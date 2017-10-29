Received: from eggs.gnu.org ([2001:4830:134:3::10]:35969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8iyv-0000QN-C9
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 04:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8iyq-0004lq-Dx
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 04:30:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e8iyq-0004jb-5C
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 04:30:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56FE5C0587E3
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 08:30:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171027023706.GD2585@work-vm> (David Alan Gilbert's message of
	"Fri, 27 Oct 2017 03:37:08 +0100")
References: <20171026075222.27798-1-quintela@redhat.com>
	<20171026075222.27798-5-quintela@redhat.com>
	<20171027023706.GD2585@work-vm>
Reply-To: quintela@redhat.com
Date: Sun, 29 Oct 2017 09:29:57 +0100
Message-ID: <87mv4acq62.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 04/10] tests: Don't abuse global_qtest
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
>> As we have two guests running, just pass always who we want to send a
>> message to.  Once there, refactor return_or_event() into wait_command.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Hmm was there anything else anywhere that relied on global_qtest?
> Hopefully not.

I tested making global_qtest = NULL for the whole test (and put it back
at the end), so ...

>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>  tests/migration-test.c | 55 +++++++++++++++++++++++++-------------------------
>>  1 file changed, 27 insertions(+), 28 deletions(-)
>> 
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index 91fb0277d6..c429a13403 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -223,20 +223,23 @@ static void wait_for_serial(const char *side)
>>  /*
>>   * Events can get in the way of responses we are actually waiting for.
>>   */
>> -static QDict *return_or_event(QDict *response)
>> +static QDict *wait_command(QTestState *who, const char *command)
>>  {
>>      const char *event_string;
>> -    if (!qdict_haskey(response, "event")) {
>> -        return response;
>> -    }
>> +    QDict *response;
>> +
>> +    response = qtest_qmp(who, command);
>>  
>> -    /* OK, it was an event */
>> -    event_string = qdict_get_str(response, "event");
>> -    if (!strcmp(event_string, "STOP")) {
>> -        got_stop = true;
>> +    while (qdict_haskey(response, "event")) {
>> +        /* OK, it was an event */
>> +        event_string = qdict_get_str(response, "event");
>> +        if (!strcmp(event_string, "STOP")) {
>> +            got_stop = true;
>> +        }
>> +        QDECREF(response);
>> +        response = qtest_qmp_receive(who);
>>      }
>> -    QDECREF(response);
>> -    return return_or_event(qtest_qmp_receive(global_qtest));
>> +    return response;
>>  }
>>  
>>  
>> @@ -245,12 +248,12 @@ static QDict *return_or_event(QDict *response)
>>   * events suddenly appearing confuse the qmp()/hmp() responses.
>>   */
>>  
>> -static uint64_t get_migration_pass(void)
>> +static uint64_t get_migration_pass(QTestState *who)
>>  {
>>      QDict *rsp, *rsp_return, *rsp_ram;
>>      uint64_t result;
>>  
>> -    rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
>> +    rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
>>      rsp_return = qdict_get_qdict(rsp, "return");
>>      if (!qdict_haskey(rsp_return, "ram")) {
>>          /* Still in setup */
>> @@ -263,7 +266,7 @@ static uint64_t get_migration_pass(void)
>>      return result;
>>  }
>>  
>> -static void wait_for_migration_complete(void)
>> +static void wait_for_migration_complete(QTestState *who)
>>  {
>>      QDict *rsp, *rsp_return;
>>      bool completed;
>> @@ -271,7 +274,7 @@ static void wait_for_migration_complete(void)
>>      do {
>>          const char *status;
>>  
>> -        rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
>> +        rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
>>          rsp_return = qdict_get_qdict(rsp, "return");
>>          status = qdict_get_str(rsp_return, "status");
>>          completed = strcmp(status, "completed") == 0;
>> @@ -281,14 +284,14 @@ static void wait_for_migration_complete(void)
>>      } while (!completed);
>>  }
>>  
>> -static void wait_for_migration_pass(void)
>> +static void wait_for_migration_pass(QTestState *who)
>>  {
>> -    uint64_t initial_pass = get_migration_pass();
>> +    uint64_t initial_pass = get_migration_pass(who);
>>      uint64_t pass;
>>  
>>      /* Wait for the 1st sync */
>>      do {
>> -        initial_pass = get_migration_pass();
>> +        initial_pass = get_migration_pass(who);
>>          if (got_stop || initial_pass) {
>>              break;
>>          }
>> @@ -297,7 +300,7 @@ static void wait_for_migration_pass(void)
>>  
>>      do {
>>          usleep(1000 * 100);
>> -        pass = get_migration_pass();
>> +        pass = get_migration_pass(who);
>>      } while (pass == initial_pass && !got_stop);
>>  }
>>  
>> @@ -493,7 +496,7 @@ static void test_migrate_end(QTestState *from, QTestState *to)
>>  static void test_migrate(void)
>>  {
>>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>> -    QTestState *global = global_qtest, *from, *to;
>> +    QTestState *from, *to;
>>      QDict *rsp;
>>  
>>      test_migrate_start(&from, &to, uri);
>> @@ -513,26 +516,22 @@ static void test_migrate(void)
>>  
>>      migrate(from, uri);
>>  
>> -    global_qtest = from;
>> -    wait_for_migration_pass();
>> +    wait_for_migration_pass(from);
>>  
>> -    rsp = return_or_event(qmp("{ 'execute': 'migrate-start-postcopy' }"));
>> +    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
>>      g_assert(qdict_haskey(rsp, "return"));
>>      QDECREF(rsp);
>>  
>>      if (!got_stop) {
>> -        qmp_eventwait("STOP");
>> +        qtest_qmp_eventwait(from, "STOP");
>>      }
>>  
>> -    global_qtest = to;
>> -    qmp_eventwait("RESUME");
>> +    qtest_qmp_eventwait(to, "RESUME");
>>  
>>      wait_for_serial("dest_serial");
>> -    global_qtest = from;
>> -    wait_for_migration_complete();
>> +    wait_for_migration_complete(from);
>>  
>>      g_free(uri);
>> -    global_qtest = global;
>>  
>>      test_migrate_end(from, to);
>>  }
>> -- 
>> 2.13.6
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
