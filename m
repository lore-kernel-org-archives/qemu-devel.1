Received: from eggs.gnu.org ([2001:4830:134:3::10]:48820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZCfz-0001MT-Et
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 03:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZCfv-0006do-Hk
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 03:23:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZCfv-0006cS-9k
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 03:23:27 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  2 Feb 2017 09:23:07 +0100
Message-Id: <1486023789-28995-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486023789-28995-1-git-send-email-kraxel@redhat.com>
References: <1486023789-28995-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] cirrus: allow zero source pitch in pattern
 fill rops
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

The rops used by cirrus_bitblt_common_patterncopy only use
the destination pitch, so the source pitch shoul allowed to
be zero and the blit with used for the range check around the
source address.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-id: 1485272138-23249-1-git-send-email-w.bumiller@proxmox.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 0f05e45..98f089e 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -272,9 +272,6 @@ static void cirrus_update_memory_access(CirrusVGAState *s);
 static bool blit_region_is_unsafe(struct CirrusVGAState *s,
                                   int32_t pitch, int32_t addr)
 {
-    if (!pitch) {
-        return true;
-    }
     if (pitch < 0) {
         int64_t min = addr
             + ((int64_t)s->cirrus_blt_height-1) * pitch;
@@ -294,8 +291,11 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
     return false;
 }
 
-static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
+static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only,
+                           bool zero_src_pitch_ok)
 {
+    int32_t check_pitch;
+
     /* should be the case, see cirrus_bitblt_start */
     assert(s->cirrus_blt_width > 0);
     assert(s->cirrus_blt_height > 0);
@@ -304,6 +304,10 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
         return true;
     }
 
+    if (!s->cirrus_blt_dstpitch) {
+        return true;
+    }
+
     if (blit_region_is_unsafe(s, s->cirrus_blt_dstpitch,
                               s->cirrus_blt_dstaddr & s->cirrus_addr_mask)) {
         return true;
@@ -311,7 +315,13 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
     if (dst_only) {
         return false;
     }
-    if (blit_region_is_unsafe(s, s->cirrus_blt_srcpitch,
+
+    check_pitch = s->cirrus_blt_srcpitch;
+    if (!zero_src_pitch_ok && !check_pitch) {
+        check_pitch = s->cirrus_blt_width;
+    }
+
+    if (blit_region_is_unsafe(s, check_pitch,
                               s->cirrus_blt_srcaddr & s->cirrus_addr_mask)) {
         return true;
     }
@@ -681,8 +691,9 @@ static int cirrus_bitblt_common_patterncopy(CirrusVGAState * s,
 
     dst = s->vga.vram_ptr + (s->cirrus_blt_dstaddr & s->cirrus_addr_mask);
 
-    if (blit_is_unsafe(s, false))
+    if (blit_is_unsafe(s, false, true)) {
         return 0;
+    }
 
     (*s->cirrus_rop) (s, dst, src,
                       s->cirrus_blt_dstpitch, 0,
@@ -699,7 +710,7 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
 {
     cirrus_fill_t rop_func;
 
-    if (blit_is_unsafe(s, true)) {
+    if (blit_is_unsafe(s, true, true)) {
         return 0;
     }
     rop_func = cirrus_fill[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
@@ -803,7 +814,7 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
 
 static int cirrus_bitblt_videotovideo_copy(CirrusVGAState * s)
 {
-    if (blit_is_unsafe(s, false))
+    if (blit_is_unsafe(s, false, false))
         return 0;
 
     return cirrus_do_copy(s, s->cirrus_blt_dstaddr - s->vga.start_addr,
-- 
1.8.3.1
