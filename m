Received: from eggs.gnu.org ([2001:4830:134:3::10]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS9-0000ns-Vs
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS6-0003UP-8E
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkS5-0003Tr-Tg
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9B0234C2
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:38:04 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 13:37:42 +0100
Message-Id: <20170912123744.14730-11-berrange@redhat.com>
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/12] ui: convert the SDL2 frontend to
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

The SDL2 scancodes are conveniently identical to the USB
scancodes. Replace the sdl2_scancode_to_qcode table with
an automatically generated table.

Missing entries in sdl2_scancode_to_qcode now fixed:

  - 0x32 -> Q_KEY_CODE_BACKSLASH
  - 0x66 -> Q_KEY_CODE_POWER
  - 0x67 -> Q_KEY_CODE_KP_EQUALS
  - 0x74 -> Q_KEY_CODE_OPEN
  - 0x77 -> Q_KEY_CODE_FRONT
  - 0x7f -> Q_KEY_CODE_AUDIOMUTE
  - 0x80 -> Q_KEY_CODE_VOLUMEUP
  - 0x81 -> Q_KEY_CODE_VOLUMEDOWN
  - 0x85 -> Q_KEY_CODE_KP_COMMA
  - 0x87 -> Q_KEY_CODE_RO
  - 0x89 -> Q_KEY_CODE_YEN
  - 0x8a -> Q_KEY_CODE_HENKAN
  - 0x93 -> Q_KEY_CODE_HIRAGANA
  - 0xe8 -> Q_KEY_CODE_AUDIOPLAY
  - 0xe9 -> Q_KEY_CODE_AUDIOSTOP
  - 0xea -> Q_KEY_CODE_AUDIOPREV
  - 0xeb -> Q_KEY_CODE_AUDIONEXT
  - 0xed -> Q_KEY_CODE_VOLUMEUP
  - 0xee -> Q_KEY_CODE_VOLUMEDOWN
  - 0xef -> Q_KEY_CODE_AUDIOMUTE
  - 0xf1 -> Q_KEY_CODE_AC_BACK
  - 0xf2 -> Q_KEY_CODE_AC_FORWARD
  - 0xf3 -> Q_KEY_CODE_STOP
  - 0xf4 -> Q_KEY_CODE_FIND
  - 0xf8 -> Q_KEY_CODE_SLEEP
  - 0xfa -> Q_KEY_CODE_AC_REFRESH
  - 0xfb -> Q_KEY_CODE_CALCULATOR

And some mistakes corrected:

  - 0x65 -> Q_KEY_CODE_COMPOSE, not duplicating Q_KEY_CODE_MENU

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h             |   3 +
 ui/Makefile.objs               |   1 +
 ui/input-keymap-usb-to-qcode.c | 177 +++++++++++++++++++++++++++
 ui/input-keymap.c              |   1 +
 ui/sdl2-input.c                |  16 ++-
 ui/sdl2-keymap.h               | 267 -----------------------------------------
 6 files changed, 193 insertions(+), 272 deletions(-)
 create mode 100644 ui/input-keymap-usb-to-qcode.c
 delete mode 100644 ui/sdl2-keymap.h

diff --git a/include/ui/input.h b/include/ui/input.h
index df3eb439bf..dcf7e0e731 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -98,4 +98,7 @@ extern const guint16 qemu_input_map_qcode_to_sun[];
 extern const guint qemu_input_map_qnum_to_qcode_len;
 extern const guint16 qemu_input_map_qnum_to_qcode[];
 
+extern const guint qemu_input_map_usb_to_qcode_len;
+extern const guint16 qemu_input_map_usb_to_qcode[];
+
 #endif /* INPUT_H */
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 9cf398e5c6..7823e85d7c 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -64,6 +64,7 @@ KEYCODEMAP_FILES = \
 		 ui/input-keymap-qcode-to-qnum.c \
 		 ui/input-keymap-qcode-to-sun.c \
 		 ui/input-keymap-qnum-to-qcode.c \
+		 ui/input-keymap-usb-to-qcode.c \
 		 $(NULL)
 
 # Generated input-keymap-XXX.c files are kept in GIT, so
diff --git a/ui/input-keymap-usb-to-qcode.c b/ui/input-keymap-usb-to-qcode.c
new file mode 100644
index 0000000000..b63c351ec7
--- /dev/null
+++ b/ui/input-keymap-usb-to-qcode.c
@@ -0,0 +1,177 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_usb_to_qcode code-map keymaps.csv usb qcode
+*/
+const guint16 qemu_input_map_usb_to_qcode[252] = {
+  [0x4] = Q_KEY_CODE_A, /* usb:4 -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x5] = Q_KEY_CODE_B, /* usb:5 -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x6] = Q_KEY_CODE_C, /* usb:6 -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x7] = Q_KEY_CODE_D, /* usb:7 -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x8] = Q_KEY_CODE_E, /* usb:8 -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x9] = Q_KEY_CODE_F, /* usb:9 -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0xa] = Q_KEY_CODE_G, /* usb:10 -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0xb] = Q_KEY_CODE_H, /* usb:11 -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0xc] = Q_KEY_CODE_I, /* usb:12 -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0xd] = Q_KEY_CODE_J, /* usb:13 -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0xe] = Q_KEY_CODE_K, /* usb:14 -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0xf] = Q_KEY_CODE_L, /* usb:15 -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x10] = Q_KEY_CODE_M, /* usb:16 -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x11] = Q_KEY_CODE_N, /* usb:17 -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x12] = Q_KEY_CODE_O, /* usb:18 -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x13] = Q_KEY_CODE_P, /* usb:19 -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x14] = Q_KEY_CODE_Q, /* usb:20 -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x15] = Q_KEY_CODE_R, /* usb:21 -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x16] = Q_KEY_CODE_S, /* usb:22 -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x17] = Q_KEY_CODE_T, /* usb:23 -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x18] = Q_KEY_CODE_U, /* usb:24 -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x19] = Q_KEY_CODE_V, /* usb:25 -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x1a] = Q_KEY_CODE_W, /* usb:26 -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x1b] = Q_KEY_CODE_X, /* usb:27 -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x1c] = Q_KEY_CODE_Y, /* usb:28 -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x1d] = Q_KEY_CODE_Z, /* usb:29 -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x1e] = Q_KEY_CODE_1, /* usb:30 -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x1f] = Q_KEY_CODE_2, /* usb:31 -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x20] = Q_KEY_CODE_3, /* usb:32 -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x21] = Q_KEY_CODE_4, /* usb:33 -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x22] = Q_KEY_CODE_5, /* usb:34 -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x23] = Q_KEY_CODE_6, /* usb:35 -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x24] = Q_KEY_CODE_7, /* usb:36 -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x25] = Q_KEY_CODE_8, /* usb:37 -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x26] = Q_KEY_CODE_9, /* usb:38 -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x27] = Q_KEY_CODE_0, /* usb:39 -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x28] = Q_KEY_CODE_RET, /* usb:40 -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x29] = Q_KEY_CODE_ESC, /* usb:41 -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0x2a] = Q_KEY_CODE_BACKSPACE, /* usb:42 -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0x2b] = Q_KEY_CODE_TAB, /* usb:43 -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x2c] = Q_KEY_CODE_SPC, /* usb:44 -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x2d] = Q_KEY_CODE_MINUS, /* usb:45 -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0x2e] = Q_KEY_CODE_EQUAL, /* usb:46 -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0x2f] = Q_KEY_CODE_BRACKET_LEFT, /* usb:47 -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x30] = Q_KEY_CODE_BRACKET_RIGHT, /* usb:48 -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x31] = Q_KEY_CODE_BACKSLASH, /* usb:49 -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x32] = Q_KEY_CODE_BACKSLASH, /* usb:50 -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x33] = Q_KEY_CODE_SEMICOLON, /* usb:51 -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x34] = Q_KEY_CODE_APOSTROPHE, /* usb:52 -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x35] = Q_KEY_CODE_GRAVE_ACCENT, /* usb:53 -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x36] = Q_KEY_CODE_COMMA, /* usb:54 -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x37] = Q_KEY_CODE_DOT, /* usb:55 -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x38] = Q_KEY_CODE_SLASH, /* usb:56 -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x39] = Q_KEY_CODE_CAPS_LOCK, /* usb:57 -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x3a] = Q_KEY_CODE_F1, /* usb:58 -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x3b] = Q_KEY_CODE_F2, /* usb:59 -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x3c] = Q_KEY_CODE_F3, /* usb:60 -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x3d] = Q_KEY_CODE_F4, /* usb:61 -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x3e] = Q_KEY_CODE_F5, /* usb:62 -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x3f] = Q_KEY_CODE_F6, /* usb:63 -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x40] = Q_KEY_CODE_F7, /* usb:64 -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x41] = Q_KEY_CODE_F8, /* usb:65 -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x42] = Q_KEY_CODE_F9, /* usb:66 -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x43] = Q_KEY_CODE_F10, /* usb:67 -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x44] = Q_KEY_CODE_F11, /* usb:68 -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x45] = Q_KEY_CODE_F12, /* usb:69 -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x46] = Q_KEY_CODE_SYSRQ, /* usb:70 -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0x47] = Q_KEY_CODE_SCROLL_LOCK, /* usb:71 -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0x48] = Q_KEY_CODE_PAUSE, /* usb:72 -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0x49] = Q_KEY_CODE_INSERT, /* usb:73 -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0x4a] = Q_KEY_CODE_HOME, /* usb:74 -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0x4b] = Q_KEY_CODE_PGUP, /* usb:75 -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0x4c] = Q_KEY_CODE_DELETE, /* usb:76 -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0x4d] = Q_KEY_CODE_END, /* usb:77 -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0x4e] = Q_KEY_CODE_PGDN, /* usb:78 -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0x4f] = Q_KEY_CODE_RIGHT, /* usb:79 -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0x50] = Q_KEY_CODE_LEFT, /* usb:80 -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0x51] = Q_KEY_CODE_DOWN, /* usb:81 -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0x52] = Q_KEY_CODE_UP, /* usb:82 -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0x53] = Q_KEY_CODE_NUM_LOCK, /* usb:83 -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x54] = Q_KEY_CODE_KP_DIVIDE, /* usb:84 -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0x55] = Q_KEY_CODE_KP_MULTIPLY, /* usb:85 -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x56] = Q_KEY_CODE_KP_SUBTRACT, /* usb:86 -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x57] = Q_KEY_CODE_KP_ADD, /* usb:87 -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x58] = Q_KEY_CODE_KP_ENTER, /* usb:88 -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0x59] = Q_KEY_CODE_KP_1, /* usb:89 -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x5a] = Q_KEY_CODE_KP_2, /* usb:90 -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x5b] = Q_KEY_CODE_KP_3, /* usb:91 -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x5c] = Q_KEY_CODE_KP_4, /* usb:92 -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x5d] = Q_KEY_CODE_KP_5, /* usb:93 -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x5e] = Q_KEY_CODE_KP_6, /* usb:94 -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x5f] = Q_KEY_CODE_KP_7, /* usb:95 -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x60] = Q_KEY_CODE_KP_8, /* usb:96 -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x61] = Q_KEY_CODE_KP_9, /* usb:97 -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x62] = Q_KEY_CODE_KP_0, /* usb:98 -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x63] = Q_KEY_CODE_KP_DECIMAL, /* usb:99 -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x64] = Q_KEY_CODE_LESS, /* usb:100 -> linux:86 (KEY_102ND) -> qcode:Q_KEY_CODE_LESS (less) */
+  [0x65] = Q_KEY_CODE_COMPOSE, /* usb:101 -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0x66] = Q_KEY_CODE_POWER, /* usb:102 -> linux:116 (KEY_POWER) -> qcode:Q_KEY_CODE_POWER (power) */
+  [0x67] = Q_KEY_CODE_KP_EQUALS, /* usb:103 -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x68] = Q_KEY_CODE_UNMAPPED, /* usb:104 -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x69] = Q_KEY_CODE_UNMAPPED, /* usb:105 -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6a] = Q_KEY_CODE_UNMAPPED, /* usb:106 -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6b] = Q_KEY_CODE_UNMAPPED, /* usb:107 -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6c] = Q_KEY_CODE_UNMAPPED, /* usb:108 -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6d] = Q_KEY_CODE_UNMAPPED, /* usb:109 -> linux:188 (KEY_F18) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6e] = Q_KEY_CODE_UNMAPPED, /* usb:110 -> linux:189 (KEY_F19) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6f] = Q_KEY_CODE_UNMAPPED, /* usb:111 -> linux:190 (KEY_F20) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x70] = Q_KEY_CODE_UNMAPPED, /* usb:112 -> linux:191 (KEY_F21) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x71] = Q_KEY_CODE_UNMAPPED, /* usb:113 -> linux:192 (KEY_F22) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x72] = Q_KEY_CODE_UNMAPPED, /* usb:114 -> linux:193 (KEY_F23) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x73] = Q_KEY_CODE_UNMAPPED, /* usb:115 -> linux:194 (KEY_F24) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x74] = Q_KEY_CODE_OPEN, /* usb:116 -> linux:134 (KEY_OPEN) -> qcode:Q_KEY_CODE_OPEN (open) */
+  [0x75] = Q_KEY_CODE_HELP, /* usb:117 -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0x76] = Q_KEY_CODE_MENU, /* usb:118 -> linux:139 (KEY_MENU) -> qcode:Q_KEY_CODE_MENU (menu) */
+  [0x77] = Q_KEY_CODE_FRONT, /* usb:119 -> linux:132 (KEY_FRONT) -> qcode:Q_KEY_CODE_FRONT (front) */
+  [0x78] = Q_KEY_CODE_STOP, /* usb:120 -> linux:128 (KEY_STOP) -> qcode:Q_KEY_CODE_STOP (stop) */
+  [0x79] = Q_KEY_CODE_AGAIN, /* usb:121 -> linux:129 (KEY_AGAIN) -> qcode:Q_KEY_CODE_AGAIN (again) */
+  [0x7a] = Q_KEY_CODE_UNDO, /* usb:122 -> linux:131 (KEY_UNDO) -> qcode:Q_KEY_CODE_UNDO (undo) */
+  [0x7b] = Q_KEY_CODE_CUT, /* usb:123 -> linux:137 (KEY_CUT) -> qcode:Q_KEY_CODE_CUT (cut) */
+  [0x7c] = Q_KEY_CODE_COPY, /* usb:124 -> linux:133 (KEY_COPY) -> qcode:Q_KEY_CODE_COPY (copy) */
+  [0x7d] = Q_KEY_CODE_PASTE, /* usb:125 -> linux:135 (KEY_PASTE) -> qcode:Q_KEY_CODE_PASTE (paste) */
+  [0x7e] = Q_KEY_CODE_FIND, /* usb:126 -> linux:136 (KEY_FIND) -> qcode:Q_KEY_CODE_FIND (find) */
+  [0x7f] = Q_KEY_CODE_AUDIOMUTE, /* usb:127 -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0x80] = Q_KEY_CODE_VOLUMEUP, /* usb:128 -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0x81] = Q_KEY_CODE_VOLUMEDOWN, /* usb:129 -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0x85] = Q_KEY_CODE_KP_COMMA, /* usb:133 -> linux:121 (KEY_KPCOMMA) -> qcode:Q_KEY_CODE_KP_COMMA (kp_comma) */
+  [0x87] = Q_KEY_CODE_RO, /* usb:135 -> linux:89 (KEY_RO) -> qcode:Q_KEY_CODE_RO (ro) */
+  [0x88] = Q_KEY_CODE_UNMAPPED, /* usb:136 -> linux:93 (KEY_KATAKANAHIRAGANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x89] = Q_KEY_CODE_YEN, /* usb:137 -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0x8a] = Q_KEY_CODE_HENKAN, /* usb:138 -> linux:92 (KEY_HENKAN) -> qcode:Q_KEY_CODE_HENKAN (henkan) */
+  [0x8b] = Q_KEY_CODE_UNMAPPED, /* usb:139 -> linux:94 (KEY_MUHENKAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x8c] = Q_KEY_CODE_UNMAPPED, /* usb:140 -> linux:95 (KEY_KPJPCOMMA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x90] = Q_KEY_CODE_UNMAPPED, /* usb:144 -> linux:122 (KEY_HANGEUL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x91] = Q_KEY_CODE_UNMAPPED, /* usb:145 -> linux:123 (KEY_HANJA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x92] = Q_KEY_CODE_UNMAPPED, /* usb:146 -> linux:90 (KEY_KATAKANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x93] = Q_KEY_CODE_HIRAGANA, /* usb:147 -> linux:91 (KEY_HIRAGANA) -> qcode:Q_KEY_CODE_HIRAGANA (hiragana) */
+  [0x94] = Q_KEY_CODE_UNMAPPED, /* usb:148 -> linux:85 (KEY_ZENKAKUHANKAKU) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb6] = Q_KEY_CODE_UNMAPPED, /* usb:182 -> linux:179 (KEY_KPLEFTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb7] = Q_KEY_CODE_UNMAPPED, /* usb:183 -> linux:180 (KEY_KPRIGHTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe0] = Q_KEY_CODE_CTRL, /* usb:224 -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0xe1] = Q_KEY_CODE_SHIFT, /* usb:225 -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0xe2] = Q_KEY_CODE_ALT, /* usb:226 -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0xe3] = Q_KEY_CODE_META_L, /* usb:227 -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0xe4] = Q_KEY_CODE_CTRL_R, /* usb:228 -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0xe5] = Q_KEY_CODE_SHIFT_R, /* usb:229 -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0xe6] = Q_KEY_CODE_ALT_R, /* usb:230 -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0xe7] = Q_KEY_CODE_META_R, /* usb:231 -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0xe8] = Q_KEY_CODE_AUDIOPLAY, /* usb:232 -> linux:164 (KEY_PLAYPAUSE) -> qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) */
+  [0xe9] = Q_KEY_CODE_AUDIOSTOP, /* usb:233 -> linux:166 (KEY_STOPCD) -> qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) */
+  [0xea] = Q_KEY_CODE_AUDIOPREV, /* usb:234 -> linux:165 (KEY_PREVIOUSSONG) -> qcode:Q_KEY_CODE_AUDIOPREV (audioprev) */
+  [0xeb] = Q_KEY_CODE_AUDIONEXT, /* usb:235 -> linux:163 (KEY_NEXTSONG) -> qcode:Q_KEY_CODE_AUDIONEXT (audionext) */
+  [0xec] = Q_KEY_CODE_UNMAPPED, /* usb:236 -> linux:161 (KEY_EJECTCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xed] = Q_KEY_CODE_VOLUMEUP, /* usb:237 -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0xee] = Q_KEY_CODE_VOLUMEDOWN, /* usb:238 -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0xef] = Q_KEY_CODE_AUDIOMUTE, /* usb:239 -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0xf0] = Q_KEY_CODE_UNMAPPED, /* usb:240 -> linux:150 (KEY_WWW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf1] = Q_KEY_CODE_AC_BACK, /* usb:241 -> linux:158 (KEY_BACK) -> qcode:Q_KEY_CODE_AC_BACK (ac_back) */
+  [0xf2] = Q_KEY_CODE_AC_FORWARD, /* usb:242 -> linux:159 (KEY_FORWARD) -> qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) */
+  [0xf3] = Q_KEY_CODE_STOP, /* usb:243 -> linux:128 (KEY_STOP) -> qcode:Q_KEY_CODE_STOP (stop) */
+  [0xf4] = Q_KEY_CODE_FIND, /* usb:244 -> linux:136 (KEY_FIND) -> qcode:Q_KEY_CODE_FIND (find) */
+  [0xf5] = Q_KEY_CODE_UNMAPPED, /* usb:245 -> linux:177 (KEY_SCROLLUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf6] = Q_KEY_CODE_UNMAPPED, /* usb:246 -> linux:178 (KEY_SCROLLDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf7] = Q_KEY_CODE_UNMAPPED, /* usb:247 -> linux:176 (KEY_EDIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf8] = Q_KEY_CODE_SLEEP, /* usb:248 -> linux:142 (KEY_SLEEP) -> qcode:Q_KEY_CODE_SLEEP (sleep) */
+  [0xf9] = Q_KEY_CODE_UNMAPPED, /* usb:249 -> linux:152 (KEY_SCREENLOCK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfa] = Q_KEY_CODE_AC_REFRESH, /* usb:250 -> linux:173 (KEY_REFRESH) -> qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) */
+  [0xfb] = Q_KEY_CODE_CALCULATOR, /* usb:251 -> linux:140 (KEY_CALC) -> qcode:Q_KEY_CODE_CALCULATOR (calculator) */
+};
+const guint qemu_input_map_usb_to_qcode_len = sizeof(qemu_input_map_usb_to_qcode)/sizeof(qemu_input_map_usb_to_qcode[0]);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index de11205dca..ad98b153cf 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -15,6 +15,7 @@
 #include "ui/input-keymap-qcode-to-qnum.c"
 #include "ui/input-keymap-qcode-to-sun.c"
 #include "ui/input-keymap-qnum-to-qcode.c"
+#include "ui/input-keymap-usb-to-qcode.c"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 6e315ae800..605d781971 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -30,8 +30,6 @@
 #include "ui/sdl2.h"
 #include "sysemu/sysemu.h"
 
-#include "sdl2-keymap.h"
-
 static uint8_t modifiers_state[SDL_NUM_SCANCODES];
 
 void sdl2_reset_keys(struct sdl2_console *scon)
@@ -39,9 +37,11 @@ void sdl2_reset_keys(struct sdl2_console *scon)
     QemuConsole *con = scon ? scon->dcl.con : NULL;
     int i;
 
-    for (i = 0; i < SDL_NUM_SCANCODES; i++) {
+    for (i = 0 ;
+         i < SDL_NUM_SCANCODES && i < qemu_input_map_usb_to_qcode_len ;
+         i++) {
         if (modifiers_state[i]) {
-            int qcode = sdl2_scancode_to_qcode[i];
+            int qcode = qemu_input_map_usb_to_qcode[i];
             qemu_input_event_send_key_qcode(con, qcode, false);
             modifiers_state[i] = 0;
         }
@@ -51,9 +51,15 @@ void sdl2_reset_keys(struct sdl2_console *scon)
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev)
 {
-    int qcode = sdl2_scancode_to_qcode[ev->keysym.scancode];
+    int qcode;
     QemuConsole *con = scon ? scon->dcl.con : NULL;
 
+    if (ev->keysym.scancode >= qemu_input_map_usb_to_qcode_len) {
+        return;
+    }
+
+    qcode = qemu_input_map_usb_to_qcode[ev->keysym.scancode];
+
     if (!qemu_console_is_graphic(con)) {
         if (ev->type == SDL_KEYDOWN) {
             switch (ev->keysym.scancode) {
diff --git a/ui/sdl2-keymap.h b/ui/sdl2-keymap.h
deleted file mode 100644
index cbedaa477d..0000000000
--- a/ui/sdl2-keymap.h
+++ /dev/null
@@ -1,267 +0,0 @@
-
-/* map SDL2 scancodes to QKeyCode */
-
-static const int sdl2_scancode_to_qcode[SDL_NUM_SCANCODES] = {
-    [SDL_SCANCODE_A]                 = Q_KEY_CODE_A,
-    [SDL_SCANCODE_B]                 = Q_KEY_CODE_B,
-    [SDL_SCANCODE_C]                 = Q_KEY_CODE_C,
-    [SDL_SCANCODE_D]                 = Q_KEY_CODE_D,
-    [SDL_SCANCODE_E]                 = Q_KEY_CODE_E,
-    [SDL_SCANCODE_F]                 = Q_KEY_CODE_F,
-    [SDL_SCANCODE_G]                 = Q_KEY_CODE_G,
-    [SDL_SCANCODE_H]                 = Q_KEY_CODE_H,
-    [SDL_SCANCODE_I]                 = Q_KEY_CODE_I,
-    [SDL_SCANCODE_J]                 = Q_KEY_CODE_J,
-    [SDL_SCANCODE_K]                 = Q_KEY_CODE_K,
-    [SDL_SCANCODE_L]                 = Q_KEY_CODE_L,
-    [SDL_SCANCODE_M]                 = Q_KEY_CODE_M,
-    [SDL_SCANCODE_N]                 = Q_KEY_CODE_N,
-    [SDL_SCANCODE_O]                 = Q_KEY_CODE_O,
-    [SDL_SCANCODE_P]                 = Q_KEY_CODE_P,
-    [SDL_SCANCODE_Q]                 = Q_KEY_CODE_Q,
-    [SDL_SCANCODE_R]                 = Q_KEY_CODE_R,
-    [SDL_SCANCODE_S]                 = Q_KEY_CODE_S,
-    [SDL_SCANCODE_T]                 = Q_KEY_CODE_T,
-    [SDL_SCANCODE_U]                 = Q_KEY_CODE_U,
-    [SDL_SCANCODE_V]                 = Q_KEY_CODE_V,
-    [SDL_SCANCODE_W]                 = Q_KEY_CODE_W,
-    [SDL_SCANCODE_X]                 = Q_KEY_CODE_X,
-    [SDL_SCANCODE_Y]                 = Q_KEY_CODE_Y,
-    [SDL_SCANCODE_Z]                 = Q_KEY_CODE_Z,
-
-    [SDL_SCANCODE_1]                 = Q_KEY_CODE_1,
-    [SDL_SCANCODE_2]                 = Q_KEY_CODE_2,
-    [SDL_SCANCODE_3]                 = Q_KEY_CODE_3,
-    [SDL_SCANCODE_4]                 = Q_KEY_CODE_4,
-    [SDL_SCANCODE_5]                 = Q_KEY_CODE_5,
-    [SDL_SCANCODE_6]                 = Q_KEY_CODE_6,
-    [SDL_SCANCODE_7]                 = Q_KEY_CODE_7,
-    [SDL_SCANCODE_8]                 = Q_KEY_CODE_8,
-    [SDL_SCANCODE_9]                 = Q_KEY_CODE_9,
-    [SDL_SCANCODE_0]                 = Q_KEY_CODE_0,
-
-    [SDL_SCANCODE_RETURN]            = Q_KEY_CODE_RET,
-    [SDL_SCANCODE_ESCAPE]            = Q_KEY_CODE_ESC,
-    [SDL_SCANCODE_BACKSPACE]         = Q_KEY_CODE_BACKSPACE,
-    [SDL_SCANCODE_TAB]               = Q_KEY_CODE_TAB,
-    [SDL_SCANCODE_SPACE]             = Q_KEY_CODE_SPC,
-    [SDL_SCANCODE_MINUS]             = Q_KEY_CODE_MINUS,
-    [SDL_SCANCODE_EQUALS]            = Q_KEY_CODE_EQUAL,
-    [SDL_SCANCODE_LEFTBRACKET]       = Q_KEY_CODE_BRACKET_LEFT,
-    [SDL_SCANCODE_RIGHTBRACKET]      = Q_KEY_CODE_BRACKET_RIGHT,
-    [SDL_SCANCODE_BACKSLASH]         = Q_KEY_CODE_BACKSLASH,
-#if 0
-    [SDL_SCANCODE_NONUSHASH]         = Q_KEY_CODE_NONUSHASH,
-#endif
-    [SDL_SCANCODE_SEMICOLON]         = Q_KEY_CODE_SEMICOLON,
-    [SDL_SCANCODE_APOSTROPHE]        = Q_KEY_CODE_APOSTROPHE,
-    [SDL_SCANCODE_GRAVE]             = Q_KEY_CODE_GRAVE_ACCENT,
-    [SDL_SCANCODE_COMMA]             = Q_KEY_CODE_COMMA,
-    [SDL_SCANCODE_PERIOD]            = Q_KEY_CODE_DOT,
-    [SDL_SCANCODE_SLASH]             = Q_KEY_CODE_SLASH,
-    [SDL_SCANCODE_CAPSLOCK]          = Q_KEY_CODE_CAPS_LOCK,
-
-    [SDL_SCANCODE_F1]                = Q_KEY_CODE_F1,
-    [SDL_SCANCODE_F2]                = Q_KEY_CODE_F2,
-    [SDL_SCANCODE_F3]                = Q_KEY_CODE_F3,
-    [SDL_SCANCODE_F4]                = Q_KEY_CODE_F4,
-    [SDL_SCANCODE_F5]                = Q_KEY_CODE_F5,
-    [SDL_SCANCODE_F6]                = Q_KEY_CODE_F6,
-    [SDL_SCANCODE_F7]                = Q_KEY_CODE_F7,
-    [SDL_SCANCODE_F8]                = Q_KEY_CODE_F8,
-    [SDL_SCANCODE_F9]                = Q_KEY_CODE_F9,
-    [SDL_SCANCODE_F10]               = Q_KEY_CODE_F10,
-    [SDL_SCANCODE_F11]               = Q_KEY_CODE_F11,
-    [SDL_SCANCODE_F12]               = Q_KEY_CODE_F12,
-
-    [SDL_SCANCODE_PRINTSCREEN]       = Q_KEY_CODE_PRINT,
-    [SDL_SCANCODE_SCROLLLOCK]        = Q_KEY_CODE_SCROLL_LOCK,
-    [SDL_SCANCODE_PAUSE]             = Q_KEY_CODE_PAUSE,
-    [SDL_SCANCODE_INSERT]            = Q_KEY_CODE_INSERT,
-    [SDL_SCANCODE_HOME]              = Q_KEY_CODE_HOME,
-    [SDL_SCANCODE_PAGEUP]            = Q_KEY_CODE_PGUP,
-    [SDL_SCANCODE_DELETE]            = Q_KEY_CODE_DELETE,
-    [SDL_SCANCODE_END]               = Q_KEY_CODE_END,
-    [SDL_SCANCODE_PAGEDOWN]          = Q_KEY_CODE_PGDN,
-    [SDL_SCANCODE_RIGHT]             = Q_KEY_CODE_RIGHT,
-    [SDL_SCANCODE_LEFT]              = Q_KEY_CODE_LEFT,
-    [SDL_SCANCODE_DOWN]              = Q_KEY_CODE_DOWN,
-    [SDL_SCANCODE_UP]                = Q_KEY_CODE_UP,
-    [SDL_SCANCODE_NUMLOCKCLEAR]      = Q_KEY_CODE_NUM_LOCK,
-
-    [SDL_SCANCODE_KP_DIVIDE]         = Q_KEY_CODE_KP_DIVIDE,
-    [SDL_SCANCODE_KP_MULTIPLY]       = Q_KEY_CODE_KP_MULTIPLY,
-    [SDL_SCANCODE_KP_MINUS]          = Q_KEY_CODE_KP_SUBTRACT,
-    [SDL_SCANCODE_KP_PLUS]           = Q_KEY_CODE_KP_ADD,
-    [SDL_SCANCODE_KP_ENTER]          = Q_KEY_CODE_KP_ENTER,
-    [SDL_SCANCODE_KP_1]              = Q_KEY_CODE_KP_1,
-    [SDL_SCANCODE_KP_2]              = Q_KEY_CODE_KP_2,
-    [SDL_SCANCODE_KP_3]              = Q_KEY_CODE_KP_3,
-    [SDL_SCANCODE_KP_4]              = Q_KEY_CODE_KP_4,
-    [SDL_SCANCODE_KP_5]              = Q_KEY_CODE_KP_5,
-    [SDL_SCANCODE_KP_6]              = Q_KEY_CODE_KP_6,
-    [SDL_SCANCODE_KP_7]              = Q_KEY_CODE_KP_7,
-    [SDL_SCANCODE_KP_8]              = Q_KEY_CODE_KP_8,
-    [SDL_SCANCODE_KP_9]              = Q_KEY_CODE_KP_9,
-    [SDL_SCANCODE_KP_0]              = Q_KEY_CODE_KP_0,
-    [SDL_SCANCODE_KP_PERIOD]         = Q_KEY_CODE_KP_DECIMAL,
-
-    [SDL_SCANCODE_NONUSBACKSLASH]    = Q_KEY_CODE_LESS,
-    [SDL_SCANCODE_APPLICATION]       = Q_KEY_CODE_MENU,
-#if 0
-    [SDL_SCANCODE_POWER]             = Q_KEY_CODE_POWER,
-    [SDL_SCANCODE_KP_EQUALS]         = Q_KEY_CODE_KP_EQUALS,
-
-    [SDL_SCANCODE_F13]               = Q_KEY_CODE_F13,
-    [SDL_SCANCODE_F14]               = Q_KEY_CODE_F14,
-    [SDL_SCANCODE_F15]               = Q_KEY_CODE_F15,
-    [SDL_SCANCODE_F16]               = Q_KEY_CODE_F16,
-    [SDL_SCANCODE_F17]               = Q_KEY_CODE_F17,
-    [SDL_SCANCODE_F18]               = Q_KEY_CODE_F18,
-    [SDL_SCANCODE_F19]               = Q_KEY_CODE_F19,
-    [SDL_SCANCODE_F20]               = Q_KEY_CODE_F20,
-    [SDL_SCANCODE_F21]               = Q_KEY_CODE_F21,
-    [SDL_SCANCODE_F22]               = Q_KEY_CODE_F22,
-    [SDL_SCANCODE_F23]               = Q_KEY_CODE_F23,
-    [SDL_SCANCODE_F24]               = Q_KEY_CODE_F24,
-
-    [SDL_SCANCODE_EXECUTE]           = Q_KEY_CODE_EXECUTE,
-#endif
-    [SDL_SCANCODE_HELP]              = Q_KEY_CODE_HELP,
-    [SDL_SCANCODE_MENU]              = Q_KEY_CODE_MENU,
-#if 0
-    [SDL_SCANCODE_SELECT]            = Q_KEY_CODE_SELECT,
-#endif
-    [SDL_SCANCODE_STOP]              = Q_KEY_CODE_STOP,
-    [SDL_SCANCODE_AGAIN]             = Q_KEY_CODE_AGAIN,
-    [SDL_SCANCODE_UNDO]              = Q_KEY_CODE_UNDO,
-    [SDL_SCANCODE_CUT]               = Q_KEY_CODE_CUT,
-    [SDL_SCANCODE_COPY]              = Q_KEY_CODE_COPY,
-    [SDL_SCANCODE_PASTE]             = Q_KEY_CODE_PASTE,
-    [SDL_SCANCODE_FIND]              = Q_KEY_CODE_FIND,
-#if 0
-    [SDL_SCANCODE_MUTE]              = Q_KEY_CODE_MUTE,
-    [SDL_SCANCODE_VOLUMEUP]          = Q_KEY_CODE_VOLUMEUP,
-    [SDL_SCANCODE_VOLUMEDOWN]        = Q_KEY_CODE_VOLUMEDOWN,
-
-    [SDL_SCANCODE_KP_COMMA]          = Q_KEY_CODE_KP_COMMA,
-    [SDL_SCANCODE_KP_EQUALSAS400]    = Q_KEY_CODE_KP_EQUALSAS400,
-
-    [SDL_SCANCODE_INTERNATIONAL1]    = Q_KEY_CODE_INTERNATIONAL1,
-    [SDL_SCANCODE_INTERNATIONAL2]    = Q_KEY_CODE_INTERNATIONAL2,
-    [SDL_SCANCODE_INTERNATIONAL3]    = Q_KEY_CODE_INTERNATIONAL3,
-    [SDL_SCANCODE_INTERNATIONAL4]    = Q_KEY_CODE_INTERNATIONAL4,
-    [SDL_SCANCODE_INTERNATIONAL5]    = Q_KEY_CODE_INTERNATIONAL5,
-    [SDL_SCANCODE_INTERNATIONAL6]    = Q_KEY_CODE_INTERNATIONAL6,
-    [SDL_SCANCODE_INTERNATIONAL7]    = Q_KEY_CODE_INTERNATIONAL7,
-    [SDL_SCANCODE_INTERNATIONAL8]    = Q_KEY_CODE_INTERNATIONAL8,
-    [SDL_SCANCODE_INTERNATIONAL9]    = Q_KEY_CODE_INTERNATIONAL9,
-    [SDL_SCANCODE_LANG1]             = Q_KEY_CODE_LANG1,
-    [SDL_SCANCODE_LANG2]             = Q_KEY_CODE_LANG2,
-    [SDL_SCANCODE_LANG3]             = Q_KEY_CODE_LANG3,
-    [SDL_SCANCODE_LANG4]             = Q_KEY_CODE_LANG4,
-    [SDL_SCANCODE_LANG5]             = Q_KEY_CODE_LANG5,
-    [SDL_SCANCODE_LANG6]             = Q_KEY_CODE_LANG6,
-    [SDL_SCANCODE_LANG7]             = Q_KEY_CODE_LANG7,
-    [SDL_SCANCODE_LANG8]             = Q_KEY_CODE_LANG8,
-    [SDL_SCANCODE_LANG9]             = Q_KEY_CODE_LANG9,
-    [SDL_SCANCODE_ALTERASE]          = Q_KEY_CODE_ALTERASE,
-#endif
-    [SDL_SCANCODE_SYSREQ]            = Q_KEY_CODE_SYSRQ,
-#if 0
-    [SDL_SCANCODE_CANCEL]            = Q_KEY_CODE_CANCEL,
-    [SDL_SCANCODE_CLEAR]             = Q_KEY_CODE_CLEAR,
-    [SDL_SCANCODE_PRIOR]             = Q_KEY_CODE_PRIOR,
-    [SDL_SCANCODE_RETURN2]           = Q_KEY_CODE_RETURN2,
-    [SDL_SCANCODE_SEPARATOR]         = Q_KEY_CODE_SEPARATOR,
-    [SDL_SCANCODE_OUT]               = Q_KEY_CODE_OUT,
-    [SDL_SCANCODE_OPER]              = Q_KEY_CODE_OPER,
-    [SDL_SCANCODE_CLEARAGAIN]        = Q_KEY_CODE_CLEARAGAIN,
-    [SDL_SCANCODE_CRSEL]             = Q_KEY_CODE_CRSEL,
-    [SDL_SCANCODE_EXSEL]             = Q_KEY_CODE_EXSEL,
-    [SDL_SCANCODE_KP_00]             = Q_KEY_CODE_KP_00,
-    [SDL_SCANCODE_KP_000]            = Q_KEY_CODE_KP_000,
-    [SDL_SCANCODE_THOUSANDSSEPARATOR] = Q_KEY_CODE_THOUSANDSSEPARATOR,
-    [SDL_SCANCODE_DECIMALSEPARATOR]  = Q_KEY_CODE_DECIMALSEPARATOR,
-    [SDL_SCANCODE_CURRENCYUNIT]      = Q_KEY_CODE_CURRENCYUNIT,
-    [SDL_SCANCODE_CURRENCYSUBUNIT]   = Q_KEY_CODE_CURRENCYSUBUNIT,
-    [SDL_SCANCODE_KP_LEFTPAREN]      = Q_KEY_CODE_KP_LEFTPAREN,
-    [SDL_SCANCODE_KP_RIGHTPAREN]     = Q_KEY_CODE_KP_RIGHTPAREN,
-    [SDL_SCANCODE_KP_LEFTBRACE]      = Q_KEY_CODE_KP_LEFTBRACE,
-    [SDL_SCANCODE_KP_RIGHTBRACE]     = Q_KEY_CODE_KP_RIGHTBRACE,
-    [SDL_SCANCODE_KP_TAB]            = Q_KEY_CODE_KP_TAB,
-    [SDL_SCANCODE_KP_BACKSPACE]      = Q_KEY_CODE_KP_BACKSPACE,
-    [SDL_SCANCODE_KP_A]              = Q_KEY_CODE_KP_A,
-    [SDL_SCANCODE_KP_B]              = Q_KEY_CODE_KP_B,
-    [SDL_SCANCODE_KP_C]              = Q_KEY_CODE_KP_C,
-    [SDL_SCANCODE_KP_D]              = Q_KEY_CODE_KP_D,
-    [SDL_SCANCODE_KP_E]              = Q_KEY_CODE_KP_E,
-    [SDL_SCANCODE_KP_F]              = Q_KEY_CODE_KP_F,
-    [SDL_SCANCODE_KP_XOR]            = Q_KEY_CODE_KP_XOR,
-    [SDL_SCANCODE_KP_POWER]          = Q_KEY_CODE_KP_POWER,
-    [SDL_SCANCODE_KP_PERCENT]        = Q_KEY_CODE_KP_PERCENT,
-    [SDL_SCANCODE_KP_LESS]           = Q_KEY_CODE_KP_LESS,
-    [SDL_SCANCODE_KP_GREATER]        = Q_KEY_CODE_KP_GREATER,
-    [SDL_SCANCODE_KP_AMPERSAND]      = Q_KEY_CODE_KP_AMPERSAND,
-    [SDL_SCANCODE_KP_DBLAMPERSAND]   = Q_KEY_CODE_KP_DBLAMPERSAND,
-    [SDL_SCANCODE_KP_VERTICALBAR]    = Q_KEY_CODE_KP_VERTICALBAR,
-    [SDL_SCANCODE_KP_DBLVERTICALBAR] = Q_KEY_CODE_KP_DBLVERTICALBAR,
-    [SDL_SCANCODE_KP_COLON]          = Q_KEY_CODE_KP_COLON,
-    [SDL_SCANCODE_KP_HASH]           = Q_KEY_CODE_KP_HASH,
-    [SDL_SCANCODE_KP_SPACE]          = Q_KEY_CODE_KP_SPACE,
-    [SDL_SCANCODE_KP_AT]             = Q_KEY_CODE_KP_AT,
-    [SDL_SCANCODE_KP_EXCLAM]         = Q_KEY_CODE_KP_EXCLAM,
-    [SDL_SCANCODE_KP_MEMSTORE]       = Q_KEY_CODE_KP_MEMSTORE,
-    [SDL_SCANCODE_KP_MEMRECALL]      = Q_KEY_CODE_KP_MEMRECALL,
-    [SDL_SCANCODE_KP_MEMCLEAR]       = Q_KEY_CODE_KP_MEMCLEAR,
-    [SDL_SCANCODE_KP_MEMADD]         = Q_KEY_CODE_KP_MEMADD,
-    [SDL_SCANCODE_KP_MEMSUBTRACT]    = Q_KEY_CODE_KP_MEMSUBTRACT,
-    [SDL_SCANCODE_KP_MEMMULTIPLY]    = Q_KEY_CODE_KP_MEMMULTIPLY,
-    [SDL_SCANCODE_KP_MEMDIVIDE]      = Q_KEY_CODE_KP_MEMDIVIDE,
-    [SDL_SCANCODE_KP_PLUSMINUS]      = Q_KEY_CODE_KP_PLUSMINUS,
-    [SDL_SCANCODE_KP_CLEAR]          = Q_KEY_CODE_KP_CLEAR,
-    [SDL_SCANCODE_KP_CLEARENTRY]     = Q_KEY_CODE_KP_CLEARENTRY,
-    [SDL_SCANCODE_KP_BINARY]         = Q_KEY_CODE_KP_BINARY,
-    [SDL_SCANCODE_KP_OCTAL]          = Q_KEY_CODE_KP_OCTAL,
-    [SDL_SCANCODE_KP_DECIMAL]        = Q_KEY_CODE_KP_DECIMAL,
-    [SDL_SCANCODE_KP_HEXADECIMAL]    = Q_KEY_CODE_KP_HEXADECIMAL,
-#endif
-    [SDL_SCANCODE_LCTRL]             = Q_KEY_CODE_CTRL,
-    [SDL_SCANCODE_LSHIFT]            = Q_KEY_CODE_SHIFT,
-    [SDL_SCANCODE_LALT]              = Q_KEY_CODE_ALT,
-    [SDL_SCANCODE_LGUI]              = Q_KEY_CODE_META_L,
-    [SDL_SCANCODE_RCTRL]             = Q_KEY_CODE_CTRL_R,
-    [SDL_SCANCODE_RSHIFT]            = Q_KEY_CODE_SHIFT_R,
-    [SDL_SCANCODE_RALT]              = Q_KEY_CODE_ALT_R,
-    [SDL_SCANCODE_RGUI]              = Q_KEY_CODE_META_R,
-#if 0
-    [SDL_SCANCODE_MODE]              = Q_KEY_CODE_MODE,
-    [SDL_SCANCODE_AUDIONEXT]         = Q_KEY_CODE_AUDIONEXT,
-    [SDL_SCANCODE_AUDIOPREV]         = Q_KEY_CODE_AUDIOPREV,
-    [SDL_SCANCODE_AUDIOSTOP]         = Q_KEY_CODE_AUDIOSTOP,
-    [SDL_SCANCODE_AUDIOPLAY]         = Q_KEY_CODE_AUDIOPLAY,
-    [SDL_SCANCODE_AUDIOMUTE]         = Q_KEY_CODE_AUDIOMUTE,
-    [SDL_SCANCODE_MEDIASELECT]       = Q_KEY_CODE_MEDIASELECT,
-    [SDL_SCANCODE_WWW]               = Q_KEY_CODE_WWW,
-    [SDL_SCANCODE_MAIL]              = Q_KEY_CODE_MAIL,
-    [SDL_SCANCODE_CALCULATOR]        = Q_KEY_CODE_CALCULATOR,
-    [SDL_SCANCODE_COMPUTER]          = Q_KEY_CODE_COMPUTER,
-    [SDL_SCANCODE_AC_SEARCH]         = Q_KEY_CODE_AC_SEARCH,
-    [SDL_SCANCODE_AC_HOME]           = Q_KEY_CODE_AC_HOME,
-    [SDL_SCANCODE_AC_BACK]           = Q_KEY_CODE_AC_BACK,
-    [SDL_SCANCODE_AC_FORWARD]        = Q_KEY_CODE_AC_FORWARD,
-    [SDL_SCANCODE_AC_STOP]           = Q_KEY_CODE_AC_STOP,
-    [SDL_SCANCODE_AC_REFRESH]        = Q_KEY_CODE_AC_REFRESH,
-    [SDL_SCANCODE_AC_BOOKMARKS]      = Q_KEY_CODE_AC_BOOKMARKS,
-    [SDL_SCANCODE_BRIGHTNESSDOWN]    = Q_KEY_CODE_BRIGHTNESSDOWN,
-    [SDL_SCANCODE_BRIGHTNESSUP]      = Q_KEY_CODE_BRIGHTNESSUP,
-    [SDL_SCANCODE_DISPLAYSWITCH]     = Q_KEY_CODE_DISPLAYSWITCH,
-    [SDL_SCANCODE_KBDILLUMTOGGLE]    = Q_KEY_CODE_KBDILLUMTOGGLE,
-    [SDL_SCANCODE_KBDILLUMDOWN]      = Q_KEY_CODE_KBDILLUMDOWN,
-    [SDL_SCANCODE_KBDILLUMUP]        = Q_KEY_CODE_KBDILLUMUP,
-    [SDL_SCANCODE_EJECT]             = Q_KEY_CODE_EJECT,
-    [SDL_SCANCODE_SLEEP]             = Q_KEY_CODE_SLEEP,
-    [SDL_SCANCODE_APP1]              = Q_KEY_CODE_APP1,
-    [SDL_SCANCODE_APP2]              = Q_KEY_CODE_APP2,
-#endif
-};
-- 
2.13.5
