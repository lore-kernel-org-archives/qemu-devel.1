Received: from eggs.gnu.org ([2001:4830:134:3::10]:38515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZdvN-0003F8-KC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZdvL-0005sb-Gx
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZdvL-0005rO-83
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15C45356E3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:01:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Jul 2017 16:01:16 +0200
Message-Id: <20170724140117.27651-3-kraxel@redhat.com>
In-Reply-To: <20170724140117.27651-1-kraxel@redhat.com>
References: <20170724140117.27651-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] ui: move qemu_input_linux_to_qcode()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Move from input-linux.c to input-keymap.c and export it,
so the function is available elsewhere too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/input.h |   1 +
 ui/input-keymap.c  | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 ui/input-linux.c   | 113 ----------------------------------------------------
 3 files changed, 116 insertions(+), 113 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 3cfd0f3363..c488585def 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -48,6 +48,7 @@ int qemu_input_key_value_to_number(const KeyValue *value);
 int qemu_input_key_value_to_qcode(const KeyValue *value);
 int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
                                      int *codes);
+int qemu_input_linux_to_qcode(unsigned int lnx);
 
 InputEvent *qemu_input_event_new_btn(InputButton btn, bool down);
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 8a1476fc48..d4972bb364 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -3,6 +3,115 @@
 #include "ui/keymaps.h"
 #include "ui/input.h"
 
+#include "standard-headers/linux/input.h"
+
+static int linux_to_qcode[KEY_CNT] = {
+    [KEY_ESC]            = Q_KEY_CODE_ESC,
+    [KEY_1]              = Q_KEY_CODE_1,
+    [KEY_2]              = Q_KEY_CODE_2,
+    [KEY_3]              = Q_KEY_CODE_3,
+    [KEY_4]              = Q_KEY_CODE_4,
+    [KEY_5]              = Q_KEY_CODE_5,
+    [KEY_6]              = Q_KEY_CODE_6,
+    [KEY_7]              = Q_KEY_CODE_7,
+    [KEY_8]              = Q_KEY_CODE_8,
+    [KEY_9]              = Q_KEY_CODE_9,
+    [KEY_0]              = Q_KEY_CODE_0,
+    [KEY_MINUS]          = Q_KEY_CODE_MINUS,
+    [KEY_EQUAL]          = Q_KEY_CODE_EQUAL,
+    [KEY_BACKSPACE]      = Q_KEY_CODE_BACKSPACE,
+    [KEY_TAB]            = Q_KEY_CODE_TAB,
+    [KEY_Q]              = Q_KEY_CODE_Q,
+    [KEY_W]              = Q_KEY_CODE_W,
+    [KEY_E]              = Q_KEY_CODE_E,
+    [KEY_R]              = Q_KEY_CODE_R,
+    [KEY_T]              = Q_KEY_CODE_T,
+    [KEY_Y]              = Q_KEY_CODE_Y,
+    [KEY_U]              = Q_KEY_CODE_U,
+    [KEY_I]              = Q_KEY_CODE_I,
+    [KEY_O]              = Q_KEY_CODE_O,
+    [KEY_P]              = Q_KEY_CODE_P,
+    [KEY_LEFTBRACE]      = Q_KEY_CODE_BRACKET_LEFT,
+    [KEY_RIGHTBRACE]     = Q_KEY_CODE_BRACKET_RIGHT,
+    [KEY_ENTER]          = Q_KEY_CODE_RET,
+    [KEY_LEFTCTRL]       = Q_KEY_CODE_CTRL,
+    [KEY_A]              = Q_KEY_CODE_A,
+    [KEY_S]              = Q_KEY_CODE_S,
+    [KEY_D]              = Q_KEY_CODE_D,
+    [KEY_F]              = Q_KEY_CODE_F,
+    [KEY_G]              = Q_KEY_CODE_G,
+    [KEY_H]              = Q_KEY_CODE_H,
+    [KEY_J]              = Q_KEY_CODE_J,
+    [KEY_K]              = Q_KEY_CODE_K,
+    [KEY_L]              = Q_KEY_CODE_L,
+    [KEY_SEMICOLON]      = Q_KEY_CODE_SEMICOLON,
+    [KEY_APOSTROPHE]     = Q_KEY_CODE_APOSTROPHE,
+    [KEY_GRAVE]          = Q_KEY_CODE_GRAVE_ACCENT,
+    [KEY_LEFTSHIFT]      = Q_KEY_CODE_SHIFT,
+    [KEY_BACKSLASH]      = Q_KEY_CODE_BACKSLASH,
+    [KEY_102ND]          = Q_KEY_CODE_LESS,
+    [KEY_Z]              = Q_KEY_CODE_Z,
+    [KEY_X]              = Q_KEY_CODE_X,
+    [KEY_C]              = Q_KEY_CODE_C,
+    [KEY_V]              = Q_KEY_CODE_V,
+    [KEY_B]              = Q_KEY_CODE_B,
+    [KEY_N]              = Q_KEY_CODE_N,
+    [KEY_M]              = Q_KEY_CODE_M,
+    [KEY_COMMA]          = Q_KEY_CODE_COMMA,
+    [KEY_DOT]            = Q_KEY_CODE_DOT,
+    [KEY_SLASH]          = Q_KEY_CODE_SLASH,
+    [KEY_RIGHTSHIFT]     = Q_KEY_CODE_SHIFT_R,
+    [KEY_LEFTALT]        = Q_KEY_CODE_ALT,
+    [KEY_SPACE]          = Q_KEY_CODE_SPC,
+    [KEY_CAPSLOCK]       = Q_KEY_CODE_CAPS_LOCK,
+    [KEY_F1]             = Q_KEY_CODE_F1,
+    [KEY_F2]             = Q_KEY_CODE_F2,
+    [KEY_F3]             = Q_KEY_CODE_F3,
+    [KEY_F4]             = Q_KEY_CODE_F4,
+    [KEY_F5]             = Q_KEY_CODE_F5,
+    [KEY_F6]             = Q_KEY_CODE_F6,
+    [KEY_F7]             = Q_KEY_CODE_F7,
+    [KEY_F8]             = Q_KEY_CODE_F8,
+    [KEY_F9]             = Q_KEY_CODE_F9,
+    [KEY_F10]            = Q_KEY_CODE_F10,
+    [KEY_NUMLOCK]        = Q_KEY_CODE_NUM_LOCK,
+    [KEY_SCROLLLOCK]     = Q_KEY_CODE_SCROLL_LOCK,
+    [KEY_KP0]            = Q_KEY_CODE_KP_0,
+    [KEY_KP1]            = Q_KEY_CODE_KP_1,
+    [KEY_KP2]            = Q_KEY_CODE_KP_2,
+    [KEY_KP3]            = Q_KEY_CODE_KP_3,
+    [KEY_KP4]            = Q_KEY_CODE_KP_4,
+    [KEY_KP5]            = Q_KEY_CODE_KP_5,
+    [KEY_KP6]            = Q_KEY_CODE_KP_6,
+    [KEY_KP7]            = Q_KEY_CODE_KP_7,
+    [KEY_KP8]            = Q_KEY_CODE_KP_8,
+    [KEY_KP9]            = Q_KEY_CODE_KP_9,
+    [KEY_KPMINUS]        = Q_KEY_CODE_KP_SUBTRACT,
+    [KEY_KPPLUS]         = Q_KEY_CODE_KP_ADD,
+    [KEY_KPDOT]          = Q_KEY_CODE_KP_DECIMAL,
+    [KEY_KPENTER]        = Q_KEY_CODE_KP_ENTER,
+    [KEY_KPSLASH]        = Q_KEY_CODE_KP_DIVIDE,
+    [KEY_KPASTERISK]     = Q_KEY_CODE_KP_MULTIPLY,
+    [KEY_F11]            = Q_KEY_CODE_F11,
+    [KEY_F12]            = Q_KEY_CODE_F12,
+    [KEY_RIGHTCTRL]      = Q_KEY_CODE_CTRL_R,
+    [KEY_SYSRQ]          = Q_KEY_CODE_SYSRQ,
+    [KEY_RIGHTALT]       = Q_KEY_CODE_ALT_R,
+    [KEY_HOME]           = Q_KEY_CODE_HOME,
+    [KEY_UP]             = Q_KEY_CODE_UP,
+    [KEY_PAGEUP]         = Q_KEY_CODE_PGUP,
+    [KEY_LEFT]           = Q_KEY_CODE_LEFT,
+    [KEY_RIGHT]          = Q_KEY_CODE_RIGHT,
+    [KEY_END]            = Q_KEY_CODE_END,
+    [KEY_DOWN]           = Q_KEY_CODE_DOWN,
+    [KEY_PAGEDOWN]       = Q_KEY_CODE_PGDN,
+    [KEY_INSERT]         = Q_KEY_CODE_INSERT,
+    [KEY_DELETE]         = Q_KEY_CODE_DELETE,
+    [KEY_LEFTMETA]       = Q_KEY_CODE_META_L,
+    [KEY_RIGHTMETA]      = Q_KEY_CODE_META_R,
+    [KEY_MENU]           = Q_KEY_CODE_MENU,
+};
+
 static const int qcode_to_number[] = {
     [Q_KEY_CODE_SHIFT] = 0x2a,
     [Q_KEY_CODE_SHIFT_R] = 0x36,
@@ -141,6 +250,12 @@ static const int qcode_to_number[] = {
 
 static int number_to_qcode[0x100];
 
+int qemu_input_linux_to_qcode(unsigned int lnx)
+{
+    assert(lnx < KEY_CNT);
+    return linux_to_qcode[lnx];
+}
+
 int qemu_input_key_value_to_number(const KeyValue *value)
 {
     if (value->type == KEY_VALUE_KIND_QCODE) {
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 49d52a69cc..9720333b2c 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -16,119 +16,6 @@
 #include <sys/ioctl.h>
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
-    [KEY_LEFTMETA]       = Q_KEY_CODE_META_L,
-    [KEY_RIGHTMETA]      = Q_KEY_CODE_META_R,
-    [KEY_MENU]           = Q_KEY_CODE_MENU,
-};
-
-static int qemu_input_linux_to_qcode(unsigned int lnx)
-{
-    assert(lnx < KEY_CNT);
-    return linux_to_qcode[lnx];
-}
-
 static bool linux_is_button(unsigned int lnx)
 {
     if (lnx < 0x100) {
-- 
2.9.3
