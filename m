Received: from eggs.gnu.org ([2001:4830:134:3::10]:54353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdBpR-0004va-ER
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdBpN-0004bl-Gs
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cdBpN-0004a8-8Q
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Feb 2017 09:17:31 +0100
Message-Id: <1486973851-21645-7-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
References: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] Revert "cirrus: allow zero source pitch in
 pattern fill rops"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This reverts commit 5858dd1801883309bdd208d72ddb81c4e9fee30c.

Conflicts:
	hw/display/cirrus_vga.c

Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-id: 1486645341-5010-2-git-send-email-kraxel@redhat.com
---
 hw/display/cirrus_vga.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 1bcf9a4..1deb520 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -273,6 +273,9 @@ static void cirrus_update_memory_access(CirrusVGAState *s);
 static bool blit_region_is_unsafe(struct CirrusVGAState *s,
                                   int32_t pitch, int32_t addr)
 {
+    if (!pitch) {
+        return true;
+    }
     if (pitch < 0) {
         int64_t min = addr
             + ((int64_t)s->cirrus_blt_height - 1) * pitch
@@ -291,11 +294,8 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
     return false;
 }
 
-static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only,
-                           bool zero_src_pitch_ok)
+static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
 {
-    int32_t check_pitch;
-
     /* should be the case, see cirrus_bitblt_start */
     assert(s->cirrus_blt_width > 0);
     assert(s->cirrus_blt_height > 0);
@@ -304,10 +304,6 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only,
         return true;
     }
 
-    if (!s->cirrus_blt_dstpitch) {
-        return true;
-    }
-
     if (blit_region_is_unsafe(s, s->cirrus_blt_dstpitch,
                               s->cirrus_blt_dstaddr)) {
         return true;
@@ -315,13 +311,7 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only,
     if (dst_only) {
         return false;
     }
-
-    check_pitch = s->cirrus_blt_srcpitch;
-    if (!zero_src_pitch_ok && !check_pitch) {
-        check_pitch = s->cirrus_blt_width;
-    }
-
-    if (blit_region_is_unsafe(s, check_pitch,
+    if (blit_region_is_unsafe(s, s->cirrus_blt_srcpitch,
                               s->cirrus_blt_srcaddr)) {
         return true;
     }
@@ -716,7 +706,7 @@ static int cirrus_bitblt_common_patterncopy(CirrusVGAState *s, bool videosrc)
         src = s->cirrus_bltbuf;
     }
 
-    if (blit_is_unsafe(s, true, true)) {
+    if (blit_is_unsafe(s, true)) {
         return 0;
     }
 
@@ -735,7 +725,7 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
 {
     cirrus_fill_t rop_func;
 
-    if (blit_is_unsafe(s, true, true)) {
+    if (blit_is_unsafe(s, true)) {
         return 0;
     }
     rop_func = cirrus_fill[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
@@ -835,7 +825,7 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
 
 static int cirrus_bitblt_videotovideo_copy(CirrusVGAState * s)
 {
-    if (blit_is_unsafe(s, false, false))
+    if (blit_is_unsafe(s, false))
         return 0;
 
     return cirrus_do_copy(s, s->cirrus_blt_dstaddr - s->vga.start_addr,
-- 
1.8.3.1
