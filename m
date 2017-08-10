Received: from eggs.gnu.org ([2001:4830:134:3::10]:41795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoY-00043O-3l
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoW-0005qV-KQ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfpoW-0005ps-BM
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:56:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F0562CE975
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 15:55:59 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 16:55:17 +0100
Message-Id: <20170810155522.31099-11-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-1-berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 10/15] ui: convert cocoa frontend to
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Replace the mac_to_qkeycode_map table with automatically
generated table.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h |   3 ++
 ui/Makefile.objs   |   1 +
 ui/cocoa.m         | 129 +----------------------------------------------------
 ui/input-keymap.c  |   1 +
 4 files changed, 7 insertions(+), 127 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 69ffff522b..595e596ef3 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -68,6 +68,9 @@ void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 extern const guint qemu_input_map_linux2qcode_len;
 extern const guint16 qemu_input_map_linux2qcode[];
 
+extern const guint qemu_input_map_osx2qcode_len;
+extern const guint16 qemu_input_map_osx2qcode[];
+
 extern const guint qemu_input_map_qcode2adb_len;
 extern const guint16 qemu_input_map_qcode2adb[];
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 935a54c109..ce9c4380ae 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -55,6 +55,7 @@ KEYCODEMAP_CSV = ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux2qcode.c \
+		 ui/input-keymap-osx2qcode.c \
 		 ui/input-keymap-qcode2adb.c \
 		 ui/input-keymap-qcode2atset1.c \
 		 ui/input-keymap-qcode2atset2.c \
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0518..97a0001cc5 100644
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
+    if (keycode >= qemu_input_map_osx2qcode_len) {
         fprintf(stderr, "(cocoa) warning unknown keycode 0x%x\n", keycode);
         return 0;
     }
-    return mac_to_qkeycode_map[keycode];
+    return qemu_input_map_osx2qcode[keycode];
 }
 
 /* Displays an alert dialog box with the specified message */
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 05a097b97f..e575348cb2 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -6,6 +6,7 @@
 #include "standard-headers/linux/input.h"
 
 #include "ui/input-keymap-linux2qcode.c"
+#include "ui/input-keymap-osx2qcode.c"
 #include "ui/input-keymap-qcode2adb.c"
 #include "ui/input-keymap-qcode2atset1.c"
 #include "ui/input-keymap-qcode2atset2.c"
-- 
2.13.3
