Received: from eggs.gnu.org ([2001:4830:134:3::10]:47805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e47VO-0006r6-6H
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e47VL-0002uH-2Z
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:40:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e47VK-0002u3-PS
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:40:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B80D3234C9A
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 15:40:33 +0000 (UTC)
Date: Mon, 16 Oct 2017 16:40:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171016154000.GE2252@work-vm>
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004103933.7898-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: Add precopy test using
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 8ef2b72459..8549e4c2c6 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -422,6 +422,76 @@ static void migrate_set_parameter(QTestState *who, const char *parameter,
>      QDECREF(rsp);
>  }
>  
> +static void migrate_set_downtime(QTestState *who, const char *value)
> +{
> +    QDict *rsp;
> +    gchar *cmd;
> +
> +    cmd = g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
> +                          "'arguments': { 'value': %s } }", value);
> +    rsp = qtest_qmp(who, cmd);
> +    g_free(cmd);
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +}
> +
> +static void migrate_set_speed(QTestState *who, const char *value)
> +{
> +    QDict *rsp;
> +    gchar *cmd;
> +
> +    cmd = g_strdup_printf("{ 'execute': 'migrate_set_speed',"
> +                          "'arguments': { 'value': %s } }", value);
> +    rsp = qtest_qmp(who, cmd);
> +    g_free(cmd);
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +}
> +
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
> +    migrate_set_downtime(from, "100");
> +    /* 1MB/s slow*/
> +    migrate_set_speed(from, "100000000");

Can't we share more/most of this function?
For example, how about we have a migrate_set_speed(who,value, old)
tht is :
  if (old) {
      migrate_set_speed...
  } else {
      migrate_set_parameter
  }

then test_precopy(const char *uri, bool old)

and we've duped most of it?

Dave

> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    migrate(from, uri);
> +
> +    wait_for_migration_pass(from);
> +
> +    /* 1GB/s now it should converge */
> +    migrate_set_speed(from, "1000000000");
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
> +}
> +
> +static void test_deprecated_unix(void)
> +{
> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +
> +    test_precopy_deprecated(uri);
> +    g_free(uri);
> +}
> +
>  static void test_precopy(const char *uri)
>  {
>      QTestState *from, *to;
> @@ -490,6 +560,7 @@ int main(int argc, char **argv)
>  
>      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
>      qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
> +    qtest_add_func("/migration/deprecated/unix", test_deprecated_unix);
>  
>      ret = g_test_run();
>  
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
