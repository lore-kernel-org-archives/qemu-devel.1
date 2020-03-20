Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B57C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AED220724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7fRq1Yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AED220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFL7H-0007MR-QU
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFL2v-00008L-LS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFL2u-00089Q-9Y
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:02:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54439)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFL2u-00089C-69
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaiJensNpwnaD1rCabFEj3CYTPUK5hj3auViO0IJV9U=;
 b=c7fRq1YhbvdQC/O8zxJ8ZQ2eydThZBk65pP4GOMPkItwsqapFTlwcB25gYmgSdVaTvGnOt
 +TAIioE863QBtOfaQ4qeqoy50SBxyJGaN+nqQxBoAC9xfBN/4odbIZP4tncgm44SjkThfG
 UrMHi4ciyyuhqPoUIHtf1VLS/tbgqxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-0HYgui4TOYux6N2bkTJL6w-1; Fri, 20 Mar 2020 13:02:51 -0400
X-MC-Unique: 0HYgui4TOYux6N2bkTJL6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1168910CE7A8;
 Fri, 20 Mar 2020 17:02:49 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 262DE16D22;
 Fri, 20 Mar 2020 17:02:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 17/24] vfio/pci: Implement the DMA fault handler
Date: Fri, 20 Mar 2020 17:58:33 +0100
Message-Id: <20200320165840.30057-18-eric.auger@redhat.com>
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

Whenever the eventfd is triggered, we retrieve the DMA fault(s)
from the mmapped fault region and inject them in the iommu
memory region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  1 +
 2 files changed, 51 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 029652a507..86ee4b6b47 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2845,10 +2845,60 @@ static PCIPASIDOps vfio_pci_pasid_ops =3D {
 static void vfio_dma_fault_notifier_handler(void *opaque)
 {
     VFIOPCIExtIRQ *ext_irq =3D opaque;
+    VFIOPCIDevice *vdev =3D ext_irq->vdev;
+    PCIDevice *pdev =3D &vdev->pdev;
+    AddressSpace *as =3D pci_device_iommu_address_space(pdev);
+    IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(as->root);
+    struct vfio_region_dma_fault header;
+    struct iommu_fault *queue;
+    char *queue_buffer =3D NULL;
+    ssize_t bytes;
=20
     if (!event_notifier_test_and_clear(&ext_irq->notifier)) {
         return;
     }
+
+    bytes =3D pread(vdev->vbasedev.fd, &header, sizeof(header),
+                  vdev->dma_fault_region.fd_offset);
+    if (bytes !=3D sizeof(header)) {
+        error_report("%s unable to read the fault region header (0x%lx)",
+                     __func__, bytes);
+        return;
+    }
+
+    /* Normally the fault queue is mmapped */
+    queue =3D (struct iommu_fault *)vdev->dma_fault_region.mmaps[0].mmap;
+    if (!queue) {
+        size_t queue_size =3D header.nb_entries * header.entry_size;
+
+        error_report("%s: fault queue not mmapped: slower fault handling",
+                     vdev->vbasedev.name);
+
+        queue_buffer =3D g_malloc(queue_size);
+        bytes =3D  pread(vdev->vbasedev.fd, queue_buffer, queue_size,
+                       vdev->dma_fault_region.fd_offset + header.offset);
+        if (bytes !=3D queue_size) {
+            error_report("%s unable to read the fault queue (0x%lx)",
+                         __func__, bytes);
+            return;
+        }
+
+        queue =3D (struct iommu_fault *)queue_buffer;
+    }
+
+    while (vdev->fault_tail_index !=3D header.head) {
+        memory_region_inject_faults(iommu_mr, 1,
+                                    &queue[vdev->fault_tail_index]);
+        vdev->fault_tail_index =3D
+            (vdev->fault_tail_index + 1) % header.nb_entries;
+    }
+    bytes =3D pwrite(vdev->vbasedev.fd, &vdev->fault_tail_index, 4,
+                   vdev->dma_fault_region.fd_offset);
+    if (bytes !=3D 4) {
+        error_report("%s unable to write the fault region tail index (0x%l=
x)",
+                     __func__, bytes);
+    }
+    g_free(queue_buffer);
 }
=20
 static int vfio_register_ext_irq_handler(VFIOPCIDevice *vdev,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c5a59a8e3d..2d0b65d8ff 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -142,6 +142,7 @@ typedef struct VFIOPCIDevice {
     EventNotifier req_notifier;
     VFIOPCIExtIRQ *ext_irqs;
     VFIORegion dma_fault_region;
+    uint32_t fault_tail_index;
     int (*resetfn)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
     uint32_t device_id;
--=20
2.20.1


