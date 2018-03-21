Received: from eggs.gnu.org ([2001:4830:134:3::10]:53033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8i-00070e-Fm
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8h-0007vt-My
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eye8h-0007vK-JL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:51 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Mar 2018 14:50:38 +0100
Message-Id: <20180321135041.15768-4-kraxel@redhat.com>
In-Reply-To: <20180321135041.15768-1-kraxel@redhat.com>
References: <20180321135041.15768-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] sdl2: enable ctrl modifier keys for text
 consoles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, balaton@eik.bme.hu

Unbreaks ctrl-pageup/pagedown scrollback.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 8d0d9ba17c..62c2b58ef0 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -90,6 +90,8 @@ void sdl2_process_key(struct sdl2_console *scon,
     }
 
     if (!qemu_console_is_graphic(con)) {
+        bool ctrl = (modifiers_state[SDL_SCANCODE_LCTRL] ||
+                     modifiers_state[SDL_SCANCODE_RCTRL]);
         if (ev->type == SDL_KEYDOWN) {
             switch (ev->keysym.scancode) {
             case SDL_SCANCODE_RETURN:
@@ -99,7 +101,7 @@ void sdl2_process_key(struct sdl2_console *scon,
                 kbd_put_keysym_console(con, QEMU_KEY_BACKSPACE);
                 break;
             default:
-                kbd_put_qcode_console(con, qcode, false);
+                kbd_put_qcode_console(con, qcode, ctrl);
                 break;
             }
         }
-- 
2.9.3
