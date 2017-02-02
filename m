Received: from eggs.gnu.org ([2001:4830:134:3::10]:43430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZIwk-00006v-H3
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZIwh-0002r4-G5
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZIwh-0002qh-BG
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:11 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  2 Feb 2017 16:05:04 +0100
Message-Id: <1486047907-26685-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486047907-26685-1-git-send-email-kraxel@redhat.com>
References: <1486047907-26685-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] cirrus: handle negative pitch in
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
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Wolfgang Bumiller <w.bumiller@proxmox.com>

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
Message-id: 1485352137-29367-1-git-send-email-w.bumiller@proxmox.com

[ kraxel: codestyle fixes ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 379910d..0f05e45 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -661,9 +661,14 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
     int off_cur;
     int off_cur_end;
 
+    if (off_pitch < 0) {
+        off_begin -= bytesperline - 1;
+    }
+
     for (y = 0; y < lines; y++) {
 	off_cur = off_begin;
 	off_cur_end = (off_cur + bytesperline) & s->cirrus_addr_mask;
+        assert(off_cur_end >= off_cur);
         memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
 	off_begin += off_pitch;
     }
-- 
1.8.3.1
