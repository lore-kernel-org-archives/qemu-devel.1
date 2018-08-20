Received: from eggs.gnu.org ([2001:4830:134:3::10]:32825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritQ-0005xD-LR
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritN-0002ZZ-AI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:43 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:08 +0200
Message-Id: <20180820120213.11095-12-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 11/16] test/qgraph: spapr-phb test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Keith Busch <keith.busch@intel.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/spapr-phb-test in qgraph test node,
spapr-phb-test. This test adds another
spapr-pci-host-bridge device in the
ppc64/pseries machine

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |  3 +--
 tests/spapr-phb-test.c | 28 +++++++++++-----------------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1a2b645209..5b006b85d1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -326,7 +326,6 @@ gcov-files-ppc-y += hw/timer/m48t59.c
 
 check-qtest-ppc64-y = $(check-qtest-ppc-y)
 gcov-files-ppc64-y = $(subst ppc-softmmu/,ppc64-softmmu/,$(gcov-files-ppc-y))
-check-qtest-ppc64-y += tests/spapr-phb-test$(EXESUF)
 gcov-files-ppc64-y += ppc64-softmmu/hw/ppc/spapr_pci.c
 check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
@@ -793,6 +792,7 @@ libqgraph-tests-obj-y += tests/ipoctal232-test.o
 libqgraph-tests-obj-y += tests/ne2000-test.o
 libqgraph-tests-obj-y += tests/nvme-test.o
 libqgraph-tests-obj-y += tests/pcnet-test.o
+libqgraph-tests-obj-y += tests/spapr-phb-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -805,7 +805,6 @@ tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
 tests/rtc-test$(EXESUF): tests/rtc-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
 tests/endianness-test$(EXESUF): tests/endianness-test.o
-tests/spapr-phb-test$(EXESUF): tests/spapr-phb-test.o $(libqos-obj-y)
 tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
 tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
 tests/fdc-test$(EXESUF): tests/fdc-test.o
diff --git a/tests/spapr-phb-test.c b/tests/spapr-phb-test.c
index d3522ea093..5b754b777c 100644
--- a/tests/spapr-phb-test.c
+++ b/tests/spapr-phb-test.c
@@ -7,29 +7,23 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
-#include "qemu/osdep.h"
 
+#include "qemu/osdep.h"
 #include "libqtest.h"
-
-#define TYPE_SPAPR_PCI_HOST_BRIDGE "spapr-pci-host-bridge"
+#include "libqos/qgraph.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void test_phb_device(void)
+static void test_phb_device(void *obj, void *data, QGuestAllocator *alloc)
 {
 }
 
-int main(int argc, char **argv)
+static void register_phb_test(void)
 {
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/spapr-phb/device", test_phb_device);
-
-    qtest_start("-device " TYPE_SPAPR_PCI_HOST_BRIDGE ",index=30");
-
-    ret = g_test_run();
-
-    qtest_end();
-
-    return ret;
+    qos_add_test("spapr-phb-test", "ppc64/pseries",
+                 test_phb_device, &(QOSGraphTestOptions) {
+                     .edge.before_cmd_line = "-device spapr-pci-host-bridge"
+                                             ",index=30",
+                 });
 }
+
+libqos_init(register_phb_test);
-- 
2.17.1
