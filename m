Received: from eggs.gnu.org ([2001:4830:134:3::10]:45327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pd-00072C-SI
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pc-00050t-Qw
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:21 -0500
Date: Thu, 21 Dec 2017 16:28:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-5-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 04/25] tests: add test to check VirtQueue object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

From: Prasad J Pandit <pjp@fedoraproject.org>

An uninitialised VirtQueue object or one with Vring.align field
set to zero(0) could lead to arithmetic exceptions. Add a unit
test to validate it.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-blk-test.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index e6fb9ba..45f368d 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -674,6 +674,30 @@ static void pci_hotplug(void)
     qtest_shutdown(qs);
 }
 
+/*
+ * Check that setting the vring addr on a non-existent virtqueue does
+ * not crash.
+ */
+static void test_nonexistent_virtqueue(void)
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
@@ -724,6 +748,7 @@ int main(int argc, char **argv)
         qtest_add_func("/virtio/blk/pci/basic", pci_basic);
         qtest_add_func("/virtio/blk/pci/indirect", pci_indirect);
         qtest_add_func("/virtio/blk/pci/config", pci_config);
+        qtest_add_func("/virtio/blk/pci/nxvirtq", test_nonexistent_virtqueue);
         if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
             qtest_add_func("/virtio/blk/pci/msix", pci_msix);
             qtest_add_func("/virtio/blk/pci/idx", pci_idx);
-- 
MST
