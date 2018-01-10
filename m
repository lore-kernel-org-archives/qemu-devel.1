Received: from eggs.gnu.org ([2001:4830:134:3::10]:33339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZKmH-0003AY-23
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZKmD-0004oZ-TX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:07:05 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 10 Jan 2018 19:06:48 +0100
Message-Id: <1515607608-18250-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] ui/sdl2: Ignore key repeats for shortcut keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

Holding down a shortcut key currently continuesly triggers the shortcut
event, e.g. holding CTRL-ALT-f continuesly switches between windowed and
fullscreen mode, or holding CTRL-ALT-u even crashes QEMU with a segfault.
This is ugly, we should rather ignore automatic key repeats when handling
the keyboard shortcuts.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 ui/sdl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 8718cf3..18664b4 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -349,7 +349,7 @@ static void handle_keydown(SDL_Event *ev)
     }
     gui_key_modifier_pressed = mod_state;
 
-    if (gui_key_modifier_pressed) {
+    if (gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
         case SDL_SCANCODE_3:
-- 
1.8.3.1
