Received: from eggs.gnu.org ([2001:4830:134:3::10]:48706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkSG-0000sx-AC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS5-0003Td-4P
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkS4-0003T8-QN
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D40587EA85
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:38:03 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 13:37:41 +0100
Message-Id: <20170912123744.14730-10-berrange@redhat.com>
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 09/12] ui: convert cocoa frontend to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Replace the mac_to_qkeycode_map table with automatically
generated table.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h             |   3 +
 ui/Makefile.objs               |   1 +
 ui/cocoa.m                     | 129 +----------------------------------------
 ui/input-keymap-osx-to-qcode.c | 128 ++++++++++++++++++++++++++++++++++++++++
 ui/input-keymap.c              |   1 +
 5 files changed, 135 insertions(+), 127 deletions(-)
 create mode 100644 ui/input-keymap-osx-to-qcode.c

diff --git a/include/ui/input.h b/include/ui/input.h
index 4ba7340b7b..df3eb439bf 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -71,6 +71,9 @@ void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 extern const guint qemu_input_map_linux_to_qcode_len;
 extern const guint16 qemu_input_map_linux_to_qcode[];
 
+extern const guint qemu_input_map_osx_to_qcode_len;
+extern const guint16 qemu_input_map_osx_to_qcode[];
+
 extern const guint qemu_input_map_qcode_to_adb_len;
 extern const guint16 qemu_input_map_qcode_to_adb[];
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 3cd1122ea9..9cf398e5c6 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -55,6 +55,7 @@ KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux-to-qcode.c \
+		 ui/input-keymap-osx-to-qcode.c \
 		 ui/input-keymap-qcode-to-adb.c \
 		 ui/input-keymap-qcode-to-atset1.c \
 		 ui/input-keymap-qcode-to-atset2.c \
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0518..e966605914 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -106,139 +106,14 @@ bool stretch_video;
 NSTextField *pauseLabel;
 NSArray * supportedImageFileTypes;
 
-// Mac to QKeyCode conversion
-const int mac_to_qkeycode_map[] = {
-    [kVK_ANSI_A] = Q_KEY_CODE_A,
-    [kVK_ANSI_B] = Q_KEY_CODE_B,
-    [kVK_ANSI_C] = Q_KEY_CODE_C,
-    [kVK_ANSI_D] = Q_KEY_CODE_D,
-    [kVK_ANSI_E] = Q_KEY_CODE_E,
-    [kVK_ANSI_F] = Q_KEY_CODE_F,
-    [kVK_ANSI_G] = Q_KEY_CODE_G,
-    [kVK_ANSI_H] = Q_KEY_CODE_H,
-    [kVK_ANSI_I] = Q_KEY_CODE_I,
-    [kVK_ANSI_J] = Q_KEY_CODE_J,
-    [kVK_ANSI_K] = Q_KEY_CODE_K,
-    [kVK_ANSI_L] = Q_KEY_CODE_L,
-    [kVK_ANSI_M] = Q_KEY_CODE_M,
-    [kVK_ANSI_N] = Q_KEY_CODE_N,
-    [kVK_ANSI_O] = Q_KEY_CODE_O,
-    [kVK_ANSI_P] = Q_KEY_CODE_P,
-    [kVK_ANSI_Q] = Q_KEY_CODE_Q,
-    [kVK_ANSI_R] = Q_KEY_CODE_R,
-    [kVK_ANSI_S] = Q_KEY_CODE_S,
-    [kVK_ANSI_T] = Q_KEY_CODE_T,
-    [kVK_ANSI_U] = Q_KEY_CODE_U,
-    [kVK_ANSI_V] = Q_KEY_CODE_V,
-    [kVK_ANSI_W] = Q_KEY_CODE_W,
-    [kVK_ANSI_X] = Q_KEY_CODE_X,
-    [kVK_ANSI_Y] = Q_KEY_CODE_Y,
-    [kVK_ANSI_Z] = Q_KEY_CODE_Z,
-
-    [kVK_ANSI_0] = Q_KEY_CODE_0,
-    [kVK_ANSI_1] = Q_KEY_CODE_1,
-    [kVK_ANSI_2] = Q_KEY_CODE_2,
-    [kVK_ANSI_3] = Q_KEY_CODE_3,
-    [kVK_ANSI_4] = Q_KEY_CODE_4,
-    [kVK_ANSI_5] = Q_KEY_CODE_5,
-    [kVK_ANSI_6] = Q_KEY_CODE_6,
-    [kVK_ANSI_7] = Q_KEY_CODE_7,
-    [kVK_ANSI_8] = Q_KEY_CODE_8,
-    [kVK_ANSI_9] = Q_KEY_CODE_9,
-
-    [kVK_ANSI_Grave] = Q_KEY_CODE_GRAVE_ACCENT,
-    [kVK_ANSI_Minus] = Q_KEY_CODE_MINUS,
-    [kVK_ANSI_Equal] = Q_KEY_CODE_EQUAL,
-    [kVK_Delete] = Q_KEY_CODE_BACKSPACE,
-    [kVK_CapsLock] = Q_KEY_CODE_CAPS_LOCK,
-    [kVK_Tab] = Q_KEY_CODE_TAB,
-    [kVK_Return] = Q_KEY_CODE_RET,
-    [kVK_ANSI_LeftBracket] = Q_KEY_CODE_BRACKET_LEFT,
-    [kVK_ANSI_RightBracket] = Q_KEY_CODE_BRACKET_RIGHT,
-    [kVK_ANSI_Backslash] = Q_KEY_CODE_BACKSLASH,
-    [kVK_ANSI_Semicolon] = Q_KEY_CODE_SEMICOLON,
-    [kVK_ANSI_Quote] = Q_KEY_CODE_APOSTROPHE,
-    [kVK_ANSI_Comma] = Q_KEY_CODE_COMMA,
-    [kVK_ANSI_Period] = Q_KEY_CODE_DOT,
-    [kVK_ANSI_Slash] = Q_KEY_CODE_SLASH,
-    [kVK_Shift] = Q_KEY_CODE_SHIFT,
-    [kVK_RightShift] = Q_KEY_CODE_SHIFT_R,
-    [kVK_Control] = Q_KEY_CODE_CTRL,
-    [kVK_RightControl] = Q_KEY_CODE_CTRL_R,
-    [kVK_Option] = Q_KEY_CODE_ALT,
-    [kVK_RightOption] = Q_KEY_CODE_ALT_R,
-    [kVK_Command] = Q_KEY_CODE_META_L,
-    [0x36] = Q_KEY_CODE_META_R, /* There is no kVK_RightCommand */
-    [kVK_Space] = Q_KEY_CODE_SPC,
-
-    [kVK_ANSI_Keypad0] = Q_KEY_CODE_KP_0,
-    [kVK_ANSI_Keypad1] = Q_KEY_CODE_KP_1,
-    [kVK_ANSI_Keypad2] = Q_KEY_CODE_KP_2,
-    [kVK_ANSI_Keypad3] = Q_KEY_CODE_KP_3,
-    [kVK_ANSI_Keypad4] = Q_KEY_CODE_KP_4,
-    [kVK_ANSI_Keypad5] = Q_KEY_CODE_KP_5,
-    [kVK_ANSI_Keypad6] = Q_KEY_CODE_KP_6,
-    [kVK_ANSI_Keypad7] = Q_KEY_CODE_KP_7,
-    [kVK_ANSI_Keypad8] = Q_KEY_CODE_KP_8,
-    [kVK_ANSI_Keypad9] = Q_KEY_CODE_KP_9,
-    [kVK_ANSI_KeypadDecimal] = Q_KEY_CODE_KP_DECIMAL,
-    [kVK_ANSI_KeypadEnter] = Q_KEY_CODE_KP_ENTER,
-    [kVK_ANSI_KeypadPlus] = Q_KEY_CODE_KP_ADD,
-    [kVK_ANSI_KeypadMinus] = Q_KEY_CODE_KP_SUBTRACT,
-    [kVK_ANSI_KeypadMultiply] = Q_KEY_CODE_KP_MULTIPLY,
-    [kVK_ANSI_KeypadDivide] = Q_KEY_CODE_KP_DIVIDE,
-    [kVK_ANSI_KeypadEquals] = Q_KEY_CODE_KP_EQUALS,
-    [kVK_ANSI_KeypadClear] = Q_KEY_CODE_NUM_LOCK,
-
-    [kVK_UpArrow] = Q_KEY_CODE_UP,
-    [kVK_DownArrow] = Q_KEY_CODE_DOWN,
-    [kVK_LeftArrow] = Q_KEY_CODE_LEFT,
-    [kVK_RightArrow] = Q_KEY_CODE_RIGHT,
-
-    [kVK_Help] = Q_KEY_CODE_INSERT,
-    [kVK_Home] = Q_KEY_CODE_HOME,
-    [kVK_PageUp] = Q_KEY_CODE_PGUP,
-    [kVK_PageDown] = Q_KEY_CODE_PGDN,
-    [kVK_End] = Q_KEY_CODE_END,
-    [kVK_ForwardDelete] = Q_KEY_CODE_DELETE,
-
-    [kVK_Escape] = Q_KEY_CODE_ESC,
-
-    /* The Power key can't be used directly because the operating system uses
-     * it. This key can be emulated by using it in place of another key such as
-     * F1. Don't forget to disable the real key binding.
-     */
-    /* [kVK_F1] = Q_KEY_CODE_POWER, */
-
-    [kVK_F1] = Q_KEY_CODE_F1,
-    [kVK_F2] = Q_KEY_CODE_F2,
-    [kVK_F3] = Q_KEY_CODE_F3,
-    [kVK_F4] = Q_KEY_CODE_F4,
-    [kVK_F5] = Q_KEY_CODE_F5,
-    [kVK_F6] = Q_KEY_CODE_F6,
-    [kVK_F7] = Q_KEY_CODE_F7,
-    [kVK_F8] = Q_KEY_CODE_F8,
-    [kVK_F9] = Q_KEY_CODE_F9,
-    [kVK_F10] = Q_KEY_CODE_F10,
-    [kVK_F11] = Q_KEY_CODE_F11,
-    [kVK_F12] = Q_KEY_CODE_F12,
-    [kVK_F13] = Q_KEY_CODE_PRINT,
-    [kVK_F14] = Q_KEY_CODE_SCROLL_LOCK,
-    [kVK_F15] = Q_KEY_CODE_PAUSE,
-
-    /*
-     * The eject and volume keys can't be used here because they are handled at
-     * a lower level than what an Application can see.
-     */
-};
 
 static int cocoa_keycode_to_qemu(int keycode)
 {
-    if (ARRAY_SIZE(mac_to_qkeycode_map) <= keycode) {
+    if (keycode >= qemu_input_map_osx_to_qcode_len) {
         fprintf(stderr, "(cocoa) warning unknown keycode 0x%x\n", keycode);
         return 0;
     }
-    return mac_to_qkeycode_map[keycode];
+    return qemu_input_map_osx_to_qcode[keycode];
 }
 
 /* Displays an alert dialog box with the specified message */
diff --git a/ui/input-keymap-osx-to-qcode.c b/ui/input-keymap-osx-to-qcode.c
new file mode 100644
index 0000000000..450d22fa6d
--- /dev/null
+++ b/ui/input-keymap-osx-to-qcode.c
@@ -0,0 +1,128 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_osx_to_qcode code-map keymaps.csv osx qcode
+*/
+const guint16 qemu_input_map_osx_to_qcode[256] = {
+  [0x0] = Q_KEY_CODE_A, /* osx:0 (ANSI_A) -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x1] = Q_KEY_CODE_S, /* osx:1 (ANSI_S) -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x2] = Q_KEY_CODE_D, /* osx:2 (ANSI_D) -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x3] = Q_KEY_CODE_F, /* osx:3 (ANSI_F) -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x4] = Q_KEY_CODE_H, /* osx:4 (ANSI_H) -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x5] = Q_KEY_CODE_G, /* osx:5 (ANSI_G) -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x6] = Q_KEY_CODE_Z, /* osx:6 (ANSI_Z) -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x7] = Q_KEY_CODE_X, /* osx:7 (ANSI_X) -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x8] = Q_KEY_CODE_C, /* osx:8 (ANSI_C) -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x9] = Q_KEY_CODE_V, /* osx:9 (ANSI_V) -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0xa] = Q_KEY_CODE_UNMAPPED, /* osx:10 (ISO_Section) -> linux:170 (KEY_ISO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb] = Q_KEY_CODE_B, /* osx:11 (ANSI_B) -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0xc] = Q_KEY_CODE_Q, /* osx:12 (ANSI_Q) -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0xd] = Q_KEY_CODE_W, /* osx:13 (ANSI_W) -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0xe] = Q_KEY_CODE_E, /* osx:14 (ANSI_E) -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0xf] = Q_KEY_CODE_R, /* osx:15 (ANSI_R) -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x10] = Q_KEY_CODE_Y, /* osx:16 (ANSI_Y) -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x11] = Q_KEY_CODE_T, /* osx:17 (ANSI_T) -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x12] = Q_KEY_CODE_1, /* osx:18 (ANSI_1) -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x13] = Q_KEY_CODE_2, /* osx:19 (ANSI_2) -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x14] = Q_KEY_CODE_3, /* osx:20 (ANSI_3) -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x15] = Q_KEY_CODE_4, /* osx:21 (ANSI_4) -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x16] = Q_KEY_CODE_6, /* osx:22 (ANSI_6) -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x17] = Q_KEY_CODE_5, /* osx:23 (ANSI_5) -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x18] = Q_KEY_CODE_EQUAL, /* osx:24 (ANSI_Equal) -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0x19] = Q_KEY_CODE_9, /* osx:25 (ANSI_9) -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x1a] = Q_KEY_CODE_7, /* osx:26 (ANSI_7) -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x1b] = Q_KEY_CODE_MINUS, /* osx:27 (ANSI_Minus) -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0x1c] = Q_KEY_CODE_8, /* osx:28 (ANSI_8) -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x1d] = Q_KEY_CODE_0, /* osx:29 (ANSI_0) -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x1e] = Q_KEY_CODE_BRACKET_RIGHT, /* osx:30 (ANSI_RightBracket) -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x1f] = Q_KEY_CODE_O, /* osx:31 (ANSI_O) -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x20] = Q_KEY_CODE_U, /* osx:32 (ANSI_U) -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x21] = Q_KEY_CODE_BRACKET_LEFT, /* osx:33 (ANSI_LeftBracket) -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x22] = Q_KEY_CODE_I, /* osx:34 (ANSI_I) -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x23] = Q_KEY_CODE_P, /* osx:35 (ANSI_P) -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x24] = Q_KEY_CODE_RET, /* osx:36 (Return) -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x25] = Q_KEY_CODE_L, /* osx:37 (ANSI_L) -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x26] = Q_KEY_CODE_J, /* osx:38 (ANSI_J) -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x27] = Q_KEY_CODE_APOSTROPHE, /* osx:39 (ANSI_Quote) -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x28] = Q_KEY_CODE_K, /* osx:40 (ANSI_K) -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x29] = Q_KEY_CODE_SEMICOLON, /* osx:41 (ANSI_Semicolon) -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x2a] = Q_KEY_CODE_BACKSLASH, /* osx:42 (ANSI_Backslash) -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x2b] = Q_KEY_CODE_COMMA, /* osx:43 (ANSI_Comma) -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x2c] = Q_KEY_CODE_SLASH, /* osx:44 (ANSI_Slash) -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x2d] = Q_KEY_CODE_N, /* osx:45 (ANSI_N) -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x2e] = Q_KEY_CODE_M, /* osx:46 (ANSI_M) -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x2f] = Q_KEY_CODE_DOT, /* osx:47 (ANSI_Period) -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x30] = Q_KEY_CODE_TAB, /* osx:48 (Tab) -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x31] = Q_KEY_CODE_SPC, /* osx:49 (Space) -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x32] = Q_KEY_CODE_GRAVE_ACCENT, /* osx:50 (ANSI_Grave) -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x33] = Q_KEY_CODE_BACKSPACE, /* osx:51 (Delete) -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0x35] = Q_KEY_CODE_ESC, /* osx:53 (Escape) -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0x36] = Q_KEY_CODE_META_R, /* osx:54 (RightCommand) -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0x37] = Q_KEY_CODE_META_L, /* osx:55 (Command) -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0x38] = Q_KEY_CODE_SHIFT, /* osx:56 (Shift) -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x39] = Q_KEY_CODE_CAPS_LOCK, /* osx:57 (CapsLock) -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x3a] = Q_KEY_CODE_ALT, /* osx:58 (Option) -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x3b] = Q_KEY_CODE_CTRL, /* osx:59 (Control) -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x3c] = Q_KEY_CODE_SHIFT_R, /* osx:60 (RightShift) -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0x3d] = Q_KEY_CODE_ALT_R, /* osx:61 (RightOption) -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0x3e] = Q_KEY_CODE_CTRL_R, /* osx:62 (RightControl) -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0x3f] = Q_KEY_CODE_UNMAPPED, /* osx:63 (Function) -> linux:464 (KEY_FN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x40] = Q_KEY_CODE_UNMAPPED, /* osx:64 (F17) -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x41] = Q_KEY_CODE_KP_DECIMAL, /* osx:65 (ANSI_KeypadDecimal) -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x43] = Q_KEY_CODE_KP_MULTIPLY, /* osx:67 (ANSI_KeypadMultiply) -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x45] = Q_KEY_CODE_KP_ADD, /* osx:69 (ANSI_KeypadPlus) -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x47] = Q_KEY_CODE_NUM_LOCK, /* osx:71 (ANSI_KeypadClear) -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x48] = Q_KEY_CODE_VOLUMEUP, /* osx:72 (VolumeUp) -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0x49] = Q_KEY_CODE_VOLUMEDOWN, /* osx:73 (VolumeDown) -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0x4a] = Q_KEY_CODE_AUDIOMUTE, /* osx:74 (Mute) -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0x4b] = Q_KEY_CODE_KP_DIVIDE, /* osx:75 (ANSI_KeypadDivide) -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0x4c] = Q_KEY_CODE_KP_ENTER, /* osx:76 (ANSI_KeypadEnter) -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0x4e] = Q_KEY_CODE_KP_SUBTRACT, /* osx:78 (ANSI_KeypadMinus) -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x4f] = Q_KEY_CODE_UNMAPPED, /* osx:79 (F18) -> linux:188 (KEY_F18) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x50] = Q_KEY_CODE_UNMAPPED, /* osx:80 (F19) -> linux:189 (KEY_F19) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x51] = Q_KEY_CODE_KP_EQUALS, /* osx:81 (ANSI_KeypadEquals) -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x52] = Q_KEY_CODE_KP_0, /* osx:82 (ANSI_Keypad0) -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x53] = Q_KEY_CODE_KP_1, /* osx:83 (ANSI_Keypad1) -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x54] = Q_KEY_CODE_KP_2, /* osx:84 (ANSI_Keypad2) -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x55] = Q_KEY_CODE_KP_3, /* osx:85 (ANSI_Keypad3) -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x56] = Q_KEY_CODE_KP_4, /* osx:86 (ANSI_Keypad4) -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x57] = Q_KEY_CODE_KP_5, /* osx:87 (ANSI_Keypad5) -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x58] = Q_KEY_CODE_KP_6, /* osx:88 (ANSI_Keypad6) -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x59] = Q_KEY_CODE_KP_7, /* osx:89 (ANSI_Keypad7) -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x5a] = Q_KEY_CODE_UNMAPPED, /* osx:90 (F20) -> linux:190 (KEY_F20) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5b] = Q_KEY_CODE_KP_8, /* osx:91 (ANSI_Keypad8) -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x5c] = Q_KEY_CODE_KP_9, /* osx:92 (ANSI_Keypad9) -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x5d] = Q_KEY_CODE_YEN, /* osx:93 (JIS_Yen) -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0x5f] = Q_KEY_CODE_UNMAPPED, /* osx:95 (JIS_KeypadComma) -> linux:95 (KEY_KPJPCOMMA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x60] = Q_KEY_CODE_F5, /* osx:96 (F5) -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x61] = Q_KEY_CODE_F6, /* osx:97 (F6) -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x62] = Q_KEY_CODE_F7, /* osx:98 (F7) -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x63] = Q_KEY_CODE_F3, /* osx:99 (F3) -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x64] = Q_KEY_CODE_F8, /* osx:100 (F8) -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x65] = Q_KEY_CODE_F9, /* osx:101 (F9) -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x67] = Q_KEY_CODE_F11, /* osx:103 (F11) -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x68] = Q_KEY_CODE_UNMAPPED, /* osx:104 (JIS_Kana) -> linux:90 (KEY_KATAKANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x69] = Q_KEY_CODE_UNMAPPED, /* osx:105 (F13) -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6a] = Q_KEY_CODE_UNMAPPED, /* osx:106 (F16) -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6b] = Q_KEY_CODE_UNMAPPED, /* osx:107 (F14) -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6d] = Q_KEY_CODE_F10, /* osx:109 (F10) -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x6e] = Q_KEY_CODE_COMPOSE, /* osx:110 (unnamed) -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0x6f] = Q_KEY_CODE_F12, /* osx:111 (F12) -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x71] = Q_KEY_CODE_UNMAPPED, /* osx:113 (F15) -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x72] = Q_KEY_CODE_HELP, /* osx:114 (Help) -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0x73] = Q_KEY_CODE_HOME, /* osx:115 (Home) -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0x74] = Q_KEY_CODE_PGUP, /* osx:116 (PageUp) -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0x75] = Q_KEY_CODE_DELETE, /* osx:117 (ForwardDelete) -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0x76] = Q_KEY_CODE_F4, /* osx:118 (F4) -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x77] = Q_KEY_CODE_END, /* osx:119 (End) -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0x78] = Q_KEY_CODE_F2, /* osx:120 (F2) -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x79] = Q_KEY_CODE_PGDN, /* osx:121 (PageDown) -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0x7a] = Q_KEY_CODE_F1, /* osx:122 (F1) -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x7b] = Q_KEY_CODE_LEFT, /* osx:123 (LeftArrow) -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0x7c] = Q_KEY_CODE_RIGHT, /* osx:124 (RightArrow) -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0x7d] = Q_KEY_CODE_DOWN, /* osx:125 (DownArrow) -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0x7e] = Q_KEY_CODE_UP, /* osx:126 (UpArrow) -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0xff] = Q_KEY_CODE_UNMAPPED, /* osx:255 (unnamed) -> linux:0 (KEY_RESERVED) -> qcode:Q_KEY_CODE_UNMAPPED (unmapped) */
+};
+const guint qemu_input_map_osx_to_qcode_len = sizeof(qemu_input_map_osx_to_qcode)/sizeof(qemu_input_map_osx_to_qcode[0]);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 1b53cb4d0a..de11205dca 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -6,6 +6,7 @@
 #include "standard-headers/linux/input.h"
 
 #include "ui/input-keymap-linux-to-qcode.c"
+#include "ui/input-keymap-osx-to-qcode.c"
 #include "ui/input-keymap-qcode-to-adb.c"
 #include "ui/input-keymap-qcode-to-atset1.c"
 #include "ui/input-keymap-qcode-to-atset2.c"
-- 
2.13.5
