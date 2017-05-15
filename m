Received: from eggs.gnu.org ([2001:4830:134:3::10]:34151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dABin-0003pD-VR
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dABik-0005Y0-D5
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dABik-0005Xq-7a
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:51:14 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 15 May 2017 16:50:57 +0800
Message-Id: <1494838260-30439-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1494838260-30439-1-git-send-email-peterx@redhat.com>
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] exec: simplify phys_page_find() params
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

It really only plays with the dispatchers, so the parameter list does
not need that complexity. This helps for readability at least.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index eac6085..1d76c63 100644
--- a/exec.c
+++ b/exec.c
@@ -371,10 +371,11 @@ static inline bool section_covers_addr(const MemoryRegionSection *section,
                              int128_getlo(section->size), addr);
 }
 
-static MemoryRegionSection *phys_page_find(PhysPageEntry lp, hwaddr addr,
-                                           Node *nodes, MemoryRegionSection *sections)
+static MemoryRegionSection *phys_page_find(AddressSpaceDispatch *d, hwaddr addr)
 {
-    PhysPageEntry *p;
+    PhysPageEntry lp = d->phys_map, *p;
+    Node *nodes = d->map.nodes;
+    MemoryRegionSection *sections = d->map.sections;
     hwaddr index = addr >> TARGET_PAGE_BITS;
     int i;
 
@@ -412,8 +413,7 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
         section_covers_addr(section, addr)) {
         update = false;
     } else {
-        section = phys_page_find(d->phys_map, addr, d->map.nodes,
-                                 d->map.sections);
+        section = phys_page_find(d, addr);
         update = true;
     }
     if (resolve_subpage && section->mr->subpage) {
@@ -1246,8 +1246,7 @@ static void register_subpage(AddressSpaceDispatch *d, MemoryRegionSection *secti
     subpage_t *subpage;
     hwaddr base = section->offset_within_address_space
         & TARGET_PAGE_MASK;
-    MemoryRegionSection *existing = phys_page_find(d->phys_map, base,
-                                                   d->map.nodes, d->map.sections);
+    MemoryRegionSection *existing = phys_page_find(d, base);
     MemoryRegionSection subsection = {
         .offset_within_address_space = base,
         .size = int128_make64(TARGET_PAGE_SIZE),
-- 
2.7.4
