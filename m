Received: from eggs.gnu.org ([2001:4830:134:3::10]:52984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8e-0006x8-0X
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8b-0007sf-4B
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eye8a-0007rx-Uu
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Mar 2018 14:50:36 +0100
Message-Id: <20180321135041.15768-2-kraxel@redhat.com>
In-Reply-To: <20180321135041.15768-1-kraxel@redhat.com>
References: <20180321135041.15768-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] ui: add ctrl modifier support to
 kbd_put_qcode_console()
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  2 +-
 ui/console.c         | 15 +++++++++++++--
 ui/gtk.c             |  4 ++--
 ui/sdl2-input.c      |  2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 6d2c052068..37a8d68d29 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -99,7 +99,7 @@ void hmp_mouse_set(Monitor *mon, const QDict *qdict);
 #define QEMU_KEY_CTRL_PAGEDOWN   0xe407
 
 void kbd_put_keysym_console(QemuConsole *s, int keysym);
-bool kbd_put_qcode_console(QemuConsole *s, int qcode);
+bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl);
 void kbd_put_string_console(QemuConsole *s, const char *str, int len);
 void kbd_put_keysym(int keysym);
 
diff --git a/ui/console.c b/ui/console.c
index 530a491987..3fb2f4e09f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1191,11 +1191,22 @@ static const int qcode_to_keysym[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_BACKSPACE] = QEMU_KEY_BACKSPACE,
 };
 
-bool kbd_put_qcode_console(QemuConsole *s, int qcode)
+static const int ctrl_qcode_to_keysym[Q_KEY_CODE__MAX] = {
+    [Q_KEY_CODE_UP]     = QEMU_KEY_CTRL_UP,
+    [Q_KEY_CODE_DOWN]   = QEMU_KEY_CTRL_DOWN,
+    [Q_KEY_CODE_RIGHT]  = QEMU_KEY_CTRL_RIGHT,
+    [Q_KEY_CODE_LEFT]   = QEMU_KEY_CTRL_LEFT,
+    [Q_KEY_CODE_HOME]   = QEMU_KEY_CTRL_HOME,
+    [Q_KEY_CODE_END]    = QEMU_KEY_CTRL_END,
+    [Q_KEY_CODE_PGUP]   = QEMU_KEY_CTRL_PAGEUP,
+    [Q_KEY_CODE_PGDN]   = QEMU_KEY_CTRL_PAGEDOWN,
+};
+
+bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl)
 {
     int keysym;
 
-    keysym = qcode_to_keysym[qcode];
+    keysym = ctrl ? ctrl_qcode_to_keysym[qcode] : qcode_to_keysym[qcode];
     if (keysym == 0) {
         return false;
     }
diff --git a/ui/gtk.c b/ui/gtk.c
index ef5bc42094..e98ac4d2fc 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1197,12 +1197,12 @@ static gboolean gd_text_key_down(GtkWidget *widget,
     QemuConsole *con = vc->gfx.dcl.con;
 
     if (key->keyval == GDK_KEY_Delete) {
-        kbd_put_qcode_console(con, Q_KEY_CODE_DELETE);
+        kbd_put_qcode_console(con, Q_KEY_CODE_DELETE, false);
     } else if (key->length) {
         kbd_put_string_console(con, key->string, key->length);
     } else {
         int qcode = gd_map_keycode(key->hardware_keycode);
-        kbd_put_qcode_console(con, qcode);
+        kbd_put_qcode_console(con, qcode, false);
     }
     return TRUE;
 }
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 605d781971..35d35c14c4 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -70,7 +70,7 @@ void sdl2_process_key(struct sdl2_console *scon,
                 kbd_put_keysym_console(con, QEMU_KEY_BACKSPACE);
                 break;
             default:
-                kbd_put_qcode_console(con, qcode);
+                kbd_put_qcode_console(con, qcode, false);
                 break;
             }
         }
-- 
2.9.3
