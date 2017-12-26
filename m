Received: from eggs.gnu.org ([2001:4830:134:3::10]:41732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eTvVN-000162-Ew
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 15:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eTvVJ-00042p-V3
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 15:07:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eTvVJ-000425-MJ
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 15:07:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC104C057FAD
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 20:07:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171208114601.GK2403@work-vm> (David Alan Gilbert's message of
	"Fri, 8 Dec 2017 11:46:01 +0000")
References: <20171201125813.1437-1-quintela@redhat.com>
	<20171201125813.1437-7-quintela@redhat.com>
	<20171208114601.GK2403@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 26 Dec 2017 21:07:07 +0100
Message-ID: <87mv25nthw.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 6/6] [RFH] tests: Add migration compress
 threads tests
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
>> Yeap, it is still not working. trying to learn how to debug threads
>> for guests running from the testt hardness.
>> 
>> For some reason, compression is not working at the moment, test is
>> disabled until I found why.
>
> How does it fail?

Source and destination hang.  Running exactly the same commands without
the test harnness work as expected.

attaching gdb show that every thread is waiting, but haven't found
anything obvious.  Happens in both sides, so I am not sure really which
one is not working (or if both are broken).

Later, Juan.


>
> Dave
>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/migration-test.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>> 
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index 41dee78a9a..eab3b146a4 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -739,6 +739,54 @@ static void test_xbzrle_unix(void)
>>      g_free(uri);
>>  }
>>  
>> +static void test_compress(const char *uri)
>> +{
>> +    QTestState *from, *to;
>> +
>> +    test_migrate_start(&from, &to, uri);
>> +
>> +    /* We want to pick a speed slow enough that the test completes
>> +     * quickly, but that it doesn't complete precopy even on a slow
>> +     * machine, so also set the downtime.
>> +     */
>> +    /* 100 ms */
>> +    migrate_set_parameter(from, "downtime-limit", "1");
>> +    /* 1MB/s slow*/
>> +    migrate_set_parameter(from, "max-bandwidth", "100000000");
>> +
>> +    migrate_set_parameter(from, "compress-threads", "4");
>> +    migrate_set_parameter(to, "decompress-threads", "3");
>> +
>> +    migrate_set_capability(from, "compress", "true");
>> +    migrate_set_capability(to, "compress", "true");
>> +    /* Wait for the first serial output from the source */
>> +    wait_for_serial("src_serial");
>> +
>> +    migrate(from, uri);
>> +
>> +    wait_for_migration_pass(from);
>> +
>> +    /* 300ms it should converge */
>> +    migrate_set_parameter(from, "downtime-limit", "300");
>> +
>> +    if (!got_stop) {
>> +        qtest_qmp_eventwait(from, "STOP");
>> +    }
>> +    qtest_qmp_eventwait(to, "RESUME");
>> +
>> +    wait_for_serial("dest_serial");
>> +    wait_for_migration_complete(from);
>> +
>> +    test_migrate_end(from, to);
>> +}
>> +
>> +static void test_compress_unix(void)
>> +{
>> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>> +
>> +    test_compress(uri);
>> +    g_free(uri);
>> +}
>>  
>>  int main(int argc, char **argv)
>>  {
>> @@ -763,6 +811,9 @@ int main(int argc, char **argv)
>>      qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
>>      qtest_add_func("/migration/postcopy/unix", test_postcopy);
>>      qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
>> +    if (0) {
>> +        qtest_add_func("/migration/compress/unix", test_compress_unix);
>> +    }
>>  
>>      ret = g_test_run();
>>  
>> -- 
>> 2.14.3
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
