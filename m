Received: from eggs.gnu.org ([2001:4830:134:3::10]:50195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqHD2-0002WG-FO
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqHCz-0008QJ-D5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:40:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cqHCz-0008PP-5P
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BA6B104CF
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:40:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 21 Mar 2017 11:39:52 +0100
Message-Id: <1490092792-30957-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1490092792-30957-1-git-send-email-thuth@redhat.com>
References: <1490092792-30957-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] tests: Add a tester for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

HMP commands do not get any automatic testing yet, so on certain
QEMU machines, some HMP commands were causing crashes in the past.
Thus we should test HMP commands in our test suite, too, to avoid
that such problems creep in again in the future.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include |   2 +
 tests/test-hmp.c       | 160 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 tests/test-hmp.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 402e71c..0a0afc7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -331,6 +331,7 @@ check-qtest-xtensaeb-y = $(check-qtest-xtensa-y)
 check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
+check-qtest-generic-y += tests/test-hmp$(EXESUF)
 
 qapi-schema += alternate-any.json
 qapi-schema += alternate-array.json
@@ -716,6 +717,7 @@ tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
+tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-pc-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
new file mode 100644
index 0000000..2f025db
--- /dev/null
+++ b/tests/test-hmp.c
@@ -0,0 +1,160 @@
+/*
+ * Test HMP commands.
+ *
+ * Copyright (c) 2017 Red Hat Inc.
+ *
+ * Author:
+ *    Thomas Huth <thuth@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2
+ * or later. See the COPYING file in the top-level directory.
+ *
+ * This test calls some HMP commands for all machines that the current
+ * QEMU binary provides, to check whether they terminate successfully
+ * (i.e. do not crash QEMU).
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+static int verbose;
+
+static const char *hmp_cmds[] = {
+    "boot_set ndc",
+    "chardev-add null,id=testchardev1",
+    "chardev-remove testchardev1",
+    "commit all",
+    "cpu-add 1",
+    "cpu 0",
+    "device_add ?",
+    "device_add usb-mouse,id=mouse1",
+    "mouse_button 7",
+    "mouse_move 10 10",
+    "mouse_button 0",
+    "device_del mouse1",
+    "dump-guest-memory /dev/null 0 4096",
+    "gdbserver",
+    "host_net_add user id=net0",
+    "hostfwd_add tcp::43210-:43210",
+    "hostfwd_remove tcp::43210-:43210",
+    "host_net_remove 0 net0",
+    "i /w 0",
+    "log all",
+    "log none",
+    "memsave 0 4096 \"/dev/null\"",
+    "migrate_set_cache_size 1",
+    "migrate_set_downtime 1",
+    "migrate_set_speed 1",
+    "netdev_add user,id=net1",
+    "set_link net1 off",
+    "set_link net1 on",
+    "netdev_del net1",
+    "nmi",
+    "o /w 0 0x1234",
+    "object_add memory-backend-ram,id=mem1,size=256M",
+    "object_del mem1",
+    "pmemsave 0 4096 \"/dev/null\"",
+    "p $pc + 8",
+    "qom-list /",
+    "qom-set /machine initrd test",
+    "screendump /dev/null",
+    "sendkey x",
+    "singlestep on",
+    "wavcapture /dev/null",
+    "stopcapture 0",
+    "sum 0 512",
+    "x /8i 0x100",
+    "xp /16x 0",
+    NULL
+};
+
+/* Run through the list of pre-defined commands */
+static void test_commands(void)
+{
+    char *response;
+    int i;
+
+    for (i = 0; hmp_cmds[i] != NULL; i++) {
+        if (verbose) {
+            fprintf(stderr, "\t%s\n", hmp_cmds[i]);
+        }
+        response = hmp(hmp_cmds[i]);
+        g_free(response);
+    }
+
+}
+
+/* Run through all info commands and call them blindly (without arguments) */
+static void test_info_commands(void)
+{
+    char *resp, *info, *info_buf, *endp;
+
+    info_buf = info = hmp("help info");
+
+    while (*info) {
+        /* Extract the info command, ignore parameters and description */
+        g_assert(strncmp(info, "info ", 5) == 0);
+        endp = strchr(&info[5], ' ');
+        g_assert(endp != NULL);
+        *endp = '\0';
+        /* Now run the info command */
+        if (verbose) {
+            fprintf(stderr, "\t%s\n", info);
+        }
+        resp = hmp(info);
+        g_free(resp);
+        /* And move forward to the next line */
+        info = strchr(endp + 1, '\n');
+        if (!info) {
+            break;
+        }
+        info += 1;
+    }
+
+    g_free(info_buf);
+}
+
+static void test_machine(gconstpointer data)
+{
+    const char *machine = data;
+    char *args;
+
+    args = g_strdup_printf("-S -M %s", machine);
+    qtest_start(args);
+
+    test_info_commands();
+    test_commands();
+
+    qtest_end();
+    g_free(args);
+    g_free((void *)data);
+}
+
+static void add_machine_test_case(const char *mname)
+{
+    char *path = g_strdup_printf("hmp/%s", mname);
+
+    /* Ignore blacklisted machines that have known problems */
+    if (strcmp("isapc", mname) == 0 ||  strcmp("puv3", mname) == 0
+        || strcmp("tricore_testboard", mname) == 0) {
+        return;
+    }
+
+    qtest_add_data_func(path, g_strdup(mname), test_machine);
+    g_free(path);
+}
+
+int main(int argc, char **argv)
+{
+    char *v_env = getenv("V");
+
+    if (v_env && *v_env >= '2') {
+        verbose = true;
+    }
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_cb_for_every_machine(add_machine_test_case);
+
+    return g_test_run();
+}
-- 
1.8.3.1
