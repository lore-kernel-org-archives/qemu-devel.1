Received: from eggs.gnu.org ([2001:4830:134:3::10]:48637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS8-0000lQ-MV
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS0-0003Ro-VI
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkS0-0003RO-Iu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A68B859FA
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:37:59 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 13:37:37 +0100
Message-Id: <20170912123744.14730-6-berrange@redhat.com>
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/12] input: convert virtio-input-hid
 device to keycodemapdb
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

Replace the keymap_qcode table with automatically generated
tables.

Missing entries in keymap_qcode now fixed:

  Q_KEY_CODE_ASTERISK -> KEY_KPASTERISK
  Q_KEY_CODE_KP_MULTIPLY -> KEY_KPASTERISK
  Q_KEY_CODE_STOP -> KEY_STOP
  Q_KEY_CODE_AGAIN -> KEY_AGAIN
  Q_KEY_CODE_PROPS -> KEY_PROPS
  Q_KEY_CODE_UNDO -> KEY_UNDO
  Q_KEY_CODE_FRONT -> KEY_FRONT
  Q_KEY_CODE_COPY -> KEY_COPY
  Q_KEY_CODE_OPEN -> KEY_OPEN
  Q_KEY_CODE_PASTE -> KEY_PASTE
  Q_KEY_CODE_FIND -> KEY_FIND
  Q_KEY_CODE_CUT -> KEY_CUT
  Q_KEY_CODE_LF -> KEY_LINEFEED
  Q_KEY_CODE_HELP -> KEY_HELP
  Q_KEY_CODE_COMPOSE -> KEY_COMPOSE
  Q_KEY_CODE_RO -> KEY_RO
  Q_KEY_CODE_HIRAGANA -> KEY_HIRAGANA
  Q_KEY_CODE_HENKAN -> KEY_HENKAN
  Q_KEY_CODE_YEN -> KEY_YEN
  Q_KEY_CODE_KP_COMMA -> KEY_KPCOMMA
  Q_KEY_CODE_KP_EQUALS -> KEY_KPEQUAL
  Q_KEY_CODE_POWER -> KEY_POWER
  Q_KEY_CODE_SLEEP -> KEY_SLEEP
  Q_KEY_CODE_WAKE -> KEY_WAKEUP
  Q_KEY_CODE_AUDIONEXT -> KEY_NEXTSONG
  Q_KEY_CODE_AUDIOPREV -> KEY_PREVIOUSSONG
  Q_KEY_CODE_AUDIOSTOP -> KEY_STOPCD
  Q_KEY_CODE_AUDIOPLAY -> KEY_PLAYPAUSE
  Q_KEY_CODE_AUDIOMUTE -> KEY_MUTE
  Q_KEY_CODE_VOLUMEUP -> KEY_VOLUMEUP
  Q_KEY_CODE_VOLUMEDOWN -> KEY_VOLUMEDOWN
  Q_KEY_CODE_MEDIASELECT -> KEY_MEDIA
  Q_KEY_CODE_MAIL -> KEY_MAIL
  Q_KEY_CODE_CALCULATOR -> KEY_CALC
  Q_KEY_CODE_COMPUTER -> KEY_COMPUTER
  Q_KEY_CODE_AC_HOME -> KEY_HOMEPAGE
  Q_KEY_CODE_AC_BACK -> KEY_BACK
  Q_KEY_CODE_AC_FORWARD -> KEY_FORWARD
  Q_KEY_CODE_AC_REFRESH -> KEY_REFRESH
  Q_KEY_CODE_AC_BOOKMARKS -> KEY_BOOKMARKS

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/input/virtio-input-hid.c      | 136 +++-------------------------------
 include/ui/input.h               |   3 +
 ui/Makefile.objs                 |   1 +
 ui/input-keymap-qcode-to-linux.c | 156 +++++++++++++++++++++++++++++++++++++++
 ui/input-keymap.c                |   1 +
 5 files changed, 170 insertions(+), 127 deletions(-)
 create mode 100644 ui/input-keymap-qcode-to-linux.c

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 4d3afc1b14..bb1296bedf 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -22,126 +22,7 @@
 
 /* ----------------------------------------------------------------- */
 
-static const unsigned int keymap_qcode[Q_KEY_CODE__MAX] = {
-    [Q_KEY_CODE_ESC]                 = KEY_ESC,
-    [Q_KEY_CODE_1]                   = KEY_1,
-    [Q_KEY_CODE_2]                   = KEY_2,
-    [Q_KEY_CODE_3]                   = KEY_3,
-    [Q_KEY_CODE_4]                   = KEY_4,
-    [Q_KEY_CODE_5]                   = KEY_5,
-    [Q_KEY_CODE_6]                   = KEY_6,
-    [Q_KEY_CODE_7]                   = KEY_7,
-    [Q_KEY_CODE_8]                   = KEY_8,
-    [Q_KEY_CODE_9]                   = KEY_9,
-    [Q_KEY_CODE_0]                   = KEY_0,
-    [Q_KEY_CODE_MINUS]               = KEY_MINUS,
-    [Q_KEY_CODE_EQUAL]               = KEY_EQUAL,
-    [Q_KEY_CODE_BACKSPACE]           = KEY_BACKSPACE,
-
-    [Q_KEY_CODE_TAB]                 = KEY_TAB,
-    [Q_KEY_CODE_Q]                   = KEY_Q,
-    [Q_KEY_CODE_W]                   = KEY_W,
-    [Q_KEY_CODE_E]                   = KEY_E,
-    [Q_KEY_CODE_R]                   = KEY_R,
-    [Q_KEY_CODE_T]                   = KEY_T,
-    [Q_KEY_CODE_Y]                   = KEY_Y,
-    [Q_KEY_CODE_U]                   = KEY_U,
-    [Q_KEY_CODE_I]                   = KEY_I,
-    [Q_KEY_CODE_O]                   = KEY_O,
-    [Q_KEY_CODE_P]                   = KEY_P,
-    [Q_KEY_CODE_BRACKET_LEFT]        = KEY_LEFTBRACE,
-    [Q_KEY_CODE_BRACKET_RIGHT]       = KEY_RIGHTBRACE,
-    [Q_KEY_CODE_RET]                 = KEY_ENTER,
-
-    [Q_KEY_CODE_CTRL]                = KEY_LEFTCTRL,
-    [Q_KEY_CODE_A]                   = KEY_A,
-    [Q_KEY_CODE_S]                   = KEY_S,
-    [Q_KEY_CODE_D]                   = KEY_D,
-    [Q_KEY_CODE_F]                   = KEY_F,
-    [Q_KEY_CODE_G]                   = KEY_G,
-    [Q_KEY_CODE_H]                   = KEY_H,
-    [Q_KEY_CODE_J]                   = KEY_J,
-    [Q_KEY_CODE_K]                   = KEY_K,
-    [Q_KEY_CODE_L]                   = KEY_L,
-    [Q_KEY_CODE_SEMICOLON]           = KEY_SEMICOLON,
-    [Q_KEY_CODE_APOSTROPHE]          = KEY_APOSTROPHE,
-    [Q_KEY_CODE_GRAVE_ACCENT]        = KEY_GRAVE,
-
-    [Q_KEY_CODE_SHIFT]               = KEY_LEFTSHIFT,
-    [Q_KEY_CODE_BACKSLASH]           = KEY_BACKSLASH,
-    [Q_KEY_CODE_LESS]                = KEY_102ND,
-    [Q_KEY_CODE_Z]                   = KEY_Z,
-    [Q_KEY_CODE_X]                   = KEY_X,
-    [Q_KEY_CODE_C]                   = KEY_C,
-    [Q_KEY_CODE_V]                   = KEY_V,
-    [Q_KEY_CODE_B]                   = KEY_B,
-    [Q_KEY_CODE_N]                   = KEY_N,
-    [Q_KEY_CODE_M]                   = KEY_M,
-    [Q_KEY_CODE_COMMA]               = KEY_COMMA,
-    [Q_KEY_CODE_DOT]                 = KEY_DOT,
-    [Q_KEY_CODE_SLASH]               = KEY_SLASH,
-    [Q_KEY_CODE_SHIFT_R]             = KEY_RIGHTSHIFT,
-
-    [Q_KEY_CODE_ALT]                 = KEY_LEFTALT,
-    [Q_KEY_CODE_SPC]                 = KEY_SPACE,
-    [Q_KEY_CODE_CAPS_LOCK]           = KEY_CAPSLOCK,
-
-    [Q_KEY_CODE_F1]                  = KEY_F1,
-    [Q_KEY_CODE_F2]                  = KEY_F2,
-    [Q_KEY_CODE_F3]                  = KEY_F3,
-    [Q_KEY_CODE_F4]                  = KEY_F4,
-    [Q_KEY_CODE_F5]                  = KEY_F5,
-    [Q_KEY_CODE_F6]                  = KEY_F6,
-    [Q_KEY_CODE_F7]                  = KEY_F7,
-    [Q_KEY_CODE_F8]                  = KEY_F8,
-    [Q_KEY_CODE_F9]                  = KEY_F9,
-    [Q_KEY_CODE_F10]                 = KEY_F10,
-    [Q_KEY_CODE_NUM_LOCK]            = KEY_NUMLOCK,
-    [Q_KEY_CODE_SCROLL_LOCK]         = KEY_SCROLLLOCK,
-
-    [Q_KEY_CODE_KP_0]                = KEY_KP0,
-    [Q_KEY_CODE_KP_1]                = KEY_KP1,
-    [Q_KEY_CODE_KP_2]                = KEY_KP2,
-    [Q_KEY_CODE_KP_3]                = KEY_KP3,
-    [Q_KEY_CODE_KP_4]                = KEY_KP4,
-    [Q_KEY_CODE_KP_5]                = KEY_KP5,
-    [Q_KEY_CODE_KP_6]                = KEY_KP6,
-    [Q_KEY_CODE_KP_7]                = KEY_KP7,
-    [Q_KEY_CODE_KP_8]                = KEY_KP8,
-    [Q_KEY_CODE_KP_9]                = KEY_KP9,
-    [Q_KEY_CODE_KP_SUBTRACT]         = KEY_KPMINUS,
-    [Q_KEY_CODE_KP_ADD]              = KEY_KPPLUS,
-    [Q_KEY_CODE_KP_DECIMAL]          = KEY_KPDOT,
-    [Q_KEY_CODE_KP_ENTER]            = KEY_KPENTER,
-    [Q_KEY_CODE_KP_DIVIDE]           = KEY_KPSLASH,
-    [Q_KEY_CODE_KP_MULTIPLY]         = KEY_KPASTERISK,
-
-    [Q_KEY_CODE_F11]                 = KEY_F11,
-    [Q_KEY_CODE_F12]                 = KEY_F12,
-
-    [Q_KEY_CODE_CTRL_R]              = KEY_RIGHTCTRL,
-    [Q_KEY_CODE_SYSRQ]               = KEY_SYSRQ,
-    [Q_KEY_CODE_PRINT]               = KEY_SYSRQ,
-    [Q_KEY_CODE_PAUSE]               = KEY_PAUSE,
-    [Q_KEY_CODE_ALT_R]               = KEY_RIGHTALT,
-
-    [Q_KEY_CODE_HOME]                = KEY_HOME,
-    [Q_KEY_CODE_UP]                  = KEY_UP,
-    [Q_KEY_CODE_PGUP]                = KEY_PAGEUP,
-    [Q_KEY_CODE_LEFT]                = KEY_LEFT,
-    [Q_KEY_CODE_RIGHT]               = KEY_RIGHT,
-    [Q_KEY_CODE_END]                 = KEY_END,
-    [Q_KEY_CODE_DOWN]                = KEY_DOWN,
-    [Q_KEY_CODE_PGDN]                = KEY_PAGEDOWN,
-    [Q_KEY_CODE_INSERT]              = KEY_INSERT,
-    [Q_KEY_CODE_DELETE]              = KEY_DELETE,
-
-    [Q_KEY_CODE_META_L]              = KEY_LEFTMETA,
-    [Q_KEY_CODE_META_R]              = KEY_RIGHTMETA,
-    [Q_KEY_CODE_MENU]                = KEY_MENU,
-};
-
-static const unsigned int keymap_button[INPUT_BUTTON__MAX] = {
+static const unsigned short keymap_button[INPUT_BUTTON__MAX] = {
     [INPUT_BUTTON_LEFT]              = BTN_LEFT,
     [INPUT_BUTTON_RIGHT]             = BTN_RIGHT,
     [INPUT_BUTTON_MIDDLE]            = BTN_MIDDLE,
@@ -149,12 +30,12 @@ static const unsigned int keymap_button[INPUT_BUTTON__MAX] = {
     [INPUT_BUTTON_WHEEL_DOWN]        = BTN_GEAR_DOWN,
 };
 
-static const unsigned int axismap_rel[INPUT_AXIS__MAX] = {
+static const unsigned short axismap_rel[INPUT_AXIS__MAX] = {
     [INPUT_AXIS_X]                   = REL_X,
     [INPUT_AXIS_Y]                   = REL_Y,
 };
 
-static const unsigned int axismap_abs[INPUT_AXIS__MAX] = {
+static const unsigned short axismap_abs[INPUT_AXIS__MAX] = {
     [INPUT_AXIS_X]                   = ABS_X,
     [INPUT_AXIS_Y]                   = ABS_Y,
 };
@@ -162,7 +43,7 @@ static const unsigned int axismap_abs[INPUT_AXIS__MAX] = {
 /* ----------------------------------------------------------------- */
 
 static void virtio_input_key_config(VirtIOInput *vinput,
-                                    const unsigned int *keymap,
+                                    const unsigned short *keymap,
                                     size_t mapsize)
 {
     virtio_input_config keys;
@@ -201,9 +82,10 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
     case INPUT_EVENT_KIND_KEY:
         key = evt->u.key.data;
         qcode = qemu_input_key_value_to_qcode(key->key);
-        if (qcode && keymap_qcode[qcode]) {
+        if (qcode < qemu_input_map_qcode_to_linux_len &&
+            qemu_input_map_qcode_to_linux[qcode]) {
             event.type  = cpu_to_le16(EV_KEY);
-            event.code  = cpu_to_le16(keymap_qcode[qcode]);
+            event.code  = cpu_to_le16(qemu_input_map_qcode_to_linux[qcode]);
             event.value = cpu_to_le32(key->down ? 1 : 0);
             virtio_input_send(vinput, &event);
         } else {
@@ -387,8 +269,8 @@ static void virtio_keyboard_init(Object *obj)
 
     vhid->handler = &virtio_keyboard_handler;
     virtio_input_init_config(vinput, virtio_keyboard_config);
-    virtio_input_key_config(vinput, keymap_qcode,
-                            ARRAY_SIZE(keymap_qcode));
+    virtio_input_key_config(vinput, qemu_input_map_qcode_to_linux,
+                            qemu_input_map_qcode_to_linux_len);
 }
 
 static const TypeInfo virtio_keyboard_info = {
diff --git a/include/ui/input.h b/include/ui/input.h
index f8cee43f65..6f56d868c7 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -71,6 +71,9 @@ void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 extern const guint qemu_input_map_linux_to_qcode_len;
 extern const guint16 qemu_input_map_linux_to_qcode[];
 
+extern const guint qemu_input_map_qcode_to_linux_len;
+extern const guint16 qemu_input_map_qcode_to_linux[];
+
 extern const guint qemu_input_map_qcode_to_qnum_len;
 extern const guint16 qemu_input_map_qcode_to_qnum[];
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 29e44c1baf..baf6f4e56f 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -55,6 +55,7 @@ KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux-to-qcode.c \
+		 ui/input-keymap-qcode-to-linux.c \
 		 ui/input-keymap-qcode-to-qnum.c \
 		 ui/input-keymap-qnum-to-qcode.c \
 		 $(NULL)
diff --git a/ui/input-keymap-qcode-to-linux.c b/ui/input-keymap-qcode-to-linux.c
new file mode 100644
index 0000000000..2a718566fb
--- /dev/null
+++ b/ui/input-keymap-qcode-to-linux.c
@@ -0,0 +1,156 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:06
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_qcode_to_linux code-map keymaps.csv qcode linux
+*/
+const guint16 qemu_input_map_qcode_to_linux[Q_KEY_CODE__MAX] = {
+  [0 ... Q_KEY_CODE__MAX-1] = 0x0,
+  [Q_KEY_CODE_0] = 0xb, /* qcode:Q_KEY_CODE_0 (0) -> linux:11 (KEY_0) -> linux:11 (KEY_0) */
+  [Q_KEY_CODE_1] = 0x2, /* qcode:Q_KEY_CODE_1 (1) -> linux:2 (KEY_1) -> linux:2 (KEY_1) */
+  [Q_KEY_CODE_2] = 0x3, /* qcode:Q_KEY_CODE_2 (2) -> linux:3 (KEY_2) -> linux:3 (KEY_2) */
+  [Q_KEY_CODE_3] = 0x4, /* qcode:Q_KEY_CODE_3 (3) -> linux:4 (KEY_3) -> linux:4 (KEY_3) */
+  [Q_KEY_CODE_4] = 0x5, /* qcode:Q_KEY_CODE_4 (4) -> linux:5 (KEY_4) -> linux:5 (KEY_4) */
+  [Q_KEY_CODE_5] = 0x6, /* qcode:Q_KEY_CODE_5 (5) -> linux:6 (KEY_5) -> linux:6 (KEY_5) */
+  [Q_KEY_CODE_6] = 0x7, /* qcode:Q_KEY_CODE_6 (6) -> linux:7 (KEY_6) -> linux:7 (KEY_6) */
+  [Q_KEY_CODE_7] = 0x8, /* qcode:Q_KEY_CODE_7 (7) -> linux:8 (KEY_7) -> linux:8 (KEY_7) */
+  [Q_KEY_CODE_8] = 0x9, /* qcode:Q_KEY_CODE_8 (8) -> linux:9 (KEY_8) -> linux:9 (KEY_8) */
+  [Q_KEY_CODE_9] = 0xa, /* qcode:Q_KEY_CODE_9 (9) -> linux:10 (KEY_9) -> linux:10 (KEY_9) */
+  [Q_KEY_CODE_A] = 0x1e, /* qcode:Q_KEY_CODE_A (a) -> linux:30 (KEY_A) -> linux:30 (KEY_A) */
+  [Q_KEY_CODE_AC_BACK] = 0x9e, /* qcode:Q_KEY_CODE_AC_BACK (ac_back) -> linux:158 (KEY_BACK) -> linux:158 (KEY_BACK) */
+  [Q_KEY_CODE_AC_BOOKMARKS] = 0x9c, /* qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) -> linux:156 (KEY_BOOKMARKS) -> linux:156 (KEY_BOOKMARKS) */
+  [Q_KEY_CODE_AC_FORWARD] = 0x9f, /* qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) -> linux:159 (KEY_FORWARD) -> linux:159 (KEY_FORWARD) */
+  [Q_KEY_CODE_AC_HOME] = 0xac, /* qcode:Q_KEY_CODE_AC_HOME (ac_home) -> linux:172 (KEY_HOMEPAGE) -> linux:172 (KEY_HOMEPAGE) */
+  [Q_KEY_CODE_AC_REFRESH] = 0xad, /* qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) -> linux:173 (KEY_REFRESH) -> linux:173 (KEY_REFRESH) */
+  [Q_KEY_CODE_AGAIN] = 0x81, /* qcode:Q_KEY_CODE_AGAIN (again) -> linux:129 (KEY_AGAIN) -> linux:129 (KEY_AGAIN) */
+  [Q_KEY_CODE_ALT] = 0x38, /* qcode:Q_KEY_CODE_ALT (alt) -> linux:56 (KEY_LEFTALT) -> linux:56 (KEY_LEFTALT) */
+  [Q_KEY_CODE_ALT_R] = 0x64, /* qcode:Q_KEY_CODE_ALT_R (alt_r) -> linux:100 (KEY_RIGHTALT) -> linux:100 (KEY_RIGHTALT) */
+  [Q_KEY_CODE_APOSTROPHE] = 0x28, /* qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) -> linux:40 (KEY_APOSTROPHE) -> linux:40 (KEY_APOSTROPHE) */
+  [Q_KEY_CODE_ASTERISK] = 0x37, /* qcode:Q_KEY_CODE_ASTERISK (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> linux:55 (KEY_KPASTERISK) */
+  [Q_KEY_CODE_AUDIOMUTE] = 0x71, /* qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) -> linux:113 (KEY_MUTE) -> linux:113 (KEY_MUTE) */
+  [Q_KEY_CODE_AUDIONEXT] = 0xa3, /* qcode:Q_KEY_CODE_AUDIONEXT (audionext) -> linux:163 (KEY_NEXTSONG) -> linux:163 (KEY_NEXTSONG) */
+  [Q_KEY_CODE_AUDIOPLAY] = 0xa4, /* qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) -> linux:164 (KEY_PLAYPAUSE) -> linux:164 (KEY_PLAYPAUSE) */
+  [Q_KEY_CODE_AUDIOPREV] = 0xa5, /* qcode:Q_KEY_CODE_AUDIOPREV (audioprev) -> linux:165 (KEY_PREVIOUSSONG) -> linux:165 (KEY_PREVIOUSSONG) */
+  [Q_KEY_CODE_AUDIOSTOP] = 0xa6, /* qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) -> linux:166 (KEY_STOPCD) -> linux:166 (KEY_STOPCD) */
+  [Q_KEY_CODE_B] = 0x30, /* qcode:Q_KEY_CODE_B (b) -> linux:48 (KEY_B) -> linux:48 (KEY_B) */
+  [Q_KEY_CODE_BACKSLASH] = 0x2b, /* qcode:Q_KEY_CODE_BACKSLASH (backslash) -> linux:43 (KEY_BACKSLASH) -> linux:43 (KEY_BACKSLASH) */
+  [Q_KEY_CODE_BACKSPACE] = 0xe, /* qcode:Q_KEY_CODE_BACKSPACE (backspace) -> linux:14 (KEY_BACKSPACE) -> linux:14 (KEY_BACKSPACE) */
+  [Q_KEY_CODE_BRACKET_LEFT] = 0x1a, /* qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) -> linux:26 (KEY_LEFTBRACE) -> linux:26 (KEY_LEFTBRACE) */
+  [Q_KEY_CODE_BRACKET_RIGHT] = 0x1b, /* qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) -> linux:27 (KEY_RIGHTBRACE) -> linux:27 (KEY_RIGHTBRACE) */
+  [Q_KEY_CODE_C] = 0x2e, /* qcode:Q_KEY_CODE_C (c) -> linux:46 (KEY_C) -> linux:46 (KEY_C) */
+  [Q_KEY_CODE_CALCULATOR] = 0x8c, /* qcode:Q_KEY_CODE_CALCULATOR (calculator) -> linux:140 (KEY_CALC) -> linux:140 (KEY_CALC) */
+  [Q_KEY_CODE_CAPS_LOCK] = 0x3a, /* qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) -> linux:58 (KEY_CAPSLOCK) -> linux:58 (KEY_CAPSLOCK) */
+  [Q_KEY_CODE_COMMA] = 0x33, /* qcode:Q_KEY_CODE_COMMA (comma) -> linux:51 (KEY_COMMA) -> linux:51 (KEY_COMMA) */
+  [Q_KEY_CODE_COMPOSE] = 0x7f, /* qcode:Q_KEY_CODE_COMPOSE (compose) -> linux:127 (KEY_COMPOSE) -> linux:127 (KEY_COMPOSE) */
+  [Q_KEY_CODE_COMPUTER] = 0x9d, /* qcode:Q_KEY_CODE_COMPUTER (computer) -> linux:157 (KEY_COMPUTER) -> linux:157 (KEY_COMPUTER) */
+  [Q_KEY_CODE_COPY] = 0x85, /* qcode:Q_KEY_CODE_COPY (copy) -> linux:133 (KEY_COPY) -> linux:133 (KEY_COPY) */
+  [Q_KEY_CODE_CTRL] = 0x1d, /* qcode:Q_KEY_CODE_CTRL (ctrl) -> linux:29 (KEY_LEFTCTRL) -> linux:29 (KEY_LEFTCTRL) */
+  [Q_KEY_CODE_CTRL_R] = 0x61, /* qcode:Q_KEY_CODE_CTRL_R (ctrl_r) -> linux:97 (KEY_RIGHTCTRL) -> linux:97 (KEY_RIGHTCTRL) */
+  [Q_KEY_CODE_CUT] = 0x89, /* qcode:Q_KEY_CODE_CUT (cut) -> linux:137 (KEY_CUT) -> linux:137 (KEY_CUT) */
+  [Q_KEY_CODE_D] = 0x20, /* qcode:Q_KEY_CODE_D (d) -> linux:32 (KEY_D) -> linux:32 (KEY_D) */
+  [Q_KEY_CODE_DELETE] = 0x6f, /* qcode:Q_KEY_CODE_DELETE (delete) -> linux:111 (KEY_DELETE) -> linux:111 (KEY_DELETE) */
+  [Q_KEY_CODE_DOT] = 0x34, /* qcode:Q_KEY_CODE_DOT (dot) -> linux:52 (KEY_DOT) -> linux:52 (KEY_DOT) */
+  [Q_KEY_CODE_DOWN] = 0x6c, /* qcode:Q_KEY_CODE_DOWN (down) -> linux:108 (KEY_DOWN) -> linux:108 (KEY_DOWN) */
+  [Q_KEY_CODE_E] = 0x12, /* qcode:Q_KEY_CODE_E (e) -> linux:18 (KEY_E) -> linux:18 (KEY_E) */
+  [Q_KEY_CODE_END] = 0x6b, /* qcode:Q_KEY_CODE_END (end) -> linux:107 (KEY_END) -> linux:107 (KEY_END) */
+  [Q_KEY_CODE_EQUAL] = 0xd, /* qcode:Q_KEY_CODE_EQUAL (equal) -> linux:13 (KEY_EQUAL) -> linux:13 (KEY_EQUAL) */
+  [Q_KEY_CODE_ESC] = 0x1, /* qcode:Q_KEY_CODE_ESC (esc) -> linux:1 (KEY_ESC) -> linux:1 (KEY_ESC) */
+  [Q_KEY_CODE_F] = 0x21, /* qcode:Q_KEY_CODE_F (f) -> linux:33 (KEY_F) -> linux:33 (KEY_F) */
+  [Q_KEY_CODE_F1] = 0x3b, /* qcode:Q_KEY_CODE_F1 (f1) -> linux:59 (KEY_F1) -> linux:59 (KEY_F1) */
+  [Q_KEY_CODE_F10] = 0x44, /* qcode:Q_KEY_CODE_F10 (f10) -> linux:68 (KEY_F10) -> linux:68 (KEY_F10) */
+  [Q_KEY_CODE_F11] = 0x57, /* qcode:Q_KEY_CODE_F11 (f11) -> linux:87 (KEY_F11) -> linux:87 (KEY_F11) */
+  [Q_KEY_CODE_F12] = 0x58, /* qcode:Q_KEY_CODE_F12 (f12) -> linux:88 (KEY_F12) -> linux:88 (KEY_F12) */
+  [Q_KEY_CODE_F2] = 0x3c, /* qcode:Q_KEY_CODE_F2 (f2) -> linux:60 (KEY_F2) -> linux:60 (KEY_F2) */
+  [Q_KEY_CODE_F3] = 0x3d, /* qcode:Q_KEY_CODE_F3 (f3) -> linux:61 (KEY_F3) -> linux:61 (KEY_F3) */
+  [Q_KEY_CODE_F4] = 0x3e, /* qcode:Q_KEY_CODE_F4 (f4) -> linux:62 (KEY_F4) -> linux:62 (KEY_F4) */
+  [Q_KEY_CODE_F5] = 0x3f, /* qcode:Q_KEY_CODE_F5 (f5) -> linux:63 (KEY_F5) -> linux:63 (KEY_F5) */
+  [Q_KEY_CODE_F6] = 0x40, /* qcode:Q_KEY_CODE_F6 (f6) -> linux:64 (KEY_F6) -> linux:64 (KEY_F6) */
+  [Q_KEY_CODE_F7] = 0x41, /* qcode:Q_KEY_CODE_F7 (f7) -> linux:65 (KEY_F7) -> linux:65 (KEY_F7) */
+  [Q_KEY_CODE_F8] = 0x42, /* qcode:Q_KEY_CODE_F8 (f8) -> linux:66 (KEY_F8) -> linux:66 (KEY_F8) */
+  [Q_KEY_CODE_F9] = 0x43, /* qcode:Q_KEY_CODE_F9 (f9) -> linux:67 (KEY_F9) -> linux:67 (KEY_F9) */
+  [Q_KEY_CODE_FIND] = 0x88, /* qcode:Q_KEY_CODE_FIND (find) -> linux:136 (KEY_FIND) -> linux:136 (KEY_FIND) */
+  [Q_KEY_CODE_FRONT] = 0x84, /* qcode:Q_KEY_CODE_FRONT (front) -> linux:132 (KEY_FRONT) -> linux:132 (KEY_FRONT) */
+  [Q_KEY_CODE_G] = 0x22, /* qcode:Q_KEY_CODE_G (g) -> linux:34 (KEY_G) -> linux:34 (KEY_G) */
+  [Q_KEY_CODE_GRAVE_ACCENT] = 0x29, /* qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) -> linux:41 (KEY_GRAVE) -> linux:41 (KEY_GRAVE) */
+  [Q_KEY_CODE_H] = 0x23, /* qcode:Q_KEY_CODE_H (h) -> linux:35 (KEY_H) -> linux:35 (KEY_H) */
+  [Q_KEY_CODE_HELP] = 0x8a, /* qcode:Q_KEY_CODE_HELP (help) -> linux:138 (KEY_HELP) -> linux:138 (KEY_HELP) */
+  [Q_KEY_CODE_HENKAN] = 0x5c, /* qcode:Q_KEY_CODE_HENKAN (henkan) -> linux:92 (KEY_HENKAN) -> linux:92 (KEY_HENKAN) */
+  [Q_KEY_CODE_HIRAGANA] = 0x5b, /* qcode:Q_KEY_CODE_HIRAGANA (hiragana) -> linux:91 (KEY_HIRAGANA) -> linux:91 (KEY_HIRAGANA) */
+  [Q_KEY_CODE_HOME] = 0x66, /* qcode:Q_KEY_CODE_HOME (home) -> linux:102 (KEY_HOME) -> linux:102 (KEY_HOME) */
+  [Q_KEY_CODE_I] = 0x17, /* qcode:Q_KEY_CODE_I (i) -> linux:23 (KEY_I) -> linux:23 (KEY_I) */
+  [Q_KEY_CODE_INSERT] = 0x6e, /* qcode:Q_KEY_CODE_INSERT (insert) -> linux:110 (KEY_INSERT) -> linux:110 (KEY_INSERT) */
+  [Q_KEY_CODE_J] = 0x24, /* qcode:Q_KEY_CODE_J (j) -> linux:36 (KEY_J) -> linux:36 (KEY_J) */
+  [Q_KEY_CODE_K] = 0x25, /* qcode:Q_KEY_CODE_K (k) -> linux:37 (KEY_K) -> linux:37 (KEY_K) */
+  [Q_KEY_CODE_KP_0] = 0x52, /* qcode:Q_KEY_CODE_KP_0 (kp_0) -> linux:82 (KEY_KP0) -> linux:82 (KEY_KP0) */
+  [Q_KEY_CODE_KP_1] = 0x4f, /* qcode:Q_KEY_CODE_KP_1 (kp_1) -> linux:79 (KEY_KP1) -> linux:79 (KEY_KP1) */
+  [Q_KEY_CODE_KP_2] = 0x50, /* qcode:Q_KEY_CODE_KP_2 (kp_2) -> linux:80 (KEY_KP2) -> linux:80 (KEY_KP2) */
+  [Q_KEY_CODE_KP_3] = 0x51, /* qcode:Q_KEY_CODE_KP_3 (kp_3) -> linux:81 (KEY_KP3) -> linux:81 (KEY_KP3) */
+  [Q_KEY_CODE_KP_4] = 0x4b, /* qcode:Q_KEY_CODE_KP_4 (kp_4) -> linux:75 (KEY_KP4) -> linux:75 (KEY_KP4) */
+  [Q_KEY_CODE_KP_5] = 0x4c, /* qcode:Q_KEY_CODE_KP_5 (kp_5) -> linux:76 (KEY_KP5) -> linux:76 (KEY_KP5) */
+  [Q_KEY_CODE_KP_6] = 0x4d, /* qcode:Q_KEY_CODE_KP_6 (kp_6) -> linux:77 (KEY_KP6) -> linux:77 (KEY_KP6) */
+  [Q_KEY_CODE_KP_7] = 0x47, /* qcode:Q_KEY_CODE_KP_7 (kp_7) -> linux:71 (KEY_KP7) -> linux:71 (KEY_KP7) */
+  [Q_KEY_CODE_KP_8] = 0x48, /* qcode:Q_KEY_CODE_KP_8 (kp_8) -> linux:72 (KEY_KP8) -> linux:72 (KEY_KP8) */
+  [Q_KEY_CODE_KP_9] = 0x49, /* qcode:Q_KEY_CODE_KP_9 (kp_9) -> linux:73 (KEY_KP9) -> linux:73 (KEY_KP9) */
+  [Q_KEY_CODE_KP_ADD] = 0x4e, /* qcode:Q_KEY_CODE_KP_ADD (kp_add) -> linux:78 (KEY_KPPLUS) -> linux:78 (KEY_KPPLUS) */
+  [Q_KEY_CODE_KP_COMMA] = 0x79, /* qcode:Q_KEY_CODE_KP_COMMA (kp_comma) -> linux:121 (KEY_KPCOMMA) -> linux:121 (KEY_KPCOMMA) */
+  [Q_KEY_CODE_KP_DECIMAL] = 0x53, /* qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) -> linux:83 (KEY_KPDOT) -> linux:83 (KEY_KPDOT) */
+  [Q_KEY_CODE_KP_DIVIDE] = 0x62, /* qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) -> linux:98 (KEY_KPSLASH) -> linux:98 (KEY_KPSLASH) */
+  [Q_KEY_CODE_KP_ENTER] = 0x60, /* qcode:Q_KEY_CODE_KP_ENTER (kp_enter) -> linux:96 (KEY_KPENTER) -> linux:96 (KEY_KPENTER) */
+  [Q_KEY_CODE_KP_EQUALS] = 0x75, /* qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) -> linux:117 (KEY_KPEQUAL) -> linux:117 (KEY_KPEQUAL) */
+  [Q_KEY_CODE_KP_MULTIPLY] = 0x37, /* qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> linux:55 (KEY_KPASTERISK) */
+  [Q_KEY_CODE_KP_SUBTRACT] = 0x4a, /* qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) -> linux:74 (KEY_KPMINUS) -> linux:74 (KEY_KPMINUS) */
+  [Q_KEY_CODE_L] = 0x26, /* qcode:Q_KEY_CODE_L (l) -> linux:38 (KEY_L) -> linux:38 (KEY_L) */
+  [Q_KEY_CODE_LEFT] = 0x69, /* qcode:Q_KEY_CODE_LEFT (left) -> linux:105 (KEY_LEFT) -> linux:105 (KEY_LEFT) */
+  [Q_KEY_CODE_LESS] = 0x56, /* qcode:Q_KEY_CODE_LESS (less) -> linux:86 (KEY_102ND) -> linux:86 (KEY_102ND) */
+  [Q_KEY_CODE_LF] = 0x65, /* qcode:Q_KEY_CODE_LF (lf) -> linux:101 (KEY_LINEFEED) -> linux:101 (KEY_LINEFEED) */
+  [Q_KEY_CODE_M] = 0x32, /* qcode:Q_KEY_CODE_M (m) -> linux:50 (KEY_M) -> linux:50 (KEY_M) */
+  [Q_KEY_CODE_MAIL] = 0x9b, /* qcode:Q_KEY_CODE_MAIL (mail) -> linux:155 (KEY_MAIL) -> linux:155 (KEY_MAIL) */
+  [Q_KEY_CODE_MEDIASELECT] = 0xe2, /* qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) -> linux:226 (KEY_MEDIA) -> linux:226 (KEY_MEDIA) */
+  [Q_KEY_CODE_MENU] = 0x8b, /* qcode:Q_KEY_CODE_MENU (menu) -> linux:139 (KEY_MENU) -> linux:139 (KEY_MENU) */
+  [Q_KEY_CODE_META_L] = 0x7d, /* qcode:Q_KEY_CODE_META_L (meta_l) -> linux:125 (KEY_LEFTMETA) -> linux:125 (KEY_LEFTMETA) */
+  [Q_KEY_CODE_META_R] = 0x7e, /* qcode:Q_KEY_CODE_META_R (meta_r) -> linux:126 (KEY_RIGHTMETA) -> linux:126 (KEY_RIGHTMETA) */
+  [Q_KEY_CODE_MINUS] = 0xc, /* qcode:Q_KEY_CODE_MINUS (minus) -> linux:12 (KEY_MINUS) -> linux:12 (KEY_MINUS) */
+  [Q_KEY_CODE_N] = 0x31, /* qcode:Q_KEY_CODE_N (n) -> linux:49 (KEY_N) -> linux:49 (KEY_N) */
+  [Q_KEY_CODE_NUM_LOCK] = 0x45, /* qcode:Q_KEY_CODE_NUM_LOCK (num_lock) -> linux:69 (KEY_NUMLOCK) -> linux:69 (KEY_NUMLOCK) */
+  [Q_KEY_CODE_O] = 0x18, /* qcode:Q_KEY_CODE_O (o) -> linux:24 (KEY_O) -> linux:24 (KEY_O) */
+  [Q_KEY_CODE_OPEN] = 0x86, /* qcode:Q_KEY_CODE_OPEN (open) -> linux:134 (KEY_OPEN) -> linux:134 (KEY_OPEN) */
+  [Q_KEY_CODE_P] = 0x19, /* qcode:Q_KEY_CODE_P (p) -> linux:25 (KEY_P) -> linux:25 (KEY_P) */
+  [Q_KEY_CODE_PASTE] = 0x87, /* qcode:Q_KEY_CODE_PASTE (paste) -> linux:135 (KEY_PASTE) -> linux:135 (KEY_PASTE) */
+  [Q_KEY_CODE_PAUSE] = 0x77, /* qcode:Q_KEY_CODE_PAUSE (pause) -> linux:119 (KEY_PAUSE) -> linux:119 (KEY_PAUSE) */
+  [Q_KEY_CODE_PGDN] = 0x6d, /* qcode:Q_KEY_CODE_PGDN (pgdn) -> linux:109 (KEY_PAGEDOWN) -> linux:109 (KEY_PAGEDOWN) */
+  [Q_KEY_CODE_PGUP] = 0x68, /* qcode:Q_KEY_CODE_PGUP (pgup) -> linux:104 (KEY_PAGEUP) -> linux:104 (KEY_PAGEUP) */
+  [Q_KEY_CODE_POWER] = 0x74, /* qcode:Q_KEY_CODE_POWER (power) -> linux:116 (KEY_POWER) -> linux:116 (KEY_POWER) */
+  [Q_KEY_CODE_PRINT] = 0x63, /* qcode:Q_KEY_CODE_PRINT (sysrq) -> linux:99 (KEY_SYSRQ) -> linux:99 (KEY_SYSRQ) */
+  [Q_KEY_CODE_PROPS] = 0x82, /* qcode:Q_KEY_CODE_PROPS (props) -> linux:130 (KEY_PROPS) -> linux:130 (KEY_PROPS) */
+  [Q_KEY_CODE_Q] = 0x10, /* qcode:Q_KEY_CODE_Q (q) -> linux:16 (KEY_Q) -> linux:16 (KEY_Q) */
+  [Q_KEY_CODE_R] = 0x13, /* qcode:Q_KEY_CODE_R (r) -> linux:19 (KEY_R) -> linux:19 (KEY_R) */
+  [Q_KEY_CODE_RET] = 0x1c, /* qcode:Q_KEY_CODE_RET (ret) -> linux:28 (KEY_ENTER) -> linux:28 (KEY_ENTER) */
+  [Q_KEY_CODE_RIGHT] = 0x6a, /* qcode:Q_KEY_CODE_RIGHT (right) -> linux:106 (KEY_RIGHT) -> linux:106 (KEY_RIGHT) */
+  [Q_KEY_CODE_RO] = 0x59, /* qcode:Q_KEY_CODE_RO (ro) -> linux:89 (KEY_RO) -> linux:89 (KEY_RO) */
+  [Q_KEY_CODE_S] = 0x1f, /* qcode:Q_KEY_CODE_S (s) -> linux:31 (KEY_S) -> linux:31 (KEY_S) */
+  [Q_KEY_CODE_SCROLL_LOCK] = 0x46, /* qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) -> linux:70 (KEY_SCROLLLOCK) -> linux:70 (KEY_SCROLLLOCK) */
+  [Q_KEY_CODE_SEMICOLON] = 0x27, /* qcode:Q_KEY_CODE_SEMICOLON (semicolon) -> linux:39 (KEY_SEMICOLON) -> linux:39 (KEY_SEMICOLON) */
+  [Q_KEY_CODE_SHIFT] = 0x2a, /* qcode:Q_KEY_CODE_SHIFT (shift) -> linux:42 (KEY_LEFTSHIFT) -> linux:42 (KEY_LEFTSHIFT) */
+  [Q_KEY_CODE_SHIFT_R] = 0x36, /* qcode:Q_KEY_CODE_SHIFT_R (shift_r) -> linux:54 (KEY_RIGHTSHIFT) -> linux:54 (KEY_RIGHTSHIFT) */
+  [Q_KEY_CODE_SLASH] = 0x35, /* qcode:Q_KEY_CODE_SLASH (slash) -> linux:53 (KEY_SLASH) -> linux:53 (KEY_SLASH) */
+  [Q_KEY_CODE_SLEEP] = 0x8e, /* qcode:Q_KEY_CODE_SLEEP (sleep) -> linux:142 (KEY_SLEEP) -> linux:142 (KEY_SLEEP) */
+  [Q_KEY_CODE_SPC] = 0x39, /* qcode:Q_KEY_CODE_SPC (spc) -> linux:57 (KEY_SPACE) -> linux:57 (KEY_SPACE) */
+  [Q_KEY_CODE_STOP] = 0x80, /* qcode:Q_KEY_CODE_STOP (stop) -> linux:128 (KEY_STOP) -> linux:128 (KEY_STOP) */
+  [Q_KEY_CODE_SYSRQ] = 0x63, /* qcode:Q_KEY_CODE_SYSRQ (sysrq) -> linux:99 (KEY_SYSRQ) -> linux:99 (KEY_SYSRQ) */
+  [Q_KEY_CODE_T] = 0x14, /* qcode:Q_KEY_CODE_T (t) -> linux:20 (KEY_T) -> linux:20 (KEY_T) */
+  [Q_KEY_CODE_TAB] = 0xf, /* qcode:Q_KEY_CODE_TAB (tab) -> linux:15 (KEY_TAB) -> linux:15 (KEY_TAB) */
+  [Q_KEY_CODE_U] = 0x16, /* qcode:Q_KEY_CODE_U (u) -> linux:22 (KEY_U) -> linux:22 (KEY_U) */
+  [Q_KEY_CODE_UNDO] = 0x83, /* qcode:Q_KEY_CODE_UNDO (undo) -> linux:131 (KEY_UNDO) -> linux:131 (KEY_UNDO) */
+  [Q_KEY_CODE_UNMAPPED] = 0x0, /* qcode:Q_KEY_CODE_UNMAPPED (unmapped) -> linux:0 (KEY_RESERVED) -> linux:0 (KEY_RESERVED) */
+  [Q_KEY_CODE_UP] = 0x67, /* qcode:Q_KEY_CODE_UP (up) -> linux:103 (KEY_UP) -> linux:103 (KEY_UP) */
+  [Q_KEY_CODE_V] = 0x2f, /* qcode:Q_KEY_CODE_V (v) -> linux:47 (KEY_V) -> linux:47 (KEY_V) */
+  [Q_KEY_CODE_VOLUMEDOWN] = 0x72, /* qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) -> linux:114 (KEY_VOLUMEDOWN) -> linux:114 (KEY_VOLUMEDOWN) */
+  [Q_KEY_CODE_VOLUMEUP] = 0x73, /* qcode:Q_KEY_CODE_VOLUMEUP (volumeup) -> linux:115 (KEY_VOLUMEUP) -> linux:115 (KEY_VOLUMEUP) */
+  [Q_KEY_CODE_W] = 0x11, /* qcode:Q_KEY_CODE_W (w) -> linux:17 (KEY_W) -> linux:17 (KEY_W) */
+  [Q_KEY_CODE_WAKE] = 0x8f, /* qcode:Q_KEY_CODE_WAKE (wake) -> linux:143 (KEY_WAKEUP) -> linux:143 (KEY_WAKEUP) */
+  [Q_KEY_CODE_X] = 0x2d, /* qcode:Q_KEY_CODE_X (x) -> linux:45 (KEY_X) -> linux:45 (KEY_X) */
+  [Q_KEY_CODE_Y] = 0x15, /* qcode:Q_KEY_CODE_Y (y) -> linux:21 (KEY_Y) -> linux:21 (KEY_Y) */
+  [Q_KEY_CODE_YEN] = 0x7c, /* qcode:Q_KEY_CODE_YEN (yen) -> linux:124 (KEY_YEN) -> linux:124 (KEY_YEN) */
+  [Q_KEY_CODE_Z] = 0x2c, /* qcode:Q_KEY_CODE_Z (z) -> linux:44 (KEY_Z) -> linux:44 (KEY_Z) */
+};
+const guint qemu_input_map_qcode_to_linux_len = sizeof(qemu_input_map_qcode_to_linux)/sizeof(qemu_input_map_qcode_to_linux[0]);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 3a19a169f5..6e543d651f 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -6,6 +6,7 @@
 #include "standard-headers/linux/input.h"
 
 #include "ui/input-keymap-linux-to-qcode.c"
+#include "ui/input-keymap-qcode-to-linux.c"
 #include "ui/input-keymap-qcode-to-qnum.c"
 #include "ui/input-keymap-qnum-to-qcode.c"
 
-- 
2.13.5
