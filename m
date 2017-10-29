Received: from eggs.gnu.org ([2001:4830:134:3::10]:36123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8izc-0000nO-R8
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 04:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8izX-0005Z1-Th
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 04:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e8izX-0005YF-OE
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 04:30:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDDA681DFF
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 08:30:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171027034713.GA13631@work-vm> (David Alan Gilbert's message of
	"Fri, 27 Oct 2017 04:47:14 +0100")
References: <20171026075222.27798-1-quintela@redhat.com>
	<20171026075222.27798-6-quintela@redhat.com>
	<20171027034713.GA13631@work-vm>
Reply-To: quintela@redhat.com
Date: Sun, 29 Oct 2017 09:30:44 +0100
Message-ID: <87ineycq4r.fsf@secure.laptop>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
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
>
> I wonder if that will hit any FP representation problems for some
> values?

This is a deprecated function, so .....

Thanks, Juan.
