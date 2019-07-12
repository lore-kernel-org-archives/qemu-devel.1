Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE38C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC33206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC33206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwf0-0003T8-GW
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlwbW-0005xV-IT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlwbV-0001ya-0l
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlwbU-0001yI-PP
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2143990C7A;
 Fri, 12 Jul 2019 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B036608C2;
 Fri, 12 Jul 2019 14:32:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 16:32:04 +0200
Message-Id: <20190712143207.4214-17-quintela@redhat.com>
In-Reply-To: <20190712143207.4214-1-quintela@redhat.com>
References: <20190712143207.4214-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 12 Jul 2019 14:32:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/19] kvm: Introduce slots lock for memory
 listener
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
Message-Id: <20190603065056.25211-10-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 accel/kvm/kvm-all.c      | 58 +++++++++++++++++++++++++++++++---------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 23ace52b9e..621c9a43ab 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -138,6 +138,9 @@ static const KVMCapabilityInfo kvm_required_capabilit=
es[] =3D {
     KVM_CAP_LAST_INFO
 };
=20
+#define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
+#define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s =3D KVM_STATE(current_machine->accelerator);
@@ -165,6 +168,7 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t =
len)
     return 1;
 }
=20
+/* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
     KVMState *s =3D kvm_state;
@@ -182,10 +186,17 @@ static KVMSlot *kvm_get_free_slot(KVMMemoryListener=
 *kml)
 bool kvm_has_free_slot(MachineState *ms)
 {
     KVMState *s =3D KVM_STATE(ms->accelerator);
+    bool result;
+    KVMMemoryListener *kml =3D &s->memory_listener;
=20
-    return kvm_get_free_slot(&s->memory_listener);
+    kvm_slots_lock(kml);
+    result =3D !!kvm_get_free_slot(kml);
+    kvm_slots_unlock(kml);
+
+    return result;
 }
=20
+/* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_alloc_slot(KVMMemoryListener *kml)
 {
     KVMSlot *slot =3D kvm_get_free_slot(kml);
@@ -244,18 +255,21 @@ int kvm_physical_memory_addr_from_host(KVMState *s,=
 void *ram,
                                        hwaddr *phys_addr)
 {
     KVMMemoryListener *kml =3D &s->memory_listener;
-    int i;
+    int i, ret =3D 0;
=20
+    kvm_slots_lock(kml);
     for (i =3D 0; i < s->nr_slots; i++) {
         KVMSlot *mem =3D &kml->slots[i];
=20
         if (ram >=3D mem->ram && ram < mem->ram + mem->memory_size) {
             *phys_addr =3D mem->start_addr + (ram - mem->ram);
-            return 1;
+            ret =3D 1;
+            break;
         }
     }
+    kvm_slots_unlock(kml);
=20
-    return 0;
+    return ret;
 }
=20
 static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *s=
lot, bool new)
@@ -396,6 +410,7 @@ static int kvm_mem_flags(MemoryRegion *mr)
     return flags;
 }
=20
+/* Called with KVMMemoryListener.slots_lock held */
 static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
                                  MemoryRegion *mr)
 {
@@ -414,19 +429,26 @@ static int kvm_section_update_flags(KVMMemoryListen=
er *kml,
 {
     hwaddr start_addr, size;
     KVMSlot *mem;
+    int ret =3D 0;
=20
     size =3D kvm_align_section(section, &start_addr);
     if (!size) {
         return 0;
     }
=20
+    kvm_slots_lock(kml);
+
     mem =3D kvm_lookup_matching_slot(kml, start_addr, size);
     if (!mem) {
         /* We don't have a slot if we want to trap every access. */
-        return 0;
+        goto out;
     }
=20
-    return kvm_slot_update_flags(kml, mem, section->mr);
+    ret =3D kvm_slot_update_flags(kml, mem, section->mr);
+
+out:
+    kvm_slots_unlock(kml);
+    return ret;
 }
=20
 static void kvm_log_start(MemoryListener *listener,
@@ -483,6 +505,8 @@ static int kvm_get_dirty_pages_log_range(MemoryRegion=
Section *section,
  * This function will first try to fetch dirty bitmap from the kernel,
  * and then updates qemu's dirty bitmap.
  *
+ * NOTE: caller must be with kml->slots_lock held.
+ *
  * @kml: the KVM memory listener object
  * @section: the memory section to sync the dirty bitmap with
  */
@@ -493,13 +517,14 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemory=
Listener *kml,
     struct kvm_dirty_log d =3D {};
     KVMSlot *mem;
     hwaddr start_addr, size;
+    int ret =3D 0;
=20
     size =3D kvm_align_section(section, &start_addr);
     if (size) {
         mem =3D kvm_lookup_matching_slot(kml, start_addr, size);
         if (!mem) {
             /* We don't have a slot if we want to trap every access. */
-            return 0;
+            goto out;
         }
=20
         /* XXX bad kernel interface alert
@@ -525,13 +550,14 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemory=
Listener *kml,
         d.slot =3D mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) =3D=3D -1) {
             DPRINTF("ioctl failed %d\n", errno);
-            return -1;
+            ret =3D -1;
+            goto out;
         }
=20
         kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
     }
-
-    return 0;
+out:
+    return ret;
 }
=20
 static void kvm_coalesce_mmio_region(MemoryListener *listener,
@@ -793,10 +819,12 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
     ram =3D memory_region_get_ram_ptr(mr) + section->offset_within_regio=
n +
           (start_addr - section->offset_within_address_space);
=20
+    kvm_slots_lock(kml);
+
     if (!add) {
         mem =3D kvm_lookup_matching_slot(kml, start_addr, size);
         if (!mem) {
-            return;
+            goto out;
         }
         if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
             kvm_physical_sync_dirty_bitmap(kml, section);
@@ -813,7 +841,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                     __func__, strerror(-err));
             abort();
         }
-        return;
+        goto out;
     }
=20
     /* register the new slot */
@@ -829,6 +857,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                 strerror(-err));
         abort();
     }
+
+out:
+    kvm_slots_unlock(kml);
 }
=20
 static void kvm_region_add(MemoryListener *listener,
@@ -855,7 +886,9 @@ static void kvm_log_sync(MemoryListener *listener,
     KVMMemoryListener *kml =3D container_of(listener, KVMMemoryListener,=
 listener);
     int r;
=20
+    kvm_slots_lock(kml);
     r =3D kvm_physical_sync_dirty_bitmap(kml, section);
+    kvm_slots_unlock(kml);
     if (r < 0) {
         abort();
     }
@@ -939,6 +972,7 @@ void kvm_memory_listener_register(KVMState *s, KVMMem=
oryListener *kml,
 {
     int i;
=20
+    qemu_mutex_init(&kml->slots_lock);
     kml->slots =3D g_malloc0(s->nr_slots * sizeof(KVMSlot));
     kml->as_id =3D as_id;
=20
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 687a2ee423..31df465fdc 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -27,6 +27,8 @@ typedef struct KVMSlot
=20
 typedef struct KVMMemoryListener {
     MemoryListener listener;
+    /* Protects the slots and all inside them */
+    QemuMutex slots_lock;
     KVMSlot *slots;
     int as_id;
 } KVMMemoryListener;
--=20
2.21.0


