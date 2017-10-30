Received: from eggs.gnu.org ([2001:4830:134:3::10]:54826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e9A7I-00088D-LE
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e9A7E-0002f4-L0
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e9A7E-0002em-CU
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:28:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A25794ACAC
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 13:28:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171029132453.GA4227@pxdev.xzpeter.org> (Peter Xu's message of
	"Sun, 29 Oct 2017 14:24:53 +0100")
References: <20171026075222.27798-1-quintela@redhat.com>
	<20171026075222.27798-6-quintela@redhat.com>
	<20171029132453.GA4227@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Mon, 30 Oct 2017 14:28:27 +0100
Message-ID: <87y3nsbw90.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 05/10] tests: check that migration
 parameters are really assigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Oct 26, 2017 at 09:52:17AM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/migration-test.c | 27 ++++++++++++++++++++++++---
>>  1 file changed, 24 insertions(+), 3 deletions(-)
>> 
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index c429a13403..be598d3257 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -354,17 +354,37 @@ static void cleanup(const char *filename)
>>      g_free(path);
>>  }
>>  
>> -static void migrate_set_downtime(QTestState *who, const char *value)
>> +static void migrate_check_parameter(QTestState *who, const char *parameter,
>> +                                    const char *value)
>> +{
>> +    QDict *rsp, *rsp_return;
>> +    const char *result;
>> +
>> +    rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
>> +    rsp_return = qdict_get_qdict(rsp, "return");
>> +    result = g_strdup_printf("%" PRId64,
>> +                             qdict_get_try_int(rsp_return,  parameter, -1));
>> +    g_assert_cmpstr(result, ==, value);
>> +    QDECREF(rsp);
>
> Maybe we need to free "result" as well?  I see a pull request already,
> so maybe another fix patch on top.  Thanks,

Done, thanks.

>
>> +}
>> +
>> +static void migrate_set_downtime(QTestState *who, const double value)
>>  {
>>      QDict *rsp;
>>      gchar *cmd;
>> +    char *expected;
>> +    int64_t result_int;
>>  
>>      cmd = g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
>> -                          "'arguments': { 'value': %s } }", value);
>> +                          "'arguments': { 'value': %g } }", value);
>>      rsp = qtest_qmp(who, cmd);
>>      g_free(cmd);
>>      g_assert(qdict_haskey(rsp, "return"));
>>      QDECREF(rsp);
>> +    result_int = value * 1000L;
>> +    expected = g_strdup_printf("%" PRId64, result_int);
>> +    migrate_check_parameter(who, "downtime-limit", expected);
>> +    g_free(expected);
>>  }
>>  
>>  static void migrate_set_speed(QTestState *who, const char *value)
>> @@ -378,6 +398,7 @@ static void migrate_set_speed(QTestState *who, const char *value)
>>      g_free(cmd);
>>      g_assert(qdict_haskey(rsp, "return"));
>>      QDECREF(rsp);
>> +    migrate_check_parameter(who, "max-bandwidth", value);
>>  }
>>  
>>  static void migrate_set_capability(QTestState *who, const char *capability,
>> @@ -509,7 +530,7 @@ static void test_migrate(void)
>>       * machine, so also set the downtime.
>>       */
>>      migrate_set_speed(from, "100000000");
>> -    migrate_set_downtime(from, "0.001");
>> +    migrate_set_downtime(from, 0.001);
>>  
>>      /* Wait for the first serial output from the source */
>>      wait_for_serial("src_serial");
>> -- 
>> 2.13.6
>> 
