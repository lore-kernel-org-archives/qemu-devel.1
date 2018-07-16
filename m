Received: from eggs.gnu.org ([2001:4830:134:3::10]:40019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1R-0001Dh-JN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1N-0004y4-3O
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 16 Jul 2018 18:38:04 +1000
Message-Id: <20180716083809.17115-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180716083809.17115-1-david@gibson.dropbear.id.au>
References: <20180716083809.17115-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/6] sm501: Update screen on frame buffer
 address change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

When the guest changes the address of the frame buffer we need to
refresh the screen to correctly display the new content. This fixes
display update problems when changing between screens on AmigaOS.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 3661a89f60..9ab29d35dd 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1235,6 +1235,7 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         if (value & 0x8000000) {
             qemu_log_mask(LOG_UNIMP, "Panel external memory not supported\n");
         }
+        s->do_full_update = true;
         break;
     case SM501_DC_PANEL_FB_OFFSET:
         s->dc_panel_fb_offset = value & 0x3FF03FF0;
@@ -1298,6 +1299,7 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         if (value & 0x8000000) {
             qemu_log_mask(LOG_UNIMP, "CRT external memory not supported\n");
         }
+        s->do_full_update = true;
         break;
     case SM501_DC_CRT_FB_OFFSET:
         s->dc_crt_fb_offset = value & 0x3FF03FF0;
-- 
2.17.1
