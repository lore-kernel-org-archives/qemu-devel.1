Received: from eggs.gnu.org ([2001:4830:134:3::10]:35808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXoSM-0000Ey-FV
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXoSK-0000uj-BL
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXoSK-0000tn-6F
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:28 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Jun 2018 15:56:25 +0200
Message-Id: <20180626135625.7078-4-kraxel@redhat.com>
In-Reply-To: <20180626135625.7078-1-kraxel@redhat.com>
References: <20180626135625.7078-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] sdl2: add checking for NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Maria Klimushenkova <maria.klimushenkova@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Sometimes SDL2 console can't be retrieved on events and scon variable
becomes NULL. This patch prevents processing of the events when the console
is not available.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Message-id: 20180626064729.18070.47600.stgit@pasha-VirtualBox
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3fff9f5b63..76e59427cc 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -438,7 +438,7 @@ static void handle_mousemotion(SDL_Event *ev)
     int max_x, max_y;
     struct sdl2_console *scon = get_scon_from_window(ev->motion.windowID);
 
-    if (!qemu_console_is_graphic(scon->dcl.con)) {
+    if (!scon || !qemu_console_is_graphic(scon->dcl.con)) {
         return;
     }
 
@@ -470,7 +470,7 @@ static void handle_mousebutton(SDL_Event *ev)
     SDL_MouseButtonEvent *bev;
     struct sdl2_console *scon = get_scon_from_window(ev->button.windowID);
 
-    if (!qemu_console_is_graphic(scon->dcl.con)) {
+    if (!scon || !qemu_console_is_graphic(scon->dcl.con)) {
         return;
     }
 
@@ -496,7 +496,7 @@ static void handle_mousewheel(SDL_Event *ev)
     SDL_MouseWheelEvent *wev = &ev->wheel;
     InputButton btn;
 
-    if (!qemu_console_is_graphic(scon->dcl.con)) {
+    if (!scon || !qemu_console_is_graphic(scon->dcl.con)) {
         return;
     }
 
-- 
2.9.3
