Received: from eggs.gnu.org ([209.51.188.92]:58097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugc-0007g1-OT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugW-00030K-Ha
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1ugW-0002zd-8S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 16:11:36 +0100
Message-Id: <20190307151141.6483-3-kraxel@redhat.com>
In-Reply-To: <20190307151141.6483-1-kraxel@redhat.com>
References: <20190307151141.6483-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] curses: support wide input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

This makes use of wide curses functions instead of 8bit functions. This
allows to type e.g. accented letters.

Unfortunately, key codes are then returned with values that could be
confused with wide characters by ncurses, so we need to add a maybe_keycode
variable to know whether the returned value is a key code or a character
(curses with wide support), or possibly both (curses without wide support).

The translation tables thus also need to be separated into key code
translation and character translation.  The curses2foo helper makes it easier
to use them.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20190304210532.7840-1-samuel.thibault@ens-lyon.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/curses_keys.h | 113 +++++++++++++++++++++++++++--------------------
 ui/curses.c      |  76 +++++++++++++++++++++++++------
 2 files changed, 127 insertions(+), 62 deletions(-)

diff --git a/ui/curses_keys.h b/ui/curses_keys.h
index e9195a167192..71e04acdc756 100644
--- a/ui/curses_keys.h
+++ b/ui/curses_keys.h
@@ -49,22 +49,28 @@
 /* curses won't detect a Control + Alt + 1, so use Alt + 1 */
 #define QEMU_KEY_CONSOLE0   (2 | ALT)   /* (curses2keycode['1'] | ALT) */
 
+#define CURSES_CHARS        0x100       /* Support latin1 only */
 #define CURSES_KEYS         KEY_MAX     /* KEY_MAX defined in <curses.h> */
 
-static const int curses2keysym[CURSES_KEYS] = {
-    [0 ... (CURSES_KEYS - 1)] = -1,
+static const int _curses2keysym[CURSES_CHARS] = {
+    [0 ... (CURSES_CHARS - 1)] = -1,
 
     [0x7f] = KEY_BACKSPACE,
     ['\r'] = KEY_ENTER,
     ['\n'] = KEY_ENTER,
     [27] = 27,
+};
+
+static const int _curseskey2keysym[CURSES_KEYS] = {
+    [0 ... (CURSES_KEYS - 1)] = -1,
+
     [KEY_BTAB] = '\t' | KEYSYM_SHIFT,
     [KEY_SPREVIOUS] = KEY_PPAGE | KEYSYM_SHIFT,
     [KEY_SNEXT] = KEY_NPAGE | KEYSYM_SHIFT,
 };
 
-static const int curses2keycode[CURSES_KEYS] = {
-    [0 ... (CURSES_KEYS - 1)] = -1,
+static const int _curses2keycode[CURSES_CHARS] = {
+    [0 ... (CURSES_CHARS - 1)] = -1,
 
     [0x01b] = 1, /* Escape */
     ['1'] = 2,
@@ -80,7 +86,6 @@ static const int curses2keycode[CURSES_KEYS] = {
     ['-'] = 12,
     ['='] = 13,
     [0x07f] = 14, /* Backspace */
-    [KEY_BACKSPACE] = 14, /* Backspace */
 
     ['\t'] = 15, /* Tab */
     ['q'] = 16,
@@ -97,7 +102,6 @@ static const int curses2keycode[CURSES_KEYS] = {
     [']'] = 27,
     ['\n'] = 28, /* Return */
     ['\r'] = 28, /* Return */
-    [KEY_ENTER] = 28, /* Return */
 
     ['a'] = 30,
     ['s'] = 31,
@@ -126,33 +130,6 @@ static const int curses2keycode[CURSES_KEYS] = {
 
     [' '] = 57,
 
-    [KEY_F(1)] = 59, /* Function Key 1 */
-    [KEY_F(2)] = 60, /* Function Key 2 */
-    [KEY_F(3)] = 61, /* Function Key 3 */
-    [KEY_F(4)] = 62, /* Function Key 4 */
-    [KEY_F(5)] = 63, /* Function Key 5 */
-    [KEY_F(6)] = 64, /* Function Key 6 */
-    [KEY_F(7)] = 65, /* Function Key 7 */
-    [KEY_F(8)] = 66, /* Function Key 8 */
-    [KEY_F(9)] = 67, /* Function Key 9 */
-    [KEY_F(10)] = 68, /* Function Key 10 */
-    [KEY_F(11)] = 87, /* Function Key 11 */
-    [KEY_F(12)] = 88, /* Function Key 12 */
-
-    [KEY_HOME] = 71 | GREY, /* Home */
-    [KEY_UP] = 72 | GREY, /* Up Arrow */
-    [KEY_PPAGE] = 73 | GREY, /* Page Up */
-    [KEY_LEFT] = 75 | GREY, /* Left Arrow */
-    [KEY_RIGHT] = 77 | GREY, /* Right Arrow */
-    [KEY_END] = 79 | GREY, /* End */
-    [KEY_DOWN] = 80 | GREY, /* Down Arrow */
-    [KEY_NPAGE] = 81 | GREY, /* Page Down */
-    [KEY_IC] = 82 | GREY, /* Insert */
-    [KEY_DC] = 83 | GREY, /* Delete */
-
-    [KEY_SPREVIOUS] = 73 | GREY | SHIFT, /* Shift + Page Up */
-    [KEY_SNEXT] = 81 | GREY | SHIFT, /* Shift + Page Down */
-
     ['!'] = 2 | SHIFT,
     ['@'] = 3 | SHIFT,
     ['#'] = 4 | SHIFT,
@@ -166,7 +143,6 @@ static const int curses2keycode[CURSES_KEYS] = {
     ['_'] = 12 | SHIFT,
     ['+'] = 13 | SHIFT,
 
-    [KEY_BTAB] = 15 | SHIFT, /* Shift + Tab */
     ['Q'] = 16 | SHIFT,
     ['W'] = 17 | SHIFT,
     ['E'] = 18 | SHIFT,
@@ -205,19 +181,6 @@ static const int curses2keycode[CURSES_KEYS] = {
     ['>'] = 52 | SHIFT,
     ['?'] = 53 | SHIFT,
 
-    [KEY_F(13)] = 59 | SHIFT, /* Shift + Function Key 1 */
-    [KEY_F(14)] = 60 | SHIFT, /* Shift + Function Key 2 */
-    [KEY_F(15)] = 61 | SHIFT, /* Shift + Function Key 3 */
-    [KEY_F(16)] = 62 | SHIFT, /* Shift + Function Key 4 */
-    [KEY_F(17)] = 63 | SHIFT, /* Shift + Function Key 5 */
-    [KEY_F(18)] = 64 | SHIFT, /* Shift + Function Key 6 */
-    [KEY_F(19)] = 65 | SHIFT, /* Shift + Function Key 7 */
-    [KEY_F(20)] = 66 | SHIFT, /* Shift + Function Key 8 */
-    [KEY_F(21)] = 67 | SHIFT, /* Shift + Function Key 9 */
-    [KEY_F(22)] = 68 | SHIFT, /* Shift + Function Key 10 */
-    [KEY_F(23)] = 69 | SHIFT, /* Shift + Function Key 11 */
-    [KEY_F(24)] = 70 | SHIFT, /* Shift + Function Key 12 */
-
     ['Q' - '@'] = 16 | CNTRL, /* Control + q */
     ['W' - '@'] = 17 | CNTRL, /* Control + w */
     ['E' - '@'] = 18 | CNTRL, /* Control + e */
@@ -249,13 +212,67 @@ static const int curses2keycode[CURSES_KEYS] = {
 
 };
 
-static const int curses2qemu[CURSES_KEYS] = {
+static const int _curseskey2keycode[CURSES_KEYS] = {
     [0 ... (CURSES_KEYS - 1)] = -1,
 
+    [KEY_BACKSPACE] = 14, /* Backspace */
+
+    [KEY_ENTER] = 28, /* Return */
+
+    [KEY_F(1)] = 59, /* Function Key 1 */
+    [KEY_F(2)] = 60, /* Function Key 2 */
+    [KEY_F(3)] = 61, /* Function Key 3 */
+    [KEY_F(4)] = 62, /* Function Key 4 */
+    [KEY_F(5)] = 63, /* Function Key 5 */
+    [KEY_F(6)] = 64, /* Function Key 6 */
+    [KEY_F(7)] = 65, /* Function Key 7 */
+    [KEY_F(8)] = 66, /* Function Key 8 */
+    [KEY_F(9)] = 67, /* Function Key 9 */
+    [KEY_F(10)] = 68, /* Function Key 10 */
+    [KEY_F(11)] = 87, /* Function Key 11 */
+    [KEY_F(12)] = 88, /* Function Key 12 */
+
+    [KEY_HOME] = 71 | GREY, /* Home */
+    [KEY_UP] = 72 | GREY, /* Up Arrow */
+    [KEY_PPAGE] = 73 | GREY, /* Page Up */
+    [KEY_LEFT] = 75 | GREY, /* Left Arrow */
+    [KEY_RIGHT] = 77 | GREY, /* Right Arrow */
+    [KEY_END] = 79 | GREY, /* End */
+    [KEY_DOWN] = 80 | GREY, /* Down Arrow */
+    [KEY_NPAGE] = 81 | GREY, /* Page Down */
+    [KEY_IC] = 82 | GREY, /* Insert */
+    [KEY_DC] = 83 | GREY, /* Delete */
+
+    [KEY_SPREVIOUS] = 73 | GREY | SHIFT, /* Shift + Page Up */
+    [KEY_SNEXT] = 81 | GREY | SHIFT, /* Shift + Page Down */
+
+    [KEY_BTAB] = 15 | SHIFT, /* Shift + Tab */
+
+    [KEY_F(13)] = 59 | SHIFT, /* Shift + Function Key 1 */
+    [KEY_F(14)] = 60 | SHIFT, /* Shift + Function Key 2 */
+    [KEY_F(15)] = 61 | SHIFT, /* Shift + Function Key 3 */
+    [KEY_F(16)] = 62 | SHIFT, /* Shift + Function Key 4 */
+    [KEY_F(17)] = 63 | SHIFT, /* Shift + Function Key 5 */
+    [KEY_F(18)] = 64 | SHIFT, /* Shift + Function Key 6 */
+    [KEY_F(19)] = 65 | SHIFT, /* Shift + Function Key 7 */
+    [KEY_F(20)] = 66 | SHIFT, /* Shift + Function Key 8 */
+    [KEY_F(21)] = 67 | SHIFT, /* Shift + Function Key 9 */
+    [KEY_F(22)] = 68 | SHIFT, /* Shift + Function Key 10 */
+    [KEY_F(23)] = 69 | SHIFT, /* Shift + Function Key 11 */
+    [KEY_F(24)] = 70 | SHIFT, /* Shift + Function Key 12 */
+};
+
+static const int _curses2qemu[CURSES_CHARS] = {
+    [0 ... (CURSES_CHARS - 1)] = -1,
+
     ['\n'] = '\n',
     ['\r'] = '\n',
 
     [0x07f] = QEMU_KEY_BACKSPACE,
+};
+
+static const int _curseskey2qemu[CURSES_KEYS] = {
+    [0 ... (CURSES_KEYS - 1)] = -1,
 
     [KEY_DOWN] = QEMU_KEY_DOWN,
     [KEY_UP] = QEMU_KEY_UP,
diff --git a/ui/curses.c b/ui/curses.c
index 870273de51a9..37954ce1b046 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -42,6 +42,12 @@
 #define FONT_HEIGHT 16
 #define FONT_WIDTH 8
 
+enum maybe_keycode {
+    CURSES_KEYCODE,
+    CURSES_CHAR,
+    CURSES_CHAR_OR_KEYCODE,
+};
+
 static DisplayChangeListener *dcl;
 static console_ch_t screen[160 * 100];
 static WINDOW *screenpad = NULL;
@@ -194,9 +200,54 @@ static void curses_cursor_position(DisplayChangeListener *dcl,
 
 static kbd_layout_t *kbd_layout = NULL;
 
+static wint_t console_getch(enum maybe_keycode *maybe_keycode)
+{
+    wint_t ret;
+    switch (get_wch(&ret)) {
+    case KEY_CODE_YES:
+        *maybe_keycode = CURSES_KEYCODE;
+        break;
+    case OK:
+        *maybe_keycode = CURSES_CHAR;
+        break;
+    case ERR:
+        ret = -1;
+        break;
+    }
+    return ret;
+}
+
+static int curses2foo(const int _curses2foo[], const int _curseskey2foo[],
+                      int chr, enum maybe_keycode maybe_keycode)
+{
+    int ret = -1;
+    if (maybe_keycode == CURSES_CHAR) {
+        if (chr < CURSES_CHARS) {
+            ret = _curses2foo[chr];
+        }
+    } else {
+        if (chr < CURSES_KEYS) {
+            ret = _curseskey2foo[chr];
+        }
+        if (ret == -1 && maybe_keycode == CURSES_CHAR_OR_KEYCODE &&
+            chr < CURSES_CHARS) {
+            ret = _curses2foo[chr];
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
 
     curses_winch_check();
 
@@ -212,14 +263,14 @@ static void curses_refresh(DisplayChangeListener *dcl)
 
     while (1) {
         /* while there are any pending key strokes to process */
-        chr = getch();
+        chr = console_getch(&maybe_keycode);
 
-        if (chr == ERR)
+        if (chr == -1)
             break;
 
 #ifdef KEY_RESIZE
         /* this shouldn't occur when we use a custom SIGWINCH handler */
-        if (chr == KEY_RESIZE) {
+        if (maybe_keycode != CURSES_CHAR && chr == KEY_RESIZE) {
             clear();
             refresh();
             curses_calc_pad();
@@ -228,17 +279,19 @@ static void curses_refresh(DisplayChangeListener *dcl)
         }
 #endif
 
-        keycode = curses2keycode[chr];
+        keycode = curses2keycode(chr, maybe_keycode);
         keycode_alt = 0;
 
         /* alt or esc key */
         if (keycode == 1) {
-            int nextchr = getch();
+            enum maybe_keycode next_maybe_keycode;
+            int nextchr = console_getch(&next_maybe_keycode);
 
-            if (nextchr != ERR) {
+            if (nextchr != -1) {
                 chr = nextchr;
+                maybe_keycode = next_maybe_keycode;
                 keycode_alt = ALT;
-                keycode = curses2keycode[chr];
+                keycode = curses2keycode(chr, maybe_keycode);
 
                 if (keycode != -1) {
                     keycode |= ALT;
@@ -258,9 +311,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
         }
 
         if (kbd_layout) {
-            keysym = -1;
-            if (chr < CURSES_KEYS)
-                keysym = curses2keysym[chr];
+            keysym = curses2keysym(chr, maybe_keycode);
 
             if (keysym == -1) {
                 if (chr < ' ') {
@@ -326,10 +377,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
                 qemu_input_event_send_key_delay(0);
             }
         } else {
-            keysym = -1;
-            if (chr < CURSES_KEYS) {
-                keysym = curses2qemu[chr];
-            }
+            keysym = curses2qemu(chr, maybe_keycode);
             if (keysym == -1)
                 keysym = chr;
 
-- 
2.18.1
