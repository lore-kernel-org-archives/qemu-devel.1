Received: from eggs.gnu.org ([2001:4830:134:3::10]:47640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCwx-0007dP-Ra
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCww-0001xT-RR
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhCww-0001xA-JO
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86B303E2CF
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 10:50:21 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 14 Aug 2017 11:49:54 +0100
Message-Id: <20170814104958.29434-9-berrange@redhat.com>
In-Reply-To: <20170814104958.29434-1-berrange@redhat.com>
References: <20170814104958.29434-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/12] char: convert the escc device to
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

Replace the qcode_to_keycode table with automatically
generated tables.

Missing entries in qcode_to_keycode now fixed:

 - Q_KEY_CODE_KP_COMMA -> 0x2d

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/char/escc.c     | 126 +++--------------------------------------------------
 include/ui/input.h |   3 ++
 ui/Makefile.objs   |   1 +
 ui/input-keymap.c  |   1 +
 4 files changed, 10 insertions(+), 121 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 1aca564e33..05665d85e7 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -717,126 +717,6 @@ MemoryRegion *escc_init(hwaddr base, qemu_irq irqA, qemu_irq irqB,
     return &d->mmio;
 }
 
-static const uint8_t qcode_to_keycode[Q_KEY_CODE__MAX] = {
-    [Q_KEY_CODE_SHIFT]         = 99,
-    [Q_KEY_CODE_SHIFT_R]       = 110,
-    [Q_KEY_CODE_ALT]           = 19,
-    [Q_KEY_CODE_ALT_R]         = 13,
-    [Q_KEY_CODE_CTRL]          = 76,
-    [Q_KEY_CODE_CTRL_R]        = 76,
-    [Q_KEY_CODE_ESC]           = 29,
-    [Q_KEY_CODE_1]             = 30,
-    [Q_KEY_CODE_2]             = 31,
-    [Q_KEY_CODE_3]             = 32,
-    [Q_KEY_CODE_4]             = 33,
-    [Q_KEY_CODE_5]             = 34,
-    [Q_KEY_CODE_6]             = 35,
-    [Q_KEY_CODE_7]             = 36,
-    [Q_KEY_CODE_8]             = 37,
-    [Q_KEY_CODE_9]             = 38,
-    [Q_KEY_CODE_0]             = 39,
-    [Q_KEY_CODE_MINUS]         = 40,
-    [Q_KEY_CODE_EQUAL]         = 41,
-    [Q_KEY_CODE_BACKSPACE]     = 43,
-    [Q_KEY_CODE_TAB]           = 53,
-    [Q_KEY_CODE_Q]             = 54,
-    [Q_KEY_CODE_W]             = 55,
-    [Q_KEY_CODE_E]             = 56,
-    [Q_KEY_CODE_R]             = 57,
-    [Q_KEY_CODE_T]             = 58,
-    [Q_KEY_CODE_Y]             = 59,
-    [Q_KEY_CODE_U]             = 60,
-    [Q_KEY_CODE_I]             = 61,
-    [Q_KEY_CODE_O]             = 62,
-    [Q_KEY_CODE_P]             = 63,
-    [Q_KEY_CODE_BRACKET_LEFT]  = 64,
-    [Q_KEY_CODE_BRACKET_RIGHT] = 65,
-    [Q_KEY_CODE_RET]           = 89,
-    [Q_KEY_CODE_A]             = 77,
-    [Q_KEY_CODE_S]             = 78,
-    [Q_KEY_CODE_D]             = 79,
-    [Q_KEY_CODE_F]             = 80,
-    [Q_KEY_CODE_G]             = 81,
-    [Q_KEY_CODE_H]             = 82,
-    [Q_KEY_CODE_J]             = 83,
-    [Q_KEY_CODE_K]             = 84,
-    [Q_KEY_CODE_L]             = 85,
-    [Q_KEY_CODE_SEMICOLON]     = 86,
-    [Q_KEY_CODE_APOSTROPHE]    = 87,
-    [Q_KEY_CODE_GRAVE_ACCENT]  = 42,
-    [Q_KEY_CODE_BACKSLASH]     = 88,
-    [Q_KEY_CODE_Z]             = 100,
-    [Q_KEY_CODE_X]             = 101,
-    [Q_KEY_CODE_C]             = 102,
-    [Q_KEY_CODE_V]             = 103,
-    [Q_KEY_CODE_B]             = 104,
-    [Q_KEY_CODE_N]             = 105,
-    [Q_KEY_CODE_M]             = 106,
-    [Q_KEY_CODE_COMMA]         = 107,
-    [Q_KEY_CODE_DOT]           = 108,
-    [Q_KEY_CODE_SLASH]         = 109,
-    [Q_KEY_CODE_ASTERISK]      = 47,
-    [Q_KEY_CODE_SPC]           = 121,
-    [Q_KEY_CODE_CAPS_LOCK]     = 119,
-    [Q_KEY_CODE_F1]            = 5,
-    [Q_KEY_CODE_F2]            = 6,
-    [Q_KEY_CODE_F3]            = 8,
-    [Q_KEY_CODE_F4]            = 10,
-    [Q_KEY_CODE_F5]            = 12,
-    [Q_KEY_CODE_F6]            = 14,
-    [Q_KEY_CODE_F7]            = 16,
-    [Q_KEY_CODE_F8]            = 17,
-    [Q_KEY_CODE_F9]            = 18,
-    [Q_KEY_CODE_F10]           = 7,
-    [Q_KEY_CODE_NUM_LOCK]      = 98,
-    [Q_KEY_CODE_SCROLL_LOCK]   = 23,
-    [Q_KEY_CODE_KP_DIVIDE]     = 46,
-    [Q_KEY_CODE_KP_MULTIPLY]   = 47,
-    [Q_KEY_CODE_KP_SUBTRACT]   = 71,
-    [Q_KEY_CODE_KP_ADD]        = 125,
-    [Q_KEY_CODE_KP_ENTER]      = 90,
-    [Q_KEY_CODE_KP_DECIMAL]    = 50,
-    [Q_KEY_CODE_KP_0]          = 94,
-    [Q_KEY_CODE_KP_1]          = 112,
-    [Q_KEY_CODE_KP_2]          = 113,
-    [Q_KEY_CODE_KP_3]          = 114,
-    [Q_KEY_CODE_KP_4]          = 91,
-    [Q_KEY_CODE_KP_5]          = 92,
-    [Q_KEY_CODE_KP_6]          = 93,
-    [Q_KEY_CODE_KP_7]          = 68,
-    [Q_KEY_CODE_KP_8]          = 69,
-    [Q_KEY_CODE_KP_9]          = 70,
-    [Q_KEY_CODE_LESS]          = 124,
-    [Q_KEY_CODE_F11]           = 9,
-    [Q_KEY_CODE_F12]           = 11,
-    [Q_KEY_CODE_HOME]          = 52,
-    [Q_KEY_CODE_PGUP]          = 96,
-    [Q_KEY_CODE_PGDN]          = 123,
-    [Q_KEY_CODE_END]           = 74,
-    [Q_KEY_CODE_LEFT]          = 24,
-    [Q_KEY_CODE_UP]            = 20,
-    [Q_KEY_CODE_DOWN]          = 27,
-    [Q_KEY_CODE_RIGHT]         = 28,
-    [Q_KEY_CODE_INSERT]        = 44,
-    [Q_KEY_CODE_DELETE]        = 66,
-    [Q_KEY_CODE_STOP]          = 1,
-    [Q_KEY_CODE_AGAIN]         = 3,
-    [Q_KEY_CODE_PROPS]         = 25,
-    [Q_KEY_CODE_UNDO]          = 26,
-    [Q_KEY_CODE_FRONT]         = 49,
-    [Q_KEY_CODE_COPY]          = 51,
-    [Q_KEY_CODE_OPEN]          = 72,
-    [Q_KEY_CODE_PASTE]         = 73,
-    [Q_KEY_CODE_FIND]          = 95,
-    [Q_KEY_CODE_CUT]           = 97,
-    [Q_KEY_CODE_LF]            = 111,
-    [Q_KEY_CODE_HELP]          = 118,
-    [Q_KEY_CODE_META_L]        = 120,
-    [Q_KEY_CODE_META_R]        = 122,
-    [Q_KEY_CODE_COMPOSE]       = 67,
-    [Q_KEY_CODE_PRINT]         = 22,
-    [Q_KEY_CODE_SYSRQ]         = 21,
-};
 
 static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
                                 InputEvent *evt)
@@ -879,7 +759,11 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
         }
     }
 
-    keycode = qcode_to_keycode[qcode];
+    if (qcode > qemu_input_map_qcode_to_sun_len) {
+        return;
+    }
+
+    keycode = qemu_input_map_qcode_to_sun[qcode];
     if (!key->down) {
         keycode |= 0x80;
     }
diff --git a/include/ui/input.h b/include/ui/input.h
index 4aa5655a0b..4ba7340b7b 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -89,6 +89,9 @@ extern const guint16 qemu_input_map_qcode_to_linux[];
 extern const guint qemu_input_map_qcode_to_qnum_len;
 extern const guint16 qemu_input_map_qcode_to_qnum[];
 
+extern const guint qemu_input_map_qcode_to_sun_len;
+extern const guint16 qemu_input_map_qcode_to_sun[];
+
 extern const guint qemu_input_map_qnum_to_qcode_len;
 extern const guint16 qemu_input_map_qnum_to_qcode[];
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 3e16fc7304..478a039398 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -61,6 +61,7 @@ KEYCODEMAP_FILES = \
 		 ui/input-keymap-qcode-to-atset3.c \
 		 ui/input-keymap-qcode-to-linux.c \
 		 ui/input-keymap-qcode-to-qnum.c \
+		 ui/input-keymap-qcode-to-sun.c \
 		 ui/input-keymap-qnum-to-qcode.c \
 		 $(NULL)
 
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 5d97a38c42..1b53cb4d0a 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -12,6 +12,7 @@
 #include "ui/input-keymap-qcode-to-atset3.c"
 #include "ui/input-keymap-qcode-to-linux.c"
 #include "ui/input-keymap-qcode-to-qnum.c"
+#include "ui/input-keymap-qcode-to-sun.c"
 #include "ui/input-keymap-qnum-to-qcode.c"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
-- 
2.13.3
