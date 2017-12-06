Received: from eggs.gnu.org ([2001:4830:134:3::10]:50126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCq-000198-1B
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCm-00019f-Sx
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50758
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCm-000194-Nq
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:04 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEsXZ037208
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:18:04 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eppat0mst-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:18:04 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:18:03 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:47 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-55-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 54/55] vga: drop line_offset variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 362f811793ff6cb4d209ab61d76cc4f841bb5e46)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/display/vga.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 497c8236d0..895e95c3f4 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1464,7 +1464,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 {
     DisplaySurface *surface = qemu_console_surface(s->con);
     int y1, y, update, linesize, y_start, double_scan, mask, depth;
-    int width, height, shift_control, line_offset, bwidth, bits;
+    int width, height, shift_control, bwidth, bits;
     ram_addr_t page0, page1;
     DirtyBitmapSnapshot *snap = NULL;
     int disp_width, multi_scan, multi_run;
@@ -1614,7 +1614,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         s->cursor_invalidate(s);
     }
 
-    line_offset = s->line_offset;
 #if 0
     printf("w=%d h=%d v=%d line_offset=%d cr[0x09]=0x%02x cr[0x17]=0x%02x linecmp=%d sr[0x01]=0x%02x\n",
            width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
@@ -1629,7 +1628,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     if (!full_update) {
         ram_addr_t region_start = addr1;
-        ram_addr_t region_end = addr1 + line_offset * height;
+        ram_addr_t region_end = addr1 + s->line_offset * height;
         vga_sync_dirty_bitmap(s);
         if (s->line_compare < height) {
             /* split screen mode */
@@ -1681,7 +1680,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         if (!multi_run) {
             mask = (s->cr[VGA_CRTC_MODE] & 3) ^ 3;
             if ((y1 & mask) == mask)
-                addr1 += line_offset;
+                addr1 += s->line_offset;
             y1++;
             multi_run = multi_scan;
         } else {
-- 
2.11.0
