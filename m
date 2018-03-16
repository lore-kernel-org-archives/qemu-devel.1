Received: from eggs.gnu.org ([2001:4830:134:3::10]:55419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewi6D-0005d9-UX
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 01:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewi6C-0003CB-Eo
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 01:40:17 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 16 Mar 2018 06:39:54 +0100
Message-Id: <1521178795-21894-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1521178795-21894-1-git-send-email-thuth@redhat.com>
References: <1521178795-21894-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] tests/cdrom-test: Test booting from
 CD-ROM ISO image file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We already have the code for a boot file in tests/boot-sector.c,
so if the genisoimage program is available, we can easily create
a bootable CD ISO image that we can use for testing whether our
CD-ROM emulation and the BIOS CD-ROM boot works correctly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include |   2 +
 tests/cdrom-test.c     | 164 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 tests/cdrom-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ef9b88c..37ca258 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -178,6 +178,7 @@ check-qtest-generic-y = tests/qmp-test$(EXESUF)
 gcov-files-generic-y = monitor.c qapi/qmp-dispatch.c
 check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
 gcov-files-generic-y = qdev-monitor.c qmp.c
+check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 gcov-files-ipack-y += hw/ipack/ipack.c
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
@@ -829,6 +830,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 tests/sdhci-test$(EXESUF): tests/sdhci-test.o $(libqos-pc-obj-y)
+tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos-obj-y)
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
new file mode 100644
index 0000000..5bbf322
--- /dev/null
+++ b/tests/cdrom-test.c
@@ -0,0 +1,164 @@
+/*
+ * Various tests for emulated CD-ROM drives.
+ *
+ * Copyright (c) 2018 Red Hat Inc.
+ *
+ * Author:
+ *    Thomas Huth <thuth@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2
+ * or later. See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "boot-sector.h"
+
+static char isoimage[] = "cdrom-boot-iso-XXXXXX";
+
+static int exec_genisoimg(const char **args)
+{
+    gchar *out_err = NULL;
+    gint exit_status = -1;
+    bool success;
+
+    success = g_spawn_sync(NULL, (gchar **)args, NULL,
+                           G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL,
+                           NULL, NULL, NULL, &out_err, &exit_status, NULL);
+    if (!success) {
+        return -ENOENT;
+    }
+    if (out_err) {
+        fputs(out_err, stderr);
+        g_free(out_err);
+    }
+
+    return exit_status;
+}
+
+static int prepare_image(const char *arch, char *isoimage)
+{
+    char srcdir[] = "cdrom-test-dir-XXXXXX";
+    char *codefile = NULL;
+    int ifh, ret = -1;
+    const char *args[] = {
+        "genisoimage", "-quiet", "-l", "-no-emul-boot",
+        "-b", NULL, "-o", isoimage, srcdir, NULL
+    };
+
+    ifh = mkstemp(isoimage);
+    if (ifh < 0) {
+        perror("Error creating temporary iso image file");
+        return -1;
+    }
+    if (!mkdtemp(srcdir)) {
+        perror("Error creating temporary directory");
+        goto cleanup;
+    }
+
+    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64") ||
+        g_str_equal(arch, "s390x")) {
+        codefile = g_strdup_printf("%s/bootcode-XXXXXX", srcdir);
+        ret = boot_sector_init(codefile);
+        if (ret) {
+            goto cleanup;
+        }
+    } else {
+        /* Just create a dummy file */
+        char txt[] = "empty disc";
+        codefile = g_strdup_printf("%s/readme.txt", srcdir);
+        if (!g_file_set_contents(codefile, txt, sizeof(txt) - 1, NULL)) {
+            fprintf(stderr, "Failed to create '%s'\n", codefile);
+            goto cleanup;
+        }
+    }
+
+    args[5] = strchr(codefile, '/') + 1;
+    ret = exec_genisoimg(args);
+    if (ret) {
+        fprintf(stderr, "genisoimage failed: %i\n", ret);
+    }
+
+    unlink(codefile);
+
+cleanup:
+    g_free(codefile);
+    rmdir(srcdir);
+    close(ifh);
+
+    return ret;
+}
+
+static void test_cdboot(gconstpointer data)
+{
+    QTestState *qts;
+
+    qts = qtest_startf("-accel kvm:tcg -no-shutdown %s%s", (const char *)data,
+                       isoimage);
+    boot_sector_test(qts);
+    qtest_quit(qts);
+}
+
+static void add_x86_tests(void)
+{
+    qtest_add_data_func("cdrom/boot/default", "-cdrom ", test_cdboot);
+    qtest_add_data_func("cdrom/boot/virtio-scsi",
+                        "-device virtio-scsi -device scsi-cd,drive=cdr "
+                        "-blockdev file,node-name=cdr,filename=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
+                        "-drive if=ide,media=cdrom,file=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/am53c974",
+                        "-device am53c974 -device scsi-cd,drive=cd1 "
+                        "-drive if=none,id=cd1,format=raw,file=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/dc390",
+                        "-device dc390 -device scsi-cd,drive=cd1 "
+                        "-blockdev file,node-name=cd1,filename=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/lsi53c895a",
+                        "-device lsi53c895a -device scsi-cd,drive=cd1 "
+                        "-blockdev file,node-name=cd1,filename=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/megasas", "-M q35 "
+                        "-device megasas -device scsi-cd,drive=cd1 "
+                        "-blockdev file,node-name=cd1,filename=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/megasas-gen2", "-M q35 "
+                        "-device megasas-gen2 -device scsi-cd,drive=cd1 "
+                        "-blockdev file,node-name=cd1,filename=", test_cdboot);
+}
+
+static void add_s390x_tests(void)
+{
+    qtest_add_data_func("cdrom/boot/default", "-cdrom ", test_cdboot);
+    qtest_add_data_func("cdrom/boot/virtio-scsi",
+                        "-device virtio-scsi -device scsi-cd,drive=cdr "
+                        "-blockdev file,node-name=cdr,filename=", test_cdboot);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    const char *arch = qtest_get_arch();
+    const char *genisocheck[] = { "genisoimage", "-version", NULL };
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (exec_genisoimg(genisocheck)) {
+        /* genisoimage not available - so can't run tests */
+        return 0;
+    }
+
+    ret = prepare_image(arch, isoimage);
+    if (ret) {
+        return ret;
+    }
+
+    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
+        add_x86_tests();
+    } else if (g_str_equal(arch, "s390x")) {
+        add_s390x_tests();
+    }
+
+    ret = g_test_run();
+
+    unlink(isoimage);
+
+    return ret;
+}
-- 
1.8.3.1
