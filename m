Received: from eggs.gnu.org ([2001:4830:134:3::10]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZIwl-000085-V3
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZIwh-0002rP-Mp
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZIwh-0002qj-Fi
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:05:11 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD6CA804E4
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 15:05:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  2 Feb 2017 16:05:06 +0100
Message-Id: <1486047907-26685-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486047907-26685-1-git-send-email-kraxel@redhat.com>
References: <1486047907-26685-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] cirrus: fix blit address mask handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Apply the cirrus_addr_mask to cirrus_blt_dstaddr and cirrus_blt_srcaddr
right after assigning them, in cirrus_bitblt_start(), instead of having
this all over the place in the cirrus code, and missing a few places.

Reported-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1485338996-17095-1-git-send-email-kraxel@redhat.com
---
 hw/display/cirrus_vga.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 98f089e..7db6409 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -309,7 +309,7 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only,
     }
 
     if (blit_region_is_unsafe(s, s->cirrus_blt_dstpitch,
-                              s->cirrus_blt_dstaddr & s->cirrus_addr_mask)) {
+                              s->cirrus_blt_dstaddr)) {
         return true;
     }
     if (dst_only) {
@@ -322,7 +322,7 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only,
     }
 
     if (blit_region_is_unsafe(s, check_pitch,
-                              s->cirrus_blt_srcaddr & s->cirrus_addr_mask)) {
+                              s->cirrus_blt_srcaddr)) {
         return true;
     }
 
@@ -689,7 +689,7 @@ static int cirrus_bitblt_common_patterncopy(CirrusVGAState * s,
 {
     uint8_t *dst;
 
-    dst = s->vga.vram_ptr + (s->cirrus_blt_dstaddr & s->cirrus_addr_mask);
+    dst = s->vga.vram_ptr + s->cirrus_blt_dstaddr;
 
     if (blit_is_unsafe(s, false, true)) {
         return 0;
@@ -714,7 +714,7 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
         return 0;
     }
     rop_func = cirrus_fill[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
-    rop_func(s, s->vga.vram_ptr + (s->cirrus_blt_dstaddr & s->cirrus_addr_mask),
+    rop_func(s, s->vga.vram_ptr + s->cirrus_blt_dstaddr,
              s->cirrus_blt_dstpitch,
              s->cirrus_blt_width, s->cirrus_blt_height);
     cirrus_invalidate_region(s, s->cirrus_blt_dstaddr,
@@ -732,9 +732,8 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
 
 static int cirrus_bitblt_videotovideo_patterncopy(CirrusVGAState * s)
 {
-    return cirrus_bitblt_common_patterncopy(s,
-					    s->vga.vram_ptr + ((s->cirrus_blt_srcaddr & ~7) &
-                                            s->cirrus_addr_mask));
+    return cirrus_bitblt_common_patterncopy(s, s->vga.vram_ptr +
+                                            (s->cirrus_blt_srcaddr & ~7));
 }
 
 static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
@@ -788,10 +787,8 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
     if (notify)
         graphic_hw_update(s->vga.con);
 
-    (*s->cirrus_rop) (s, s->vga.vram_ptr +
-		      (s->cirrus_blt_dstaddr & s->cirrus_addr_mask),
-		      s->vga.vram_ptr +
-		      (s->cirrus_blt_srcaddr & s->cirrus_addr_mask),
+    (*s->cirrus_rop) (s, s->vga.vram_ptr + s->cirrus_blt_dstaddr,
+                      s->vga.vram_ptr + s->cirrus_blt_srcaddr,
 		      s->cirrus_blt_dstpitch, s->cirrus_blt_srcpitch,
 		      s->cirrus_blt_width, s->cirrus_blt_height);
 
@@ -842,8 +839,7 @@ static void cirrus_bitblt_cputovideo_next(CirrusVGAState * s)
         } else {
             /* at least one scan line */
             do {
-                (*s->cirrus_rop)(s, s->vga.vram_ptr +
-                                 (s->cirrus_blt_dstaddr & s->cirrus_addr_mask),
+                (*s->cirrus_rop)(s, s->vga.vram_ptr + s->cirrus_blt_dstaddr,
                                   s->cirrus_bltbuf, 0, 0, s->cirrus_blt_width, 1);
                 cirrus_invalidate_region(s, s->cirrus_blt_dstaddr, 0,
                                          s->cirrus_blt_width, 1);
@@ -962,6 +958,9 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
     s->cirrus_blt_modeext = s->vga.gr[0x33];
     blt_rop = s->vga.gr[0x32];
 
+    s->cirrus_blt_dstaddr &= s->cirrus_addr_mask;
+    s->cirrus_blt_srcaddr &= s->cirrus_addr_mask;
+
 #ifdef DEBUG_BITBLT
     printf("rop=0x%02x mode=0x%02x modeext=0x%02x w=%d h=%d dpitch=%d spitch=%d daddr=0x%08x saddr=0x%08x writemask=0x%02x\n",
            blt_rop,
-- 
1.8.3.1
