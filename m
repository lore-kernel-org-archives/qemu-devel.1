Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30618C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB323214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB323214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9r0u-00060d-JR
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 09:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i9qz4-0004vF-4P
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i9qz1-00009L-QT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1941)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i9qz1-000093-Hm; Mon, 16 Sep 2019 09:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA324693D6;
 Mon, 16 Sep 2019 13:23:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6C5C10027AA;
 Mon, 16 Sep 2019 13:23:55 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 09:23:46 -0400
Message-Id: <20190916132347.30676-2-imammedo@redhat.com>
In-Reply-To: <20190916132347.30676-1-imammedo@redhat.com>
References: <20190916132347.30676-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 16 Sep 2019 13:23:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 1/2] kvm: s390: split too big memory section
 on several memslots
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, dgilbert@redhat.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com
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
Since there is quite a bit of migration related code churn in the patch
CCing migration maintainer

CC: dgilbert@redhat.com

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


 include/sysemu/kvm_int.h   |   1 +
 accel/kvm/kvm-all.c        | 239 ++++++++++++++++++++++---------------
 hw/s390x/s390-virtio-ccw.c |   9 --
 target/s390x/kvm.c         |  12 ++
 4 files changed, 159 insertions(+), 102 deletions(-)

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
index b09bad0804..0635903408 100644
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
+        slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;
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
@@ -497,11 +503,14 @@ static void kvm_log_stop(MemoryListener *listener,
 
 /* get kvm's dirty pages bitmap and update qemu's */
 static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
+                                         hwaddr offset_in_section,
+                                         hwaddr range_size,
                                          unsigned long *bitmap)
 {
     ram_addr_t start = section->offset_within_region +
+                       offset_in_section +
                        memory_region_get_ram_addr(section->mr);
-    ram_addr_t pages = int128_get64(section->size) / getpagesize();
+    ram_addr_t pages = range_size / getpagesize();
 
     cpu_physical_memory_set_dirty_lebitmap(bitmap, start, pages);
     return 0;
@@ -527,11 +536,13 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
     struct kvm_dirty_log d = {};
     KVMSlot *mem;
     hwaddr start_addr, size;
+    hwaddr slot_size, slot_offset = 0;
     int ret = 0;
 
     size = kvm_align_section(section, &start_addr);
-    if (size) {
-        mem = kvm_lookup_matching_slot(kml, start_addr, size);
+    while (size) {
+        slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;
+        mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
             /* We don't have a slot if we want to trap every access. */
             goto out;
@@ -549,11 +560,11 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
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
@@ -564,7 +575,12 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
             goto out;
         }
 
-        kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
+        kvm_get_dirty_pages_log_range(section, slot_offset, slot_size,
+                                      d.dirty_bitmap);
+
+        slot_offset += slot_size;
+        start_addr += slot_size;
+        size -= slot_size;
     }
 out:
     return ret;
@@ -575,55 +591,14 @@ out:
 #define KVM_CLEAR_LOG_ALIGN  (qemu_real_host_page_size << KVM_CLEAR_LOG_SHIFT)
 #define KVM_CLEAR_LOG_MASK   (-KVM_CLEAR_LOG_ALIGN)
 
-/**
- * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
- *
- * NOTE: this will be a no-op if we haven't enabled manual dirty log
- * protection in the host kernel because in that case this operation
- * will be done within log_sync().
- *
- * @kml:     the kvm memory listener
- * @section: the memory range to clear dirty bitmap
- */
-static int kvm_physical_log_clear(KVMMemoryListener *kml,
-                                  MemoryRegionSection *section)
+static int kvm_physical_log_slot_clear(uint64_t start, uint64_t size,
+                                       KVMSlot *mem, int as_id)
 {
     KVMState *s = kvm_state;
-    struct kvm_clear_dirty_log d;
-    uint64_t start, end, bmap_start, start_delta, bmap_npages, size;
     unsigned long *bmap_clear = NULL, psize = qemu_real_host_page_size;
-    KVMSlot *mem = NULL;
-    int ret, i;
-
-    if (!s->manual_dirty_log_protect) {
-        /* No need to do explicit clear */
-        return 0;
-    }
-
-    start = section->offset_within_address_space;
-    size = int128_get64(section->size);
-
-    if (!size) {
-        /* Nothing more we can do... */
-        return 0;
-    }
-
-    kvm_slots_lock(kml);
-
-    /* Find any possible slot that covers the section */
-    for (i = 0; i < s->nr_slots; i++) {
-        mem = &kml->slots[i];
-        if (mem->start_addr <= start &&
-            start + size <= mem->start_addr + mem->memory_size) {
-            break;
-        }
-    }
-
-    /*
-     * We should always find one memslot until this point, otherwise
-     * there could be something wrong from the upper layer
-     */
-    assert(mem && i != s->nr_slots);
+    uint64_t end, bmap_start, start_delta, bmap_npages;
+    struct kvm_clear_dirty_log d;
+    int ret;
 
     /*
      * We need to extend either the start or the size or both to
@@ -694,7 +669,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
     /* It should never overflow.  If it happens, say something */
     assert(bmap_npages <= UINT32_MAX);
     d.num_pages = bmap_npages;
-    d.slot = mem->slot | (kml->as_id << 16);
+    d.slot = mem->slot | (as_id << 16);
 
     if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) == -1) {
         ret = -errno;
@@ -718,8 +693,66 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
     /* This handles the NULL case well */
     g_free(bmap_clear);
 
-    kvm_slots_unlock(kml);
+    return ret;
+}
+
+/**
+ * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
+ *
+ * NOTE: this will be a no-op if we haven't enabled manual dirty log
+ * protection in the host kernel because in that case this operation
+ * will be done within log_sync().
+ *
+ * @kml:     the kvm memory listener
+ * @section: the memory range to clear dirty bitmap
+ */
+static int kvm_physical_log_clear(KVMMemoryListener *kml,
+                                  MemoryRegionSection *section)
+{
+    KVMState *s = kvm_state;
+    uint64_t start, size, slot_size;
+    KVMSlot *mem = NULL;
+    int i, ret = 0;
+
+    if (!s->manual_dirty_log_protect) {
+        /* No need to do explicit clear */
+        return 0;
+    }
+
+    start = section->offset_within_address_space;
+    size = int128_get64(section->size);
+
+    if (!size) {
+        /* Nothing more we can do... */
+        return 0;
+    }
+
+    kvm_slots_lock(kml);
+
+    while (size) {
+        slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;
+        /* Iterate over slots that cover the section */
+        for (i = 0; i < s->nr_slots; i++) {
+            mem = &kml->slots[i];
+            if (mem->start_addr <= start &&
+                start + slot_size <= mem->start_addr + mem->memory_size) {
+                break;
+            }
+        }
 
+        /*
+         * We should always find one memslot until this point, otherwise
+         * there could be something wrong from the upper layer
+         */
+        assert(mem && i != s->nr_slots);
+
+        kvm_physical_log_slot_clear(start, slot_size, mem, kml->as_id);
+
+        size -= slot_size;
+        start += slot_size;
+    }
+
+    kvm_slots_unlock(kml);
     return ret;
 }
 
@@ -953,6 +986,14 @@ kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
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
@@ -960,7 +1001,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     int err;
     MemoryRegion *mr = section->mr;
     bool writeable = !mr->readonly && !mr->rom_device;
-    hwaddr start_addr, size;
+    hwaddr start_addr, size, slot_size;
     void *ram;
 
     if (!memory_region_is_ram(mr)) {
@@ -985,41 +1026,52 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
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
+            slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;
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
+        slot_size = kvm_max_slot_size < size ? kvm_max_slot_size : size;
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
@@ -2859,6 +2911,7 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
 
     for (i = 0; i < kvm->nr_as; ++i) {
         if (kvm->as[i].as == as && kvm->as[i].ml) {
+            size = kvm_max_slot_size < size ? kvm_max_slot_size : size;
             return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
                                                     start_addr, size);
         }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8bfb6684cb..baa95aad38 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -154,15 +154,6 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
 }
 
-/*
- * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
- * as the dirty bitmap must be managed by bitops that take an int as
- * position indicator. If we have a guest beyond that we will split off
- * new subregions. The split must happen on a segment boundary (1MB).
- */
-#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
-#define SEG_MSK (~0xfffffULL)
-#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
 static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index cea71ac7c3..838d23cb17 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -28,6 +28,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_s390x.h"
+#include "sysemu/kvm_int.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -123,6 +124,16 @@
 #define VCPU_IRQ_BUF_SIZE(max_cpus) (sizeof(struct kvm_s390_irq) * \
                                      (max_cpus + NR_LOCAL_IRQS))
 
+/*
+ * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
+ * as the dirty bitmap must be managed by bitops that take an int as
+ * position indicator. If we have a guest beyond that we will split off
+ * new subregions. The split must happen on a segment boundary (1MB).
+ */
+#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
+#define SEG_MSK (~0xfffffULL)
+#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
+
 static CPUWatchpoint hw_watchpoint;
 /*
  * We don't use a list because this structure is also used to transmit the
@@ -348,6 +359,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      */
     /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
 
+    kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
     return 0;
 }
 
-- 
2.18.1


