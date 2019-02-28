Received: from eggs.gnu.org ([209.51.188.92]:49450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ekohler@gmail.com>) id 1gzSZx-00070Y-Kq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ekohler@gmail.com>) id 1gzSZv-00053B-P8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:46:53 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ekohler@gmail.com>) id 1gzSZt-00051T-Ur
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:46:51 -0500
Received: by mail-qt1-x844.google.com with SMTP id u7so16010094qtg.9
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:46:48 -0800 (PST)
From: Eddie Kohler <ekohler@gmail.com>
Date: Thu, 28 Feb 2019 15:46:38 -0500
Message-Id: <20190228204638.4928-1-ekohler@gmail.com>
Subject: [Qemu-devel] [PATCH] Use wide-character ncurses functions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eddie Kohler <ekohler@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi,

QEMU is unable to display all VGA characters to console output; for
instance, the smiley (VGA character 0x01) is printed just as
\001. However, QEMU links with the wide-character ncurses library,
which can output all VGA characters (since they have Unicode
equivalents). The attached patch switches QEMU to use wide-character
functions, using the VGA character Unicode equivalents from
Wikipedia. It works for me, and I'm hoping something like it would be
acceptable for QEMU.

Thanks for any comments,
Eddie Kohler

***

All VGA console characters have Unicode equivalents, and most
modern terminals can display them.

Signed-off-by: Eddie Kohler <ekohler@gmail.com>
---
 ui/curses.c | 143 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 92 insertions(+), 51 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 6e0091c3b2..a07528770f 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -27,6 +27,7 @@
 #include <sys/ioctl.h>
 #include <termios.h>
 #endif
+#include <locale.h>
 
 #include "qapi/error.h"
 #include "qemu-common.h"
@@ -48,25 +49,106 @@ static WINDOW *screenpad = NULL;
 static int width, height, gwidth, gheight, invalidate;
 static int px, py, sminx, sminy, smaxx, smaxy;
 
-static chtype vga_to_curses[256];
+static const wchar_t vga_to_wchar[256] = {
+    // 0x0_
+    L' ', L'\u263A', L'\u263B', L'\u2665',
+    L'\u2666', L'\u2663', L'\u2660', L'\u2022',
+    L'\u25D8', L'\u25CB', L'\u25D9', L'\u2642',
+    L'\u2640', L'\u266A', L'\u266B', L'\u263C',
+
+    // 0x1_
+    L'\u25BA', L'\u25C4', L'\u2195', L'\u203C',
+    L'\u00B6', L'\u00A7', L'\u25AC', L'\u21A8',
+    L'\u2191', L'\u2193', L'\u2192', L'\u2190',
+    L'\u221F', L'\u2194', L'\u25B2', L'\u25BC',
+
+    // 0x2_
+    L' ', L'!', L'"', L'#', L'$', L'%', L'&', L'\'',
+    L'(', L')', L'*', L'+', L',', L'-', L'.', L'/',
+
+    // 0x3_
+    L'0', L'1', L'2', L'3', L'4', L'5', L'6', L'7',
+    L'8', L'9', L':', L';', L'<', L'=', L'>', L'?',
+
+    // 0x4_
+    L'@', L'A', L'B', L'C', L'D', L'E', L'F', L'G',
+    L'H', L'I', L'J', L'K', L'L', L'M', L'N', L'O',
+
+    // 0x5_
+    L'P', L'Q', L'R', L'S', L'T', L'U', L'V', L'W',
+    L'X', L'Y', L'Z', L'[', L'\\', L']', L'^', L'_',
+
+    // 0x6_
+    L'`', L'a', L'b', L'c', L'd', L'e', L'f', L'g',
+    L'h', L'i', L'j', L'k', L'l', L'm', L'n', L'o',
+
+    // 0x7_
+    L'p', L'q', L'r', L's', L't', L'u', L'v', L'w',
+    L'x', L'y', L'z', L'{', L'|', L'}', L'~', L'\u2302',
+
+    // 0x8_
+    L'\u00C7', L'\u00FC', L'\u00E9', L'\u00E2',
+    L'\u00E4', L'\u00E0', L'\u00E5', L'\u00E7',
+    L'\u00EA', L'\u00EB', L'\u00E8', L'\u00EF',
+    L'\u00EE', L'\u00EC', L'\u00C4', L'\u00C5',
+
+    // 0x9_
+    L'\u00C9', L'\u00E6', L'\u00C6', L'\u00F4',
+    L'\u00F6', L'\u00F2', L'\u00FB', L'\u00F9',
+    L'\u00FF', L'\u00D6', L'\u00DC', L'\u00A2',
+    L'\u00A3', L'\u00A5', L'\u20A7', L'\u0192',
+
+    // 0xA_
+    L'\u00E1', L'\u00ED', L'\u00F3', L'\u00FA',
+    L'\u00F1', L'\u00D1', L'\u00AA', L'\u00BA',
+    L'\u00BF', L'\u2310', L'\u00AC', L'\u00BD',
+    L'\u00BC', L'\u00A1', L'\u00AB', L'\u00BB',
+
+    // 0xB_
+    L'\u2591', L'\u2592', L'\u2593', L'\u2502',
+    L'\u2524', L'\u2561', L'\u2562', L'\u2556',
+    L'\u2555', L'\u2563', L'\u2551', L'\u2557',
+    L'\u255D', L'\u255C', L'\u255B', L'\u2510',
+
+    // 0xC_
+    L'\u2514', L'\u2534', L'\u252C', L'\u251C',
+    L'\u2500', L'\u253C', L'\u255E', L'\u255F',
+    L'\u255A', L'\u2554', L'\u2569', L'\u2566',
+    L'\u2560', L'\u2550', L'\u256C', L'\u2567',
+
+    // 0xD_
+    L'\u2568', L'\u2564', L'\u2565', L'\u2559',
+    L'\u2558', L'\u2552', L'\u2553', L'\u256B',
+    L'\u256A', L'\u2518', L'\u250C', L'\u2588',
+    L'\u2584', L'\u258C', L'\u2590', L'\u2580',
+
+    // 0xE_
+    L'\u03B1', L'\u00DF', L'\u0393', L'\u03C0',
+    L'\u03A3', L'\u03C3', L'\u00B5', L'\u03C4',
+    L'\u03A6', L'\u0398', L'\u03A9', L'\u03B4',
+    L'\u221E', L'\u03C6', L'\u03B5', L'\u2229',
+
+    // 0xF_
+    L'\u2261', L'\u00B1', L'\u2265', L'\u2264',
+    L'\u2320', L'\u2321', L'\u00F7', L'\u2248',
+    L'\u00B0', L'\u2219', L'\u00B7', L'\u221A',
+    L'\u207F', L'\u00B2', L'\u25A0', L'\u00A0'
+};
 
 static void curses_update(DisplayChangeListener *dcl,
                           int x, int y, int w, int h)
 {
     console_ch_t *line;
-    chtype curses_line[width];
+    cchar_t curses_line[width];
 
     line = screen + y * width;
     for (h += y; y < h; y ++, line += width) {
         for (x = 0; x < width; x++) {
-            chtype ch = line[x] & 0xff;
-            chtype at = line[x] & ~0xff;
-            if (vga_to_curses[ch]) {
-                ch = vga_to_curses[ch];
-            }
-            curses_line[x] = ch | at;
+            curses_line[x].attr = line[x] & ~0xff;
+            curses_line[x].chars[0] = vga_to_wchar[line[x] & 0xff];
+            curses_line[x].chars[1] = L'\0';
         }
-        mvwaddchnstr(screenpad, y, 0, curses_line, width);
+        mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
     }
 
     pnoutrefresh(screenpad, py, px, sminy, sminx, smaxy - 1, smaxx - 1);
@@ -358,6 +440,7 @@ static void curses_setup(void)
 
     /* input as raw as possible, let everything be interpreted
      * by the guest system */
+    setlocale(LC_ALL, "");
     initscr(); noecho(); intrflush(stdscr, FALSE);
     nodelay(stdscr, TRUE); nonl(); keypad(stdscr, TRUE);
     start_color(); raw(); scrollok(stdscr, FALSE);
@@ -370,48 +453,6 @@ static void curses_setup(void)
     for (i = 64; i < COLOR_PAIRS; i++) {
         init_pair(i, COLOR_WHITE, COLOR_BLACK);
     }
-
-    /*
-     * Setup mapping for vga to curses line graphics.
-     * FIXME: for better font, have to use ncursesw and setlocale()
-     */
-#if 0
-    /* FIXME: map from where? */
-    ACS_S1;
-    ACS_S3;
-    ACS_S7;
-    ACS_S9;
-#endif
-    /* ACS_* is not constant. So, we can't initialize statically. */
-    vga_to_curses['\0'] = ' ';
-    vga_to_curses[0x04] = ACS_DIAMOND;
-    vga_to_curses[0x18] = ACS_UARROW;
-    vga_to_curses[0x19] = ACS_DARROW;
-    vga_to_curses[0x1a] = ACS_RARROW;
-    vga_to_curses[0x1b] = ACS_LARROW;
-    vga_to_curses[0x9c] = ACS_STERLING;
-    vga_to_curses[0xb0] = ACS_BOARD;
-    vga_to_curses[0xb1] = ACS_CKBOARD;
-    vga_to_curses[0xb3] = ACS_VLINE;
-    vga_to_curses[0xb4] = ACS_RTEE;
-    vga_to_curses[0xbf] = ACS_URCORNER;
-    vga_to_curses[0xc0] = ACS_LLCORNER;
-    vga_to_curses[0xc1] = ACS_BTEE;
-    vga_to_curses[0xc2] = ACS_TTEE;
-    vga_to_curses[0xc3] = ACS_LTEE;
-    vga_to_curses[0xc4] = ACS_HLINE;
-    vga_to_curses[0xc5] = ACS_PLUS;
-    vga_to_curses[0xce] = ACS_LANTERN;
-    vga_to_curses[0xd8] = ACS_NEQUAL;
-    vga_to_curses[0xd9] = ACS_LRCORNER;
-    vga_to_curses[0xda] = ACS_ULCORNER;
-    vga_to_curses[0xdb] = ACS_BLOCK;
-    vga_to_curses[0xe3] = ACS_PI;
-    vga_to_curses[0xf1] = ACS_PLMINUS;
-    vga_to_curses[0xf2] = ACS_GEQUAL;
-    vga_to_curses[0xf3] = ACS_LEQUAL;
-    vga_to_curses[0xf8] = ACS_DEGREE;
-    vga_to_curses[0xfe] = ACS_BULLET;
 }
 
 static void curses_keyboard_setup(void)
-- 
2.17.1
