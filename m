Received: from eggs.gnu.org ([2001:4830:134:3::10]:58477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4445-0005qP-Rq
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4440-0000vB-7H
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e443z-0000uB-VJ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:00:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 401D3C04AC67
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 12:00:06 +0000 (UTC)
Date: Mon, 16 Oct 2017 12:59:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171016115957.GC2252@work-vm>
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004103933.7898-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Add basic migration precopy test
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

1) I think I agree with the bits about needing to share this code with
postcopy; lets see how it goes.
2) I do have a bug I can reproduce in the postcopy test where it fails
under heavy load (e.g. ~10 TCG'd guests on one CPU) - not investigated
in detail yet, but watch out.

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
> +    /* 100 ms */
> +    migrate_set_parameter(from, "downtime-limit", "100");
> +    /* 1MB/s slow*/
> +    migrate_set_parameter(from, "max-bandwidth", "100000000");
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    migrate(from, uri);
> +
> +    wait_for_migration_pass(from);
> +
> +    /* 1GB/s now it should converge */
> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");

why is 1GB/s enough for it to converge? I'd add another 0 and
make the downtime larger as well.

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
> +static void test_precopy_unix(void)
> +{
> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +
> +    test_precopy(uri);
> +    g_free(uri);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    char template[] = "/tmp/migration-test-XXXXXX";
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    tmpfs = mkdtemp(template);
> +    if (!tmpfs) {
> +        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
> +    }
> +    g_assert(tmpfs);

We've started using g_dir_make_tmp recently; it's certianly simpler.

Dave

> +    module_call_init(MODULE_INIT_QOM);
> +
> +    qtest_add_func("/migration/precopy/unix", test_precopy_unix);
> +
> +    ret = g_test_run();
> +
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    ret = rmdir(tmpfs);
> +    if (ret != 0) {
> +        g_test_message("unable to rmdir: path (%s): %s\n",
> +                       tmpfs, strerror(errno));
> +    }
> +
> +    return ret;
> +}
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
