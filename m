Received: from eggs.gnu.org ([209.51.188.92]:39528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqp-0003Fn-Mu
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqn-000873-Pu
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wql-00085D-VE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:33 -0500
Received: by mail-wm1-x32b.google.com with SMTP id e74so10067355wmg.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:29 +0100
Message-Id: <1551979804-6060-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/57] tests/libqos: remove global_qtest from
 virtio endianness checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lviver@redhat.com

This is needed to support migration tests with qgraph.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/virtio-pci.c | 11 ++++++++++-
 tests/libqos/virtio.c     |  5 +++++
 tests/libqos/virtio.h     |  8 ++------
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 6bcdbbb..0b58b74 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -43,6 +43,14 @@ typedef struct QVirtioPCIForeachData {
     void *user_data;
 } QVirtioPCIForeachData;
 
+static inline bool qvirtio_pci_is_big_endian(QVirtioPCIDevice *dev)
+{
+    QPCIBus *bus = dev->pdev->bus;
+
+    /* FIXME: virtio 1.0 is always little-endian */
+    return qtest_big_endian(bus->qts);
+}
+
 void qvirtio_pci_device_free(QVirtioPCIDevice *dev)
 {
     g_free(dev->pdev);
@@ -56,6 +64,7 @@ static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevice *pci_
     dev->config_msix_entry = -1;
 
     dev->vdev.bus = &qvirtio_pci;
+    dev->vdev.big_endian = qvirtio_pci_is_big_endian(dev);
 
     /* each virtio-xxx-pci device should override at least this function */
     dev->obj.get_driver = NULL;
@@ -99,7 +108,7 @@ static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
  * so with a big-endian guest the order has been reversed,
  * reverse it again
  * virtio-1.0 is always little-endian, like PCI, but this
- * case will be managed inside qvirtio_is_big_endian()
+ * case will be managed inside qvirtio_pci_is_big_endian()
  */
 
 static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index c1ff020..5a62950 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -372,3 +372,8 @@ void qvirtio_start_device(QVirtioDevice *vdev)
     qvirtio_set_acknowledge(vdev);
     qvirtio_set_driver(vdev);
 }
+
+bool qvirtio_is_big_endian(QVirtioDevice *d)
+{
+    return d->big_endian;
+}
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 2c68668..7f0f9dd 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -21,6 +21,7 @@ typedef struct QVirtioDevice {
     const QVirtioBus *bus;
     /* Device type */
     uint16_t device_type;
+    bool big_endian;
 } QVirtioDevice;
 
 typedef struct QVirtQueue {
@@ -90,12 +91,6 @@ struct QVirtioBus {
     void (*virtqueue_kick)(QVirtioDevice *d, QVirtQueue *vq);
 };
 
-static inline bool qvirtio_is_big_endian(QVirtioDevice *d)
-{
-    /* FIXME: virtio 1.0 is always little-endian */
-    return qtest_big_endian(global_qtest);
-}
-
 static inline uint32_t qvring_size(uint32_t num, uint32_t align)
 {
     return ((sizeof(struct vring_desc) * num + sizeof(uint16_t) * (3 + num)
@@ -109,6 +104,7 @@ uint32_t qvirtio_config_readl(QVirtioDevice *d, uint64_t addr);
 uint64_t qvirtio_config_readq(QVirtioDevice *d, uint64_t addr);
 uint32_t qvirtio_get_features(QVirtioDevice *d);
 void qvirtio_set_features(QVirtioDevice *d, uint32_t features);
+bool qvirtio_is_big_endian(QVirtioDevice *d);
 
 void qvirtio_reset(QVirtioDevice *d);
 void qvirtio_set_acknowledge(QVirtioDevice *d);
-- 
1.8.3.1
