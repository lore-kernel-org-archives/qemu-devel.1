Received: from eggs.gnu.org ([2001:4830:134:3::10]:33588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG98-0001aI-3c
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG97-0003R2-BI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRG97-0003QY-5S
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:45 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 11:28:34 +0100
Message-Id: <1484130518-18873-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
References: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] display: cirrus: ignore source pitch value
 as needed in blit_is_unsafe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bruce Rogers <brogers@suse.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Bruce Rogers <brogers@suse.com>

Commit 4299b90 added a check which is too broad, given that the source
pitch value is not required to be initialized for solid fill operations.
This patch refines the blit_is_unsafe() check to ignore source pitch in
that case. After applying the above commit as a security patch, we
noticed the SLES 11 SP4 guest gui failed to initialize properly.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Message-id: 20170109203520.5619-1-brogers@suse.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index bdb092e..379910d 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -294,7 +294,7 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
     return false;
 }
 
-static bool blit_is_unsafe(struct CirrusVGAState *s)
+static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
 {
     /* should be the case, see cirrus_bitblt_start */
     assert(s->cirrus_blt_width > 0);
@@ -308,6 +308,9 @@ static bool blit_is_unsafe(struct CirrusVGAState *s)
                               s->cirrus_blt_dstaddr & s->cirrus_addr_mask)) {
         return true;
     }
+    if (dst_only) {
+        return false;
+    }
     if (blit_region_is_unsafe(s, s->cirrus_blt_srcpitch,
                               s->cirrus_blt_srcaddr & s->cirrus_addr_mask)) {
         return true;
@@ -673,7 +676,7 @@ static int cirrus_bitblt_common_patterncopy(CirrusVGAState * s,
 
     dst = s->vga.vram_ptr + (s->cirrus_blt_dstaddr & s->cirrus_addr_mask);
 
-    if (blit_is_unsafe(s))
+    if (blit_is_unsafe(s, false))
         return 0;
 
     (*s->cirrus_rop) (s, dst, src,
@@ -691,7 +694,7 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
 {
     cirrus_fill_t rop_func;
 
-    if (blit_is_unsafe(s)) {
+    if (blit_is_unsafe(s, true)) {
         return 0;
     }
     rop_func = cirrus_fill[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
@@ -795,7 +798,7 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
 
 static int cirrus_bitblt_videotovideo_copy(CirrusVGAState * s)
 {
-    if (blit_is_unsafe(s))
+    if (blit_is_unsafe(s, false))
         return 0;
 
     return cirrus_do_copy(s, s->cirrus_blt_dstaddr - s->vga.start_addr,
-- 
1.8.3.1
