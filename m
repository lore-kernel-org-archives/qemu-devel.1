Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B07C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8528C206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UctUmBWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8528C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbU29-00036S-Om
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 15:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbTwm-0001jz-C1
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:00:08 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbTwl-0004yR-1n
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:00:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec57e290003>; Wed, 20 May 2020 11:59:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 20 May 2020 12:00:05 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 20 May 2020 12:00:05 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 19:00:04 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 20 May 2020 18:59:56 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v23 15/18] vfio: Add vfio_listener_log_sync to mark dirty
 pages
Date: Wed, 20 May 2020 23:54:45 +0530
Message-ID: <1589999088-31477-16-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590001193; bh=PcwqSiKRfgV5VNqx0xeuD3wW157oGjQVRUEoMWu1jgY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=UctUmBWQz8+KgDKbDvJ7fM0SZTmYdlJRZ/FdOw5LPcdBC4AUec2HLBLlho4ryag61
 JzbojroJ9YzevUhxWK787RA+krr6zVUH5+JpbQk3wvJHvCHFHyxAMqyntsB3YPSCew
 T+mJXbSQOZteslshb/ok3xC65mQZMmjD7nf41Q+e0FkkgT8uBIanYRtdnx2aJMR8CQ
 /L/fZlFSINzxfW6rUuv1e4mIrRNZRit55djc2L4mIXVE41vjlkCTH4ucvEIVqelPtd
 zg/vTMhqzsQRyWTrrMB367/Y920+Hk17X8qlaVBYtBUT61r5VYKKYGvjTzsp+L1Hkq
 LBg5/+nHE+txA==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 14:41:35
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vfio_listener_log_sync gets list of dirty pages from container using
VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
devices are stopped and saving state.
Return early for the RAM block section of mapped MMIO region.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/common.c     | 184 +++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/vfio/trace-events |   1 +
 2 files changed, 180 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e0d3d4585a65..3f7049fbd1b0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -29,6 +29,7 @@
 #include "hw/vfio/vfio.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
+#include "exec/ram_addr.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -38,6 +39,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/migration.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -288,6 +290,28 @@ const MemoryRegionOps vfio_region_ops = {
 };
 
 /*
+ * Device state interfaces
+ */
+
+static bool vfio_devices_are_stopped_and_saving(void)
+{
+    VFIOGroup *group;
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
+                !(vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
+                continue;
+            } else {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
+/*
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
 static int vfio_dma_unmap(VFIOContainer *container,
@@ -408,8 +432,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 }
 
 /* Called with rcu_read_lock held.  */
-static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
-                           bool *read_only)
+static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
+                               ram_addr_t *ram_addr, bool *read_only)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -440,9 +464,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
         return false;
     }
 
-    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
-    *read_only = !writable || mr->readonly;
+    if (vaddr) {
+        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
+    }
 
+    if (ram_addr) {
+        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
+    }
+
+    if (read_only) {
+        *read_only = !writable || mr->readonly;
+    }
     return true;
 }
 
@@ -467,7 +499,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     rcu_read_lock();
 
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
-        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
             goto out;
         }
         /*
@@ -813,9 +845,151 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 }
 
+static int vfio_get_dirty_bitmap(MemoryListener *listener,
+                                 MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+    VFIOGuestIOMMU *giommu = NULL;
+    IOMMUTLBEntry iotlb;
+    hwaddr granularity, iova, iova_end;
+    int ret;
+
+    if (memory_region_is_iommu(section->mr)) {
+        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
+            if (MEMORY_REGION(giommu->iommu) == section->mr &&
+                giommu->n.start == section->offset_within_region) {
+                break;
+            }
+        }
+
+        if (!giommu) {
+            return -EINVAL;
+        }
+    }
+
+    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+
+    if (memory_region_is_iommu(section->mr)) {
+        hwaddr iova_size;
+
+        granularity = memory_region_iommu_get_min_page_size(giommu->iommu);
+        iova_end = memory_region_iommu_get_address_limit(giommu->iommu);
+
+        if (iova_end) {
+            iova_size = MIN(int128_get64(section->size), iova_end - iova + 1);
+        } else {
+            iova_size = int128_get64(section->size);
+        }
+
+        iova_end = iova + iova_size - 1;
+    } else {
+        granularity = memory_region_size(section->mr);
+        iova_end = iova + int128_get64(section->size) - 1;
+    }
+
+    RCU_READ_LOCK_GUARD();
+
+    while (iova < iova_end) {
+        struct vfio_iommu_type1_dirty_bitmap *dbitmap;
+        struct vfio_iommu_type1_dirty_bitmap_get *range;
+        ram_addr_t start, pages;
+        uint64_t iova_xlat, size;
+
+        if (memory_region_is_iommu(section->mr)) {
+            iotlb = address_space_get_iotlb_entry(container->space->as, iova,
+                                                 true, MEMTXATTRS_UNSPECIFIED);
+            if ((iotlb.target_as == NULL) || (iotlb.addr_mask == 0)) {
+                if ((iova + granularity) < iova) {
+                    break;
+                }
+                iova += granularity;
+                continue;
+            }
+            iova_xlat = iotlb.iova + giommu->iommu_offset;
+            size = iotlb.addr_mask + 1;
+        } else {
+            iova_xlat = iova;
+            size = iova_end - iova + 1;
+        }
+
+        dbitmap = g_malloc0(sizeof(*dbitmap) + sizeof(*range));
+
+        dbitmap->argsz = sizeof(*dbitmap) + sizeof(*range);
+        dbitmap->flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
+        range = (struct vfio_iommu_type1_dirty_bitmap_get *)&dbitmap->data;
+        range->iova = iova_xlat;
+        range->size = size;
+
+        /*
+         * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
+         * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap's pgsize to
+         * TARGET_PAGE_SIZE.
+         */
+        range->bitmap.pgsize = TARGET_PAGE_SIZE;
+
+        pages = TARGET_PAGE_ALIGN(range->size) >> TARGET_PAGE_BITS;
+        range->bitmap.size = ROUND_UP(pages, sizeof(__u64) * BITS_PER_BYTE) /
+                             BITS_PER_BYTE;
+        range->bitmap.data = g_malloc0(range->bitmap.size);
+
+        ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
+        if (ret) {
+            error_report("Failed to get dirty bitmap for iova: 0x%llx "
+                         "size: 0x%llx err: %d",
+                         range->iova, range->size, errno);
+            goto err_out;
+        }
+
+        if (memory_region_is_iommu(section->mr)) {
+            if (!vfio_get_xlat_addr(&iotlb, NULL, &start, NULL)) {
+                ret = -EINVAL;
+                goto err_out;
+            }
+        } else {
+            start = memory_region_get_ram_addr(section->mr) +
+                    section->offset_within_region + iova -
+                    TARGET_PAGE_ALIGN(section->offset_within_address_space);
+        }
+
+        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitmap.data,
+                                               start, pages);
+
+        trace_vfio_get_dirty_bitmap(container->fd, range->iova, range->size,
+                                    range->bitmap.size, start);
+err_out:
+        g_free(range->bitmap.data);
+        g_free(dbitmap);
+
+        if (ret) {
+            return ret;
+        }
+
+        if ((iova + size) < iova) {
+            break;
+        }
+
+        iova += size;
+    }
+
+    return 0;
+}
+
+static void vfio_listerner_log_sync(MemoryListener *listener,
+        MemoryRegionSection *section)
+{
+    if (vfio_listener_skipped_section(section)) {
+        return;
+    }
+
+    if (vfio_devices_are_stopped_and_saving()) {
+        vfio_get_dirty_bitmap(listener, section);
+    }
+}
+
 static const MemoryListener vfio_memory_listener = {
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
+    .log_sync = vfio_listerner_log_sync,
 };
 
 static void vfio_listener_release(VFIOContainer *container)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 4a4bd3ba9a2a..c61ae4f3ead8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -160,3 +160,4 @@ vfio_save_complete_precopy(const char *name) " (%s)"
 vfio_load_device_config_state(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
+vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
-- 
2.7.0


