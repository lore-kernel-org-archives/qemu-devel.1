Received: from eggs.gnu.org ([2001:4830:134:3::10]:41310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qr-0001qj-O7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qk-00053C-Pp
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qk-000525-Gu
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:38 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8ZVj128159
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:37 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ambn2999-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:37 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:36 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:11 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-48-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 47/81] display: cirrus: ignore source pitch
 value as needed in blit_is_unsafe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bruce Rogers <brogers@suse.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Bruce Rogers <brogers@suse.com>

Commit 4299b90 added a check which is too broad, given that the source
pitch value is not required to be initialized for solid fill operations.
This patch refines the blit_is_unsafe() check to ignore source pitch in
that case. After applying the above commit as a security patch, we
noticed the SLES 11 SP4 guest gui failed to initialize properly.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Message-id: 20170109203520.5619-1-brogers@suse.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 913a87885f589d263e682c2eb6637c6e14538061)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
