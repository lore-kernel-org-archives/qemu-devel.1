Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED37C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1BA27C73
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1BA27C73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgy5-0006qF-62
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:01:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgog-0007uf-QC
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgof-0002Rz-9R
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hXgof-0002Qn-1g
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AD38308402F
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 06:51:32 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EFE5648B0;
	Mon,  3 Jun 2019 06:51:29 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 14:50:54 +0800
Message-Id: <20190603065056.25211-10-peterx@redhat.com>
In-Reply-To: <20190603065056.25211-1-peterx@redhat.com>
References: <20190603065056.25211-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 03 Jun 2019 06:51:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 09/11] kvm: Introduce slots lock for memory
 listener
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

Introduce KVMMemoryListener.slots_lock to protect the slots inside the
kvm memory listener.  Currently it is close to useless because all the
KVM code path now is always protected by the BQL.  But it'll start to
make sense in follow up patches where we might do remote dirty bitmap
clear and also we'll update the per-slot cached dirty bitmap even
without the BQL.  So let's prepare for it.

We can also use per-slot lock for above reason but it seems to be an
overkill.  Let's just use this bigger one (which covers all the slots
of a single address space) but anyway this lock is still much smaller
than the BQL.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 58 +++++++++++++++++++++++++++++++---------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9fb0694772..e3006006ea 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -138,6 +138,9 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_LAST_INFO
 };
 
+#define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
+#define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_machine->accelerator);
@@ -165,6 +168,7 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
     return 1;
 }
 
+/* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
     KVMState *s = kvm_state;
@@ -182,10 +186,17 @@ static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 bool kvm_has_free_slot(MachineState *ms)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
+    bool result;
+    KVMMemoryListener *kml = &s->memory_listener;
+
+    kvm_slots_lock(kml);
+    result = !!kvm_get_free_slot(kml);
+    kvm_slots_unlock(kml);
 
-    return kvm_get_free_slot(&s->memory_listener);
+    return result;
 }
 
+/* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_alloc_slot(KVMMemoryListener *kml)
 {
     KVMSlot *slot = kvm_get_free_slot(kml);
@@ -244,18 +255,21 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
                                        hwaddr *phys_addr)
 {
     KVMMemoryListener *kml = &s->memory_listener;
-    int i;
+    int i, ret = 0;
 
+    kvm_slots_lock(kml);
     for (i = 0; i < s->nr_slots; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (ram >= mem->ram && ram < mem->ram + mem->memory_size) {
             *phys_addr = mem->start_addr + (ram - mem->ram);
-            return 1;
+            ret = 1;
+            break;
         }
     }
+    kvm_slots_unlock(kml);
 
-    return 0;
+    return ret;
 }
 
 static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
@@ -391,6 +405,7 @@ static int kvm_mem_flags(MemoryRegion *mr)
     return flags;
 }
 
+/* Called with KVMMemoryListener.slots_lock held */
 static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
                                  MemoryRegion *mr)
 {
@@ -409,19 +424,26 @@ static int kvm_section_update_flags(KVMMemoryListener *kml,
 {
     hwaddr start_addr, size;
     KVMSlot *mem;
+    int ret = 0;
 
     size = kvm_align_section(section, &start_addr);
     if (!size) {
         return 0;
     }
 
+    kvm_slots_lock(kml);
+
     mem = kvm_lookup_matching_slot(kml, start_addr, size);
     if (!mem) {
         /* We don't have a slot if we want to trap every access. */
-        return 0;
+        goto out;
     }
 
-    return kvm_slot_update_flags(kml, mem, section->mr);
+    ret = kvm_slot_update_flags(kml, mem, section->mr);
+
+out:
+    kvm_slots_unlock(kml);
+    return ret;
 }
 
 static void kvm_log_start(MemoryListener *listener,
@@ -478,6 +500,8 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
  * This function will first try to fetch dirty bitmap from the kernel,
  * and then updates qemu's dirty bitmap.
  *
+ * NOTE: caller must be with kml->slots_lock held.
+ *
  * @kml: the KVM memory listener object
  * @section: the memory section to sync the dirty bitmap with
  */
@@ -488,13 +512,14 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
     struct kvm_dirty_log d = {};
     KVMSlot *mem;
     hwaddr start_addr, size;
+    int ret = 0;
 
     size = kvm_align_section(section, &start_addr);
     if (size) {
         mem = kvm_lookup_matching_slot(kml, start_addr, size);
         if (!mem) {
             /* We don't have a slot if we want to trap every access. */
-            return 0;
+            goto out;
         }
 
         /* XXX bad kernel interface alert
@@ -520,13 +545,14 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
         d.slot = mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
             DPRINTF("ioctl failed %d\n", errno);
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
     }
-
-    return 0;
+out:
+    return ret;
 }
 
 static void kvm_coalesce_mmio_region(MemoryListener *listener,
@@ -788,10 +814,12 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     ram = memory_region_get_ram_ptr(mr) + section->offset_within_region +
           (start_addr - section->offset_within_address_space);
 
+    kvm_slots_lock(kml);
+
     if (!add) {
         mem = kvm_lookup_matching_slot(kml, start_addr, size);
         if (!mem) {
-            return;
+            goto out;
         }
         if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
             kvm_physical_sync_dirty_bitmap(kml, section);
@@ -808,7 +836,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                     __func__, strerror(-err));
             abort();
         }
-        return;
+        goto out;
     }
 
     /* register the new slot */
@@ -824,6 +852,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                 strerror(-err));
         abort();
     }
+
+out:
+    kvm_slots_unlock(kml);
 }
 
 static void kvm_region_add(MemoryListener *listener,
@@ -850,7 +881,9 @@ static void kvm_log_sync(MemoryListener *listener,
     KVMMemoryListener *kml = container_of(listener, KVMMemoryListener, listener);
     int r;
 
+    kvm_slots_lock(kml);
     r = kvm_physical_sync_dirty_bitmap(kml, section);
+    kvm_slots_unlock(kml);
     if (r < 0) {
         abort();
     }
@@ -930,6 +963,7 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
 {
     int i;
 
+    qemu_mutex_init(&kml->slots_lock);
     kml->slots = g_malloc0(s->nr_slots * sizeof(KVMSlot));
     kml->as_id = as_id;
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 687a2ee423..31df465fdc 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -27,6 +27,8 @@ typedef struct KVMSlot
 
 typedef struct KVMMemoryListener {
     MemoryListener listener;
+    /* Protects the slots and all inside them */
+    QemuMutex slots_lock;
     KVMSlot *slots;
     int as_id;
 } KVMMemoryListener;
-- 
2.17.1


