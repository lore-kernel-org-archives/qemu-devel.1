Received: from eggs.gnu.org ([2001:4830:134:3::10]:53660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpjj-0002XM-Iy
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpji-00046w-Qt
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:35 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:56611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDpji-00046R-Kl
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:34 -0500
Received: by mail-wr0-x243.google.com with SMTP id q66so12004155wrb.13
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 02:43:34 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 11:42:45 +0100
Message-Id: <20171112104246.10007-8-makovick@gmail.com>
In-Reply-To: <20171112104246.10007-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171112104246.10007-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 7/8] sdl2: Do not leave grab when fullscreen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>
Cc: Jindrich Makovicka <makovick@gmail.com>

Prevents displaying of a doubled mouse pointer when moving the pointer
to the screen edges when fullscreen.
---
 ui/sdl2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index cdc599be48..6feb637739 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -451,8 +451,9 @@ static void handle_mousemotion(SDL_Event *ev)
         SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
         max_x = scr_w - 1;
         max_y = scr_h - 1;
-        if (gui_grab && (ev->motion.x == 0 || ev->motion.y == 0 ||
-                         ev->motion.x == max_x || ev->motion.y == max_y)) {
+        if (gui_grab && !gui_fullscreen
+            && (ev->motion.x == 0 || ev->motion.y == 0 ||
+                ev->motion.x == max_x || ev->motion.y == max_y)) {
             sdl_grab_end(scon);
         }
         if (!gui_grab &&
-- 
2.15.0
