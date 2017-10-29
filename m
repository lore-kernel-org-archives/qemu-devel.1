Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e8o52-0007Is-Dj
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e8o4y-00048E-Fi
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e8o4y-00047g-6K
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:56:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C01C164054
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:56:42 +0000 (UTC)
Date: Sun, 29 Oct 2017 14:56:39 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171029135639.GB9859@pxdev.xzpeter.org>
References: <20171026075222.27798-1-quintela@redhat.com>
	<20171026075222.27798-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171026075222.27798-7-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/10] tests: Add migration precopy test
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

On Thu, Oct 26, 2017 at 09:52:18AM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

I am not sure whether some numbers below are the best, but I believe
it should pass your smoke test at least, and I really want to have
some migration unit tests there in master sonner or later (even, I
would be happy if I can run them if I need to post another postcopy
recovery series :-).

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

> ---
>  tests/migration-test.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index be598d3257..a8718770c9 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -401,6 +401,22 @@ static void migrate_set_speed(QTestState *who, const char *value)
>      migrate_check_parameter(who, "max-bandwidth", value);
>  }
>  
> +static void migrate_set_parameter(QTestState *who, const char *parameter,
> +                                  const char *value)
> +{
> +    QDict *rsp;
> +    gchar *cmd;
> +
> +    cmd = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
> +                          "'arguments': { '%s': %s } }",
> +                          parameter, value);
> +    rsp = qtest_qmp(who, cmd);
> +    g_free(cmd);
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +    migrate_check_parameter(who, parameter, value);
> +}
> +
>  static void migrate_set_capability(QTestState *who, const char *capability,
>                                     const char *value)
>  {
> @@ -514,7 +530,7 @@ static void test_migrate_end(QTestState *from, QTestState *to)
>      cleanup("dest_serial");
>  }
>  
> -static void test_migrate(void)
> +static void test_postcopy(void)
>  {
>      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
> @@ -557,6 +573,53 @@ static void test_migrate(void)
>      test_migrate_end(from, to);
>  }
>  
> +
> +static void test_precopy(const char *uri)
> +{
> +    QTestState *from, *to;
> +
> +    test_migrate_start(&from, &to, uri);
> +
> +    /* We want to pick a speed slow enough that the test completes
> +     * quickly, but that it doesn't complete precopy even on a slow
> +     * machine, so also set the downtime.
> +     */
> +    /* 1 ms */
> +    migrate_set_parameter(from, "downtime-limit", "1");
> +    /* 1GB/s slow*/
> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");
> +
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    migrate(from, uri);
> +
> +    wait_for_migration_pass(from);
> +
> +    /* 1GB/s now it should converge */
> +    migrate_set_parameter(from, "downtime-limit", "300");
> +
> +    if (!got_stop) {
> +        qtest_qmp_eventwait(from, "STOP");
> +    }
> +
> +    qtest_qmp_eventwait(to, "RESUME");
> +
> +    wait_for_serial("dest_serial");
> +    wait_for_migration_complete(from);
> +
> +    test_migrate_end(from, to);
> +}
> +
> +static void test_precopy_unix(void)
> +{
> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +
> +    test_precopy(uri);
> +    g_free(uri);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -576,7 +639,8 @@ int main(int argc, char **argv)
>  
>      module_call_init(MODULE_INIT_QOM);
>  
> -    qtest_add_func("/migration/postcopy/unix", test_migrate);
> +    qtest_add_func("/migration/precopy/unix", test_precopy_unix);
> +    qtest_add_func("/migration/postcopy/unix", test_postcopy);
>  
>      ret = g_test_run();
>  
> -- 
> 2.13.6
> 

-- 
Peter Xu
