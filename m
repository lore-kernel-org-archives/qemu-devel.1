Received: from eggs.gnu.org ([2001:4830:134:3::10]:35809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXoSM-0000Ez-FX
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXoSJ-0000sO-8U
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXoSJ-0000rb-4a
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:27 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Jun 2018 15:56:24 +0200
Message-Id: <20180626135625.7078-3-kraxel@redhat.com>
In-Reply-To: <20180626135625.7078-1-kraxel@redhat.com>
References: <20180626135625.7078-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] sdl2: fix copypaste issues
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

This patch fixes text and mouse event processing. These functions used
'key' field of the event instead of appropriate 'text', 'motion', 'button',
or 'wheel'.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Message-id: 20180626064017.17031.47954.stgit@pasha-VirtualBox
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3ae4719c32..3fff9f5b63 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -424,7 +424,7 @@ static void handle_keyup(SDL_Event *ev)
 
 static void handle_textinput(SDL_Event *ev)
 {
-    struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
+    struct sdl2_console *scon = get_scon_from_window(ev->text.windowID);
     QemuConsole *con = scon ? scon->dcl.con : NULL;
 
     if (qemu_console_is_graphic(con)) {
@@ -436,7 +436,7 @@ static void handle_textinput(SDL_Event *ev)
 static void handle_mousemotion(SDL_Event *ev)
 {
     int max_x, max_y;
-    struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
+    struct sdl2_console *scon = get_scon_from_window(ev->motion.windowID);
 
     if (!qemu_console_is_graphic(scon->dcl.con)) {
         return;
@@ -468,7 +468,7 @@ static void handle_mousebutton(SDL_Event *ev)
 {
     int buttonstate = SDL_GetMouseState(NULL, NULL);
     SDL_MouseButtonEvent *bev;
-    struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
+    struct sdl2_console *scon = get_scon_from_window(ev->button.windowID);
 
     if (!qemu_console_is_graphic(scon->dcl.con)) {
         return;
@@ -492,7 +492,7 @@ static void handle_mousebutton(SDL_Event *ev)
 
 static void handle_mousewheel(SDL_Event *ev)
 {
-    struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
+    struct sdl2_console *scon = get_scon_from_window(ev->wheel.windowID);
     SDL_MouseWheelEvent *wev = &ev->wheel;
     InputButton btn;
 
-- 
2.9.3
