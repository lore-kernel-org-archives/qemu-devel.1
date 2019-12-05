Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A6C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D74214B2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D74214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iciHm-0001BB-Dy
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1iciDE-0005Gg-1R
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1iciDC-00018t-0T
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:53:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:12053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1iciDB-00015L-MF
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:53:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 19:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="205633342"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
 by orsmga008.jf.intel.com with ESMTP; 04 Dec 2019 19:53:50 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC PATCH 1/2] hw/vfio: add a 'disablable' flag to sparse mmaped
 region
Date: Wed,  4 Dec 2019 22:45:32 -0500
Message-Id: <20191205034532.30229-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205034451.30181-1-yan.y.zhao@intel.com>
References: <20191205034451.30181-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
Cc: kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, zhenyuw@linux.intel.com, shaopeng.he@intel.com,
 zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

add a 'disablable' flag to each each sparse mmaped region and this flag is by
default off.

vfio_region_disablable_mmaps_set_enabled() will enable/disable mmapped
subregions if its 'disablable' flag is on.

Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 hw/vfio/common.c              | 28 +++++++++++++++++++++++++++-
 hw/vfio/trace-events          |  3 ++-
 include/hw/vfio/vfio-common.h |  2 ++
 linux-headers/linux/vfio.h    |  2 ++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6f36b02e3e..79f694dd19 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -883,11 +883,13 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
     for (i = 0, j = 0; i < sparse->nr_areas; i++) {
         trace_vfio_region_sparse_mmap_entry(i, sparse->areas[i].offset,
                                             sparse->areas[i].offset +
-                                            sparse->areas[i].size);
+                                            sparse->areas[i].size,
+                                            sparse->areas[i].disablable);
 
         if (sparse->areas[i].size) {
             region->mmaps[j].offset = sparse->areas[i].offset;
             region->mmaps[j].size = sparse->areas[i].size;
+            region->mmaps[j].disablable = sparse->areas[i].disablable;
             j++;
         }
     }
@@ -1084,6 +1086,30 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
                                         enabled);
 }
 
+/**
+ * enable/disable vfio regions with mmaped subregions
+ * It only disable mmapped subregions with disablable flag on
+ */
+void vfio_region_disablable_mmaps_set_enabled(VFIORegion *region, bool enabled)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        if (region->mmaps[i].mmap && region->mmaps[i].disablable) {
+            memory_region_set_enabled(&region->mmaps[i].mem, enabled);
+            trace_vfio_region_disablable_mmaps_set_enabled(
+                    memory_region_name(region->mem),
+                    region->mmaps[i].offset,
+                    region->mmaps[i].offset + region->mmaps[i].size,
+                    enabled);
+        }
+    }
+}
+
 void vfio_reset_handler(void *opaque)
 {
     VFIOGroup *group;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 414a5e69ec..7b2d07529e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -113,7 +113,7 @@ vfio_region_finalize(const char *name, int index) "Device %s, region %d"
 vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
 vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Region %s unmap [0x%lx - 0x%lx]"
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
-vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
+vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end, bool disablable) "sparse entry %d [0x%lx - 0x%lx] disablable %d"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
 vfio_dma_unmap_overflow_workaround(void) ""
 
@@ -161,3 +161,4 @@ vfio_load_device_config_state(char *name) " (%s)"
 vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
 vfio_get_dirty_page_list(char *name, uint64_t start, uint64_t pfn_count, uint64_t page_size) " (%s) start 0x%"PRIx64" pfn_count 0x%"PRIx64 " page size 0x%"PRIx64
+vfio_region_disablable_mmaps_set_enabled(const char *name, unsigned long offset, unsigned long end, bool enabled) "Region %s mmaps [0x%lx - 0x%lx] set to %d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 41ff5ebba2..8cfe46c681 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -45,6 +45,7 @@ typedef struct VFIOMmap {
     void *mmap;
     off_t offset;
     size_t size;
+    bool disablable; /* whether this region is able to get diabled */
 } VFIOMmap;
 
 typedef struct VFIORegion {
@@ -187,6 +188,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
+void vfio_region_disablable_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_unmap(VFIORegion *region);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4bc0236b08..f9f0ea8eda 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -258,6 +258,8 @@ struct vfio_region_info {
 struct vfio_region_sparse_mmap_area {
 	__u64	offset;	/* Offset of mmap'able area within region */
 	__u64	size;	/* Size of mmap'able area */
+	__u32   disablable; /* whether this mmap'able are able to
+					be dynamically disbled */
 };
 
 struct vfio_region_info_cap_sparse_mmap {
-- 
2.17.1


