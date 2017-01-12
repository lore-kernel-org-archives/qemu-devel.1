Received: from eggs.gnu.org ([2001:4830:134:3::10]:46765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkA-00039z-1F
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk7-0006hO-Ru
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:00 +1100
Message-Id: <20170112020327.24882-41-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 40/67] qtest: convert ivshmem-test to use libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

This will allow to use it with ppc64.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/ivshmem-test.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 04a5c5d..8095d72 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include "contrib/ivshmem-server/ivshmem-server.h"
-#include "libqos/pci-pc.h"
+#include "libqos/libqos-pc.h"
 #include "libqtest.h"
 #include "qemu-common.h"
 
@@ -40,9 +40,8 @@ static QPCIDevice *get_device(QPCIBus *pcibus)
 }
 
 typedef struct _IVState {
-    QTestState *qtest;
+    QOSState *qs;
     QPCIBar reg_bar, mem_bar;
-    QPCIBus *pcibus;
     QPCIDevice *dev;
 } IVState;
 
@@ -74,7 +73,7 @@ static inline unsigned in_reg(IVState *s, enum Reg reg)
     QTestState *qtest = global_qtest;
     unsigned res;
 
-    global_qtest = s->qtest;
+    global_qtest = s->qs->qts;
     res = qpci_io_readl(s->dev, s->reg_bar, reg);
     g_test_message("*%s -> %x\n", name, res);
     global_qtest = qtest;
@@ -87,7 +86,7 @@ static inline void out_reg(IVState *s, enum Reg reg, unsigned v)
     const char *name = reg2str(reg);
     QTestState *qtest = global_qtest;
 
-    global_qtest = s->qtest;
+    global_qtest = s->qs->qts;
     g_test_message("%x -> *%s\n", v, name);
     qpci_io_writel(s->dev, s->reg_bar, reg, v);
     global_qtest = qtest;
@@ -97,7 +96,7 @@ static inline void read_mem(IVState *s, uint64_t off, void *buf, size_t len)
 {
     QTestState *qtest = global_qtest;
 
-    global_qtest = s->qtest;
+    global_qtest = s->qs->qts;
     qpci_memread(s->dev, s->mem_bar, off, buf, len);
     global_qtest = qtest;
 }
@@ -107,7 +106,7 @@ static inline void write_mem(IVState *s, uint64_t off,
 {
     QTestState *qtest = global_qtest;
 
-    global_qtest = s->qtest;
+    global_qtest = s->qs->qts;
     qpci_memwrite(s->dev, s->mem_bar, off, buf, len);
     global_qtest = qtest;
 }
@@ -115,17 +114,21 @@ static inline void write_mem(IVState *s, uint64_t off,
 static void cleanup_vm(IVState *s)
 {
     g_free(s->dev);
-    qpci_free_pc(s->pcibus);
-    qtest_quit(s->qtest);
+    qtest_shutdown(s->qs);
 }
 
 static void setup_vm_cmd(IVState *s, const char *cmd, bool msix)
 {
     uint64_t barsize;
+    const char *arch = qtest_get_arch();
 
-    s->qtest = qtest_start(cmd);
-    s->pcibus = qpci_init_pc(NULL);
-    s->dev = get_device(s->pcibus);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        s->qs = qtest_pc_boot(cmd);
+    } else {
+        g_printerr("ivshmem-test tests are only available on x86\n");
+        exit(EXIT_FAILURE);
+    }
+    s->dev = get_device(s->qs->pcibus);
 
     s->reg_bar = qpci_iomap(s->dev, 0, &barsize);
     g_assert_cmpuint(barsize, ==, 256);
@@ -347,7 +350,7 @@ static void test_ivshmem_server(bool msi)
     g_assert_cmpint(vm1, !=, vm2);
 
     /* check number of MSI-X vectors */
-    global_qtest = s1->qtest;
+    global_qtest = s1->qs->qts;
     if (msi) {
         ret = qpci_msix_table_size(s1->dev);
         g_assert_cmpuint(ret, ==, nvectors);
@@ -370,7 +373,7 @@ static void test_ivshmem_server(bool msi)
     g_assert_cmpuint(ret, !=, 0);
 
     /* ping vm1 -> vm2 on vector 1 */
-    global_qtest = s2->qtest;
+    global_qtest = s2->qs->qts;
     if (msi) {
         ret = qpci_msix_pending(s2->dev, 1);
         g_assert_cmpuint(ret, ==, 0);
-- 
2.9.3
