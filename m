Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6894C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD75217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD75217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1RM-00047D-Kv
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54102)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hn1PI-0003Eh-Cz
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hn1PG-0003YY-Ti
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hn1PG-0003YA-LU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01B39307CDD1;
 Mon, 15 Jul 2019 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1ABF5B683;
 Mon, 15 Jul 2019 13:52:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 15:51:16 +0200
Message-Id: <20190715135125.17770-13-quintela@redhat.com>
In-Reply-To: <20190715135125.17770-1-quintela@redhat.com>
References: <20190715135125.17770-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 13:52:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/21] memory: Introduce memory listener hook
 log_clear()
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

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
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is introduced).  However with this
new interface the memory listener users will start to have a chance to
postpone the log clear operation explicitly if the module supports.
That can really benefit users like KVM at least for host kernels that
support KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2.

There are three places that can clear dirty bits in any one of the
dirty bitmap in the ram_list.dirty_memory[3] array:

        cpu_physical_memory_snapshot_and_clear_dirty
        cpu_physical_memory_test_and_clear_dirty
        cpu_physical_memory_sync_dirty_bitmap

Currently we hook directly into each of the functions to notify about
the log_clear().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190603065056.25211-7-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 exec.c                  | 12 ++++++++++
 include/exec/memory.h   | 17 ++++++++++++++
 include/exec/ram_addr.h |  3 +++
 memory.c                | 51 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/exec.c b/exec.c
index 3a00698cc0..3e78de3b8f 100644
--- a/exec.c
+++ b/exec.c
@@ -1358,6 +1358,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_a=
ddr_t start,
     DirtyMemoryBlocks *blocks;
     unsigned long end, page;
     bool dirty =3D false;
+    RAMBlock *ramblock;
+    uint64_t mr_offset, mr_size;
=20
     if (length =3D=3D 0) {
         return false;
@@ -1369,6 +1371,10 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_=
addr_t start,
     rcu_read_lock();
=20
     blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
+    ramblock =3D qemu_get_ram_block(start);
+    /* Range sanity check on the ramblock */
+    assert(start >=3D ramblock->offset &&
+           start + length <=3D ramblock->offset + ramblock->used_length)=
;
=20
     while (page < end) {
         unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
@@ -1380,6 +1386,10 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_=
addr_t start,
         page +=3D num;
     }
=20
+    mr_offset =3D (ram_addr_t)(page << TARGET_PAGE_BITS) - ramblock->off=
set;
+    mr_size =3D (end - page) << TARGET_PAGE_BITS;
+    memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
+
     rcu_read_unlock();
=20
     if (dirty && tcg_enabled()) {
@@ -1435,6 +1445,8 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_a=
nd_clear_dirty
         tlb_reset_dirty_range_all(start, length);
     }
=20
+    memory_region_clear_dirty_bitmap(mr, offset, length);
+
     return snap;
 }
=20
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 70d6f7e451..bb0961ddb9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -416,6 +416,7 @@ struct MemoryListener {
     void (*log_stop)(MemoryListener *listener, MemoryRegionSection *sect=
ion,
                      int old, int new);
     void (*log_sync)(MemoryListener *listener, MemoryRegionSection *sect=
ion);
+    void (*log_clear)(MemoryListener *listener, MemoryRegionSection *sec=
tion);
     void (*log_global_start)(MemoryListener *listener);
     void (*log_global_stop)(MemoryListener *listener);
     void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection *s=
ection,
@@ -1269,6 +1270,22 @@ void memory_region_set_log(MemoryRegion *mr, bool =
log, unsigned client);
 void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size);
=20
+/**
+ * memory_region_clear_dirty_bitmap - clear dirty bitmap for memory rang=
e
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
index 1843b6f2d3..222b4338fb 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -462,6 +462,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlo=
ck *rb,
                 idx++;
             }
         }
+
+        /* TODO: split the huge bitmap into smaller chunks */
+        memory_region_clear_dirty_bitmap(rb->mr, start, length);
     } else {
         ram_addr_t offset =3D rb->offset;
=20
diff --git a/memory.c b/memory.c
index 71fcaf2d00..beac26e173 100644
--- a/memory.c
+++ b/memory.c
@@ -2064,6 +2064,57 @@ static void memory_region_sync_dirty_bitmap(Memory=
Region *mr)
     }
 }
=20
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
+        as =3D listener->address_space;
+        view =3D address_space_get_flatview(as);
+        FOR_EACH_FLAT_RANGE(fr, view) {
+            if (!fr->dirty_log_mask || fr->mr !=3D mr) {
+                /*
+                 * Clear dirty bitmap operation only applies to those
+                 * regions whose dirty logging is at least enabled
+                 */
+                continue;
+            }
+
+            mrs =3D section_from_flat_range(fr, view);
+
+            sec_start =3D MAX(mrs.offset_within_region, start);
+            sec_end =3D mrs.offset_within_region + int128_get64(mrs.size=
);
+            sec_end =3D MIN(sec_end, start + len);
+
+            if (sec_start >=3D sec_end) {
+                /*
+                 * If this memory region section has no intersection
+                 * with the requested range, skip.
+                 */
+                continue;
+            }
+
+            /* Valid case; shrink the section if needed */
+            mrs.offset_within_address_space +=3D
+                sec_start - mrs.offset_within_region;
+            mrs.offset_within_region =3D sec_start;
+            sec_size =3D sec_end - sec_start;
+            mrs.size =3D int128_make64(sec_size);
+            listener->log_clear(listener, &mrs);
+        }
+        flatview_unref(view);
+    }
+}
+
 DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion=
 *mr,
                                                             hwaddr addr,
                                                             hwaddr size,
--=20
2.21.0


