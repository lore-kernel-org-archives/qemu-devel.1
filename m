Received: from eggs.gnu.org ([2001:4830:134:3::10]:52506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFv-00023P-17
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFq-000690-6i
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFp-00068I-V5
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:26 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:09 +0100
Message-Id: <1543851204-41186-57-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 56/71] qos-test: virtio-scsi test node
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

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/virtio-scsi-test in qgraph test node,
virtio-scsi-test. This test consumes a virtio-scsi interface
and checks that its function return the expected values.

Some functions are implemented only for virtio-scsi-pci, so they
don't consume virtio-scsi, but virtio-scsi-pci

Note that this test does not allocate any virtio-scsi structure,
it's all done by the qtest walking graph mechanism

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include   |   4 +-
 tests/virtio-scsi-test.c | 143 +++++++++++++++++++----------------------------
 2 files changed, 60 insertions(+), 87 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3d58798..34d1e5f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -143,8 +143,6 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
-check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
-
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
@@ -692,6 +690,7 @@ qos-test-obj-y += tests/virtio-9p-test.o
 qos-test-obj-y += tests/virtio-blk-test.o
 qos-test-obj-y += tests/virtio-net-test.o
 qos-test-obj-y += tests/virtio-rng-test.o
+qos-test-obj-y += tests/virtio-scsi-test.o
 qos-test-obj-y += tests/virtio-serial-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
@@ -738,7 +737,6 @@ tests/ne2000-test$(EXESUF): tests/ne2000-test.o
 tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test.o
 tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
 tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
-tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 9298aa8..162b31c 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -18,6 +18,8 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_scsi.h"
+#include "libqos/virtio-scsi.h"
+#include "libqos/qgraph.h"
 
 #define PCI_SLOT                0x02
 #define PCI_FN                  0x00
@@ -27,55 +29,28 @@
 
 typedef struct {
     QVirtioDevice *dev;
-    QOSState *qs;
     int num_queues;
     QVirtQueue *vq[MAX_NUM_QUEUES + 2];
-} QVirtIOSCSI;
+} QVirtioSCSIQueues;
 
-static QOSState *qvirtio_scsi_start(const char *extra_opts)
-{
-    QOSState *qs;
-    const char *arch = qtest_get_arch();
-    const char *cmd = "-drive id=drv0,if=none,file=null-co://,format=raw "
-                      "-device virtio-scsi-pci,id=vs0 "
-                      "-device scsi-hd,bus=vs0.0,drive=drv0 %s";
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qs = qtest_pc_boot(cmd, extra_opts ? : "");
-    } else if (strcmp(arch, "ppc64") == 0) {
-        qs = qtest_spapr_boot(cmd, extra_opts ? : "");
-    } else {
-        g_printerr("virtio-scsi tests are only available on x86 or ppc64\n");
-        exit(EXIT_FAILURE);
-    }
-    global_qtest = qs->qts;
-    return qs;
-}
-
-static void qvirtio_scsi_stop(QOSState *qs)
-{
-    qtest_shutdown(qs);
-}
+static QGuestAllocator *alloc;
 
-static void qvirtio_scsi_pci_free(QVirtIOSCSI *vs)
+static void qvirtio_scsi_pci_free(QVirtioSCSIQueues *vs)
 {
     int i;
 
     for (i = 0; i < vs->num_queues + 2; i++) {
-        qvirtqueue_cleanup(vs->dev->bus, vs->vq[i], &vs->qs->alloc);
+        qvirtqueue_cleanup(vs->dev->bus, vs->vq[i], alloc);
     }
-    qvirtio_pci_device_disable(container_of(vs->dev, QVirtioPCIDevice, vdev));
-    qvirtio_pci_device_free((QVirtioPCIDevice *)vs->dev);
-    qvirtio_scsi_stop(vs->qs);
     g_free(vs);
 }
 
-static uint64_t qvirtio_scsi_alloc(QVirtIOSCSI *vs, size_t alloc_size,
+static uint64_t qvirtio_scsi_alloc(QVirtioSCSIQueues *vs, size_t alloc_size,
                                    const void *data)
 {
     uint64_t addr;
 
-    addr = guest_alloc(&vs->qs->alloc, alloc_size);
+    addr = guest_alloc(alloc, alloc_size);
     if (data) {
         memwrite(addr, data, alloc_size);
     }
@@ -83,7 +58,8 @@ static uint64_t qvirtio_scsi_alloc(QVirtIOSCSI *vs, size_t alloc_size,
     return addr;
 }
 
-static uint8_t virtio_scsi_do_command(QVirtIOSCSI *vs, const uint8_t *cdb,
+static uint8_t virtio_scsi_do_command(QVirtioSCSIQueues *vs,
+                                      const uint8_t *cdb,
                                       const uint8_t *data_in,
                                       size_t data_in_len,
                                       uint8_t *data_out, size_t data_out_len,
@@ -133,40 +109,28 @@ static uint8_t virtio_scsi_do_command(QVirtIOSCSI *vs, const uint8_t *cdb,
         memread(resp_addr, resp_out, sizeof(*resp_out));
     }
 
-    guest_free(&vs->qs->alloc, req_addr);
-    guest_free(&vs->qs->alloc, resp_addr);
-    guest_free(&vs->qs->alloc, data_in_addr);
-    guest_free(&vs->qs->alloc, data_out_addr);
+    guest_free(alloc, req_addr);
+    guest_free(alloc, resp_addr);
+    guest_free(alloc, data_in_addr);
+    guest_free(alloc, data_out_addr);
     return response;
 }
 
-static QVirtIOSCSI *qvirtio_scsi_pci_init(int slot)
+static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev)
 {
+    QVirtioSCSIQueues *vs;
     const uint8_t test_unit_ready_cdb[VIRTIO_SCSI_CDB_SIZE] = {};
-    QVirtIOSCSI *vs;
-    QVirtioPCIDevice *dev;
     struct virtio_scsi_cmd_resp resp;
     int i;
 
-    vs = g_new0(QVirtIOSCSI, 1);
-
-    vs->qs = qvirtio_scsi_start("-drive file=blkdebug::null-co://,"
-                                "if=none,id=dr1,format=raw,file.align=4k "
-                                "-device scsi-hd,drive=dr1,lun=0,scsi-id=1");
-    dev = qvirtio_pci_device_find(vs->qs->pcibus, VIRTIO_ID_SCSI);
-    vs->dev = (QVirtioDevice *)dev;
-    g_assert(dev != NULL);
-    g_assert_cmphex(vs->dev->device_type, ==, VIRTIO_ID_SCSI);
-
-    qvirtio_pci_device_enable(dev);
-    qvirtio_start_device(vs->dev);
-
-    vs->num_queues = qvirtio_config_readl(vs->dev, 0);
+    vs = g_new0(QVirtioSCSIQueues, 1);
+    vs->dev = dev;
+    vs->num_queues = qvirtio_config_readl(dev, 0);
 
     g_assert_cmpint(vs->num_queues, <, MAX_NUM_QUEUES);
 
     for (i = 0; i < vs->num_queues + 2; i++) {
-        vs->vq[i] = qvirtqueue_setup(vs->dev, &vs->qs->alloc, i);
+        vs->vq[i] = qvirtqueue_setup(dev, alloc, i);
     }
 
     /* Clear the POWER ON OCCURRED unit attention */
@@ -182,30 +146,18 @@ static QVirtIOSCSI *qvirtio_scsi_pci_init(int slot)
     return vs;
 }
 
-/* Tests only initialization so far. TODO: Replace with functional tests */
-static void pci_nop(void)
-{
-    QOSState *qs;
-
-    qs = qvirtio_scsi_start(NULL);
-    qvirtio_scsi_stop(qs);
-}
-
-static void hotplug(void)
+static void hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
-    QOSState *qs;
-
-    qs = qvirtio_scsi_start(
-            "-drive id=drv1,if=none,file=null-co://,format=raw");
     qtest_qmp_device_add("scsi-hd", "scsihd", "{'drive': 'drv1'}");
     qtest_qmp_device_del("scsihd");
-    qvirtio_scsi_stop(qs);
 }
 
 /* Test WRITE SAME with the lba not aligned */
-static void test_unaligned_write_same(void)
+static void test_unaligned_write_same(void *obj, void *data,
+                                      QGuestAllocator *t_alloc)
 {
-    QVirtIOSCSI *vs;
+    QVirtioSCSI *scsi = obj;
+    QVirtioSCSIQueues *vs;
     uint8_t buf1[512] = { 0 };
     uint8_t buf2[512] = { 1 };
     const uint8_t write_same_cdb_1[VIRTIO_SCSI_CDB_SIZE] = {
@@ -218,27 +170,50 @@ static void test_unaligned_write_same(void)
         0x41, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x33, 0x00, 0x00
     };
 
-    vs = qvirtio_scsi_pci_init(PCI_SLOT);
+    alloc = t_alloc;
+    vs = qvirtio_scsi_init(scsi->vdev);
 
     g_assert_cmphex(0, ==,
-        virtio_scsi_do_command(vs, write_same_cdb_1, NULL, 0, buf1, 512, NULL));
+        virtio_scsi_do_command(vs, write_same_cdb_1, NULL, 0, buf1, 512,
+                               NULL));
 
     g_assert_cmphex(0, ==,
-        virtio_scsi_do_command(vs, write_same_cdb_2, NULL, 0, buf2, 512, NULL));
+        virtio_scsi_do_command(vs, write_same_cdb_2, NULL, 0, buf2, 512,
+                               NULL));
 
     g_assert_cmphex(0, ==,
-        virtio_scsi_do_command(vs, write_same_cdb_ndob, NULL, 0, NULL, 0, NULL));
+        virtio_scsi_do_command(vs, write_same_cdb_ndob, NULL, 0, NULL, 0,
+                               NULL));
 
     qvirtio_scsi_pci_free(vs);
 }
 
-int main(int argc, char **argv)
+static void *virtio_scsi_hotplug_setup(GString *cmd_line, void *arg)
 {
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/scsi/pci/nop", pci_nop);
-    qtest_add_func("/virtio/scsi/pci/hotplug", hotplug);
-    qtest_add_func("/virtio/scsi/pci/scsi-disk/unaligned-write-same",
-                   test_unaligned_write_same);
+    g_string_append(cmd_line,
+                    " -drive id=drv1,if=none,file=null-co://,format=raw");
+    return arg;
+}
 
-    return g_test_run();
+static void *virtio_scsi_setup(GString *cmd_line, void *arg)
+{
+    g_string_append(cmd_line,
+                    " -drive file=blkdebug::null-co://,"
+                    "if=none,id=dr1,format=raw,file.align=4k "
+                    "-device scsi-hd,drive=dr1,lun=0,scsi-id=1");
+    return arg;
 }
+
+static void register_virtio_scsi_test(void)
+{
+    QOSGraphTestOptions opts = { };
+
+    opts.before = virtio_scsi_hotplug_setup;
+    qos_add_test("hotplug", "virtio-scsi", hotplug, &opts);
+
+    opts.before = virtio_scsi_setup;
+    qos_add_test("unaligned-write-same", "virtio-scsi",
+                 test_unaligned_write_same, &opts);
+}
+
+libqos_init(register_virtio_scsi_test);
-- 
1.8.3.1
