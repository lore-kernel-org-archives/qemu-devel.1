Received: from eggs.gnu.org ([2001:4830:134:3::10]:50971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1e7hXF-00071d-1q
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1e7hXA-00050W-0C
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1e7hX9-0004yy-NL
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B321425C43
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 12:45:14 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Thu, 26 Oct 2017 14:44:25 +0200
Message-Id: <20171026124425.17957-3-jfreimann@redhat.com>
In-Reply-To: <20171026124425.17957-1-jfreimann@redhat.com>
References: <20171026124425.17957-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [v3 2/2] tests/pxe-test: add testcase using
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
Cc: mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

From: Jens Freimann <jfreiman@redhat.com>

Add a PXE testcase tunneling traffic through vhost-user-bridge process.
Create a vhost-user-bridge process and connect it to qemu via a socket.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 tests/Makefile.include |   4 +-
 tests/pxe-test.c       | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 70dc711bca..6cdb783753 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -740,7 +740,8 @@ tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
 tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
 tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
-tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
+tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o \
+    tests/vhost-user-bridge$(EXESUF) $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
@@ -849,6 +850,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu
 	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
 	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
 		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
+		QTEST_VUBR_BINARY=./tests/vhost-user-bridge$(EXESUF) \
 		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
 		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
 	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generic-y); do \
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 937f29e631..d2646ee86d 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -7,6 +7,7 @@
  *  Michael S. Tsirkin <mst@redhat.com>,
  *  Victor Kaplansky <victork@redhat.com>
  *  Thomas Huth <thuth@redhat.com>
+ *  Jens Freimann <jfreiman@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -14,14 +15,123 @@
 
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
+#include <glib.h>
 #include "qemu-common.h"
 #include "libqtest.h"
 #include "boot-sector.h"
 
+#define LPORT 5555
+#define RPORT 4444
 #define NETNAME "net0"
+#define QEMU_CMD_MEM    "--enable-kvm -m %d "\
+                        "-object memory-backend-file,id=mem,size=%dM,"\
+                        "mem-path=%s,share=on -numa node,memdev=mem -mem-prealloc "
+#define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s"
+#define QEMU_CMD_NETDEV " -device virtio-net-pci,netdev=net0 "\
+                        " -netdev vhost-user,id=net0,chardev=%s,vhostforce "\
+                        " -netdev user,id=n0,tftp=./,bootfile=%s "\
+                        " -netdev socket,id=n1,fd=%d"
+#define QEMU_CMD_NET    " -device virtio-net-pci,netdev=n0 "\
+                        " -device virtio-net-pci,netdev=n1 "
+
+#define QEMU_CMD        QEMU_CMD_MEM QEMU_CMD_CHR \
+                        QEMU_CMD_NETDEV QEMU_CMD_NET
+
+#define VUBR_SOCK "vubr.sock"
+#define MEMSZ 1024
 
 static char disk[] = "tests/pxe-test-disk-XXXXXX";
 
+static int vubr_create_socket(struct sockaddr_in *si_remote, int rport)
+{
+    int sock;
+
+    si_remote->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+    sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+    if (sock == -1) {
+        g_test_message("socket creation failed\n");
+        return -1;
+    }
+    if (connect(sock, (struct sockaddr *) si_remote, sizeof(*si_remote))) {
+        g_test_message("connect failed: %s", strerror(errno));
+        return -1;
+    }
+
+    return sock;
+}
+
+static void vubr_watch(GPid pid, gint status, gpointer data)
+{
+    g_assert_cmpint(status, ==, 0);
+    g_spawn_close_pid(pid);
+}
+
+static void abrt_handler(void *data)
+{
+    int *pid = data;
+
+    g_spawn_close_pid(*pid);
+    kill(*pid, SIGTERM);
+    waitpid(*pid, NULL, 0);
+}
+
+static void test_pxe_vhost_user(void)
+{
+    char template[] = "/tmp/vhost-user-bridge-XXXXXX";
+    gchar * vubr_args[] = {NULL, NULL, NULL, NULL};
+    struct sockaddr_in si_remote = {
+        .sin_family = AF_INET,
+        .sin_port = htons(RPORT),
+    };
+    const char *hugefs = NULL;
+    const char *tmpfs = NULL;
+    GError *error = NULL;
+    char *vubr_binary;
+    char *qemu_args;
+    GPid vubr_pid;
+    int sock = -1;
+
+    qtest_add_abrt_handler(abrt_handler, &vubr_pid);
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
+                  G_SPAWN_SEARCH_PATH |
+                  G_SPAWN_DO_NOT_REAP_CHILD,
+                  NULL, NULL, &vubr_pid, &error);
+    g_assert_no_error(error);
+    g_child_watch_add(vubr_pid, vubr_watch, NULL);
+
+    hugefs = getenv("QTEST_HUGETLBFS_PATH");
+    if (!hugefs) {
+        hugefs = tmpfs;
+    }
+    sock = vubr_create_socket(&si_remote, RPORT);
+    g_assert_cmpint(sock, !=, -1);
+    qemu_args = g_strdup_printf(QEMU_CMD, MEMSZ, MEMSZ, (hugefs),
+                                "char0", vubr_args[2], "char0",
+                                disk, sock);
+    qtest_start(qemu_args);
+    boot_sector_test();
+    qtest_quit(global_qtest);
+    g_free(qemu_args);
+    g_free(vubr_args[0]);
+    g_free(vubr_args[1]);
+    g_free(vubr_args[2]);
+    g_assert_cmpint(g_remove(g_strdup_printf("%s/%s", tmpfs, VUBR_SOCK)),
+                    ==, 0);
+    g_assert_cmpint(g_remove(g_strdup_printf("%s", disk)), ==, 0);
+    g_assert_cmpint(g_rmdir(tmpfs), ==, 0);
+    g_assert_cmpint(kill(vubr_pid, SIGTERM), ==, 0);
+}
+
 static void test_pxe_one(const char *params, bool ipv6)
 {
     char *args;
@@ -77,6 +187,7 @@ int main(int argc, char *argv[])
             qtest_add_data_func("pxe/pcnet", "pcnet", test_pxe_ipv4);
             qtest_add_data_func("pxe/rtl8139", "rtl8139", test_pxe_ipv4);
             qtest_add_data_func("pxe/vmxnet3", "vmxnet3", test_pxe_ipv4);
+            qtest_add_func("pxe/vhost-user", test_pxe_vhost_user);
         }
     } else if (strcmp(arch, "ppc64") == 0) {
         qtest_add_func("pxe/spapr-vlan", test_pxe_spapr_vlan);
-- 
2.13.6
