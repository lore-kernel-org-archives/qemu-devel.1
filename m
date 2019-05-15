Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA1C04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3E42084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3E42084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40443 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxy5-0005jc-Ea
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:45:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQxwH-0004WX-4E
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQxwF-0004LA-U2
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hQxwF-0004Ku-LV
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03289309264E
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 17:43:35 +0000 (UTC)
Received: from thuth.com (ovpn-117-96.ams2.redhat.com [10.36.117.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B0C553DED;
	Wed, 15 May 2019 17:43:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Wed, 15 May 2019 19:43:23 +0200
Message-Id: <20190515174328.16361-2-thuth@redhat.com>
In-Reply-To: <20190515174328.16361-1-thuth@redhat.com>
References: <20190515174328.16361-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 15 May 2019 17:43:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/6] tests/libqos: Get rid of global_qtest
 dependency in qvring_init()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Library functions should not depend on global_qtest functions like
writew() and writeq(), so that they can also be used in tests that
deal with multiple QTestStates at the same time (like migration tests).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio-mmio.c |  2 +-
 tests/libqos/virtio-pci.c  |  3 ++-
 tests/libqos/virtio.c      | 18 ++++++++++--------
 tests/libqos/virtio.h      |  3 ++-
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 3678c07ef0..213a5f9de0 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -148,7 +148,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirt=
ioDevice *d,
     g_assert_cmpint(vq->size & (vq->size - 1), =3D=3D, 0);
=20
     addr =3D guest_alloc(alloc, qvring_size(vq->size, dev->page_size));
-    qvring_init(alloc, vq, addr);
+    qvring_init(dev->qts, alloc, vq, addr);
     qvirtio_mmio_set_queue_address(d, vq->desc / dev->page_size);
=20
     return vq;
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 993d347830..a622ca26ca 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -199,6 +199,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
     uint32_t feat;
     uint64_t addr;
     QVirtQueuePCI *vqpci;
+    QVirtioPCIDevice *qvpcidev =3D container_of(d, QVirtioPCIDevice, vde=
v);
=20
     vqpci =3D g_malloc0(sizeof(*vqpci));
     feat =3D qvirtio_pci_get_guest_features(d);
@@ -224,7 +225,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
=20
     addr =3D guest_alloc(alloc, qvring_size(vqpci->vq.size,
                                           VIRTIO_PCI_VRING_ALIGN));
-    qvring_init(alloc, &vqpci->vq, addr);
+    qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
     qvirtio_pci_set_queue_address(d, vqpci->vq.desc / VIRTIO_PCI_VRING_A=
LIGN);
=20
     return &vqpci->vq;
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 5e8f39b4d3..b4c01dc0c1 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -162,7 +162,8 @@ void qvirtio_wait_config_isr(QVirtioDevice *d, gint64=
 timeout_us)
     }
 }
=20
-void qvring_init(const QGuestAllocator *alloc, QVirtQueue *vq, uint64_t =
addr)
+void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQue=
ue *vq,
+                 uint64_t addr)
 {
     int i;
=20
@@ -173,22 +174,23 @@ void qvring_init(const QGuestAllocator *alloc, QVir=
tQueue *vq, uint64_t addr)
=20
     for (i =3D 0; i < vq->size - 1; i++) {
         /* vq->desc[i].addr */
-        writeq(vq->desc + (16 * i), 0);
+        qtest_writeq(qts, vq->desc + (16 * i), 0);
         /* vq->desc[i].next */
-        writew(vq->desc + (16 * i) + 14, i + 1);
+        qtest_writew(qts, vq->desc + (16 * i) + 14, i + 1);
     }
=20
     /* vq->avail->flags */
-    writew(vq->avail, 0);
+    qtest_writew(qts, vq->avail, 0);
     /* vq->avail->idx */
-    writew(vq->avail + 2, 0);
+    qtest_writew(qts, vq->avail + 2, 0);
     /* vq->avail->used_event */
-    writew(vq->avail + 4 + (2 * vq->size), 0);
+    qtest_writew(qts, vq->avail + 4 + (2 * vq->size), 0);
=20
     /* vq->used->flags */
-    writew(vq->used, 0);
+    qtest_writew(qts, vq->used, 0);
     /* vq->used->avail_event */
-    writew(vq->used + 2 + sizeof(struct vring_used_elem) * vq->size, 0);
+    qtest_writew(qts, vq->used + 2 + sizeof(struct vring_used_elem) * vq=
->size,
+                 0);
 }
=20
 QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 51d2359ace..7b97f5e567 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -129,7 +129,8 @@ QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
 void qvirtqueue_cleanup(const QVirtioBus *bus, QVirtQueue *vq,
                         QGuestAllocator *alloc);
=20
-void qvring_init(const QGuestAllocator *alloc, QVirtQueue *vq, uint64_t =
addr);
+void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQue=
ue *vq,
+                 uint64_t addr);
 QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
                                         QGuestAllocator *alloc, uint16_t=
 elem);
 void qvring_indirect_desc_add(QVRingIndirectDesc *indirect, uint64_t dat=
a,
--=20
2.21.0


