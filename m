Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3AAC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BCE214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BCE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCn6I-0003Xu-PN
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iCm6w-0007zu-GT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iCm6u-000420-R0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:48:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iCm6u-00041K-JU; Tue, 24 Sep 2019 10:48:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4BC33CA03;
 Tue, 24 Sep 2019 14:48:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B92B10013D9;
 Tue, 24 Sep 2019 14:48:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 3/4] kvm: split too big memory section on several memslots
Date: Tue, 24 Sep 2019 10:47:50 -0400
Message-Id: <20190924144751.24149-4-imammedo@redhat.com>
In-Reply-To: <20190924144751.24149-1-imammedo@redhat.com>
References: <20190924144751.24149-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 24 Sep 2019 14:48:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, peterx@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max memslot size supported by kvm on s390 is 8Tb,
move logic of splitting RAM in chunks upto 8T to KVM code.

This way it will hide KVM specific restrictions in KVM code
and won't affect board level design decisions. Which would allow
us to avoid misusing memory_region_allocate_system_memory() API
and eventually use a single hostmem backend for guest RAM.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v7:
  * rebase on top of Paolo's series
     "kvm: clear dirty bitmaps from all overlapping memslots"
  * use MIN() instead of open coding it
  * keep KVM_SLOT_MAX_BYTES at original place, and deal with
    it in the next s390 specific patch
  * s/slot_size/range_size/ in kvm_physical_log_clear()
  * use temporary MemoryRegionSection variable and keep
    original kvm_get_dirty_pages_log_range() untouched
v6:
  * KVM's migration code was assuming 1:1 relation between
    memslot and MemorySection, which becomes not true fo s390x
    with this patch. As result migration was broken and
    dirty logging wasn't even started with when a MemorySection
    was split on several memslots. Amend related KVM dirty
    log tracking code to account for split MemorySection.
v5:
  * move computation 'size -= slot_size' inside of loop body
          (David Hildenbrand <david@redhat.com>)
v4:
  * fix compilation issue
          (Christian Borntraeger <borntraeger@de.ibm.com>)
  * advance HVA along with GPA in kvm_set_phys_mem()
          (Christian Borntraeger <borntraeger@de.ibm.com>)

patch prepares only KVM side for switching to single RAM memory region
another patch will take care of  dropping manual RAM partitioning in
s390 code.
---
 include/sysemu/kvm_int.h |   1 +
 accel/kvm/kvm-all.c      | 124 +++++++++++++++++++++++++--------------
 2 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 72b2d1b3ae..ac2d1f8b56 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -41,4 +41,5 @@ typedef struct KVMMemoryListener {
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id);
 
+void kvm_set_max_memslot_size(hwaddr max_slot_size);
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 315a91557f..f3848e7e75 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -140,6 +140,7 @@ bool kvm_direct_msi_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 static bool kvm_immediate_exit;
+static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
@@ -437,7 +438,7 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
 static int kvm_section_update_flags(KVMMemoryListener *kml,
                                     MemoryRegionSection *section)
 {
-    hwaddr start_addr, size;
+    hwaddr start_addr, size, slot_size;
     KVMSlot *mem;
     int ret = 0;
 
@@ -448,13 +449,18 @@ static int kvm_section_update_flags(KVMMemoryListener *kml,
 
     kvm_slots_lock(kml);
 
-    mem = kvm_lookup_matching_slot(kml, start_addr, size);
-    if (!mem) {
-        /* We don't have a slot if we want to trap every access. */
-        goto out;
-    }
+    while (size && !ret) {
+        slot_size = MIN(kvm_max_slot_size, size);
+        mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
+        if (!mem) {
+            /* We don't have a slot if we want to trap every access. */
+            goto out;
+        }
 
-    ret = kvm_slot_update_flags(kml, mem, section->mr);
+        ret = kvm_slot_update_flags(kml, mem, section->mr);
+        start_addr += slot_size;
+        size -= slot_size;
+    }
 
 out:
     kvm_slots_unlock(kml);
@@ -527,11 +533,15 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
     struct kvm_dirty_log d = {};
     KVMSlot *mem;
     hwaddr start_addr, size;
+    hwaddr slot_size, slot_offset = 0;
     int ret = 0;
 
     size = kvm_align_section(section, &start_addr);
-    if (size) {
-        mem = kvm_lookup_matching_slot(kml, start_addr, size);
+    while (size) {
+        MemoryRegionSection subsection = *section;
+
+        slot_size = MIN(kvm_max_slot_size, size);
+        mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
             /* We don't have a slot if we want to trap every access. */
             goto out;
@@ -549,11 +559,11 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
          * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
          * a hope that sizeof(long) won't become >8 any time soon.
          */
-        size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
-                     /*HOST_LONG_BITS*/ 64) / 8;
         if (!mem->dirty_bmap) {
+            hwaddr bitmap_size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
+                                        /*HOST_LONG_BITS*/ 64) / 8;
             /* Allocate on the first log_sync, once and for all */
-            mem->dirty_bmap = g_malloc0(size);
+            mem->dirty_bmap = g_malloc0(bitmap_size);
         }
 
         d.dirty_bitmap = mem->dirty_bmap;
@@ -564,7 +574,13 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
             goto out;
         }
 
-        kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
+        subsection.offset_within_region += slot_offset;
+        subsection.size = int128_make64(slot_size);
+        kvm_get_dirty_pages_log_range(&subsection, d.dirty_bitmap);
+
+        slot_offset += slot_size;
+        start_addr += slot_size;
+        size -= slot_size;
     }
 out:
     return ret;
@@ -971,6 +987,14 @@ kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
     return NULL;
 }
 
+void kvm_set_max_memslot_size(hwaddr max_slot_size)
+{
+    g_assert(
+        ROUND_UP(max_slot_size, qemu_real_host_page_size) == max_slot_size
+    );
+    kvm_max_slot_size = max_slot_size;
+}
+
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
 {
@@ -978,7 +1002,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     int err;
     MemoryRegion *mr = section->mr;
     bool writeable = !mr->readonly && !mr->rom_device;
-    hwaddr start_addr, size;
+    hwaddr start_addr, size, slot_size;
     void *ram;
 
     if (!memory_region_is_ram(mr)) {
@@ -1003,41 +1027,52 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     kvm_slots_lock(kml);
 
     if (!add) {
-        mem = kvm_lookup_matching_slot(kml, start_addr, size);
-        if (!mem) {
-            goto out;
-        }
-        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
-            kvm_physical_sync_dirty_bitmap(kml, section);
-        }
+        do {
+            slot_size = MIN(kvm_max_slot_size, size);
+            mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
+            if (!mem) {
+                goto out;
+            }
+            if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+                kvm_physical_sync_dirty_bitmap(kml, section);
+            }
 
-        /* unregister the slot */
-        g_free(mem->dirty_bmap);
-        mem->dirty_bmap = NULL;
-        mem->memory_size = 0;
-        mem->flags = 0;
-        err = kvm_set_user_memory_region(kml, mem, false);
-        if (err) {
-            fprintf(stderr, "%s: error unregistering slot: %s\n",
-                    __func__, strerror(-err));
-            abort();
-        }
+            /* unregister the slot */
+            g_free(mem->dirty_bmap);
+            mem->dirty_bmap = NULL;
+            mem->memory_size = 0;
+            mem->flags = 0;
+            err = kvm_set_user_memory_region(kml, mem, false);
+            if (err) {
+                fprintf(stderr, "%s: error unregistering slot: %s\n",
+                        __func__, strerror(-err));
+                abort();
+            }
+            start_addr += slot_size;
+            size -= slot_size;
+        } while (size);
         goto out;
     }
 
     /* register the new slot */
-    mem = kvm_alloc_slot(kml);
-    mem->memory_size = size;
-    mem->start_addr = start_addr;
-    mem->ram = ram;
-    mem->flags = kvm_mem_flags(mr);
-
-    err = kvm_set_user_memory_region(kml, mem, true);
-    if (err) {
-        fprintf(stderr, "%s: error registering slot: %s\n", __func__,
-                strerror(-err));
-        abort();
-    }
+    do {
+        slot_size = MIN(kvm_max_slot_size, size);
+        mem = kvm_alloc_slot(kml);
+        mem->memory_size = slot_size;
+        mem->start_addr = start_addr;
+        mem->ram = ram;
+        mem->flags = kvm_mem_flags(mr);
+
+        err = kvm_set_user_memory_region(kml, mem, true);
+        if (err) {
+            fprintf(stderr, "%s: error registering slot: %s\n", __func__,
+                    strerror(-err));
+            abort();
+        }
+        start_addr += slot_size;
+        ram += slot_size;
+        size -= slot_size;
+    } while (size);
 
 out:
     kvm_slots_unlock(kml);
@@ -2877,6 +2912,7 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
 
     for (i = 0; i < kvm->nr_as; ++i) {
         if (kvm->as[i].as == as && kvm->as[i].ml) {
+            size = MIN(kvm_max_slot_size, size);
             return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
                                                     start_addr, size);
         }
-- 
2.18.1


