Received: from eggs.gnu.org ([2001:4830:134:3::10]:46646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk7-00036y-Uj
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk5-0006ef-62
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:01 +1100
Message-Id: <20170112020327.24882-42-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 41/67] qtest: add ivshmem-test for ppc64
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

The test has been converted to use libqos, we can
now use it on ppc64. We also make the test fail on
all other architectures.
As libqos on ppc64 is not able to manage hotplug
and IRQ/MSI, we disable this part in the test on ppc64.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/Makefile.include |  3 ++-
 tests/ivshmem-test.c   | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6ed78b8..0bb939d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -288,6 +288,7 @@ check-qtest-ppc64-y += tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
 check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
 check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
+check-qtest-ppc64-y += tests/ivshmem-test$(EXESUF)
 
 check-qtest-sh4-y = tests/endianness-test$(EXESUF)
 
@@ -692,7 +693,7 @@ tests/test-netfilter$(EXESUF): tests/test-netfilter.o $(qtest-obj-y)
 tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-y)
 tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(qtest-obj-y)
 tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qtest-obj-y)
-tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y)
+tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libvhost-user/libvhost-user.o $(test-util-obj-y)
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 8095d72..3776342 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -12,6 +12,7 @@
 #include <glib/gstdio.h>
 #include "contrib/ivshmem-server/ivshmem-server.h"
 #include "libqos/libqos-pc.h"
+#include "libqos/libqos-spapr.h"
 #include "libqtest.h"
 #include "qemu-common.h"
 
@@ -124,8 +125,10 @@ static void setup_vm_cmd(IVState *s, const char *cmd, bool msix)
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         s->qs = qtest_pc_boot(cmd);
+    } else if (strcmp(arch, "ppc64") == 0) {
+        s->qs = qtest_spapr_boot(cmd);
     } else {
-        g_printerr("ivshmem-test tests are only available on x86\n");
+        g_printerr("ivshmem-test tests are only available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
     }
     s->dev = get_device(s->qs->pcibus);
@@ -415,6 +418,7 @@ static void test_ivshmem_server_irq(void)
 
 static void test_ivshmem_hotplug(void)
 {
+    const char *arch = qtest_get_arch();
     gchar *opts;
 
     qtest_start("");
@@ -422,7 +426,9 @@ static void test_ivshmem_hotplug(void)
     opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);
 
     qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
-    qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
+    if (strcmp(arch, "ppc64") != 0) {
+        qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
+    }
 
     qtest_end();
     g_free(opts);
@@ -494,6 +500,7 @@ static gchar *mktempshm(int size, int *fd)
 int main(int argc, char **argv)
 {
     int ret, fd;
+    const char *arch = qtest_get_arch();
     gchar dir[] = "/tmp/ivshmem-test.XXXXXX";
 
 #if !GLIB_CHECK_VERSION(2, 31, 0)
@@ -524,8 +531,10 @@ int main(int argc, char **argv)
     qtest_add_func("/ivshmem/memdev", test_ivshmem_memdev);
     if (g_test_slow()) {
         qtest_add_func("/ivshmem/pair", test_ivshmem_pair);
-        qtest_add_func("/ivshmem/server-msi", test_ivshmem_server_msi);
-        qtest_add_func("/ivshmem/server-irq", test_ivshmem_server_irq);
+        if (strcmp(arch, "ppc64") != 0) {
+            qtest_add_func("/ivshmem/server-msi", test_ivshmem_server_msi);
+            qtest_add_func("/ivshmem/server-irq", test_ivshmem_server_irq);
+        }
     }
 
     ret = g_test_run();
-- 
2.9.3
