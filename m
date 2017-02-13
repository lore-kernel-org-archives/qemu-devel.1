Received: from eggs.gnu.org ([2001:4830:134:3::10]:54356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdBpR-0004vd-Ea
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdBpN-0004br-MQ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cdBpN-0004ae-EL
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Feb 2017 09:17:30 +0100
Message-Id: <1486973851-21645-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
References: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] cirrus: fix patterncopy checks
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

The blit_region_is_unsafe checks don't work correctly for the
patterncopy source.  It's a fixed-sized region, which doesn't
depend on cirrus_blt_{width,height}.  So go do the check in
cirrus_bitblt_common_patterncopy instead, then tell blit_is_unsafe that
it doesn't need to verify the source.  Also handle the case where we
blit from cirrus_bitbuf correctly.

This patch replaces 5858dd1801883309bdd208d72ddb81c4e9fee30c.

Security impact:  I think for the most part error on the safe side this
time, refusing blits which should have been allowed.

Only exception is placing the blit source at the end of the video ram,
so cirrus_blt_srcaddr + 256 goes beyond the end of video memory.  But
even in that case I'm not fully sure this actually allows read access to
host memory.  To trick the commit 5858dd18 security checks one has to
pick very small cirrus_blt_{width,height} values, which in turn implies
only a fraction of the blit source will actually be used.

Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-id: 1486645341-5010-1-git-send-email-kraxel@redhat.com
---
 hw/display/cirrus_vga.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index b272a70..1bcf9a4 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -684,14 +684,39 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
     }
 }
 
-static int cirrus_bitblt_common_patterncopy(CirrusVGAState * s,
-					    const uint8_t * src)
+static int cirrus_bitblt_common_patterncopy(CirrusVGAState *s, bool videosrc)
 {
+    uint32_t patternsize;
     uint8_t *dst;
+    uint8_t *src;
 
     dst = s->vga.vram_ptr + s->cirrus_blt_dstaddr;
 
-    if (blit_is_unsafe(s, false, true)) {
+    if (videosrc) {
+        switch (s->vga.get_bpp(&s->vga)) {
+        case 8:
+            patternsize = 64;
+            break;
+        case 15:
+        case 16:
+            patternsize = 128;
+            break;
+        case 24:
+        case 32:
+        default:
+            patternsize = 256;
+            break;
+        }
+        s->cirrus_blt_srcaddr &= ~(patternsize - 1);
+        if (s->cirrus_blt_srcaddr + patternsize > s->vga.vram_size) {
+            return 0;
+        }
+        src = s->vga.vram_ptr + s->cirrus_blt_srcaddr;
+    } else {
+        src = s->cirrus_bltbuf;
+    }
+
+    if (blit_is_unsafe(s, true, true)) {
         return 0;
     }
 
@@ -732,8 +757,7 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
 
 static int cirrus_bitblt_videotovideo_patterncopy(CirrusVGAState * s)
 {
-    return cirrus_bitblt_common_patterncopy(s, s->vga.vram_ptr +
-                                            (s->cirrus_blt_srcaddr & ~7));
+    return cirrus_bitblt_common_patterncopy(s, true);
 }
 
 static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
@@ -832,7 +856,7 @@ static void cirrus_bitblt_cputovideo_next(CirrusVGAState * s)
 
     if (s->cirrus_srccounter > 0) {
         if (s->cirrus_blt_mode & CIRRUS_BLTMODE_PATTERNCOPY) {
-            cirrus_bitblt_common_patterncopy(s, s->cirrus_bltbuf);
+            cirrus_bitblt_common_patterncopy(s, false);
         the_end:
             s->cirrus_srccounter = 0;
             cirrus_bitblt_reset(s);
-- 
1.8.3.1
