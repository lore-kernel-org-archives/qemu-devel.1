Received: from eggs.gnu.org ([2001:4830:134:3::10]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfO-0004Bx-Sc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfO-0005WT-4K
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:18 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfN-0005Vl-Uv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:18 -0400
Received: by mail-wm0-x243.google.com with SMTP id i131so3750077wma.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:19 +0200
Message-Id: <1505824179-21541-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/50] kvm: kvm_log_start/stop are only called
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's properly align the sections first and bail out if we would ever
get called with a memory section we don't know yet.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170911174933.20789-6-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b677d1b..2ae4594 100644
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
1.8.3.1
