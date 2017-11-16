Received: from eggs.gnu.org ([2001:4830:134:3::10]:33991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpm-0001xe-Ow
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpl-0000Pc-KA
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFIpl-0000P1-Dy
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:53 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Nov 2017 12:59:25 +0100
Message-Id: <20171116115926.16627-11-pbonzini@redhat.com>
In-Reply-To: <20171116115926.16627-1-pbonzini@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/11] exec: Do not resolve subpage in
 mru_section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This fixes a crash caused by picking the wrong memory region in
address_space_lookup_region seen with client code accessing a device
model that uses alias memory regions.  The expensive part of
address_space_lookup_region anyway is phys_page_find; performance-wise
it is okay to repeat the subsequent subpage lookup.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20171114225941.072707456B5@zero.eik.bme.hu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/exec.c b/exec.c
index 97a24a875e..3bb9fcf257 100644
--- a/exec.c
+++ b/exec.c
@@ -410,22 +410,16 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
 {
     MemoryRegionSection *section = atomic_read(&d->mru_section);
     subpage_t *subpage;
-    bool update;
 
-    if (section && section != &d->map.sections[PHYS_SECTION_UNASSIGNED] &&
-        section_covers_addr(section, addr)) {
-        update = false;
-    } else {
+    if (!section || section == &d->map.sections[PHYS_SECTION_UNASSIGNED] ||
+        !section_covers_addr(section, addr)) {
         section = phys_page_find(d, addr);
-        update = true;
+        atomic_set(&d->mru_section, section);
     }
     if (resolve_subpage && section->mr->subpage) {
         subpage = container_of(section->mr, subpage_t, iomem);
         section = &d->map.sections[subpage->sub_section[SUBPAGE_IDX(addr)]];
     }
-    if (update) {
-        atomic_set(&d->mru_section, section);
-    }
     return section;
 }
 
-- 
2.14.3
