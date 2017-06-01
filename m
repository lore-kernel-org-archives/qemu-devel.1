Received: from eggs.gnu.org ([2001:4830:134:3::10]:59653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQc-0003dH-BD
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQb-0005jv-C6
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:14 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQb-0005jj-6Z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:13 -0400
Received: by mail-wm0-x244.google.com with SMTP id k15so11049631wmh.3
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:33 +0200
Message-Id: <1496320911-51305-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/33] exec: simplify phys_page_find() params
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

It really only plays with the dispatchers, so the parameter list does
not need that complexity. This helps for readability at least.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1494838260-30439-2-git-send-email-peterx@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index 96e3ac9..29633cd 100644
--- a/exec.c
+++ b/exec.c
@@ -373,10 +373,11 @@ static inline bool section_covers_addr(const MemoryRegionSection *section,
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
 
@@ -414,8 +415,7 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
         section_covers_addr(section, addr)) {
         update = false;
     } else {
-        section = phys_page_find(d->phys_map, addr, d->map.nodes,
-                                 d->map.sections);
+        section = phys_page_find(d, addr);
         update = true;
     }
     if (resolve_subpage && section->mr->subpage) {
@@ -1283,8 +1283,7 @@ static void register_subpage(AddressSpaceDispatch *d, MemoryRegionSection *secti
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
1.8.3.1
