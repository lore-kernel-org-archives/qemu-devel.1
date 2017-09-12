Received: from eggs.gnu.org ([2001:4830:134:3::10]:48640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS9-0000lz-4B
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS2-0003SX-TU
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkS2-0003SC-JS
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A22EF8553D
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:38:01 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 13:37:39 +0100
Message-Id: <20170912123744.14730-8-berrange@redhat.com>
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 07/12] input: convert the adb device to
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

Replace the qcode_to_adb_keycode table with automatically
generated tables.

Missing entries in qcode_to_adb_keycode now fixed:

 - Q_KEY_CODE_KP_COMMA -> 0x47

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/input/adb.c                 | 124 +-------------------------------
 include/hw/input/adb-keys.h    | 141 -------------------------------------
 include/ui/input.h             |   3 +
 ui/Makefile.objs               |   1 +
 ui/input-keymap-qcode-to-adb.c | 156 +++++++++++++++++++++++++++++++++++++++++
 ui/input-keymap.c              |   1 +
 6 files changed, 163 insertions(+), 263 deletions(-)
 delete mode 100644 include/hw/input/adb-keys.h
 create mode 100644 ui/input-keymap-qcode-to-adb.c

diff --git a/hw/input/adb.c b/hw/input/adb.c
index fcca3a8eb9..1fe5d298a3 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -25,7 +25,6 @@
 #include "hw/hw.h"
 #include "hw/input/adb.h"
 #include "ui/console.h"
-#include "include/hw/input/adb-keys.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 
@@ -193,125 +192,6 @@ typedef struct ADBKeyboardClass {
     DeviceRealize parent_realize;
 } ADBKeyboardClass;
 
-int qcode_to_adb_keycode[] = {
-     /* Make sure future additions are automatically set to NO_KEY */
-    [0 ... 0xff]               = NO_KEY,
-
-    [Q_KEY_CODE_SHIFT]         = ADB_KEY_LEFT_SHIFT,
-    [Q_KEY_CODE_SHIFT_R]       = ADB_KEY_RIGHT_SHIFT,
-    [Q_KEY_CODE_ALT]           = ADB_KEY_LEFT_OPTION,
-    [Q_KEY_CODE_ALT_R]         = ADB_KEY_RIGHT_OPTION,
-    [Q_KEY_CODE_CTRL]          = ADB_KEY_LEFT_CONTROL,
-    [Q_KEY_CODE_CTRL_R]        = ADB_KEY_RIGHT_CONTROL,
-    [Q_KEY_CODE_META_L]        = ADB_KEY_COMMAND,
-    [Q_KEY_CODE_META_R]        = ADB_KEY_COMMAND,
-    [Q_KEY_CODE_SPC]           = ADB_KEY_SPACEBAR,
-
-    [Q_KEY_CODE_ESC]           = ADB_KEY_ESC,
-    [Q_KEY_CODE_1]             = ADB_KEY_1,
-    [Q_KEY_CODE_2]             = ADB_KEY_2,
-    [Q_KEY_CODE_3]             = ADB_KEY_3,
-    [Q_KEY_CODE_4]             = ADB_KEY_4,
-    [Q_KEY_CODE_5]             = ADB_KEY_5,
-    [Q_KEY_CODE_6]             = ADB_KEY_6,
-    [Q_KEY_CODE_7]             = ADB_KEY_7,
-    [Q_KEY_CODE_8]             = ADB_KEY_8,
-    [Q_KEY_CODE_9]             = ADB_KEY_9,
-    [Q_KEY_CODE_0]             = ADB_KEY_0,
-    [Q_KEY_CODE_MINUS]         = ADB_KEY_MINUS,
-    [Q_KEY_CODE_EQUAL]         = ADB_KEY_EQUAL,
-    [Q_KEY_CODE_BACKSPACE]     = ADB_KEY_DELETE,
-    [Q_KEY_CODE_TAB]           = ADB_KEY_TAB,
-    [Q_KEY_CODE_Q]             = ADB_KEY_Q,
-    [Q_KEY_CODE_W]             = ADB_KEY_W,
-    [Q_KEY_CODE_E]             = ADB_KEY_E,
-    [Q_KEY_CODE_R]             = ADB_KEY_R,
-    [Q_KEY_CODE_T]             = ADB_KEY_T,
-    [Q_KEY_CODE_Y]             = ADB_KEY_Y,
-    [Q_KEY_CODE_U]             = ADB_KEY_U,
-    [Q_KEY_CODE_I]             = ADB_KEY_I,
-    [Q_KEY_CODE_O]             = ADB_KEY_O,
-    [Q_KEY_CODE_P]             = ADB_KEY_P,
-    [Q_KEY_CODE_BRACKET_LEFT]  = ADB_KEY_LEFT_BRACKET,
-    [Q_KEY_CODE_BRACKET_RIGHT] = ADB_KEY_RIGHT_BRACKET,
-    [Q_KEY_CODE_RET]           = ADB_KEY_RETURN,
-    [Q_KEY_CODE_A]             = ADB_KEY_A,
-    [Q_KEY_CODE_S]             = ADB_KEY_S,
-    [Q_KEY_CODE_D]             = ADB_KEY_D,
-    [Q_KEY_CODE_F]             = ADB_KEY_F,
-    [Q_KEY_CODE_G]             = ADB_KEY_G,
-    [Q_KEY_CODE_H]             = ADB_KEY_H,
-    [Q_KEY_CODE_J]             = ADB_KEY_J,
-    [Q_KEY_CODE_K]             = ADB_KEY_K,
-    [Q_KEY_CODE_L]             = ADB_KEY_L,
-    [Q_KEY_CODE_SEMICOLON]     = ADB_KEY_SEMICOLON,
-    [Q_KEY_CODE_APOSTROPHE]    = ADB_KEY_APOSTROPHE,
-    [Q_KEY_CODE_GRAVE_ACCENT]  = ADB_KEY_GRAVE_ACCENT,
-    [Q_KEY_CODE_BACKSLASH]     = ADB_KEY_BACKSLASH,
-    [Q_KEY_CODE_Z]             = ADB_KEY_Z,
-    [Q_KEY_CODE_X]             = ADB_KEY_X,
-    [Q_KEY_CODE_C]             = ADB_KEY_C,
-    [Q_KEY_CODE_V]             = ADB_KEY_V,
-    [Q_KEY_CODE_B]             = ADB_KEY_B,
-    [Q_KEY_CODE_N]             = ADB_KEY_N,
-    [Q_KEY_CODE_M]             = ADB_KEY_M,
-    [Q_KEY_CODE_COMMA]         = ADB_KEY_COMMA,
-    [Q_KEY_CODE_DOT]           = ADB_KEY_PERIOD,
-    [Q_KEY_CODE_SLASH]         = ADB_KEY_FORWARD_SLASH,
-    [Q_KEY_CODE_ASTERISK]      = ADB_KEY_KP_MULTIPLY,
-    [Q_KEY_CODE_CAPS_LOCK]     = ADB_KEY_CAPS_LOCK,
-
-    [Q_KEY_CODE_F1]            = ADB_KEY_F1,
-    [Q_KEY_CODE_F2]            = ADB_KEY_F2,
-    [Q_KEY_CODE_F3]            = ADB_KEY_F3,
-    [Q_KEY_CODE_F4]            = ADB_KEY_F4,
-    [Q_KEY_CODE_F5]            = ADB_KEY_F5,
-    [Q_KEY_CODE_F6]            = ADB_KEY_F6,
-    [Q_KEY_CODE_F7]            = ADB_KEY_F7,
-    [Q_KEY_CODE_F8]            = ADB_KEY_F8,
-    [Q_KEY_CODE_F9]            = ADB_KEY_F9,
-    [Q_KEY_CODE_F10]           = ADB_KEY_F10,
-    [Q_KEY_CODE_F11]           = ADB_KEY_F11,
-    [Q_KEY_CODE_F12]           = ADB_KEY_F12,
-    [Q_KEY_CODE_PRINT]         = ADB_KEY_F13,
-    [Q_KEY_CODE_SYSRQ]         = ADB_KEY_F13,
-    [Q_KEY_CODE_SCROLL_LOCK]   = ADB_KEY_F14,
-    [Q_KEY_CODE_PAUSE]         = ADB_KEY_F15,
-
-    [Q_KEY_CODE_NUM_LOCK]      = ADB_KEY_KP_CLEAR,
-    [Q_KEY_CODE_KP_EQUALS]     = ADB_KEY_KP_EQUAL,
-    [Q_KEY_CODE_KP_DIVIDE]     = ADB_KEY_KP_DIVIDE,
-    [Q_KEY_CODE_KP_MULTIPLY]   = ADB_KEY_KP_MULTIPLY,
-    [Q_KEY_CODE_KP_SUBTRACT]   = ADB_KEY_KP_SUBTRACT,
-    [Q_KEY_CODE_KP_ADD]        = ADB_KEY_KP_PLUS,
-    [Q_KEY_CODE_KP_ENTER]      = ADB_KEY_KP_ENTER,
-    [Q_KEY_CODE_KP_DECIMAL]    = ADB_KEY_KP_PERIOD,
-    [Q_KEY_CODE_KP_0]          = ADB_KEY_KP_0,
-    [Q_KEY_CODE_KP_1]          = ADB_KEY_KP_1,
-    [Q_KEY_CODE_KP_2]          = ADB_KEY_KP_2,
-    [Q_KEY_CODE_KP_3]          = ADB_KEY_KP_3,
-    [Q_KEY_CODE_KP_4]          = ADB_KEY_KP_4,
-    [Q_KEY_CODE_KP_5]          = ADB_KEY_KP_5,
-    [Q_KEY_CODE_KP_6]          = ADB_KEY_KP_6,
-    [Q_KEY_CODE_KP_7]          = ADB_KEY_KP_7,
-    [Q_KEY_CODE_KP_8]          = ADB_KEY_KP_8,
-    [Q_KEY_CODE_KP_9]          = ADB_KEY_KP_9,
-
-    [Q_KEY_CODE_UP]            = ADB_KEY_UP,
-    [Q_KEY_CODE_DOWN]          = ADB_KEY_DOWN,
-    [Q_KEY_CODE_LEFT]          = ADB_KEY_LEFT,
-    [Q_KEY_CODE_RIGHT]         = ADB_KEY_RIGHT,
-
-    [Q_KEY_CODE_HELP]          = ADB_KEY_HELP,
-    [Q_KEY_CODE_INSERT]        = ADB_KEY_HELP,
-    [Q_KEY_CODE_DELETE]        = ADB_KEY_FORWARD_DELETE,
-    [Q_KEY_CODE_HOME]          = ADB_KEY_HOME,
-    [Q_KEY_CODE_END]           = ADB_KEY_END,
-    [Q_KEY_CODE_PGUP]          = ADB_KEY_PAGE_UP,
-    [Q_KEY_CODE_PGDN]          = ADB_KEY_PAGE_DOWN,
-
-    [Q_KEY_CODE_POWER]         = ADB_KEY_POWER
-};
 
 static void adb_kbd_put_keycode(void *opaque, int keycode)
 {
@@ -439,11 +319,11 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
     int qcode, keycode;
 
     qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
-    if (qcode >= ARRAY_SIZE(qcode_to_adb_keycode)) {
+    if (qcode >= qemu_input_map_qcode_to_adb_len) {
         return;
     }
     /* FIXME: take handler into account when translating qcode */
-    keycode = qcode_to_adb_keycode[qcode];
+    keycode = qemu_input_map_qcode_to_adb[qcode];
     if (keycode == NO_KEY) {  /* We don't want to send this to the guest */
         ADB_DPRINTF("Ignoring NO_KEY\n");
         return;
diff --git a/include/hw/input/adb-keys.h b/include/hw/input/adb-keys.h
deleted file mode 100644
index 525fba8a61..0000000000
--- a/include/hw/input/adb-keys.h
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2016 John Arbuckle
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-/*
- *  adb-keys.h
- *
- *  Provides an enum of all the Macintosh keycodes.
- *  Additional information: http://www.archive.org/stream/apple-guide-macintosh-family-hardware/Apple_Guide_to_the_Macintosh_Family_Hardware_2e#page/n345/mode/2up
- *                          page 308
- */
-
-#ifndef ADB_KEYS_H
-#define ADB_KEYS_H
-
-enum {
-    ADB_KEY_A = 0x00,
-    ADB_KEY_B = 0x0b,
-    ADB_KEY_C = 0x08,
-    ADB_KEY_D = 0x02,
-    ADB_KEY_E = 0x0e,
-    ADB_KEY_F = 0x03,
-    ADB_KEY_G = 0x05,
-    ADB_KEY_H = 0x04,
-    ADB_KEY_I = 0x22,
-    ADB_KEY_J = 0x26,
-    ADB_KEY_K = 0x28,
-    ADB_KEY_L = 0x25,
-    ADB_KEY_M = 0x2e,
-    ADB_KEY_N = 0x2d,
-    ADB_KEY_O = 0x1f,
-    ADB_KEY_P = 0x23,
-    ADB_KEY_Q = 0x0c,
-    ADB_KEY_R = 0x0f,
-    ADB_KEY_S = 0x01,
-    ADB_KEY_T = 0x11,
-    ADB_KEY_U = 0x20,
-    ADB_KEY_V = 0x09,
-    ADB_KEY_W = 0x0d,
-    ADB_KEY_X = 0x07,
-    ADB_KEY_Y = 0x10,
-    ADB_KEY_Z = 0x06,
-
-    ADB_KEY_0 = 0x1d,
-    ADB_KEY_1 = 0x12,
-    ADB_KEY_2 = 0x13,
-    ADB_KEY_3 = 0x14,
-    ADB_KEY_4 = 0x15,
-    ADB_KEY_5 = 0x17,
-    ADB_KEY_6 = 0x16,
-    ADB_KEY_7 = 0x1a,
-    ADB_KEY_8 = 0x1c,
-    ADB_KEY_9 = 0x19,
-
-    ADB_KEY_GRAVE_ACCENT = 0x32,
-    ADB_KEY_MINUS = 0x1b,
-    ADB_KEY_EQUAL = 0x18,
-    ADB_KEY_DELETE = 0x33,
-    ADB_KEY_CAPS_LOCK = 0x39,
-    ADB_KEY_TAB = 0x30,
-    ADB_KEY_RETURN = 0x24,
-    ADB_KEY_LEFT_BRACKET = 0x21,
-    ADB_KEY_RIGHT_BRACKET = 0x1e,
-    ADB_KEY_BACKSLASH = 0x2a,
-    ADB_KEY_SEMICOLON = 0x29,
-    ADB_KEY_APOSTROPHE = 0x27,
-    ADB_KEY_COMMA = 0x2b,
-    ADB_KEY_PERIOD = 0x2f,
-    ADB_KEY_FORWARD_SLASH = 0x2c,
-    ADB_KEY_LEFT_SHIFT = 0x38,
-    ADB_KEY_RIGHT_SHIFT = 0x7b,
-    ADB_KEY_SPACEBAR = 0x31,
-    ADB_KEY_LEFT_CONTROL = 0x36,
-    ADB_KEY_RIGHT_CONTROL = 0x7d,
-    ADB_KEY_LEFT_OPTION = 0x3a,
-    ADB_KEY_RIGHT_OPTION = 0x7c,
-    ADB_KEY_COMMAND = 0x37,
-
-    ADB_KEY_KP_0 = 0x52,
-    ADB_KEY_KP_1 = 0x53,
-    ADB_KEY_KP_2 = 0x54,
-    ADB_KEY_KP_3 = 0x55,
-    ADB_KEY_KP_4 = 0x56,
-    ADB_KEY_KP_5 = 0x57,
-    ADB_KEY_KP_6 = 0x58,
-    ADB_KEY_KP_7 = 0x59,
-    ADB_KEY_KP_8 = 0x5b,
-    ADB_KEY_KP_9 = 0x5c,
-    ADB_KEY_KP_PERIOD = 0x41,
-    ADB_KEY_KP_ENTER = 0x4c,
-    ADB_KEY_KP_PLUS = 0x45,
-    ADB_KEY_KP_SUBTRACT = 0x4e,
-    ADB_KEY_KP_MULTIPLY = 0x43,
-    ADB_KEY_KP_DIVIDE = 0x4b,
-    ADB_KEY_KP_EQUAL = 0x51,
-    ADB_KEY_KP_CLEAR = 0x47,
-
-    ADB_KEY_UP = 0x3e,
-    ADB_KEY_DOWN = 0x3d,
-    ADB_KEY_LEFT = 0x3b,
-    ADB_KEY_RIGHT = 0x3c,
-
-    ADB_KEY_HELP = 0x72,
-    ADB_KEY_HOME = 0x73,
-    ADB_KEY_PAGE_UP = 0x74,
-    ADB_KEY_PAGE_DOWN = 0x79,
-    ADB_KEY_END = 0x77,
-    ADB_KEY_FORWARD_DELETE = 0x75,
-
-    ADB_KEY_ESC = 0x35,
-    ADB_KEY_F1 = 0x7a,
-    ADB_KEY_F2 = 0x78,
-    ADB_KEY_F3 = 0x63,
-    ADB_KEY_F4 = 0x76,
-    ADB_KEY_F5 = 0x60,
-    ADB_KEY_F6 = 0x61,
-    ADB_KEY_F7 = 0x62,
-    ADB_KEY_F8 = 0x64,
-    ADB_KEY_F9 = 0x65,
-    ADB_KEY_F10 = 0x6d,
-    ADB_KEY_F11 = 0x67,
-    ADB_KEY_F12 = 0x6f,
-    ADB_KEY_F13 = 0x69,
-    ADB_KEY_F14 = 0x6b,
-    ADB_KEY_F15 = 0x71,
-
-    ADB_KEY_VOLUME_UP = 0x48,
-    ADB_KEY_VOLUME_DOWN = 0x49,
-    ADB_KEY_VOLUME_MUTE = 0x4a,
-    ADB_KEY_POWER = 0x7f7f
-};
-
-/* Could not find the value for this key. */
-/* #define ADB_KEY_EJECT */
-
-#endif /* ADB_KEYS_H */
diff --git a/include/ui/input.h b/include/ui/input.h
index 76235ba97a..4aa5655a0b 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -71,6 +71,9 @@ void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 extern const guint qemu_input_map_linux_to_qcode_len;
 extern const guint16 qemu_input_map_linux_to_qcode[];
 
+extern const guint qemu_input_map_qcode_to_adb_len;
+extern const guint16 qemu_input_map_qcode_to_adb[];
+
 extern const guint qemu_input_map_qcode_to_atset1_len;
 extern const guint16 qemu_input_map_qcode_to_atset1[];
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 8ba843c0c9..6846636f39 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -55,6 +55,7 @@ KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux-to-qcode.c \
+		 ui/input-keymap-qcode-to-adb.c \
 		 ui/input-keymap-qcode-to-atset1.c \
 		 ui/input-keymap-qcode-to-atset2.c \
 		 ui/input-keymap-qcode-to-atset3.c \
diff --git a/ui/input-keymap-qcode-to-adb.c b/ui/input-keymap-qcode-to-adb.c
new file mode 100644
index 0000000000..979f40a953
--- /dev/null
+++ b/ui/input-keymap-qcode-to-adb.c
@@ -0,0 +1,156 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:07
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_qcode_to_adb code-map keymaps.csv qcode adb
+*/
+const guint16 qemu_input_map_qcode_to_adb[Q_KEY_CODE__MAX] = {
+  [0 ... Q_KEY_CODE__MAX-1] = 0xff,
+  [Q_KEY_CODE_0] = 0x1d, /* qcode:Q_KEY_CODE_0 (0) -> linux:11 (KEY_0) -> adb:29 */
+  [Q_KEY_CODE_1] = 0x12, /* qcode:Q_KEY_CODE_1 (1) -> linux:2 (KEY_1) -> adb:18 */
+  [Q_KEY_CODE_2] = 0x13, /* qcode:Q_KEY_CODE_2 (2) -> linux:3 (KEY_2) -> adb:19 */
+  [Q_KEY_CODE_3] = 0x14, /* qcode:Q_KEY_CODE_3 (3) -> linux:4 (KEY_3) -> adb:20 */
+  [Q_KEY_CODE_4] = 0x15, /* qcode:Q_KEY_CODE_4 (4) -> linux:5 (KEY_4) -> adb:21 */
+  [Q_KEY_CODE_5] = 0x17, /* qcode:Q_KEY_CODE_5 (5) -> linux:6 (KEY_5) -> adb:23 */
+  [Q_KEY_CODE_6] = 0x16, /* qcode:Q_KEY_CODE_6 (6) -> linux:7 (KEY_6) -> adb:22 */
+  [Q_KEY_CODE_7] = 0x1a, /* qcode:Q_KEY_CODE_7 (7) -> linux:8 (KEY_7) -> adb:26 */
+  [Q_KEY_CODE_8] = 0x1c, /* qcode:Q_KEY_CODE_8 (8) -> linux:9 (KEY_8) -> adb:28 */
+  [Q_KEY_CODE_9] = 0x19, /* qcode:Q_KEY_CODE_9 (9) -> linux:10 (KEY_9) -> adb:25 */
+  [Q_KEY_CODE_A] = 0x0, /* qcode:Q_KEY_CODE_A (a) -> linux:30 (KEY_A) -> adb:0 */
+  [Q_KEY_CODE_AC_BACK] = 0xff, /* qcode:Q_KEY_CODE_AC_BACK (ac_back) -> linux:158 (KEY_BACK) -> adb:255 */
+  [Q_KEY_CODE_AC_BOOKMARKS] = 0xff, /* qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) -> linux:156 (KEY_BOOKMARKS) -> adb:255 */
+  [Q_KEY_CODE_AC_FORWARD] = 0xff, /* qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) -> linux:159 (KEY_FORWARD) -> adb:255 */
+  [Q_KEY_CODE_AC_HOME] = 0xff, /* qcode:Q_KEY_CODE_AC_HOME (ac_home) -> linux:172 (KEY_HOMEPAGE) -> adb:255 */
+  [Q_KEY_CODE_AC_REFRESH] = 0xff, /* qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) -> linux:173 (KEY_REFRESH) -> adb:255 */
+  [Q_KEY_CODE_AGAIN] = 0xff, /* qcode:Q_KEY_CODE_AGAIN (again) -> linux:129 (KEY_AGAIN) -> adb:255 */
+  [Q_KEY_CODE_ALT] = 0x3a, /* qcode:Q_KEY_CODE_ALT (alt) -> linux:56 (KEY_LEFTALT) -> adb:58 */
+  [Q_KEY_CODE_ALT_R] = 0x7c, /* qcode:Q_KEY_CODE_ALT_R (alt_r) -> linux:100 (KEY_RIGHTALT) -> adb:124 */
+  [Q_KEY_CODE_APOSTROPHE] = 0x27, /* qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) -> linux:40 (KEY_APOSTROPHE) -> adb:39 */
+  [Q_KEY_CODE_ASTERISK] = 0x43, /* qcode:Q_KEY_CODE_ASTERISK (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> adb:67 */
+  [Q_KEY_CODE_AUDIOMUTE] = 0xff, /* qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) -> linux:113 (KEY_MUTE) -> adb:255 */
+  [Q_KEY_CODE_AUDIONEXT] = 0xff, /* qcode:Q_KEY_CODE_AUDIONEXT (audionext) -> linux:163 (KEY_NEXTSONG) -> adb:255 */
+  [Q_KEY_CODE_AUDIOPLAY] = 0xff, /* qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) -> linux:164 (KEY_PLAYPAUSE) -> adb:255 */
+  [Q_KEY_CODE_AUDIOPREV] = 0xff, /* qcode:Q_KEY_CODE_AUDIOPREV (audioprev) -> linux:165 (KEY_PREVIOUSSONG) -> adb:255 */
+  [Q_KEY_CODE_AUDIOSTOP] = 0xff, /* qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) -> linux:166 (KEY_STOPCD) -> adb:255 */
+  [Q_KEY_CODE_B] = 0xb, /* qcode:Q_KEY_CODE_B (b) -> linux:48 (KEY_B) -> adb:11 */
+  [Q_KEY_CODE_BACKSLASH] = 0x2a, /* qcode:Q_KEY_CODE_BACKSLASH (backslash) -> linux:43 (KEY_BACKSLASH) -> adb:42 */
+  [Q_KEY_CODE_BACKSPACE] = 0x33, /* qcode:Q_KEY_CODE_BACKSPACE (backspace) -> linux:14 (KEY_BACKSPACE) -> adb:51 */
+  [Q_KEY_CODE_BRACKET_LEFT] = 0x21, /* qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) -> linux:26 (KEY_LEFTBRACE) -> adb:33 */
+  [Q_KEY_CODE_BRACKET_RIGHT] = 0x1e, /* qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) -> linux:27 (KEY_RIGHTBRACE) -> adb:30 */
+  [Q_KEY_CODE_C] = 0x8, /* qcode:Q_KEY_CODE_C (c) -> linux:46 (KEY_C) -> adb:8 */
+  [Q_KEY_CODE_CALCULATOR] = 0xff, /* qcode:Q_KEY_CODE_CALCULATOR (calculator) -> linux:140 (KEY_CALC) -> adb:255 */
+  [Q_KEY_CODE_CAPS_LOCK] = 0x39, /* qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) -> linux:58 (KEY_CAPSLOCK) -> adb:57 */
+  [Q_KEY_CODE_COMMA] = 0x2b, /* qcode:Q_KEY_CODE_COMMA (comma) -> linux:51 (KEY_COMMA) -> adb:43 */
+  [Q_KEY_CODE_COMPOSE] = 0xff, /* qcode:Q_KEY_CODE_COMPOSE (compose) -> linux:127 (KEY_COMPOSE) -> adb:255 */
+  [Q_KEY_CODE_COMPUTER] = 0xff, /* qcode:Q_KEY_CODE_COMPUTER (computer) -> linux:157 (KEY_COMPUTER) -> adb:255 */
+  [Q_KEY_CODE_COPY] = 0xff, /* qcode:Q_KEY_CODE_COPY (copy) -> linux:133 (KEY_COPY) -> adb:255 */
+  [Q_KEY_CODE_CTRL] = 0x36, /* qcode:Q_KEY_CODE_CTRL (ctrl) -> linux:29 (KEY_LEFTCTRL) -> adb:54 */
+  [Q_KEY_CODE_CTRL_R] = 0x7d, /* qcode:Q_KEY_CODE_CTRL_R (ctrl_r) -> linux:97 (KEY_RIGHTCTRL) -> adb:125 */
+  [Q_KEY_CODE_CUT] = 0xff, /* qcode:Q_KEY_CODE_CUT (cut) -> linux:137 (KEY_CUT) -> adb:255 */
+  [Q_KEY_CODE_D] = 0x2, /* qcode:Q_KEY_CODE_D (d) -> linux:32 (KEY_D) -> adb:2 */
+  [Q_KEY_CODE_DELETE] = 0x75, /* qcode:Q_KEY_CODE_DELETE (delete) -> linux:111 (KEY_DELETE) -> adb:117 */
+  [Q_KEY_CODE_DOT] = 0x2f, /* qcode:Q_KEY_CODE_DOT (dot) -> linux:52 (KEY_DOT) -> adb:47 */
+  [Q_KEY_CODE_DOWN] = 0x3d, /* qcode:Q_KEY_CODE_DOWN (down) -> linux:108 (KEY_DOWN) -> adb:61 */
+  [Q_KEY_CODE_E] = 0xe, /* qcode:Q_KEY_CODE_E (e) -> linux:18 (KEY_E) -> adb:14 */
+  [Q_KEY_CODE_END] = 0x77, /* qcode:Q_KEY_CODE_END (end) -> linux:107 (KEY_END) -> adb:119 */
+  [Q_KEY_CODE_EQUAL] = 0x18, /* qcode:Q_KEY_CODE_EQUAL (equal) -> linux:13 (KEY_EQUAL) -> adb:24 */
+  [Q_KEY_CODE_ESC] = 0x35, /* qcode:Q_KEY_CODE_ESC (esc) -> linux:1 (KEY_ESC) -> adb:53 */
+  [Q_KEY_CODE_F] = 0x3, /* qcode:Q_KEY_CODE_F (f) -> linux:33 (KEY_F) -> adb:3 */
+  [Q_KEY_CODE_F1] = 0x7a, /* qcode:Q_KEY_CODE_F1 (f1) -> linux:59 (KEY_F1) -> adb:122 */
+  [Q_KEY_CODE_F10] = 0x6d, /* qcode:Q_KEY_CODE_F10 (f10) -> linux:68 (KEY_F10) -> adb:109 */
+  [Q_KEY_CODE_F11] = 0x67, /* qcode:Q_KEY_CODE_F11 (f11) -> linux:87 (KEY_F11) -> adb:103 */
+  [Q_KEY_CODE_F12] = 0x6f, /* qcode:Q_KEY_CODE_F12 (f12) -> linux:88 (KEY_F12) -> adb:111 */
+  [Q_KEY_CODE_F2] = 0x78, /* qcode:Q_KEY_CODE_F2 (f2) -> linux:60 (KEY_F2) -> adb:120 */
+  [Q_KEY_CODE_F3] = 0x63, /* qcode:Q_KEY_CODE_F3 (f3) -> linux:61 (KEY_F3) -> adb:99 */
+  [Q_KEY_CODE_F4] = 0x76, /* qcode:Q_KEY_CODE_F4 (f4) -> linux:62 (KEY_F4) -> adb:118 */
+  [Q_KEY_CODE_F5] = 0x60, /* qcode:Q_KEY_CODE_F5 (f5) -> linux:63 (KEY_F5) -> adb:96 */
+  [Q_KEY_CODE_F6] = 0x61, /* qcode:Q_KEY_CODE_F6 (f6) -> linux:64 (KEY_F6) -> adb:97 */
+  [Q_KEY_CODE_F7] = 0x62, /* qcode:Q_KEY_CODE_F7 (f7) -> linux:65 (KEY_F7) -> adb:98 */
+  [Q_KEY_CODE_F8] = 0x64, /* qcode:Q_KEY_CODE_F8 (f8) -> linux:66 (KEY_F8) -> adb:100 */
+  [Q_KEY_CODE_F9] = 0x65, /* qcode:Q_KEY_CODE_F9 (f9) -> linux:67 (KEY_F9) -> adb:101 */
+  [Q_KEY_CODE_FIND] = 0xff, /* qcode:Q_KEY_CODE_FIND (find) -> linux:136 (KEY_FIND) -> adb:255 */
+  [Q_KEY_CODE_FRONT] = 0xff, /* qcode:Q_KEY_CODE_FRONT (front) -> linux:132 (KEY_FRONT) -> adb:255 */
+  [Q_KEY_CODE_G] = 0x5, /* qcode:Q_KEY_CODE_G (g) -> linux:34 (KEY_G) -> adb:5 */
+  [Q_KEY_CODE_GRAVE_ACCENT] = 0x32, /* qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) -> linux:41 (KEY_GRAVE) -> adb:50 */
+  [Q_KEY_CODE_H] = 0x4, /* qcode:Q_KEY_CODE_H (h) -> linux:35 (KEY_H) -> adb:4 */
+  [Q_KEY_CODE_HELP] = 0xff, /* qcode:Q_KEY_CODE_HELP (help) -> linux:138 (KEY_HELP) -> adb:255 */
+  [Q_KEY_CODE_HENKAN] = 0xff, /* qcode:Q_KEY_CODE_HENKAN (henkan) -> linux:92 (KEY_HENKAN) -> adb:255 */
+  [Q_KEY_CODE_HIRAGANA] = 0xff, /* qcode:Q_KEY_CODE_HIRAGANA (hiragana) -> linux:91 (KEY_HIRAGANA) -> adb:255 */
+  [Q_KEY_CODE_HOME] = 0x73, /* qcode:Q_KEY_CODE_HOME (home) -> linux:102 (KEY_HOME) -> adb:115 */
+  [Q_KEY_CODE_I] = 0x22, /* qcode:Q_KEY_CODE_I (i) -> linux:23 (KEY_I) -> adb:34 */
+  [Q_KEY_CODE_INSERT] = 0x72, /* qcode:Q_KEY_CODE_INSERT (insert) -> linux:110 (KEY_INSERT) -> adb:114 */
+  [Q_KEY_CODE_J] = 0x26, /* qcode:Q_KEY_CODE_J (j) -> linux:36 (KEY_J) -> adb:38 */
+  [Q_KEY_CODE_K] = 0x28, /* qcode:Q_KEY_CODE_K (k) -> linux:37 (KEY_K) -> adb:40 */
+  [Q_KEY_CODE_KP_0] = 0x52, /* qcode:Q_KEY_CODE_KP_0 (kp_0) -> linux:82 (KEY_KP0) -> adb:82 */
+  [Q_KEY_CODE_KP_1] = 0x53, /* qcode:Q_KEY_CODE_KP_1 (kp_1) -> linux:79 (KEY_KP1) -> adb:83 */
+  [Q_KEY_CODE_KP_2] = 0x54, /* qcode:Q_KEY_CODE_KP_2 (kp_2) -> linux:80 (KEY_KP2) -> adb:84 */
+  [Q_KEY_CODE_KP_3] = 0x55, /* qcode:Q_KEY_CODE_KP_3 (kp_3) -> linux:81 (KEY_KP3) -> adb:85 */
+  [Q_KEY_CODE_KP_4] = 0x56, /* qcode:Q_KEY_CODE_KP_4 (kp_4) -> linux:75 (KEY_KP4) -> adb:86 */
+  [Q_KEY_CODE_KP_5] = 0x57, /* qcode:Q_KEY_CODE_KP_5 (kp_5) -> linux:76 (KEY_KP5) -> adb:87 */
+  [Q_KEY_CODE_KP_6] = 0x58, /* qcode:Q_KEY_CODE_KP_6 (kp_6) -> linux:77 (KEY_KP6) -> adb:88 */
+  [Q_KEY_CODE_KP_7] = 0x59, /* qcode:Q_KEY_CODE_KP_7 (kp_7) -> linux:71 (KEY_KP7) -> adb:89 */
+  [Q_KEY_CODE_KP_8] = 0x5b, /* qcode:Q_KEY_CODE_KP_8 (kp_8) -> linux:72 (KEY_KP8) -> adb:91 */
+  [Q_KEY_CODE_KP_9] = 0x5c, /* qcode:Q_KEY_CODE_KP_9 (kp_9) -> linux:73 (KEY_KP9) -> adb:92 */
+  [Q_KEY_CODE_KP_ADD] = 0x45, /* qcode:Q_KEY_CODE_KP_ADD (kp_add) -> linux:78 (KEY_KPPLUS) -> adb:69 */
+  [Q_KEY_CODE_KP_COMMA] = 0xff, /* qcode:Q_KEY_CODE_KP_COMMA (kp_comma) -> linux:121 (KEY_KPCOMMA) -> adb:255 */
+  [Q_KEY_CODE_KP_DECIMAL] = 0x41, /* qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) -> linux:83 (KEY_KPDOT) -> adb:65 */
+  [Q_KEY_CODE_KP_DIVIDE] = 0x4b, /* qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) -> linux:98 (KEY_KPSLASH) -> adb:75 */
+  [Q_KEY_CODE_KP_ENTER] = 0x4c, /* qcode:Q_KEY_CODE_KP_ENTER (kp_enter) -> linux:96 (KEY_KPENTER) -> adb:76 */
+  [Q_KEY_CODE_KP_EQUALS] = 0x51, /* qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) -> linux:117 (KEY_KPEQUAL) -> adb:81 */
+  [Q_KEY_CODE_KP_MULTIPLY] = 0x43, /* qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> adb:67 */
+  [Q_KEY_CODE_KP_SUBTRACT] = 0x4e, /* qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) -> linux:74 (KEY_KPMINUS) -> adb:78 */
+  [Q_KEY_CODE_L] = 0x25, /* qcode:Q_KEY_CODE_L (l) -> linux:38 (KEY_L) -> adb:37 */
+  [Q_KEY_CODE_LEFT] = 0x3b, /* qcode:Q_KEY_CODE_LEFT (left) -> linux:105 (KEY_LEFT) -> adb:59 */
+  [Q_KEY_CODE_LESS] = 0xff, /* qcode:Q_KEY_CODE_LESS (less) -> linux:86 (KEY_102ND) -> adb:255 */
+  [Q_KEY_CODE_LF] = 0xff, /* qcode:Q_KEY_CODE_LF (lf) -> linux:101 (KEY_LINEFEED) -> adb:255 */
+  [Q_KEY_CODE_M] = 0x2e, /* qcode:Q_KEY_CODE_M (m) -> linux:50 (KEY_M) -> adb:46 */
+  [Q_KEY_CODE_MAIL] = 0xff, /* qcode:Q_KEY_CODE_MAIL (mail) -> linux:155 (KEY_MAIL) -> adb:255 */
+  [Q_KEY_CODE_MEDIASELECT] = 0xff, /* qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) -> linux:226 (KEY_MEDIA) -> adb:255 */
+  [Q_KEY_CODE_MENU] = 0xff, /* qcode:Q_KEY_CODE_MENU (menu) -> linux:139 (KEY_MENU) -> adb:255 */
+  [Q_KEY_CODE_META_L] = 0x37, /* qcode:Q_KEY_CODE_META_L (meta_l) -> linux:125 (KEY_LEFTMETA) -> adb:55 */
+  [Q_KEY_CODE_META_R] = 0x37, /* qcode:Q_KEY_CODE_META_R (meta_r) -> linux:126 (KEY_RIGHTMETA) -> adb:55 */
+  [Q_KEY_CODE_MINUS] = 0x1b, /* qcode:Q_KEY_CODE_MINUS (minus) -> linux:12 (KEY_MINUS) -> adb:27 */
+  [Q_KEY_CODE_N] = 0x2d, /* qcode:Q_KEY_CODE_N (n) -> linux:49 (KEY_N) -> adb:45 */
+  [Q_KEY_CODE_NUM_LOCK] = 0x47, /* qcode:Q_KEY_CODE_NUM_LOCK (num_lock) -> linux:69 (KEY_NUMLOCK) -> adb:71 */
+  [Q_KEY_CODE_O] = 0x1f, /* qcode:Q_KEY_CODE_O (o) -> linux:24 (KEY_O) -> adb:31 */
+  [Q_KEY_CODE_OPEN] = 0xff, /* qcode:Q_KEY_CODE_OPEN (open) -> linux:134 (KEY_OPEN) -> adb:255 */
+  [Q_KEY_CODE_P] = 0x23, /* qcode:Q_KEY_CODE_P (p) -> linux:25 (KEY_P) -> adb:35 */
+  [Q_KEY_CODE_PASTE] = 0xff, /* qcode:Q_KEY_CODE_PASTE (paste) -> linux:135 (KEY_PASTE) -> adb:255 */
+  [Q_KEY_CODE_PAUSE] = 0x71, /* qcode:Q_KEY_CODE_PAUSE (pause) -> linux:119 (KEY_PAUSE) -> adb:113 */
+  [Q_KEY_CODE_PGDN] = 0x79, /* qcode:Q_KEY_CODE_PGDN (pgdn) -> linux:109 (KEY_PAGEDOWN) -> adb:121 */
+  [Q_KEY_CODE_PGUP] = 0x74, /* qcode:Q_KEY_CODE_PGUP (pgup) -> linux:104 (KEY_PAGEUP) -> adb:116 */
+  [Q_KEY_CODE_POWER] = 0x7f7f, /* qcode:Q_KEY_CODE_POWER (power) -> linux:116 (KEY_POWER) -> adb:32639 */
+  [Q_KEY_CODE_PRINT] = 0x69, /* qcode:Q_KEY_CODE_PRINT (sysrq) -> linux:99 (KEY_SYSRQ) -> adb:105 */
+  [Q_KEY_CODE_PROPS] = 0xff, /* qcode:Q_KEY_CODE_PROPS (props) -> linux:130 (KEY_PROPS) -> adb:255 */
+  [Q_KEY_CODE_Q] = 0xc, /* qcode:Q_KEY_CODE_Q (q) -> linux:16 (KEY_Q) -> adb:12 */
+  [Q_KEY_CODE_R] = 0xf, /* qcode:Q_KEY_CODE_R (r) -> linux:19 (KEY_R) -> adb:15 */
+  [Q_KEY_CODE_RET] = 0x24, /* qcode:Q_KEY_CODE_RET (ret) -> linux:28 (KEY_ENTER) -> adb:36 */
+  [Q_KEY_CODE_RIGHT] = 0x3c, /* qcode:Q_KEY_CODE_RIGHT (right) -> linux:106 (KEY_RIGHT) -> adb:60 */
+  [Q_KEY_CODE_RO] = 0xff, /* qcode:Q_KEY_CODE_RO (ro) -> linux:89 (KEY_RO) -> adb:255 */
+  [Q_KEY_CODE_S] = 0x1, /* qcode:Q_KEY_CODE_S (s) -> linux:31 (KEY_S) -> adb:1 */
+  [Q_KEY_CODE_SCROLL_LOCK] = 0x6b, /* qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) -> linux:70 (KEY_SCROLLLOCK) -> adb:107 */
+  [Q_KEY_CODE_SEMICOLON] = 0x29, /* qcode:Q_KEY_CODE_SEMICOLON (semicolon) -> linux:39 (KEY_SEMICOLON) -> adb:41 */
+  [Q_KEY_CODE_SHIFT] = 0x38, /* qcode:Q_KEY_CODE_SHIFT (shift) -> linux:42 (KEY_LEFTSHIFT) -> adb:56 */
+  [Q_KEY_CODE_SHIFT_R] = 0x7b, /* qcode:Q_KEY_CODE_SHIFT_R (shift_r) -> linux:54 (KEY_RIGHTSHIFT) -> adb:123 */
+  [Q_KEY_CODE_SLASH] = 0x2c, /* qcode:Q_KEY_CODE_SLASH (slash) -> linux:53 (KEY_SLASH) -> adb:44 */
+  [Q_KEY_CODE_SLEEP] = 0xff, /* qcode:Q_KEY_CODE_SLEEP (sleep) -> linux:142 (KEY_SLEEP) -> adb:255 */
+  [Q_KEY_CODE_SPC] = 0x31, /* qcode:Q_KEY_CODE_SPC (spc) -> linux:57 (KEY_SPACE) -> adb:49 */
+  [Q_KEY_CODE_STOP] = 0xff, /* qcode:Q_KEY_CODE_STOP (stop) -> linux:128 (KEY_STOP) -> adb:255 */
+  [Q_KEY_CODE_SYSRQ] = 0x69, /* qcode:Q_KEY_CODE_SYSRQ (sysrq) -> linux:99 (KEY_SYSRQ) -> adb:105 */
+  [Q_KEY_CODE_T] = 0x11, /* qcode:Q_KEY_CODE_T (t) -> linux:20 (KEY_T) -> adb:17 */
+  [Q_KEY_CODE_TAB] = 0x30, /* qcode:Q_KEY_CODE_TAB (tab) -> linux:15 (KEY_TAB) -> adb:48 */
+  [Q_KEY_CODE_U] = 0x20, /* qcode:Q_KEY_CODE_U (u) -> linux:22 (KEY_U) -> adb:32 */
+  [Q_KEY_CODE_UNDO] = 0xff, /* qcode:Q_KEY_CODE_UNDO (undo) -> linux:131 (KEY_UNDO) -> adb:255 */
+  [Q_KEY_CODE_UNMAPPED] = 0xff, /* qcode:Q_KEY_CODE_UNMAPPED (unmapped) -> linux:0 (KEY_RESERVED) -> adb:255 */
+  [Q_KEY_CODE_UP] = 0x3e, /* qcode:Q_KEY_CODE_UP (up) -> linux:103 (KEY_UP) -> adb:62 */
+  [Q_KEY_CODE_V] = 0x9, /* qcode:Q_KEY_CODE_V (v) -> linux:47 (KEY_V) -> adb:9 */
+  [Q_KEY_CODE_VOLUMEDOWN] = 0xff, /* qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) -> linux:114 (KEY_VOLUMEDOWN) -> adb:255 */
+  [Q_KEY_CODE_VOLUMEUP] = 0xff, /* qcode:Q_KEY_CODE_VOLUMEUP (volumeup) -> linux:115 (KEY_VOLUMEUP) -> adb:255 */
+  [Q_KEY_CODE_W] = 0xd, /* qcode:Q_KEY_CODE_W (w) -> linux:17 (KEY_W) -> adb:13 */
+  [Q_KEY_CODE_WAKE] = 0xff, /* qcode:Q_KEY_CODE_WAKE (wake) -> linux:143 (KEY_WAKEUP) -> adb:255 */
+  [Q_KEY_CODE_X] = 0x7, /* qcode:Q_KEY_CODE_X (x) -> linux:45 (KEY_X) -> adb:7 */
+  [Q_KEY_CODE_Y] = 0x10, /* qcode:Q_KEY_CODE_Y (y) -> linux:21 (KEY_Y) -> adb:16 */
+  [Q_KEY_CODE_YEN] = 0xff, /* qcode:Q_KEY_CODE_YEN (yen) -> linux:124 (KEY_YEN) -> adb:255 */
+  [Q_KEY_CODE_Z] = 0x6, /* qcode:Q_KEY_CODE_Z (z) -> linux:44 (KEY_Z) -> adb:6 */
+};
+const guint qemu_input_map_qcode_to_adb_len = sizeof(qemu_input_map_qcode_to_adb)/sizeof(qemu_input_map_qcode_to_adb[0]);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index d90f6a16f7..5d97a38c42 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -6,6 +6,7 @@
 #include "standard-headers/linux/input.h"
 
 #include "ui/input-keymap-linux-to-qcode.c"
+#include "ui/input-keymap-qcode-to-adb.c"
 #include "ui/input-keymap-qcode-to-atset1.c"
 #include "ui/input-keymap-qcode-to-atset2.c"
 #include "ui/input-keymap-qcode-to-atset3.c"
-- 
2.13.5
