Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897BEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF26420770
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JfpGrQUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF26420770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzsA-000843-OF
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzUG-0002RM-Po
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:12:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzUA-0000MX-VH
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:12:23 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f96a1080000>; Mon, 26 Oct 2020 03:12:24 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 10:12:09 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 10:12:01 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v29 15/17] vfio: Add ioctl to get dirty pages bitmap during
 dma unmap
Date: Mon, 26 Oct 2020 15:06:25 +0530
Message-ID: <1603704987-20977-16-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603707145; bh=OhcAlMXoLAYBrlJlYzcqA0dhUVMvACU5pFKjEdoeB+A=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=JfpGrQUy+etypimOPQkVyLAH6du5SjPQVsjocaIIUYXhCfdhINwTe6horj9aWNj4D
 zlhVuncPLBFtt5NN4cav07MT1hOXXEilmD26X6iK5AZHGnsgmHwDPEUhgwjV75TRBp
 8syghCjvfiQB1EgohJp4j00mRmYAihNhmGj/IVGXjFzcvie4lpdoje+LqiBNjtuNBN
 Si9WwfZq4I76NZyxIUOysKFS526FNey7oaXexC3t37RiClQIY/decGZApJ15xw+0UT
 hd3gZm0s6Z3uHt81GWtV6jxaBmq57yNcQ8Wl6AfgfIrefO3c9GohPagwdYPVB0ESV0
 0VRMvPSJKbEQA==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 06:10:03
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: cohuck@redhat.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With vIOMMU, IO virtual address range can get unmapped while in pre-copy
phase of migration. In that case, unmap ioctl should return pages pinned
in that range and QEMU should find its correcponding guest physical
addresses and report those dirty.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/common.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c0b5b6245a47..49c68a5253ae 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -321,11 +321,94 @@ static bool vfio_devices_all_stopped_and_saving(VFIOContainer *container)
     return true;
 }
 
+static bool vfio_devices_all_running_and_saving(VFIOContainer *container)
+{
+    VFIOGroup *group;
+    VFIODevice *vbasedev;
+    MigrationState *ms = migrate_get_current();
+
+    if (!migration_is_setup_or_active(ms->state)) {
+        return false;
+    }
+
+    QLIST_FOREACH(group, &container->group_list, container_next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            VFIOMigration *migration = vbasedev->migration;
+
+            if (!migration) {
+                return false;
+            }
+
+            if ((migration->device_state & VFIO_DEVICE_STATE_SAVING) &&
+                (migration->device_state & VFIO_DEVICE_STATE_RUNNING)) {
+                continue;
+            } else {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
+static int vfio_dma_unmap_bitmap(VFIOContainer *container,
+                                 hwaddr iova, ram_addr_t size,
+                                 IOMMUTLBEntry *iotlb)
+{
+    struct vfio_iommu_type1_dma_unmap *unmap;
+    struct vfio_bitmap *bitmap;
+    uint64_t pages = TARGET_PAGE_ALIGN(size) >> TARGET_PAGE_BITS;
+    int ret;
+
+    unmap = g_malloc0(sizeof(*unmap) + sizeof(*bitmap));
+
+    unmap->argsz = sizeof(*unmap) + sizeof(*bitmap);
+    unmap->iova = iova;
+    unmap->size = size;
+    unmap->flags |= VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP;
+    bitmap = (struct vfio_bitmap *)&unmap->data;
+
+    /*
+     * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
+     * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap_pgsize to
+     * TARGET_PAGE_SIZE.
+     */
+
+    bitmap->pgsize = TARGET_PAGE_SIZE;
+    bitmap->size = ROUND_UP(pages, sizeof(__u64) * BITS_PER_BYTE) /
+                   BITS_PER_BYTE;
+
+    if (bitmap->size > container->max_dirty_bitmap_size) {
+        error_report("UNMAP: Size of bitmap too big 0x%llx", bitmap->size);
+        ret = -E2BIG;
+        goto unmap_exit;
+    }
+
+    bitmap->data = g_try_malloc0(bitmap->size);
+    if (!bitmap->data) {
+        ret = -ENOMEM;
+        goto unmap_exit;
+    }
+
+    ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+    if (!ret) {
+        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)bitmap->data,
+                iotlb->translated_addr, pages);
+    } else {
+        error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
+    }
+
+    g_free(bitmap->data);
+unmap_exit:
+    g_free(unmap);
+    return ret;
+}
+
 /*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
 static int vfio_dma_unmap(VFIOContainer *container,
-                          hwaddr iova, ram_addr_t size)
+                          hwaddr iova, ram_addr_t size,
+                          IOMMUTLBEntry *iotlb)
 {
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
@@ -334,6 +417,11 @@ static int vfio_dma_unmap(VFIOContainer *container,
         .size = size,
     };
 
+    if (iotlb && container->dirty_pages_supported &&
+        vfio_devices_all_running_and_saving(container)) {
+        return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
+    }
+
     while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         /*
          * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
@@ -381,7 +469,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
      * the VGA ROM space.
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
-        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
+        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -531,7 +619,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                          iotlb->addr_mask + 1, vaddr, ret);
         }
     } else {
-        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
+        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%m)",
@@ -834,7 +922,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
-        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
+        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%m)",
-- 
2.7.0


