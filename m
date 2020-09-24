Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F87AC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ECD20738
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI5hfHcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ECD20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUK1-0002F7-Rf
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTkU-0002S9-K5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTkS-0003oV-DZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3N5IgJYqkCr1hw868wwfOZv+LThV2WpVpRBD9vwnCeQ=;
 b=EI5hfHcjpPi++V+6SR8yvLH8VXYV7mBGnuOfLmBD+7Kl1j81+h2tShz40crKKnXXGYj3Q9
 mfL41fZewoLBLYVgVkMsbbjWbhpo18EIntXSuUPb0qxnAeLKeTCNJW/UUMPb+t1LKBbaMo
 oAIRVLk3WqXgice4mgbNmfWjfgtSbDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-KPUqA1oKPsiww6_mqYbP7w-1; Thu, 24 Sep 2020 12:05:27 -0400
X-MC-Unique: KPUqA1oKPsiww6_mqYbP7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F72B8010C7;
 Thu, 24 Sep 2020 16:05:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-4.ams2.redhat.com [10.36.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 323E119C66;
 Thu, 24 Sep 2020 16:05:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH PROTOTYPE 3/6] vfio: Implement support for sparse RAM memory
 regions
Date: Thu, 24 Sep 2020 18:04:20 +0200
Message-Id: <20200924160423.106747-4-david@redhat.com>
In-Reply-To: <20200924160423.106747-1-david@redhat.com>
References: <20200924160423.106747-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement support for sparse RAM, to be used by virtio-mem. Handling
is somewhat-similar to memory_region_is_iommu() handling, which also
notifies on changes.

Instead of mapping the whole region, we only map selected pieces (and
unmap previously selected pieces) when notified by the SparseRAMHandler.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/vfio/common.c              | 155 ++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  12 +++
 2 files changed, 167 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 13471ae294..a3aaf70dd8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -37,6 +37,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qemu/units.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -498,6 +499,143 @@ out:
     rcu_read_unlock();
 }
 
+static int vfio_sparse_ram_notify(SparseRAMNotifier *n, const MemoryRegion *mr,
+                                  uint64_t mr_offset, uint64_t size,
+                                  bool map)
+{
+    VFIOSparseRAM *sram = container_of(n, VFIOSparseRAM, notifier);
+    const hwaddr mr_start = MAX(mr_offset, sram->offset_within_region);
+    const hwaddr mr_end = MIN(mr_offset + size,
+                              sram->offset_within_region + sram->size);
+    const hwaddr iova_start = mr_start + sram->offset_within_address_space;
+    const hwaddr iova_end = mr_end + sram->offset_within_address_space;
+    hwaddr mr_cur, iova_cur, mr_next;
+    void *vaddr;
+    int ret, ret2;
+
+    g_assert(mr == sram->mr);
+
+    /* We get notified about everything, ignore range we don't care about. */
+    if (mr_start >= mr_end) {
+        return 0;
+    }
+
+    /* Unmap everything with a single call. */
+    if (!map) {
+        ret = vfio_dma_unmap(sram->container, iova_start,
+                             iova_end - iova_start);
+        if (ret) {
+            error_report("%s: vfio_dma_unmap() failed: %s", __func__,
+                         strerror(-ret));
+        }
+        return 0;
+    }
+
+    /* TODO: fail early if we would exceed a specified number of mappings. */
+
+    /* Map in (aligned within MR) granularity, so we can unmap later. */
+    for (mr_cur = mr_start; mr_cur < mr_end; mr_cur = mr_next) {
+        iova_cur = mr_cur + sram->offset_within_address_space;
+        mr_next = QEMU_ALIGN_UP(mr_cur + 1, sram->granularity);
+        mr_next = MIN(mr_next, mr_end);
+
+        vaddr = memory_region_get_ram_ptr(sram->mr) + mr_cur;
+        ret = vfio_dma_map(sram->container, iova_cur, mr_next - mr_cur,
+                           vaddr, mr->readonly);
+        if (ret) {
+            /* Rollback in case of error. */
+            if (mr_cur != mr_start) {
+                ret2 = vfio_dma_unmap(sram->container, iova_start,
+                                      iova_end - iova_start);
+                if (ret2) {
+                    error_report("%s: vfio_dma_unmap() failed: %s", __func__,
+                                  strerror(-ret));
+                }
+            }
+            return ret;
+        }
+    }
+    return 0;
+}
+
+static int vfio_sparse_ram_notify_map(SparseRAMNotifier *n,
+                                      const MemoryRegion *mr,
+                                      uint64_t mr_offset, uint64_t size)
+{
+    return vfio_sparse_ram_notify(n, mr, mr_offset, size, true);
+}
+
+static void vfio_sparse_ram_notify_unmap(SparseRAMNotifier *n,
+                                         const MemoryRegion *mr,
+                                         uint64_t mr_offset, uint64_t size)
+{
+    vfio_sparse_ram_notify(n, mr, mr_offset, size, false);
+}
+
+static void vfio_register_sparse_ram(VFIOContainer *container,
+                                     MemoryRegionSection *section)
+{
+    VFIOSparseRAM *sram;
+    int ret;
+
+    sram = g_new0(VFIOSparseRAM, 1);
+    sram->container = container;
+    sram->mr = section->mr;
+    sram->offset_within_region = section->offset_within_region;
+    sram->offset_within_address_space = section->offset_within_address_space;
+    sram->size = int128_get64(section->size);
+    sram->granularity = memory_region_sparse_ram_get_granularity(section->mr);
+
+    /*
+     * TODO: We usually want a bigger granularity (for a lot of addded memory,
+     * as we need quite a lot of mappings) - however, this has to be configured
+     * by the user.
+     */
+    g_assert(sram->granularity >= 1 * MiB &&
+             is_power_of_2(sram->granularity));
+
+    /* Register the notifier */
+    sparse_ram_notifier_init(&sram->notifier, vfio_sparse_ram_notify_map,
+                             vfio_sparse_ram_notify_unmap);
+    memory_region_register_sparse_ram_notifier(section->mr, &sram->notifier);
+    QLIST_INSERT_HEAD(&container->sram_list, sram, next);
+    /*
+     * Replay mapped blocks - if anything goes wrong (only when hotplugging
+     * vfio devices), report the error for now.
+     *
+     * TODO: Can we catch this earlier?
+     */
+    ret = memory_region_sparse_ram_replay_mapped(section->mr, &sram->notifier);
+    if (ret) {
+        error_report("%s: failed to replay mappings: %s", __func__,
+                     strerror(-ret));
+    }
+}
+
+static void vfio_unregister_sparse_ram(VFIOContainer *container,
+                                       MemoryRegionSection *section)
+{
+    VFIOSparseRAM *sram = NULL;
+
+    QLIST_FOREACH(sram, &container->sram_list, next) {
+        if (sram->mr == section->mr &&
+            sram->offset_within_region == section->offset_within_region &&
+            sram->offset_within_address_space ==
+            section->offset_within_address_space) {
+            break;
+        }
+    }
+
+    if (!sram) {
+        hw_error("vfio: Trying to unregister non-existant sparse RAM");
+    }
+
+    memory_region_unregister_sparse_ram_notifier(section->mr, &sram->notifier);
+    QLIST_REMOVE(sram, next);
+    g_free(sram);
+    /* The caller is expected to vfio_dma_unmap(). */
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -650,6 +788,15 @@ static void vfio_listener_region_add(MemoryListener *listener,
 
     /* Here we assume that memory_region_is_ram(section->mr)==true */
 
+    /*
+     * For sparse RAM, we only want to register the actually mapped
+     * pieces - and update the mapping whenever we're notified about changes.
+     */
+    if (memory_region_is_sparse_ram(section->mr)) {
+        vfio_register_sparse_ram(container, section);
+        return;
+    }
+
     vaddr = memory_region_get_ram_ptr(section->mr) +
             section->offset_within_region +
             (iova - section->offset_within_address_space);
@@ -786,6 +933,13 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
         pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
         try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
+    } else if (memory_region_is_sparse_ram(section->mr)) {
+        vfio_unregister_sparse_ram(container, section);
+        /*
+         * We rely on a single vfio_dma_unmap() call below to clean the whole
+         * region.
+         */
+        try_unmap = true;
     }
 
     if (try_unmap) {
@@ -1275,6 +1429,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->error = NULL;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
+    QLIST_INIT(&container->sram_list);
 
     ret = vfio_init_container(container, group->fd, errp);
     if (ret) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c78f3ff559..dfa18dbd8e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -77,6 +77,7 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
+    QLIST_HEAD(, VFIOSparseRAM) sram_list;
     QLIST_ENTRY(VFIOContainer) next;
 } VFIOContainer;
 
@@ -88,6 +89,17 @@ typedef struct VFIOGuestIOMMU {
     QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
 } VFIOGuestIOMMU;
 
+typedef struct VFIOSparseRAM {
+    VFIOContainer *container;
+    MemoryRegion *mr;
+    hwaddr offset_within_region;
+    hwaddr offset_within_address_space;
+    hwaddr size;
+    uint64_t granularity;
+    SparseRAMNotifier notifier;
+    QLIST_ENTRY(VFIOSparseRAM) next;
+} VFIOSparseRAM;
+
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;
-- 
2.26.2


