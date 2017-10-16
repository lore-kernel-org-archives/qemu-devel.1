Received: from eggs.gnu.org ([2001:4830:134:3::10]:51001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46c1-00053B-Ac
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46c0-0005li-H8
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e46c0-0005jb-Bv
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:24 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Oct 2017 16:43:00 +0200
Message-Id: <20171016144302.24284-6-david@redhat.com>
In-Reply-To: <20171016144302.24284-1-david@redhat.com>
References: <20171016144302.24284-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/7] kvm: region_add and region_del is not
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
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joe Clifford <joeclifford@gmail.com>, David Hildenbrand <david@redhat.com>

Attributes are not updated via region_add()/region_del(). Attribute changes
lead to a delete first, followed by a new add.

If this would ever not be the case, we would get an error when trying to
register the new slot.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 559c544501..2835bb3801 100644
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
2.13.5
