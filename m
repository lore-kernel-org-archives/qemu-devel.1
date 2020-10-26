Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3242CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3512F20795
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAEbVeyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3512F20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8bD-0001ov-3O
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX8GM-0003hU-CW
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX8GK-00025u-DA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603740875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BpdFFowB4Mg6Rt2I2xEViNGL0O0I91paSwF16jGLfgk=;
 b=IAEbVeyQATTm186qCxE3uEWGd1dptC4T7fGHMciHOKPr/4kLJcY1t/IyQEFYc8JeZBAvEK
 kyR8bbAeMn9fnnT/dH+Q0sS3h969SWJWHUnZkyfRou5wKSjjjnmk+Oz4gha3jX/GvEYLL5
 t6SHtZGdT0LkeYsYN9dmpx2bc2xLrNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-jQCb3i4aPFS7SD4IE9OHxA-1; Mon, 26 Oct 2020 15:34:31 -0400
X-MC-Unique: jQCb3i4aPFS7SD4IE9OHxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 144491009E2D;
 Mon, 26 Oct 2020 19:34:30 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B001819744;
 Mon, 26 Oct 2020 19:34:25 +0000 (UTC)
Subject: [PULL 14/32] vfio: Dirty page tracking when vIOMMU is enabled
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Oct 2020 13:34:25 -0600
Message-ID: <160374086500.22414.1507133315327936037.stgit@gimli.home>
In-Reply-To: <160374054442.22414.10832953989449611268.stgit@gimli.home>
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Yan Zhao <yan.y.zhao@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kirti Wankhede <kwankhede@nvidia.com>

When vIOMMU is enabled, register MAP notifier from log_sync when all
devices in container are in stop and copy phase of migration. Call replay
and get dirty pages from notifier callback.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c     |   88 +++++++++++++++++++++++++++++++++++++++++++++++---
 hw/vfio/trace-events |    1 +
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


