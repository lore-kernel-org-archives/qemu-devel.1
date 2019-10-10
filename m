Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83466C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4865421835
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4865421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIb1i-00059C-FO
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIaqs-00062b-4H
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIaqo-0003Pm-Sv
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iIaqo-0003PN-KD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBF893090FD1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:59:37 +0000 (UTC)
Received: from localhost (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 133C0600C4;
 Thu, 10 Oct 2019 15:59:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] libqos: add VIRTIO PCI 1.0 support
Date: Thu, 10 Oct 2019 16:58:53 +0100
Message-Id: <20191010155853.4325-8-stefanha@redhat.com>
In-Reply-To: <20191010155853.4325-1-stefanha@redhat.com>
References: <20191010155853.4325-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 10 Oct 2019 15:59:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement the VIRTIO 1.0 virtio-pci interface.  The main change here is
that the register layout is no longer a fixed layout in BAR 0.  Instead
we have to iterate of PCI Capabilities to find descriptions of where
various registers are located.  The vring registers are also more
fine-grained, allowing for more flexible vring layouts, but we don't
take advantage of that.

Note that test cases do not negotiate VIRTIO_F_VERSION_1 yet and are
therefore not running in VIRTIO 1.0 mode.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/Makefile.include           |   1 +
 tests/libqos/virtio-pci-modern.h |  17 ++
 tests/libqos/virtio-pci.h        |  10 +
 tests/libqos/virtio-pci-modern.c | 405 +++++++++++++++++++++++++++++++
 tests/libqos/virtio-pci.c        |   6 +-
 5 files changed, 438 insertions(+), 1 deletion(-)
 create mode 100644 tests/libqos/virtio-pci-modern.h
 create mode 100644 tests/libqos/virtio-pci-modern.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451ed3..3f633c8313 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -715,6 +715,7 @@ qos-test-obj-y +=3D tests/libqos/virtio-blk.o
 qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
 qos-test-obj-y +=3D tests/libqos/virtio-net.o
 qos-test-obj-y +=3D tests/libqos/virtio-pci.o
+qos-test-obj-y +=3D tests/libqos/virtio-pci-modern.o
 qos-test-obj-y +=3D tests/libqos/virtio-rng.o
 qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
 qos-test-obj-y +=3D tests/libqos/virtio-serial.o
diff --git a/tests/libqos/virtio-pci-modern.h b/tests/libqos/virtio-pci-m=
odern.h
new file mode 100644
index 0000000000..6bf2b207c3
--- /dev/null
+++ b/tests/libqos/virtio-pci-modern.h
@@ -0,0 +1,17 @@
+/*
+ * libqos virtio PCI VIRTIO 1.0 definitions
+ *
+ * Copyright (c) 2019 Red Hat, Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef LIBQOS_VIRTIO_PCI_MODERN_H
+#define LIBQOS_VIRTIO_PCI_MODERN_H
+
+#include "virtio-pci.h"
+
+bool qvirtio_pci_init_virtio_1(QVirtioPCIDevice *dev);
+
+#endif /* LIBQOS_VIRTIO_PCI_MODERN_H */
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index f2d53aa377..29d4e9bf79 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -27,6 +27,13 @@ typedef struct QVirtioPCIDevice {
     uint32_t config_msix_data;
=20
     uint8_t bar_idx;
+
+    /* VIRTIO 1.0 */
+    uint32_t common_cfg_offset;
+    uint32_t notify_cfg_offset;
+    uint32_t notify_off_multiplier;
+    uint32_t isr_cfg_offset;
+    uint32_t device_cfg_offset;
 } QVirtioPCIDevice;
=20
 struct QVirtioPCIMSIXOps {
@@ -43,6 +50,9 @@ typedef struct QVirtQueuePCI {
     uint16_t msix_entry;
     uint64_t msix_addr;
     uint32_t msix_data;
+
+    /* VIRTIO 1.0 */
+    uint64_t notify_offset;
 } QVirtQueuePCI;
=20
 void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * =
addr);
diff --git a/tests/libqos/virtio-pci-modern.c b/tests/libqos/virtio-pci-m=
odern.c
new file mode 100644
index 0000000000..d4f0e22822
--- /dev/null
+++ b/tests/libqos/virtio-pci-modern.c
@@ -0,0 +1,405 @@
+/*
+ * libqos VIRTIO 1.0 PCI driver
+ *
+ * Copyright (c) 2019 Red Hat, Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "standard-headers/linux/pci_regs.h"
+#include "standard-headers/linux/virtio_pci.h"
+#include "virtio-pci-modern.h"
+
+static uint8_t config_readb(QVirtioDevice *d, uint64_t addr)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    return qpci_io_readb(dev->pdev, dev->bar, dev->device_cfg_offset + a=
ddr);
+}
+
+static uint16_t config_readw(QVirtioDevice *d, uint64_t addr)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    return qpci_io_readw(dev->pdev, dev->bar, dev->device_cfg_offset + a=
ddr);
+}
+
+static uint32_t config_readl(QVirtioDevice *d, uint64_t addr)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    return qpci_io_readl(dev->pdev, dev->bar, dev->device_cfg_offset + a=
ddr);
+}
+
+static uint64_t config_readq(QVirtioDevice *d, uint64_t addr)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    return qpci_io_readq(dev->pdev, dev->bar, dev->device_cfg_offset + a=
ddr);
+}
+
+static uint32_t get_features(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            device_feature_select),
+                   0);
+    return qpci_io_readl(dev->pdev, dev->bar, dev->common_cfg_offset +
+                         offsetof(struct virtio_pci_common_cfg,
+                                  device_feature));
+}
+
+static void set_features(QVirtioDevice *d, uint32_t features)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature_select),
+                   0);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature),
+                   features);
+}
+
+static uint32_t get_guest_features(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg,
+                            guest_feature_select),
+                   0);
+    return qpci_io_readl(dev->pdev, dev->bar, dev->common_cfg_offset +
+                         offsetof(struct virtio_pci_common_cfg,
+                                  guest_feature));
+}
+
+static uint8_t get_status(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    return qpci_io_readb(dev->pdev, dev->bar, dev->common_cfg_offset +
+                         offsetof(struct virtio_pci_common_cfg,
+                                  device_status));
+}
+
+static void set_status(QVirtioDevice *d, uint8_t status)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    return qpci_io_writeb(dev->pdev, dev->bar, dev->common_cfg_offset +
+                          offsetof(struct virtio_pci_common_cfg,
+                                   device_status),
+                          status);
+}
+
+static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
+                            uint32_t msix_addr, uint32_t msix_data)
+{
+    uint32_t data;
+
+    g_assert_cmpint(msix_entry, !=3D, -1);
+    if (qpci_msix_masked(dev->pdev, msix_entry)) {
+        /* No ISR checking should be done if masked, but read anyway */
+        return qpci_msix_pending(dev->pdev, msix_entry);
+    }
+
+    data =3D qtest_readl(dev->pdev->bus->qts, msix_addr);
+    if (data =3D=3D msix_data) {
+        qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
+        return true;
+    } else {
+        return false;
+    }
+}
+
+static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    if (dev->pdev->msix_enabled) {
+        QVirtQueuePCI *vqpci =3D container_of(vq, QVirtQueuePCI, vq);
+
+        return get_msix_status(dev, vqpci->msix_entry, vqpci->msix_addr,
+                               vqpci->msix_data);
+    }
+
+    return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 1;
+}
+
+static bool get_config_isr_status(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    if (dev->pdev->msix_enabled) {
+        return get_msix_status(dev, dev->config_msix_entry,
+                               dev->config_msix_addr, dev->config_msix_d=
ata);
+    }
+
+    return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 2;
+}
+
+static void wait_config_isr_status(QVirtioDevice *d, gint64 timeout_us)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    gint64 start_time =3D g_get_monotonic_time();
+
+    do {
+        g_assert(g_get_monotonic_time() - start_time <=3D timeout_us);
+        qtest_clock_step(dev->pdev->bus->qts, 100);
+    } while (!get_config_isr_status(d));
+}
+
+static void queue_select(QVirtioDevice *d, uint16_t index)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    qpci_io_writew(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_select),
+                   index);
+}
+
+static uint16_t get_queue_size(QVirtioDevice *d)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    return qpci_io_readw(dev->pdev, dev->bar, dev->common_cfg_offset +
+                         offsetof(struct virtio_pci_common_cfg, queue_si=
ze));
+}
+
+static void set_queue_address(QVirtioDevice *d, QVirtQueue *vq)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_desc_lo)=
,
+                   vq->desc);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_desc_hi)=
,
+                   vq->desc >> 32);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_avail_lo=
),
+                   vq->avail);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_avail_hi=
),
+                   vq->avail >> 32);
+
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_used_lo)=
,
+                   vq->used);
+    qpci_io_writel(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_used_hi)=
,
+                   vq->used >> 32);
+}
+
+static QVirtQueue *virtqueue_setup(QVirtioDevice *d, QGuestAllocator *al=
loc, uint16_t index)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    QVirtQueue *vq;
+    QVirtQueuePCI *vqpci;
+    uint16_t notify_off;
+
+    vq =3D qvirtio_pci_virtqueue_setup_common(d, alloc, index);
+    vqpci =3D container_of(vq, QVirtQueuePCI, vq);
+
+    notify_off =3D qpci_io_readw(dev->pdev, dev->bar, dev->common_cfg_of=
fset +
+                               offsetof(struct virtio_pci_common_cfg,
+                                        queue_notify_off));
+
+    vqpci->notify_offset =3D dev->notify_cfg_offset +
+                           notify_off * dev->notify_off_multiplier;
+
+    qpci_io_writew(dev->pdev, dev->bar, dev->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_enable),=
 1);
+
+    return vq;
+}
+
+static void virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
+{
+    QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    QVirtQueuePCI *vqpci =3D container_of(vq, QVirtQueuePCI, vq);
+
+    qpci_io_writew(dev->pdev, dev->bar, vqpci->notify_offset, vq->index)=
;
+}
+
+static const QVirtioBus qvirtio_pci_virtio_1 =3D {
+    .config_readb =3D config_readb,
+    .config_readw =3D config_readw,
+    .config_readl =3D config_readl,
+    .config_readq =3D config_readq,
+    .get_features =3D get_features,
+    .set_features =3D set_features,
+    .get_guest_features =3D get_guest_features,
+    .get_status =3D get_status,
+    .set_status =3D set_status,
+    .get_queue_isr_status =3D get_queue_isr_status,
+    .wait_config_isr_status =3D wait_config_isr_status,
+    .queue_select =3D queue_select,
+    .get_queue_size =3D get_queue_size,
+    .set_queue_address =3D set_queue_address,
+    .virtqueue_setup =3D virtqueue_setup,
+    .virtqueue_cleanup =3D qvirtio_pci_virtqueue_cleanup_common,
+    .virtqueue_kick =3D virtqueue_kick,
+};
+
+static void set_config_vector(QVirtioPCIDevice *d, uint16_t entry)
+{
+    uint16_t vector;
+
+    qpci_io_writew(d->pdev, d->bar, d->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, msix_config), =
entry);
+    vector =3D qpci_io_readw(d->pdev, d->bar, d->common_cfg_offset +
+                           offsetof(struct virtio_pci_common_cfg,
+                                    msix_config));
+    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
+}
+
+static void set_queue_vector(QVirtioPCIDevice *d, uint16_t vq_idx, uint1=
6_t entry)
+{
+    uint16_t vector;
+
+    queue_select(&d->vdev, vq_idx);
+    qpci_io_writew(d->pdev, d->bar, d->common_cfg_offset +
+                   offsetof(struct virtio_pci_common_cfg, queue_msix_vec=
tor),
+                   entry);
+    vector =3D qpci_io_readw(d->pdev, d->bar, d->common_cfg_offset +
+                           offsetof(struct virtio_pci_common_cfg,
+                                    queue_msix_vector));
+    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
+}
+
+static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_virtio_1 =3D {
+    .set_config_vector =3D set_config_vector,
+    .set_queue_vector =3D set_queue_vector,
+};
+
+static bool probe_device_type(QVirtioPCIDevice *dev)
+{
+    uint16_t vendor_id;
+    uint16_t device_id;
+
+    /* "Drivers MUST match devices with the PCI Vendor ID 0x1AF4" */
+    vendor_id =3D qpci_config_readw(dev->pdev, PCI_VENDOR_ID);
+    if (vendor_id !=3D 0x1af4) {
+        return false;
+    }
+
+    /* "Any PCI device with ... PCI Device ID 0x1000 through 0x107F incl=
usive
+     * is a virtio device"
+     */
+    device_id =3D qpci_config_readw(dev->pdev, PCI_DEVICE_ID);
+    if (device_id < 0x1000 || device_id > 0x107f) {
+        return false;
+    }
+
+    /* "Devices MAY utilize a Transitional PCI Device ID range, 0x1000 t=
o
+     * 0x103F depending on the device type"
+     */
+    if (device_id < 0x1040) {
+        /* "Transitional devices MUST have the PCI Subsystem Device ID m=
atching
+         * the Virtio Device ID"
+         */
+        dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSY=
STEM_ID);
+    } else {
+        /* "The PCI Device ID is calculated by adding 0x1040 to the Virt=
io
+         * Device ID"
+         */
+        dev->vdev.device_type =3D device_id - 0x1040;
+    }
+
+    return true;
+}
+
+/* Find the first VIRTIO 1.0 PCI structure for a given type */
+static bool find_structure(QVirtioPCIDevice *dev, uint8_t cfg_type,
+                           uint8_t *bar, uint32_t *offset, uint32_t *len=
gth,
+                           uint8_t *cfg_addr)
+{
+    uint8_t addr =3D 0;
+
+    while ((addr =3D qpci_find_capability(dev->pdev, PCI_CAP_ID_VNDR,
+                                        addr)) !=3D 0) {
+        uint8_t type;
+
+        type =3D qpci_config_readb(dev->pdev,
+                addr + offsetof(struct virtio_pci_cap, cfg_type));
+        if (type !=3D cfg_type) {
+            continue;
+        }
+
+        *bar =3D qpci_config_readb(dev->pdev,
+                addr + offsetof(struct virtio_pci_cap, bar));
+        *offset =3D qpci_config_readl(dev->pdev,
+                addr + offsetof(struct virtio_pci_cap, offset));
+        *length =3D qpci_config_readl(dev->pdev,
+                addr + offsetof(struct virtio_pci_cap, length));
+        if (cfg_addr) {
+            *cfg_addr =3D addr;
+        }
+
+        return true;
+    }
+
+    return false;
+}
+
+static bool probe_device_layout(QVirtioPCIDevice *dev)
+{
+    uint8_t bar;
+    uint8_t cfg_addr;
+    uint32_t length;
+
+    /* Due to the qpci_iomap() API we only support devices that put all
+     * structures in the same PCI BAR.  Luckily this is true with QEMU.
+     */
+
+    if (!find_structure(dev, VIRTIO_PCI_CAP_COMMON_CFG, &dev->bar_idx,
+                        &dev->common_cfg_offset, &length, NULL)) {
+        return false;
+    }
+
+    if (!find_structure(dev, VIRTIO_PCI_CAP_NOTIFY_CFG, &bar,
+                        &dev->notify_cfg_offset, &length, &cfg_addr)) {
+        return false;
+    }
+    g_assert_cmphex(bar, =3D=3D, dev->bar_idx);
+
+    dev->notify_off_multiplier =3D qpci_config_readl(dev->pdev,
+            cfg_addr + offsetof(struct virtio_pci_notify_cap,
+                                notify_off_multiplier));
+
+    if (!find_structure(dev, VIRTIO_PCI_CAP_ISR_CFG, &bar,
+                        &dev->isr_cfg_offset, &length, NULL)) {
+        return false;
+    }
+    g_assert_cmphex(bar, =3D=3D, dev->bar_idx);
+
+    if (!find_structure(dev, VIRTIO_PCI_CAP_DEVICE_CFG, &bar,
+                        &dev->device_cfg_offset, &length, NULL)) {
+        return false;
+    }
+    g_assert_cmphex(bar, =3D=3D, dev->bar_idx);
+
+    return true;
+}
+
+/* Probe a VIRTIO 1.0 device */
+bool qvirtio_pci_init_virtio_1(QVirtioPCIDevice *dev)
+{
+    if (!probe_device_type(dev)) {
+        return false;
+    }
+
+    if (!probe_device_layout(dev)) {
+        return false;
+    }
+
+    dev->vdev.bus =3D &qvirtio_pci_virtio_1;
+    dev->msix_ops =3D &qvirtio_pci_msix_ops_virtio_1;
+    dev->vdev.big_endian =3D false;
+    return true;
+}
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 08451cb7f7..9ab79f19c9 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -22,6 +22,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_regs.h"
=20
+#include "virtio-pci-modern.h"
+
 /* virtio-pci is a superclass of all virtio-xxx-pci devices;
  * the relation between virtio-pci and virtio-xxx-pci is implicit,
  * and therefore virtio-pci does not produce virtio and is not
@@ -399,7 +401,9 @@ static void qvirtio_pci_init_from_pcidev(QVirtioPCIDe=
vice *dev, QPCIDevice *pci_
     dev->pdev =3D pci_dev;
     dev->config_msix_entry =3D -1;
=20
-    qvirtio_pci_init_legacy(dev);
+    if (!qvirtio_pci_init_virtio_1(dev)) {
+        qvirtio_pci_init_legacy(dev);
+    }
=20
     /* each virtio-xxx-pci device should override at least this function=
 */
     dev->obj.get_driver =3D NULL;
--=20
2.21.0


