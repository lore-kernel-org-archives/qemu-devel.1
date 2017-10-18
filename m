Received: from eggs.gnu.org ([2001:4830:134:3::10]:36034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyE-0003f3-Dc
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyD-0002Ig-B5
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:26 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyD-0002Hs-4k
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:25 -0400
Received: by mail-wr0-x242.google.com with SMTP id l1so5597054wrc.3
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:25 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:13 +0200
Message-Id: <1508343141-31835-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/29] kvm: simplify kvm_align_section()
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

Use ROUND_UP and simplify the code a bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016144302.24284-7-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2835bb3..f290f48 100644
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
1.8.3.1
