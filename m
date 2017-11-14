Received: from eggs.gnu.org ([2001:4830:134:3::10]:53415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eEkBG-0000Zr-RD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 17:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eEkBD-0002Gr-Q6
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 17:59:46 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:10126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eEkBD-0002Fl-Jc
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 17:59:43 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 14 Nov 2017 23:42:35 +0100
Message-Id: <20171114225941.072707456B5@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] exec: Skip mru section if it's a partial page
 and not resolving subpage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This fixes a crash caused by picking the wrong memory region in
address_space_lookup_region seen with client code accessing a device
model that uses alias memory regions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index 97a24a8..e5f2b9a 100644
--- a/exec.c
+++ b/exec.c
@@ -413,6 +413,7 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
     bool update;
 
     if (section && section != &d->map.sections[PHYS_SECTION_UNASSIGNED] &&
+        (resolve_subpage || !section->offset_within_region) &&
         section_covers_addr(section, addr)) {
         update = false;
     } else {
-- 
2.7.6
