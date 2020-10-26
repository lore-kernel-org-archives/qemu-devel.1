Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4493AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9250F2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="e/x3Mimw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9250F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX03v-00078k-Dy
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzUA-0002Or-DO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:12:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzU0-0000Iy-Go
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:12:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f96a0fb0000>; Mon, 26 Oct 2020 03:12:11 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 10:12:00 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 10:11:52 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v29 14/17] vfio: Dirty page tracking when vIOMMU is enabled
Date: Mon, 26 Oct 2020 15:06:24 +0530
Message-ID: <1603704987-20977-15-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603707131; bh=Cls4gEh+VPhv8vXKQL7bPpKkip2D69kBgiEfsaR3z0M=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=e/x3MimwD/SgSa2Q5E2dePXPlCAB7d4LuumdiwJvaMFC+6mfAGHGKlhk/saUGxbqv
 yLSwO7XXtVPKMPRWikHKFjTD9tQ15yXHNzWJi3uK1EfDPqU7d2orcSnaufa5u9DFjb
 yb+ajdNsu2Rmcye9Gp/KFycuvsDZIpD9kOAtn+KRDVf0EOfLSisoizPDzUik+dXN8O
 9/IBS/NgFcvHkM55QFZgq/AX7YfB81bKcGhcwi7122zk4IRj14StClq4VGctMSZulY
 9xVX9KJUFuTVmwzvUrvWZxtUi6lmxSU0qYXHHBsx5gImEvLMD/WMbJxa8/djvBuOY+
 Sv+m4433iJ08Q==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 06:10:10
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

When vIOMMU is enabled, register MAP notifier from log_sync when all
devices in container are in stop and copy phase of migration. Call replay
and get dirty pages from notifier callback.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
---
 hw/vfio/common.c     | 88 ++++++++++++++++++++++++++++++++++++++++++++++++----
 hw/vfio/trace-events |  1 +
 2 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2634387df948..c0b5b6245a47 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -442,8 +442,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 }
 
 /* Called with rcu_read_lock held.  */
-static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
-                           bool *read_only)
+static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
+                               ram_addr_t *ram_addr, bool *read_only)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -474,8 +474,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
         return false;
     }
 
-    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
-    *read_only = !writable || mr->readonly;
+    if (vaddr) {
+        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
+    }
+
+    if (ram_addr) {
+        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
+    }
+
+    if (read_only) {
+        *read_only = !writable || mr->readonly;
+    }
 
     return true;
 }
@@ -485,7 +494,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainer *container = giommu->container;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
-    bool read_only;
     void *vaddr;
     int ret;
 
@@ -501,7 +509,9 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     rcu_read_lock();
 
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
-        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
+        bool read_only;
+
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
             goto out;
         }
         /*
@@ -899,11 +909,77 @@ err_out:
     return ret;
 }
 
+typedef struct {
+    IOMMUNotifier n;
+    VFIOGuestIOMMU *giommu;
+} vfio_giommu_dirty_notifier;
+
+static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    vfio_giommu_dirty_notifier *gdn = container_of(n,
+                                                vfio_giommu_dirty_notifier, n);
+    VFIOGuestIOMMU *giommu = gdn->giommu;
+    VFIOContainer *container = giommu->container;
+    hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    ram_addr_t translated_addr;
+
+    trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
+
+    if (iotlb->target_as != &address_space_memory) {
+        error_report("Wrong target AS \"%s\", only system memory is allowed",
+                     iotlb->target_as->name ? iotlb->target_as->name : "none");
+        return;
+    }
+
+    rcu_read_lock();
+    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
+        int ret;
+
+        ret = vfio_get_dirty_bitmap(container, iova, iotlb->addr_mask + 1,
+                                    translated_addr);
+        if (ret) {
+            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
+                         "0x%"HWADDR_PRIx") = %d (%m)",
+                         container, iova,
+                         iotlb->addr_mask + 1, ret);
+        }
+    }
+    rcu_read_unlock();
+}
+
 static int vfio_sync_dirty_bitmap(VFIOContainer *container,
                                   MemoryRegionSection *section)
 {
     ram_addr_t ram_addr;
 
+    if (memory_region_is_iommu(section->mr)) {
+        VFIOGuestIOMMU *giommu;
+
+        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
+            if (MEMORY_REGION(giommu->iommu) == section->mr &&
+                giommu->n.start == section->offset_within_region) {
+                Int128 llend;
+                vfio_giommu_dirty_notifier gdn = { .giommu = giommu };
+                int idx = memory_region_iommu_attrs_to_index(giommu->iommu,
+                                                       MEMTXATTRS_UNSPECIFIED);
+
+                llend = int128_add(int128_make64(section->offset_within_region),
+                                   section->size);
+                llend = int128_sub(llend, int128_one());
+
+                iommu_notifier_init(&gdn.n,
+                                    vfio_iommu_map_dirty_notify,
+                                    IOMMU_NOTIFIER_MAP,
+                                    section->offset_within_region,
+                                    int128_get64(llend),
+                                    idx);
+                memory_region_iommu_replay(giommu->iommu, &gdn.n);
+                break;
+            }
+        }
+        return 0;
+    }
+
     ram_addr = memory_region_get_ram_addr(section->mr) +
                section->offset_within_region;
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index dd991bd8f265..c0e75f24b76d 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -164,3 +164,4 @@ vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
 vfio_load_cleanup(const char *name) " (%s)"
 vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
+vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
-- 
2.7.0


