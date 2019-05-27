Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40681C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177AE20883
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177AE20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVEIp-00009R-9g
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 08:00:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVE4b-0005Xs-N6
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVE4a-0005dt-Ek
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:45:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hVE4U-0005AU-Ql; Mon, 27 May 2019 07:45:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42C3046202;
	Mon, 27 May 2019 11:45:12 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25F3D5D962;
	Mon, 27 May 2019 11:45:06 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Mon, 27 May 2019 13:42:01 +0200
Message-Id: <20190527114203.2762-26-eric.auger@redhat.com>
In-Reply-To: <20190527114203.2762-1-eric.auger@redhat.com>
References: <20190527114203.2762-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 27 May 2019 11:45:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 25/27] vfio-pci: register handler for iommu
 fault
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
Cc: drjones@redhat.com, yi.l.liu@intel.com, mst@redhat.com,
	jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use the VFIO_PCI_DMA_FAULT_IRQ_INDEX "irq" index to set/unset
a notifier for physical DMA faults. The associated eventfd is
triggered, in nested mode, whenever a fault is detected at IOMMU
physical level.

As this is the first use of this new IRQ index, also handle it
in irq_to_str() in case the signaling setup fails.

The actual handler will be implemented in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- check VFIO_PCI_DMA_FAULT_IRQ_INDEX is supported at kernel level
  before attempting to set signaling for it.
---
 hw/vfio/common.c |  3 +++
 hw/vfio/pci.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h    |  1 +
 3 files changed, 56 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 532ede0e70..cf0087321e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -130,6 +130,9 @@ static char *irq_to_str(int index, int subindex)
     case VFIO_PCI_REQ_IRQ_INDEX:
         str =3D g_strdup_printf("REQ-%d", subindex);
         break;
+    case VFIO_PCI_DMA_FAULT_IRQ_INDEX:
+        str =3D g_strdup_printf("DMA-FAULT-%d", subindex);
+        break;
     default:
         str =3D g_strdup_printf("index %d (unknown)", index);
         break;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b613b20501..29d4f633b0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2736,6 +2736,56 @@ static void vfio_unregister_req_notifier(VFIOPCIDe=
vice *vdev)
     vdev->req_enabled =3D false;
 }
=20
+static void vfio_dma_fault_notifier_handler(void *opaque)
+{
+    VFIOPCIDevice *vdev =3D opaque;
+
+    if (!event_notifier_test_and_clear(&vdev->dma_fault_notifier)) {
+        return;
+    }
+}
+
+static void vfio_register_dma_fault_notifier(VFIOPCIDevice *vdev)
+{
+    struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info),
+                                      .index =3D VFIO_PCI_DMA_FAULT_IRQ_=
INDEX };
+    Error *err =3D NULL;
+    int32_t fd;
+
+    if (ioctl(vdev->vbasedev.fd,
+              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count=
 < 1) {
+        return;
+    }
+
+    if (event_notifier_init(&vdev->dma_fault_notifier, 0)) {
+        error_report("vfio: Unable to init event notifier for dma fault"=
);
+        return;
+    }
+
+    fd =3D event_notifier_get_fd(&vdev->dma_fault_notifier);
+    qemu_set_fd_handler(fd, vfio_dma_fault_notifier_handler, NULL, vdev)=
;
+
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_DMA_FAULT_IRQ_I=
NDEX, 0,
+                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        qemu_set_fd_handler(fd, NULL, NULL, vdev);
+        event_notifier_cleanup(&vdev->dma_fault_notifier);
+    }
+}
+
+static void vfio_unregister_dma_fault_notifier(VFIOPCIDevice *vdev)
+{
+    Error *err =3D NULL;
+
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_DMA_FAULT_IRQ_I=
NDEX, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+    }
+    qemu_set_fd_handler(event_notifier_get_fd(&vdev->dma_fault_notifier)=
,
+                        NULL, NULL, vdev);
+    event_notifier_cleanup(&vdev->dma_fault_notifier);
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
@@ -3035,6 +3085,7 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
=20
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
+    vfio_register_dma_fault_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
=20
     return;
@@ -3073,6 +3124,7 @@ static void vfio_exitfn(PCIDevice *pdev)
=20
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
+    vfio_unregister_dma_fault_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index cfcd1a81b8..96d29d667b 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -135,6 +135,7 @@ typedef struct VFIOPCIDevice {
     PCIHostDeviceAddress host;
     EventNotifier err_notifier;
     EventNotifier req_notifier;
+    EventNotifier dma_fault_notifier;
     int (*resetfn)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
     uint32_t device_id;
--=20
2.20.1


