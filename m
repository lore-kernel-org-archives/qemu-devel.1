Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A374C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC9E21019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC9E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60171 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOG16-0001Di-Dn
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:25:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hOFrq-0000op-Mf
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hOFrp-0004CG-Az
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hOFrp-0004Bc-3Z
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 701D83082E72
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 06:15:48 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 34ADD16BF0;
	Wed,  8 May 2019 06:15:43 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 14:15:18 +0800
Message-Id: <20190508061523.17666-7-peterx@redhat.com>
In-Reply-To: <20190508061523.17666-1-peterx@redhat.com>
References: <20190508061523.17666-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 08 May 2019 06:15:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 06/11] memory: Introduce memory listener hook
 log_clear()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a new memory region listener hook log_clear() to allow the
listeners to hook onto the points where the dirty bitmap is cleared by
the bitmap users.

Previously log_sync() contains two operations:

  - dirty bitmap collection, and,
  - dirty bitmap clear on remote site.

Let's take KVM as example - log_sync() for KVM will first copy the
kernel dirty bitmap to userspace, and at the same time we'll clear the
dirty bitmap there along with re-protecting all the guest pages again.

We add this new log_clear() interface only to split the old log_sync()
into two separated procedures:

  - use log_sync() to collect the collection only, and,
  - use log_clear() to clear the remote dirty bitmap.

With the new interface, the memory listener users will still be able
to decide how to implement the log synchronization procedure, e.g.,
they can still only provide log_sync() method only and put all the two
procedures within log_sync() (that's how the old KVM works before
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT is introduced).  However with this
new interface the memory listener users will start to have a chance to
postpone the log clear operation explicitly if the module supports.
That can really benefit users like KVM at least for host kernels that
support KVM_CAP_MANUAL_DIRTY_LOG_PROTECT.

There are three places that can clear dirty bits in any one of the
dirty bitmap in the ram_list.dirty_memory[3] array:

        cpu_physical_memory_snapshot_and_clear_dirty
        cpu_physical_memory_test_and_clear_dirty
        cpu_physical_memory_sync_dirty_bitmap

Currently we hook directly into each of the functions to notify about
the log_clear().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c                  | 12 ++++++++++
 include/exec/memory.h   | 17 ++++++++++++++
 include/exec/ram_addr.h |  3 +++
 memory.c                | 51 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/exec.c b/exec.c
index 2615b4cfed..ab595e1e4b 100644
--- a/exec.c
+++ b/exec.c
@@ -1355,6 +1355,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
     DirtyMemoryBlocks *blocks;
     unsigned long end, page;
     bool dirty = false;
+    RAMBlock *ramblock;
+    uint64_t mr_offset, mr_size;
 
     if (length == 0) {
         return false;
@@ -1366,6 +1368,10 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
     rcu_read_lock();
 
     blocks = atomic_rcu_read(&ram_list.dirty_memory[client]);
+    ramblock = qemu_get_ram_block(start);
+    /* Range sanity check on the ramblock */
+    assert(start >= ramblock->offset &&
+           start + length <= ramblock->offset + ramblock->used_length);
 
     while (page < end) {
         unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
@@ -1377,6 +1383,10 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
         page += num;
     }
 
+    mr_offset = (ram_addr_t)(page << TARGET_PAGE_BITS) - ramblock->offset;
+    mr_size = (end - page) << TARGET_PAGE_BITS;
+    memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
+
     rcu_read_unlock();
 
     if (dirty && tcg_enabled()) {
@@ -1432,6 +1442,8 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
         tlb_reset_dirty_range_all(start, length);
     }
 
+    memory_region_clear_dirty_bitmap(mr, addr, length);
+
     return snap;
 }
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index f29300c54d..d752b2a758 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -416,6 +416,7 @@ struct MemoryListener {
     void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
                      int old, int new);
     void (*log_sync)(MemoryListener *listener, MemoryRegionSection *section);
+    void (*log_clear)(MemoryListener *listener, MemoryRegionSection *section);
     void (*log_global_start)(MemoryListener *listener);
     void (*log_global_stop)(MemoryListener *listener);
     void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection *section,
@@ -1269,6 +1270,22 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client);
 void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size);
 
+/**
+ * memory_region_clear_dirty_bitmap - clear dirty bitmap for memory range
+ *
+ * This function is called when the caller wants to clear the remote
+ * dirty bitmap of a memory range within the memory region.  This can
+ * be used by e.g. KVM to manually clear dirty log when
+ * KVM_CAP_MANUAL_DIRTY_LOG_PROTECT is declared support by the host
+ * kernel.
+ *
+ * @mr:     the memory region to clear the dirty log upon
+ * @start:  start address offset within the memory region
+ * @len:    length of the memory region to clear dirty bitmap
+ */
+void memory_region_clear_dirty_bitmap(MemoryRegion *mr, hwaddr start,
+                                      hwaddr len);
+
 /**
  * memory_region_snapshot_and_clear_dirty: Get a snapshot of the dirty
  *                                         bitmap and clear it.
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 69cc528c98..896324281a 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -461,6 +461,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                 idx++;
             }
         }
+
+        /* TODO: split the huge bitmap into smaller chunks */
+        memory_region_clear_dirty_bitmap(rb->mr, start, length);
     } else {
         ram_addr_t offset = rb->offset;
 
diff --git a/memory.c b/memory.c
index be16beea76..b4e2c41ba0 100644
--- a/memory.c
+++ b/memory.c
@@ -2064,6 +2064,57 @@ static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
     }
 }
 
+void memory_region_clear_dirty_bitmap(MemoryRegion *mr, hwaddr start,
+                                      hwaddr len)
+{
+    MemoryRegionSection mrs;
+    MemoryListener *listener;
+    AddressSpace *as;
+    FlatView *view;
+    FlatRange *fr;
+    hwaddr sec_start, sec_end, sec_size;
+
+    QTAILQ_FOREACH(listener, &memory_listeners, link) {
+        if (!listener->log_clear) {
+            continue;
+        }
+        as = listener->address_space;
+        view = address_space_get_flatview(as);
+        FOR_EACH_FLAT_RANGE(fr, view) {
+            if (!fr->dirty_log_mask || fr->mr != mr) {
+                /*
+                 * Clear dirty bitmap operation only applies to those
+                 * regions whose dirty logging is at least enabled
+                 */
+                continue;
+            }
+
+            mrs = section_from_flat_range(fr, view);
+
+            sec_start = MAX(mrs.offset_within_region, start);
+            sec_end = mrs.offset_within_region + int128_get64(mrs.size);
+            sec_end = MIN(sec_end, start + len);
+
+            if (sec_start >= sec_end) {
+                /*
+                 * If this memory region section has no intersection
+                 * with the requested range, skip.
+                 */
+                continue;
+            }
+
+            /* Valid case; shrink the section if needed */
+            mrs.offset_within_address_space +=
+                sec_start - mrs.offset_within_region;
+            mrs.offset_within_region = sec_start;
+            sec_size = sec_end - sec_start;
+            mrs.size = int128_make64(sec_size);
+            listener->log_clear(listener, &mrs);
+        }
+        flatview_unref(view);
+    }
+}
+
 DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
                                                             hwaddr addr,
                                                             hwaddr size,
-- 
2.17.1


