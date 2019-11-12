Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38980C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BC3214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W1A+vi41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BC3214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaIs-000662-0F
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa9w-0003dc-BM
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa9v-0006Mp-1K
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:40:56 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8167)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUa9u-0006MU-Pm
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:40:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcaed410000>; Tue, 12 Nov 2019 09:34:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 12 Nov 2019 09:35:52 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 09:35:52 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:35:53 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 17:35:46 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v9 QEMU 14/15] vfio: Add ioctl to get dirty pages bitmap
 during dma unmap.
Date: Tue, 12 Nov 2019 22:35:23 +0530
Message-ID: <1573578324-8389-15-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573580097; bh=sSZ0v+XlNpk2vM60Bu6eKD2s0oL0MDKUEeqOP4A6g1U=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=W1A+vi41Z2lW1+FIdafLZd/oN0PiIpFpmV7L/wcg8TkBi4w0tEtKzGk+3u/7Pp84x
 uXSRnEsrid4lJeCQZmjrAJzlroo+KlZ5PQ7JupHDnSO7yAxQ3b9aAokrR5zUVAJ8ph
 hH0A9yAIkINqyTKVOdFh02GqQRkYcRN5CUmSAnwPDHFmf9GPWTLjzjrPMpEaoN7INr
 SObGtnqV0lbuLPYqyy1y03mMbDFy732JZJhY4ixH/+XMuFFYrko+J553QPy+jVQ9Ge
 Bkcs9br4+cb7JNg1S0kj8wRkFVd+eRT6g2T6oKZWuBtVN4ym5HhJc+C7rXPNMkhzW6
 v8Tbj+JreW+AQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With vIOMMU, IO virtual address range can get unmapped while in pre-copy phase
of migration. In that case, unmap ioctl should return pages pinned in that range
and QEMU should find its correcponding guest physical addresses and report
those dirty.

Note: This patch is not yet tested. I'm trying to see how I can test this code
path.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/common.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 66f1c64bf074..dc5768219d44 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -311,11 +311,30 @@ static bool vfio_devices_are_stopped_and_saving(void)
     return true;
 }
 
+static bool vfio_devices_are_running_and_saving(void)
+{
+    VFIOGroup *group;
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
+                (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
+                continue;
+            } else {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
 /*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
 static int vfio_dma_unmap(VFIOContainer *container,
-                          hwaddr iova, ram_addr_t size)
+                          hwaddr iova, ram_addr_t size,
+                          VFIOGuestIOMMU *giommu)
 {
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
@@ -324,6 +343,44 @@ static int vfio_dma_unmap(VFIOContainer *container,
         .size = size,
     };
 
+    if (giommu && vfio_devices_are_running_and_saving()) {
+        int ret;
+        uint64_t bitmap_size;
+        struct vfio_iommu_type1_dma_unmap_bitmap unmap_bitmap = {
+            .argsz = sizeof(unmap_bitmap),
+            .flags = VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP,
+            .iova = iova,
+            .size = size,
+        };
+
+        bitmap_size = BITS_TO_LONGS(size >> TARGET_PAGE_BITS) *
+                      sizeof(uint64_t);
+
+        unmap_bitmap.bitmap = g_try_malloc0(bitmap_size);
+        if (!unmap_bitmap.bitmap) {
+            error_report("%s: Error allocating bitmap buffer of size 0x%lx",
+                         __func__, bitmap_size);
+            return -ENOMEM;
+        }
+
+        unmap_bitmap.bitmap_size = bitmap_size;
+
+        ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA_GET_BITMAP,
+                    &unmap_bitmap);
+
+        if (!ret) {
+            cpu_physical_memory_set_dirty_lebitmap(
+                                        (uint64_t *)unmap_bitmap.bitmap,
+                                        giommu->iommu_offset + giommu->n.start,
+                                        bitmap_size >> TARGET_PAGE_BITS);
+        } else {
+            error_report("VFIO_IOMMU_GET_DIRTY_BITMAP: %d %d", ret, errno);
+        }
+
+        g_free(unmap_bitmap.bitmap);
+        return ret;
+    }
+
     while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         /*
          * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
@@ -371,7 +428,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
      * the VGA ROM space.
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
-        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
+        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -511,7 +568,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                          iotlb->addr_mask + 1, vaddr, ret);
         }
     } else {
-        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
+        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, giommu);
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%m)",
@@ -814,7 +871,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
-        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
+        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%m)",
-- 
2.7.0


