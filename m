Received: from eggs.gnu.org ([2001:4830:134:3::10]:51757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4Tmf-0000b4-1t
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4Tmd-0000jq-81
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e4Tmc-0000jU-Vc
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8C6481E0D
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 15:27:53 +0000 (UTC)
Date: Tue, 17 Oct 2017 16:27:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171017152746.GE2326@work-vm>
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004104636.7963-13-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 12/12] migration: Add multifd test
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

<snip>
We *must* find a way to share all the boiler plate I've snipped
out;  even this test_migrate function is almost identical to
your other test series with just those few extra parameter sets.

> +static void test_migrate(void)
> +{
> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +    QTestState *global = global_qtest, *from, *to;
> +    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
> +    gchar *cmd, *cmd_src, *cmd_dst;
> +    QDict *rsp;
> +
> +    char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
> +    const char *arch = qtest_get_arch();
> +
> +    got_stop = false;
> +
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        init_bootfile_x86(bootpath);
> +        cmd_src = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
> +                                  " -name pcsource,debug-threads=on"
> +                                  " -serial file:%s/src_serial"
> +                                  " -drive file=%s,format=raw",
> +                                  tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
> +                                  " -name pcdest,debug-threads=on"
> +                                  " -serial file:%s/dest_serial"
> +                                  " -drive file=%s,format=raw"
> +                                  " -incoming %s",
> +                                  tmpfs, bootpath, uri);
> +    } else if (strcmp(arch, "ppc64") == 0) {
> +        const char *accel;
> +
> +        /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
> +        accel = access("/sys/module/kvm_hv", F_OK) ? "tcg" : "kvm:tcg";
> +        init_bootfile_ppc(bootpath);
> +        cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
> +                                  " -name pcsource,debug-threads=on"
> +                                  " -serial file:%s/src_serial"
> +                                  " -drive file=%s,if=pflash,format=raw",
> +                                  accel, tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
> +                                  " -name pcdest,debug-threads=on"
> +                                  " -serial file:%s/dest_serial"
> +                                  " -incoming %s",
> +                                  accel, tmpfs, uri);
> +    } else {
> +        g_assert_not_reached();
> +    }
> +
> +    g_free(bootpath);
> +
> +    from = qtest_start(cmd_src);
> +    g_free(cmd_src);
> +
> +    to = qtest_init(cmd_dst);
> +    g_free(cmd_dst);
> +
> +    global_qtest = from;
> +    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
> +                  "'arguments': { "
> +                      "'capabilities': [ {"
> +                          "'capability': 'x-multifd',"
> +                          "'state': true } ] } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +    global_qtest = to;
> +    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
> +                  "'arguments': { "
> +                      "'capabilities': [ {"
> +                          "'capability': 'x-multifd',"
> +                          "'state': true } ] } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +    /* We want to pick a speed slow enough that the test completes
> +     * quickly, but that it doesn't complete precopy even on a slow
> +     * machine, so also set the downtime.
> +     */
> +    global_qtest = from;
> +    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
> +              "'arguments': { 'max-bandwidth': 100000000 } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +    /* 200ms downtime */
> +    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
> +              "'arguments': { 'downtime-limit': 300 } }");

Note 200 vs 300 !

> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +    /* set 4 channels */
> +    global_qtest = to;
> +    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
> +              "'arguments': { 'x-multifd-channels': 4 } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
> +              "'arguments': { 'x-multifd-page-count': 64 } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +    /* set 4 channels */
> +    global_qtest = from;
> +    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
> +              "'arguments': { 'x-multifd-channels': 4 } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
> +              "'arguments': { 'x-multifd-page-count': 64 } }");
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    cmd = g_strdup_printf("{ 'execute': 'migrate',"
> +                          "'arguments': { 'uri': '%s' } }",
> +                          uri);
> +    rsp = qmp(cmd);
> +    g_free(cmd);
> +    g_assert(qdict_haskey(rsp, "return"));
> +    QDECREF(rsp);
> +
> +    wait_for_migration_pass();
> +
> +    if (!got_stop) {
> +        qmp_eventwait("STOP");
> +    }
> +
> +    global_qtest = to;
> +    qmp_eventwait("RESUME");
> +
> +    wait_for_serial("dest_serial");
> +    global_qtest = from;
> +    wait_for_migration_complete();
> +
> +    qtest_quit(from);
> +
> +    global_qtest = to;
> +
> +    qtest_memread(to, start_address, &dest_byte_a, 1);
> +
> +    /* Destination still running, wait for a byte to change */
> +    do {
> +        qtest_memread(to, start_address, &dest_byte_b, 1);
> +        usleep(10 * 1000);
> +    } while (dest_byte_a == dest_byte_b);

Are there any multifd stats we can check?  I guess the migration
wont start until all channels are connected, so we know they're all
in use in theory, so there's nothing specific.

Dave

> +    qmp_discard_response("{ 'execute' : 'stop'}");
> +    /* With it stopped, check nothing changes */
> +    qtest_memread(to, start_address, &dest_byte_c, 1);
> +    sleep(1);
> +    qtest_memread(to, start_address, &dest_byte_d, 1);
> +    g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
> +
> +    check_guests_ram();
> +
> +    qtest_quit(to);
> +    g_free(uri);
> +
> +    global_qtest = global;
> +
> +    cleanup("bootsect");
> +    cleanup("migsocket");
> +    cleanup("src_serial");
> +    cleanup("dest_serial");
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    char template[] = "/tmp/multifd-test-XXXXXX";
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    tmpfs = mkdtemp(template);
> +    if (!tmpfs) {
> +        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
> +    }
> +    g_assert(tmpfs);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    qtest_add_func("/multifd", test_migrate);
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
