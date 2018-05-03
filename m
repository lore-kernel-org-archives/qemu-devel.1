Received: from eggs.gnu.org ([2001:4830:134:3::10]:60010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEI5T-0007zN-G0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fEI5Q-0002Pd-7n
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:32:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fEI5Q-0002PO-2X
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:32:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D254EC000
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 17:32:04 +0000 (UTC)
Date: Thu, 3 May 2018 18:31:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180503173154.GL2660@work-vm>
References: <20180425111940.1030-1-quintela@redhat.com>
	<20180425111940.1030-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425111940.1030-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/8] tests: Add migration xbzrle test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/migration-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 834cdf50f2..fd885ba909 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -512,6 +512,20 @@ static void deprecated_set_speed(QTestState *who, const char *value)
>      migrate_check_parameter(who, "max-bandwidth", value);
>  }
>  
> +static void deprecated_set_cache_size(QTestState *who, const char *value)
> +{
> +    QDict *rsp;
> +    gchar *cmd;
> +
> +    cmd = g_strdup_printf("{ 'execute': 'migrate-set-cache-size',"
> +                          "'arguments': { 'value': %s } }", value);
> +    rsp = qtest_qmp(who, cmd);
> +    g_free(cmd);
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +    migrate_check_parameter(who, "xbzrle-cache-size", value);
> +}
> +
>  static void test_deprecated(void)
>  {
>      QTestState *from;
> @@ -520,6 +534,7 @@ static void test_deprecated(void)
>  
>      deprecated_set_downtime(from, 0.12345);
>      deprecated_set_speed(from, "12345");
> +    deprecated_set_cache_size(from, "4096");
>  
>      qtest_quit(from);
>  }
> @@ -634,6 +649,54 @@ static void test_precopy_unix(void)
>      g_free(uri);
>  }
>  
> +static void test_xbzrle(const char *uri)
> +{
> +    QTestState *from, *to;
> +
> +    test_migrate_start(&from, &to, uri, false);
> +
> +    /* We want to pick a speed slow enough that the test completes
> +     * quickly, but that it doesn't complete precopy even on a slow
> +     * machine, so also set the downtime.
> +     */
> +    /* 1 ms should make it not converge*/
> +    migrate_set_parameter(from, "downtime-limit", "1");
> +    /* 1GB/s */
> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");
> +
> +    migrate_set_parameter(from, "xbzrle-cache-size", "33554432");

I still worry about the cache size relative to the size of memory we're
actually changing in the test; I don't quite understand why it's turning
out to get lots of hits.

Also, xbzrle eats so much CPU we'll still have to watch out for the low
end CPUs.

Dave

> +    migrate_set_capability(from, "xbzrle", "true");
> +    migrate_set_capability(to, "xbzrle", "true");
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    migrate(from, uri);
> +
> +    wait_for_migration_pass(from);
> +
> +    /* 300ms should converge */
> +    migrate_set_parameter(from, "downtime-limit", "300");
> +
> +    if (!got_stop) {
> +        qtest_qmp_eventwait(from, "STOP");
> +    }
> +    qtest_qmp_eventwait(to, "RESUME");
> +
> +    wait_for_serial("dest_serial");
> +    wait_for_migration_complete(from);
> +
> +    test_migrate_end(from, to, true);
> +}
> +
> +static void test_xbzrle_unix(void)
> +{
> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +
> +    test_xbzrle(uri);
> +    g_free(uri);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -657,6 +720,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/deprecated", test_deprecated);
>      qtest_add_func("/migration/bad_dest", test_baddest);
>      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
> +    qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
>  
>      ret = g_test_run();
>  
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
