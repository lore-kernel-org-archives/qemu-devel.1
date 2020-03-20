Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10896C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E4A2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmdStEqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E4A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLAQ-00040o-VT
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFL2u-0008WJ-5O
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFL2s-00088a-N9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:02:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29041)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFL2s-00088H-Jm
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQhKfFuhoehdaJWgTP0IvCMXdM/ilJRI+EK32UnS4wY=;
 b=AmdStEqppZz62V2l9aY9iDw8uDvu8fAzE35td+hWG/4YG13H65qjUk8oL40A+6l182VQb2
 pb+Qriul3tP+UJirZF8BTuow9agalmXQlEI0gSTYig78PuhSvCnAC1nojDixw0GkQ5LOjz
 cF3aUCEBGmOqmIb+ZE5fFoVnRjurwN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-aBa6nSI8PEqSwEj5sFwU5Q-1; Fri, 20 Mar 2020 13:02:50 -0400
X-MC-Unique: aBa6nSI8PEqSwEj5sFwU5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCCCB8024D1;
 Fri, 20 Mar 2020 17:02:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3619616D22;
 Fri, 20 Mar 2020 17:02:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 16/24] vfio/pci: Set up the DMA FAULT region
Date: Fri, 20 Mar 2020 17:58:32 +0100
Message-Id: <20200320165840.30057-17-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-1-eric.auger@redhat.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 zhangfei.gao@foxmail.com, peterx@redhat.com,
 shameerali.kolothum.thodi@huawei.com, zhangfei.gao@linaro.org,
 bbhushan2@marvell.com, will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set up the fault region which is composed of the actual fault
queue (mmappable) and a header used to handle it. The fault
queue is mmapped.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4 -> v5:
- use a single DMA FAULT region. No version selection anymore
---
 hw/vfio/pci.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7579f476b0..029652a507 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2530,11 +2530,67 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **=
errp)
     return 0;
 }
=20
+static void vfio_init_fault_regions(VFIOPCIDevice *vdev, Error **errp)
+{
+    struct vfio_region_info *fault_region_info =3D NULL;
+    struct vfio_region_info_cap_fault *cap_fault;
+    VFIODevice *vbasedev =3D &vdev->vbasedev;
+    struct vfio_info_cap_header *hdr;
+    char *fault_region_name;
+    int ret;
+
+    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
+                                   VFIO_REGION_TYPE_NESTED,
+                                   VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT,
+                                   &fault_region_info);
+    if (ret) {
+        goto out;
+    }
+
+    hdr =3D vfio_get_region_info_cap(fault_region_info,
+                                   VFIO_REGION_INFO_CAP_DMA_FAULT);
+    if (!hdr) {
+        error_setg(errp, "failed to retrieve DMA FAULT capability");
+        goto out;
+    }
+    cap_fault =3D container_of(hdr, struct vfio_region_info_cap_fault,
+                             header);
+    if (cap_fault->version !=3D 1) {
+        error_setg(errp, "Unsupported DMA FAULT API version %d",
+                   cap_fault->version);
+        goto out;
+    }
+
+    fault_region_name =3D g_strdup_printf("%s DMA FAULT %d",
+                                        vbasedev->name,
+                                        fault_region_info->index);
+
+    ret =3D vfio_region_setup(OBJECT(vdev), vbasedev,
+                            &vdev->dma_fault_region,
+                            fault_region_info->index,
+                            fault_region_name);
+    g_free(fault_region_name);
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "failed to set up the DMA FAULT region %d",
+                         fault_region_info->index);
+        goto out;
+    }
+
+    ret =3D vfio_region_mmap(&vdev->dma_fault_region);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Failed to mmap the DMA FAULT queue")=
;
+    }
+out:
+    g_free(fault_region_info);
+}
+
 static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev =3D &vdev->vbasedev;
     struct vfio_region_info *reg_info;
     struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info) };
+    Error *err =3D NULL;
     int i, ret =3D -1;
=20
     /* Sanity check device */
@@ -2598,6 +2654,12 @@ static void vfio_populate_device(VFIOPCIDevice *vdev=
, Error **errp)
         }
     }
=20
+    vfio_init_fault_regions(vdev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
     irq_info.index =3D VFIO_PCI_ERR_IRQ_INDEX;
=20
     ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
@@ -3200,6 +3262,7 @@ static void vfio_instance_finalize(Object *obj)
=20
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
+    vfio_region_finalize(&vdev->dma_fault_region);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
     if (vdev->migration_blocker) {
@@ -3224,6 +3287,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     vfio_unregister_ext_irq_notifiers(vdev);
+    vfio_region_exit(&vdev->dma_fault_region);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier)=
;
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 56f0fabb33..c5a59a8e3d 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -141,6 +141,7 @@ typedef struct VFIOPCIDevice {
     EventNotifier err_notifier;
     EventNotifier req_notifier;
     VFIOPCIExtIRQ *ext_irqs;
+    VFIORegion dma_fault_region;
     int (*resetfn)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
     uint32_t device_id;
--=20
2.20.1


