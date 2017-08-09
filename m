Received: from eggs.gnu.org ([2001:4830:134:3::10]:59103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfR7U-0008T8-2S
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfR7R-0003Q6-MQ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dfR7R-0003PG-Db
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:53 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed,  9 Aug 2017 15:33:41 +0200
Message-Id: <20170809133346.30271-2-david@redhat.com>
In-Reply-To: <20170809133346.30271-1-david@redhat.com>
References: <20170809133346.30271-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/6] kvm: require JOIN_MEMORY_REGIONS_WORKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, david@redhat.com

We already require DESTROY_MEMORY_REGION_WORKS, JOIN_MEMORY_REGIONS_WORKS
was added just half a year later.

In addition, with flatview overlapping memory regions are first
removed before adding the changed one. So we can't really detect joining
memory regions this way.

Let's just get rid of this special handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 46ce479..eae61bb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -79,7 +79,6 @@ struct KVMState
     int coalesced_mmio;
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
-    int broken_set_mem_region;
     int vcpu_events;
     int robust_singlestep;
     int debugregs;
@@ -127,6 +126,7 @@ static bool kvm_immediate_exit;
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
+    KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
     KVM_CAP_LAST_INFO
 };
 
@@ -696,7 +696,6 @@ kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
 {
-    KVMState *s = kvm_state;
     KVMSlot *mem, old;
     int err;
     MemoryRegion *mr = section->mr;
@@ -763,35 +762,6 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        /* Workaround for older KVM versions: we can't join slots, even not by
-         * unregistering the previous ones and then registering the larger
-         * slot. We have to maintain the existing fragmentation. Sigh.
-         *
-         * This workaround assumes that the new slot starts at the same
-         * address as the first existing one. If not or if some overlapping
-         * slot comes around later, we will fail (not seen in practice so far)
-         * - and actually require a recent KVM version. */
-        if (s->broken_set_mem_region &&
-            old.start_addr == start_addr && old.memory_size < size && add) {
-            mem = kvm_alloc_slot(kml);
-            mem->memory_size = old.memory_size;
-            mem->start_addr = old.start_addr;
-            mem->ram = old.ram;
-            mem->flags = kvm_mem_flags(mr);
-
-            err = kvm_set_user_memory_region(kml, mem);
-            if (err) {
-                fprintf(stderr, "%s: error updating slot: %s\n", __func__,
-                        strerror(-err));
-                abort();
-            }
-
-            start_addr += old.memory_size;
-            ram += old.memory_size;
-            size -= old.memory_size;
-            continue;
-        }
-
         /* register prefix slot */
         if (old.start_addr < start_addr) {
             mem = kvm_alloc_slot(kml);
@@ -833,10 +803,6 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         }
     }
 
-    /* in case the KVM bug workaround already "consumed" the new slot */
-    if (!size) {
-        return;
-    }
     if (!add) {
         return;
     }
@@ -1692,12 +1658,6 @@ static int kvm_init(MachineState *ms)
 
     s->coalesced_mmio = kvm_check_extension(s, KVM_CAP_COALESCED_MMIO);
 
-    s->broken_set_mem_region = 1;
-    ret = kvm_check_extension(s, KVM_CAP_JOIN_MEMORY_REGIONS_WORKS);
-    if (ret > 0) {
-        s->broken_set_mem_region = 0;
-    }
-
 #ifdef KVM_CAP_VCPU_EVENTS
     s->vcpu_events = kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
 #endif
-- 
2.9.4
