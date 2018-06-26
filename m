Received: from eggs.gnu.org ([2001:4830:134:3::10]:39572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fXhlE-00061i-2f
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 02:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fXhlB-0008T4-0d
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 02:47:32 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34066)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fXhlA-0008Sn-NK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 02:47:28 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 26 Jun 2018 09:47:29 +0300
Message-ID: <20180626064729.18070.47600.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] sdl2: add checking for NULL
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

Sometimes SDL2 console can't be retrieved on events and scon variable
becomes NULL. This patch prevents processing of the events when the console
is not available.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
---
 ui/sdl2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3fff9f5..76e5942 100644
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
 
