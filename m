Received: from eggs.gnu.org ([2001:4830:134:3::10]:47569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCwr-0007Yz-Sy
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCwp-0001uN-Qi
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhCwp-0001sz-H3
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76178C047B9C
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 10:50:14 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 14 Aug 2017 11:49:48 +0100
Message-Id: <20170814104958.29434-3-berrange@redhat.com>
In-Reply-To: <20170814104958.29434-1-berrange@redhat.com>
References: <20170814104958.29434-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/12] ui: convert common input code to
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
 include/ui/input.h |  11 +-
 ui/Makefile.objs   |   3 +
 ui/input-keymap.c  | 326 +++--------------------------------------------------
 3 files changed, 28 insertions(+), 312 deletions(-)

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
index 6796a9f98b..8c357b488f 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -54,6 +54,9 @@ KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
+		 ui/input-keymap-linux-to-qcode.c \
+		 ui/input-keymap-qcode-to-qnum.c \
+		 ui/input-keymap-qnum-to-qcode.c \
 		 $(NULL)
 
 GENERATED_FILES += $(KEYCODEMAP_FILES)
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
2.13.3
