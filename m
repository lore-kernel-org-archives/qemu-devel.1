Received: from eggs.gnu.org ([2001:4830:134:3::10]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46c3-00054b-1F
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46c2-0005o5-8A
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e46c2-0005mO-1s
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:26 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Oct 2017 16:43:01 +0200
Message-Id: <20171016144302.24284-7-david@redhat.com>
In-Reply-To: <20171016144302.24284-1-david@redhat.com>
References: <20171016144302.24284-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/7] kvm: simplify kvm_align_section()
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

Use ROUND_UP and simplify the code a bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2835bb3801..f290f487a5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -197,26 +197,20 @@ static hwaddr kvm_align_section(MemoryRegionSection *section,
                                 hwaddr *start)
 {
     hwaddr size = int128_get64(section->size);
-    hwaddr delta;
-
-    *start = section->offset_within_address_space;
+    hwaddr delta, aligned;
 
     /* kvm works in page size chunks, but the function may be called
        with sub-page size and unaligned start address. Pad the start
        address to next and truncate size to previous page boundary. */
-    delta = qemu_real_host_page_size - (*start & ~qemu_real_host_page_mask);
-    delta &= ~qemu_real_host_page_mask;
-    *start += delta;
+    aligned = ROUND_UP(section->offset_within_address_space,
+                       qemu_real_host_page_size);
+    delta = aligned - section->offset_within_address_space;
+    *start = aligned;
     if (delta > size) {
         return 0;
     }
-    size -= delta;
-    size &= qemu_real_host_page_mask;
-    if (*start & ~qemu_real_host_page_mask) {
-        return 0;
-    }
 
-    return size;
+    return (size - delta) & qemu_real_host_page_mask;
 }
 
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
-- 
2.13.5
