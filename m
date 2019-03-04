Received: from eggs.gnu.org ([209.51.188.92]:35273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0uuA-00036R-Rp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0umH-0005c1-EW
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:05:38 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:47776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h0umH-0005Xz-0s
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:05:37 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon,  4 Mar 2019 22:05:32 +0100
Message-Id: <20190304210532.7840-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] curses: support wide input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kraxel@redhat.com

This makes use of wide curses functions instead of 8bit functions. This
allows to type e.g. accented letters.

Unfortunately, key codes are then returned with values that could be
confused with wide characters by ncurses, so we need to add a maybe_keyco=
de
variable to know whether the returned value is a key code or a character
(curses with wide support), or possibly both (curses without wide support=
).

The translation tables thus also need to be separated into key code
translation and character translation.  The curses2foo helper makes it ea=
sier
to use them.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 ui/curses.c      |  76 +++++++++++++++++++++++++------
 ui/curses_keys.h | 113 +++++++++++++++++++++++++++--------------------
 2 files changed, 127 insertions(+), 62 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 6e0091c3b2..6861539b20 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -42,6 +42,12 @@
 #define FONT_HEIGHT 16
 #define FONT_WIDTH 8
=20
+enum maybe_keycode {
+    CURSES_KEYCODE,
+    CURSES_CHAR,
+    CURSES_CHAR_OR_KEYCODE,
+};
+
 static DisplayChangeListener *dcl;
 static console_ch_t screen[160 * 100];
 static WINDOW *screenpad =3D NULL;
@@ -194,9 +200,54 @@ static void curses_cursor_position(DisplayChangeList=
ener *dcl,
=20
 static kbd_layout_t *kbd_layout =3D NULL;
=20
+static wint_t console_getch(enum maybe_keycode *maybe_keycode)
+{
+    wint_t ret;
+    switch (get_wch(&ret)) {
+    case KEY_CODE_YES:
+        *maybe_keycode =3D CURSES_KEYCODE;
+        break;
+    case OK:
+        *maybe_keycode =3D CURSES_CHAR;
+        break;
+    case ERR:
+        ret =3D -1;
+        break;
+    }
+    return ret;
+}
+
+static int curses2foo(const int _curses2foo[], const int _curseskey2foo[=
],
+                      int chr, enum maybe_keycode maybe_keycode)
+{
+    int ret =3D -1;
+    if (maybe_keycode =3D=3D CURSES_CHAR) {
+        if (chr < CURSES_CHARS) {
+            ret =3D _curses2foo[chr];
+        }
+    } else {
+        if (chr < CURSES_KEYS) {
+            ret =3D _curseskey2foo[chr];
+        }
+        if (ret =3D=3D -1 && maybe_keycode =3D=3D CURSES_CHAR_OR_KEYCODE=
 &&
+            chr < CURSES_CHARS) {
+            ret =3D _curses2foo[chr];
+        }
+    }
+    return ret;
+}
+
+#define curses2keycode(chr, maybe_keycode) \
+    curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
+#define curses2keysym(chr, maybe_keycode) \
+    curses2foo(_curses2keysym, _curseskey2keysym, chr, maybe_keycode)
+#define curses2qemu(chr, maybe_keycode) \
+    curses2foo(_curses2qemu, _curseskey2qemu, chr, maybe_keycode)
+
 static void curses_refresh(DisplayChangeListener *dcl)
 {
     int chr, keysym, keycode, keycode_alt;
+    enum maybe_keycode maybe_keycode;
=20
     curses_winch_check();
=20
@@ -212,14 +263,14 @@ static void curses_refresh(DisplayChangeListener *d=
cl)
=20
     while (1) {
         /* while there are any pending key strokes to process */
-        chr =3D getch();
+        chr =3D console_getch(&maybe_keycode);
=20
-        if (chr =3D=3D ERR)
+        if (chr =3D=3D -1)
             break;
=20
 #ifdef KEY_RESIZE
         /* this shouldn't occur when we use a custom SIGWINCH handler */
-        if (chr =3D=3D KEY_RESIZE) {
+        if (maybe_keycode !=3D CURSES_CHAR && chr =3D=3D KEY_RESIZE) {
             clear();
             refresh();
             curses_calc_pad();
@@ -228,17 +279,19 @@ static void curses_refresh(DisplayChangeListener *d=
cl)
         }
 #endif
=20
-        keycode =3D curses2keycode[chr];
+        keycode =3D curses2keycode(chr, maybe_keycode);
         keycode_alt =3D 0;
=20
         /* alt key */
         if (keycode =3D=3D 1) {
-            int nextchr =3D getch();
+            enum maybe_keycode next_maybe_keycode;
+            int nextchr =3D console_getch(&next_maybe_keycode);
=20
-            if (nextchr !=3D ERR) {
+            if (nextchr !=3D -1) {
                 chr =3D nextchr;
+                maybe_keycode =3D next_maybe_keycode;
                 keycode_alt =3D ALT;
-                keycode =3D curses2keycode[chr];
+                keycode =3D curses2keycode(chr, maybe_keycode);
=20
                 if (keycode !=3D -1) {
                     keycode |=3D ALT;
@@ -258,9 +311,7 @@ static void curses_refresh(DisplayChangeListener *dcl=
)
         }
=20
         if (kbd_layout) {
-            keysym =3D -1;
-            if (chr < CURSES_KEYS)
-                keysym =3D curses2keysym[chr];
+            keysym =3D curses2keysym(chr, maybe_keycode);
=20
             if (keysym =3D=3D -1) {
                 if (chr < ' ') {
@@ -326,10 +377,7 @@ static void curses_refresh(DisplayChangeListener *dc=
l)
                 qemu_input_event_send_key_delay(0);
             }
         } else {
-            keysym =3D -1;
-            if (chr < CURSES_KEYS) {
-                keysym =3D curses2qemu[chr];
-            }
+            keysym =3D curses2qemu(chr, maybe_keycode);
             if (keysym =3D=3D -1)
                 keysym =3D chr;
=20
diff --git a/ui/curses_keys.h b/ui/curses_keys.h
index e9195a1671..71e04acdc7 100644
--- a/ui/curses_keys.h
+++ b/ui/curses_keys.h
@@ -49,22 +49,28 @@
 /* curses won't detect a Control + Alt + 1, so use Alt + 1 */
 #define QEMU_KEY_CONSOLE0   (2 | ALT)   /* (curses2keycode['1'] | ALT) *=
/
=20
+#define CURSES_CHARS        0x100       /* Support latin1 only */
 #define CURSES_KEYS         KEY_MAX     /* KEY_MAX defined in <curses.h>=
 */
=20
-static const int curses2keysym[CURSES_KEYS] =3D {
-    [0 ... (CURSES_KEYS - 1)] =3D -1,
+static const int _curses2keysym[CURSES_CHARS] =3D {
+    [0 ... (CURSES_CHARS - 1)] =3D -1,
=20
     [0x7f] =3D KEY_BACKSPACE,
     ['\r'] =3D KEY_ENTER,
     ['\n'] =3D KEY_ENTER,
     [27] =3D 27,
+};
+
+static const int _curseskey2keysym[CURSES_KEYS] =3D {
+    [0 ... (CURSES_KEYS - 1)] =3D -1,
+
     [KEY_BTAB] =3D '\t' | KEYSYM_SHIFT,
     [KEY_SPREVIOUS] =3D KEY_PPAGE | KEYSYM_SHIFT,
     [KEY_SNEXT] =3D KEY_NPAGE | KEYSYM_SHIFT,
 };
=20
-static const int curses2keycode[CURSES_KEYS] =3D {
-    [0 ... (CURSES_KEYS - 1)] =3D -1,
+static const int _curses2keycode[CURSES_CHARS] =3D {
+    [0 ... (CURSES_CHARS - 1)] =3D -1,
=20
     [0x01b] =3D 1, /* Escape */
     ['1'] =3D 2,
@@ -80,7 +86,6 @@ static const int curses2keycode[CURSES_KEYS] =3D {
     ['-'] =3D 12,
     ['=3D'] =3D 13,
     [0x07f] =3D 14, /* Backspace */
-    [KEY_BACKSPACE] =3D 14, /* Backspace */
=20
     ['\t'] =3D 15, /* Tab */
     ['q'] =3D 16,
@@ -97,7 +102,6 @@ static const int curses2keycode[CURSES_KEYS] =3D {
     [']'] =3D 27,
     ['\n'] =3D 28, /* Return */
     ['\r'] =3D 28, /* Return */
-    [KEY_ENTER] =3D 28, /* Return */
=20
     ['a'] =3D 30,
     ['s'] =3D 31,
@@ -126,33 +130,6 @@ static const int curses2keycode[CURSES_KEYS] =3D {
=20
     [' '] =3D 57,
=20
-    [KEY_F(1)] =3D 59, /* Function Key 1 */
-    [KEY_F(2)] =3D 60, /* Function Key 2 */
-    [KEY_F(3)] =3D 61, /* Function Key 3 */
-    [KEY_F(4)] =3D 62, /* Function Key 4 */
-    [KEY_F(5)] =3D 63, /* Function Key 5 */
-    [KEY_F(6)] =3D 64, /* Function Key 6 */
-    [KEY_F(7)] =3D 65, /* Function Key 7 */
-    [KEY_F(8)] =3D 66, /* Function Key 8 */
-    [KEY_F(9)] =3D 67, /* Function Key 9 */
-    [KEY_F(10)] =3D 68, /* Function Key 10 */
-    [KEY_F(11)] =3D 87, /* Function Key 11 */
-    [KEY_F(12)] =3D 88, /* Function Key 12 */
-
-    [KEY_HOME] =3D 71 | GREY, /* Home */
-    [KEY_UP] =3D 72 | GREY, /* Up Arrow */
-    [KEY_PPAGE] =3D 73 | GREY, /* Page Up */
-    [KEY_LEFT] =3D 75 | GREY, /* Left Arrow */
-    [KEY_RIGHT] =3D 77 | GREY, /* Right Arrow */
-    [KEY_END] =3D 79 | GREY, /* End */
-    [KEY_DOWN] =3D 80 | GREY, /* Down Arrow */
-    [KEY_NPAGE] =3D 81 | GREY, /* Page Down */
-    [KEY_IC] =3D 82 | GREY, /* Insert */
-    [KEY_DC] =3D 83 | GREY, /* Delete */
-
-    [KEY_SPREVIOUS] =3D 73 | GREY | SHIFT, /* Shift + Page Up */
-    [KEY_SNEXT] =3D 81 | GREY | SHIFT, /* Shift + Page Down */
-
     ['!'] =3D 2 | SHIFT,
     ['@'] =3D 3 | SHIFT,
     ['#'] =3D 4 | SHIFT,
@@ -166,7 +143,6 @@ static const int curses2keycode[CURSES_KEYS] =3D {
     ['_'] =3D 12 | SHIFT,
     ['+'] =3D 13 | SHIFT,
=20
-    [KEY_BTAB] =3D 15 | SHIFT, /* Shift + Tab */
     ['Q'] =3D 16 | SHIFT,
     ['W'] =3D 17 | SHIFT,
     ['E'] =3D 18 | SHIFT,
@@ -205,19 +181,6 @@ static const int curses2keycode[CURSES_KEYS] =3D {
     ['>'] =3D 52 | SHIFT,
     ['?'] =3D 53 | SHIFT,
=20
-    [KEY_F(13)] =3D 59 | SHIFT, /* Shift + Function Key 1 */
-    [KEY_F(14)] =3D 60 | SHIFT, /* Shift + Function Key 2 */
-    [KEY_F(15)] =3D 61 | SHIFT, /* Shift + Function Key 3 */
-    [KEY_F(16)] =3D 62 | SHIFT, /* Shift + Function Key 4 */
-    [KEY_F(17)] =3D 63 | SHIFT, /* Shift + Function Key 5 */
-    [KEY_F(18)] =3D 64 | SHIFT, /* Shift + Function Key 6 */
-    [KEY_F(19)] =3D 65 | SHIFT, /* Shift + Function Key 7 */
-    [KEY_F(20)] =3D 66 | SHIFT, /* Shift + Function Key 8 */
-    [KEY_F(21)] =3D 67 | SHIFT, /* Shift + Function Key 9 */
-    [KEY_F(22)] =3D 68 | SHIFT, /* Shift + Function Key 10 */
-    [KEY_F(23)] =3D 69 | SHIFT, /* Shift + Function Key 11 */
-    [KEY_F(24)] =3D 70 | SHIFT, /* Shift + Function Key 12 */
-
     ['Q' - '@'] =3D 16 | CNTRL, /* Control + q */
     ['W' - '@'] =3D 17 | CNTRL, /* Control + w */
     ['E' - '@'] =3D 18 | CNTRL, /* Control + e */
@@ -249,13 +212,67 @@ static const int curses2keycode[CURSES_KEYS] =3D {
=20
 };
=20
-static const int curses2qemu[CURSES_KEYS] =3D {
+static const int _curseskey2keycode[CURSES_KEYS] =3D {
     [0 ... (CURSES_KEYS - 1)] =3D -1,
=20
+    [KEY_BACKSPACE] =3D 14, /* Backspace */
+
+    [KEY_ENTER] =3D 28, /* Return */
+
+    [KEY_F(1)] =3D 59, /* Function Key 1 */
+    [KEY_F(2)] =3D 60, /* Function Key 2 */
+    [KEY_F(3)] =3D 61, /* Function Key 3 */
+    [KEY_F(4)] =3D 62, /* Function Key 4 */
+    [KEY_F(5)] =3D 63, /* Function Key 5 */
+    [KEY_F(6)] =3D 64, /* Function Key 6 */
+    [KEY_F(7)] =3D 65, /* Function Key 7 */
+    [KEY_F(8)] =3D 66, /* Function Key 8 */
+    [KEY_F(9)] =3D 67, /* Function Key 9 */
+    [KEY_F(10)] =3D 68, /* Function Key 10 */
+    [KEY_F(11)] =3D 87, /* Function Key 11 */
+    [KEY_F(12)] =3D 88, /* Function Key 12 */
+
+    [KEY_HOME] =3D 71 | GREY, /* Home */
+    [KEY_UP] =3D 72 | GREY, /* Up Arrow */
+    [KEY_PPAGE] =3D 73 | GREY, /* Page Up */
+    [KEY_LEFT] =3D 75 | GREY, /* Left Arrow */
+    [KEY_RIGHT] =3D 77 | GREY, /* Right Arrow */
+    [KEY_END] =3D 79 | GREY, /* End */
+    [KEY_DOWN] =3D 80 | GREY, /* Down Arrow */
+    [KEY_NPAGE] =3D 81 | GREY, /* Page Down */
+    [KEY_IC] =3D 82 | GREY, /* Insert */
+    [KEY_DC] =3D 83 | GREY, /* Delete */
+
+    [KEY_SPREVIOUS] =3D 73 | GREY | SHIFT, /* Shift + Page Up */
+    [KEY_SNEXT] =3D 81 | GREY | SHIFT, /* Shift + Page Down */
+
+    [KEY_BTAB] =3D 15 | SHIFT, /* Shift + Tab */
+
+    [KEY_F(13)] =3D 59 | SHIFT, /* Shift + Function Key 1 */
+    [KEY_F(14)] =3D 60 | SHIFT, /* Shift + Function Key 2 */
+    [KEY_F(15)] =3D 61 | SHIFT, /* Shift + Function Key 3 */
+    [KEY_F(16)] =3D 62 | SHIFT, /* Shift + Function Key 4 */
+    [KEY_F(17)] =3D 63 | SHIFT, /* Shift + Function Key 5 */
+    [KEY_F(18)] =3D 64 | SHIFT, /* Shift + Function Key 6 */
+    [KEY_F(19)] =3D 65 | SHIFT, /* Shift + Function Key 7 */
+    [KEY_F(20)] =3D 66 | SHIFT, /* Shift + Function Key 8 */
+    [KEY_F(21)] =3D 67 | SHIFT, /* Shift + Function Key 9 */
+    [KEY_F(22)] =3D 68 | SHIFT, /* Shift + Function Key 10 */
+    [KEY_F(23)] =3D 69 | SHIFT, /* Shift + Function Key 11 */
+    [KEY_F(24)] =3D 70 | SHIFT, /* Shift + Function Key 12 */
+};
+
+static const int _curses2qemu[CURSES_CHARS] =3D {
+    [0 ... (CURSES_CHARS - 1)] =3D -1,
+
     ['\n'] =3D '\n',
     ['\r'] =3D '\n',
=20
     [0x07f] =3D QEMU_KEY_BACKSPACE,
+};
+
+static const int _curseskey2qemu[CURSES_KEYS] =3D {
+    [0 ... (CURSES_KEYS - 1)] =3D -1,
=20
     [KEY_DOWN] =3D QEMU_KEY_DOWN,
     [KEY_UP] =3D QEMU_KEY_UP,
--=20
2.20.1
