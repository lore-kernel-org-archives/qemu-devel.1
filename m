Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA7AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DAD205CB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCyEABNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DAD205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKe0-0004Zk-6G
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKTh-0006HJ-FM
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKTf-0005Tn-BI
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Hu7XHUgUFuXjFxp7/nhYOgLYoiXZ5bnq8q2Cm/SPeA=;
 b=LCyEABNqTGH0+tlRD9G1HRS8TjcvcrZL+JKHuYOOWShxAp5IZhHfU6j4Y9cTf4WjBj8Jkr
 cD+FRtsn7qyceih4jMoIXPTWWoLGKbGWBFU7kGGKmdcUNYhyG5UHYsrJyi/w2sTQT6rOKL
 lnHzvHHDvJC7wfrSH/dCkkaTRLPydS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-2tSEx7D0OWOBLEW7pIcBBQ-1; Sun, 01 Nov 2020 16:01:24 -0500
X-MC-Unique: 2tSEx7D0OWOBLEW7pIcBBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71C7E1006C83;
 Sun,  1 Nov 2020 21:01:23 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21D105578C;
 Sun,  1 Nov 2020 21:01:20 +0000 (UTC)
Subject: [PULL v3 15/32] vfio: Add ioctl to get dirty pages bitmap during
 dma unmap
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 14:01:20 -0700
Message-ID: <160426447993.24886.10237011487367170903.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:46:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

With vIOMMU, IO virtual address range can get unmapped while in pre-copy
phase of migration. In that case, unmap ioctl should return pages pinned
in that range and QEMU should find its correcponding guest physical
addresses and report those dirty.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
[aw: fix error_report types, fix cpu_physical_memory_set_dirty_lebitmap() cast]
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 43e6e89090f2..620358a3d804 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -321,11 +321,95 @@ static bool vfio_devices_all_stopped_and_saving(VFIOContainer *container)
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
+        error_report("UNMAP: Size of bitmap too big 0x%"PRIx64,
+                     (uint64_t)bitmap->size);
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
+        cpu_physical_memory_set_dirty_lebitmap((unsigned long *)bitmap->data,
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
@@ -334,6 +418,11 @@ static int vfio_dma_unmap(VFIOContainer *container,
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
@@ -381,7 +470,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
      * the VGA ROM space.
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
-        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
+        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -531,7 +620,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                          iotlb->addr_mask + 1, vaddr, ret);
         }
     } else {
-        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
+        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%m)",
@@ -834,7 +923,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
-        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
+        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
         if (ret) {
             error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%m)",


