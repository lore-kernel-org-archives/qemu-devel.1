Received: from eggs.gnu.org ([2001:4830:134:3::10]:38317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fXheI-0004TV-1C
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 02:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fXheE-0004uT-Q5
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 02:40:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33670)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fXheE-0004sp-FA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 02:40:18 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 26 Jun 2018 09:40:17 +0300
Message-ID: <20180626064017.17031.47954.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] sdl2: fix copypaste issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru

This patch fixes text and mouse event processing. These functions used
'key' field of the event instead of appropriate 'text', 'motion', 'button',
or 'wheel'.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
---
 ui/sdl2.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3ae4719..3fff9f5 100644
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
 
