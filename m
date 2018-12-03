Received: from eggs.gnu.org ([2001:4830:134:3::10]:52530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFy-00026z-SU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFx-0006FS-OX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFx-0006Em-GN
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:11 +0100
Message-Id: <1543851204-41186-59-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 58/71] tests: move virtio entirely to qos-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

The only remaining test that needs libqos-virtio-obj-y is drive_del-test,
which really only needs a function.  Move that function to the test
and remove libqos-virtio-obj-y.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  9 ++++-----
 tests/drive_del-test.c | 25 +++++++++++++++++++------
 tests/libqos/virtio.c  | 18 ------------------
 tests/libqos/virtio.h  |  1 -
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 34d1e5f..c0b370b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -151,7 +151,6 @@ check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
 check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
 check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
-check-qtest-pci-y += $(check-qtest-virtio-y)
 check-qtest-pci-$(CONFIG_IPACK) += tests/tpci200-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
 check-qtest-pci-y += tests/display-vga-test$(EXESUF)
@@ -234,7 +233,6 @@ check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
-check-qtest-ppc64-y += $(check-qtest-virtio-y)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
@@ -654,18 +652,19 @@ libqos-pc-obj-y += tests/libqos/ahci.o
 libqos-omap-obj-y = $(libqos-obj-y) tests/libqos/i2c-omap.o
 libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
 libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
-libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o
 
 # Devices
 qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/e1000e.o
 qos-test-obj-y += tests/libqos/sdhci.o
-qos-test-obj-y += $(libqos-virtio-obj-y)
+qos-test-obj-y += tests/libqos/virtio.o
 qos-test-obj-y += tests/libqos/virtio-9p.o
 qos-test-obj-y += tests/libqos/virtio-balloon.o
 qos-test-obj-y += tests/libqos/virtio-blk.o
+qos-test-obj-y += tests/libqos/virtio-mmio.o
 qos-test-obj-y += tests/libqos/virtio-net.o
+qos-test-obj-y += tests/libqos/virtio-pci.o
 qos-test-obj-y += tests/libqos/virtio-rng.o
 qos-test-obj-y += tests/libqos/virtio-scsi.o
 qos-test-obj-y += tests/libqos/virtio-serial.o
@@ -743,7 +742,7 @@ tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
-tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
+tests/drive_del-test$(EXESUF): tests/drive_del-test.o
 tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 4a1a088..2f9474e 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -63,6 +63,24 @@ static void test_drive_without_dev(void)
     qtest_end();
 }
 
+/*
+ * qvirtio_get_dev_type:
+ * Returns: the preferred virtio bus/device type for the current architecture.
+ * TODO: delete this
+ */
+static const char *qvirtio_get_dev_type(void)
+{
+    const char *arch = qtest_get_arch();
+
+    if (g_str_equal(arch, "arm") || g_str_equal(arch, "aarch64")) {
+        return "device";  /* for virtio-mmio */
+    } else if (g_str_equal(arch, "s390x")) {
+        return "ccw";
+    } else {
+        return "pci";
+    }
+}
+
 static void test_after_failed_device_add(void)
 {
     char driver[32];
@@ -119,16 +137,11 @@ static void test_drive_del_device_del(void)
 
 int main(int argc, char **argv)
 {
-    const char *arch = qtest_get_arch();
-
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/drive_del/without-dev", test_drive_without_dev);
 
-    /* TODO I guess any arch with a hot-pluggable virtio bus would do */
-    if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64") ||
-        !strcmp(arch, "ppc") || !strcmp(arch, "ppc64") ||
-        !strcmp(arch, "s390x")) {
+    if (qvirtio_get_dev_type() != NULL) {
         qtest_add_func("/drive_del/after_failed_device_add",
                        test_after_failed_device_add);
         qtest_add_func("/blockdev/drive_del_device_del",
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index e4925d1..5e8f39b 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -350,24 +350,6 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
     writew(vq->avail + 4 + (2 * vq->size), idx);
 }
 
-/*
- * qvirtio_get_dev_type:
- * Returns: the preferred virtio bus/device type for the current architecture.
- * TODO: delete this
- */
-const char *qvirtio_get_dev_type(void)
-{
-    const char *arch = qtest_get_arch();
-
-    if (g_str_equal(arch, "arm") || g_str_equal(arch, "aarch64")) {
-        return "device";  /* for virtio-mmio */
-    } else if (g_str_equal(arch, "s390x")) {
-        return "ccw";
-    } else {
-        return "pci";
-    }
-}
-
 void qvirtio_start_device(QVirtioDevice *vdev)
 {
     qvirtio_reset(vdev);
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 3f97d79..51d2359 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -142,7 +142,6 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx, uint32_t *len);
 
 void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
 
-const char *qvirtio_get_dev_type(void);
 void qvirtio_start_device(QVirtioDevice *vdev);
 
 #endif
-- 
1.8.3.1
