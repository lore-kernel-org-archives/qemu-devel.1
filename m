Received: from eggs.gnu.org ([2001:4830:134:3::10]:56973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cWKWD-00085i-E4
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cWKW9-0000jQ-Ci
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:09:33 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 25 Jan 2017 11:09:17 +0100
Message-Id: <1485338957-16939-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] cirrus: fix oob access issue (CVE-2017-TODO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>, qemu-stable@nongnu.org, P J P <ppandit@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Li Qiang <liqiang6-s@360.cn>

When doing bitblt copy in backward mode, we should minus the
blt width first just like the adding in the forward mode. This
can avoid the oob access of the front of vga's vram.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-id: 5887254f.863a240a.2c122.5500@mx.google.com

{ kraxel: with backward blits (negative pitch) addr is the topmost
          address, so check it as-is against vram size ]

Cc: qemu-stable@nongnu.org
Cc: P J P <ppandit@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
Fixes: d3532a0db02296e687711b8cdc7791924efccea0 (CVE-2014-8106)
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 379910d..5547a60 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -277,10 +277,9 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
     }
     if (pitch < 0) {
         int64_t min = addr
-            + ((int64_t)s->cirrus_blt_height-1) * pitch;
-        int32_t max = addr
-            + s->cirrus_blt_width;
-        if (min < 0 || max > s->vga.vram_size) {
+            + ((int64_t)s->cirrus_blt_height - 1) * pitch
+            - s->cirrus_blt_width;
+        if (min < 0 || addr >= s->vga.vram_size) {
             return true;
         }
     } else {
-- 
1.8.3.1
