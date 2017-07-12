Received: from eggs.gnu.org ([2001:4830:134:3::10]:43722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVEA4-0000XV-08
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dVEA2-0002tf-RJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dVEA2-0002tD-HY
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:42:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 783F4C0587F2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:42:21 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Wed, 12 Jul 2017 11:41:48 +0200
Message-Id: <20170712094149.23069-3-jfreimann@redhat.com>
In-Reply-To: <20170712094149.23069-1-jfreimann@redhat.com>
References: <20170712094149.23069-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/3] tests/pxe-test: add testcase using
 vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com

From: Jens Freimann <jfreiman@redhat.com>

Add a test to pxe-test using the vhost-user interface. 
Create a vhost-user-bridge process and connect it to qemu.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 tests/Makefile.include |   4 +-
 tests/pxe-test.c       | 106 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 18cd06a..eccb27e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -698,7 +698,8 @@ tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
 tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
 tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
-tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
+tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o \
+    tests/vhost-user-bridge$(EXESUF) $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
@@ -826,6 +827,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check-qtest-y)
 	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
 	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
 		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
+		QTEST_VUBR_BINARY=./tests/vhost-user-bridge$(EXESUF) \
 		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))} \
 		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
 	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generic-y); do \
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 34282d3..5a0d182 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -5,7 +5,8 @@
  *
  * Authors:
  *  Michael S. Tsirkin <mst@redhat.com>,
- *  Victor Kaplansky <victork@redhat.com>
+ *  Victor Kaplansky <victork@redhat.com>,
+ *  Jens Freimann <jfreiman@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -13,13 +14,115 @@
 
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
+#include <glib.h>
 #include "qemu-common.h"
 #include "libqtest.h"
 #include "boot-sector.h"
+#include <sys/vfs.h>
 
+#define LPORT 5555
+#define RPORT 4444
 #define NETNAME "net0"
+#define QEMU_CMD_MEM    "--enable-kvm -m %d -object memory-backend-file,id=mem,size=%dM,"\
+                        "mem-path=%s,share=on -numa node,memdev=mem -mem-prealloc "
+#define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s"
+#define QEMU_CMD_NETDEV " -device virtio-net-pci,netdev=net0 "\
+                        " -netdev vhost-user,id=net0,chardev=%s,vhostforce "\
+                        " -netdev user,id=n0,tftp=./,bootfile=%s "\
+                        " -netdev socket,id=n1,udp=localhost:%d,localaddr=localhost:%d"
+#define QEMU_CMD_NET    " -device virtio-net-pci,netdev=n0 "\
+                        " -device virtio-net-pci,netdev=n1 "
+
+#define QEMU_CMD        QEMU_CMD_MEM QEMU_CMD_CHR \
+                        QEMU_CMD_NETDEV QEMU_CMD_NET
+
+#define HUGETLBFS_MAGIC       0x958458f6
+#define VUBR_SOCK "vubr.sock"
+#define MEMSZ 1024
 
 static char disk[] = "tests/pxe-test-disk-XXXXXX";
+static const char *root;
+static const char *tmpfs;
+static const char *tmpfs2;
+
+static const char *init_hugepagefs(const char *path)
+{
+    struct statfs fs;
+    int ret;
+
+    if (access(path, R_OK | W_OK | X_OK)) {
+        g_test_message("access on path (%s): %s\n", path, strerror(errno));
+        return NULL;
+    }
+
+    do {
+        ret = statfs(path, &fs);
+    } while (ret != 0 && errno == EINTR);
+
+    if (ret != 0) {
+        g_test_message("statfs on path (%s): %s\n", path, strerror(errno));
+        return NULL;
+    }
+
+    if (fs.f_type != HUGETLBFS_MAGIC) {
+        g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
+        return NULL;
+    }
+
+    return path;
+}
+
+static void test_pxe_vhost_user(void)
+{
+    char template[] = "/tmp/vhost-user-bridge-XXXXXX";
+    char template2[] = "/tmp/hugepages-XXXXXX";
+    gchar *vubr_args[] = {NULL, NULL, NULL, NULL};
+    const char *hugefs;
+    GError *error = NULL;
+    char *vubr_binary;
+    char *qemu_args;
+    GPid vubr_pid;
+
+    tmpfs = mkdtemp(template);
+    if (!tmpfs) {
+        g_test_message("mkdtemp on path(%s): %s\n",
+                       template, strerror(errno));
+    }
+    vubr_binary = getenv("QTEST_VUBR_BINARY");
+    g_assert(vubr_binary);
+    vubr_args[0] = g_strdup_printf("%s", vubr_binary);
+    vubr_args[1] = g_strdup_printf("-u");
+    vubr_args[2] = g_strdup_printf("%s/%s", tmpfs, VUBR_SOCK);
+    g_spawn_async(NULL, vubr_args, NULL,
+                  G_SPAWN_SEARCH_PATH_FROM_ENVP |
+                  G_SPAWN_SEARCH_PATH,
+                  NULL, NULL, &vubr_pid, &error);
+    g_assert_no_error(error);
+
+    hugefs = getenv("QTEST_HUGETLBFS_PATH");
+    if (hugefs) {
+        root = init_hugepagefs(hugefs);
+        g_assert(root);
+    } else {
+        tmpfs2 = mkdtemp(template2);
+        g_assert(tmpfs2);
+        root = tmpfs2;
+    }
+
+    qemu_args = g_strdup_printf(QEMU_CMD, MEMSZ, MEMSZ, (root),
+                                "char0", vubr_args[2], "char0", disk,
+                                RPORT, LPORT);
+    qtest_start(qemu_args);
+    boot_sector_test();
+    qtest_quit(global_qtest);
+    g_free(qemu_args);
+    g_free(vubr_args[0]);
+    g_free(vubr_args[1]);
+    g_free(vubr_args[2]);
+    g_assert_cmpint (g_remove(g_strdup_printf("%s/%s", tmpfs,VUBR_SOCK)),
+		     ==, 0);
+    g_assert_cmpint(rmdir(tmpfs), ==, 0);
+}
 
 static void test_pxe_one(const char *params, bool ipv6)
 {
@@ -65,6 +168,7 @@ int main(int argc, char *argv[])
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qtest_add_func("pxe/e1000", test_pxe_e1000);
         qtest_add_func("pxe/virtio", test_pxe_virtio_pci);
+        qtest_add_func("pxe/vhost-user", test_pxe_vhost_user);
     } else if (strcmp(arch, "ppc64") == 0) {
         qtest_add_func("pxe/virtio", test_pxe_virtio_pci);
         qtest_add_func("pxe/spapr-vlan", test_pxe_spapr_vlan);
-- 
2.9.4
