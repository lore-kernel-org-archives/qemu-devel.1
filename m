Received: from eggs.gnu.org ([2001:4830:134:3::10]:40006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFl-0001zf-PV
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFi-0007Ac-Kt
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diEFi-0007AE-Bw
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:58 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 08:25:12 +0200
Message-Id: <1502951113-4246-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1502951113-4246-1-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] tests: Add qvirtio_(un)plug_device_test
 wrapper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

To support hot-plugging tests with virtio-ccw later, the current
tests should become independent from PCI specific functions. Thus
let's add some proper wrapper function for virtio device hot-plugging
and -unplugging first.
It also seems like device unplugging works fine on ppc64 when using
the generic qtest_hot_unplug_device() function, so hot-unplugging
is now tested on ppc64, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include  |  4 ++--
 tests/libqos/virtio.c   | 27 +++++++++++++++++++++++++++
 tests/libqos/virtio.h   |  5 +++++
 tests/virtio-net-test.c |  8 ++------
 tests/virtio-rng-test.c |  9 +++------
 5 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ff2a551..e3acdff 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -751,8 +751,8 @@ tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-balloon-test$(EXESUF): tests/virtio-balloon-test.o
 tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virtio-obj-y)
-tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(libqos-virtio-obj-y)
-tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
+tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-virtio-obj-y)
+tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-virtio-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/virtio-9p-test$(EXESUF): tests/virtio-9p-test.o $(libqos-virtio-obj-y)
 tests/virtio-serial-test$(EXESUF): tests/virtio-serial-test.o
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 9880a69..87d2e65 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/virtio.h"
+#include "libqos/pci.h"
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
 
@@ -339,3 +340,29 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
     /* vq->avail->used_event */
     writew(vq->avail + 4 + (2 * vq->size), idx);
 }
+
+void qvirtio_plug_device_test(const char *driver, const char *id,
+                              uint8_t addr, const char *opts)
+{
+    const char *arch = qtest_get_arch();
+
+    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64") ||
+        g_str_equal(arch, "ppc64")) {
+        qpci_plug_device_test(driver, id, addr, opts);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+void qvirtio_unplug_device_test(const char *id, uint8_t addr)
+{
+    const char *arch = qtest_get_arch();
+
+    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
+        qpci_unplug_acpi_device_test(id, addr);
+    } else if (g_str_equal(arch, "ppc64")) {
+        qtest_hot_unplug_device(id);
+    } else {
+        g_assert_not_reached();
+    }
+}
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 8fbcd18..03e33d6 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -143,4 +143,9 @@ void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head);
 bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx);
 
 void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
+
+void qvirtio_plug_device_test(const char *driver, const char *id,
+                              uint8_t addr, const char *opts);
+void qvirtio_unplug_device_test(const char *id, uint8_t addr);
+
 #endif
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 635b942..49e733d 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -241,15 +241,11 @@ static void pci_basic(gconstpointer data)
 
 static void hotplug(void)
 {
-    const char *arch = qtest_get_arch();
-
     qtest_start("-device virtio-net-pci");
 
-    qpci_plug_device_test("virtio-net-pci", "net1", PCI_SLOT_HP, NULL);
+    qvirtio_plug_device_test("virtio-net", "net1", PCI_SLOT_HP, NULL);
 
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qpci_unplug_acpi_device_test("net1", PCI_SLOT_HP);
-    }
+    qvirtio_unplug_device_test("net1", PCI_SLOT_HP);
 
     test_end();
 }
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index dcecf77..04c4279 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/pci.h"
+#include "libqos/virtio.h"
 
 #define PCI_SLOT_HP             0x06
 
@@ -20,13 +21,9 @@ static void pci_nop(void)
 
 static void hotplug(void)
 {
-    const char *arch = qtest_get_arch();
+    qvirtio_plug_device_test("virtio-rng-pci", "rng1", PCI_SLOT_HP, NULL);
 
-    qpci_plug_device_test("virtio-rng-pci", "rng1", PCI_SLOT_HP, NULL);
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qpci_unplug_acpi_device_test("rng1", PCI_SLOT_HP);
-    }
+    qvirtio_unplug_device_test("rng1", PCI_SLOT_HP);
 }
 
 int main(int argc, char **argv)
-- 
1.8.3.1
