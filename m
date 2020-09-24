Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E664C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E439D23741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnEnrl9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E439D23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUCk-0002zf-Tz
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTlF-0003SL-K2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTlB-00047k-0E
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ns91EjBugtmDxMCQ5VfxqyGOa9vP01gmqc4UUw1zhlo=;
 b=gnEnrl9WkxQmAKwp48oOXbegUwE29FSVp5SS9lF3gi64FhItbu0WjTmf6Tjv3pn9tYKtri
 7LVvYc71CxU7fs27CdLco9pME3EWXP9uE4pgjPnFRLz4ML8lnz+c7wSYmYKmKVOzNGAVHh
 Ccg53oy9g/w08HBiuyZZKgLrubDwqXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-dB8S5PCUMAKcngodM1kPug-1; Thu, 24 Sep 2020 12:05:01 -0400
X-MC-Unique: dB8S5PCUMAKcngodM1kPug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BF2A10BBED8;
 Thu, 24 Sep 2020 16:05:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-4.ams2.redhat.com [10.36.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A3E119C66;
 Thu, 24 Sep 2020 16:04:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH PROTOTYPE 1/6] memory: Introduce sparse RAM handler for memory
 regions
Date: Thu, 24 Sep 2020 18:04:18 +0200
Message-Id: <20200924160423.106747-2-david@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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

We have some special memory ram regions (managed by paravirtualized memory
devices - virtio-mem), whereby the guest agreed to only use selected memory
ranges. This results in "sparse" mmaps, "sparse" RAMBlocks and "sparse"
memory ram regions.

In most cases, we don't currently care about that - e.g., in KVM, we simply
have a single KVM memory slot (and as the number is fairly limited, we'll
have to keep it like that). However, in case of vfio, registering the
whole region with the kernel results in all pages getting pinned, and
therefore an unexpected high memory consumption. This is the main
reason why vfio is incompatible with memory ballooning.

Let's introduce a way to communicate the actual accessible/mapped (meaning,
not discarded) pieces for such a sparse memory region, and get notified on
changes (e.g., a virito-mem device plugging/unplugging memory).

We expect that the SparseRAMHandler is set for a memory region before it
is mapped into guest physical address space (so before any memory
listeners get notified about the addition), and the SparseRAMHandler isn't
unset before the memory region was unmapped from guest physical address
space (so after any memory listener got notified about the removal).

This is somewhat similar to the iommu memory region notifier mechanism.

TODO:
- Better documentation.
- Better Naming?
- Handle it on RAMBlocks?
- SPAPR spacial handling required (virtio-mem only supports x86-64 for now)?
- Catch mapping errors during hotplug in a nice way
- Fail early when a certain number of mappings would be exceeded
  (instead of eventually consuming too many, leaving none for others)
- Resizeable memory region handling (future).
- Callback to check the state of a block.

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
 include/exec/memory.h | 115 ++++++++++++++++++++++++++++++++++++++++++
 softmmu/memory.c      |   7 +++
 2 files changed, 122 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index f1bb2a7df5..2931ead730 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -42,6 +42,12 @@ typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegionClass;
 DECLARE_OBJ_CHECKERS(IOMMUMemoryRegion, IOMMUMemoryRegionClass,
                      IOMMU_MEMORY_REGION, TYPE_IOMMU_MEMORY_REGION)
 
+#define TYPE_SPARSE_RAM_HANDLER "sparse-ram-handler"
+typedef struct SparseRAMHandlerClass SparseRAMHandlerClass;
+typedef struct SparseRAMHandler SparseRAMHandler;
+DECLARE_OBJ_CHECKERS(SparseRAMHandler, SparseRAMHandlerClass,
+                     SPARSE_RAM_HANDLER, TYPE_SPARSE_RAM_HANDLER)
+
 extern bool global_dirty_log;
 
 typedef struct MemoryRegionOps MemoryRegionOps;
@@ -136,6 +142,28 @@ static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
     n->iommu_idx = iommu_idx;
 }
 
+struct SparseRAMNotifier;
+typedef int (*SparseRAMNotifyMap)(struct SparseRAMNotifier *notifier,
+                                  const MemoryRegion *mr, uint64_t mr_offset,
+                                  uint64_t size);
+typedef void (*SparseRAMNotifyUnmap)(struct SparseRAMNotifier *notifier,
+                                     const MemoryRegion *mr, uint64_t mr_offset,
+                                     uint64_t size);
+
+typedef struct SparseRAMNotifier {
+    SparseRAMNotifyMap notify_map;
+    SparseRAMNotifyUnmap notify_unmap;
+    QLIST_ENTRY(SparseRAMNotifier) next;
+} SparseRAMNotifier;
+
+static inline void sparse_ram_notifier_init(SparseRAMNotifier *notifier,
+                                            SparseRAMNotifyMap map_fn,
+                                            SparseRAMNotifyUnmap unmap_fn)
+{
+    notifier->notify_map = map_fn;
+    notifier->notify_unmap = unmap_fn;
+}
+
 /*
  * Memory region callbacks
  */
@@ -352,6 +380,36 @@ struct IOMMUMemoryRegionClass {
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
 };
 
+struct SparseRAMHandlerClass {
+    /* private */
+    InterfaceClass parent_class;
+
+    /*
+     * Returns the minimum granularity in which (granularity-aligned pieces
+     * within the memory region) can become either be mapped or unmapped.
+     */
+    uint64_t (*get_granularity)(const SparseRAMHandler *srh,
+                                const MemoryRegion *mr);
+
+    /*
+     * Register a listener for mapping changes.
+     */
+    void (*register_listener)(SparseRAMHandler *srh, const MemoryRegion *mr,
+                              SparseRAMNotifier *notifier);
+
+    /*
+     * Unregister a listener for mapping changes.
+     */
+    void (*unregister_listener)(SparseRAMHandler *srh, const MemoryRegion *mr,
+                                SparseRAMNotifier *notifier);
+
+    /*
+     * Replay notifications for mapped RAM.
+     */
+    int (*replay_mapped)(SparseRAMHandler *srh, const MemoryRegion *mr,
+                         SparseRAMNotifier *notifier);
+};
+
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
 
@@ -399,6 +457,7 @@ struct MemoryRegion {
     const char *name;
     unsigned ioeventfd_nb;
     MemoryRegionIoeventfd *ioeventfds;
+    SparseRAMHandler *srh; /* For RAM only */
 };
 
 struct IOMMUMemoryRegion {
@@ -1889,6 +1948,62 @@ bool memory_region_present(MemoryRegion *container, hwaddr addr);
  */
 bool memory_region_is_mapped(MemoryRegion *mr);
 
+
+static inline SparseRAMHandler* memory_region_get_sparse_ram_handler(
+                                                               MemoryRegion *mr)
+{
+    return mr->srh;
+}
+
+static inline bool memory_region_is_sparse_ram(MemoryRegion *mr)
+{
+    return memory_region_get_sparse_ram_handler(mr) != NULL;
+}
+
+static inline void memory_region_set_sparse_ram_handler(MemoryRegion *mr,
+                                                        SparseRAMHandler *srh)
+{
+    g_assert(memory_region_is_ram(mr));
+    mr->srh = srh;
+}
+
+static inline void memory_region_register_sparse_ram_notifier(MemoryRegion *mr,
+                                                           SparseRAMNotifier *n)
+{
+    SparseRAMHandler *srh = memory_region_get_sparse_ram_handler(mr);
+    SparseRAMHandlerClass *srhc = SPARSE_RAM_HANDLER_GET_CLASS(srh);
+
+    srhc->register_listener(srh, mr, n);
+}
+
+static inline void memory_region_unregister_sparse_ram_notifier(
+                                                               MemoryRegion *mr,
+                                                           SparseRAMNotifier *n)
+{
+    SparseRAMHandler *srh = memory_region_get_sparse_ram_handler(mr);
+    SparseRAMHandlerClass *srhc = SPARSE_RAM_HANDLER_GET_CLASS(srh);
+
+    srhc->unregister_listener(srh, mr, n);
+}
+
+static inline uint64_t memory_region_sparse_ram_get_granularity(
+                                                               MemoryRegion *mr)
+{
+    SparseRAMHandler *srh = memory_region_get_sparse_ram_handler(mr);
+    SparseRAMHandlerClass *srhc = SPARSE_RAM_HANDLER_GET_CLASS(srh);
+
+    return srhc->get_granularity(srh, mr);
+}
+
+static inline int memory_region_sparse_ram_replay_mapped(MemoryRegion *mr,
+                                                         SparseRAMNotifier *n)
+{
+    SparseRAMHandler *srh = memory_region_get_sparse_ram_handler(mr);
+    SparseRAMHandlerClass *srhc = SPARSE_RAM_HANDLER_GET_CLASS(srh);
+
+    return srhc->replay_mapped(srh, mr, n);
+}
+
 /**
  * memory_region_find: translate an address/size relative to a
  * MemoryRegion into a #MemoryRegionSection.
diff --git a/softmmu/memory.c b/softmmu/memory.c
index d030eb6f7c..89649f52f7 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3241,10 +3241,17 @@ static const TypeInfo iommu_memory_region_info = {
     .abstract           = true,
 };
 
+static const TypeInfo sparse_ram_handler_info = {
+    .parent             = TYPE_INTERFACE,
+    .name               = TYPE_SPARSE_RAM_HANDLER,
+    .class_size         = sizeof(SparseRAMHandlerClass),
+};
+
 static void memory_register_types(void)
 {
     type_register_static(&memory_region_info);
     type_register_static(&iommu_memory_region_info);
+    type_register_static(&sparse_ram_handler_info);
 }
 
 type_init(memory_register_types)
-- 
2.26.2


