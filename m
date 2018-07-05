Received: from eggs.gnu.org ([2001:4830:134:3::10]:42846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3yt-00084e-SV
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3yn-00060J-KJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:07:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fb3yn-0005z5-EG
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:07:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19C92407CCD8
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:07:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180705102339.GH2538@work-vm> (David Alan Gilbert's message of
	"Thu, 5 Jul 2018 11:23:39 +0100")
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-7-peterx@redhat.com>
	<20180705102339.GH2538@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 05 Jul 2018 15:07:17 +0200
Message-ID: <87d0w125mi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 6/9] tests: introduce
 migrate_query*() helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Peter Xu (peterx@redhat.com) wrote:
>> Introduce helpers to query migration states and use it.
>> 
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  tests/migration-test.c | 64 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 43 insertions(+), 21 deletions(-)
>> 
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index af82a04789..1d85ccbef1 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -168,6 +168,37 @@ static QDict *wait_command(QTestState *who, const char *command)
>>      return response;
>>  }
>>  
>> +/*
>> + * Note: caller is responsible to free the returned object via
>> + * qobject_unref() after use
>> + */
>> +static QDict *migrate_query(QTestState *who)
>> +{
>> +    QDict *rsp, *rsp_return;
>> +
>> +    rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
>
> having a 'migrate_query' function that issues 'query-migrate' is a bit
> odd; I think I'd have called it query_migrate just to match; however
> that's just a nit-pick:

I guess he is trying to get almost everything to be migrate_<foo>.

Not that the whole file is consistent at all, but well.


>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> +    rsp_return = qdict_get_qdict(rsp, "return");
>> +    g_assert(rsp_return);
>> +    qobject_ref(rsp_return);
>> +    qobject_unref(rsp);
>> +
>> +    return rsp_return;
>> +}
>> +
>> +/*
>> + * Note: caller is responsible to free the returned object via
>> + * g_free() after use
>> + */
>> +static gchar *migrate_query_status(QTestState *who)
>> +{
>> +    QDict *rsp_return = migrate_query(who);
>> +    gchar *status = g_strdup(qdict_get_str(rsp_return, "status"));
>> +
>> +    g_assert(status);
>> +    qobject_unref(rsp_return);
>> +
>> +    return status;
>> +}
>>  
>>  /*
>>   * It's tricky to use qemu's migration event capability with qtest,
>> @@ -176,11 +207,10 @@ static QDict *wait_command(QTestState *who, const char *command)
>>  
>>  static uint64_t get_migration_pass(QTestState *who)
>>  {
>> -    QDict *rsp, *rsp_return, *rsp_ram;
>> +    QDict *rsp_return, *rsp_ram;
>>      uint64_t result;
>>  
>> -    rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
>> -    rsp_return = qdict_get_qdict(rsp, "return");
>> +    rsp_return = migrate_query(who);
>>      if (!qdict_haskey(rsp_return, "ram")) {
>>          /* Still in setup */
>>          result = 0;
>> @@ -188,33 +218,29 @@ static uint64_t get_migration_pass(QTestState *who)
>>          rsp_ram = qdict_get_qdict(rsp_return, "ram");
>>          result = qdict_get_try_int(rsp_ram, "dirty-sync-count", 0);
>>      }
>> -    qobject_unref(rsp);
>> +    qobject_unref(rsp_return);
>>      return result;
>>  }
>>  
>>  static void read_blocktime(QTestState *who)
>>  {
>> -    QDict *rsp, *rsp_return;
>> +    QDict *rsp_return;
>>  
>> -    rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
>> -    rsp_return = qdict_get_qdict(rsp, "return");
>> +    rsp_return = migrate_query(who);
>>      g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
>> -    qobject_unref(rsp);
>> +    qobject_unref(rsp_return);
>>  }
>>  
>>  static void wait_for_migration_complete(QTestState *who)
>>  {
>>      while (true) {
>> -        QDict *rsp, *rsp_return;
>>          bool completed;
>> -        const char *status;
>> +        char *status;
>>  
>> -        rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
>> -        rsp_return = qdict_get_qdict(rsp, "return");
>> -        status = qdict_get_str(rsp_return, "status");
>> +        status = migrate_query_status(who);
>>          completed = strcmp(status, "completed") == 0;
>>          g_assert_cmpstr(status, !=,  "failed");
>> -        qobject_unref(rsp);
>> +        g_free(status);
>>          if (completed) {
>>              return;
>>          }
>> @@ -569,20 +595,16 @@ static void test_baddest(void)
>>  {
>>      QTestState *from, *to;
>>      QDict *rsp, *rsp_return;
>> -    const char *status;
>> +    char *status;
>>      bool failed;
>>  
>>      test_migrate_start(&from, &to, "tcp:0:0", true);
>>      migrate(from, "tcp:0:0", NULL);
>>      do {
>> -        rsp = wait_command(from, "{ 'execute': 'query-migrate' }");
>> -        rsp_return = qdict_get_qdict(rsp, "return");
>> -
>> -        status = qdict_get_str(rsp_return, "status");
>> -
>> +        status = migrate_query_status(from);
>>          g_assert(!strcmp(status, "setup") || !(strcmp(status, "failed")));
>>          failed = !strcmp(status, "failed");
>> -        qobject_unref(rsp);
>> +        g_free(status);
>>      } while (!failed);
>>  
>>      /* Is the machine currently running? */
>> -- 
>> 2.17.1
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
