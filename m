Received: from eggs.gnu.org ([2001:4830:134:3::10]:39776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsY-0000Tb-Fv
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsW-0005dI-Cl
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoXsW-0005cS-7v
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:24 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 18:08:20 +0100
Message-Id: <20180221170820.15365-6-kraxel@redhat.com>
In-Reply-To: <20180221170820.15365-1-kraxel@redhat.com>
References: <20180221170820.15365-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 5/5] sdl2: use only QKeyCode in
 sdl2_process_key()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com, berrange@redhat.com, peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>

Small cleanup.  Also drop the special backspace handling,
kbd_put_qcode_console() learned to handle that meanwhile.
And sdl2_process_key is never called with scon == NULL.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 82ec375ea2..f0847dd745 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -39,23 +39,19 @@ void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev)
 {
     int qcode;
-    QemuConsole *con = scon ? scon->dcl.con : NULL;
+    QemuConsole *con = scon->dcl.con;
 
     if (ev->keysym.scancode >= qemu_input_map_usb_to_qcode_len) {
         return;
     }
-
     qcode = qemu_input_map_usb_to_qcode[ev->keysym.scancode];
 
     if (!qemu_console_is_graphic(con)) {
         if (ev->type == SDL_KEYDOWN) {
-            switch (ev->keysym.scancode) {
-            case SDL_SCANCODE_RETURN:
+            switch (qcode) {
+            case Q_KEY_CODE_RET:
                 kbd_put_keysym_console(con, '\n');
                 break;
-            case SDL_SCANCODE_BACKSPACE:
-                kbd_put_keysym_console(con, QEMU_KEY_BACKSPACE);
-                break;
             default:
                 kbd_put_qcode_console(con, qcode);
                 break;
-- 
2.9.3
