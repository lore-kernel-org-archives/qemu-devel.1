Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCwu-0007aq-VC
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCwt-0001w0-Cj
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhCwt-0001ve-3S
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04D4113223
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 10:50:18 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 14 Aug 2017 11:49:51 +0100
Message-Id: <20170814104958.29434-6-berrange@redhat.com>
In-Reply-To: <20170814104958.29434-1-berrange@redhat.com>
References: <20170814104958.29434-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/12] input: convert virtio-input-hid
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
 hw/input/virtio-input-hid.c | 136 +++-----------------------------------------
 include/ui/input.h          |   3 +
 ui/Makefile.objs            |   1 +
 ui/input-keymap.c           |   1 +
 4 files changed, 14 insertions(+), 127 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 46c038110c..3e5a2051ed 100644
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
index 8c357b488f..11915a9bb4 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -55,6 +55,7 @@ KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux-to-qcode.c \
+		 ui/input-keymap-qcode-to-linux.c \
 		 ui/input-keymap-qcode-to-qnum.c \
 		 ui/input-keymap-qnum-to-qcode.c \
 		 $(NULL)
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
2.13.3
