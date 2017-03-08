Received: from eggs.gnu.org ([2001:4830:134:3::10]:55136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clSAJ-0007FT-Uo
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:21:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clSAG-000712-Q3
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:21:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clSAG-00070p-GM
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 22:21:24 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82462186883
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 03:21:24 +0000 (UTC)
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f3e9db7e-f3ab-1ae5-4da6-05dbd8d0206f@redhat.com>
Date: Wed, 8 Mar 2017 11:21:08 +0800
MIME-Version: 1.0
In-Reply-To: <313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
Content-Type: multipart/mixed; boundary="------------77D252CA25C77B152E777E6B"
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com

This is a multi-part message in MIME format.
--------------77D252CA25C77B152E777E6B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:55, Paolo Bonzini wrote:
>
> On 07/03/2017 09:47, Jason Wang wrote:
>> We don't destroy region cache during reset which can make the maps
>> of previous driver leaked to a buggy or malicious driver that don't
>> set vring address before starting to use the device.
> I'm still not sure as to how this can happen.  Reset does clear
> desc/used/avail, which should then be checked before accessing the cach=
es.

But the code does not check them in fact? (E.g the attached qtest patch=20
can still pass check-qtest).

Thanks

>
> Paolo
>
>> Fix this by
>> destroy the region cache during reset and validate it before trying to
>> use them. While at it, also validate address_space_cache_init() during
>> virtio_init_region_cache() to make sure we have a correct region
>> cache.


--------------77D252CA25C77B152E777E6B
Content-Type: text/x-patch;
 name="0001-virtio-net-qtest-for-region-cache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-virtio-net-qtest-for-region-cache.patch"

>From 8f588662d439c74e4da3924464167d2be330fd66 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2017 11:19:37 +0800
Subject: [PATCH] virtio-net: qtest for region cache

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/libqos/virtio-pci.c | 21 ++++++++++++++++++---
 tests/libqos/virtio.c     |  8 ++++++++
 tests/libqos/virtio.h     |  6 ++++++
 tests/virtio-net-test.c   |  3 +++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 7ac15c0..6273635 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -222,8 +222,9 @@ static void qvirtio_pci_set_queue_address(QVirtioDevice *d, uint32_t pfn)
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
 }
 
-static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
-                                        QGuestAllocator *alloc, uint16_t index)
+static QVirtQueue *__qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
+                                                 QGuestAllocator *alloc, uint16_t index,
+                                                 bool set_pfn)
 {
     uint32_t feat;
     uint64_t addr;
@@ -254,11 +255,24 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
     addr = guest_alloc(alloc, qvring_size(vqpci->vq.size,
                                           VIRTIO_PCI_VRING_ALIGN));
     qvring_init(alloc, &vqpci->vq, addr);
-    qvirtio_pci_set_queue_address(d, vqpci->vq.desc / VIRTIO_PCI_VRING_ALIGN);
+    if (set_pfn)
+        qvirtio_pci_set_queue_address(d, vqpci->vq.desc / VIRTIO_PCI_VRING_ALIGN);
 
     return &vqpci->vq;
 }
 
+static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
+                                        QGuestAllocator *alloc, uint16_t index)
+{
+    return __qvirtio_pci_virtqueue_setup(d, alloc, index, true);
+}
+
+static QVirtQueue *qvirtio_pci_virtqueue_setup2(QVirtioDevice *d,
+                                        QGuestAllocator *alloc, uint16_t index)
+{
+    return __qvirtio_pci_virtqueue_setup(d, alloc, index, false);
+}
+
 static void qvirtio_pci_virtqueue_cleanup(QVirtQueue *vq,
                                           QGuestAllocator *alloc)
 {
@@ -290,6 +304,7 @@ const QVirtioBus qvirtio_pci = {
     .get_queue_size = qvirtio_pci_get_queue_size,
     .set_queue_address = qvirtio_pci_set_queue_address,
     .virtqueue_setup = qvirtio_pci_virtqueue_setup,
+    .virtqueue_setup2 = qvirtio_pci_virtqueue_setup2,
     .virtqueue_cleanup = qvirtio_pci_virtqueue_cleanup,
     .virtqueue_kick = qvirtio_pci_virtqueue_kick,
 };
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index ec30cb9..def910f 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -49,6 +49,12 @@ QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
     return d->bus->virtqueue_setup(d, alloc, index);
 }
 
+QVirtQueue *qvirtqueue_setup2(QVirtioDevice *d,
+                             QGuestAllocator *alloc, uint16_t index)
+{
+    return d->bus->virtqueue_setup(d, alloc, index);
+}
+
 void qvirtqueue_cleanup(const QVirtioBus *bus, QVirtQueue *vq,
                         QGuestAllocator *alloc)
 {
@@ -77,8 +83,10 @@ void qvirtio_set_driver(QVirtioDevice *d)
 void qvirtio_set_driver_ok(QVirtioDevice *d)
 {
     d->bus->set_status(d, d->bus->get_status(d) | VIRTIO_CONFIG_S_DRIVER_OK);
+    #if 0
     g_assert_cmphex(d->bus->get_status(d), ==, VIRTIO_CONFIG_S_DRIVER_OK |
                     VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE);
+    #endif
 }
 
 void qvirtio_wait_queue_isr(QVirtioDevice *d,
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 3397a08..2c194b9 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -82,6 +82,10 @@ struct QVirtioBus {
     QVirtQueue *(*virtqueue_setup)(QVirtioDevice *d, QGuestAllocator *alloc,
                                                                 uint16_t index);
 
+  /* Setup the virtqueue specified by index */
+    QVirtQueue *(*virtqueue_setup2)(QVirtioDevice *d, QGuestAllocator *alloc,
+                                                                uint16_t index);
+
     /* Free virtqueue resources */
     void (*virtqueue_cleanup)(QVirtQueue *vq, QGuestAllocator *alloc);
 
@@ -123,6 +127,8 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
 void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us);
 QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
                              QGuestAllocator *alloc, uint16_t index);
+QVirtQueue *qvirtqueue_setup2(QVirtioDevice *d,
+			      QGuestAllocator *alloc, uint16_t index);
 void qvirtqueue_cleanup(const QVirtioBus *bus, QVirtQueue *vq,
                         QGuestAllocator *alloc);
 
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 8f94360..df54b19 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -224,6 +224,9 @@ static void pci_basic(gconstpointer data)
 
     rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
     tx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 1);
+    qvirtio_reset(&dev->vdev);
+    rx = (QVirtQueuePCI *)qvirtqueue_setup2(&dev->vdev, qs->alloc, 0);
+    tx = (QVirtQueuePCI *)qvirtqueue_setup2(&dev->vdev, qs->alloc, 1);
 
     driver_init(&dev->vdev);
     func(&dev->vdev, qs->alloc, &rx->vq, &tx->vq, sv[0]);
-- 
2.7.4


--------------77D252CA25C77B152E777E6B--
