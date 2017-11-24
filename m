Received: from eggs.gnu.org ([2001:4830:134:3::10]:38293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eI8q7-0000dh-2W
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eI8q6-0006XJ-28
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:55:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eI8q5-0006X0-SJ
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:55:57 -0500
From: P J P <ppandit@redhat.com>
Date: Fri, 24 Nov 2017 13:25:42 +0530
Message-Id: <20171124075542.16979-3-ppandit@redhat.com>
In-Reply-To: <20171124075542.16979-1-ppandit@redhat.com>
References: <20171124075542.16979-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/2] tests: add test to check VirtQueue
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

An uninitialised VirtQueue object or one with Vring.align field
set to zero(0) could lead to arithmetic exceptions. Add a unit
test to validate it.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 tests/virtio-blk-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index e6fb9bac87..d00ceb0501 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -674,6 +674,26 @@ static void pci_hotplug(void)
     qtest_shutdown(qs);
 }
 
+static void test_vring_align(void)
+{
+    QPCIBar bar0;
+    QOSState *qs;
+    QPCIDevice *dev;
+
+    qs = pci_test_start();
+    dev = qpci_device_find(qs->pcibus, QPCI_DEVFN(4, 0));
+    g_assert(dev != NULL);
+
+    qpci_device_enable(dev);
+    bar0 = qpci_iomap(dev, 0, NULL);
+
+    qpci_io_writeb(dev, bar0, VIRTIO_PCI_QUEUE_SEL, 2);
+    qpci_io_writel(dev, bar0, VIRTIO_PCI_QUEUE_PFN, 1);
+
+    g_free(dev);
+    qtest_shutdown(qs);
+}
+
 static void mmio_basic(void)
 {
     QVirtioMMIODevice *dev;
@@ -724,6 +744,7 @@ int main(int argc, char **argv)
         qtest_add_func("/virtio/blk/pci/basic", pci_basic);
         qtest_add_func("/virtio/blk/pci/indirect", pci_indirect);
         qtest_add_func("/virtio/blk/pci/config", pci_config);
+        qtest_add_func("/virtio/blk/pci/vring", test_vring_align);
         if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
             qtest_add_func("/virtio/blk/pci/msix", pci_msix);
             qtest_add_func("/virtio/blk/pci/idx", pci_idx);
-- 
2.13.6
