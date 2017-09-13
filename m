Received: from eggs.gnu.org ([2001:4830:134:3::10]:36823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Iu-00058X-V7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Ir-0003Gt-27
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds2Iq-0003FD-S2
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF4D413A4C
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:41:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 09:41:37 +0200
Message-Id: <20170913074140.5160-4-kraxel@redhat.com>
In-Reply-To: <20170913074140.5160-1-kraxel@redhat.com>
References: <20170913074140.5160-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] qxl: drop mono cursor support
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

The chunk size sanity check in qxl_render_cursor works for
SPICE_CURSOR_TYPE_ALPHA cursors only.  So support for
SPICE_CURSOR_TYPE_MONO cursors must be broken for ages without anyone
noticing.  Most likely it simply isn't used any more by guest drivers.
Drop the dead code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170828123933.30323-2-kraxel@redhat.com
---
 hw/display/qxl-render.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 9ad9d9e0f5..e1b3f05ecb 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -207,7 +207,6 @@ void qxl_render_update_area_done(PCIQXLDevice *qxl, QXLCookie *cookie)
 static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor)
 {
     QEMUCursor *c;
-    uint8_t *image, *mask;
     size_t size;
 
     c = cursor_alloc(cursor->header.width, cursor->header.height);
@@ -221,14 +220,6 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor)
             cursor_print_ascii_art(c, "qxl/alpha");
         }
         break;
-    case SPICE_CURSOR_TYPE_MONO:
-        mask  = cursor->chunk.data;
-        image = mask + cursor_get_mono_bpl(c) * c->width;
-        cursor_set_mono(c, 0xffffff, 0x000000, image, 1, mask);
-        if (qxl->debug > 2) {
-            cursor_print_ascii_art(c, "qxl/mono");
-        }
-        break;
     default:
         fprintf(stderr, "%s: not implemented: type %d\n",
                 __FUNCTION__, cursor->header.type);
-- 
2.9.3
