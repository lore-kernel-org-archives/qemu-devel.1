Received: from eggs.gnu.org ([2001:4830:134:3::10]:50925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bq-0004xB-Vd
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bq-0005St-6A
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e46bp-0005R9-Vv
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Oct 2017 16:42:57 +0200
Message-Id: <20171016144302.24284-3-david@redhat.com>
In-Reply-To: <20171016144302.24284-1-david@redhat.com>
References: <20171016144302.24284-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/7] kvm: fix alignment of ram address
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

Fix the wrong calculation of the delta, used to align the ram address.

This only strikes if alignment has to be done.

Reported-by: Joe Clifford <joeclifford@gmail.com>
Fixes: 5ea69c2e3614 ("kvm: factor out alignment of memory section")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 90c88b517d..fae1eca983 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -717,8 +717,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         return;
     }
 
+    /* use aligned delta to align the ram address */
     ram = memory_region_get_ram_ptr(mr) + section->offset_within_region +
-          (section->offset_within_address_space - start_addr);
+          (start_addr - section->offset_within_address_space);
 
     mem = kvm_lookup_matching_slot(kml, start_addr, size);
     if (!add) {
-- 
2.13.5
