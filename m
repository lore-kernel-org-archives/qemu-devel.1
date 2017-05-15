Received: from eggs.gnu.org ([2001:4830:134:3::10]:34166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dABio-0003pI-Tl
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dABio-0005Yx-3e
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dABin-0005Yg-V8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:18 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 15 May 2017 16:50:58 +0800
Message-Id: <1494838260-30439-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1494838260-30439-1-git-send-email-peterx@redhat.com>
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] exec: rename resolve_subpage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

It is not easy for people to know "what this parameter does" before
knowing "what is subpage". Let's use "is_mmio" to make it easier to
understand.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 1d76c63..0adae94 100644
--- a/exec.c
+++ b/exec.c
@@ -403,7 +403,7 @@ bool memory_region_is_unassigned(MemoryRegion *mr)
 /* Called from RCU critical section */
 static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
                                                         hwaddr addr,
-                                                        bool resolve_subpage)
+                                                        bool is_mmio)
 {
     MemoryRegionSection *section = atomic_read(&d->mru_section);
     subpage_t *subpage;
@@ -416,7 +416,7 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
         section = phys_page_find(d, addr);
         update = true;
     }
-    if (resolve_subpage && section->mr->subpage) {
+    if (is_mmio && section->mr->subpage) {
         subpage = container_of(section->mr, subpage_t, iomem);
         section = &d->map.sections[subpage->sub_section[SUBPAGE_IDX(addr)]];
     }
@@ -429,13 +429,13 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
 /* Called from RCU critical section */
 static MemoryRegionSection *
 address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *xlat,
-                                 hwaddr *plen, bool resolve_subpage)
+                                 hwaddr *plen, bool is_mmio)
 {
     MemoryRegionSection *section;
     MemoryRegion *mr;
     Int128 diff;
 
-    section = address_space_lookup_region(d, addr, resolve_subpage);
+    section = address_space_lookup_region(d, addr, is_mmio);
     /* Compute offset within MemoryRegionSection */
     addr -= section->offset_within_address_space;
 
-- 
2.7.4
