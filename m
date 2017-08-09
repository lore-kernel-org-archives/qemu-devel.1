Received: from eggs.gnu.org ([2001:4830:134:3::10]:59138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfR7W-0008TC-D2
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfR7U-0003T0-Ou
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dfR7U-0003S6-IY
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed,  9 Aug 2017 15:33:43 +0200
Message-Id: <20170809133346.30271-4-david@redhat.com>
In-Reply-To: <20170809133346.30271-1-david@redhat.com>
References: <20170809133346.30271-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/6] kvm: use start + size for memory ranges
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

Convert kvm_lookup_matching_slot().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f6ceeba..bec157e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -172,7 +172,7 @@ static KVMSlot *kvm_alloc_slot(KVMMemoryListener *kml)
 
 static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
                                          hwaddr start_addr,
-                                         hwaddr end_addr)
+                                         hwaddr size)
 {
     KVMState *s = kvm_state;
     int i;
@@ -180,8 +180,7 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
     for (i = 0; i < s->nr_slots; i++) {
         KVMSlot *mem = &kml->slots[i];
 
-        if (start_addr == mem->start_addr &&
-            end_addr == mem->start_addr + mem->memory_size) {
+        if (start_addr == mem->start_addr && size == mem->memory_size) {
             return mem;
         }
     }
@@ -414,7 +413,7 @@ static int kvm_section_update_flags(KVMMemoryListener *kml,
 {
     hwaddr phys_addr = section->offset_within_address_space;
     ram_addr_t size = int128_get64(section->size);
-    KVMSlot *mem = kvm_lookup_matching_slot(kml, phys_addr, phys_addr + size);
+    KVMSlot *mem = kvm_lookup_matching_slot(kml, phys_addr, size);
 
     if (mem == NULL)  {
         return 0;
-- 
2.9.4
