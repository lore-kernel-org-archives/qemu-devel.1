Received: from eggs.gnu.org ([2001:4830:134:3::10]:48764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1cQgfE-0008Iu-8G
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1cQgfA-0000mD-4D
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:35:32 -0500
From: Bruce Rogers <brogers@suse.com>
Date: Mon,  9 Jan 2017 13:35:20 -0700
Message-Id: <20170109203520.5619-1-brogers@suse.com>
Subject: [Qemu-devel] [PATCH] display: cirrus: ignore source pitch value as
 needed in blit_is_unsafe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org, ppandit@redhat.com
Cc: brogers@suse.com

Commit 4299b90 added a check which is too broad, given that the source
pitch value is not required to be initialized for solid fill operations.
This patch refines the blit_is_unsafe() check to ignore source pitch in
that case. After applying the above commit as a security patch, we
noticed the SLES 11 SP4 guest gui failed to initialize properly.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 hw/display/cirrus_vga.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index bdb092ee9d..379910db2d 100644
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
2.11.0
