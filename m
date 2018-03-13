Received: from eggs.gnu.org ([2001:4830:134:3::10]:42074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evnBP-000765-Rt
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evnBL-0003dT-Sa
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:53:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37546 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evnBL-0003d1-Mm
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82204406802E
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 16:53:43 +0000 (UTC)
Date: Tue, 13 Mar 2018 16:53:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180313165339.GI3545@work-vm>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307110010.2205-9-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 08/24] migration: Add multifd test
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
> We set the x-multifd-page-count and x-multifd-channels.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>


This should probably go nearer the end of the series;
we've also got the problem that things are a bit delicate with TCG so
adding more migration tests probably shouldn't happen until Paolo's
TCG fixes are worked out.

Also, should we be checking for some stats to show all 4 channels were
used?

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 6f9b4c8d7a..97d35f979d 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -755,6 +755,55 @@ static void test_compress_unix(void)
>      g_free(uri);
>  }
>  
> +static void test_multifd_tcp(void)
> +{
> +    char *uri;
> +    char *port;
> +    QTestState *from, *to;
> +
> +    test_migrate_start(&from, &to, "tcp:127.0.0.1:0");
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
> +    migrate_set_parameter(from, "x-multifd-channels", "4");
> +    migrate_set_parameter(to, "x-multifd-channels", "4");
> +
> +    migrate_set_parameter(from, "x-multifd-page-count", "64");
> +    migrate_set_parameter(to, "x-multifd-page-count", "64");
> +
> +    migrate_set_capability(from, "x-multifd", "true");
> +    migrate_set_capability(to, "x-multifd", "true");
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    port = migrate_get_parameter(to, "x-tcp-port");
> +    uri = g_strdup_printf("tcp:127.0.0.1:%s", port);
> +
> +    migrate(from, uri);
> +
> +    wait_for_migration_pass(from);
> +
> +    /* 300ms it should converge */
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
>  int main(int argc, char **argv)
>  {
>      char template[] = "/tmp/migration-test-XXXXXX";
> @@ -783,6 +832,7 @@ int main(int argc, char **argv)
>      if (0) {
>          qtest_add_func("/migration/compress/unix", test_compress_unix);
>      }
> +    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
>  
>      ret = g_test_run();
>  
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
