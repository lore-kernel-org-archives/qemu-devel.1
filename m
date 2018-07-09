Received: from eggs.gnu.org ([2001:4830:134:3::10]:40665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fcZpf-0002oD-3J
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fcZpa-0004bO-4u
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:20:15 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:40170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fcZpZ-0004WU-Tz
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:20:10 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 9 Jul 2018 19:02:36 +0200
Message-Id: <20180709172005.5306274569D@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] sm501: Update screen on frame buffer address
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

When the guest changes the address of the frame buffer we need to
refresh the screen to correctly display the new content. This fixes
display update problems when changing between screens on AmigaOS.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This fixes an annoying refresh problem in AmigaOS when changing or
moving screens. The user could work around it by moving the mouse to
repaint the screen but if it's possible to get this in before or
during the freeze that could avoid this problem in the release.

 hw/display/sm501.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 3661a89..9ab29d3 100644
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
2.7.6
