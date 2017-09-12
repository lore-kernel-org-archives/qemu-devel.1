Received: from eggs.gnu.org ([2001:4830:134:3::10]:48661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkSA-0000od-Su
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkRx-0003QK-LZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkRx-0003Q3-61
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:37:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F3C8883AC
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:37:56 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 13:37:34 +0100
Message-Id: <20170912123744.14730-3-berrange@redhat.com>
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 02/12] ui: convert common input code to
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

Replace the number_to_qcode, qcode_to_number and linux_to_qcode
tables with automatically generated tables.

Missing entries in linux_to_qcode now fixed:

  KEY_LINEFEED -> Q_KEY_CODE_LF
  KEY_KPEQUAL -> Q_KEY_CODE_KP_EQUALS
  KEY_COMPOSE -> Q_KEY_CODE_COMPOSE
  KEY_AGAIN -> Q_KEY_CODE_AGAIN
  KEY_PROPS -> Q_KEY_CODE_PROPS
  KEY_UNDO -> Q_KEY_CODE_UNDO
  KEY_FRONT -> Q_KEY_CODE_FRONT
  KEY_COPY -> Q_KEY_CODE_COPY
  KEY_OPEN -> Q_KEY_CODE_OPEN
  KEY_PASTE -> Q_KEY_CODE_PASTE
  KEY_CUT -> Q_KEY_CODE_CUT
  KEY_HELP -> Q_KEY_CODE_HELP
  KEY_MEDIA -> Q_KEY_CODE_MEDIASELECT

In additionsome fixes:

 - KEY_PLAYPAUSE now maps to Q_KEY_CODE_AUDIOPLAY, instead of
   KEY_PLAYCD. KEY_PLAYPAUSE is defined across almost all scancodes
   sets, while KEY_PLAYCD only appears in AT set1, so the former is
   a more useful mapping.

Missing entries in qcode_to_number now fixed:

  Q_KEY_CODE_AGAIN -> 0x85
  Q_KEY_CODE_PROPS -> 0x86
  Q_KEY_CODE_UNDO -> 0x87
  Q_KEY_CODE_FRONT -> 0x8c
  Q_KEY_CODE_COPY -> 0xf8
  Q_KEY_CODE_OPEN -> 0x64
  Q_KEY_CODE_PASTE -> 0x65
  Q_KEY_CODE_CUT -> 0xbc
  Q_KEY_CODE_LF -> 0x5b
  Q_KEY_CODE_HELP -> 0xf5
  Q_KEY_CODE_COMPOSE -> 0xdd
  Q_KEY_CODE_KP_EQUALS -> 0x59
  Q_KEY_CODE_MEDIASELECT -> 0xed

In addition some fixes:

 - Q_KEY_CODE_MENU was incorrectly mapped to the compose
   scancode (0xdd) and is now mapped to 0x9e
 - Q_KEY_CODE_FIND was mapped to 0xe065 (Search) instead
   of to 0xe041 (Find)
 - Q_KEY_CODE_HIRAGANA was mapped to 0x70 (Katakanahiragana)
   instead of of 0x77 (Hirigana)
 - Q_KEY_CODE_PRINT was mapped to 0xb7 which is not a defined
   scan code in AT set 1, it is now mapped to 0x54 (sysrq)

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h               |  11 +-
 ui/Makefile.objs                 |   3 +
 ui/input-keymap-linux-to-qcode.c | 463 +++++++++++++++++++++++++++++++++++++++
 ui/input-keymap-qcode-to-qnum.c  | 154 +++++++++++++
 ui/input-keymap-qnum-to-qcode.c  | 245 +++++++++++++++++++++
 ui/input-keymap.c                | 326 ++-------------------------
 6 files changed, 890 insertions(+), 312 deletions(-)
 create mode 100644 ui/input-keymap-linux-to-qcode.c
 create mode 100644 ui/input-keymap-qcode-to-qnum.c
 create mode 100644 ui/input-keymap-qnum-to-qcode.c

diff --git a/include/ui/input.h b/include/ui/input.h
index c488585def..479cc46cfc 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -43,7 +43,7 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down);
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down);
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down);
 void qemu_input_event_send_key_delay(uint32_t delay_ms);
-int qemu_input_key_number_to_qcode(uint8_t nr);
+int qemu_input_key_number_to_qcode(unsigned int nr);
 int qemu_input_key_value_to_number(const KeyValue *value);
 int qemu_input_key_value_to_qcode(const KeyValue *value);
 int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
@@ -69,4 +69,13 @@ void qemu_input_check_mode_change(void);
 void qemu_add_mouse_mode_change_notifier(Notifier *notify);
 void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 
+extern const guint qemu_input_map_linux_to_qcode_len;
+extern const guint16 qemu_input_map_linux_to_qcode[];
+
+extern const guint qemu_input_map_qcode_to_qnum_len;
+extern const guint16 qemu_input_map_qcode_to_qnum[];
+
+extern const guint qemu_input_map_qnum_to_qcode_len;
+extern const guint16 qemu_input_map_qnum_to_qcode[];
+
 #endif /* INPUT_H */
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 5fcb3010b3..29e44c1baf 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -54,6 +54,9 @@ KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
+		 ui/input-keymap-linux-to-qcode.c \
+		 ui/input-keymap-qcode-to-qnum.c \
+		 ui/input-keymap-qnum-to-qcode.c \
 		 $(NULL)
 
 # Generated input-keymap-XXX.c files are kept in GIT, so
diff --git a/ui/input-keymap-linux-to-qcode.c b/ui/input-keymap-linux-to-qcode.c
new file mode 100644
index 0000000000..c026ed106f
--- /dev/null
+++ b/ui/input-keymap-linux-to-qcode.c
@@ -0,0 +1,463 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:01
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_linux_to_qcode code-map keymaps.csv linux qcode
+*/
+const guint16 qemu_input_map_linux_to_qcode[525] = {
+  [0x0] = Q_KEY_CODE_UNMAPPED, /* linux:0 (KEY_RESERVED) -> linux:0 (KEY_RESERVED) -> qcode:Q_KEY_CODE_UNMAPPED (unmapped) */
+  [0x1] = Q_KEY_CODE_ESC, /* linux:1 (KEY_ESC) -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0x2] = Q_KEY_CODE_1, /* linux:2 (KEY_1) -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x3] = Q_KEY_CODE_2, /* linux:3 (KEY_2) -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x4] = Q_KEY_CODE_3, /* linux:4 (KEY_3) -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x5] = Q_KEY_CODE_4, /* linux:5 (KEY_4) -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x6] = Q_KEY_CODE_5, /* linux:6 (KEY_5) -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x7] = Q_KEY_CODE_6, /* linux:7 (KEY_6) -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x8] = Q_KEY_CODE_7, /* linux:8 (KEY_7) -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x9] = Q_KEY_CODE_8, /* linux:9 (KEY_8) -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0xa] = Q_KEY_CODE_9, /* linux:10 (KEY_9) -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0xb] = Q_KEY_CODE_0, /* linux:11 (KEY_0) -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0xc] = Q_KEY_CODE_MINUS, /* linux:12 (KEY_MINUS) -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0xd] = Q_KEY_CODE_EQUAL, /* linux:13 (KEY_EQUAL) -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0xe] = Q_KEY_CODE_BACKSPACE, /* linux:14 (KEY_BACKSPACE) -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0xf] = Q_KEY_CODE_TAB, /* linux:15 (KEY_TAB) -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x10] = Q_KEY_CODE_Q, /* linux:16 (KEY_Q) -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x11] = Q_KEY_CODE_W, /* linux:17 (KEY_W) -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x12] = Q_KEY_CODE_E, /* linux:18 (KEY_E) -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x13] = Q_KEY_CODE_R, /* linux:19 (KEY_R) -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x14] = Q_KEY_CODE_T, /* linux:20 (KEY_T) -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x15] = Q_KEY_CODE_Y, /* linux:21 (KEY_Y) -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x16] = Q_KEY_CODE_U, /* linux:22 (KEY_U) -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x17] = Q_KEY_CODE_I, /* linux:23 (KEY_I) -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x18] = Q_KEY_CODE_O, /* linux:24 (KEY_O) -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x19] = Q_KEY_CODE_P, /* linux:25 (KEY_P) -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x1a] = Q_KEY_CODE_BRACKET_LEFT, /* linux:26 (KEY_LEFTBRACE) -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x1b] = Q_KEY_CODE_BRACKET_RIGHT, /* linux:27 (KEY_RIGHTBRACE) -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x1c] = Q_KEY_CODE_RET, /* linux:28 (KEY_ENTER) -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x1d] = Q_KEY_CODE_CTRL, /* linux:29 (KEY_LEFTCTRL) -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x1e] = Q_KEY_CODE_A, /* linux:30 (KEY_A) -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x1f] = Q_KEY_CODE_S, /* linux:31 (KEY_S) -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x20] = Q_KEY_CODE_D, /* linux:32 (KEY_D) -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x21] = Q_KEY_CODE_F, /* linux:33 (KEY_F) -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x22] = Q_KEY_CODE_G, /* linux:34 (KEY_G) -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x23] = Q_KEY_CODE_H, /* linux:35 (KEY_H) -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x24] = Q_KEY_CODE_J, /* linux:36 (KEY_J) -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x25] = Q_KEY_CODE_K, /* linux:37 (KEY_K) -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x26] = Q_KEY_CODE_L, /* linux:38 (KEY_L) -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x27] = Q_KEY_CODE_SEMICOLON, /* linux:39 (KEY_SEMICOLON) -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x28] = Q_KEY_CODE_APOSTROPHE, /* linux:40 (KEY_APOSTROPHE) -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x29] = Q_KEY_CODE_GRAVE_ACCENT, /* linux:41 (KEY_GRAVE) -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x2a] = Q_KEY_CODE_SHIFT, /* linux:42 (KEY_LEFTSHIFT) -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x2b] = Q_KEY_CODE_BACKSLASH, /* linux:43 (KEY_BACKSLASH) -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x2c] = Q_KEY_CODE_Z, /* linux:44 (KEY_Z) -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x2d] = Q_KEY_CODE_X, /* linux:45 (KEY_X) -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x2e] = Q_KEY_CODE_C, /* linux:46 (KEY_C) -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x2f] = Q_KEY_CODE_V, /* linux:47 (KEY_V) -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x30] = Q_KEY_CODE_B, /* linux:48 (KEY_B) -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x31] = Q_KEY_CODE_N, /* linux:49 (KEY_N) -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x32] = Q_KEY_CODE_M, /* linux:50 (KEY_M) -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x33] = Q_KEY_CODE_COMMA, /* linux:51 (KEY_COMMA) -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x34] = Q_KEY_CODE_DOT, /* linux:52 (KEY_DOT) -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x35] = Q_KEY_CODE_SLASH, /* linux:53 (KEY_SLASH) -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x36] = Q_KEY_CODE_SHIFT_R, /* linux:54 (KEY_RIGHTSHIFT) -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0x37] = Q_KEY_CODE_KP_MULTIPLY, /* linux:55 (KEY_KPASTERISK) -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x38] = Q_KEY_CODE_ALT, /* linux:56 (KEY_LEFTALT) -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x39] = Q_KEY_CODE_SPC, /* linux:57 (KEY_SPACE) -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x3a] = Q_KEY_CODE_CAPS_LOCK, /* linux:58 (KEY_CAPSLOCK) -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x3b] = Q_KEY_CODE_F1, /* linux:59 (KEY_F1) -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x3c] = Q_KEY_CODE_F2, /* linux:60 (KEY_F2) -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x3d] = Q_KEY_CODE_F3, /* linux:61 (KEY_F3) -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x3e] = Q_KEY_CODE_F4, /* linux:62 (KEY_F4) -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x3f] = Q_KEY_CODE_F5, /* linux:63 (KEY_F5) -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x40] = Q_KEY_CODE_F6, /* linux:64 (KEY_F6) -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x41] = Q_KEY_CODE_F7, /* linux:65 (KEY_F7) -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x42] = Q_KEY_CODE_F8, /* linux:66 (KEY_F8) -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x43] = Q_KEY_CODE_F9, /* linux:67 (KEY_F9) -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x44] = Q_KEY_CODE_F10, /* linux:68 (KEY_F10) -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x45] = Q_KEY_CODE_NUM_LOCK, /* linux:69 (KEY_NUMLOCK) -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x46] = Q_KEY_CODE_SCROLL_LOCK, /* linux:70 (KEY_SCROLLLOCK) -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0x47] = Q_KEY_CODE_KP_7, /* linux:71 (KEY_KP7) -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x48] = Q_KEY_CODE_KP_8, /* linux:72 (KEY_KP8) -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x49] = Q_KEY_CODE_KP_9, /* linux:73 (KEY_KP9) -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x4a] = Q_KEY_CODE_KP_SUBTRACT, /* linux:74 (KEY_KPMINUS) -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x4b] = Q_KEY_CODE_KP_4, /* linux:75 (KEY_KP4) -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x4c] = Q_KEY_CODE_KP_5, /* linux:76 (KEY_KP5) -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x4d] = Q_KEY_CODE_KP_6, /* linux:77 (KEY_KP6) -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x4e] = Q_KEY_CODE_KP_ADD, /* linux:78 (KEY_KPPLUS) -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x4f] = Q_KEY_CODE_KP_1, /* linux:79 (KEY_KP1) -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x50] = Q_KEY_CODE_KP_2, /* linux:80 (KEY_KP2) -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x51] = Q_KEY_CODE_KP_3, /* linux:81 (KEY_KP3) -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x52] = Q_KEY_CODE_KP_0, /* linux:82 (KEY_KP0) -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x53] = Q_KEY_CODE_KP_DECIMAL, /* linux:83 (KEY_KPDOT) -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x54] = Q_KEY_CODE_UNMAPPED, /* linux:84 (unnamed) -> linux:84 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x55] = Q_KEY_CODE_UNMAPPED, /* linux:85 (KEY_ZENKAKUHANKAKU) -> linux:85 (KEY_ZENKAKUHANKAKU) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x56] = Q_KEY_CODE_LESS, /* linux:86 (KEY_102ND) -> linux:86 (KEY_102ND) -> qcode:Q_KEY_CODE_LESS (less) */
+  [0x57] = Q_KEY_CODE_F11, /* linux:87 (KEY_F11) -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x58] = Q_KEY_CODE_F12, /* linux:88 (KEY_F12) -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x59] = Q_KEY_CODE_RO, /* linux:89 (KEY_RO) -> linux:89 (KEY_RO) -> qcode:Q_KEY_CODE_RO (ro) */
+  [0x5a] = Q_KEY_CODE_UNMAPPED, /* linux:90 (KEY_KATAKANA) -> linux:90 (KEY_KATAKANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5b] = Q_KEY_CODE_HIRAGANA, /* linux:91 (KEY_HIRAGANA) -> linux:91 (KEY_HIRAGANA) -> qcode:Q_KEY_CODE_HIRAGANA (hiragana) */
+  [0x5c] = Q_KEY_CODE_HENKAN, /* linux:92 (KEY_HENKAN) -> linux:92 (KEY_HENKAN) -> qcode:Q_KEY_CODE_HENKAN (henkan) */
+  [0x5d] = Q_KEY_CODE_UNMAPPED, /* linux:93 (KEY_KATAKANAHIRAGANA) -> linux:93 (KEY_KATAKANAHIRAGANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5e] = Q_KEY_CODE_UNMAPPED, /* linux:94 (KEY_MUHENKAN) -> linux:94 (KEY_MUHENKAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5f] = Q_KEY_CODE_UNMAPPED, /* linux:95 (KEY_KPJPCOMMA) -> linux:95 (KEY_KPJPCOMMA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x60] = Q_KEY_CODE_KP_ENTER, /* linux:96 (KEY_KPENTER) -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0x61] = Q_KEY_CODE_CTRL_R, /* linux:97 (KEY_RIGHTCTRL) -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0x62] = Q_KEY_CODE_KP_DIVIDE, /* linux:98 (KEY_KPSLASH) -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0x63] = Q_KEY_CODE_SYSRQ, /* linux:99 (KEY_SYSRQ) -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0x64] = Q_KEY_CODE_ALT_R, /* linux:100 (KEY_RIGHTALT) -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0x65] = Q_KEY_CODE_LF, /* linux:101 (KEY_LINEFEED) -> linux:101 (KEY_LINEFEED) -> qcode:Q_KEY_CODE_LF (lf) */
+  [0x66] = Q_KEY_CODE_HOME, /* linux:102 (KEY_HOME) -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0x67] = Q_KEY_CODE_UP, /* linux:103 (KEY_UP) -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0x68] = Q_KEY_CODE_PGUP, /* linux:104 (KEY_PAGEUP) -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0x69] = Q_KEY_CODE_LEFT, /* linux:105 (KEY_LEFT) -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0x6a] = Q_KEY_CODE_RIGHT, /* linux:106 (KEY_RIGHT) -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0x6b] = Q_KEY_CODE_END, /* linux:107 (KEY_END) -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0x6c] = Q_KEY_CODE_DOWN, /* linux:108 (KEY_DOWN) -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0x6d] = Q_KEY_CODE_PGDN, /* linux:109 (KEY_PAGEDOWN) -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0x6e] = Q_KEY_CODE_INSERT, /* linux:110 (KEY_INSERT) -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0x6f] = Q_KEY_CODE_DELETE, /* linux:111 (KEY_DELETE) -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0x70] = Q_KEY_CODE_UNMAPPED, /* linux:112 (KEY_MACRO) -> linux:112 (KEY_MACRO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x71] = Q_KEY_CODE_AUDIOMUTE, /* linux:113 (KEY_MUTE) -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0x72] = Q_KEY_CODE_VOLUMEDOWN, /* linux:114 (KEY_VOLUMEDOWN) -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0x73] = Q_KEY_CODE_VOLUMEUP, /* linux:115 (KEY_VOLUMEUP) -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0x74] = Q_KEY_CODE_POWER, /* linux:116 (KEY_POWER) -> linux:116 (KEY_POWER) -> qcode:Q_KEY_CODE_POWER (power) */
+  [0x75] = Q_KEY_CODE_KP_EQUALS, /* linux:117 (KEY_KPEQUAL) -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x76] = Q_KEY_CODE_UNMAPPED, /* linux:118 (KEY_KPPLUSMINUS) -> linux:118 (KEY_KPPLUSMINUS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x77] = Q_KEY_CODE_PAUSE, /* linux:119 (KEY_PAUSE) -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0x78] = Q_KEY_CODE_UNMAPPED, /* linux:120 (KEY_SCALE) -> linux:120 (KEY_SCALE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x79] = Q_KEY_CODE_KP_COMMA, /* linux:121 (KEY_KPCOMMA) -> linux:121 (KEY_KPCOMMA) -> qcode:Q_KEY_CODE_KP_COMMA (kp_comma) */
+  [0x7a] = Q_KEY_CODE_UNMAPPED, /* linux:122 (KEY_HANGEUL) -> linux:122 (KEY_HANGEUL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7b] = Q_KEY_CODE_UNMAPPED, /* linux:123 (KEY_HANJA) -> linux:123 (KEY_HANJA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7c] = Q_KEY_CODE_YEN, /* linux:124 (KEY_YEN) -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0x7d] = Q_KEY_CODE_META_L, /* linux:125 (KEY_LEFTMETA) -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0x7e] = Q_KEY_CODE_META_R, /* linux:126 (KEY_RIGHTMETA) -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0x7f] = Q_KEY_CODE_COMPOSE, /* linux:127 (KEY_COMPOSE) -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0x80] = Q_KEY_CODE_STOP, /* linux:128 (KEY_STOP) -> linux:128 (KEY_STOP) -> qcode:Q_KEY_CODE_STOP (stop) */
+  [0x81] = Q_KEY_CODE_AGAIN, /* linux:129 (KEY_AGAIN) -> linux:129 (KEY_AGAIN) -> qcode:Q_KEY_CODE_AGAIN (again) */
+  [0x82] = Q_KEY_CODE_PROPS, /* linux:130 (KEY_PROPS) -> linux:130 (KEY_PROPS) -> qcode:Q_KEY_CODE_PROPS (props) */
+  [0x83] = Q_KEY_CODE_UNDO, /* linux:131 (KEY_UNDO) -> linux:131 (KEY_UNDO) -> qcode:Q_KEY_CODE_UNDO (undo) */
+  [0x84] = Q_KEY_CODE_FRONT, /* linux:132 (KEY_FRONT) -> linux:132 (KEY_FRONT) -> qcode:Q_KEY_CODE_FRONT (front) */
+  [0x85] = Q_KEY_CODE_COPY, /* linux:133 (KEY_COPY) -> linux:133 (KEY_COPY) -> qcode:Q_KEY_CODE_COPY (copy) */
+  [0x86] = Q_KEY_CODE_OPEN, /* linux:134 (KEY_OPEN) -> linux:134 (KEY_OPEN) -> qcode:Q_KEY_CODE_OPEN (open) */
+  [0x87] = Q_KEY_CODE_PASTE, /* linux:135 (KEY_PASTE) -> linux:135 (KEY_PASTE) -> qcode:Q_KEY_CODE_PASTE (paste) */
+  [0x88] = Q_KEY_CODE_FIND, /* linux:136 (KEY_FIND) -> linux:136 (KEY_FIND) -> qcode:Q_KEY_CODE_FIND (find) */
+  [0x89] = Q_KEY_CODE_CUT, /* linux:137 (KEY_CUT) -> linux:137 (KEY_CUT) -> qcode:Q_KEY_CODE_CUT (cut) */
+  [0x8a] = Q_KEY_CODE_HELP, /* linux:138 (KEY_HELP) -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0x8b] = Q_KEY_CODE_MENU, /* linux:139 (KEY_MENU) -> linux:139 (KEY_MENU) -> qcode:Q_KEY_CODE_MENU (menu) */
+  [0x8c] = Q_KEY_CODE_CALCULATOR, /* linux:140 (KEY_CALC) -> linux:140 (KEY_CALC) -> qcode:Q_KEY_CODE_CALCULATOR (calculator) */
+  [0x8d] = Q_KEY_CODE_UNMAPPED, /* linux:141 (KEY_SETUP) -> linux:141 (KEY_SETUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x8e] = Q_KEY_CODE_SLEEP, /* linux:142 (KEY_SLEEP) -> linux:142 (KEY_SLEEP) -> qcode:Q_KEY_CODE_SLEEP (sleep) */
+  [0x8f] = Q_KEY_CODE_WAKE, /* linux:143 (KEY_WAKEUP) -> linux:143 (KEY_WAKEUP) -> qcode:Q_KEY_CODE_WAKE (wake) */
+  [0x90] = Q_KEY_CODE_UNMAPPED, /* linux:144 (KEY_FILE) -> linux:144 (KEY_FILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x91] = Q_KEY_CODE_UNMAPPED, /* linux:145 (KEY_SENDFILE) -> linux:145 (KEY_SENDFILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x92] = Q_KEY_CODE_UNMAPPED, /* linux:146 (KEY_DELETEFILE) -> linux:146 (KEY_DELETEFILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x93] = Q_KEY_CODE_UNMAPPED, /* linux:147 (KEY_XFER) -> linux:147 (KEY_XFER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x94] = Q_KEY_CODE_UNMAPPED, /* linux:148 (KEY_PROG1) -> linux:148 (KEY_PROG1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x95] = Q_KEY_CODE_UNMAPPED, /* linux:149 (KEY_PROG2) -> linux:149 (KEY_PROG2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x96] = Q_KEY_CODE_UNMAPPED, /* linux:150 (KEY_WWW) -> linux:150 (KEY_WWW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x97] = Q_KEY_CODE_UNMAPPED, /* linux:151 (KEY_MSDOS) -> linux:151 (KEY_MSDOS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x98] = Q_KEY_CODE_UNMAPPED, /* linux:152 (KEY_SCREENLOCK) -> linux:152 (KEY_SCREENLOCK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x99] = Q_KEY_CODE_UNMAPPED, /* linux:153 (KEY_DIRECTION) -> linux:153 (KEY_DIRECTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9a] = Q_KEY_CODE_UNMAPPED, /* linux:154 (KEY_CYCLEWINDOWS) -> linux:154 (KEY_CYCLEWINDOWS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9b] = Q_KEY_CODE_MAIL, /* linux:155 (KEY_MAIL) -> linux:155 (KEY_MAIL) -> qcode:Q_KEY_CODE_MAIL (mail) */
+  [0x9c] = Q_KEY_CODE_AC_BOOKMARKS, /* linux:156 (KEY_BOOKMARKS) -> linux:156 (KEY_BOOKMARKS) -> qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) */
+  [0x9d] = Q_KEY_CODE_COMPUTER, /* linux:157 (KEY_COMPUTER) -> linux:157 (KEY_COMPUTER) -> qcode:Q_KEY_CODE_COMPUTER (computer) */
+  [0x9e] = Q_KEY_CODE_AC_BACK, /* linux:158 (KEY_BACK) -> linux:158 (KEY_BACK) -> qcode:Q_KEY_CODE_AC_BACK (ac_back) */
+  [0x9f] = Q_KEY_CODE_AC_FORWARD, /* linux:159 (KEY_FORWARD) -> linux:159 (KEY_FORWARD) -> qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) */
+  [0xa0] = Q_KEY_CODE_UNMAPPED, /* linux:160 (KEY_CLOSECD) -> linux:160 (KEY_CLOSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa1] = Q_KEY_CODE_UNMAPPED, /* linux:161 (KEY_EJECTCD) -> linux:161 (KEY_EJECTCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa2] = Q_KEY_CODE_UNMAPPED, /* linux:162 (KEY_EJECTCLOSECD) -> linux:162 (KEY_EJECTCLOSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa3] = Q_KEY_CODE_AUDIONEXT, /* linux:163 (KEY_NEXTSONG) -> linux:163 (KEY_NEXTSONG) -> qcode:Q_KEY_CODE_AUDIONEXT (audionext) */
+  [0xa4] = Q_KEY_CODE_AUDIOPLAY, /* linux:164 (KEY_PLAYPAUSE) -> linux:164 (KEY_PLAYPAUSE) -> qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) */
+  [0xa5] = Q_KEY_CODE_AUDIOPREV, /* linux:165 (KEY_PREVIOUSSONG) -> linux:165 (KEY_PREVIOUSSONG) -> qcode:Q_KEY_CODE_AUDIOPREV (audioprev) */
+  [0xa6] = Q_KEY_CODE_AUDIOSTOP, /* linux:166 (KEY_STOPCD) -> linux:166 (KEY_STOPCD) -> qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) */
+  [0xa7] = Q_KEY_CODE_UNMAPPED, /* linux:167 (KEY_RECORD) -> linux:167 (KEY_RECORD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa8] = Q_KEY_CODE_UNMAPPED, /* linux:168 (KEY_REWIND) -> linux:168 (KEY_REWIND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa9] = Q_KEY_CODE_UNMAPPED, /* linux:169 (KEY_PHONE) -> linux:169 (KEY_PHONE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xaa] = Q_KEY_CODE_UNMAPPED, /* linux:170 (KEY_ISO) -> linux:170 (KEY_ISO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xab] = Q_KEY_CODE_UNMAPPED, /* linux:171 (KEY_CONFIG) -> linux:171 (KEY_CONFIG) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xac] = Q_KEY_CODE_AC_HOME, /* linux:172 (KEY_HOMEPAGE) -> linux:172 (KEY_HOMEPAGE) -> qcode:Q_KEY_CODE_AC_HOME (ac_home) */
+  [0xad] = Q_KEY_CODE_AC_REFRESH, /* linux:173 (KEY_REFRESH) -> linux:173 (KEY_REFRESH) -> qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) */
+  [0xae] = Q_KEY_CODE_UNMAPPED, /* linux:174 (KEY_EXIT) -> linux:174 (KEY_EXIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xaf] = Q_KEY_CODE_UNMAPPED, /* linux:175 (KEY_MOVE) -> linux:175 (KEY_MOVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb0] = Q_KEY_CODE_UNMAPPED, /* linux:176 (KEY_EDIT) -> linux:176 (KEY_EDIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb1] = Q_KEY_CODE_UNMAPPED, /* linux:177 (KEY_SCROLLUP) -> linux:177 (KEY_SCROLLUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb2] = Q_KEY_CODE_UNMAPPED, /* linux:178 (KEY_SCROLLDOWN) -> linux:178 (KEY_SCROLLDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb3] = Q_KEY_CODE_UNMAPPED, /* linux:179 (KEY_KPLEFTPAREN) -> linux:179 (KEY_KPLEFTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb4] = Q_KEY_CODE_UNMAPPED, /* linux:180 (KEY_KPRIGHTPAREN) -> linux:180 (KEY_KPRIGHTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb5] = Q_KEY_CODE_UNMAPPED, /* linux:181 (KEY_NEW) -> linux:181 (KEY_NEW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb6] = Q_KEY_CODE_UNMAPPED, /* linux:182 (KEY_REDO) -> linux:182 (KEY_REDO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb7] = Q_KEY_CODE_UNMAPPED, /* linux:183 (KEY_F13) -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb8] = Q_KEY_CODE_UNMAPPED, /* linux:184 (KEY_F14) -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb9] = Q_KEY_CODE_UNMAPPED, /* linux:185 (KEY_F15) -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xba] = Q_KEY_CODE_UNMAPPED, /* linux:186 (KEY_F16) -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbb] = Q_KEY_CODE_UNMAPPED, /* linux:187 (KEY_F17) -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbc] = Q_KEY_CODE_UNMAPPED, /* linux:188 (KEY_F18) -> linux:188 (KEY_F18) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbd] = Q_KEY_CODE_UNMAPPED, /* linux:189 (KEY_F19) -> linux:189 (KEY_F19) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbe] = Q_KEY_CODE_UNMAPPED, /* linux:190 (KEY_F20) -> linux:190 (KEY_F20) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbf] = Q_KEY_CODE_UNMAPPED, /* linux:191 (KEY_F21) -> linux:191 (KEY_F21) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc0] = Q_KEY_CODE_UNMAPPED, /* linux:192 (KEY_F22) -> linux:192 (KEY_F22) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc1] = Q_KEY_CODE_UNMAPPED, /* linux:193 (KEY_F23) -> linux:193 (KEY_F23) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc2] = Q_KEY_CODE_UNMAPPED, /* linux:194 (KEY_F24) -> linux:194 (KEY_F24) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc3] = Q_KEY_CODE_UNMAPPED, /* linux:195 (unnamed) -> linux:195 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc4] = Q_KEY_CODE_UNMAPPED, /* linux:196 (unnamed) -> linux:196 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc5] = Q_KEY_CODE_UNMAPPED, /* linux:197 (unnamed) -> linux:197 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc6] = Q_KEY_CODE_UNMAPPED, /* linux:198 (unnamed) -> linux:198 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc7] = Q_KEY_CODE_UNMAPPED, /* linux:199 (unnamed) -> linux:199 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc8] = Q_KEY_CODE_UNMAPPED, /* linux:200 (KEY_PLAYCD) -> linux:200 (KEY_PLAYCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc9] = Q_KEY_CODE_UNMAPPED, /* linux:201 (KEY_PAUSECD) -> linux:201 (KEY_PAUSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xca] = Q_KEY_CODE_UNMAPPED, /* linux:202 (KEY_PROG3) -> linux:202 (KEY_PROG3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcb] = Q_KEY_CODE_UNMAPPED, /* linux:203 (KEY_PROG4) -> linux:203 (KEY_PROG4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcc] = Q_KEY_CODE_UNMAPPED, /* linux:204 (KEY_DASHBOARD) -> linux:204 (KEY_DASHBOARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcd] = Q_KEY_CODE_UNMAPPED, /* linux:205 (KEY_SUSPEND) -> linux:205 (KEY_SUSPEND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xce] = Q_KEY_CODE_UNMAPPED, /* linux:206 (KEY_CLOSE) -> linux:206 (KEY_CLOSE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcf] = Q_KEY_CODE_UNMAPPED, /* linux:207 (KEY_PLAY) -> linux:207 (KEY_PLAY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd0] = Q_KEY_CODE_UNMAPPED, /* linux:208 (KEY_FASTFORWARD) -> linux:208 (KEY_FASTFORWARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd1] = Q_KEY_CODE_UNMAPPED, /* linux:209 (KEY_BASSBOOST) -> linux:209 (KEY_BASSBOOST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd2] = Q_KEY_CODE_UNMAPPED, /* linux:210 (KEY_PRINT) -> linux:210 (KEY_PRINT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd3] = Q_KEY_CODE_UNMAPPED, /* linux:211 (KEY_HP) -> linux:211 (KEY_HP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd4] = Q_KEY_CODE_UNMAPPED, /* linux:212 (KEY_CAMERA) -> linux:212 (KEY_CAMERA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd5] = Q_KEY_CODE_UNMAPPED, /* linux:213 (KEY_SOUND) -> linux:213 (KEY_SOUND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd6] = Q_KEY_CODE_UNMAPPED, /* linux:214 (KEY_QUESTION) -> linux:214 (KEY_QUESTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd7] = Q_KEY_CODE_UNMAPPED, /* linux:215 (KEY_EMAIL) -> linux:215 (KEY_EMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd8] = Q_KEY_CODE_UNMAPPED, /* linux:216 (KEY_CHAT) -> linux:216 (KEY_CHAT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd9] = Q_KEY_CODE_UNMAPPED, /* linux:217 (KEY_SEARCH) -> linux:217 (KEY_SEARCH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xda] = Q_KEY_CODE_UNMAPPED, /* linux:218 (KEY_CONNECT) -> linux:218 (KEY_CONNECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdb] = Q_KEY_CODE_UNMAPPED, /* linux:219 (KEY_FINANCE) -> linux:219 (KEY_FINANCE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdc] = Q_KEY_CODE_UNMAPPED, /* linux:220 (KEY_SPORT) -> linux:220 (KEY_SPORT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdd] = Q_KEY_CODE_UNMAPPED, /* linux:221 (KEY_SHOP) -> linux:221 (KEY_SHOP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xde] = Q_KEY_CODE_UNMAPPED, /* linux:222 (KEY_ALTERASE) -> linux:222 (KEY_ALTERASE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdf] = Q_KEY_CODE_UNMAPPED, /* linux:223 (KEY_CANCEL) -> linux:223 (KEY_CANCEL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe0] = Q_KEY_CODE_UNMAPPED, /* linux:224 (KEY_BRIGHTNESSDOWN) -> linux:224 (KEY_BRIGHTNESSDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe1] = Q_KEY_CODE_UNMAPPED, /* linux:225 (KEY_BRIGHTNESSUP) -> linux:225 (KEY_BRIGHTNESSUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe2] = Q_KEY_CODE_MEDIASELECT, /* linux:226 (KEY_MEDIA) -> linux:226 (KEY_MEDIA) -> qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) */
+  [0xe3] = Q_KEY_CODE_UNMAPPED, /* linux:227 (KEY_SWITCHVIDEOMODE) -> linux:227 (KEY_SWITCHVIDEOMODE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe4] = Q_KEY_CODE_UNMAPPED, /* linux:228 (KEY_KBDILLUMTOGGLE) -> linux:228 (KEY_KBDILLUMTOGGLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe5] = Q_KEY_CODE_UNMAPPED, /* linux:229 (KEY_KBDILLUMDOWN) -> linux:229 (KEY_KBDILLUMDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe6] = Q_KEY_CODE_UNMAPPED, /* linux:230 (KEY_KBDILLUMUP) -> linux:230 (KEY_KBDILLUMUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe7] = Q_KEY_CODE_UNMAPPED, /* linux:231 (KEY_SEND) -> linux:231 (KEY_SEND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe8] = Q_KEY_CODE_UNMAPPED, /* linux:232 (KEY_REPLY) -> linux:232 (KEY_REPLY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe9] = Q_KEY_CODE_UNMAPPED, /* linux:233 (KEY_FORWARDMAIL) -> linux:233 (KEY_FORWARDMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xea] = Q_KEY_CODE_UNMAPPED, /* linux:234 (KEY_SAVE) -> linux:234 (KEY_SAVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xeb] = Q_KEY_CODE_UNMAPPED, /* linux:235 (KEY_DOCUMENTS) -> linux:235 (KEY_DOCUMENTS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xec] = Q_KEY_CODE_UNMAPPED, /* linux:236 (KEY_BATTERY) -> linux:236 (KEY_BATTERY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xed] = Q_KEY_CODE_UNMAPPED, /* linux:237 (KEY_BLUETOOTH) -> linux:237 (KEY_BLUETOOTH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xee] = Q_KEY_CODE_UNMAPPED, /* linux:238 (KEY_WLAN) -> linux:238 (KEY_WLAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xef] = Q_KEY_CODE_UNMAPPED, /* linux:239 (KEY_UWB) -> linux:239 (KEY_UWB) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf0] = Q_KEY_CODE_UNMAPPED, /* linux:240 (KEY_UNKNOWN) -> linux:240 (KEY_UNKNOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf1] = Q_KEY_CODE_UNMAPPED, /* linux:241 (KEY_VIDEO_NEXT) -> linux:241 (KEY_VIDEO_NEXT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf2] = Q_KEY_CODE_UNMAPPED, /* linux:242 (KEY_VIDEO_PREV) -> linux:242 (KEY_VIDEO_PREV) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf3] = Q_KEY_CODE_UNMAPPED, /* linux:243 (KEY_BRIGHTNESS_CYCLE) -> linux:243 (KEY_BRIGHTNESS_CYCLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf4] = Q_KEY_CODE_UNMAPPED, /* linux:244 (KEY_BRIGHTNESS_ZERO) -> linux:244 (KEY_BRIGHTNESS_ZERO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf5] = Q_KEY_CODE_UNMAPPED, /* linux:245 (KEY_DISPLAY_OFF) -> linux:245 (KEY_DISPLAY_OFF) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf6] = Q_KEY_CODE_UNMAPPED, /* linux:246 (KEY_WIMAX) -> linux:246 (KEY_WIMAX) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf7] = Q_KEY_CODE_UNMAPPED, /* linux:247 (unnamed) -> linux:247 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf8] = Q_KEY_CODE_UNMAPPED, /* linux:248 (unnamed) -> linux:248 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf9] = Q_KEY_CODE_UNMAPPED, /* linux:249 (unnamed) -> linux:249 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfa] = Q_KEY_CODE_UNMAPPED, /* linux:250 (unnamed) -> linux:250 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfb] = Q_KEY_CODE_UNMAPPED, /* linux:251 (unnamed) -> linux:251 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfc] = Q_KEY_CODE_UNMAPPED, /* linux:252 (unnamed) -> linux:252 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfd] = Q_KEY_CODE_UNMAPPED, /* linux:253 (unnamed) -> linux:253 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfe] = Q_KEY_CODE_UNMAPPED, /* linux:254 (unnamed) -> linux:254 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xff] = Q_KEY_CODE_UNMAPPED, /* linux:255 (unnamed) -> linux:255 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x100] = Q_KEY_CODE_UNMAPPED, /* linux:256 (BTN_0) -> linux:256 (BTN_0) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x101] = Q_KEY_CODE_UNMAPPED, /* linux:257 (BTN_1) -> linux:257 (BTN_1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x102] = Q_KEY_CODE_UNMAPPED, /* linux:258 (BTN_2) -> linux:258 (BTN_2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x103] = Q_KEY_CODE_UNMAPPED, /* linux:259 (BTN_3) -> linux:259 (BTN_3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x104] = Q_KEY_CODE_UNMAPPED, /* linux:260 (BTN_4) -> linux:260 (BTN_4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x105] = Q_KEY_CODE_UNMAPPED, /* linux:261 (BTN_5) -> linux:261 (BTN_5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x106] = Q_KEY_CODE_UNMAPPED, /* linux:262 (BTN_6) -> linux:262 (BTN_6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x107] = Q_KEY_CODE_UNMAPPED, /* linux:263 (BTN_7) -> linux:263 (BTN_7) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x108] = Q_KEY_CODE_UNMAPPED, /* linux:264 (BTN_8) -> linux:264 (BTN_8) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x109] = Q_KEY_CODE_UNMAPPED, /* linux:265 (BTN_9) -> linux:265 (BTN_9) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x110] = Q_KEY_CODE_UNMAPPED, /* linux:272 (BTN_LEFT) -> linux:272 (BTN_LEFT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x111] = Q_KEY_CODE_UNMAPPED, /* linux:273 (BTN_RIGHT) -> linux:273 (BTN_RIGHT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x112] = Q_KEY_CODE_UNMAPPED, /* linux:274 (BTN_MIDDLE) -> linux:274 (BTN_MIDDLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x113] = Q_KEY_CODE_UNMAPPED, /* linux:275 (BTN_SIDE) -> linux:275 (BTN_SIDE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x114] = Q_KEY_CODE_UNMAPPED, /* linux:276 (BTN_EXTRA) -> linux:276 (BTN_EXTRA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x115] = Q_KEY_CODE_UNMAPPED, /* linux:277 (BTN_FORWARD) -> linux:277 (BTN_FORWARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x116] = Q_KEY_CODE_UNMAPPED, /* linux:278 (BTN_BACK) -> linux:278 (BTN_BACK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x117] = Q_KEY_CODE_UNMAPPED, /* linux:279 (BTN_TASK) -> linux:279 (BTN_TASK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x120] = Q_KEY_CODE_UNMAPPED, /* linux:288 (BTN_TRIGGER) -> linux:288 (BTN_TRIGGER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x121] = Q_KEY_CODE_UNMAPPED, /* linux:289 (BTN_THUMB) -> linux:289 (BTN_THUMB) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x122] = Q_KEY_CODE_UNMAPPED, /* linux:290 (BTN_THUMB2) -> linux:290 (BTN_THUMB2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x123] = Q_KEY_CODE_UNMAPPED, /* linux:291 (BTN_TOP) -> linux:291 (BTN_TOP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x124] = Q_KEY_CODE_UNMAPPED, /* linux:292 (BTN_TOP2) -> linux:292 (BTN_TOP2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x125] = Q_KEY_CODE_UNMAPPED, /* linux:293 (BTN_PINKIE) -> linux:293 (BTN_PINKIE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x126] = Q_KEY_CODE_UNMAPPED, /* linux:294 (BTN_BASE) -> linux:294 (BTN_BASE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x127] = Q_KEY_CODE_UNMAPPED, /* linux:295 (BTN_BASE2) -> linux:295 (BTN_BASE2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x128] = Q_KEY_CODE_UNMAPPED, /* linux:296 (BTN_BASE3) -> linux:296 (BTN_BASE3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x129] = Q_KEY_CODE_UNMAPPED, /* linux:297 (BTN_BASE4) -> linux:297 (BTN_BASE4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12a] = Q_KEY_CODE_UNMAPPED, /* linux:298 (BTN_BASE5) -> linux:298 (BTN_BASE5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12b] = Q_KEY_CODE_UNMAPPED, /* linux:299 (BTN_BASE6) -> linux:299 (BTN_BASE6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12f] = Q_KEY_CODE_UNMAPPED, /* linux:303 (BTN_DEAD) -> linux:303 (BTN_DEAD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x130] = Q_KEY_CODE_UNMAPPED, /* linux:304 (BTN_A) -> linux:304 (BTN_A) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x131] = Q_KEY_CODE_UNMAPPED, /* linux:305 (BTN_B) -> linux:305 (BTN_B) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x132] = Q_KEY_CODE_UNMAPPED, /* linux:306 (BTN_C) -> linux:306 (BTN_C) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x133] = Q_KEY_CODE_UNMAPPED, /* linux:307 (BTN_X) -> linux:307 (BTN_X) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x134] = Q_KEY_CODE_UNMAPPED, /* linux:308 (BTN_Y) -> linux:308 (BTN_Y) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x135] = Q_KEY_CODE_UNMAPPED, /* linux:309 (BTN_Z) -> linux:309 (BTN_Z) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x136] = Q_KEY_CODE_UNMAPPED, /* linux:310 (BTN_TL) -> linux:310 (BTN_TL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x137] = Q_KEY_CODE_UNMAPPED, /* linux:311 (BTN_TR) -> linux:311 (BTN_TR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x138] = Q_KEY_CODE_UNMAPPED, /* linux:312 (BTN_TL2) -> linux:312 (BTN_TL2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x139] = Q_KEY_CODE_UNMAPPED, /* linux:313 (BTN_TR2) -> linux:313 (BTN_TR2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13a] = Q_KEY_CODE_UNMAPPED, /* linux:314 (BTN_SELECT) -> linux:314 (BTN_SELECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13b] = Q_KEY_CODE_UNMAPPED, /* linux:315 (BTN_START) -> linux:315 (BTN_START) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13c] = Q_KEY_CODE_UNMAPPED, /* linux:316 (BTN_MODE) -> linux:316 (BTN_MODE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13d] = Q_KEY_CODE_UNMAPPED, /* linux:317 (BTN_THUMBL) -> linux:317 (BTN_THUMBL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13e] = Q_KEY_CODE_UNMAPPED, /* linux:318 (BTN_THUMBR) -> linux:318 (BTN_THUMBR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x140] = Q_KEY_CODE_UNMAPPED, /* linux:320 (BTN_TOOL_PEN) -> linux:320 (BTN_TOOL_PEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x141] = Q_KEY_CODE_UNMAPPED, /* linux:321 (BTN_TOOL_RUBBER) -> linux:321 (BTN_TOOL_RUBBER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x142] = Q_KEY_CODE_UNMAPPED, /* linux:322 (BTN_TOOL_BRUSH) -> linux:322 (BTN_TOOL_BRUSH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x143] = Q_KEY_CODE_UNMAPPED, /* linux:323 (BTN_TOOL_PENCIL) -> linux:323 (BTN_TOOL_PENCIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x144] = Q_KEY_CODE_UNMAPPED, /* linux:324 (BTN_TOOL_AIRBRUSH) -> linux:324 (BTN_TOOL_AIRBRUSH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x145] = Q_KEY_CODE_UNMAPPED, /* linux:325 (BTN_TOOL_FINGER) -> linux:325 (BTN_TOOL_FINGER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x146] = Q_KEY_CODE_UNMAPPED, /* linux:326 (BTN_TOOL_MOUSE) -> linux:326 (BTN_TOOL_MOUSE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x147] = Q_KEY_CODE_UNMAPPED, /* linux:327 (BTN_TOOL_LENS) -> linux:327 (BTN_TOOL_LENS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14a] = Q_KEY_CODE_UNMAPPED, /* linux:330 (BTN_TOUCH) -> linux:330 (BTN_TOUCH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14b] = Q_KEY_CODE_UNMAPPED, /* linux:331 (BTN_STYLUS) -> linux:331 (BTN_STYLUS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14c] = Q_KEY_CODE_UNMAPPED, /* linux:332 (BTN_STYLUS2) -> linux:332 (BTN_STYLUS2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14d] = Q_KEY_CODE_UNMAPPED, /* linux:333 (BTN_TOOL_DOUBLETAP) -> linux:333 (BTN_TOOL_DOUBLETAP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14e] = Q_KEY_CODE_UNMAPPED, /* linux:334 (BTN_TOOL_TRIPLETAP) -> linux:334 (BTN_TOOL_TRIPLETAP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14f] = Q_KEY_CODE_UNMAPPED, /* linux:335 (BTN_TOOL_QUADTAP) -> linux:335 (BTN_TOOL_QUADTAP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x150] = Q_KEY_CODE_UNMAPPED, /* linux:336 (BTN_GEAR_DOWN) -> linux:336 (BTN_GEAR_DOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x151] = Q_KEY_CODE_UNMAPPED, /* linux:337 (BTN_GEAR_UP) -> linux:337 (BTN_GEAR_UP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x160] = Q_KEY_CODE_UNMAPPED, /* linux:352 (KEY_OK) -> linux:352 (KEY_OK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x161] = Q_KEY_CODE_UNMAPPED, /* linux:353 (KEY_SELECT) -> linux:353 (KEY_SELECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x162] = Q_KEY_CODE_UNMAPPED, /* linux:354 (KEY_GOTO) -> linux:354 (KEY_GOTO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x163] = Q_KEY_CODE_UNMAPPED, /* linux:355 (KEY_CLEAR) -> linux:355 (KEY_CLEAR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x164] = Q_KEY_CODE_UNMAPPED, /* linux:356 (KEY_POWER2) -> linux:356 (KEY_POWER2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x165] = Q_KEY_CODE_UNMAPPED, /* linux:357 (KEY_OPTION) -> linux:357 (KEY_OPTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x166] = Q_KEY_CODE_UNMAPPED, /* linux:358 (KEY_INFO) -> linux:358 (KEY_INFO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x167] = Q_KEY_CODE_UNMAPPED, /* linux:359 (KEY_TIME) -> linux:359 (KEY_TIME) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x168] = Q_KEY_CODE_UNMAPPED, /* linux:360 (KEY_VENDOR) -> linux:360 (KEY_VENDOR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x169] = Q_KEY_CODE_UNMAPPED, /* linux:361 (KEY_ARCHIVE) -> linux:361 (KEY_ARCHIVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16a] = Q_KEY_CODE_UNMAPPED, /* linux:362 (KEY_PROGRAM) -> linux:362 (KEY_PROGRAM) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16b] = Q_KEY_CODE_UNMAPPED, /* linux:363 (KEY_CHANNEL) -> linux:363 (KEY_CHANNEL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16c] = Q_KEY_CODE_UNMAPPED, /* linux:364 (KEY_FAVORITES) -> linux:364 (KEY_FAVORITES) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16d] = Q_KEY_CODE_UNMAPPED, /* linux:365 (KEY_EPG) -> linux:365 (KEY_EPG) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16e] = Q_KEY_CODE_UNMAPPED, /* linux:366 (KEY_PVR) -> linux:366 (KEY_PVR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16f] = Q_KEY_CODE_UNMAPPED, /* linux:367 (KEY_MHP) -> linux:367 (KEY_MHP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x170] = Q_KEY_CODE_UNMAPPED, /* linux:368 (KEY_LANGUAGE) -> linux:368 (KEY_LANGUAGE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x171] = Q_KEY_CODE_UNMAPPED, /* linux:369 (KEY_TITLE) -> linux:369 (KEY_TITLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x172] = Q_KEY_CODE_UNMAPPED, /* linux:370 (KEY_SUBTITLE) -> linux:370 (KEY_SUBTITLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x173] = Q_KEY_CODE_UNMAPPED, /* linux:371 (KEY_ANGLE) -> linux:371 (KEY_ANGLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x174] = Q_KEY_CODE_UNMAPPED, /* linux:372 (KEY_ZOOM) -> linux:372 (KEY_ZOOM) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x175] = Q_KEY_CODE_UNMAPPED, /* linux:373 (KEY_MODE) -> linux:373 (KEY_MODE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x176] = Q_KEY_CODE_UNMAPPED, /* linux:374 (KEY_KEYBOARD) -> linux:374 (KEY_KEYBOARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x177] = Q_KEY_CODE_UNMAPPED, /* linux:375 (KEY_SCREEN) -> linux:375 (KEY_SCREEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x178] = Q_KEY_CODE_UNMAPPED, /* linux:376 (KEY_PC) -> linux:376 (KEY_PC) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x179] = Q_KEY_CODE_UNMAPPED, /* linux:377 (KEY_TV) -> linux:377 (KEY_TV) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17a] = Q_KEY_CODE_UNMAPPED, /* linux:378 (KEY_TV2) -> linux:378 (KEY_TV2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17b] = Q_KEY_CODE_UNMAPPED, /* linux:379 (KEY_VCR) -> linux:379 (KEY_VCR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17c] = Q_KEY_CODE_UNMAPPED, /* linux:380 (KEY_VCR2) -> linux:380 (KEY_VCR2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17d] = Q_KEY_CODE_UNMAPPED, /* linux:381 (KEY_SAT) -> linux:381 (KEY_SAT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17e] = Q_KEY_CODE_UNMAPPED, /* linux:382 (KEY_SAT2) -> linux:382 (KEY_SAT2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17f] = Q_KEY_CODE_UNMAPPED, /* linux:383 (KEY_CD) -> linux:383 (KEY_CD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x180] = Q_KEY_CODE_UNMAPPED, /* linux:384 (KEY_TAPE) -> linux:384 (KEY_TAPE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x181] = Q_KEY_CODE_UNMAPPED, /* linux:385 (KEY_RADIO) -> linux:385 (KEY_RADIO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x182] = Q_KEY_CODE_UNMAPPED, /* linux:386 (KEY_TUNER) -> linux:386 (KEY_TUNER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x183] = Q_KEY_CODE_UNMAPPED, /* linux:387 (KEY_PLAYER) -> linux:387 (KEY_PLAYER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x184] = Q_KEY_CODE_UNMAPPED, /* linux:388 (KEY_TEXT) -> linux:388 (KEY_TEXT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x185] = Q_KEY_CODE_UNMAPPED, /* linux:389 (KEY_DVD) -> linux:389 (KEY_DVD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x186] = Q_KEY_CODE_UNMAPPED, /* linux:390 (KEY_AUX) -> linux:390 (KEY_AUX) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x187] = Q_KEY_CODE_UNMAPPED, /* linux:391 (KEY_MP3) -> linux:391 (KEY_MP3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x188] = Q_KEY_CODE_UNMAPPED, /* linux:392 (KEY_AUDIO) -> linux:392 (KEY_AUDIO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x189] = Q_KEY_CODE_UNMAPPED, /* linux:393 (KEY_VIDEO) -> linux:393 (KEY_VIDEO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18a] = Q_KEY_CODE_UNMAPPED, /* linux:394 (KEY_DIRECTORY) -> linux:394 (KEY_DIRECTORY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18b] = Q_KEY_CODE_UNMAPPED, /* linux:395 (KEY_LIST) -> linux:395 (KEY_LIST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18c] = Q_KEY_CODE_UNMAPPED, /* linux:396 (KEY_MEMO) -> linux:396 (KEY_MEMO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18d] = Q_KEY_CODE_UNMAPPED, /* linux:397 (KEY_CALENDAR) -> linux:397 (KEY_CALENDAR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18e] = Q_KEY_CODE_UNMAPPED, /* linux:398 (KEY_RED) -> linux:398 (KEY_RED) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18f] = Q_KEY_CODE_UNMAPPED, /* linux:399 (KEY_GREEN) -> linux:399 (KEY_GREEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x190] = Q_KEY_CODE_UNMAPPED, /* linux:400 (KEY_YELLOW) -> linux:400 (KEY_YELLOW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x191] = Q_KEY_CODE_UNMAPPED, /* linux:401 (KEY_BLUE) -> linux:401 (KEY_BLUE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x192] = Q_KEY_CODE_UNMAPPED, /* linux:402 (KEY_CHANNELUP) -> linux:402 (KEY_CHANNELUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x193] = Q_KEY_CODE_UNMAPPED, /* linux:403 (KEY_CHANNELDOWN) -> linux:403 (KEY_CHANNELDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x194] = Q_KEY_CODE_UNMAPPED, /* linux:404 (KEY_FIRST) -> linux:404 (KEY_FIRST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x195] = Q_KEY_CODE_UNMAPPED, /* linux:405 (KEY_LAST) -> linux:405 (KEY_LAST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x196] = Q_KEY_CODE_UNMAPPED, /* linux:406 (KEY_AB) -> linux:406 (KEY_AB) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x197] = Q_KEY_CODE_UNMAPPED, /* linux:407 (KEY_NEXT) -> linux:407 (KEY_NEXT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x198] = Q_KEY_CODE_UNMAPPED, /* linux:408 (KEY_RESTART) -> linux:408 (KEY_RESTART) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x199] = Q_KEY_CODE_UNMAPPED, /* linux:409 (KEY_SLOW) -> linux:409 (KEY_SLOW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19a] = Q_KEY_CODE_UNMAPPED, /* linux:410 (KEY_SHUFFLE) -> linux:410 (KEY_SHUFFLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19b] = Q_KEY_CODE_UNMAPPED, /* linux:411 (KEY_BREAK) -> linux:411 (KEY_BREAK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19c] = Q_KEY_CODE_UNMAPPED, /* linux:412 (KEY_PREVIOUS) -> linux:412 (KEY_PREVIOUS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19d] = Q_KEY_CODE_UNMAPPED, /* linux:413 (KEY_DIGITS) -> linux:413 (KEY_DIGITS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19e] = Q_KEY_CODE_UNMAPPED, /* linux:414 (KEY_TEEN) -> linux:414 (KEY_TEEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19f] = Q_KEY_CODE_UNMAPPED, /* linux:415 (KEY_TWEN) -> linux:415 (KEY_TWEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a0] = Q_KEY_CODE_UNMAPPED, /* linux:416 (KEY_VIDEOPHONE) -> linux:416 (KEY_VIDEOPHONE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a1] = Q_KEY_CODE_UNMAPPED, /* linux:417 (KEY_GAMES) -> linux:417 (KEY_GAMES) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a2] = Q_KEY_CODE_UNMAPPED, /* linux:418 (KEY_ZOOMIN) -> linux:418 (KEY_ZOOMIN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a3] = Q_KEY_CODE_UNMAPPED, /* linux:419 (KEY_ZOOMOUT) -> linux:419 (KEY_ZOOMOUT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a4] = Q_KEY_CODE_UNMAPPED, /* linux:420 (KEY_ZOOMRESET) -> linux:420 (KEY_ZOOMRESET) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a5] = Q_KEY_CODE_UNMAPPED, /* linux:421 (KEY_WORDPROCESSOR) -> linux:421 (KEY_WORDPROCESSOR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a6] = Q_KEY_CODE_UNMAPPED, /* linux:422 (KEY_EDITOR) -> linux:422 (KEY_EDITOR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a7] = Q_KEY_CODE_UNMAPPED, /* linux:423 (KEY_SPREADSHEET) -> linux:423 (KEY_SPREADSHEET) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a8] = Q_KEY_CODE_UNMAPPED, /* linux:424 (KEY_GRAPHICSEDITOR) -> linux:424 (KEY_GRAPHICSEDITOR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a9] = Q_KEY_CODE_UNMAPPED, /* linux:425 (KEY_PRESENTATION) -> linux:425 (KEY_PRESENTATION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1aa] = Q_KEY_CODE_UNMAPPED, /* linux:426 (KEY_DATABASE) -> linux:426 (KEY_DATABASE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ab] = Q_KEY_CODE_UNMAPPED, /* linux:427 (KEY_NEWS) -> linux:427 (KEY_NEWS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ac] = Q_KEY_CODE_UNMAPPED, /* linux:428 (KEY_VOICEMAIL) -> linux:428 (KEY_VOICEMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ad] = Q_KEY_CODE_UNMAPPED, /* linux:429 (KEY_ADDRESSBOOK) -> linux:429 (KEY_ADDRESSBOOK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ae] = Q_KEY_CODE_UNMAPPED, /* linux:430 (KEY_MESSENGER) -> linux:430 (KEY_MESSENGER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1af] = Q_KEY_CODE_UNMAPPED, /* linux:431 (KEY_DISPLAYTOGGLE) -> linux:431 (KEY_DISPLAYTOGGLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b0] = Q_KEY_CODE_UNMAPPED, /* linux:432 (KEY_SPELLCHECK) -> linux:432 (KEY_SPELLCHECK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b1] = Q_KEY_CODE_UNMAPPED, /* linux:433 (KEY_LOGOFF) -> linux:433 (KEY_LOGOFF) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b2] = Q_KEY_CODE_UNMAPPED, /* linux:434 (KEY_DOLLAR) -> linux:434 (KEY_DOLLAR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b3] = Q_KEY_CODE_UNMAPPED, /* linux:435 (KEY_EURO) -> linux:435 (KEY_EURO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b4] = Q_KEY_CODE_UNMAPPED, /* linux:436 (KEY_FRAMEBACK) -> linux:436 (KEY_FRAMEBACK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b5] = Q_KEY_CODE_UNMAPPED, /* linux:437 (KEY_FRAMEFORWARD) -> linux:437 (KEY_FRAMEFORWARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b6] = Q_KEY_CODE_UNMAPPED, /* linux:438 (KEY_CONTEXT_MENU) -> linux:438 (KEY_CONTEXT_MENU) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b7] = Q_KEY_CODE_UNMAPPED, /* linux:439 (KEY_MEDIA_REPEAT) -> linux:439 (KEY_MEDIA_REPEAT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1c0] = Q_KEY_CODE_UNMAPPED, /* linux:448 (KEY_DEL_EOL) -> linux:448 (KEY_DEL_EOL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1c1] = Q_KEY_CODE_UNMAPPED, /* linux:449 (KEY_DEL_EOS) -> linux:449 (KEY_DEL_EOS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1c2] = Q_KEY_CODE_UNMAPPED, /* linux:450 (KEY_INS_LINE) -> linux:450 (KEY_INS_LINE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1c3] = Q_KEY_CODE_UNMAPPED, /* linux:451 (KEY_DEL_LINE) -> linux:451 (KEY_DEL_LINE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d0] = Q_KEY_CODE_UNMAPPED, /* linux:464 (KEY_FN) -> linux:464 (KEY_FN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d1] = Q_KEY_CODE_UNMAPPED, /* linux:465 (KEY_FN_ESC) -> linux:465 (KEY_FN_ESC) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d2] = Q_KEY_CODE_UNMAPPED, /* linux:466 (KEY_FN_F1) -> linux:466 (KEY_FN_F1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d3] = Q_KEY_CODE_UNMAPPED, /* linux:467 (KEY_FN_F2) -> linux:467 (KEY_FN_F2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d4] = Q_KEY_CODE_UNMAPPED, /* linux:468 (KEY_FN_F3) -> linux:468 (KEY_FN_F3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d5] = Q_KEY_CODE_UNMAPPED, /* linux:469 (KEY_FN_F4) -> linux:469 (KEY_FN_F4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d6] = Q_KEY_CODE_UNMAPPED, /* linux:470 (KEY_FN_F5) -> linux:470 (KEY_FN_F5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d7] = Q_KEY_CODE_UNMAPPED, /* linux:471 (KEY_FN_F6) -> linux:471 (KEY_FN_F6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d8] = Q_KEY_CODE_UNMAPPED, /* linux:472 (KEY_FN_F7) -> linux:472 (KEY_FN_F7) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d9] = Q_KEY_CODE_UNMAPPED, /* linux:473 (KEY_FN_F8) -> linux:473 (KEY_FN_F8) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1da] = Q_KEY_CODE_UNMAPPED, /* linux:474 (KEY_FN_F9) -> linux:474 (KEY_FN_F9) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1db] = Q_KEY_CODE_UNMAPPED, /* linux:475 (KEY_FN_F10) -> linux:475 (KEY_FN_F10) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1dc] = Q_KEY_CODE_UNMAPPED, /* linux:476 (KEY_FN_F11) -> linux:476 (KEY_FN_F11) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1dd] = Q_KEY_CODE_UNMAPPED, /* linux:477 (KEY_FN_F12) -> linux:477 (KEY_FN_F12) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1de] = Q_KEY_CODE_UNMAPPED, /* linux:478 (KEY_FN_1) -> linux:478 (KEY_FN_1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1df] = Q_KEY_CODE_UNMAPPED, /* linux:479 (KEY_FN_2) -> linux:479 (KEY_FN_2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e0] = Q_KEY_CODE_UNMAPPED, /* linux:480 (KEY_FN_D) -> linux:480 (KEY_FN_D) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e1] = Q_KEY_CODE_UNMAPPED, /* linux:481 (KEY_FN_E) -> linux:481 (KEY_FN_E) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e2] = Q_KEY_CODE_UNMAPPED, /* linux:482 (KEY_FN_F) -> linux:482 (KEY_FN_F) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e3] = Q_KEY_CODE_UNMAPPED, /* linux:483 (KEY_FN_S) -> linux:483 (KEY_FN_S) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e4] = Q_KEY_CODE_UNMAPPED, /* linux:484 (KEY_FN_B) -> linux:484 (KEY_FN_B) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f1] = Q_KEY_CODE_UNMAPPED, /* linux:497 (KEY_BRL_DOT1) -> linux:497 (KEY_BRL_DOT1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f2] = Q_KEY_CODE_UNMAPPED, /* linux:498 (KEY_BRL_DOT2) -> linux:498 (KEY_BRL_DOT2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f3] = Q_KEY_CODE_UNMAPPED, /* linux:499 (KEY_BRL_DOT3) -> linux:499 (KEY_BRL_DOT3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f4] = Q_KEY_CODE_UNMAPPED, /* linux:500 (KEY_BRL_DOT4) -> linux:500 (KEY_BRL_DOT4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f5] = Q_KEY_CODE_UNMAPPED, /* linux:501 (KEY_BRL_DOT5) -> linux:501 (KEY_BRL_DOT5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f6] = Q_KEY_CODE_UNMAPPED, /* linux:502 (KEY_BRL_DOT6) -> linux:502 (KEY_BRL_DOT6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f7] = Q_KEY_CODE_UNMAPPED, /* linux:503 (KEY_BRL_DOT7) -> linux:503 (KEY_BRL_DOT7) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f8] = Q_KEY_CODE_UNMAPPED, /* linux:504 (KEY_BRL_DOT8) -> linux:504 (KEY_BRL_DOT8) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f9] = Q_KEY_CODE_UNMAPPED, /* linux:505 (KEY_BRL_DOT9) -> linux:505 (KEY_BRL_DOT9) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1fa] = Q_KEY_CODE_UNMAPPED, /* linux:506 (KEY_BRL_DOT10) -> linux:506 (KEY_BRL_DOT10) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x200] = Q_KEY_CODE_UNMAPPED, /* linux:512 (KEY_NUMERIC_0) -> linux:512 (KEY_NUMERIC_0) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x201] = Q_KEY_CODE_UNMAPPED, /* linux:513 (KEY_NUMERIC_1) -> linux:513 (KEY_NUMERIC_1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x202] = Q_KEY_CODE_UNMAPPED, /* linux:514 (KEY_NUMERIC_2) -> linux:514 (KEY_NUMERIC_2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x203] = Q_KEY_CODE_UNMAPPED, /* linux:515 (KEY_NUMERIC_3) -> linux:515 (KEY_NUMERIC_3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x204] = Q_KEY_CODE_UNMAPPED, /* linux:516 (KEY_NUMERIC_4) -> linux:516 (KEY_NUMERIC_4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x205] = Q_KEY_CODE_UNMAPPED, /* linux:517 (KEY_NUMERIC_5) -> linux:517 (KEY_NUMERIC_5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x206] = Q_KEY_CODE_UNMAPPED, /* linux:518 (KEY_NUMERIC_6) -> linux:518 (KEY_NUMERIC_6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x207] = Q_KEY_CODE_UNMAPPED, /* linux:519 (KEY_NUMERIC_7) -> linux:519 (KEY_NUMERIC_7) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x208] = Q_KEY_CODE_UNMAPPED, /* linux:520 (KEY_NUMERIC_8) -> linux:520 (KEY_NUMERIC_8) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x209] = Q_KEY_CODE_UNMAPPED, /* linux:521 (KEY_NUMERIC_9) -> linux:521 (KEY_NUMERIC_9) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20a] = Q_KEY_CODE_UNMAPPED, /* linux:522 (KEY_NUMERIC_STAR) -> linux:522 (KEY_NUMERIC_STAR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20b] = Q_KEY_CODE_UNMAPPED, /* linux:523 (KEY_NUMERIC_POUND) -> linux:523 (KEY_NUMERIC_POUND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20c] = Q_KEY_CODE_UNMAPPED, /* linux:524 (KEY_RFKILL) -> linux:524 (KEY_RFKILL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+};
+const guint qemu_input_map_linux_to_qcode_len = sizeof(qemu_input_map_linux_to_qcode)/sizeof(qemu_input_map_linux_to_qcode[0]);
diff --git a/ui/input-keymap-qcode-to-qnum.c b/ui/input-keymap-qcode-to-qnum.c
new file mode 100644
index 0000000000..acaaa0f16d
--- /dev/null
+++ b/ui/input-keymap-qcode-to-qnum.c
@@ -0,0 +1,154 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:01
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_qcode_to_qnum code-map keymaps.csv qcode qnum
+*/
+const guint16 qemu_input_map_qcode_to_qnum[Q_KEY_CODE__MAX] = {
+  [Q_KEY_CODE_0] = 0xb, /* qcode:Q_KEY_CODE_0 (0) -> linux:11 (KEY_0) -> qnum:11 */
+  [Q_KEY_CODE_1] = 0x2, /* qcode:Q_KEY_CODE_1 (1) -> linux:2 (KEY_1) -> qnum:2 */
+  [Q_KEY_CODE_2] = 0x3, /* qcode:Q_KEY_CODE_2 (2) -> linux:3 (KEY_2) -> qnum:3 */
+  [Q_KEY_CODE_3] = 0x4, /* qcode:Q_KEY_CODE_3 (3) -> linux:4 (KEY_3) -> qnum:4 */
+  [Q_KEY_CODE_4] = 0x5, /* qcode:Q_KEY_CODE_4 (4) -> linux:5 (KEY_4) -> qnum:5 */
+  [Q_KEY_CODE_5] = 0x6, /* qcode:Q_KEY_CODE_5 (5) -> linux:6 (KEY_5) -> qnum:6 */
+  [Q_KEY_CODE_6] = 0x7, /* qcode:Q_KEY_CODE_6 (6) -> linux:7 (KEY_6) -> qnum:7 */
+  [Q_KEY_CODE_7] = 0x8, /* qcode:Q_KEY_CODE_7 (7) -> linux:8 (KEY_7) -> qnum:8 */
+  [Q_KEY_CODE_8] = 0x9, /* qcode:Q_KEY_CODE_8 (8) -> linux:9 (KEY_8) -> qnum:9 */
+  [Q_KEY_CODE_9] = 0xa, /* qcode:Q_KEY_CODE_9 (9) -> linux:10 (KEY_9) -> qnum:10 */
+  [Q_KEY_CODE_A] = 0x1e, /* qcode:Q_KEY_CODE_A (a) -> linux:30 (KEY_A) -> qnum:30 */
+  [Q_KEY_CODE_AC_BACK] = 0xea, /* qcode:Q_KEY_CODE_AC_BACK (ac_back) -> linux:158 (KEY_BACK) -> qnum:234 */
+  [Q_KEY_CODE_AC_BOOKMARKS] = 0xe6, /* qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) -> linux:156 (KEY_BOOKMARKS) -> qnum:230 */
+  [Q_KEY_CODE_AC_FORWARD] = 0xe9, /* qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) -> linux:159 (KEY_FORWARD) -> qnum:233 */
+  [Q_KEY_CODE_AC_HOME] = 0xb2, /* qcode:Q_KEY_CODE_AC_HOME (ac_home) -> linux:172 (KEY_HOMEPAGE) -> qnum:178 */
+  [Q_KEY_CODE_AC_REFRESH] = 0xe7, /* qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) -> linux:173 (KEY_REFRESH) -> qnum:231 */
+  [Q_KEY_CODE_AGAIN] = 0x85, /* qcode:Q_KEY_CODE_AGAIN (again) -> linux:129 (KEY_AGAIN) -> qnum:133 */
+  [Q_KEY_CODE_ALT] = 0x38, /* qcode:Q_KEY_CODE_ALT (alt) -> linux:56 (KEY_LEFTALT) -> qnum:56 */
+  [Q_KEY_CODE_ALT_R] = 0xb8, /* qcode:Q_KEY_CODE_ALT_R (alt_r) -> linux:100 (KEY_RIGHTALT) -> qnum:184 */
+  [Q_KEY_CODE_APOSTROPHE] = 0x28, /* qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) -> linux:40 (KEY_APOSTROPHE) -> qnum:40 */
+  [Q_KEY_CODE_ASTERISK] = 0x37, /* qcode:Q_KEY_CODE_ASTERISK (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> qnum:55 */
+  [Q_KEY_CODE_AUDIOMUTE] = 0xa0, /* qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) -> linux:113 (KEY_MUTE) -> qnum:160 */
+  [Q_KEY_CODE_AUDIONEXT] = 0x99, /* qcode:Q_KEY_CODE_AUDIONEXT (audionext) -> linux:163 (KEY_NEXTSONG) -> qnum:153 */
+  [Q_KEY_CODE_AUDIOPLAY] = 0xa2, /* qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) -> linux:164 (KEY_PLAYPAUSE) -> qnum:162 */
+  [Q_KEY_CODE_AUDIOPREV] = 0x90, /* qcode:Q_KEY_CODE_AUDIOPREV (audioprev) -> linux:165 (KEY_PREVIOUSSONG) -> qnum:144 */
+  [Q_KEY_CODE_AUDIOSTOP] = 0xa4, /* qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) -> linux:166 (KEY_STOPCD) -> qnum:164 */
+  [Q_KEY_CODE_B] = 0x30, /* qcode:Q_KEY_CODE_B (b) -> linux:48 (KEY_B) -> qnum:48 */
+  [Q_KEY_CODE_BACKSLASH] = 0x2b, /* qcode:Q_KEY_CODE_BACKSLASH (backslash) -> linux:43 (KEY_BACKSLASH) -> qnum:43 */
+  [Q_KEY_CODE_BACKSPACE] = 0xe, /* qcode:Q_KEY_CODE_BACKSPACE (backspace) -> linux:14 (KEY_BACKSPACE) -> qnum:14 */
+  [Q_KEY_CODE_BRACKET_LEFT] = 0x1a, /* qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) -> linux:26 (KEY_LEFTBRACE) -> qnum:26 */
+  [Q_KEY_CODE_BRACKET_RIGHT] = 0x1b, /* qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) -> linux:27 (KEY_RIGHTBRACE) -> qnum:27 */
+  [Q_KEY_CODE_C] = 0x2e, /* qcode:Q_KEY_CODE_C (c) -> linux:46 (KEY_C) -> qnum:46 */
+  [Q_KEY_CODE_CALCULATOR] = 0xa1, /* qcode:Q_KEY_CODE_CALCULATOR (calculator) -> linux:140 (KEY_CALC) -> qnum:161 */
+  [Q_KEY_CODE_CAPS_LOCK] = 0x3a, /* qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) -> linux:58 (KEY_CAPSLOCK) -> qnum:58 */
+  [Q_KEY_CODE_COMMA] = 0x33, /* qcode:Q_KEY_CODE_COMMA (comma) -> linux:51 (KEY_COMMA) -> qnum:51 */
+  [Q_KEY_CODE_COMPOSE] = 0xdd, /* qcode:Q_KEY_CODE_COMPOSE (compose) -> linux:127 (KEY_COMPOSE) -> qnum:221 */
+  [Q_KEY_CODE_COMPUTER] = 0xeb, /* qcode:Q_KEY_CODE_COMPUTER (computer) -> linux:157 (KEY_COMPUTER) -> qnum:235 */
+  [Q_KEY_CODE_COPY] = 0xf8, /* qcode:Q_KEY_CODE_COPY (copy) -> linux:133 (KEY_COPY) -> qnum:248 */
+  [Q_KEY_CODE_CTRL] = 0x1d, /* qcode:Q_KEY_CODE_CTRL (ctrl) -> linux:29 (KEY_LEFTCTRL) -> qnum:29 */
+  [Q_KEY_CODE_CTRL_R] = 0x9d, /* qcode:Q_KEY_CODE_CTRL_R (ctrl_r) -> linux:97 (KEY_RIGHTCTRL) -> qnum:157 */
+  [Q_KEY_CODE_CUT] = 0xbc, /* qcode:Q_KEY_CODE_CUT (cut) -> linux:137 (KEY_CUT) -> qnum:188 */
+  [Q_KEY_CODE_D] = 0x20, /* qcode:Q_KEY_CODE_D (d) -> linux:32 (KEY_D) -> qnum:32 */
+  [Q_KEY_CODE_DELETE] = 0xd3, /* qcode:Q_KEY_CODE_DELETE (delete) -> linux:111 (KEY_DELETE) -> qnum:211 */
+  [Q_KEY_CODE_DOT] = 0x34, /* qcode:Q_KEY_CODE_DOT (dot) -> linux:52 (KEY_DOT) -> qnum:52 */
+  [Q_KEY_CODE_DOWN] = 0xd0, /* qcode:Q_KEY_CODE_DOWN (down) -> linux:108 (KEY_DOWN) -> qnum:208 */
+  [Q_KEY_CODE_E] = 0x12, /* qcode:Q_KEY_CODE_E (e) -> linux:18 (KEY_E) -> qnum:18 */
+  [Q_KEY_CODE_END] = 0xcf, /* qcode:Q_KEY_CODE_END (end) -> linux:107 (KEY_END) -> qnum:207 */
+  [Q_KEY_CODE_EQUAL] = 0xd, /* qcode:Q_KEY_CODE_EQUAL (equal) -> linux:13 (KEY_EQUAL) -> qnum:13 */
+  [Q_KEY_CODE_ESC] = 0x1, /* qcode:Q_KEY_CODE_ESC (esc) -> linux:1 (KEY_ESC) -> qnum:1 */
+  [Q_KEY_CODE_F] = 0x21, /* qcode:Q_KEY_CODE_F (f) -> linux:33 (KEY_F) -> qnum:33 */
+  [Q_KEY_CODE_F1] = 0x3b, /* qcode:Q_KEY_CODE_F1 (f1) -> linux:59 (KEY_F1) -> qnum:59 */
+  [Q_KEY_CODE_F10] = 0x44, /* qcode:Q_KEY_CODE_F10 (f10) -> linux:68 (KEY_F10) -> qnum:68 */
+  [Q_KEY_CODE_F11] = 0x57, /* qcode:Q_KEY_CODE_F11 (f11) -> linux:87 (KEY_F11) -> qnum:87 */
+  [Q_KEY_CODE_F12] = 0x58, /* qcode:Q_KEY_CODE_F12 (f12) -> linux:88 (KEY_F12) -> qnum:88 */
+  [Q_KEY_CODE_F2] = 0x3c, /* qcode:Q_KEY_CODE_F2 (f2) -> linux:60 (KEY_F2) -> qnum:60 */
+  [Q_KEY_CODE_F3] = 0x3d, /* qcode:Q_KEY_CODE_F3 (f3) -> linux:61 (KEY_F3) -> qnum:61 */
+  [Q_KEY_CODE_F4] = 0x3e, /* qcode:Q_KEY_CODE_F4 (f4) -> linux:62 (KEY_F4) -> qnum:62 */
+  [Q_KEY_CODE_F5] = 0x3f, /* qcode:Q_KEY_CODE_F5 (f5) -> linux:63 (KEY_F5) -> qnum:63 */
+  [Q_KEY_CODE_F6] = 0x40, /* qcode:Q_KEY_CODE_F6 (f6) -> linux:64 (KEY_F6) -> qnum:64 */
+  [Q_KEY_CODE_F7] = 0x41, /* qcode:Q_KEY_CODE_F7 (f7) -> linux:65 (KEY_F7) -> qnum:65 */
+  [Q_KEY_CODE_F8] = 0x42, /* qcode:Q_KEY_CODE_F8 (f8) -> linux:66 (KEY_F8) -> qnum:66 */
+  [Q_KEY_CODE_F9] = 0x43, /* qcode:Q_KEY_CODE_F9 (f9) -> linux:67 (KEY_F9) -> qnum:67 */
+  [Q_KEY_CODE_FIND] = 0xc1, /* qcode:Q_KEY_CODE_FIND (find) -> linux:136 (KEY_FIND) -> qnum:193 */
+  [Q_KEY_CODE_FRONT] = 0x8c, /* qcode:Q_KEY_CODE_FRONT (front) -> linux:132 (KEY_FRONT) -> qnum:140 */
+  [Q_KEY_CODE_G] = 0x22, /* qcode:Q_KEY_CODE_G (g) -> linux:34 (KEY_G) -> qnum:34 */
+  [Q_KEY_CODE_GRAVE_ACCENT] = 0x29, /* qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) -> linux:41 (KEY_GRAVE) -> qnum:41 */
+  [Q_KEY_CODE_H] = 0x23, /* qcode:Q_KEY_CODE_H (h) -> linux:35 (KEY_H) -> qnum:35 */
+  [Q_KEY_CODE_HELP] = 0xf5, /* qcode:Q_KEY_CODE_HELP (help) -> linux:138 (KEY_HELP) -> qnum:245 */
+  [Q_KEY_CODE_HENKAN] = 0x79, /* qcode:Q_KEY_CODE_HENKAN (henkan) -> linux:92 (KEY_HENKAN) -> qnum:121 */
+  [Q_KEY_CODE_HIRAGANA] = 0x77, /* qcode:Q_KEY_CODE_HIRAGANA (hiragana) -> linux:91 (KEY_HIRAGANA) -> qnum:119 */
+  [Q_KEY_CODE_HOME] = 0xc7, /* qcode:Q_KEY_CODE_HOME (home) -> linux:102 (KEY_HOME) -> qnum:199 */
+  [Q_KEY_CODE_I] = 0x17, /* qcode:Q_KEY_CODE_I (i) -> linux:23 (KEY_I) -> qnum:23 */
+  [Q_KEY_CODE_INSERT] = 0xd2, /* qcode:Q_KEY_CODE_INSERT (insert) -> linux:110 (KEY_INSERT) -> qnum:210 */
+  [Q_KEY_CODE_J] = 0x24, /* qcode:Q_KEY_CODE_J (j) -> linux:36 (KEY_J) -> qnum:36 */
+  [Q_KEY_CODE_K] = 0x25, /* qcode:Q_KEY_CODE_K (k) -> linux:37 (KEY_K) -> qnum:37 */
+  [Q_KEY_CODE_KP_0] = 0x52, /* qcode:Q_KEY_CODE_KP_0 (kp_0) -> linux:82 (KEY_KP0) -> qnum:82 */
+  [Q_KEY_CODE_KP_1] = 0x4f, /* qcode:Q_KEY_CODE_KP_1 (kp_1) -> linux:79 (KEY_KP1) -> qnum:79 */
+  [Q_KEY_CODE_KP_2] = 0x50, /* qcode:Q_KEY_CODE_KP_2 (kp_2) -> linux:80 (KEY_KP2) -> qnum:80 */
+  [Q_KEY_CODE_KP_3] = 0x51, /* qcode:Q_KEY_CODE_KP_3 (kp_3) -> linux:81 (KEY_KP3) -> qnum:81 */
+  [Q_KEY_CODE_KP_4] = 0x4b, /* qcode:Q_KEY_CODE_KP_4 (kp_4) -> linux:75 (KEY_KP4) -> qnum:75 */
+  [Q_KEY_CODE_KP_5] = 0x4c, /* qcode:Q_KEY_CODE_KP_5 (kp_5) -> linux:76 (KEY_KP5) -> qnum:76 */
+  [Q_KEY_CODE_KP_6] = 0x4d, /* qcode:Q_KEY_CODE_KP_6 (kp_6) -> linux:77 (KEY_KP6) -> qnum:77 */
+  [Q_KEY_CODE_KP_7] = 0x47, /* qcode:Q_KEY_CODE_KP_7 (kp_7) -> linux:71 (KEY_KP7) -> qnum:71 */
+  [Q_KEY_CODE_KP_8] = 0x48, /* qcode:Q_KEY_CODE_KP_8 (kp_8) -> linux:72 (KEY_KP8) -> qnum:72 */
+  [Q_KEY_CODE_KP_9] = 0x49, /* qcode:Q_KEY_CODE_KP_9 (kp_9) -> linux:73 (KEY_KP9) -> qnum:73 */
+  [Q_KEY_CODE_KP_ADD] = 0x4e, /* qcode:Q_KEY_CODE_KP_ADD (kp_add) -> linux:78 (KEY_KPPLUS) -> qnum:78 */
+  [Q_KEY_CODE_KP_COMMA] = 0x7e, /* qcode:Q_KEY_CODE_KP_COMMA (kp_comma) -> linux:121 (KEY_KPCOMMA) -> qnum:126 */
+  [Q_KEY_CODE_KP_DECIMAL] = 0x53, /* qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) -> linux:83 (KEY_KPDOT) -> qnum:83 */
+  [Q_KEY_CODE_KP_DIVIDE] = 0xb5, /* qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) -> linux:98 (KEY_KPSLASH) -> qnum:181 */
+  [Q_KEY_CODE_KP_ENTER] = 0x9c, /* qcode:Q_KEY_CODE_KP_ENTER (kp_enter) -> linux:96 (KEY_KPENTER) -> qnum:156 */
+  [Q_KEY_CODE_KP_EQUALS] = 0x59, /* qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) -> linux:117 (KEY_KPEQUAL) -> qnum:89 */
+  [Q_KEY_CODE_KP_MULTIPLY] = 0x37, /* qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> qnum:55 */
+  [Q_KEY_CODE_KP_SUBTRACT] = 0x4a, /* qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) -> linux:74 (KEY_KPMINUS) -> qnum:74 */
+  [Q_KEY_CODE_L] = 0x26, /* qcode:Q_KEY_CODE_L (l) -> linux:38 (KEY_L) -> qnum:38 */
+  [Q_KEY_CODE_LEFT] = 0xcb, /* qcode:Q_KEY_CODE_LEFT (left) -> linux:105 (KEY_LEFT) -> qnum:203 */
+  [Q_KEY_CODE_LESS] = 0x56, /* qcode:Q_KEY_CODE_LESS (less) -> linux:86 (KEY_102ND) -> qnum:86 */
+  [Q_KEY_CODE_LF] = 0x5b, /* qcode:Q_KEY_CODE_LF (lf) -> linux:101 (KEY_LINEFEED) -> qnum:91 */
+  [Q_KEY_CODE_M] = 0x32, /* qcode:Q_KEY_CODE_M (m) -> linux:50 (KEY_M) -> qnum:50 */
+  [Q_KEY_CODE_MAIL] = 0xec, /* qcode:Q_KEY_CODE_MAIL (mail) -> linux:155 (KEY_MAIL) -> qnum:236 */
+  [Q_KEY_CODE_MEDIASELECT] = 0xed, /* qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) -> linux:226 (KEY_MEDIA) -> qnum:237 */
+  [Q_KEY_CODE_MENU] = 0x9e, /* qcode:Q_KEY_CODE_MENU (menu) -> linux:139 (KEY_MENU) -> qnum:158 */
+  [Q_KEY_CODE_META_L] = 0xdb, /* qcode:Q_KEY_CODE_META_L (meta_l) -> linux:125 (KEY_LEFTMETA) -> qnum:219 */
+  [Q_KEY_CODE_META_R] = 0xdc, /* qcode:Q_KEY_CODE_META_R (meta_r) -> linux:126 (KEY_RIGHTMETA) -> qnum:220 */
+  [Q_KEY_CODE_MINUS] = 0xc, /* qcode:Q_KEY_CODE_MINUS (minus) -> linux:12 (KEY_MINUS) -> qnum:12 */
+  [Q_KEY_CODE_N] = 0x31, /* qcode:Q_KEY_CODE_N (n) -> linux:49 (KEY_N) -> qnum:49 */
+  [Q_KEY_CODE_NUM_LOCK] = 0x45, /* qcode:Q_KEY_CODE_NUM_LOCK (num_lock) -> linux:69 (KEY_NUMLOCK) -> qnum:69 */
+  [Q_KEY_CODE_O] = 0x18, /* qcode:Q_KEY_CODE_O (o) -> linux:24 (KEY_O) -> qnum:24 */
+  [Q_KEY_CODE_OPEN] = 0x64, /* qcode:Q_KEY_CODE_OPEN (open) -> linux:134 (KEY_OPEN) -> qnum:100 */
+  [Q_KEY_CODE_P] = 0x19, /* qcode:Q_KEY_CODE_P (p) -> linux:25 (KEY_P) -> qnum:25 */
+  [Q_KEY_CODE_PASTE] = 0x65, /* qcode:Q_KEY_CODE_PASTE (paste) -> linux:135 (KEY_PASTE) -> qnum:101 */
+  [Q_KEY_CODE_PAUSE] = 0xc6, /* qcode:Q_KEY_CODE_PAUSE (pause) -> linux:119 (KEY_PAUSE) -> qnum:198 */
+  [Q_KEY_CODE_PGDN] = 0xd1, /* qcode:Q_KEY_CODE_PGDN (pgdn) -> linux:109 (KEY_PAGEDOWN) -> qnum:209 */
+  [Q_KEY_CODE_PGUP] = 0xc9, /* qcode:Q_KEY_CODE_PGUP (pgup) -> linux:104 (KEY_PAGEUP) -> qnum:201 */
+  [Q_KEY_CODE_POWER] = 0xde, /* qcode:Q_KEY_CODE_POWER (power) -> linux:116 (KEY_POWER) -> qnum:222 */
+  [Q_KEY_CODE_PRINT] = 0x54, /* qcode:Q_KEY_CODE_PRINT (sysrq) -> linux:99 (KEY_SYSRQ) -> qnum:84 */
+  [Q_KEY_CODE_PROPS] = 0x86, /* qcode:Q_KEY_CODE_PROPS (props) -> linux:130 (KEY_PROPS) -> qnum:134 */
+  [Q_KEY_CODE_Q] = 0x10, /* qcode:Q_KEY_CODE_Q (q) -> linux:16 (KEY_Q) -> qnum:16 */
+  [Q_KEY_CODE_R] = 0x13, /* qcode:Q_KEY_CODE_R (r) -> linux:19 (KEY_R) -> qnum:19 */
+  [Q_KEY_CODE_RET] = 0x1c, /* qcode:Q_KEY_CODE_RET (ret) -> linux:28 (KEY_ENTER) -> qnum:28 */
+  [Q_KEY_CODE_RIGHT] = 0xcd, /* qcode:Q_KEY_CODE_RIGHT (right) -> linux:106 (KEY_RIGHT) -> qnum:205 */
+  [Q_KEY_CODE_RO] = 0x73, /* qcode:Q_KEY_CODE_RO (ro) -> linux:89 (KEY_RO) -> qnum:115 */
+  [Q_KEY_CODE_S] = 0x1f, /* qcode:Q_KEY_CODE_S (s) -> linux:31 (KEY_S) -> qnum:31 */
+  [Q_KEY_CODE_SCROLL_LOCK] = 0x46, /* qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) -> linux:70 (KEY_SCROLLLOCK) -> qnum:70 */
+  [Q_KEY_CODE_SEMICOLON] = 0x27, /* qcode:Q_KEY_CODE_SEMICOLON (semicolon) -> linux:39 (KEY_SEMICOLON) -> qnum:39 */
+  [Q_KEY_CODE_SHIFT] = 0x2a, /* qcode:Q_KEY_CODE_SHIFT (shift) -> linux:42 (KEY_LEFTSHIFT) -> qnum:42 */
+  [Q_KEY_CODE_SHIFT_R] = 0x36, /* qcode:Q_KEY_CODE_SHIFT_R (shift_r) -> linux:54 (KEY_RIGHTSHIFT) -> qnum:54 */
+  [Q_KEY_CODE_SLASH] = 0x35, /* qcode:Q_KEY_CODE_SLASH (slash) -> linux:53 (KEY_SLASH) -> qnum:53 */
+  [Q_KEY_CODE_SLEEP] = 0xdf, /* qcode:Q_KEY_CODE_SLEEP (sleep) -> linux:142 (KEY_SLEEP) -> qnum:223 */
+  [Q_KEY_CODE_SPC] = 0x39, /* qcode:Q_KEY_CODE_SPC (spc) -> linux:57 (KEY_SPACE) -> qnum:57 */
+  [Q_KEY_CODE_STOP] = 0xe8, /* qcode:Q_KEY_CODE_STOP (stop) -> linux:128 (KEY_STOP) -> qnum:232 */
+  [Q_KEY_CODE_SYSRQ] = 0x54, /* qcode:Q_KEY_CODE_SYSRQ (sysrq) -> linux:99 (KEY_SYSRQ) -> qnum:84 */
+  [Q_KEY_CODE_T] = 0x14, /* qcode:Q_KEY_CODE_T (t) -> linux:20 (KEY_T) -> qnum:20 */
+  [Q_KEY_CODE_TAB] = 0xf, /* qcode:Q_KEY_CODE_TAB (tab) -> linux:15 (KEY_TAB) -> qnum:15 */
+  [Q_KEY_CODE_U] = 0x16, /* qcode:Q_KEY_CODE_U (u) -> linux:22 (KEY_U) -> qnum:22 */
+  [Q_KEY_CODE_UNDO] = 0x87, /* qcode:Q_KEY_CODE_UNDO (undo) -> linux:131 (KEY_UNDO) -> qnum:135 */
+  [Q_KEY_CODE_UP] = 0xc8, /* qcode:Q_KEY_CODE_UP (up) -> linux:103 (KEY_UP) -> qnum:200 */
+  [Q_KEY_CODE_V] = 0x2f, /* qcode:Q_KEY_CODE_V (v) -> linux:47 (KEY_V) -> qnum:47 */
+  [Q_KEY_CODE_VOLUMEDOWN] = 0xae, /* qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) -> linux:114 (KEY_VOLUMEDOWN) -> qnum:174 */
+  [Q_KEY_CODE_VOLUMEUP] = 0xb0, /* qcode:Q_KEY_CODE_VOLUMEUP (volumeup) -> linux:115 (KEY_VOLUMEUP) -> qnum:176 */
+  [Q_KEY_CODE_W] = 0x11, /* qcode:Q_KEY_CODE_W (w) -> linux:17 (KEY_W) -> qnum:17 */
+  [Q_KEY_CODE_WAKE] = 0xe3, /* qcode:Q_KEY_CODE_WAKE (wake) -> linux:143 (KEY_WAKEUP) -> qnum:227 */
+  [Q_KEY_CODE_X] = 0x2d, /* qcode:Q_KEY_CODE_X (x) -> linux:45 (KEY_X) -> qnum:45 */
+  [Q_KEY_CODE_Y] = 0x15, /* qcode:Q_KEY_CODE_Y (y) -> linux:21 (KEY_Y) -> qnum:21 */
+  [Q_KEY_CODE_YEN] = 0x7d, /* qcode:Q_KEY_CODE_YEN (yen) -> linux:124 (KEY_YEN) -> qnum:125 */
+  [Q_KEY_CODE_Z] = 0x2c, /* qcode:Q_KEY_CODE_Z (z) -> linux:44 (KEY_Z) -> qnum:44 */
+};
+const guint qemu_input_map_qcode_to_qnum_len = sizeof(qemu_input_map_qcode_to_qnum)/sizeof(qemu_input_map_qcode_to_qnum[0]);
diff --git a/ui/input-keymap-qnum-to-qcode.c b/ui/input-keymap-qnum-to-qcode.c
new file mode 100644
index 0000000000..eba9ad0f96
--- /dev/null
+++ b/ui/input-keymap-qnum-to-qcode.c
@@ -0,0 +1,245 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:01
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_qnum_to_qcode code-map keymaps.csv qnum qcode
+*/
+const guint16 qemu_input_map_qnum_to_qcode[254] = {
+  [0x1] = Q_KEY_CODE_ESC, /* qnum:1 -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0x2] = Q_KEY_CODE_1, /* qnum:2 -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x3] = Q_KEY_CODE_2, /* qnum:3 -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x4] = Q_KEY_CODE_3, /* qnum:4 -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x5] = Q_KEY_CODE_4, /* qnum:5 -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x6] = Q_KEY_CODE_5, /* qnum:6 -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x7] = Q_KEY_CODE_6, /* qnum:7 -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x8] = Q_KEY_CODE_7, /* qnum:8 -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x9] = Q_KEY_CODE_8, /* qnum:9 -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0xa] = Q_KEY_CODE_9, /* qnum:10 -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0xb] = Q_KEY_CODE_0, /* qnum:11 -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0xc] = Q_KEY_CODE_MINUS, /* qnum:12 -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0xd] = Q_KEY_CODE_EQUAL, /* qnum:13 -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0xe] = Q_KEY_CODE_BACKSPACE, /* qnum:14 -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0xf] = Q_KEY_CODE_TAB, /* qnum:15 -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x10] = Q_KEY_CODE_Q, /* qnum:16 -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x11] = Q_KEY_CODE_W, /* qnum:17 -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x12] = Q_KEY_CODE_E, /* qnum:18 -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x13] = Q_KEY_CODE_R, /* qnum:19 -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x14] = Q_KEY_CODE_T, /* qnum:20 -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x15] = Q_KEY_CODE_Y, /* qnum:21 -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x16] = Q_KEY_CODE_U, /* qnum:22 -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x17] = Q_KEY_CODE_I, /* qnum:23 -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x18] = Q_KEY_CODE_O, /* qnum:24 -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x19] = Q_KEY_CODE_P, /* qnum:25 -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x1a] = Q_KEY_CODE_BRACKET_LEFT, /* qnum:26 -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x1b] = Q_KEY_CODE_BRACKET_RIGHT, /* qnum:27 -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x1c] = Q_KEY_CODE_RET, /* qnum:28 -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x1d] = Q_KEY_CODE_CTRL, /* qnum:29 -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x1e] = Q_KEY_CODE_A, /* qnum:30 -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x1f] = Q_KEY_CODE_S, /* qnum:31 -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x20] = Q_KEY_CODE_D, /* qnum:32 -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x21] = Q_KEY_CODE_F, /* qnum:33 -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x22] = Q_KEY_CODE_G, /* qnum:34 -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x23] = Q_KEY_CODE_H, /* qnum:35 -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x24] = Q_KEY_CODE_J, /* qnum:36 -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x25] = Q_KEY_CODE_K, /* qnum:37 -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x26] = Q_KEY_CODE_L, /* qnum:38 -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x27] = Q_KEY_CODE_SEMICOLON, /* qnum:39 -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x28] = Q_KEY_CODE_APOSTROPHE, /* qnum:40 -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x29] = Q_KEY_CODE_GRAVE_ACCENT, /* qnum:41 -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x2a] = Q_KEY_CODE_SHIFT, /* qnum:42 -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x2b] = Q_KEY_CODE_BACKSLASH, /* qnum:43 -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x2c] = Q_KEY_CODE_Z, /* qnum:44 -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x2d] = Q_KEY_CODE_X, /* qnum:45 -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x2e] = Q_KEY_CODE_C, /* qnum:46 -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x2f] = Q_KEY_CODE_V, /* qnum:47 -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x30] = Q_KEY_CODE_B, /* qnum:48 -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x31] = Q_KEY_CODE_N, /* qnum:49 -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x32] = Q_KEY_CODE_M, /* qnum:50 -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x33] = Q_KEY_CODE_COMMA, /* qnum:51 -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x34] = Q_KEY_CODE_DOT, /* qnum:52 -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x35] = Q_KEY_CODE_SLASH, /* qnum:53 -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x36] = Q_KEY_CODE_SHIFT_R, /* qnum:54 -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0x37] = Q_KEY_CODE_KP_MULTIPLY, /* qnum:55 -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x38] = Q_KEY_CODE_ALT, /* qnum:56 -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x39] = Q_KEY_CODE_SPC, /* qnum:57 -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x3a] = Q_KEY_CODE_CAPS_LOCK, /* qnum:58 -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x3b] = Q_KEY_CODE_F1, /* qnum:59 -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x3c] = Q_KEY_CODE_F2, /* qnum:60 -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x3d] = Q_KEY_CODE_F3, /* qnum:61 -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x3e] = Q_KEY_CODE_F4, /* qnum:62 -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x3f] = Q_KEY_CODE_F5, /* qnum:63 -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x40] = Q_KEY_CODE_F6, /* qnum:64 -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x41] = Q_KEY_CODE_F7, /* qnum:65 -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x42] = Q_KEY_CODE_F8, /* qnum:66 -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x43] = Q_KEY_CODE_F9, /* qnum:67 -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x44] = Q_KEY_CODE_F10, /* qnum:68 -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x45] = Q_KEY_CODE_NUM_LOCK, /* qnum:69 -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x46] = Q_KEY_CODE_SCROLL_LOCK, /* qnum:70 -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0x47] = Q_KEY_CODE_KP_7, /* qnum:71 -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x48] = Q_KEY_CODE_KP_8, /* qnum:72 -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x49] = Q_KEY_CODE_KP_9, /* qnum:73 -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x4a] = Q_KEY_CODE_KP_SUBTRACT, /* qnum:74 -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x4b] = Q_KEY_CODE_KP_4, /* qnum:75 -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x4c] = Q_KEY_CODE_KP_5, /* qnum:76 -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x4d] = Q_KEY_CODE_KP_6, /* qnum:77 -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x4e] = Q_KEY_CODE_KP_ADD, /* qnum:78 -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x4f] = Q_KEY_CODE_KP_1, /* qnum:79 -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x50] = Q_KEY_CODE_KP_2, /* qnum:80 -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x51] = Q_KEY_CODE_KP_3, /* qnum:81 -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x52] = Q_KEY_CODE_KP_0, /* qnum:82 -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x53] = Q_KEY_CODE_KP_DECIMAL, /* qnum:83 -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x54] = Q_KEY_CODE_SYSRQ, /* qnum:84 -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0x55] = Q_KEY_CODE_UNMAPPED, /* qnum:85 -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x56] = Q_KEY_CODE_LESS, /* qnum:86 -> linux:86 (KEY_102ND) -> qcode:Q_KEY_CODE_LESS (less) */
+  [0x57] = Q_KEY_CODE_F11, /* qnum:87 -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x58] = Q_KEY_CODE_F12, /* qnum:88 -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x59] = Q_KEY_CODE_KP_EQUALS, /* qnum:89 -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x5a] = Q_KEY_CODE_UNMAPPED, /* qnum:90 -> linux:190 (KEY_F20) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5b] = Q_KEY_CODE_LF, /* qnum:91 -> linux:101 (KEY_LINEFEED) -> qcode:Q_KEY_CODE_LF (lf) */
+  [0x5c] = Q_KEY_CODE_UNMAPPED, /* qnum:92 -> linux:95 (KEY_KPJPCOMMA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5d] = Q_KEY_CODE_UNMAPPED, /* qnum:93 -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5e] = Q_KEY_CODE_UNMAPPED, /* qnum:94 -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5f] = Q_KEY_CODE_UNMAPPED, /* qnum:95 -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x63] = Q_KEY_CODE_UNMAPPED, /* qnum:99 -> linux:169 (KEY_PHONE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x64] = Q_KEY_CODE_OPEN, /* qnum:100 -> linux:134 (KEY_OPEN) -> qcode:Q_KEY_CODE_OPEN (open) */
+  [0x65] = Q_KEY_CODE_PASTE, /* qnum:101 -> linux:135 (KEY_PASTE) -> qcode:Q_KEY_CODE_PASTE (paste) */
+  [0x66] = Q_KEY_CODE_UNMAPPED, /* qnum:102 -> linux:141 (KEY_SETUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x67] = Q_KEY_CODE_UNMAPPED, /* qnum:103 -> linux:144 (KEY_FILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x68] = Q_KEY_CODE_UNMAPPED, /* qnum:104 -> linux:145 (KEY_SENDFILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x69] = Q_KEY_CODE_UNMAPPED, /* qnum:105 -> linux:146 (KEY_DELETEFILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6a] = Q_KEY_CODE_UNMAPPED, /* qnum:106 -> linux:151 (KEY_MSDOS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6b] = Q_KEY_CODE_UNMAPPED, /* qnum:107 -> linux:153 (KEY_DIRECTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6c] = Q_KEY_CODE_UNMAPPED, /* qnum:108 -> linux:161 (KEY_EJECTCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6d] = Q_KEY_CODE_UNMAPPED, /* qnum:109 -> linux:193 (KEY_F23) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6f] = Q_KEY_CODE_UNMAPPED, /* qnum:111 -> linux:194 (KEY_F24) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x70] = Q_KEY_CODE_UNMAPPED, /* qnum:112 -> linux:170 (KEY_ISO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x71] = Q_KEY_CODE_UNMAPPED, /* qnum:113 -> linux:174 (KEY_EXIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x72] = Q_KEY_CODE_UNMAPPED, /* qnum:114 -> linux:175 (KEY_MOVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x73] = Q_KEY_CODE_RO, /* qnum:115 -> linux:89 (KEY_RO) -> qcode:Q_KEY_CODE_RO (ro) */
+  [0x74] = Q_KEY_CODE_UNMAPPED, /* qnum:116 -> linux:191 (KEY_F21) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x75] = Q_KEY_CODE_UNMAPPED, /* qnum:117 -> linux:177 (KEY_SCROLLUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x76] = Q_KEY_CODE_UNMAPPED, /* qnum:118 -> linux:85 (KEY_ZENKAKUHANKAKU) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x77] = Q_KEY_CODE_HIRAGANA, /* qnum:119 -> linux:91 (KEY_HIRAGANA) -> qcode:Q_KEY_CODE_HIRAGANA (hiragana) */
+  [0x78] = Q_KEY_CODE_UNMAPPED, /* qnum:120 -> linux:90 (KEY_KATAKANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x79] = Q_KEY_CODE_HENKAN, /* qnum:121 -> linux:92 (KEY_HENKAN) -> qcode:Q_KEY_CODE_HENKAN (henkan) */
+  [0x7b] = Q_KEY_CODE_UNMAPPED, /* qnum:123 -> linux:94 (KEY_MUHENKAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7d] = Q_KEY_CODE_YEN, /* qnum:125 -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0x7e] = Q_KEY_CODE_KP_COMMA, /* qnum:126 -> linux:121 (KEY_KPCOMMA) -> qcode:Q_KEY_CODE_KP_COMMA (kp_comma) */
+  [0x81] = Q_KEY_CODE_UNMAPPED, /* qnum:129 -> linux:171 (KEY_CONFIG) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x82] = Q_KEY_CODE_UNMAPPED, /* qnum:130 -> linux:150 (KEY_WWW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x83] = Q_KEY_CODE_UNMAPPED, /* qnum:131 -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x84] = Q_KEY_CODE_UNMAPPED, /* qnum:132 -> linux:189 (KEY_F19) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x85] = Q_KEY_CODE_AGAIN, /* qnum:133 -> linux:129 (KEY_AGAIN) -> qcode:Q_KEY_CODE_AGAIN (again) */
+  [0x86] = Q_KEY_CODE_PROPS, /* qnum:134 -> linux:130 (KEY_PROPS) -> qcode:Q_KEY_CODE_PROPS (props) */
+  [0x87] = Q_KEY_CODE_UNDO, /* qnum:135 -> linux:131 (KEY_UNDO) -> qcode:Q_KEY_CODE_UNDO (undo) */
+  [0x88] = Q_KEY_CODE_UNMAPPED, /* qnum:136 -> linux:176 (KEY_EDIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x89] = Q_KEY_CODE_UNMAPPED, /* qnum:137 -> linux:181 (KEY_NEW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x8a] = Q_KEY_CODE_UNMAPPED, /* qnum:138 -> linux:182 (KEY_REDO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x8b] = Q_KEY_CODE_UNMAPPED, /* qnum:139 -> linux:120 (KEY_SCALE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x8c] = Q_KEY_CODE_FRONT, /* qnum:140 -> linux:132 (KEY_FRONT) -> qcode:Q_KEY_CODE_FRONT (front) */
+  [0x8d] = Q_KEY_CODE_UNMAPPED, /* qnum:141 -> linux:123 (KEY_HANJA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x8e] = Q_KEY_CODE_UNMAPPED, /* qnum:142 -> linux:233 (KEY_FORWARDMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x8f] = Q_KEY_CODE_UNMAPPED, /* qnum:143 -> linux:178 (KEY_SCROLLDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x90] = Q_KEY_CODE_AUDIOPREV, /* qnum:144 -> linux:165 (KEY_PREVIOUSSONG) -> qcode:Q_KEY_CODE_AUDIOPREV (audioprev) */
+  [0x92] = Q_KEY_CODE_UNMAPPED, /* qnum:146 -> linux:152 (KEY_SCREENLOCK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x93] = Q_KEY_CODE_UNMAPPED, /* qnum:147 -> linux:147 (KEY_XFER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x94] = Q_KEY_CODE_UNMAPPED, /* qnum:148 -> linux:222 (KEY_ALTERASE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x95] = Q_KEY_CODE_UNMAPPED, /* qnum:149 -> linux:195 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x96] = Q_KEY_CODE_UNMAPPED, /* qnum:150 -> linux:196 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x97] = Q_KEY_CODE_UNMAPPED, /* qnum:151 -> linux:149 (KEY_PROG2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x98] = Q_KEY_CODE_UNMAPPED, /* qnum:152 -> linux:168 (KEY_REWIND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x99] = Q_KEY_CODE_AUDIONEXT, /* qnum:153 -> linux:163 (KEY_NEXTSONG) -> qcode:Q_KEY_CODE_AUDIONEXT (audionext) */
+  [0x9a] = Q_KEY_CODE_UNMAPPED, /* qnum:154 -> linux:197 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9b] = Q_KEY_CODE_UNMAPPED, /* qnum:155 -> linux:198 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9c] = Q_KEY_CODE_KP_ENTER, /* qnum:156 -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0x9d] = Q_KEY_CODE_CTRL_R, /* qnum:157 -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0x9e] = Q_KEY_CODE_MENU, /* qnum:158 -> linux:139 (KEY_MENU) -> qcode:Q_KEY_CODE_MENU (menu) */
+  [0x9f] = Q_KEY_CODE_UNMAPPED, /* qnum:159 -> linux:148 (KEY_PROG1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa0] = Q_KEY_CODE_AUDIOMUTE, /* qnum:160 -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0xa1] = Q_KEY_CODE_CALCULATOR, /* qnum:161 -> linux:140 (KEY_CALC) -> qcode:Q_KEY_CODE_CALCULATOR (calculator) */
+  [0xa2] = Q_KEY_CODE_AUDIOPLAY, /* qnum:162 -> linux:164 (KEY_PLAYPAUSE) -> qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) */
+  [0xa3] = Q_KEY_CODE_UNMAPPED, /* qnum:163 -> linux:160 (KEY_CLOSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa4] = Q_KEY_CODE_AUDIOSTOP, /* qnum:164 -> linux:166 (KEY_STOPCD) -> qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) */
+  [0xa5] = Q_KEY_CODE_UNMAPPED, /* qnum:165 -> linux:205 (KEY_SUSPEND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa6] = Q_KEY_CODE_UNMAPPED, /* qnum:166 -> linux:154 (KEY_CYCLEWINDOWS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa7] = Q_KEY_CODE_UNMAPPED, /* qnum:167 -> linux:199 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa8] = Q_KEY_CODE_UNMAPPED, /* qnum:168 -> linux:200 (KEY_PLAYCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa9] = Q_KEY_CODE_UNMAPPED, /* qnum:169 -> linux:201 (KEY_PAUSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xab] = Q_KEY_CODE_UNMAPPED, /* qnum:171 -> linux:202 (KEY_PROG3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xac] = Q_KEY_CODE_UNMAPPED, /* qnum:172 -> linux:203 (KEY_PROG4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xad] = Q_KEY_CODE_UNMAPPED, /* qnum:173 -> linux:204 (KEY_DASHBOARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xae] = Q_KEY_CODE_VOLUMEDOWN, /* qnum:174 -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0xaf] = Q_KEY_CODE_UNMAPPED, /* qnum:175 -> linux:206 (KEY_CLOSE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb0] = Q_KEY_CODE_VOLUMEUP, /* qnum:176 -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0xb1] = Q_KEY_CODE_UNMAPPED, /* qnum:177 -> linux:167 (KEY_RECORD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb2] = Q_KEY_CODE_AC_HOME, /* qnum:178 -> linux:172 (KEY_HOMEPAGE) -> qcode:Q_KEY_CODE_AC_HOME (ac_home) */
+  [0xb3] = Q_KEY_CODE_UNMAPPED, /* qnum:179 -> linux:207 (KEY_PLAY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb4] = Q_KEY_CODE_UNMAPPED, /* qnum:180 -> linux:208 (KEY_FASTFORWARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb5] = Q_KEY_CODE_KP_DIVIDE, /* qnum:181 -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0xb6] = Q_KEY_CODE_UNMAPPED, /* qnum:182 -> linux:209 (KEY_BASSBOOST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb8] = Q_KEY_CODE_ALT_R, /* qnum:184 -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0xb9] = Q_KEY_CODE_UNMAPPED, /* qnum:185 -> linux:210 (KEY_PRINT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xba] = Q_KEY_CODE_UNMAPPED, /* qnum:186 -> linux:211 (KEY_HP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbb] = Q_KEY_CODE_UNMAPPED, /* qnum:187 -> linux:212 (KEY_CAMERA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbc] = Q_KEY_CODE_CUT, /* qnum:188 -> linux:137 (KEY_CUT) -> qcode:Q_KEY_CODE_CUT (cut) */
+  [0xbd] = Q_KEY_CODE_UNMAPPED, /* qnum:189 -> linux:213 (KEY_SOUND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbe] = Q_KEY_CODE_UNMAPPED, /* qnum:190 -> linux:214 (KEY_QUESTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbf] = Q_KEY_CODE_UNMAPPED, /* qnum:191 -> linux:215 (KEY_EMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc0] = Q_KEY_CODE_UNMAPPED, /* qnum:192 -> linux:216 (KEY_CHAT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc1] = Q_KEY_CODE_FIND, /* qnum:193 -> linux:136 (KEY_FIND) -> qcode:Q_KEY_CODE_FIND (find) */
+  [0xc2] = Q_KEY_CODE_UNMAPPED, /* qnum:194 -> linux:218 (KEY_CONNECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc3] = Q_KEY_CODE_UNMAPPED, /* qnum:195 -> linux:219 (KEY_FINANCE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc4] = Q_KEY_CODE_UNMAPPED, /* qnum:196 -> linux:220 (KEY_SPORT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc5] = Q_KEY_CODE_UNMAPPED, /* qnum:197 -> linux:221 (KEY_SHOP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc6] = Q_KEY_CODE_PAUSE, /* qnum:198 -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0xc7] = Q_KEY_CODE_HOME, /* qnum:199 -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0xc8] = Q_KEY_CODE_UP, /* qnum:200 -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0xc9] = Q_KEY_CODE_PGUP, /* qnum:201 -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0xca] = Q_KEY_CODE_UNMAPPED, /* qnum:202 -> linux:223 (KEY_CANCEL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcb] = Q_KEY_CODE_LEFT, /* qnum:203 -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0xcc] = Q_KEY_CODE_UNMAPPED, /* qnum:204 -> linux:224 (KEY_BRIGHTNESSDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcd] = Q_KEY_CODE_RIGHT, /* qnum:205 -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0xce] = Q_KEY_CODE_UNMAPPED, /* qnum:206 -> linux:118 (KEY_KPPLUSMINUS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcf] = Q_KEY_CODE_END, /* qnum:207 -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0xd0] = Q_KEY_CODE_DOWN, /* qnum:208 -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0xd1] = Q_KEY_CODE_PGDN, /* qnum:209 -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0xd2] = Q_KEY_CODE_INSERT, /* qnum:210 -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0xd3] = Q_KEY_CODE_DELETE, /* qnum:211 -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0xd4] = Q_KEY_CODE_UNMAPPED, /* qnum:212 -> linux:225 (KEY_BRIGHTNESSUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd5] = Q_KEY_CODE_UNMAPPED, /* qnum:213 -> linux:234 (KEY_SAVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd6] = Q_KEY_CODE_UNMAPPED, /* qnum:214 -> linux:227 (KEY_SWITCHVIDEOMODE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd7] = Q_KEY_CODE_UNMAPPED, /* qnum:215 -> linux:228 (KEY_KBDILLUMTOGGLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd8] = Q_KEY_CODE_UNMAPPED, /* qnum:216 -> linux:229 (KEY_KBDILLUMDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd9] = Q_KEY_CODE_UNMAPPED, /* qnum:217 -> linux:230 (KEY_KBDILLUMUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xda] = Q_KEY_CODE_UNMAPPED, /* qnum:218 -> linux:231 (KEY_SEND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdb] = Q_KEY_CODE_META_L, /* qnum:219 -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0xdc] = Q_KEY_CODE_META_R, /* qnum:220 -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0xdd] = Q_KEY_CODE_COMPOSE, /* qnum:221 -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0xde] = Q_KEY_CODE_POWER, /* qnum:222 -> linux:116 (KEY_POWER) -> qcode:Q_KEY_CODE_POWER (power) */
+  [0xdf] = Q_KEY_CODE_SLEEP, /* qnum:223 -> linux:142 (KEY_SLEEP) -> qcode:Q_KEY_CODE_SLEEP (sleep) */
+  [0xe3] = Q_KEY_CODE_WAKE, /* qnum:227 -> linux:143 (KEY_WAKEUP) -> qcode:Q_KEY_CODE_WAKE (wake) */
+  [0xe4] = Q_KEY_CODE_UNMAPPED, /* qnum:228 -> linux:232 (KEY_REPLY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe5] = Q_KEY_CODE_UNMAPPED, /* qnum:229 -> linux:217 (KEY_SEARCH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe6] = Q_KEY_CODE_AC_BOOKMARKS, /* qnum:230 -> linux:156 (KEY_BOOKMARKS) -> qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) */
+  [0xe7] = Q_KEY_CODE_AC_REFRESH, /* qnum:231 -> linux:173 (KEY_REFRESH) -> qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) */
+  [0xe8] = Q_KEY_CODE_STOP, /* qnum:232 -> linux:128 (KEY_STOP) -> qcode:Q_KEY_CODE_STOP (stop) */
+  [0xe9] = Q_KEY_CODE_AC_FORWARD, /* qnum:233 -> linux:159 (KEY_FORWARD) -> qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) */
+  [0xea] = Q_KEY_CODE_AC_BACK, /* qnum:234 -> linux:158 (KEY_BACK) -> qcode:Q_KEY_CODE_AC_BACK (ac_back) */
+  [0xeb] = Q_KEY_CODE_COMPUTER, /* qnum:235 -> linux:157 (KEY_COMPUTER) -> qcode:Q_KEY_CODE_COMPUTER (computer) */
+  [0xec] = Q_KEY_CODE_MAIL, /* qnum:236 -> linux:155 (KEY_MAIL) -> qcode:Q_KEY_CODE_MAIL (mail) */
+  [0xed] = Q_KEY_CODE_MEDIASELECT, /* qnum:237 -> linux:226 (KEY_MEDIA) -> qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) */
+  [0xef] = Q_KEY_CODE_UNMAPPED, /* qnum:239 -> linux:112 (KEY_MACRO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf0] = Q_KEY_CODE_UNMAPPED, /* qnum:240 -> linux:235 (KEY_DOCUMENTS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf1] = Q_KEY_CODE_UNMAPPED, /* qnum:241 -> linux:236 (KEY_BATTERY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf2] = Q_KEY_CODE_UNMAPPED, /* qnum:242 -> linux:237 (KEY_BLUETOOTH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf3] = Q_KEY_CODE_UNMAPPED, /* qnum:243 -> linux:238 (KEY_WLAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf4] = Q_KEY_CODE_UNMAPPED, /* qnum:244 -> linux:239 (KEY_UWB) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf5] = Q_KEY_CODE_HELP, /* qnum:245 -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0xf6] = Q_KEY_CODE_UNMAPPED, /* qnum:246 -> linux:179 (KEY_KPLEFTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf7] = Q_KEY_CODE_UNMAPPED, /* qnum:247 -> linux:188 (KEY_F18) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf8] = Q_KEY_CODE_COPY, /* qnum:248 -> linux:133 (KEY_COPY) -> qcode:Q_KEY_CODE_COPY (copy) */
+  [0xf9] = Q_KEY_CODE_UNMAPPED, /* qnum:249 -> linux:192 (KEY_F22) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfb] = Q_KEY_CODE_UNMAPPED, /* qnum:251 -> linux:180 (KEY_KPRIGHTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfd] = Q_KEY_CODE_UNMAPPED, /* qnum:253 -> linux:162 (KEY_EJECTCLOSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+};
+const guint qemu_input_map_qnum_to_qcode_len = sizeof(qemu_input_map_qnum_to_qcode)/sizeof(qemu_input_map_qnum_to_qcode[0]);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index cf979c2ce9..3a19a169f5 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -5,333 +5,37 @@
 
 #include "standard-headers/linux/input.h"
 
-static int linux_to_qcode[KEY_CNT] = {
-    [KEY_ESC]            = Q_KEY_CODE_ESC,
-    [KEY_1]              = Q_KEY_CODE_1,
-    [KEY_2]              = Q_KEY_CODE_2,
-    [KEY_3]              = Q_KEY_CODE_3,
-    [KEY_4]              = Q_KEY_CODE_4,
-    [KEY_5]              = Q_KEY_CODE_5,
-    [KEY_6]              = Q_KEY_CODE_6,
-    [KEY_7]              = Q_KEY_CODE_7,
-    [KEY_8]              = Q_KEY_CODE_8,
-    [KEY_9]              = Q_KEY_CODE_9,
-    [KEY_0]              = Q_KEY_CODE_0,
-    [KEY_MINUS]          = Q_KEY_CODE_MINUS,
-    [KEY_EQUAL]          = Q_KEY_CODE_EQUAL,
-    [KEY_BACKSPACE]      = Q_KEY_CODE_BACKSPACE,
-    [KEY_TAB]            = Q_KEY_CODE_TAB,
-    [KEY_Q]              = Q_KEY_CODE_Q,
-    [KEY_W]              = Q_KEY_CODE_W,
-    [KEY_E]              = Q_KEY_CODE_E,
-    [KEY_R]              = Q_KEY_CODE_R,
-    [KEY_T]              = Q_KEY_CODE_T,
-    [KEY_Y]              = Q_KEY_CODE_Y,
-    [KEY_U]              = Q_KEY_CODE_U,
-    [KEY_I]              = Q_KEY_CODE_I,
-    [KEY_O]              = Q_KEY_CODE_O,
-    [KEY_P]              = Q_KEY_CODE_P,
-    [KEY_LEFTBRACE]      = Q_KEY_CODE_BRACKET_LEFT,
-    [KEY_RIGHTBRACE]     = Q_KEY_CODE_BRACKET_RIGHT,
-    [KEY_ENTER]          = Q_KEY_CODE_RET,
-    [KEY_LEFTCTRL]       = Q_KEY_CODE_CTRL,
-    [KEY_A]              = Q_KEY_CODE_A,
-    [KEY_S]              = Q_KEY_CODE_S,
-    [KEY_D]              = Q_KEY_CODE_D,
-    [KEY_F]              = Q_KEY_CODE_F,
-    [KEY_G]              = Q_KEY_CODE_G,
-    [KEY_H]              = Q_KEY_CODE_H,
-    [KEY_J]              = Q_KEY_CODE_J,
-    [KEY_K]              = Q_KEY_CODE_K,
-    [KEY_L]              = Q_KEY_CODE_L,
-    [KEY_SEMICOLON]      = Q_KEY_CODE_SEMICOLON,
-    [KEY_APOSTROPHE]     = Q_KEY_CODE_APOSTROPHE,
-    [KEY_GRAVE]          = Q_KEY_CODE_GRAVE_ACCENT,
-    [KEY_LEFTSHIFT]      = Q_KEY_CODE_SHIFT,
-    [KEY_BACKSLASH]      = Q_KEY_CODE_BACKSLASH,
-    [KEY_102ND]          = Q_KEY_CODE_LESS,
-    [KEY_Z]              = Q_KEY_CODE_Z,
-    [KEY_X]              = Q_KEY_CODE_X,
-    [KEY_C]              = Q_KEY_CODE_C,
-    [KEY_V]              = Q_KEY_CODE_V,
-    [KEY_B]              = Q_KEY_CODE_B,
-    [KEY_N]              = Q_KEY_CODE_N,
-    [KEY_M]              = Q_KEY_CODE_M,
-    [KEY_COMMA]          = Q_KEY_CODE_COMMA,
-    [KEY_DOT]            = Q_KEY_CODE_DOT,
-    [KEY_SLASH]          = Q_KEY_CODE_SLASH,
-    [KEY_RIGHTSHIFT]     = Q_KEY_CODE_SHIFT_R,
-    [KEY_LEFTALT]        = Q_KEY_CODE_ALT,
-    [KEY_SPACE]          = Q_KEY_CODE_SPC,
-    [KEY_CAPSLOCK]       = Q_KEY_CODE_CAPS_LOCK,
-    [KEY_F1]             = Q_KEY_CODE_F1,
-    [KEY_F2]             = Q_KEY_CODE_F2,
-    [KEY_F3]             = Q_KEY_CODE_F3,
-    [KEY_F4]             = Q_KEY_CODE_F4,
-    [KEY_F5]             = Q_KEY_CODE_F5,
-    [KEY_F6]             = Q_KEY_CODE_F6,
-    [KEY_F7]             = Q_KEY_CODE_F7,
-    [KEY_F8]             = Q_KEY_CODE_F8,
-    [KEY_F9]             = Q_KEY_CODE_F9,
-    [KEY_F10]            = Q_KEY_CODE_F10,
-    [KEY_NUMLOCK]        = Q_KEY_CODE_NUM_LOCK,
-    [KEY_SCROLLLOCK]     = Q_KEY_CODE_SCROLL_LOCK,
-    [KEY_KP0]            = Q_KEY_CODE_KP_0,
-    [KEY_KP1]            = Q_KEY_CODE_KP_1,
-    [KEY_KP2]            = Q_KEY_CODE_KP_2,
-    [KEY_KP3]            = Q_KEY_CODE_KP_3,
-    [KEY_KP4]            = Q_KEY_CODE_KP_4,
-    [KEY_KP5]            = Q_KEY_CODE_KP_5,
-    [KEY_KP6]            = Q_KEY_CODE_KP_6,
-    [KEY_KP7]            = Q_KEY_CODE_KP_7,
-    [KEY_KP8]            = Q_KEY_CODE_KP_8,
-    [KEY_KP9]            = Q_KEY_CODE_KP_9,
-    [KEY_KPMINUS]        = Q_KEY_CODE_KP_SUBTRACT,
-    [KEY_KPPLUS]         = Q_KEY_CODE_KP_ADD,
-    [KEY_KPDOT]          = Q_KEY_CODE_KP_DECIMAL,
-    [KEY_KPENTER]        = Q_KEY_CODE_KP_ENTER,
-    [KEY_KPSLASH]        = Q_KEY_CODE_KP_DIVIDE,
-    [KEY_KPASTERISK]     = Q_KEY_CODE_KP_MULTIPLY,
-    [KEY_F11]            = Q_KEY_CODE_F11,
-    [KEY_F12]            = Q_KEY_CODE_F12,
-    [KEY_RO]             = Q_KEY_CODE_RO,
-    [KEY_HIRAGANA]       = Q_KEY_CODE_HIRAGANA,
-    [KEY_HENKAN]         = Q_KEY_CODE_HENKAN,
-    [KEY_RIGHTCTRL]      = Q_KEY_CODE_CTRL_R,
-    [KEY_SYSRQ]          = Q_KEY_CODE_SYSRQ,
-    [KEY_RIGHTALT]       = Q_KEY_CODE_ALT_R,
-    [KEY_HOME]           = Q_KEY_CODE_HOME,
-    [KEY_UP]             = Q_KEY_CODE_UP,
-    [KEY_PAGEUP]         = Q_KEY_CODE_PGUP,
-    [KEY_LEFT]           = Q_KEY_CODE_LEFT,
-    [KEY_RIGHT]          = Q_KEY_CODE_RIGHT,
-    [KEY_END]            = Q_KEY_CODE_END,
-    [KEY_DOWN]           = Q_KEY_CODE_DOWN,
-    [KEY_PAGEDOWN]       = Q_KEY_CODE_PGDN,
-    [KEY_INSERT]         = Q_KEY_CODE_INSERT,
-    [KEY_DELETE]         = Q_KEY_CODE_DELETE,
-    [KEY_POWER]          = Q_KEY_CODE_POWER,
-    [KEY_KPCOMMA]        = Q_KEY_CODE_KP_COMMA,
-    [KEY_YEN]            = Q_KEY_CODE_YEN,
-    [KEY_LEFTMETA]       = Q_KEY_CODE_META_L,
-    [KEY_RIGHTMETA]      = Q_KEY_CODE_META_R,
-    [KEY_MENU]           = Q_KEY_CODE_MENU,
-    [KEY_PAUSE]          = Q_KEY_CODE_PAUSE,
-
-    [KEY_SLEEP]          = Q_KEY_CODE_SLEEP,
-    [KEY_WAKEUP]         = Q_KEY_CODE_WAKE,
-    [KEY_CALC]           = Q_KEY_CODE_CALCULATOR,
-    [KEY_MAIL]           = Q_KEY_CODE_MAIL,
-    [KEY_COMPUTER]       = Q_KEY_CODE_COMPUTER,
-
-    [KEY_STOP]           = Q_KEY_CODE_STOP,
-    [KEY_BOOKMARKS]      = Q_KEY_CODE_AC_BOOKMARKS,
-    [KEY_BACK]           = Q_KEY_CODE_AC_BACK,
-    [KEY_FORWARD]        = Q_KEY_CODE_AC_FORWARD,
-    [KEY_HOMEPAGE]       = Q_KEY_CODE_AC_HOME,
-    [KEY_REFRESH]        = Q_KEY_CODE_AC_REFRESH,
-    [KEY_FIND]           = Q_KEY_CODE_FIND,
-
-    [KEY_NEXTSONG]       = Q_KEY_CODE_AUDIONEXT,
-    [KEY_PREVIOUSSONG]   = Q_KEY_CODE_AUDIOPREV,
-    [KEY_STOPCD]         = Q_KEY_CODE_AUDIOSTOP,
-    [KEY_PLAYCD]         = Q_KEY_CODE_AUDIOPLAY,
-    [KEY_MUTE]           = Q_KEY_CODE_AUDIOMUTE,
-    [KEY_VOLUMEDOWN]     = Q_KEY_CODE_VOLUMEDOWN,
-    [KEY_VOLUMEUP]       = Q_KEY_CODE_VOLUMEUP,
-};
-
-static const int qcode_to_number[] = {
-    [Q_KEY_CODE_SHIFT] = 0x2a,
-    [Q_KEY_CODE_SHIFT_R] = 0x36,
-
-    [Q_KEY_CODE_ALT] = 0x38,
-    [Q_KEY_CODE_ALT_R] = 0xb8,
-    [Q_KEY_CODE_CTRL] = 0x1d,
-    [Q_KEY_CODE_CTRL_R] = 0x9d,
-
-    [Q_KEY_CODE_META_L] = 0xdb,
-    [Q_KEY_CODE_META_R] = 0xdc,
-    [Q_KEY_CODE_MENU] = 0xdd,
-
-    [Q_KEY_CODE_ESC] = 0x01,
-
-    [Q_KEY_CODE_1] = 0x02,
-    [Q_KEY_CODE_2] = 0x03,
-    [Q_KEY_CODE_3] = 0x04,
-    [Q_KEY_CODE_4] = 0x05,
-    [Q_KEY_CODE_5] = 0x06,
-    [Q_KEY_CODE_6] = 0x07,
-    [Q_KEY_CODE_7] = 0x08,
-    [Q_KEY_CODE_8] = 0x09,
-    [Q_KEY_CODE_9] = 0x0a,
-    [Q_KEY_CODE_0] = 0x0b,
-    [Q_KEY_CODE_MINUS] = 0x0c,
-    [Q_KEY_CODE_EQUAL] = 0x0d,
-    [Q_KEY_CODE_BACKSPACE] = 0x0e,
-
-    [Q_KEY_CODE_TAB] = 0x0f,
-    [Q_KEY_CODE_Q] = 0x10,
-    [Q_KEY_CODE_W] = 0x11,
-    [Q_KEY_CODE_E] = 0x12,
-    [Q_KEY_CODE_R] = 0x13,
-    [Q_KEY_CODE_T] = 0x14,
-    [Q_KEY_CODE_Y] = 0x15,
-    [Q_KEY_CODE_U] = 0x16,
-    [Q_KEY_CODE_I] = 0x17,
-    [Q_KEY_CODE_O] = 0x18,
-    [Q_KEY_CODE_P] = 0x19,
-    [Q_KEY_CODE_BRACKET_LEFT] = 0x1a,
-    [Q_KEY_CODE_BRACKET_RIGHT] = 0x1b,
-    [Q_KEY_CODE_RET] = 0x1c,
-
-    [Q_KEY_CODE_A] = 0x1e,
-    [Q_KEY_CODE_S] = 0x1f,
-    [Q_KEY_CODE_D] = 0x20,
-    [Q_KEY_CODE_F] = 0x21,
-    [Q_KEY_CODE_G] = 0x22,
-    [Q_KEY_CODE_H] = 0x23,
-    [Q_KEY_CODE_J] = 0x24,
-    [Q_KEY_CODE_K] = 0x25,
-    [Q_KEY_CODE_L] = 0x26,
-    [Q_KEY_CODE_SEMICOLON] = 0x27,
-    [Q_KEY_CODE_APOSTROPHE] = 0x28,
-    [Q_KEY_CODE_GRAVE_ACCENT] = 0x29,
-
-    [Q_KEY_CODE_BACKSLASH] = 0x2b,
-    [Q_KEY_CODE_Z] = 0x2c,
-    [Q_KEY_CODE_X] = 0x2d,
-    [Q_KEY_CODE_C] = 0x2e,
-    [Q_KEY_CODE_V] = 0x2f,
-    [Q_KEY_CODE_B] = 0x30,
-    [Q_KEY_CODE_N] = 0x31,
-    [Q_KEY_CODE_M] = 0x32,
-    [Q_KEY_CODE_COMMA] = 0x33,
-    [Q_KEY_CODE_DOT] = 0x34,
-    [Q_KEY_CODE_SLASH] = 0x35,
-
-    [Q_KEY_CODE_ASTERISK] = 0x37,
-
-    [Q_KEY_CODE_SPC] = 0x39,
-    [Q_KEY_CODE_CAPS_LOCK] = 0x3a,
-    [Q_KEY_CODE_F1] = 0x3b,
-    [Q_KEY_CODE_F2] = 0x3c,
-    [Q_KEY_CODE_F3] = 0x3d,
-    [Q_KEY_CODE_F4] = 0x3e,
-    [Q_KEY_CODE_F5] = 0x3f,
-    [Q_KEY_CODE_F6] = 0x40,
-    [Q_KEY_CODE_F7] = 0x41,
-    [Q_KEY_CODE_F8] = 0x42,
-    [Q_KEY_CODE_F9] = 0x43,
-    [Q_KEY_CODE_F10] = 0x44,
-    [Q_KEY_CODE_NUM_LOCK] = 0x45,
-    [Q_KEY_CODE_SCROLL_LOCK] = 0x46,
-
-    [Q_KEY_CODE_KP_DIVIDE] = 0xb5,
-    [Q_KEY_CODE_KP_MULTIPLY] = 0x37,
-    [Q_KEY_CODE_KP_SUBTRACT] = 0x4a,
-    [Q_KEY_CODE_KP_ADD] = 0x4e,
-    [Q_KEY_CODE_KP_ENTER] = 0x9c,
-    [Q_KEY_CODE_KP_DECIMAL] = 0x53,
-    [Q_KEY_CODE_SYSRQ] = 0x54,
-    [Q_KEY_CODE_PAUSE] = 0xc6,
-
-    [Q_KEY_CODE_KP_0] = 0x52,
-    [Q_KEY_CODE_KP_1] = 0x4f,
-    [Q_KEY_CODE_KP_2] = 0x50,
-    [Q_KEY_CODE_KP_3] = 0x51,
-    [Q_KEY_CODE_KP_4] = 0x4b,
-    [Q_KEY_CODE_KP_5] = 0x4c,
-    [Q_KEY_CODE_KP_6] = 0x4d,
-    [Q_KEY_CODE_KP_7] = 0x47,
-    [Q_KEY_CODE_KP_8] = 0x48,
-    [Q_KEY_CODE_KP_9] = 0x49,
-
-    [Q_KEY_CODE_LESS] = 0x56,
-
-    [Q_KEY_CODE_F11] = 0x57,
-    [Q_KEY_CODE_F12] = 0x58,
-
-    [Q_KEY_CODE_PRINT] = 0xb7,
-
-    [Q_KEY_CODE_HOME] = 0xc7,
-    [Q_KEY_CODE_PGUP] = 0xc9,
-    [Q_KEY_CODE_PGDN] = 0xd1,
-    [Q_KEY_CODE_END] = 0xcf,
-
-    [Q_KEY_CODE_LEFT] = 0xcb,
-    [Q_KEY_CODE_UP] = 0xc8,
-    [Q_KEY_CODE_DOWN] = 0xd0,
-    [Q_KEY_CODE_RIGHT] = 0xcd,
-
-    [Q_KEY_CODE_INSERT] = 0xd2,
-    [Q_KEY_CODE_DELETE] = 0xd3,
-
-    [Q_KEY_CODE_RO] = 0x73,
-    [Q_KEY_CODE_HIRAGANA] = 0x70,
-    [Q_KEY_CODE_HENKAN] = 0x79,
-    [Q_KEY_CODE_POWER] = 0xde,
-    [Q_KEY_CODE_YEN] = 0x7d,
-    [Q_KEY_CODE_KP_COMMA] = 0x7e,
-
-    [Q_KEY_CODE_SLEEP] = 0xdf,
-    [Q_KEY_CODE_WAKE] = 0xe3,
-    [Q_KEY_CODE_CALCULATOR] = 0xa1,
-    [Q_KEY_CODE_MAIL] = 0xec,
-    [Q_KEY_CODE_COMPUTER] = 0xeb,
-
-    [Q_KEY_CODE_STOP] = 0xe8,
-    [Q_KEY_CODE_AC_BOOKMARKS] = 0xe6,
-    [Q_KEY_CODE_AC_BACK] = 0xea,
-    [Q_KEY_CODE_AC_FORWARD] = 0xe9,
-    [Q_KEY_CODE_AC_HOME] = 0xb2,
-    [Q_KEY_CODE_AC_REFRESH] = 0xe7,
-    [Q_KEY_CODE_FIND] = 0xe5,
-
-    [Q_KEY_CODE_AUDIONEXT] = 0x99,
-    [Q_KEY_CODE_AUDIOPREV] = 0x90,
-    [Q_KEY_CODE_AUDIOSTOP] = 0xa4,
-    [Q_KEY_CODE_AUDIOPLAY] = 0xa2,
-    [Q_KEY_CODE_AUDIOMUTE] = 0xa0,
-    [Q_KEY_CODE_VOLUMEDOWN] = 0xae,
-    [Q_KEY_CODE_VOLUMEUP] = 0xb0,
-
-    [Q_KEY_CODE__MAX] = 0,
-};
-
-static int number_to_qcode[0x100];
+#include "ui/input-keymap-linux-to-qcode.c"
+#include "ui/input-keymap-qcode-to-qnum.c"
+#include "ui/input-keymap-qnum-to-qcode.c"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
-    assert(lnx < KEY_CNT);
-    return linux_to_qcode[lnx];
+    if (lnx >= qemu_input_map_linux_to_qcode_len) {
+        return 0;
+    }
+    return qemu_input_map_linux_to_qcode[lnx];
 }
 
 int qemu_input_key_value_to_number(const KeyValue *value)
 {
     if (value->type == KEY_VALUE_KIND_QCODE) {
-        return qcode_to_number[value->u.qcode.data];
+        if (value->u.qcode.data >= qemu_input_map_qcode_to_qnum_len) {
+            return 0;
+        }
+        return qemu_input_map_qcode_to_qnum[value->u.qcode.data];
     } else {
         assert(value->type == KEY_VALUE_KIND_NUMBER);
         return value->u.number.data;
     }
 }
 
-int qemu_input_key_number_to_qcode(uint8_t nr)
+int qemu_input_key_number_to_qcode(unsigned int nr)
 {
-    static int first = true;
-
-    if (first) {
-        int qcode, number;
-        first = false;
-        for (qcode = 0; qcode < Q_KEY_CODE__MAX; qcode++) {
-            number = qcode_to_number[qcode];
-            assert(number < ARRAY_SIZE(number_to_qcode));
-            number_to_qcode[number] = qcode;
-        }
+    if (nr >= qemu_input_map_qnum_to_qcode_len) {
+        return 0;
     }
-
-    return number_to_qcode[nr];
+    return qemu_input_map_qnum_to_qcode[nr];
 }
 
 int qemu_input_key_value_to_qcode(const KeyValue *value)
-- 
2.13.5
