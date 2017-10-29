Received: from eggs.gnu.org ([2001:4830:134:3::10]:50280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e8npm-0004vB-7r
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e8nph-0003BP-8d
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:41:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e8npg-0003B3-Vt
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:40:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C23B8C03BD52
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:40:54 +0000 (UTC)
Date: Sun, 29 Oct 2017 14:40:51 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171029134051.GA9859@pxdev.xzpeter.org>
References: <20171026075222.27798-1-quintela@redhat.com>
	<20171026075222.27798-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171026075222.27798-9-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/10] tests: Add precopy test using
 deprecated commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Thu, Oct 26, 2017 at 09:52:20AM +0200, Juan Quintela wrote:
> Once there, make postcopy test to use the new commands now that we
> have other test for deprecated ones
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 338254bafe..b72dff3917 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -545,8 +545,8 @@ static void test_postcopy(void)
>       * quickly, but that it doesn't complete precopy even on a slow
>       * machine, so also set the downtime.
>       */
> -    migrate_set_speed(from, "100000000");
> -    migrate_set_downtime(from, 0.001);
> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");
> +    migrate_set_parameter(from, "downtime-limit", "1");
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> @@ -573,6 +573,49 @@ static void test_postcopy(void)
>      test_migrate_end(from, to);
>  }
>  
> +static void test_precopy_deprecated(const char *uri)
> +{
> +    QTestState *from, *to;
> +
> +    test_migrate_start(&from, &to, uri);
> +
> +    /* We want to pick a speed slow enough that the test completes
> +     * quickly, but that it doesn't complete precopy even on a slow
> +     * machine, so also set the downtime.
> +     */
> +    /* 100 ms */
> +    migrate_set_downtime(from, 0.001);
> +    /* 1MB/s slow*/
> +    migrate_set_speed(from, "1000000000");
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    migrate(from, uri);
> +
> +    wait_for_migration_pass(from);
> +
> +    /* 300ms it should converge */
> +    migrate_set_downtime(from, 0.3);
> +
> +    if (!got_stop) {
> +        qtest_qmp_eventwait(from, "STOP");
> +    }
> +    qtest_qmp_eventwait(to, "RESUME");
> +
> +    wait_for_serial("dest_serial");
> +    wait_for_migration_complete(from);
> +
> +    test_migrate_end(from, to);

Again, instead of doing real migration to test deprecated commands,
how about just set/check them one by one?  After all we have
migrate_check_parameter() now, which seems even easier than before.

Thanks,

> +}
> +
> +static void test_deprecated_unix(void)
> +{
> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +
> +    test_precopy_deprecated(uri);
> +    g_free(uri);
> +}
>  
>  static void test_precopy(const char *uri)
>  {
> @@ -648,6 +691,7 @@ int main(int argc, char **argv)
>  
>      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
>      qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
> +    qtest_add_func("/migration/deprecated/unix", test_deprecated_unix);
>      qtest_add_func("/migration/postcopy/unix", test_postcopy);
>  
>      ret = g_test_run();
> -- 
> 2.13.6
> 

-- 
Peter Xu
