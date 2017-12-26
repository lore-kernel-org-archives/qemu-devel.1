Received: from eggs.gnu.org ([2001:4830:134:3::10]:33402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eTvM3-0006QD-D8
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 14:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eTvM0-00030a-36
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 14:57:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eTvLz-000302-Qe
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 14:57:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F34327EA85
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 19:57:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171208110148.GH2403@work-vm> (David Alan Gilbert's message of
	"Fri, 8 Dec 2017 11:01:49 +0000")
References: <20171201125813.1437-1-quintela@redhat.com>
	<20171201125813.1437-4-quintela@redhat.com>
	<20171208110148.GH2403@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 26 Dec 2017 20:57:30 +0100
Message-ID: <87vagtntxx.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/6] tests: Add migration precopy test
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
>
> OK, although you seem to have chosen a bandwidth 10x what I use
> in the postcopy test but for the same reason.

I tried to make it as fast as possible while making sure that we wait
enough time.   In my home machine each test takes around 2-3 seconds,
and I want to add tests, so better that they are fast.

Later, Juan.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks, Juan.


>
>> ---
>>  tests/migration-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 42 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index 51f49c74e9..3f3f056be6 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -539,7 +539,7 @@ static void test_migrate_end(QTestState *from, QTestState *to)
>>      cleanup("dest_serial");
>>  }
>>  
>> -static void test_migrate(void)
>> +static void test_postcopy(void)
>>  {
>>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>>      QTestState *from, *to;
>> @@ -582,6 +582,45 @@ static void test_migrate(void)
>>      test_migrate_end(from, to);
>>  }
>>  
>> +static void test_precopy_unix(void)
>> +{
>> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>> +    QTestState *from, *to;
>> +
>> +    test_migrate_start(&from, &to, uri);
>> +
>> +    /* We want to pick a speed slow enough that the test completes
>> +     * quickly, but that it doesn't complete precopy even on a slow
>> +     * machine, so also set the downtime.
>> +     */
>> +    /* 1 ms */
>> +    migrate_set_parameter(from, "downtime-limit", "1");
>> +    /* 1GB/s slow*/
>> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");
>> +
>> +    /* Wait for the first serial output from the source */
>> +    wait_for_serial("src_serial");
>> +
>> +    migrate(from, uri);
>> +
>> +    wait_for_migration_pass(from);
>> +
>> +    /* 300 ms should converge */
>> +    migrate_set_parameter(from, "downtime-limit", "300");
>> +
>> +    if (!got_stop) {
>> +        qtest_qmp_eventwait(from, "STOP");
>> +    }
>> +
>> +    qtest_qmp_eventwait(to, "RESUME");
>> +
>> +    wait_for_serial("dest_serial");
>> +    wait_for_migration_complete(from);
>> +
>> +    test_migrate_end(from, to);
>> +    g_free(uri);
>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>      char template[] = "/tmp/migration-test-XXXXXX";
>> @@ -601,7 +640,8 @@ int main(int argc, char **argv)
>>  
>>      module_call_init(MODULE_INIT_QOM);
>>  
>> -    qtest_add_func("/migration/postcopy/unix", test_migrate);
>> +    qtest_add_func("/migration/precopy/unix", test_precopy_unix);
>> +    qtest_add_func("/migration/postcopy/unix", test_postcopy);
>>  
>>      ret = g_test_run();
>>  
>> -- 
>> 2.14.3
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
