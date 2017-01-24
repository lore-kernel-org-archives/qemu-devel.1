Received: from eggs.gnu.org ([2001:4830:134:3::10]:56980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cW38R-00050u-Or
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cW38N-0004te-Ot
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:35:51 -0500
Received: from proxmox.maurer-it.com ([212.186.127.180]:24365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1cW38N-0004tO-Bb
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:35:47 -0500
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Date: Tue, 24 Jan 2017 16:35:38 +0100
Message-Id: <1485272138-23249-1-git-send-email-w.bumiller@proxmox.com>
Subject: [Qemu-devel] [PATCH v2] cirrus: allow zero source pitch in pattern
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

The rops used by cirrus_bitblt_common_patterncopy only use
the destination pitch, so the source pitch shoul allowed to
be zero and the blit with used for the range check around the
source address.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
I'd also like someone to take a look at cirrus_colorexpand_{,transp_}*
in the cirrus_vga_rop2.h header for verification since with them not
using srcpitch I'd like to be sure using the width for the pitch check
is truly safe enough. It seems obvious really (unless you read the
code ;-) ), but anyway, here's my analysis:

They iterate through src via `*src++` which is used both in the outer
y-loop as well as well as in a condition within the x loop. At first
this means we potentially go through `with*height + height` bytes.

Looking at DEPTH=8 (as it produces the longest loop per row and is
easy to read ;-) ) with fabricated dstskipleft and srcskipleft values
as described in the comments (they depend on one another though, so
we're making it a bit worse than it actually is...) the code for a row
becomes:
  = for each row:
  |  bitmask = 0x80 >> srcskipleft;      // assume bitmask = 0;
  |  bits = *src++ ^ bits_xor;           // bumps src
  |  (...)
  |  for (x = dstskipleft; x < bltwidth; x++) { // assume x starts at 0
  |      if ((bitmask & 0xff) == 0) {
  |          bitmask = 0x80;
  |          bits = *src++ ^ bits_xor;   // bumps src
  |      }
  |  (...)
  |      bitmask >>= 1;
  |  }

The inner loop performs the *src++ for every 8th pixel only.
So we index src at most by: bltheight + bltheight*(ceil(bltwidth/8))
or (bltheight * (1 + ceil(bltwidth/8))).
This is usually covered by width*height when looking at it in a
simplified `(width/8)*height` way, but it would seem as though
width=1 is a dangerous case when the bitmask is initialized as 0
as we'd be going through height*2 instead of height*1 src pixels.
Note however that the values for srcskipleft and dstskipleft have a
relationship: In one part of the code dstskipleft is at least
srcskipleft*8 (meaning either both are 0 and bitmask is initialized to
0x80 so the inner *src++ is never executed) or, if bitmask is 0 due to
srcskipleft being 8, dstskipleft > 0 so the inner loop is not executed
due to width being only 1 and x starting at dstskipleft.
In the other function the DEPTH==24 case says: srcskipleft = dstskipleft/3
So if the bitmask is initialized to 0 then x also must start at
something >= width and the inner loop is not executed either.
So basically it's impossible for both assumptions made in the code
snippet's comments to be true at the same time.

>From this I infer that instead of my patch from the other day where I
disabled the src check on a zero src pitch entirely (which I can only
attribute to temporary insanity caused by reading through this code
in the first place ;-) ) a zero source pitch should instead -
obviously - simply assume a pitch equal to the width.
(And after writing that last sentence of this paragraph I feel quite
paranoid, or stupid?)

 hw/display/cirrus_vga.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 379910d..331fc65 100644
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
@@ -676,8 +686,9 @@ static int cirrus_bitblt_common_patterncopy(CirrusVGAState * s,
 
     dst = s->vga.vram_ptr + (s->cirrus_blt_dstaddr & s->cirrus_addr_mask);
 
-    if (blit_is_unsafe(s, false))
+    if (blit_is_unsafe(s, false, true)) {
         return 0;
+    }
 
     (*s->cirrus_rop) (s, dst, src,
                       s->cirrus_blt_dstpitch, 0,
@@ -694,7 +705,7 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
 {
     cirrus_fill_t rop_func;
 
-    if (blit_is_unsafe(s, true)) {
+    if (blit_is_unsafe(s, true, true)) {
         return 0;
     }
     rop_func = cirrus_fill[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
@@ -798,7 +809,7 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
 
 static int cirrus_bitblt_videotovideo_copy(CirrusVGAState * s)
 {
-    if (blit_is_unsafe(s, false))
+    if (blit_is_unsafe(s, false, false))
         return 0;
 
     return cirrus_do_copy(s, s->cirrus_blt_dstaddr - s->vga.start_addr,
-- 
2.1.4
