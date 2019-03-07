Received: from eggs.gnu.org ([209.51.188.92]:58082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugZ-0007dR-H5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugX-00031Q-Ue
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1ugX-00030f-KY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:49 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 16:11:38 +0100
Message-Id: <20190307151141.6483-5-kraxel@redhat.com>
In-Reply-To: <20190307151141.6483-1-kraxel@redhat.com>
References: <20190307151141.6483-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] curses: add option to specify VGA font
 encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Eddie Kohler <ekohler@gmail.com>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

This uses iconv to convert glyphs from the specified VGA font encoding to
unicode, and makes use of cchar_t instead of chtype when using ncursesw,
which allows to store all wide char as well as the WACS values. The default
charset is made CP437 since that is the charset of the hardware default VGA
font. This also makes the curses backend set the LC_CTYPE locale to "" to
allow curses to emit wide characters.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Eddie Kohler <ekohler@gmail.com>
Message-Id: <20190304210217.7056-3-samuel.thibault@ens-lyon.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure       |   5 +-
 ui/curses.c     | 315 ++++++++++++++++++++++++++++++++++++++++--------
 qapi/ui.json    |  14 +++
 qemu-options.hx |   5 +-
 4 files changed, 290 insertions(+), 49 deletions(-)

diff --git a/configure b/configure
index c594d2be18c7..8422bf5eef70 100755
--- a/configure
+++ b/configure
@@ -3475,14 +3475,17 @@ if test "$curses" != "no" ; then
 #include <locale.h>
 #include <curses.h>
 #include <wchar.h>
+#include <langinfo.h>
 int main(void) {
+  const char *codeset;
   wchar_t wch = L'w';
   setlocale(LC_ALL, "");
   resize_term(0, 0);
   addwstr(L"wide chars\n");
   addnwstr(&wch, 1);
   add_wch(WACS_DEGREE);
-  return 0;
+  codeset = nl_langinfo(CODESET);
+  return codeset != 0;
 }
 EOF
   IFS=:
diff --git a/ui/curses.c b/ui/curses.c
index 37954ce1b046..3a7e8649f3de 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -27,6 +27,10 @@
 #include <sys/ioctl.h>
 #include <termios.h>
 #endif
+#include <locale.h>
+#include <wchar.h>
+#include <langinfo.h>
+#include <iconv.h>
 
 #include "qapi/error.h"
 #include "qemu-common.h"
@@ -54,25 +58,30 @@ static WINDOW *screenpad = NULL;
 static int width, height, gwidth, gheight, invalidate;
 static int px, py, sminx, sminy, smaxx, smaxy;
 
-static chtype vga_to_curses[256];
+static const char *font_charset = "CP437";
+static cchar_t vga_to_curses[256];
 
 static void curses_update(DisplayChangeListener *dcl,
                           int x, int y, int w, int h)
 {
     console_ch_t *line;
-    chtype curses_line[width];
+    cchar_t curses_line[width];
 
     line = screen + y * width;
     for (h += y; y < h; y ++, line += width) {
         for (x = 0; x < width; x++) {
             chtype ch = line[x] & 0xff;
             chtype at = line[x] & ~0xff;
-            if (vga_to_curses[ch]) {
-                ch = vga_to_curses[ch];
+            if (vga_to_curses[ch].chars[0]) {
+                curses_line[x] = vga_to_curses[ch];
+            } else {
+                curses_line[x].chars[0] = ch;
+                curses_line[x].chars[1] = 0;
+                curses_line[x].attr = 0;
             }
-            curses_line[x] = ch | at;
+            curses_line[x].attr |= at;
         }
-        mvwaddchnstr(screenpad, y, 0, curses_line, width);
+        mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
     }
 
     pnoutrefresh(screenpad, py, px, sminy, sminx, smaxy - 1, smaxx - 1);
@@ -391,6 +400,254 @@ static void curses_atexit(void)
     endwin();
 }
 
+/* Setup wchar glyph for one UCS-2 char */
+static void convert_ucs(int glyph, uint16_t ch, iconv_t conv)
+{
+    wchar_t wch;
+    char *pch, *pwch;
+    size_t sch, swch;
+
+    pch = (char *) &ch;
+    pwch = (char *) &wch;
+    sch = sizeof(ch);
+    swch = sizeof(wch);
+
+    if (iconv(conv, &pch, &sch, &pwch, &swch) == (size_t) -1) {
+        fprintf(stderr, "Could not convert 0x%04x from UCS-2 to WCHAR_T: %s\n",
+                        ch, strerror(errno));
+    } else {
+        vga_to_curses[glyph].chars[0] = wch;
+    }
+}
+
+/* Setup wchar glyph for one font character */
+static void convert_font(unsigned char ch, iconv_t conv)
+{
+    wchar_t wch;
+    char *pch, *pwch;
+    size_t sch, swch;
+
+    pch = (char *) &ch;
+    pwch = (char *) &wch;
+    sch = sizeof(ch);
+    swch = sizeof(wch);
+
+    if (iconv(conv, &pch, &sch, &pwch, &swch) == (size_t) -1) {
+        fprintf(stderr, "Could not convert 0x%02x from %s to WCHAR_T: %s\n",
+                        ch, font_charset, strerror(errno));
+    } else {
+        vga_to_curses[ch].chars[0] = wch;
+    }
+}
+
+/* Convert one wchar to UCS-2 */
+static uint16_t get_ucs(wchar_t wch, iconv_t conv)
+{
+    uint16_t ch;
+    char *pch, *pwch;
+    size_t sch, swch;
+
+    pch = (char *) &ch;
+    pwch = (char *) &wch;
+    sch = sizeof(ch);
+    swch = sizeof(wch);
+
+    if (iconv(conv, &pwch, &swch, &pch, &sch) == (size_t) -1) {
+        fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
+                        wch, strerror(errno));
+        return 0xFFFD;
+    }
+
+    return ch;
+}
+
+/*
+ * Setup mapping for vga to curses line graphics.
+ */
+static void font_setup(void)
+{
+    /*
+     * Control characters are normally non-printable, but VGA does have
+     * well-known glyphs for them.
+     */
+    static uint16_t control_characters[0x20] = {
+      0x0020,
+      0x263a,
+      0x263b,
+      0x2665,
+      0x2666,
+      0x2663,
+      0x2660,
+      0x2022,
+      0x25d8,
+      0x25cb,
+      0x25d9,
+      0x2642,
+      0x2640,
+      0x266a,
+      0x266b,
+      0x263c,
+      0x25ba,
+      0x25c4,
+      0x2195,
+      0x203c,
+      0x00b6,
+      0x00a7,
+      0x25ac,
+      0x21a8,
+      0x2191,
+      0x2193,
+      0x2192,
+      0x2190,
+      0x221f,
+      0x2194,
+      0x25b2,
+      0x25bc
+    };
+
+    iconv_t ucs_to_wchar_conv;
+    iconv_t wchar_to_ucs_conv;
+    iconv_t font_conv;
+    int i;
+
+    ucs_to_wchar_conv = iconv_open("WCHAR_T", "UCS-2");
+    if (ucs_to_wchar_conv == (iconv_t) -1) {
+        fprintf(stderr, "Could not convert font glyphs from UCS-2: '%s'\n",
+                        strerror(errno));
+        exit(1);
+    }
+
+    wchar_to_ucs_conv = iconv_open("UCS-2", "WCHAR_T");
+    if (wchar_to_ucs_conv == (iconv_t) -1) {
+        fprintf(stderr, "Could not convert font glyphs to UCS-2: '%s'\n",
+                        strerror(errno));
+        exit(1);
+    }
+
+    font_conv = iconv_open("WCHAR_T", font_charset);
+    if (font_conv == (iconv_t) -1) {
+        fprintf(stderr, "Could not convert font glyphs from %s: '%s'\n",
+                        font_charset, strerror(errno));
+        exit(1);
+    }
+
+    /* Control characters */
+    for (i = 0; i <= 0x1F; i++) {
+        convert_ucs(i, control_characters[i], ucs_to_wchar_conv);
+    }
+
+    for (i = 0x20; i <= 0xFF; i++) {
+        convert_font(i, font_conv);
+    }
+
+    /* DEL */
+    convert_ucs(0x7F, 0x2302, ucs_to_wchar_conv);
+
+    if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
+        /* Non-Unicode capable, use termcap equivalents for those available */
+        for (i = 0; i <= 0xFF; i++) {
+            switch (get_ucs(vga_to_curses[i].chars[0], wchar_to_ucs_conv)) {
+            case 0x00a3:
+                vga_to_curses[i] = *WACS_STERLING;
+                break;
+            case 0x2591:
+                vga_to_curses[i] = *WACS_BOARD;
+                break;
+            case 0x2592:
+                vga_to_curses[i] = *WACS_CKBOARD;
+                break;
+            case 0x2502:
+                vga_to_curses[i] = *WACS_VLINE;
+                break;
+            case 0x2524:
+                vga_to_curses[i] = *WACS_RTEE;
+                break;
+            case 0x2510:
+                vga_to_curses[i] = *WACS_URCORNER;
+                break;
+            case 0x2514:
+                vga_to_curses[i] = *WACS_LLCORNER;
+                break;
+            case 0x2534:
+                vga_to_curses[i] = *WACS_BTEE;
+                break;
+            case 0x252c:
+                vga_to_curses[i] = *WACS_TTEE;
+                break;
+            case 0x251c:
+                vga_to_curses[i] = *WACS_LTEE;
+                break;
+            case 0x2500:
+                vga_to_curses[i] = *WACS_HLINE;
+                break;
+            case 0x253c:
+                vga_to_curses[i] = *WACS_PLUS;
+                break;
+            case 0x256c:
+                vga_to_curses[i] = *WACS_LANTERN;
+                break;
+            case 0x256a:
+                vga_to_curses[i] = *WACS_NEQUAL;
+                break;
+            case 0x2518:
+                vga_to_curses[i] = *WACS_LRCORNER;
+                break;
+            case 0x250c:
+                vga_to_curses[i] = *WACS_ULCORNER;
+                break;
+            case 0x2588:
+                vga_to_curses[i] = *WACS_BLOCK;
+                break;
+            case 0x03c0:
+                vga_to_curses[i] = *WACS_PI;
+                break;
+            case 0x00b1:
+                vga_to_curses[i] = *WACS_PLMINUS;
+                break;
+            case 0x2265:
+                vga_to_curses[i] = *WACS_GEQUAL;
+                break;
+            case 0x2264:
+                vga_to_curses[i] = *WACS_LEQUAL;
+                break;
+            case 0x00b0:
+                vga_to_curses[i] = *WACS_DEGREE;
+                break;
+            case 0x25a0:
+                vga_to_curses[i] = *WACS_BULLET;
+                break;
+            case 0x2666:
+                vga_to_curses[i] = *WACS_DIAMOND;
+                break;
+            case 0x2192:
+                vga_to_curses[i] = *WACS_RARROW;
+                break;
+            case 0x2190:
+                vga_to_curses[i] = *WACS_LARROW;
+                break;
+            case 0x2191:
+                vga_to_curses[i] = *WACS_UARROW;
+                break;
+            case 0x2193:
+                vga_to_curses[i] = *WACS_DARROW;
+                break;
+            case 0x23ba:
+                vga_to_curses[i] = *WACS_S1;
+                break;
+            case 0x23bb:
+                vga_to_curses[i] = *WACS_S3;
+                break;
+            case 0x23bc:
+                vga_to_curses[i] = *WACS_S7;
+                break;
+            case 0x23bd:
+                vga_to_curses[i] = *WACS_S9;
+                break;
+            }
+        }
+    }
+}
+
 static void curses_setup(void)
 {
     int i, colour_default[8] = {
@@ -420,47 +677,7 @@ static void curses_setup(void)
         init_pair(i, COLOR_WHITE, COLOR_BLACK);
     }
 
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
+    font_setup();
 }
 
 static void curses_keyboard_setup(void)
@@ -493,6 +710,10 @@ static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 #endif
 
+    setlocale(LC_CTYPE, "");
+    if (opts->u.curses.charset) {
+        font_charset = opts->u.curses.charset;
+    }
     curses_setup();
     curses_keyboard_setup();
     atexit(curses_atexit);
diff --git a/qapi/ui.json b/qapi/ui.json
index c5d1d7f09966..59e412139adc 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1080,6 +1080,19 @@
  { 'enum'    : 'DisplayGLMode',
    'data'    : [ 'off', 'on', 'core', 'es' ] }
 
+##
+# @DisplayCurses:
+#
+# Curses display options.
+#
+# @charset:       Font charset used by guest (default: CP437).
+#
+# Since: 4.0
+#
+##
+{ 'struct'  : 'DisplayCurses',
+  'data'    : { '*charset'       : 'str' } }
+
 ##
 # @DisplayType:
 #
@@ -1142,6 +1155,7 @@
                 '*gl'            : 'DisplayGLMode' },
   'discriminator' : 'type',
   'data'    : { 'gtk'            : 'DisplayGTK',
+                'curses'         : 'DisplayCurses',
                 'egl-headless'   : 'DisplayEGLHeadless'} }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index 1cf9aac1fe35..4bc4e736bb47 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1216,7 +1216,7 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     "            [,window_close=on|off][,gl=on|core|es|off]\n"
     "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
     "-display vnc=<display>[,<optargs>]\n"
-    "-display curses\n"
+    "-display curses[,charset=<encoding>]\n"
     "-display none\n"
     "-display egl-headless[,rendernode=<file>]"
     "                select display type\n"
@@ -1248,6 +1248,9 @@ support a text mode, QEMU can display this output using a
 curses/ncurses interface. Nothing is displayed when the graphics
 device is in graphical mode or if the graphics device does not support
 a text mode. Generally only the VGA device models support text mode.
+The font charset used by the guest can be specified with the
+@code{charset} option, for example @code{charset=CP850} for IBM CP850
+encoding. The default is @code{CP437}.
 @item none
 Do not display video output. The guest will still see an emulated
 graphics card, but its output will not be displayed to the QEMU
-- 
2.18.1
