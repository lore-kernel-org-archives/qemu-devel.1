Received: from eggs.gnu.org ([2001:4830:134:3::10]:60014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfP-0004Cm-R0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfL-0005V8-VA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:19 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfL-0005UB-OP
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:15 -0400
Received: by mail-wm0-x243.google.com with SMTP id m127so3757100wmm.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:17 +0200
Message-Id: <1505824179-21541-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/50] kvm: use start + size for memory ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Convert kvm_lookup_matching_slot().

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170911174933.20789-4-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e0d100b..88b0e63 100644
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
1.8.3.1
