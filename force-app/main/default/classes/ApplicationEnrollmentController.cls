public with sharing class ApplicationEnrollmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<TREX1__Course_Option_Enrollment__c> getApplications(
        String recordId
    ){
        List<TREX1__Course_Option_Enrollment__c> lstCoes = new List<TREX1__Course_Option_Enrollment__c>();
        try {
            lstCoes = [
                SELECT Id, 
                       Name, 
                       Application_Status__c, 
                       CreatedDate, 
                       TREX1__Registration__c, 
                       TREX1__Contact__c, 
                       TREX1__Contact__r.FirstName, 
                       TREX1__Contact__r.LastName, 
                       TREX1__Contact__r.TREX1__Age__c, 
                       TREX1__Transaction__r.TREX1__Contact__c, 
                       TREX1__Transaction__r.TREX1__Contact__r.FirstName, 
                       TREX1__Transaction__r.TREX1__Contact__r.LastName, 
                       TREX1__Transaction__r.TREX1__Contact__r.Email, 
                       TREX1__Transaction__r.TREX1__Contact__r.Phone 
                  FROM TREX1__Course_Option_Enrollment__c 
                 WHERE TREX1__Course_Option__c = :recordId 
                   AND Application_Status__c != null 
                  WITH SECURITY_ENFORCED 
                 ORDER BY CreatedDate ASC 
                 LIMIT 200 
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return lstCoes;
    }

    @AuraEnabled(cacheable=true)
    public static List<TREX1__Answered_Question__c> getAnsweredQuestions(
        String recordId
    ){
        List<TREX1__Answered_Question__c> lstAqs = new List<TREX1__Answered_Question__c>();
        try {
            lstAqs = [
                SELECT Id, 
                       Name, 
                       TREX1__Answer__c, 
                       TREX1__Question__c
                  FROM TREX1__Answered_Question__c
                 WHERE TREX1__Registration__c = :recordId
                  WITH SECURITY_ENFORCED
                 ORDER BY CreatedDate ASC
                 LIMIT 200
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return lstAqs;
    }

}
