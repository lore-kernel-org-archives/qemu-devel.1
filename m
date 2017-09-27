Received: from eggs.gnu.org ([2001:4830:134:3::10]:43865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dx7po-0006IY-EX
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dx7pi-0007yF-KH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dx7pi-0007xD-C2
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:36:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 929DF883C5
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 08:36:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 27 Sep 2017 10:36:36 +0200
Message-Id: <20170927083636.26648-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] console: purge curses bits from console.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Handle the translation from vga chars to curses chars in curses_update()
instead of console_write_ch().  Purge any curses support bits from
ui/console.h include file.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 23 ++---------------------
 ui/curses.c          | 25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 8024878bae..6966e4bd9d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -336,29 +336,10 @@ static inline pixman_format_code_t surface_format(DisplaySurface *s)
     return s->format;
 }
 
-#ifdef CONFIG_CURSES
-/* KEY_EVENT is defined in wincon.h and in curses.h. Avoid redefinition. */
-#undef KEY_EVENT
-#include <curses.h>
-#undef KEY_EVENT
-typedef chtype console_ch_t;
-extern chtype vga_to_curses[];
-#else
-typedef unsigned long console_ch_t;
-#endif
+typedef uint32_t console_ch_t;
+
 static inline void console_write_ch(console_ch_t *dest, uint32_t ch)
 {
-    uint8_t c = ch;
-#ifdef CONFIG_CURSES
-    if (vga_to_curses[c]) {
-        ch &= ~(console_ch_t)0xff;
-        ch |= vga_to_curses[c];
-    }
-#else
-    if (c == '\0') {
-        ch |= ' ';
-    }
-#endif
     *dest = ch;
 }
 
diff --git a/ui/curses.c b/ui/curses.c
index 03cefdf470..85503876c0 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -33,6 +33,11 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 
+/* KEY_EVENT is defined in wincon.h and in curses.h. Avoid redefinition. */
+#undef KEY_EVENT
+#include <curses.h>
+#undef KEY_EVENT
+
 #define FONT_HEIGHT 16
 #define FONT_WIDTH 8
 
@@ -42,16 +47,26 @@ static WINDOW *screenpad = NULL;
 static int width, height, gwidth, gheight, invalidate;
 static int px, py, sminx, sminy, smaxx, smaxy;
 
-chtype vga_to_curses[256];
+static chtype vga_to_curses[256];
 
 static void curses_update(DisplayChangeListener *dcl,
                           int x, int y, int w, int h)
 {
-    chtype *line;
+    console_ch_t *line;
+    chtype curses_line[width];
 
-    line = ((chtype *) screen) + y * width;
-    for (h += y; y < h; y ++, line += width)
-        mvwaddchnstr(screenpad, y, 0, line, width);
+    line = screen + y * width;
+    for (h += y; y < h; y ++, line += width) {
+        for (x = 0; x < width; x++) {
+            chtype ch = line[x] & 0xff;
+            chtype at = line[x] & ~0xff;
+            if (vga_to_curses[ch]) {
+                ch = vga_to_curses[ch];
+            }
+            curses_line[x] = ch | at;
+        }
+        mvwaddchnstr(screenpad, y, 0, curses_line, width);
+    }
 
     pnoutrefresh(screenpad, py, px, sminy, sminx, smaxy - 1, smaxx - 1);
     refresh();
-- 
2.9.3
