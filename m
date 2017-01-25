Received: from eggs.gnu.org ([2001:4830:134:3::10]:60234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cWNwi-0006eO-Eh
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cWNwf-0007MW-5K
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:49:08 -0500
Received: from proxmox.maurer-it.com ([212.186.127.180]:16700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1cWNwe-0007MB-TA
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:49:05 -0500
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Date: Wed, 25 Jan 2017 14:48:57 +0100
Message-Id: <1485352137-29367-1-git-send-email-w.bumiller@proxmox.com>
Subject: [Qemu-devel] [PATCH v2] cirrus: handle negative pitch in
 cirrus_invalidate_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Laszlo Ersek <lersek@redhat.com>

cirrus_invalidate_region() calls memory_region_set_dirty()
on a per-line basis, always ranging from off_begin to
off_begin+bytesperline. With a negative pitch off_begin
marks the top most used address and thus we need to do an
initial shift backwards by a line for negative pitches of
backward blits, otherwise the first iteration covers the
line going from the start offset forwards instead of
backwards.
Additionally since the start address is inclusive, if we
shift by a full `bytesperline` we move to the first address
*not* included in the blit, so we only shift by one less
than bytesperline.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
Changes to v1:
* Subtract only bytesperline-1 since the original address should be
  included while the byte at `begin-bytesperline` is exclusive.
* Added an assertion to ensure we don't call memory_region_set_dirty()
  with a negative size since it takes unsigned parameters.

 @Gerd: Still unclear: is -1 enough or should this somehow deal with
multiple depths? As far as I can see the backward blit functions
are all only byte based, as opposed to the patternfill functions in
cirrus_vga_rop2.h which have PUTPIXEL() macros for 8/16/24/32 bpp.
CIRRUS_BLTMODE_BACKWARDS only references cirrus_bkwd_rop[16] and
cirrus_bkwd_transp_rop[16][2] which only contain the bkwd rops
from cirrus_vga_rop.h.

 hw/display/cirrus_vga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index b1a0773..755110f 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -670,9 +670,14 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
     int off_cur;
     int off_cur_end;
 
+    if (off_pitch < 0) {
+        off_begin -= bytesperline-1;
+    }
+
     for (y = 0; y < lines; y++) {
 	off_cur = off_begin;
 	off_cur_end = (off_cur + bytesperline) & s->cirrus_addr_mask;
+	assert(off_cur_end >= off_cur);
         memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
 	off_begin += off_pitch;
     }
-- 
2.1.4
