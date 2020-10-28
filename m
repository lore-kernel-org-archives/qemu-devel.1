Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91E9C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF5C246CD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIsmW1Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF5C246CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXocK-0006zI-7b
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoW5-0006qe-Gk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoW3-0001Gm-7X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603903297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7DW2erUjE2a/RQ0PB5Kl9mWrBJS4v5mxouQr0nLsFU=;
 b=eIsmW1ZnkvWhllAV0OpnY/z27i/tZVrCzGTpozhJ5q1DGr9HEYFjgZuxxKVNW0bADghdFG
 CZh0eLeYv9CQw+A2wcW3dTn/fpGOw8zATTIDTidtf8ruFULqm0K/If9NHZTJKl5gBlZaL9
 dp5OBJlYGZLo5mzTilFN18YtXim7gnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-ziHrPsFwP8KJCjgfRBsAyg-1; Wed, 28 Oct 2020 12:41:32 -0400
X-MC-Unique: ziHrPsFwP8KJCjgfRBsAyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E283108E1A2;
 Wed, 28 Oct 2020 16:41:31 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B25E219647;
 Wed, 28 Oct 2020 16:41:27 +0000 (UTC)
Subject: [PULL v2 13/32] vfio: Add vfio_listener_log_sync to mark dirty pages
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 10:41:27 -0600
Message-ID: <160390328739.12234.13340453982053225195.stgit@gimli.home>
In-Reply-To: <160390309510.12234.8858324597971641979.stgit@gimli.home>
References: <160390309510.12234.8858324597971641979.stgit@gimli.home>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Neo Jia <cjia@nvidia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kirti Wankhede <kwankhede@nvidia.com>

vfio_listener_log_sync gets list of dirty pages from container using
VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
devices are stopped and saving state.
Return early for the RAM block section of mapped MMIO region.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
[aw: llx -> PRIx64, __u64 -> uint64_t cast]
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c     |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |    1 
 2 files changed, 117 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d4959c036dd1..2b1455e78089 100644
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
@@ -37,6 +38,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/migration.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -286,6 +288,39 @@ const MemoryRegionOps vfio_region_ops = {
     },
 };
 
+/*
+ * Device state interfaces
+ */
+
+static bool vfio_devices_all_stopped_and_saving(VFIOContainer *container)
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
+                !(migration->device_state & VFIO_DEVICE_STATE_RUNNING)) {
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
@@ -812,9 +847,90 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 }
 
+static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
+                                 uint64_t size, ram_addr_t ram_addr)
+{
+    struct vfio_iommu_type1_dirty_bitmap *dbitmap;
+    struct vfio_iommu_type1_dirty_bitmap_get *range;
+    uint64_t pages;
+    int ret;
+
+    dbitmap = g_malloc0(sizeof(*dbitmap) + sizeof(*range));
+
+    dbitmap->argsz = sizeof(*dbitmap) + sizeof(*range);
+    dbitmap->flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
+    range = (struct vfio_iommu_type1_dirty_bitmap_get *)&dbitmap->data;
+    range->iova = iova;
+    range->size = size;
+
+    /*
+     * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
+     * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap's pgsize to
+     * TARGET_PAGE_SIZE.
+     */
+    range->bitmap.pgsize = TARGET_PAGE_SIZE;
+
+    pages = TARGET_PAGE_ALIGN(range->size) >> TARGET_PAGE_BITS;
+    range->bitmap.size = ROUND_UP(pages, sizeof(__u64) * BITS_PER_BYTE) /
+                                         BITS_PER_BYTE;
+    range->bitmap.data = g_try_malloc0(range->bitmap.size);
+    if (!range->bitmap.data) {
+        ret = -ENOMEM;
+        goto err_out;
+    }
+
+    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
+    if (ret) {
+        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
+                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
+                (uint64_t)range->size, errno);
+        goto err_out;
+    }
+
+    cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitmap.data,
+                                            ram_addr, pages);
+
+    trace_vfio_get_dirty_bitmap(container->fd, range->iova, range->size,
+                                range->bitmap.size, ram_addr);
+err_out:
+    g_free(range->bitmap.data);
+    g_free(dbitmap);
+
+    return ret;
+}
+
+static int vfio_sync_dirty_bitmap(VFIOContainer *container,
+                                  MemoryRegionSection *section)
+{
+    ram_addr_t ram_addr;
+
+    ram_addr = memory_region_get_ram_addr(section->mr) +
+               section->offset_within_region;
+
+    return vfio_get_dirty_bitmap(container,
+                       TARGET_PAGE_ALIGN(section->offset_within_address_space),
+                       int128_get64(section->size), ram_addr);
+}
+
+static void vfio_listerner_log_sync(MemoryListener *listener,
+        MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+
+    if (vfio_listener_skipped_section(section) ||
+        !container->dirty_pages_supported) {
+        return;
+    }
+
+    if (vfio_devices_all_stopped_and_saving(container)) {
+        vfio_sync_dirty_bitmap(container, section);
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
index a75b5208818c..dd991bd8f265 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -163,3 +163,4 @@ vfio_load_device_config_state(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
 vfio_load_cleanup(const char *name) " (%s)"
+vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64


