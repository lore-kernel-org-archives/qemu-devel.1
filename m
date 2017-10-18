Received: from eggs.gnu.org ([2001:4830:134:3::10]:36060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyG-0003gq-31
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyC-0002Hf-5o
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:28 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:48423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyB-0002H0-Ut
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:24 -0400
Received: by mail-wm0-x243.google.com with SMTP id i124so10878405wmf.3
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:12 +0200
Message-Id: <1508343141-31835-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/29] kvm: region_add and region_del is not
 called on updates
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

Attributes are not updated via region_add()/region_del(). Attribute changes
lead to a delete first, followed by a new add.

If this would ever not be the case, we would get an error when trying to
register the new slot.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016144302.24284-6-david@redhat.com>
Tested-by: Joe Clifford <joeclifford@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 559c544..2835bb3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -721,8 +721,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     ram = memory_region_get_ram_ptr(mr) + section->offset_within_region +
           (start_addr - section->offset_within_address_space);
 
-    mem = kvm_lookup_matching_slot(kml, start_addr, size);
     if (!add) {
+        mem = kvm_lookup_matching_slot(kml, start_addr, size);
         if (!mem) {
             return;
         }
@@ -741,12 +741,6 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         return;
     }
 
-    if (mem) {
-        /* update the slot */
-        kvm_slot_update_flags(kml, mem, mr);
-        return;
-    }
-
     /* register the new slot */
     mem = kvm_alloc_slot(kml);
     mem->memory_size = size;
-- 
1.8.3.1
