Received: from eggs.gnu.org ([2001:4830:134:3::10]:49183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drSqD-0000pq-E2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drSqC-0008Hq-NS
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drSqC-0008FI-Gs
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:48 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 19:49:32 +0200
Message-Id: <20170911174933.20789-6-david@redhat.com>
In-Reply-To: <20170911174933.20789-1-david@redhat.com>
References: <20170911174933.20789-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/6] kvm: kvm_log_start/stop are only called
 with known sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, david@redhat.com

Let's properly align the sections first and bail out if we would ever
get called with a memory section we don't know yet.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b677d1b13e..2ae459453d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -411,15 +411,21 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
 static int kvm_section_update_flags(KVMMemoryListener *kml,
                                     MemoryRegionSection *section)
 {
-    hwaddr phys_addr = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    KVMSlot *mem = kvm_lookup_matching_slot(kml, phys_addr, size);
+    hwaddr start_addr, size;
+    KVMSlot *mem;
 
-    if (mem == NULL)  {
+    size = kvm_align_section(section, &start_addr);
+    if (!size) {
         return 0;
-    } else {
-        return kvm_slot_update_flags(kml, mem, section->mr);
     }
+
+    mem = kvm_lookup_matching_slot(kml, start_addr, size);
+    if (!mem) {
+        fprintf(stderr, "%s: error finding slot\n", __func__);
+        abort();
+    }
+
+    return kvm_slot_update_flags(kml, mem, section->mr);
 }
 
 static void kvm_log_start(MemoryListener *listener,
-- 
2.13.5
