Received: from eggs.gnu.org ([2001:4830:134:3::10]:55175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCo-00059v-3s
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCl-000380-FZ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzhCl-00037c-6G
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36F068B11B
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:47:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:46:36 +0200
Message-Id: <20171004104636.7963-13-quintela@redhat.com>
In-Reply-To: <20171004104636.7963-1-quintela@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 12/12] migration: Add multifd test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We set the x-multifd-page-count and x-multifd-channels.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include |   3 +
 tests/multifd-test.c   | 511 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 514 insertions(+)
 create mode 100644 tests/multifd-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d23ca1ed1c..69e3fd143d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -289,6 +289,7 @@ check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-i386-y += tests/migration-test$(EXESUF)
 check-qtest-i386-y += tests/postcopy-test$(EXESUF)
+check-qtest-i386-y += tests/multifd-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
@@ -318,6 +319,7 @@ check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/drive_del-test$(EXESUF)
 check-qtest-ppc64-y += tests/postcopy-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
+check-qtest-ppc64-y += tests/multifd-test$(EXESUF)
 check-qtest-ppc64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
@@ -785,6 +787,7 @@ tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
 tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
 tests/postcopy-test$(EXESUF): tests/postcopy-test.o
 tests/migration-test$(EXESUF): tests/migration-test.o
+tests/multifd-test$(EXESUF): tests/multifd-test.o
 tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
 	$(chardev-obj-y)
diff --git a/tests/multifd-test.c b/tests/multifd-test.c
new file mode 100644
index 0000000000..2b90f8f7bd
--- /dev/null
+++ b/tests/multifd-test.c
@@ -0,0 +1,511 @@
+/*
+ * QTest testcase for multifd
+ *
+ * Copyright (c) 2017 Red Hat, Inc. and/or its affiliates
+ *   based on the postcopy-test.c which is based
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "qemu/option.h"
+#include "qemu/range.h"
+#include "qemu/sockets.h"
+#include "chardev/char.h"
+#include "sysemu/sysemu.h"
+#include "hw/nvram/chrp_nvram.h"
+
+#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
+
+const unsigned start_address = 1024 * 1024;
+const unsigned end_address = 100 * 1024 * 1024;
+bool got_stop;
+
+#if defined(__linux__)
+#include <sys/syscall.h>
+#include <sys/vfs.h>
+#endif
+
+static const char *tmpfs;
+
+/* A simple PC boot sector that modifies memory (1-100MB) quickly
+ * outputing a 'B' every so often if it's still running.
+ */
+unsigned char bootsect[] = {
+  0xfa, 0x0f, 0x01, 0x16, 0x74, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
+  0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
+  0xe6, 0x92, 0xb8, 0x10, 0x00, 0x00, 0x00, 0x8e, 0xd8, 0x66, 0xb8, 0x41,
+  0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xb3, 0x00, 0xb8, 0x00, 0x00, 0x10,
+  0x00, 0xfe, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40,
+  0x06, 0x7c, 0xf2, 0xfe, 0xc3, 0x75, 0xe9, 0x66, 0xb8, 0x42, 0x00, 0x66,
+  0xba, 0xf8, 0x03, 0xee, 0xeb, 0xde, 0x66, 0x90, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00,
+  0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0x5c, 0x7c,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
+};
+
+static void init_bootfile_x86(const char *bootpath)
+{
+    FILE *bootfile = fopen(bootpath, "wb");
+
+    g_assert_cmpint(fwrite(bootsect, 512, 1, bootfile), ==, 1);
+    fclose(bootfile);
+}
+
+static void init_bootfile_ppc(const char *bootpath)
+{
+    FILE *bootfile;
+    char buf[MIN_NVRAM_SIZE];
+    ChrpNvramPartHdr *header = (ChrpNvramPartHdr *)buf;
+
+    memset(buf, 0, MIN_NVRAM_SIZE);
+
+    /* Create a "common" partition in nvram to store boot-command property */
+
+    header->signature = CHRP_NVPART_SYSTEM;
+    memcpy(header->name, "common", 6);
+    chrp_nvram_finish_partition(header, MIN_NVRAM_SIZE);
+
+    /* FW_MAX_SIZE is 4MB, but slof.bin is only 900KB,
+     * so let's modify memory between 1MB and 100MB
+     * to do like PC bootsector
+     */
+
+    sprintf(buf + 16,
+            "boot-command=hex .\" _\" begin %x %x do i c@ 1 + i c! 1000 +loop "
+            ".\" B\" 0 until", end_address, start_address);
+
+    /* Write partition to the NVRAM file */
+
+    bootfile = fopen(bootpath, "wb");
+    g_assert_cmpint(fwrite(buf, MIN_NVRAM_SIZE, 1, bootfile), ==, 1);
+    fclose(bootfile);
+}
+
+/*
+ * Wait for some output in the serial output file,
+ * we get an 'A' followed by an endless string of 'B's
+ * but on the destination we won't have the A.
+ */
+static void wait_for_serial(const char *side)
+{
+    char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
+    FILE *serialfile = fopen(serialpath, "r");
+    const char *arch = qtest_get_arch();
+    int started = (strcmp(side, "src_serial") == 0 &&
+                   strcmp(arch, "ppc64") == 0) ? 0 : 1;
+
+    g_free(serialpath);
+    do {
+        int readvalue = fgetc(serialfile);
+
+        if (!started) {
+            /* SLOF prints its banner before starting test,
+             * to ignore it, mark the start of the test with '_',
+             * ignore all characters until this marker
+             */
+            switch (readvalue) {
+            case '_':
+                started = 1;
+                break;
+            case EOF:
+                fseek(serialfile, 0, SEEK_SET);
+                usleep(1000);
+                break;
+            }
+            continue;
+        }
+        switch (readvalue) {
+        case 'A':
+            /* Fine */
+            break;
+
+        case 'B':
+            /* It's alive! */
+            fclose(serialfile);
+            return;
+
+        case EOF:
+            started = (strcmp(side, "src_serial") == 0 &&
+                       strcmp(arch, "ppc64") == 0) ? 0 : 1;
+            fseek(serialfile, 0, SEEK_SET);
+            usleep(1000);
+            break;
+
+        default:
+            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
+            g_assert_not_reached();
+        }
+    } while (true);
+}
+
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+static QDict *return_or_event(QDict *response)
+{
+    const char *event_string;
+    if (!qdict_haskey(response, "event")) {
+        return response;
+    }
+
+    /* OK, it was an event */
+    event_string = qdict_get_str(response, "event");
+    if (!strcmp(event_string, "STOP")) {
+        got_stop = true;
+    }
+    QDECREF(response);
+    return return_or_event(qtest_qmp_receive(global_qtest));
+}
+
+
+/*
+ * It's tricky to use qemu's migration event capability with qtest,
+ * events suddenly appearing confuse the qmp()/hmp() responses.
+ * so wait for a couple of passes to have happened before
+ * going postcopy.
+ */
+
+static uint64_t get_migration_pass(void)
+{
+    QDict *rsp, *rsp_return, *rsp_ram;
+    uint64_t result;
+
+    rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+    rsp_return = qdict_get_qdict(rsp, "return");
+    if (!qdict_haskey(rsp_return, "ram")) {
+        /* Still in setup */
+        result = 0;
+    } else {
+        rsp_ram = qdict_get_qdict(rsp_return, "ram");
+        result = qdict_get_try_int(rsp_ram, "dirty-sync-count", 0);
+    }
+    QDECREF(rsp);
+    return result;
+}
+
+static void wait_for_migration_complete(void)
+{
+    QDict *rsp, *rsp_return;
+    bool completed;
+
+    do {
+        const char *status;
+
+        rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+        rsp_return = qdict_get_qdict(rsp, "return");
+        status = qdict_get_str(rsp_return, "status");
+        completed = strcmp(status, "completed") == 0;
+        g_assert_cmpstr(status, !=,  "failed");
+        QDECREF(rsp);
+        usleep(1000 * 100);
+    } while (!completed);
+}
+
+static void wait_for_migration_pass(void)
+{
+    uint64_t initial_pass = get_migration_pass();
+    uint64_t pass;
+
+    /* Wait for the 1st sync */
+    do {
+        initial_pass = get_migration_pass();
+        if (got_stop || initial_pass) {
+            break;
+        }
+        usleep(1000 * 100);
+    } while (true);
+
+    do {
+        usleep(1000 * 100);
+        pass = get_migration_pass();
+    } while (pass == initial_pass && !got_stop);
+}
+
+static void check_guests_ram(void)
+{
+    /* Our ASM test will have been incrementing one byte from each page from
+     * 1MB to <100MB in order.
+     * This gives us a constraint that any page's byte should be equal or less
+     * than the previous pages byte (mod 256); and they should all be equal
+     * except for one transition at the point where we meet the incrementer.
+     * (We're running this with the guest stopped).
+     */
+    unsigned address;
+    uint8_t first_byte;
+    uint8_t last_byte;
+    bool hit_edge = false;
+    bool bad = false;
+
+    qtest_memread(global_qtest, start_address, &first_byte, 1);
+    last_byte = first_byte;
+
+    for (address = start_address + 4096; address < end_address; address += 4096)
+    {
+        uint8_t b;
+        qtest_memread(global_qtest, address, &b, 1);
+        if (b != last_byte) {
+            if (((b + 1) % 256) == last_byte && !hit_edge) {
+                /* This is OK, the guest stopped at the point of
+                 * incrementing the previous page but didn't get
+                 * to us yet.
+                 */
+                hit_edge = true;
+            } else {
+                fprintf(stderr, "Memory content inconsistency at %x"
+                                " first_byte = %x last_byte = %x current = %x"
+                                " hit_edge = %x\n",
+                                address, first_byte, last_byte, b, hit_edge);
+                bad = true;
+            }
+        }
+        last_byte = b;
+    }
+    g_assert_false(bad);
+}
+
+static void cleanup(const char *filename)
+{
+    char *path = g_strdup_printf("%s/%s", tmpfs, filename);
+
+    unlink(path);
+    g_free(path);
+}
+
+static void test_migrate(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *global = global_qtest, *from, *to;
+    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
+    gchar *cmd, *cmd_src, *cmd_dst;
+    QDict *rsp;
+
+    char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
+    const char *arch = qtest_get_arch();
+
+    got_stop = false;
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        init_bootfile_x86(bootpath);
+        cmd_src = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
+                                  " -name pcsource,debug-threads=on"
+                                  " -serial file:%s/src_serial"
+                                  " -drive file=%s,format=raw",
+                                  tmpfs, bootpath);
+        cmd_dst = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
+                                  " -name pcdest,debug-threads=on"
+                                  " -serial file:%s/dest_serial"
+                                  " -drive file=%s,format=raw"
+                                  " -incoming %s",
+                                  tmpfs, bootpath, uri);
+    } else if (strcmp(arch, "ppc64") == 0) {
+        const char *accel;
+
+        /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
+        accel = access("/sys/module/kvm_hv", F_OK) ? "tcg" : "kvm:tcg";
+        init_bootfile_ppc(bootpath);
+        cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
+                                  " -name pcsource,debug-threads=on"
+                                  " -serial file:%s/src_serial"
+                                  " -drive file=%s,if=pflash,format=raw",
+                                  accel, tmpfs, bootpath);
+        cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
+                                  " -name pcdest,debug-threads=on"
+                                  " -serial file:%s/dest_serial"
+                                  " -incoming %s",
+                                  accel, tmpfs, uri);
+    } else {
+        g_assert_not_reached();
+    }
+
+    g_free(bootpath);
+
+    from = qtest_start(cmd_src);
+    g_free(cmd_src);
+
+    to = qtest_init(cmd_dst);
+    g_free(cmd_dst);
+
+    global_qtest = from;
+    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
+                  "'arguments': { "
+                      "'capabilities': [ {"
+                          "'capability': 'x-multifd',"
+                          "'state': true } ] } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    global_qtest = to;
+    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
+                  "'arguments': { "
+                      "'capabilities': [ {"
+                          "'capability': 'x-multifd',"
+                          "'state': true } ] } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    global_qtest = from;
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+              "'arguments': { 'max-bandwidth': 100000000 } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    /* 200ms downtime */
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+              "'arguments': { 'downtime-limit': 300 } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    /* set 4 channels */
+    global_qtest = to;
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+              "'arguments': { 'x-multifd-channels': 4 } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+              "'arguments': { 'x-multifd-page-count': 64 } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    /* set 4 channels */
+    global_qtest = from;
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+              "'arguments': { 'x-multifd-channels': 4 } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+              "'arguments': { 'x-multifd-page-count': 64 } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate',"
+                          "'arguments': { 'uri': '%s' } }",
+                          uri);
+    rsp = qmp(cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    wait_for_migration_pass();
+
+    if (!got_stop) {
+        qmp_eventwait("STOP");
+    }
+
+    global_qtest = to;
+    qmp_eventwait("RESUME");
+
+    wait_for_serial("dest_serial");
+    global_qtest = from;
+    wait_for_migration_complete();
+
+    qtest_quit(from);
+
+    global_qtest = to;
+
+    qtest_memread(to, start_address, &dest_byte_a, 1);
+
+    /* Destination still running, wait for a byte to change */
+    do {
+        qtest_memread(to, start_address, &dest_byte_b, 1);
+        usleep(10 * 1000);
+    } while (dest_byte_a == dest_byte_b);
+
+    qmp_discard_response("{ 'execute' : 'stop'}");
+    /* With it stopped, check nothing changes */
+    qtest_memread(to, start_address, &dest_byte_c, 1);
+    sleep(1);
+    qtest_memread(to, start_address, &dest_byte_d, 1);
+    g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
+
+    check_guests_ram();
+
+    qtest_quit(to);
+    g_free(uri);
+
+    global_qtest = global;
+
+    cleanup("bootsect");
+    cleanup("migsocket");
+    cleanup("src_serial");
+    cleanup("dest_serial");
+}
+
+int main(int argc, char **argv)
+{
+    char template[] = "/tmp/multifd-test-XXXXXX";
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    tmpfs = mkdtemp(template);
+    if (!tmpfs) {
+        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
+    }
+    g_assert(tmpfs);
+
+    module_call_init(MODULE_INIT_QOM);
+
+    qtest_add_func("/multifd", test_migrate);
+
+    ret = g_test_run();
+
+    g_assert_cmpint(ret, ==, 0);
+
+    ret = rmdir(tmpfs);
+    if (ret != 0) {
+        g_test_message("unable to rmdir: path (%s): %s\n",
+                       tmpfs, strerror(errno));
+    }
+
+    return ret;
+}
-- 
2.13.5
