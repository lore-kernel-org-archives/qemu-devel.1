Received: from eggs.gnu.org ([2001:4830:134:3::10]:47638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCwx-0007dM-Pg
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCwv-0001wx-NS
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhCwv-0001wf-E9
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 680AF70005
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 10:50:20 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 14 Aug 2017 11:49:53 +0100
Message-Id: <20170814104958.29434-8-berrange@redhat.com>
In-Reply-To: <20170814104958.29434-1-berrange@redhat.com>
References: <20170814104958.29434-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/12] input: convert the adb device to
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
 hw/input/adb.c              | 124 +-------------------------------------
 include/hw/input/adb-keys.h | 141 --------------------------------------------
 include/ui/input.h          |   3 +
 ui/Makefile.objs            |   1 +
 ui/input-keymap.c           |   1 +
 5 files changed, 7 insertions(+), 263 deletions(-)
 delete mode 100644 include/hw/input/adb-keys.h

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
index b92d49ccc8..3e16fc7304 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -55,6 +55,7 @@ KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux-to-qcode.c \
+		 ui/input-keymap-qcode-to-adb.c \
 		 ui/input-keymap-qcode-to-atset1.c \
 		 ui/input-keymap-qcode-to-atset2.c \
 		 ui/input-keymap-qcode-to-atset3.c \
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
2.13.3
