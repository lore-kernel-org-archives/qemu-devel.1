Received: from eggs.gnu.org ([2001:4830:134:3::10]:44763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZafA-0003Ic-3X
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZaf6-0000Az-4f
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZaf2-00009v-Iz
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DAAC58E49
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 12:09:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Dec 2018 13:09:00 +0100
Message-Id: <20181219120904.17643-4-kraxel@redhat.com>
In-Reply-To: <20181219120904.17643-1-kraxel@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 3/7] sdl2: use only QKeyCode in
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Small cleanup.  Also drop the special backspace handling,
kbd_put_qcode_console() learned to handle that meanwhile.
And sdl2_process_key is never called with scon == NULL.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index ae52d548f6..78241c2a98 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -39,20 +39,19 @@ void sdl2_process_key(struct sdl2_console *scon,
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
     kbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
 
     if (!qemu_console_is_graphic(con)) {
         bool ctrl = kbd_state_modifier_get(scon->kbd, KBD_MOD_CTRL);
         if (ev->type == SDL_KEYDOWN) {
-            switch (ev->keysym.scancode) {
-            case SDL_SCANCODE_RETURN:
+            switch (qcode) {
+            case Q_KEY_CODE_RET:
                 kbd_put_keysym_console(con, '\n');
                 break;
             default:
-- 
2.9.3
