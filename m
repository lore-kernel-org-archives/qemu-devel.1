Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4B02084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="df3FhUz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4B02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaLW-00025K-Ao
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUaA6-0003tW-Ax
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUaA5-0006RO-0R
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:41:06 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUaA4-0006Qo-Ob
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:41:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcaed720002>; Tue, 12 Nov 2019 09:35:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 12 Nov 2019 09:35:46 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 09:35:46 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:35:46 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 17:35:40 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v9 QEMU 13/15] vfio: Add vfio_listener_log_sync to mark dirty
 pages
Date: Tue, 12 Nov 2019 22:35:22 +0530
Message-ID: <1573578324-8389-14-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573580146; bh=0UUp97MJ5WZU+gK0tOeBWbmGpsvBrEQM3KLye1oMDJA=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=df3FhUz34/8/VVXn2NKOcQXsOnbH+ClWATzS8nESt9cgeqbAuvPSbH7Ttcg4fRgqh
 F+Gi1L9F2eEaMfpspMUhNfSfBcPDHPhlS7npW53OVuy9BWFR6YBBvu4Ab2UzzH3Ssq
 N2S8o/kQs84ruOuQ+2LXdEEDsT9LGS0DdykvWWv0bi1UICaLtFE4VvHpGyl3vB3lqf
 do+Q4xGF12mmj+ppSdwe1aFFy86vMPqR5sY02oua3Cy+0yy9UBiRjkrVh8MkALgQm7
 MS5C2juuxfWdxK7QVeti3wrF+8C66erCvaQOg4ChcczZIbxPEvPMvOUW8IteoqRci0
 jxfZHz/rcY2Bw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
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

vfio_listener_log_sync gets list of dirty pages from container using
VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
devices are stopped and saving state.
Return early for the RAM block section of mapped MMIO region.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/common.c     | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |   1 +
 2 files changed, 104 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ade9839c28a3..66f1c64bf074 100644
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
@@ -813,9 +837,88 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 }
 
+static int vfio_get_dirty_bitmap(VFIOContainer *container,
+                                 MemoryRegionSection *section)
+{
+    struct vfio_iommu_type1_dirty_bitmap range;
+    uint64_t bitmap_size;
+    int ret;
+
+    range.argsz = sizeof(range);
+
+    if (memory_region_is_iommu(section->mr)) {
+        VFIOGuestIOMMU *giommu;
+        IOMMUTLBEntry iotlb;
+
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
+
+        iotlb = address_space_get_iotlb_entry(container->space->as,
+                       TARGET_PAGE_ALIGN(section->offset_within_address_space),
+                       true, MEMTXATTRS_UNSPECIFIED);
+        range.iova = iotlb.iova + giommu->iommu_offset;
+        range.size = iotlb.addr_mask + 1;
+    } else {
+        range.iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+        range.size = int128_get64(section->size);
+    }
+
+    bitmap_size = BITS_TO_LONGS(range.size >> TARGET_PAGE_BITS) *
+                                                             sizeof(uint64_t);
+
+    range.bitmap = g_try_malloc0(bitmap_size);
+    if (!range.bitmap) {
+        error_report("%s: Error allocating bitmap buffer of size 0x%lx",
+                     __func__, bitmap_size);
+        return -ENOMEM;
+    }
+
+    range.bitmap_size = bitmap_size;
+
+    ret = ioctl(container->fd, VFIO_IOMMU_GET_DIRTY_BITMAP, &range);
+
+    if (!ret) {
+        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range.bitmap,
+                       TARGET_PAGE_ALIGN(section->offset_within_address_space),
+                       bitmap_size >> TARGET_PAGE_BITS);
+    } else {
+        error_report("VFIO_IOMMU_GET_DIRTY_BITMAP: %d %d", ret, errno);
+    }
+
+    trace_vfio_get_dirty_bitmap(container->fd, range.iova, range.size,
+                                bitmap_size);
+
+    g_free(range.bitmap);
+    return ret;
+}
+
+static void vfio_listerner_log_sync(MemoryListener *listener,
+        MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+
+    if (memory_region_is_ram_device(section->mr)) {
+        return;
+    }
+
+    if (vfio_devices_are_stopped_and_saving()) {
+
+        vfio_get_dirty_bitmap(container, section);
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
index ac065b559f4e..0dd1f2ffe648 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -160,3 +160,4 @@ vfio_save_complete_precopy(char *name) " (%s)"
 vfio_load_device_config_state(char *name) " (%s)"
 vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
+vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64
-- 
2.7.0


