Received: from eggs.gnu.org ([2001:4830:134:3::10]:48677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkSC-0000qJ-Mb
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS1-0003S6-VD
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkS1-0003Rl-HA
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94D24883B0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:38:00 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 13:37:38 +0100
Message-Id: <20170912123744.14730-7-berrange@redhat.com>
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 06/12] input: convert ps2 device to
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

Replace the qcode_to_keycode_set1, qcode_to_keycode_set2,
and qcode_to_keycode_set3 tables with automatically
generated tables.

Missing entries in qcode_to_keycode_set1 now fixed:

 - Q_KEY_CODE_SYSRQ -> 0x54
 - Q_KEY_CODE_PRINT -> 0x54 (NB ignored due to special case)
 - Q_KEY_CODE_AGAIN -> 0xe005
 - Q_KEY_CODE_PROPS -> 0xe006
 - Q_KEY_CODE_UNDO -> 0xe007
 - Q_KEY_CODE_FRONT -> 0xe00c
 - Q_KEY_CODE_COPY -> 0xe078
 - Q_KEY_CODE_OPEN -> 0x64
 - Q_KEY_CODE_PASTE -> 0x65
 - Q_KEY_CODE_CUT -> 0xe03c
 - Q_KEY_CODE_LF -> 0x5b
 - Q_KEY_CODE_HELP -> 0xe075
 - Q_KEY_CODE_COMPOSE -> 0xe05d
 - Q_KEY_CODE_PAUSE -> 0xe046
 - Q_KEY_CODE_KP_EQUALS -> 0x59

And some mistakes corrected:

 - Q_KEY_CODE_HIRAGANA was mapped to 0x70 (Katakanahiragana)
   instead of of 0x77 (Hirigana)
 - Q_KEY_CODE_MENU was incorrectly mapped to the compose
   scancode (0xe05d) and is now mapped to 0xe01e
 - Q_KEY_CODE_FIND was mapped to 0xe065 (Search) instead
   of to 0xe041 (Find)
 - Q_KEY_CODE_POWER, SLEEP & WAKE had 0x0e instead of 0xe0
   as the prefix

Missing entries in qcode_to_keycode_set2 now fixed:

 - Q_KEY_CODE_PRINT -> 0x7f (NB ignored due to special case)
 - Q_KEY_CODE_COMPOSE -> 0xe02f
 - Q_KEY_CODE_PAUSE -> 0xe077
 - Q_KEY_CODE_KP_EQUALS -> 0x0f

And some mistakes corrected:

 - Q_KEY_CODE_HIRAGANA was mapped to 0x13 (Katakanahiragana)
   instead of of 0x62 (Hirigana)
 - Q_KEY_CODE_MENU was incorrectly mapped to the compose
   scancode (0xe02f) and is now not mapped
 - Q_KEY_CODE_FIND was mapped to 0xe010 (Search) and is now
   not mapped.
 - Q_KEY_CODE_POWER, SLEEP & WAKE had 0x0e instead of 0xe0
   as the prefix

Missing entries in qcode_to_keycode_set3 now fixed:

 - Q_KEY_CODE_ASTERISK -> 0x7e
 - Q_KEY_CODE_SYSRQ -> 0x57
 - Q_KEY_CODE_LESS -> 0x13
 - Q_KEY_CODE_STOP -> 0x0a
 - Q_KEY_CODE_AGAIN -> 0x0b
 - Q_KEY_CODE_PROPS -> 0x0c
 - Q_KEY_CODE_UNDO -> 0x10
 - Q_KEY_CODE_COPY -> 0x18
 - Q_KEY_CODE_OPEN -> 0x20
 - Q_KEY_CODE_PASTE -> 0x28
 - Q_KEY_CODE_FIND -> 0x30
 - Q_KEY_CODE_CUT -> 0x38
 - Q_KEY_CODE_HELP -> 0x09
 - Q_KEY_CODE_COMPOSE -> 0x8d
 - Q_KEY_CODE_AUDIONEXT -> 0x93
 - Q_KEY_CODE_AUDIOPREV -> 0x94
 - Q_KEY_CODE_AUDIOSTOP -> 0x98
 - Q_KEY_CODE_AUDIOMUTE -> 0x9c
 - Q_KEY_CODE_VOLUMEUP -> 0x95
 - Q_KEY_CODE_VOLUMEDOWN -> 0x9d
 - Q_KEY_CODE_CALCULATOR -> 0xa3
 - Q_KEY_CODE_AC_HOME -> 0x97

And some mistakes corrected:

 - Q_KEY_CODE_MENU was incorrectly mapped to the compose
   scancode (0x8d) and is now 0x91

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/input/ps2.c                    | 406 +-------------------------------------
 include/ui/input.h                |   9 +
 ui/Makefile.objs                  |   3 +
 ui/input-keymap-qcode-to-atset1.c | 154 +++++++++++++++
 ui/input-keymap-qcode-to-atset2.c | 142 +++++++++++++
 ui/input-keymap-qcode-to-atset3.c | 138 +++++++++++++
 ui/input-keymap.c                 |   3 +
 7 files changed, 456 insertions(+), 399 deletions(-)
 create mode 100644 ui/input-keymap-qcode-to-atset1.c
 create mode 100644 ui/input-keymap-qcode-to-atset2.c
 create mode 100644 ui/input-keymap-qcode-to-atset3.c

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 77906d5f46..7eeadc144d 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -115,401 +115,6 @@ typedef struct {
     uint8_t mouse_buttons;
 } PS2MouseState;
 
-/* Table to convert from QEMU codes to scancodes.  */
-static const uint16_t qcode_to_keycode_set1[Q_KEY_CODE__MAX] = {
-    [0 ... Q_KEY_CODE__MAX - 1] = 0,
-
-    [Q_KEY_CODE_A] = 0x1e,
-    [Q_KEY_CODE_B] = 0x30,
-    [Q_KEY_CODE_C] = 0x2e,
-    [Q_KEY_CODE_D] = 0x20,
-    [Q_KEY_CODE_E] = 0x12,
-    [Q_KEY_CODE_F] = 0x21,
-    [Q_KEY_CODE_G] = 0x22,
-    [Q_KEY_CODE_H] = 0x23,
-    [Q_KEY_CODE_I] = 0x17,
-    [Q_KEY_CODE_J] = 0x24,
-    [Q_KEY_CODE_K] = 0x25,
-    [Q_KEY_CODE_L] = 0x26,
-    [Q_KEY_CODE_M] = 0x32,
-    [Q_KEY_CODE_N] = 0x31,
-    [Q_KEY_CODE_O] = 0x18,
-    [Q_KEY_CODE_P] = 0x19,
-    [Q_KEY_CODE_Q] = 0x10,
-    [Q_KEY_CODE_R] = 0x13,
-    [Q_KEY_CODE_S] = 0x1f,
-    [Q_KEY_CODE_T] = 0x14,
-    [Q_KEY_CODE_U] = 0x16,
-    [Q_KEY_CODE_V] = 0x2f,
-    [Q_KEY_CODE_W] = 0x11,
-    [Q_KEY_CODE_X] = 0x2d,
-    [Q_KEY_CODE_Y] = 0x15,
-    [Q_KEY_CODE_Z] = 0x2c,
-    [Q_KEY_CODE_0] = 0x0b,
-    [Q_KEY_CODE_1] = 0x02,
-    [Q_KEY_CODE_2] = 0x03,
-    [Q_KEY_CODE_3] = 0x04,
-    [Q_KEY_CODE_4] = 0x05,
-    [Q_KEY_CODE_5] = 0x06,
-    [Q_KEY_CODE_6] = 0x07,
-    [Q_KEY_CODE_7] = 0x08,
-    [Q_KEY_CODE_8] = 0x09,
-    [Q_KEY_CODE_9] = 0x0a,
-    [Q_KEY_CODE_GRAVE_ACCENT] = 0x29,
-    [Q_KEY_CODE_MINUS] = 0x0c,
-    [Q_KEY_CODE_EQUAL] = 0x0d,
-    [Q_KEY_CODE_BACKSLASH] = 0x2b,
-    [Q_KEY_CODE_BACKSPACE] = 0x0e,
-    [Q_KEY_CODE_SPC] = 0x39,
-    [Q_KEY_CODE_TAB] = 0x0f,
-    [Q_KEY_CODE_CAPS_LOCK] = 0x3a,
-    [Q_KEY_CODE_SHIFT] = 0x2a,
-    [Q_KEY_CODE_CTRL] = 0x1d,
-    [Q_KEY_CODE_META_L] = 0xe05b,
-    [Q_KEY_CODE_ALT] = 0x38,
-    [Q_KEY_CODE_SHIFT_R] = 0x36,
-    [Q_KEY_CODE_CTRL_R] = 0xe01d,
-    [Q_KEY_CODE_META_R] = 0xe05c,
-    [Q_KEY_CODE_ALT_R] = 0xe038,
-    [Q_KEY_CODE_MENU] = 0xe05d,
-    [Q_KEY_CODE_RET] = 0x1c,
-    [Q_KEY_CODE_ESC] = 0x01,
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
-    [Q_KEY_CODE_F11] = 0x57,
-    [Q_KEY_CODE_F12] = 0x58,
-    /* special handling for Q_KEY_CODE_PRINT */
-    [Q_KEY_CODE_SCROLL_LOCK] = 0x46,
-    /* special handling for Q_KEY_CODE_PAUSE */
-    [Q_KEY_CODE_BRACKET_LEFT] = 0x1a,
-    [Q_KEY_CODE_INSERT] = 0xe052,
-    [Q_KEY_CODE_HOME] = 0xe047,
-    [Q_KEY_CODE_PGUP] = 0xe049,
-    [Q_KEY_CODE_DELETE] = 0xe053,
-    [Q_KEY_CODE_END] = 0xe04f,
-    [Q_KEY_CODE_PGDN] = 0xe051,
-    [Q_KEY_CODE_UP] = 0xe048,
-    [Q_KEY_CODE_LEFT] = 0xe04b,
-    [Q_KEY_CODE_DOWN] = 0xe050,
-    [Q_KEY_CODE_RIGHT] = 0xe04d,
-    [Q_KEY_CODE_NUM_LOCK] = 0x45,
-    [Q_KEY_CODE_KP_DIVIDE] = 0xe035,
-    [Q_KEY_CODE_KP_MULTIPLY] = 0x37,
-    [Q_KEY_CODE_KP_SUBTRACT] = 0x4a,
-    [Q_KEY_CODE_KP_ADD] = 0x4e,
-    [Q_KEY_CODE_KP_ENTER] = 0xe01c,
-    [Q_KEY_CODE_KP_DECIMAL] = 0x53,
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
-    [Q_KEY_CODE_BRACKET_RIGHT] = 0x1b,
-    [Q_KEY_CODE_SEMICOLON] = 0x27,
-    [Q_KEY_CODE_APOSTROPHE] = 0x28,
-    [Q_KEY_CODE_COMMA] = 0x33,
-    [Q_KEY_CODE_DOT] = 0x34,
-    [Q_KEY_CODE_SLASH] = 0x35,
-
-    [Q_KEY_CODE_POWER] = 0x0e5e,
-    [Q_KEY_CODE_SLEEP] = 0x0e5f,
-    [Q_KEY_CODE_WAKE] = 0x0e63,
-
-    [Q_KEY_CODE_AUDIONEXT] = 0xe019,
-    [Q_KEY_CODE_AUDIOPREV] = 0xe010,
-    [Q_KEY_CODE_AUDIOSTOP] = 0xe024,
-    [Q_KEY_CODE_AUDIOPLAY] = 0xe022,
-    [Q_KEY_CODE_AUDIOMUTE] = 0xe020,
-    [Q_KEY_CODE_VOLUMEUP] = 0xe030,
-    [Q_KEY_CODE_VOLUMEDOWN] = 0xe02e,
-    [Q_KEY_CODE_MEDIASELECT] = 0xe06d,
-    [Q_KEY_CODE_MAIL] = 0xe06c,
-    [Q_KEY_CODE_CALCULATOR] = 0xe021,
-    [Q_KEY_CODE_COMPUTER] = 0xe06b,
-    [Q_KEY_CODE_FIND] = 0xe065,
-    [Q_KEY_CODE_AC_HOME] = 0xe032,
-    [Q_KEY_CODE_AC_BACK] = 0xe06a,
-    [Q_KEY_CODE_AC_FORWARD] = 0xe069,
-    [Q_KEY_CODE_STOP] = 0xe068,
-    [Q_KEY_CODE_AC_REFRESH] = 0xe067,
-    [Q_KEY_CODE_AC_BOOKMARKS] = 0xe066,
-
-    [Q_KEY_CODE_ASTERISK] = 0x37,
-    [Q_KEY_CODE_LESS] = 0x56,
-    [Q_KEY_CODE_RO] = 0x73,
-    [Q_KEY_CODE_HIRAGANA] = 0x70,
-    [Q_KEY_CODE_HENKAN] = 0x79,
-    [Q_KEY_CODE_YEN] = 0x7d,
-    [Q_KEY_CODE_KP_COMMA] = 0x7e,
-};
-
-static const uint16_t qcode_to_keycode_set2[Q_KEY_CODE__MAX] = {
-    [0 ... Q_KEY_CODE__MAX - 1] = 0,
-
-    [Q_KEY_CODE_A] = 0x1c,
-    [Q_KEY_CODE_B] = 0x32,
-    [Q_KEY_CODE_C] = 0x21,
-    [Q_KEY_CODE_D] = 0x23,
-    [Q_KEY_CODE_E] = 0x24,
-    [Q_KEY_CODE_F] = 0x2b,
-    [Q_KEY_CODE_G] = 0x34,
-    [Q_KEY_CODE_H] = 0x33,
-    [Q_KEY_CODE_I] = 0x43,
-    [Q_KEY_CODE_J] = 0x3b,
-    [Q_KEY_CODE_K] = 0x42,
-    [Q_KEY_CODE_L] = 0x4b,
-    [Q_KEY_CODE_M] = 0x3a,
-    [Q_KEY_CODE_N] = 0x31,
-    [Q_KEY_CODE_O] = 0x44,
-    [Q_KEY_CODE_P] = 0x4d,
-    [Q_KEY_CODE_Q] = 0x15,
-    [Q_KEY_CODE_R] = 0x2d,
-    [Q_KEY_CODE_S] = 0x1b,
-    [Q_KEY_CODE_T] = 0x2c,
-    [Q_KEY_CODE_U] = 0x3c,
-    [Q_KEY_CODE_V] = 0x2a,
-    [Q_KEY_CODE_W] = 0x1d,
-    [Q_KEY_CODE_X] = 0x22,
-    [Q_KEY_CODE_Y] = 0x35,
-    [Q_KEY_CODE_Z] = 0x1a,
-    [Q_KEY_CODE_0] = 0x45,
-    [Q_KEY_CODE_1] = 0x16,
-    [Q_KEY_CODE_2] = 0x1e,
-    [Q_KEY_CODE_3] = 0x26,
-    [Q_KEY_CODE_4] = 0x25,
-    [Q_KEY_CODE_5] = 0x2e,
-    [Q_KEY_CODE_6] = 0x36,
-    [Q_KEY_CODE_7] = 0x3d,
-    [Q_KEY_CODE_8] = 0x3e,
-    [Q_KEY_CODE_9] = 0x46,
-    [Q_KEY_CODE_GRAVE_ACCENT] = 0x0e,
-    [Q_KEY_CODE_MINUS] = 0x4e,
-    [Q_KEY_CODE_EQUAL] = 0x55,
-    [Q_KEY_CODE_BACKSLASH] = 0x5d,
-    [Q_KEY_CODE_BACKSPACE] = 0x66,
-    [Q_KEY_CODE_SPC] = 0x29,
-    [Q_KEY_CODE_TAB] = 0x0d,
-    [Q_KEY_CODE_CAPS_LOCK] = 0x58,
-    [Q_KEY_CODE_SHIFT] = 0x12,
-    [Q_KEY_CODE_CTRL] = 0x14,
-    [Q_KEY_CODE_META_L] = 0xe01f,
-    [Q_KEY_CODE_ALT] = 0x11,
-    [Q_KEY_CODE_SHIFT_R] = 0x59,
-    [Q_KEY_CODE_CTRL_R] = 0xe014,
-    [Q_KEY_CODE_META_R] = 0xe027,
-    [Q_KEY_CODE_ALT_R] = 0xe011,
-    [Q_KEY_CODE_MENU] = 0xe02f,
-    [Q_KEY_CODE_RET] = 0x5a,
-    [Q_KEY_CODE_ESC] = 0x76,
-    [Q_KEY_CODE_F1] = 0x05,
-    [Q_KEY_CODE_F2] = 0x06,
-    [Q_KEY_CODE_F3] = 0x04,
-    [Q_KEY_CODE_F4] = 0x0c,
-    [Q_KEY_CODE_F5] = 0x03,
-    [Q_KEY_CODE_F6] = 0x0b,
-    [Q_KEY_CODE_F7] = 0x83,
-    [Q_KEY_CODE_F8] = 0x0a,
-    [Q_KEY_CODE_F9] = 0x01,
-    [Q_KEY_CODE_F10] = 0x09,
-    [Q_KEY_CODE_F11] = 0x78,
-    [Q_KEY_CODE_F12] = 0x07,
-    /* special handling for Q_KEY_CODE_PRINT */
-    [Q_KEY_CODE_SCROLL_LOCK] = 0x7e,
-    /* special handling for Q_KEY_CODE_PAUSE */
-    [Q_KEY_CODE_BRACKET_LEFT] = 0x54,
-    [Q_KEY_CODE_INSERT] = 0xe070,
-    [Q_KEY_CODE_HOME] = 0xe06c,
-    [Q_KEY_CODE_PGUP] = 0xe07d,
-    [Q_KEY_CODE_DELETE] = 0xe071,
-    [Q_KEY_CODE_END] = 0xe069,
-    [Q_KEY_CODE_PGDN] = 0xe07a,
-    [Q_KEY_CODE_UP] = 0xe075,
-    [Q_KEY_CODE_LEFT] = 0xe06b,
-    [Q_KEY_CODE_DOWN] = 0xe072,
-    [Q_KEY_CODE_RIGHT] = 0xe074,
-    [Q_KEY_CODE_NUM_LOCK] = 0x77,
-    [Q_KEY_CODE_KP_DIVIDE] = 0xe04a,
-    [Q_KEY_CODE_KP_MULTIPLY] = 0x7c,
-    [Q_KEY_CODE_KP_SUBTRACT] = 0x7b,
-    [Q_KEY_CODE_KP_ADD] = 0x79,
-    [Q_KEY_CODE_KP_ENTER] = 0xe05a,
-    [Q_KEY_CODE_KP_DECIMAL] = 0x71,
-    [Q_KEY_CODE_KP_0] = 0x70,
-    [Q_KEY_CODE_KP_1] = 0x69,
-    [Q_KEY_CODE_KP_2] = 0x72,
-    [Q_KEY_CODE_KP_3] = 0x7a,
-    [Q_KEY_CODE_KP_4] = 0x6b,
-    [Q_KEY_CODE_KP_5] = 0x73,
-    [Q_KEY_CODE_KP_6] = 0x74,
-    [Q_KEY_CODE_KP_7] = 0x6c,
-    [Q_KEY_CODE_KP_8] = 0x75,
-    [Q_KEY_CODE_KP_9] = 0x7d,
-    [Q_KEY_CODE_BRACKET_RIGHT] = 0x5b,
-    [Q_KEY_CODE_SEMICOLON] = 0x4c,
-    [Q_KEY_CODE_APOSTROPHE] = 0x52,
-    [Q_KEY_CODE_COMMA] = 0x41,
-    [Q_KEY_CODE_DOT] = 0x49,
-    [Q_KEY_CODE_SLASH] = 0x4a,
-
-    [Q_KEY_CODE_POWER] = 0x0e37,
-    [Q_KEY_CODE_SLEEP] = 0x0e3f,
-    [Q_KEY_CODE_WAKE] = 0x0e5e,
-
-    [Q_KEY_CODE_AUDIONEXT] = 0xe04d,
-    [Q_KEY_CODE_AUDIOPREV] = 0xe015,
-    [Q_KEY_CODE_AUDIOSTOP] = 0xe03b,
-    [Q_KEY_CODE_AUDIOPLAY] = 0xe034,
-    [Q_KEY_CODE_AUDIOMUTE] = 0xe023,
-    [Q_KEY_CODE_VOLUMEUP] = 0xe032,
-    [Q_KEY_CODE_VOLUMEDOWN] = 0xe021,
-    [Q_KEY_CODE_MEDIASELECT] = 0xe050,
-    [Q_KEY_CODE_MAIL] = 0xe048,
-    [Q_KEY_CODE_CALCULATOR] = 0xe02b,
-    [Q_KEY_CODE_COMPUTER] = 0xe040,
-    [Q_KEY_CODE_FIND] = 0xe010,
-    [Q_KEY_CODE_AC_HOME] = 0xe03a,
-    [Q_KEY_CODE_AC_BACK] = 0xe038,
-    [Q_KEY_CODE_AC_FORWARD] = 0xe030,
-    [Q_KEY_CODE_STOP] = 0xe028,
-    [Q_KEY_CODE_AC_REFRESH] = 0xe020,
-    [Q_KEY_CODE_AC_BOOKMARKS] = 0xe018,
-
-    [Q_KEY_CODE_ASTERISK] = 0x7c,
-    [Q_KEY_CODE_LESS] = 0x61,
-    [Q_KEY_CODE_SYSRQ] = 0x7f,
-    [Q_KEY_CODE_RO] = 0x51,
-    [Q_KEY_CODE_HIRAGANA] = 0x13,
-    [Q_KEY_CODE_HENKAN] = 0x64,
-    [Q_KEY_CODE_YEN] = 0x6a,
-    [Q_KEY_CODE_KP_COMMA] = 0x6d,
-};
-
-static const uint16_t qcode_to_keycode_set3[Q_KEY_CODE__MAX] = {
-    [0 ... Q_KEY_CODE__MAX - 1] = 0,
-
-    [Q_KEY_CODE_A] = 0x1c,
-    [Q_KEY_CODE_B] = 0x32,
-    [Q_KEY_CODE_C] = 0x21,
-    [Q_KEY_CODE_D] = 0x23,
-    [Q_KEY_CODE_E] = 0x24,
-    [Q_KEY_CODE_F] = 0x2b,
-    [Q_KEY_CODE_G] = 0x34,
-    [Q_KEY_CODE_H] = 0x33,
-    [Q_KEY_CODE_I] = 0x43,
-    [Q_KEY_CODE_J] = 0x3b,
-    [Q_KEY_CODE_K] = 0x42,
-    [Q_KEY_CODE_L] = 0x4b,
-    [Q_KEY_CODE_M] = 0x3a,
-    [Q_KEY_CODE_N] = 0x31,
-    [Q_KEY_CODE_O] = 0x44,
-    [Q_KEY_CODE_P] = 0x4d,
-    [Q_KEY_CODE_Q] = 0x15,
-    [Q_KEY_CODE_R] = 0x2d,
-    [Q_KEY_CODE_S] = 0x1b,
-    [Q_KEY_CODE_T] = 0x2c,
-    [Q_KEY_CODE_U] = 0x3c,
-    [Q_KEY_CODE_V] = 0x2a,
-    [Q_KEY_CODE_W] = 0x1d,
-    [Q_KEY_CODE_X] = 0x22,
-    [Q_KEY_CODE_Y] = 0x35,
-    [Q_KEY_CODE_Z] = 0x1a,
-    [Q_KEY_CODE_0] = 0x45,
-    [Q_KEY_CODE_1] = 0x16,
-    [Q_KEY_CODE_2] = 0x1e,
-    [Q_KEY_CODE_3] = 0x26,
-    [Q_KEY_CODE_4] = 0x25,
-    [Q_KEY_CODE_5] = 0x2e,
-    [Q_KEY_CODE_6] = 0x36,
-    [Q_KEY_CODE_7] = 0x3d,
-    [Q_KEY_CODE_8] = 0x3e,
-    [Q_KEY_CODE_9] = 0x46,
-    [Q_KEY_CODE_GRAVE_ACCENT] = 0x0e,
-    [Q_KEY_CODE_MINUS] = 0x4e,
-    [Q_KEY_CODE_EQUAL] = 0x55,
-    [Q_KEY_CODE_BACKSLASH] = 0x5c,
-    [Q_KEY_CODE_BACKSPACE] = 0x66,
-    [Q_KEY_CODE_SPC] = 0x29,
-    [Q_KEY_CODE_TAB] = 0x0d,
-    [Q_KEY_CODE_CAPS_LOCK] = 0x14,
-    [Q_KEY_CODE_SHIFT] = 0x12,
-    [Q_KEY_CODE_CTRL] = 0x11,
-    [Q_KEY_CODE_META_L] = 0x8b,
-    [Q_KEY_CODE_ALT] = 0x19,
-    [Q_KEY_CODE_SHIFT_R] = 0x59,
-    [Q_KEY_CODE_CTRL_R] = 0x58,
-    [Q_KEY_CODE_META_R] = 0x8c,
-    [Q_KEY_CODE_ALT_R] = 0x39,
-    [Q_KEY_CODE_MENU] = 0x8d,
-    [Q_KEY_CODE_RET] = 0x5a,
-    [Q_KEY_CODE_ESC] = 0x08,
-    [Q_KEY_CODE_F1] = 0x07,
-    [Q_KEY_CODE_F2] = 0x0f,
-    [Q_KEY_CODE_F3] = 0x17,
-    [Q_KEY_CODE_F4] = 0x1f,
-    [Q_KEY_CODE_F5] = 0x27,
-    [Q_KEY_CODE_F6] = 0x2f,
-    [Q_KEY_CODE_F7] = 0x37,
-    [Q_KEY_CODE_F8] = 0x3f,
-    [Q_KEY_CODE_F9] = 0x47,
-    [Q_KEY_CODE_F10] = 0x4f,
-    [Q_KEY_CODE_F11] = 0x56,
-    [Q_KEY_CODE_F12] = 0x5e,
-    [Q_KEY_CODE_PRINT] = 0x57,
-    [Q_KEY_CODE_SCROLL_LOCK] = 0x5f,
-    [Q_KEY_CODE_PAUSE] = 0x62,
-    [Q_KEY_CODE_BRACKET_LEFT] = 0x54,
-    [Q_KEY_CODE_INSERT] = 0x67,
-    [Q_KEY_CODE_HOME] = 0x6e,
-    [Q_KEY_CODE_PGUP] = 0x6f,
-    [Q_KEY_CODE_DELETE] = 0x64,
-    [Q_KEY_CODE_END] = 0x65,
-    [Q_KEY_CODE_PGDN] = 0x6d,
-    [Q_KEY_CODE_UP] = 0x63,
-    [Q_KEY_CODE_LEFT] = 0x61,
-    [Q_KEY_CODE_DOWN] = 0x60,
-    [Q_KEY_CODE_RIGHT] = 0x6a,
-    [Q_KEY_CODE_NUM_LOCK] = 0x76,
-    [Q_KEY_CODE_KP_DIVIDE] = 0x4a,
-    [Q_KEY_CODE_KP_MULTIPLY] = 0x7e,
-    [Q_KEY_CODE_KP_SUBTRACT] = 0x4e,
-    [Q_KEY_CODE_KP_ADD] = 0x7c,
-    [Q_KEY_CODE_KP_ENTER] = 0x79,
-    [Q_KEY_CODE_KP_DECIMAL] = 0x71,
-    [Q_KEY_CODE_KP_0] = 0x70,
-    [Q_KEY_CODE_KP_1] = 0x69,
-    [Q_KEY_CODE_KP_2] = 0x72,
-    [Q_KEY_CODE_KP_3] = 0x7a,
-    [Q_KEY_CODE_KP_4] = 0x6b,
-    [Q_KEY_CODE_KP_5] = 0x73,
-    [Q_KEY_CODE_KP_6] = 0x74,
-    [Q_KEY_CODE_KP_7] = 0x6c,
-    [Q_KEY_CODE_KP_8] = 0x75,
-    [Q_KEY_CODE_KP_9] = 0x7d,
-    [Q_KEY_CODE_BRACKET_RIGHT] = 0x5b,
-    [Q_KEY_CODE_SEMICOLON] = 0x4c,
-    [Q_KEY_CODE_APOSTROPHE] = 0x52,
-    [Q_KEY_CODE_COMMA] = 0x41,
-    [Q_KEY_CODE_DOT] = 0x49,
-    [Q_KEY_CODE_SLASH] = 0x4a,
-
-    [Q_KEY_CODE_HIRAGANA] = 0x87,
-    [Q_KEY_CODE_HENKAN] = 0x86,
-    [Q_KEY_CODE_YEN] = 0x5d,
-};
-
 static uint8_t translate_table[256] = {
     0xff, 0x43, 0x41, 0x3f, 0x3d, 0x3b, 0x3c, 0x58,
     0x64, 0x44, 0x42, 0x40, 0x3e, 0x0f, 0x29, 0x59,
@@ -595,7 +200,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
     PS2KbdState *s = (PS2KbdState *)dev;
     InputKeyEvent *key = evt->u.key.data;
     int qcode;
-    uint16_t keycode;
+    uint16_t keycode = 0;
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
@@ -624,7 +229,8 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 ps2_put_keycode(s, 0xaa);
             }
         } else {
-            keycode = qcode_to_keycode_set1[qcode];
+            if (qcode < qemu_input_map_qcode_to_atset1_len)
+                keycode = qemu_input_map_qcode_to_atset1[qcode];
             if (keycode) {
                 if (keycode & 0xff00) {
                     ps2_put_keycode(s, keycode >> 8);
@@ -665,7 +271,8 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 ps2_put_keycode(s, 0x12);
             }
         } else {
-            keycode = qcode_to_keycode_set2[qcode];
+            if (qcode < qemu_input_map_qcode_to_atset2_len)
+                keycode = qemu_input_map_qcode_to_atset2[qcode];
             if (keycode) {
                 if (keycode & 0xff00) {
                     ps2_put_keycode(s, keycode >> 8);
@@ -680,7 +287,8 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
             }
         }
     } else if (s->scancode_set == 3) {
-        keycode = qcode_to_keycode_set3[qcode];
+        if (qcode < qemu_input_map_qcode_to_atset3_len)
+            keycode = qemu_input_map_qcode_to_atset3[qcode];
         if (keycode) {
             /* FIXME: break code should be configured on a key by key basis */
             if (!key->down) {
diff --git a/include/ui/input.h b/include/ui/input.h
index 6f56d868c7..76235ba97a 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -71,6 +71,15 @@ void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 extern const guint qemu_input_map_linux_to_qcode_len;
 extern const guint16 qemu_input_map_linux_to_qcode[];
 
+extern const guint qemu_input_map_qcode_to_atset1_len;
+extern const guint16 qemu_input_map_qcode_to_atset1[];
+
+extern const guint qemu_input_map_qcode_to_atset2_len;
+extern const guint16 qemu_input_map_qcode_to_atset2[];
+
+extern const guint qemu_input_map_qcode_to_atset3_len;
+extern const guint16 qemu_input_map_qcode_to_atset3[];
+
 extern const guint qemu_input_map_qcode_to_linux_len;
 extern const guint16 qemu_input_map_qcode_to_linux[];
 
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index baf6f4e56f..8ba843c0c9 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -55,6 +55,9 @@ KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux-to-qcode.c \
+		 ui/input-keymap-qcode-to-atset1.c \
+		 ui/input-keymap-qcode-to-atset2.c \
+		 ui/input-keymap-qcode-to-atset3.c \
 		 ui/input-keymap-qcode-to-linux.c \
 		 ui/input-keymap-qcode-to-qnum.c \
 		 ui/input-keymap-qnum-to-qcode.c \
diff --git a/ui/input-keymap-qcode-to-atset1.c b/ui/input-keymap-qcode-to-atset1.c
new file mode 100644
index 0000000000..3793e38cd4
--- /dev/null
+++ b/ui/input-keymap-qcode-to-atset1.c
@@ -0,0 +1,154 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:06
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_qcode_to_atset1 code-map keymaps.csv qcode atset1
+*/
+const guint16 qemu_input_map_qcode_to_atset1[Q_KEY_CODE__MAX] = {
+  [Q_KEY_CODE_0] = 0xb, /* qcode:Q_KEY_CODE_0 (0) -> linux:11 (KEY_0) -> atset1:11 */
+  [Q_KEY_CODE_1] = 0x2, /* qcode:Q_KEY_CODE_1 (1) -> linux:2 (KEY_1) -> atset1:2 */
+  [Q_KEY_CODE_2] = 0x3, /* qcode:Q_KEY_CODE_2 (2) -> linux:3 (KEY_2) -> atset1:3 */
+  [Q_KEY_CODE_3] = 0x4, /* qcode:Q_KEY_CODE_3 (3) -> linux:4 (KEY_3) -> atset1:4 */
+  [Q_KEY_CODE_4] = 0x5, /* qcode:Q_KEY_CODE_4 (4) -> linux:5 (KEY_4) -> atset1:5 */
+  [Q_KEY_CODE_5] = 0x6, /* qcode:Q_KEY_CODE_5 (5) -> linux:6 (KEY_5) -> atset1:6 */
+  [Q_KEY_CODE_6] = 0x7, /* qcode:Q_KEY_CODE_6 (6) -> linux:7 (KEY_6) -> atset1:7 */
+  [Q_KEY_CODE_7] = 0x8, /* qcode:Q_KEY_CODE_7 (7) -> linux:8 (KEY_7) -> atset1:8 */
+  [Q_KEY_CODE_8] = 0x9, /* qcode:Q_KEY_CODE_8 (8) -> linux:9 (KEY_8) -> atset1:9 */
+  [Q_KEY_CODE_9] = 0xa, /* qcode:Q_KEY_CODE_9 (9) -> linux:10 (KEY_9) -> atset1:10 */
+  [Q_KEY_CODE_A] = 0x1e, /* qcode:Q_KEY_CODE_A (a) -> linux:30 (KEY_A) -> atset1:30 */
+  [Q_KEY_CODE_AC_BACK] = 0xe06a, /* qcode:Q_KEY_CODE_AC_BACK (ac_back) -> linux:158 (KEY_BACK) -> atset1:57450 */
+  [Q_KEY_CODE_AC_BOOKMARKS] = 0xe066, /* qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) -> linux:156 (KEY_BOOKMARKS) -> atset1:57446 */
+  [Q_KEY_CODE_AC_FORWARD] = 0xe069, /* qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) -> linux:159 (KEY_FORWARD) -> atset1:57449 */
+  [Q_KEY_CODE_AC_HOME] = 0xe032, /* qcode:Q_KEY_CODE_AC_HOME (ac_home) -> linux:172 (KEY_HOMEPAGE) -> atset1:57394 */
+  [Q_KEY_CODE_AC_REFRESH] = 0xe067, /* qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) -> linux:173 (KEY_REFRESH) -> atset1:57447 */
+  [Q_KEY_CODE_AGAIN] = 0xe005, /* qcode:Q_KEY_CODE_AGAIN (again) -> linux:129 (KEY_AGAIN) -> atset1:57349 */
+  [Q_KEY_CODE_ALT] = 0x38, /* qcode:Q_KEY_CODE_ALT (alt) -> linux:56 (KEY_LEFTALT) -> atset1:56 */
+  [Q_KEY_CODE_ALT_R] = 0xe038, /* qcode:Q_KEY_CODE_ALT_R (alt_r) -> linux:100 (KEY_RIGHTALT) -> atset1:57400 */
+  [Q_KEY_CODE_APOSTROPHE] = 0x28, /* qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) -> linux:40 (KEY_APOSTROPHE) -> atset1:40 */
+  [Q_KEY_CODE_ASTERISK] = 0x37, /* qcode:Q_KEY_CODE_ASTERISK (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> atset1:55 */
+  [Q_KEY_CODE_AUDIOMUTE] = 0xe020, /* qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) -> linux:113 (KEY_MUTE) -> atset1:57376 */
+  [Q_KEY_CODE_AUDIONEXT] = 0xe019, /* qcode:Q_KEY_CODE_AUDIONEXT (audionext) -> linux:163 (KEY_NEXTSONG) -> atset1:57369 */
+  [Q_KEY_CODE_AUDIOPLAY] = 0xe022, /* qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) -> linux:164 (KEY_PLAYPAUSE) -> atset1:57378 */
+  [Q_KEY_CODE_AUDIOPREV] = 0xe010, /* qcode:Q_KEY_CODE_AUDIOPREV (audioprev) -> linux:165 (KEY_PREVIOUSSONG) -> atset1:57360 */
+  [Q_KEY_CODE_AUDIOSTOP] = 0xe024, /* qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) -> linux:166 (KEY_STOPCD) -> atset1:57380 */
+  [Q_KEY_CODE_B] = 0x30, /* qcode:Q_KEY_CODE_B (b) -> linux:48 (KEY_B) -> atset1:48 */
+  [Q_KEY_CODE_BACKSLASH] = 0x2b, /* qcode:Q_KEY_CODE_BACKSLASH (backslash) -> linux:43 (KEY_BACKSLASH) -> atset1:43 */
+  [Q_KEY_CODE_BACKSPACE] = 0xe, /* qcode:Q_KEY_CODE_BACKSPACE (backspace) -> linux:14 (KEY_BACKSPACE) -> atset1:14 */
+  [Q_KEY_CODE_BRACKET_LEFT] = 0x1a, /* qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) -> linux:26 (KEY_LEFTBRACE) -> atset1:26 */
+  [Q_KEY_CODE_BRACKET_RIGHT] = 0x1b, /* qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) -> linux:27 (KEY_RIGHTBRACE) -> atset1:27 */
+  [Q_KEY_CODE_C] = 0x2e, /* qcode:Q_KEY_CODE_C (c) -> linux:46 (KEY_C) -> atset1:46 */
+  [Q_KEY_CODE_CALCULATOR] = 0xe021, /* qcode:Q_KEY_CODE_CALCULATOR (calculator) -> linux:140 (KEY_CALC) -> atset1:57377 */
+  [Q_KEY_CODE_CAPS_LOCK] = 0x3a, /* qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) -> linux:58 (KEY_CAPSLOCK) -> atset1:58 */
+  [Q_KEY_CODE_COMMA] = 0x33, /* qcode:Q_KEY_CODE_COMMA (comma) -> linux:51 (KEY_COMMA) -> atset1:51 */
+  [Q_KEY_CODE_COMPOSE] = 0xe05d, /* qcode:Q_KEY_CODE_COMPOSE (compose) -> linux:127 (KEY_COMPOSE) -> atset1:57437 */
+  [Q_KEY_CODE_COMPUTER] = 0xe06b, /* qcode:Q_KEY_CODE_COMPUTER (computer) -> linux:157 (KEY_COMPUTER) -> atset1:57451 */
+  [Q_KEY_CODE_COPY] = 0xe078, /* qcode:Q_KEY_CODE_COPY (copy) -> linux:133 (KEY_COPY) -> atset1:57464 */
+  [Q_KEY_CODE_CTRL] = 0x1d, /* qcode:Q_KEY_CODE_CTRL (ctrl) -> linux:29 (KEY_LEFTCTRL) -> atset1:29 */
+  [Q_KEY_CODE_CTRL_R] = 0xe01d, /* qcode:Q_KEY_CODE_CTRL_R (ctrl_r) -> linux:97 (KEY_RIGHTCTRL) -> atset1:57373 */
+  [Q_KEY_CODE_CUT] = 0xe03c, /* qcode:Q_KEY_CODE_CUT (cut) -> linux:137 (KEY_CUT) -> atset1:57404 */
+  [Q_KEY_CODE_D] = 0x20, /* qcode:Q_KEY_CODE_D (d) -> linux:32 (KEY_D) -> atset1:32 */
+  [Q_KEY_CODE_DELETE] = 0xe053, /* qcode:Q_KEY_CODE_DELETE (delete) -> linux:111 (KEY_DELETE) -> atset1:57427 */
+  [Q_KEY_CODE_DOT] = 0x34, /* qcode:Q_KEY_CODE_DOT (dot) -> linux:52 (KEY_DOT) -> atset1:52 */
+  [Q_KEY_CODE_DOWN] = 0xe050, /* qcode:Q_KEY_CODE_DOWN (down) -> linux:108 (KEY_DOWN) -> atset1:57424 */
+  [Q_KEY_CODE_E] = 0x12, /* qcode:Q_KEY_CODE_E (e) -> linux:18 (KEY_E) -> atset1:18 */
+  [Q_KEY_CODE_END] = 0xe04f, /* qcode:Q_KEY_CODE_END (end) -> linux:107 (KEY_END) -> atset1:57423 */
+  [Q_KEY_CODE_EQUAL] = 0xd, /* qcode:Q_KEY_CODE_EQUAL (equal) -> linux:13 (KEY_EQUAL) -> atset1:13 */
+  [Q_KEY_CODE_ESC] = 0x1, /* qcode:Q_KEY_CODE_ESC (esc) -> linux:1 (KEY_ESC) -> atset1:1 */
+  [Q_KEY_CODE_F] = 0x21, /* qcode:Q_KEY_CODE_F (f) -> linux:33 (KEY_F) -> atset1:33 */
+  [Q_KEY_CODE_F1] = 0x3b, /* qcode:Q_KEY_CODE_F1 (f1) -> linux:59 (KEY_F1) -> atset1:59 */
+  [Q_KEY_CODE_F10] = 0x44, /* qcode:Q_KEY_CODE_F10 (f10) -> linux:68 (KEY_F10) -> atset1:68 */
+  [Q_KEY_CODE_F11] = 0x57, /* qcode:Q_KEY_CODE_F11 (f11) -> linux:87 (KEY_F11) -> atset1:87 */
+  [Q_KEY_CODE_F12] = 0x58, /* qcode:Q_KEY_CODE_F12 (f12) -> linux:88 (KEY_F12) -> atset1:88 */
+  [Q_KEY_CODE_F2] = 0x3c, /* qcode:Q_KEY_CODE_F2 (f2) -> linux:60 (KEY_F2) -> atset1:60 */
+  [Q_KEY_CODE_F3] = 0x3d, /* qcode:Q_KEY_CODE_F3 (f3) -> linux:61 (KEY_F3) -> atset1:61 */
+  [Q_KEY_CODE_F4] = 0x3e, /* qcode:Q_KEY_CODE_F4 (f4) -> linux:62 (KEY_F4) -> atset1:62 */
+  [Q_KEY_CODE_F5] = 0x3f, /* qcode:Q_KEY_CODE_F5 (f5) -> linux:63 (KEY_F5) -> atset1:63 */
+  [Q_KEY_CODE_F6] = 0x40, /* qcode:Q_KEY_CODE_F6 (f6) -> linux:64 (KEY_F6) -> atset1:64 */
+  [Q_KEY_CODE_F7] = 0x41, /* qcode:Q_KEY_CODE_F7 (f7) -> linux:65 (KEY_F7) -> atset1:65 */
+  [Q_KEY_CODE_F8] = 0x42, /* qcode:Q_KEY_CODE_F8 (f8) -> linux:66 (KEY_F8) -> atset1:66 */
+  [Q_KEY_CODE_F9] = 0x43, /* qcode:Q_KEY_CODE_F9 (f9) -> linux:67 (KEY_F9) -> atset1:67 */
+  [Q_KEY_CODE_FIND] = 0xe041, /* qcode:Q_KEY_CODE_FIND (find) -> linux:136 (KEY_FIND) -> atset1:57409 */
+  [Q_KEY_CODE_FRONT] = 0xe00c, /* qcode:Q_KEY_CODE_FRONT (front) -> linux:132 (KEY_FRONT) -> atset1:57356 */
+  [Q_KEY_CODE_G] = 0x22, /* qcode:Q_KEY_CODE_G (g) -> linux:34 (KEY_G) -> atset1:34 */
+  [Q_KEY_CODE_GRAVE_ACCENT] = 0x29, /* qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) -> linux:41 (KEY_GRAVE) -> atset1:41 */
+  [Q_KEY_CODE_H] = 0x23, /* qcode:Q_KEY_CODE_H (h) -> linux:35 (KEY_H) -> atset1:35 */
+  [Q_KEY_CODE_HELP] = 0xe075, /* qcode:Q_KEY_CODE_HELP (help) -> linux:138 (KEY_HELP) -> atset1:57461 */
+  [Q_KEY_CODE_HENKAN] = 0x79, /* qcode:Q_KEY_CODE_HENKAN (henkan) -> linux:92 (KEY_HENKAN) -> atset1:121 */
+  [Q_KEY_CODE_HIRAGANA] = 0x77, /* qcode:Q_KEY_CODE_HIRAGANA (hiragana) -> linux:91 (KEY_HIRAGANA) -> atset1:119 */
+  [Q_KEY_CODE_HOME] = 0xe047, /* qcode:Q_KEY_CODE_HOME (home) -> linux:102 (KEY_HOME) -> atset1:57415 */
+  [Q_KEY_CODE_I] = 0x17, /* qcode:Q_KEY_CODE_I (i) -> linux:23 (KEY_I) -> atset1:23 */
+  [Q_KEY_CODE_INSERT] = 0xe052, /* qcode:Q_KEY_CODE_INSERT (insert) -> linux:110 (KEY_INSERT) -> atset1:57426 */
+  [Q_KEY_CODE_J] = 0x24, /* qcode:Q_KEY_CODE_J (j) -> linux:36 (KEY_J) -> atset1:36 */
+  [Q_KEY_CODE_K] = 0x25, /* qcode:Q_KEY_CODE_K (k) -> linux:37 (KEY_K) -> atset1:37 */
+  [Q_KEY_CODE_KP_0] = 0x52, /* qcode:Q_KEY_CODE_KP_0 (kp_0) -> linux:82 (KEY_KP0) -> atset1:82 */
+  [Q_KEY_CODE_KP_1] = 0x4f, /* qcode:Q_KEY_CODE_KP_1 (kp_1) -> linux:79 (KEY_KP1) -> atset1:79 */
+  [Q_KEY_CODE_KP_2] = 0x50, /* qcode:Q_KEY_CODE_KP_2 (kp_2) -> linux:80 (KEY_KP2) -> atset1:80 */
+  [Q_KEY_CODE_KP_3] = 0x51, /* qcode:Q_KEY_CODE_KP_3 (kp_3) -> linux:81 (KEY_KP3) -> atset1:81 */
+  [Q_KEY_CODE_KP_4] = 0x4b, /* qcode:Q_KEY_CODE_KP_4 (kp_4) -> linux:75 (KEY_KP4) -> atset1:75 */
+  [Q_KEY_CODE_KP_5] = 0x4c, /* qcode:Q_KEY_CODE_KP_5 (kp_5) -> linux:76 (KEY_KP5) -> atset1:76 */
+  [Q_KEY_CODE_KP_6] = 0x4d, /* qcode:Q_KEY_CODE_KP_6 (kp_6) -> linux:77 (KEY_KP6) -> atset1:77 */
+  [Q_KEY_CODE_KP_7] = 0x47, /* qcode:Q_KEY_CODE_KP_7 (kp_7) -> linux:71 (KEY_KP7) -> atset1:71 */
+  [Q_KEY_CODE_KP_8] = 0x48, /* qcode:Q_KEY_CODE_KP_8 (kp_8) -> linux:72 (KEY_KP8) -> atset1:72 */
+  [Q_KEY_CODE_KP_9] = 0x49, /* qcode:Q_KEY_CODE_KP_9 (kp_9) -> linux:73 (KEY_KP9) -> atset1:73 */
+  [Q_KEY_CODE_KP_ADD] = 0x4e, /* qcode:Q_KEY_CODE_KP_ADD (kp_add) -> linux:78 (KEY_KPPLUS) -> atset1:78 */
+  [Q_KEY_CODE_KP_COMMA] = 0x7e, /* qcode:Q_KEY_CODE_KP_COMMA (kp_comma) -> linux:121 (KEY_KPCOMMA) -> atset1:126 */
+  [Q_KEY_CODE_KP_DECIMAL] = 0x53, /* qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) -> linux:83 (KEY_KPDOT) -> atset1:83 */
+  [Q_KEY_CODE_KP_DIVIDE] = 0xe035, /* qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) -> linux:98 (KEY_KPSLASH) -> atset1:57397 */
+  [Q_KEY_CODE_KP_ENTER] = 0xe01c, /* qcode:Q_KEY_CODE_KP_ENTER (kp_enter) -> linux:96 (KEY_KPENTER) -> atset1:57372 */
+  [Q_KEY_CODE_KP_EQUALS] = 0x59, /* qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) -> linux:117 (KEY_KPEQUAL) -> atset1:89 */
+  [Q_KEY_CODE_KP_MULTIPLY] = 0x37, /* qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> atset1:55 */
+  [Q_KEY_CODE_KP_SUBTRACT] = 0x4a, /* qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) -> linux:74 (KEY_KPMINUS) -> atset1:74 */
+  [Q_KEY_CODE_L] = 0x26, /* qcode:Q_KEY_CODE_L (l) -> linux:38 (KEY_L) -> atset1:38 */
+  [Q_KEY_CODE_LEFT] = 0xe04b, /* qcode:Q_KEY_CODE_LEFT (left) -> linux:105 (KEY_LEFT) -> atset1:57419 */
+  [Q_KEY_CODE_LESS] = 0x56, /* qcode:Q_KEY_CODE_LESS (less) -> linux:86 (KEY_102ND) -> atset1:86 */
+  [Q_KEY_CODE_LF] = 0x5b, /* qcode:Q_KEY_CODE_LF (lf) -> linux:101 (KEY_LINEFEED) -> atset1:91 */
+  [Q_KEY_CODE_M] = 0x32, /* qcode:Q_KEY_CODE_M (m) -> linux:50 (KEY_M) -> atset1:50 */
+  [Q_KEY_CODE_MAIL] = 0xe06c, /* qcode:Q_KEY_CODE_MAIL (mail) -> linux:155 (KEY_MAIL) -> atset1:57452 */
+  [Q_KEY_CODE_MEDIASELECT] = 0xe06d, /* qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) -> linux:226 (KEY_MEDIA) -> atset1:57453 */
+  [Q_KEY_CODE_MENU] = 0xe01e, /* qcode:Q_KEY_CODE_MENU (menu) -> linux:139 (KEY_MENU) -> atset1:57374 */
+  [Q_KEY_CODE_META_L] = 0xe05b, /* qcode:Q_KEY_CODE_META_L (meta_l) -> linux:125 (KEY_LEFTMETA) -> atset1:57435 */
+  [Q_KEY_CODE_META_R] = 0xe05c, /* qcode:Q_KEY_CODE_META_R (meta_r) -> linux:126 (KEY_RIGHTMETA) -> atset1:57436 */
+  [Q_KEY_CODE_MINUS] = 0xc, /* qcode:Q_KEY_CODE_MINUS (minus) -> linux:12 (KEY_MINUS) -> atset1:12 */
+  [Q_KEY_CODE_N] = 0x31, /* qcode:Q_KEY_CODE_N (n) -> linux:49 (KEY_N) -> atset1:49 */
+  [Q_KEY_CODE_NUM_LOCK] = 0x45, /* qcode:Q_KEY_CODE_NUM_LOCK (num_lock) -> linux:69 (KEY_NUMLOCK) -> atset1:69 */
+  [Q_KEY_CODE_O] = 0x18, /* qcode:Q_KEY_CODE_O (o) -> linux:24 (KEY_O) -> atset1:24 */
+  [Q_KEY_CODE_OPEN] = 0x64, /* qcode:Q_KEY_CODE_OPEN (open) -> linux:134 (KEY_OPEN) -> atset1:100 */
+  [Q_KEY_CODE_P] = 0x19, /* qcode:Q_KEY_CODE_P (p) -> linux:25 (KEY_P) -> atset1:25 */
+  [Q_KEY_CODE_PASTE] = 0x65, /* qcode:Q_KEY_CODE_PASTE (paste) -> linux:135 (KEY_PASTE) -> atset1:101 */
+  [Q_KEY_CODE_PAUSE] = 0xe046, /* qcode:Q_KEY_CODE_PAUSE (pause) -> linux:119 (KEY_PAUSE) -> atset1:57414 */
+  [Q_KEY_CODE_PGDN] = 0xe051, /* qcode:Q_KEY_CODE_PGDN (pgdn) -> linux:109 (KEY_PAGEDOWN) -> atset1:57425 */
+  [Q_KEY_CODE_PGUP] = 0xe049, /* qcode:Q_KEY_CODE_PGUP (pgup) -> linux:104 (KEY_PAGEUP) -> atset1:57417 */
+  [Q_KEY_CODE_POWER] = 0xe05e, /* qcode:Q_KEY_CODE_POWER (power) -> linux:116 (KEY_POWER) -> atset1:57438 */
+  [Q_KEY_CODE_PRINT] = 0x54, /* qcode:Q_KEY_CODE_PRINT (sysrq) -> linux:99 (KEY_SYSRQ) -> atset1:84 */
+  [Q_KEY_CODE_PROPS] = 0xe006, /* qcode:Q_KEY_CODE_PROPS (props) -> linux:130 (KEY_PROPS) -> atset1:57350 */
+  [Q_KEY_CODE_Q] = 0x10, /* qcode:Q_KEY_CODE_Q (q) -> linux:16 (KEY_Q) -> atset1:16 */
+  [Q_KEY_CODE_R] = 0x13, /* qcode:Q_KEY_CODE_R (r) -> linux:19 (KEY_R) -> atset1:19 */
+  [Q_KEY_CODE_RET] = 0x1c, /* qcode:Q_KEY_CODE_RET (ret) -> linux:28 (KEY_ENTER) -> atset1:28 */
+  [Q_KEY_CODE_RIGHT] = 0xe04d, /* qcode:Q_KEY_CODE_RIGHT (right) -> linux:106 (KEY_RIGHT) -> atset1:57421 */
+  [Q_KEY_CODE_RO] = 0x73, /* qcode:Q_KEY_CODE_RO (ro) -> linux:89 (KEY_RO) -> atset1:115 */
+  [Q_KEY_CODE_S] = 0x1f, /* qcode:Q_KEY_CODE_S (s) -> linux:31 (KEY_S) -> atset1:31 */
+  [Q_KEY_CODE_SCROLL_LOCK] = 0x46, /* qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) -> linux:70 (KEY_SCROLLLOCK) -> atset1:70 */
+  [Q_KEY_CODE_SEMICOLON] = 0x27, /* qcode:Q_KEY_CODE_SEMICOLON (semicolon) -> linux:39 (KEY_SEMICOLON) -> atset1:39 */
+  [Q_KEY_CODE_SHIFT] = 0x2a, /* qcode:Q_KEY_CODE_SHIFT (shift) -> linux:42 (KEY_LEFTSHIFT) -> atset1:42 */
+  [Q_KEY_CODE_SHIFT_R] = 0x36, /* qcode:Q_KEY_CODE_SHIFT_R (shift_r) -> linux:54 (KEY_RIGHTSHIFT) -> atset1:54 */
+  [Q_KEY_CODE_SLASH] = 0x35, /* qcode:Q_KEY_CODE_SLASH (slash) -> linux:53 (KEY_SLASH) -> atset1:53 */
+  [Q_KEY_CODE_SLEEP] = 0xe05f, /* qcode:Q_KEY_CODE_SLEEP (sleep) -> linux:142 (KEY_SLEEP) -> atset1:57439 */
+  [Q_KEY_CODE_SPC] = 0x39, /* qcode:Q_KEY_CODE_SPC (spc) -> linux:57 (KEY_SPACE) -> atset1:57 */
+  [Q_KEY_CODE_STOP] = 0xe068, /* qcode:Q_KEY_CODE_STOP (stop) -> linux:128 (KEY_STOP) -> atset1:57448 */
+  [Q_KEY_CODE_SYSRQ] = 0x54, /* qcode:Q_KEY_CODE_SYSRQ (sysrq) -> linux:99 (KEY_SYSRQ) -> atset1:84 */
+  [Q_KEY_CODE_T] = 0x14, /* qcode:Q_KEY_CODE_T (t) -> linux:20 (KEY_T) -> atset1:20 */
+  [Q_KEY_CODE_TAB] = 0xf, /* qcode:Q_KEY_CODE_TAB (tab) -> linux:15 (KEY_TAB) -> atset1:15 */
+  [Q_KEY_CODE_U] = 0x16, /* qcode:Q_KEY_CODE_U (u) -> linux:22 (KEY_U) -> atset1:22 */
+  [Q_KEY_CODE_UNDO] = 0xe007, /* qcode:Q_KEY_CODE_UNDO (undo) -> linux:131 (KEY_UNDO) -> atset1:57351 */
+  [Q_KEY_CODE_UP] = 0xe048, /* qcode:Q_KEY_CODE_UP (up) -> linux:103 (KEY_UP) -> atset1:57416 */
+  [Q_KEY_CODE_V] = 0x2f, /* qcode:Q_KEY_CODE_V (v) -> linux:47 (KEY_V) -> atset1:47 */
+  [Q_KEY_CODE_VOLUMEDOWN] = 0xe02e, /* qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) -> linux:114 (KEY_VOLUMEDOWN) -> atset1:57390 */
+  [Q_KEY_CODE_VOLUMEUP] = 0xe030, /* qcode:Q_KEY_CODE_VOLUMEUP (volumeup) -> linux:115 (KEY_VOLUMEUP) -> atset1:57392 */
+  [Q_KEY_CODE_W] = 0x11, /* qcode:Q_KEY_CODE_W (w) -> linux:17 (KEY_W) -> atset1:17 */
+  [Q_KEY_CODE_WAKE] = 0xe063, /* qcode:Q_KEY_CODE_WAKE (wake) -> linux:143 (KEY_WAKEUP) -> atset1:57443 */
+  [Q_KEY_CODE_X] = 0x2d, /* qcode:Q_KEY_CODE_X (x) -> linux:45 (KEY_X) -> atset1:45 */
+  [Q_KEY_CODE_Y] = 0x15, /* qcode:Q_KEY_CODE_Y (y) -> linux:21 (KEY_Y) -> atset1:21 */
+  [Q_KEY_CODE_YEN] = 0x7d, /* qcode:Q_KEY_CODE_YEN (yen) -> linux:124 (KEY_YEN) -> atset1:125 */
+  [Q_KEY_CODE_Z] = 0x2c, /* qcode:Q_KEY_CODE_Z (z) -> linux:44 (KEY_Z) -> atset1:44 */
+};
+const guint qemu_input_map_qcode_to_atset1_len = sizeof(qemu_input_map_qcode_to_atset1)/sizeof(qemu_input_map_qcode_to_atset1[0]);
diff --git a/ui/input-keymap-qcode-to-atset2.c b/ui/input-keymap-qcode-to-atset2.c
new file mode 100644
index 0000000000..ba168db5f7
--- /dev/null
+++ b/ui/input-keymap-qcode-to-atset2.c
@@ -0,0 +1,142 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:06
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_qcode_to_atset2 code-map keymaps.csv qcode atset2
+*/
+const guint16 qemu_input_map_qcode_to_atset2[Q_KEY_CODE__MAX] = {
+  [Q_KEY_CODE_0] = 0x45, /* qcode:Q_KEY_CODE_0 (0) -> linux:11 (KEY_0) -> atset2:69 */
+  [Q_KEY_CODE_1] = 0x16, /* qcode:Q_KEY_CODE_1 (1) -> linux:2 (KEY_1) -> atset2:22 */
+  [Q_KEY_CODE_2] = 0x1e, /* qcode:Q_KEY_CODE_2 (2) -> linux:3 (KEY_2) -> atset2:30 */
+  [Q_KEY_CODE_3] = 0x26, /* qcode:Q_KEY_CODE_3 (3) -> linux:4 (KEY_3) -> atset2:38 */
+  [Q_KEY_CODE_4] = 0x25, /* qcode:Q_KEY_CODE_4 (4) -> linux:5 (KEY_4) -> atset2:37 */
+  [Q_KEY_CODE_5] = 0x2e, /* qcode:Q_KEY_CODE_5 (5) -> linux:6 (KEY_5) -> atset2:46 */
+  [Q_KEY_CODE_6] = 0x36, /* qcode:Q_KEY_CODE_6 (6) -> linux:7 (KEY_6) -> atset2:54 */
+  [Q_KEY_CODE_7] = 0x3d, /* qcode:Q_KEY_CODE_7 (7) -> linux:8 (KEY_7) -> atset2:61 */
+  [Q_KEY_CODE_8] = 0x3e, /* qcode:Q_KEY_CODE_8 (8) -> linux:9 (KEY_8) -> atset2:62 */
+  [Q_KEY_CODE_9] = 0x46, /* qcode:Q_KEY_CODE_9 (9) -> linux:10 (KEY_9) -> atset2:70 */
+  [Q_KEY_CODE_A] = 0x1c, /* qcode:Q_KEY_CODE_A (a) -> linux:30 (KEY_A) -> atset2:28 */
+  [Q_KEY_CODE_AC_BACK] = 0xe038, /* qcode:Q_KEY_CODE_AC_BACK (ac_back) -> linux:158 (KEY_BACK) -> atset2:57400 */
+  [Q_KEY_CODE_AC_BOOKMARKS] = 0xe018, /* qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) -> linux:156 (KEY_BOOKMARKS) -> atset2:57368 */
+  [Q_KEY_CODE_AC_FORWARD] = 0xe030, /* qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) -> linux:159 (KEY_FORWARD) -> atset2:57392 */
+  [Q_KEY_CODE_AC_HOME] = 0xe03a, /* qcode:Q_KEY_CODE_AC_HOME (ac_home) -> linux:172 (KEY_HOMEPAGE) -> atset2:57402 */
+  [Q_KEY_CODE_AC_REFRESH] = 0xe020, /* qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) -> linux:173 (KEY_REFRESH) -> atset2:57376 */
+  [Q_KEY_CODE_ALT] = 0x11, /* qcode:Q_KEY_CODE_ALT (alt) -> linux:56 (KEY_LEFTALT) -> atset2:17 */
+  [Q_KEY_CODE_ALT_R] = 0xe011, /* qcode:Q_KEY_CODE_ALT_R (alt_r) -> linux:100 (KEY_RIGHTALT) -> atset2:57361 */
+  [Q_KEY_CODE_APOSTROPHE] = 0x52, /* qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) -> linux:40 (KEY_APOSTROPHE) -> atset2:82 */
+  [Q_KEY_CODE_ASTERISK] = 0x7c, /* qcode:Q_KEY_CODE_ASTERISK (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> atset2:124 */
+  [Q_KEY_CODE_AUDIOMUTE] = 0xe023, /* qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) -> linux:113 (KEY_MUTE) -> atset2:57379 */
+  [Q_KEY_CODE_AUDIONEXT] = 0xe04d, /* qcode:Q_KEY_CODE_AUDIONEXT (audionext) -> linux:163 (KEY_NEXTSONG) -> atset2:57421 */
+  [Q_KEY_CODE_AUDIOPLAY] = 0xe034, /* qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) -> linux:164 (KEY_PLAYPAUSE) -> atset2:57396 */
+  [Q_KEY_CODE_AUDIOPREV] = 0xe015, /* qcode:Q_KEY_CODE_AUDIOPREV (audioprev) -> linux:165 (KEY_PREVIOUSSONG) -> atset2:57365 */
+  [Q_KEY_CODE_AUDIOSTOP] = 0xe03b, /* qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) -> linux:166 (KEY_STOPCD) -> atset2:57403 */
+  [Q_KEY_CODE_B] = 0x32, /* qcode:Q_KEY_CODE_B (b) -> linux:48 (KEY_B) -> atset2:50 */
+  [Q_KEY_CODE_BACKSLASH] = 0x5d, /* qcode:Q_KEY_CODE_BACKSLASH (backslash) -> linux:43 (KEY_BACKSLASH) -> atset2:93 */
+  [Q_KEY_CODE_BACKSPACE] = 0x66, /* qcode:Q_KEY_CODE_BACKSPACE (backspace) -> linux:14 (KEY_BACKSPACE) -> atset2:102 */
+  [Q_KEY_CODE_BRACKET_LEFT] = 0x54, /* qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) -> linux:26 (KEY_LEFTBRACE) -> atset2:84 */
+  [Q_KEY_CODE_BRACKET_RIGHT] = 0x5b, /* qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) -> linux:27 (KEY_RIGHTBRACE) -> atset2:91 */
+  [Q_KEY_CODE_C] = 0x21, /* qcode:Q_KEY_CODE_C (c) -> linux:46 (KEY_C) -> atset2:33 */
+  [Q_KEY_CODE_CALCULATOR] = 0xe02b, /* qcode:Q_KEY_CODE_CALCULATOR (calculator) -> linux:140 (KEY_CALC) -> atset2:57387 */
+  [Q_KEY_CODE_CAPS_LOCK] = 0x58, /* qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) -> linux:58 (KEY_CAPSLOCK) -> atset2:88 */
+  [Q_KEY_CODE_COMMA] = 0x41, /* qcode:Q_KEY_CODE_COMMA (comma) -> linux:51 (KEY_COMMA) -> atset2:65 */
+  [Q_KEY_CODE_COMPOSE] = 0xe02f, /* qcode:Q_KEY_CODE_COMPOSE (compose) -> linux:127 (KEY_COMPOSE) -> atset2:57391 */
+  [Q_KEY_CODE_COMPUTER] = 0xe040, /* qcode:Q_KEY_CODE_COMPUTER (computer) -> linux:157 (KEY_COMPUTER) -> atset2:57408 */
+  [Q_KEY_CODE_CTRL] = 0x14, /* qcode:Q_KEY_CODE_CTRL (ctrl) -> linux:29 (KEY_LEFTCTRL) -> atset2:20 */
+  [Q_KEY_CODE_CTRL_R] = 0xe014, /* qcode:Q_KEY_CODE_CTRL_R (ctrl_r) -> linux:97 (KEY_RIGHTCTRL) -> atset2:57364 */
+  [Q_KEY_CODE_D] = 0x23, /* qcode:Q_KEY_CODE_D (d) -> linux:32 (KEY_D) -> atset2:35 */
+  [Q_KEY_CODE_DELETE] = 0xe071, /* qcode:Q_KEY_CODE_DELETE (delete) -> linux:111 (KEY_DELETE) -> atset2:57457 */
+  [Q_KEY_CODE_DOT] = 0x49, /* qcode:Q_KEY_CODE_DOT (dot) -> linux:52 (KEY_DOT) -> atset2:73 */
+  [Q_KEY_CODE_DOWN] = 0xe072, /* qcode:Q_KEY_CODE_DOWN (down) -> linux:108 (KEY_DOWN) -> atset2:57458 */
+  [Q_KEY_CODE_E] = 0x24, /* qcode:Q_KEY_CODE_E (e) -> linux:18 (KEY_E) -> atset2:36 */
+  [Q_KEY_CODE_END] = 0xe069, /* qcode:Q_KEY_CODE_END (end) -> linux:107 (KEY_END) -> atset2:57449 */
+  [Q_KEY_CODE_EQUAL] = 0x55, /* qcode:Q_KEY_CODE_EQUAL (equal) -> linux:13 (KEY_EQUAL) -> atset2:85 */
+  [Q_KEY_CODE_ESC] = 0x76, /* qcode:Q_KEY_CODE_ESC (esc) -> linux:1 (KEY_ESC) -> atset2:118 */
+  [Q_KEY_CODE_F] = 0x2b, /* qcode:Q_KEY_CODE_F (f) -> linux:33 (KEY_F) -> atset2:43 */
+  [Q_KEY_CODE_F1] = 0x5, /* qcode:Q_KEY_CODE_F1 (f1) -> linux:59 (KEY_F1) -> atset2:5 */
+  [Q_KEY_CODE_F10] = 0x9, /* qcode:Q_KEY_CODE_F10 (f10) -> linux:68 (KEY_F10) -> atset2:9 */
+  [Q_KEY_CODE_F11] = 0x78, /* qcode:Q_KEY_CODE_F11 (f11) -> linux:87 (KEY_F11) -> atset2:120 */
+  [Q_KEY_CODE_F12] = 0x7, /* qcode:Q_KEY_CODE_F12 (f12) -> linux:88 (KEY_F12) -> atset2:7 */
+  [Q_KEY_CODE_F2] = 0x6, /* qcode:Q_KEY_CODE_F2 (f2) -> linux:60 (KEY_F2) -> atset2:6 */
+  [Q_KEY_CODE_F3] = 0x4, /* qcode:Q_KEY_CODE_F3 (f3) -> linux:61 (KEY_F3) -> atset2:4 */
+  [Q_KEY_CODE_F4] = 0xc, /* qcode:Q_KEY_CODE_F4 (f4) -> linux:62 (KEY_F4) -> atset2:12 */
+  [Q_KEY_CODE_F5] = 0x3, /* qcode:Q_KEY_CODE_F5 (f5) -> linux:63 (KEY_F5) -> atset2:3 */
+  [Q_KEY_CODE_F6] = 0xb, /* qcode:Q_KEY_CODE_F6 (f6) -> linux:64 (KEY_F6) -> atset2:11 */
+  [Q_KEY_CODE_F7] = 0x83, /* qcode:Q_KEY_CODE_F7 (f7) -> linux:65 (KEY_F7) -> atset2:131 */
+  [Q_KEY_CODE_F8] = 0xa, /* qcode:Q_KEY_CODE_F8 (f8) -> linux:66 (KEY_F8) -> atset2:10 */
+  [Q_KEY_CODE_F9] = 0x1, /* qcode:Q_KEY_CODE_F9 (f9) -> linux:67 (KEY_F9) -> atset2:1 */
+  [Q_KEY_CODE_G] = 0x34, /* qcode:Q_KEY_CODE_G (g) -> linux:34 (KEY_G) -> atset2:52 */
+  [Q_KEY_CODE_GRAVE_ACCENT] = 0xe, /* qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) -> linux:41 (KEY_GRAVE) -> atset2:14 */
+  [Q_KEY_CODE_H] = 0x33, /* qcode:Q_KEY_CODE_H (h) -> linux:35 (KEY_H) -> atset2:51 */
+  [Q_KEY_CODE_HENKAN] = 0x64, /* qcode:Q_KEY_CODE_HENKAN (henkan) -> linux:92 (KEY_HENKAN) -> atset2:100 */
+  [Q_KEY_CODE_HIRAGANA] = 0x62, /* qcode:Q_KEY_CODE_HIRAGANA (hiragana) -> linux:91 (KEY_HIRAGANA) -> atset2:98 */
+  [Q_KEY_CODE_HOME] = 0xe06c, /* qcode:Q_KEY_CODE_HOME (home) -> linux:102 (KEY_HOME) -> atset2:57452 */
+  [Q_KEY_CODE_I] = 0x43, /* qcode:Q_KEY_CODE_I (i) -> linux:23 (KEY_I) -> atset2:67 */
+  [Q_KEY_CODE_INSERT] = 0xe070, /* qcode:Q_KEY_CODE_INSERT (insert) -> linux:110 (KEY_INSERT) -> atset2:57456 */
+  [Q_KEY_CODE_J] = 0x3b, /* qcode:Q_KEY_CODE_J (j) -> linux:36 (KEY_J) -> atset2:59 */
+  [Q_KEY_CODE_K] = 0x42, /* qcode:Q_KEY_CODE_K (k) -> linux:37 (KEY_K) -> atset2:66 */
+  [Q_KEY_CODE_KP_0] = 0x70, /* qcode:Q_KEY_CODE_KP_0 (kp_0) -> linux:82 (KEY_KP0) -> atset2:112 */
+  [Q_KEY_CODE_KP_1] = 0x69, /* qcode:Q_KEY_CODE_KP_1 (kp_1) -> linux:79 (KEY_KP1) -> atset2:105 */
+  [Q_KEY_CODE_KP_2] = 0x72, /* qcode:Q_KEY_CODE_KP_2 (kp_2) -> linux:80 (KEY_KP2) -> atset2:114 */
+  [Q_KEY_CODE_KP_3] = 0x7a, /* qcode:Q_KEY_CODE_KP_3 (kp_3) -> linux:81 (KEY_KP3) -> atset2:122 */
+  [Q_KEY_CODE_KP_4] = 0x6b, /* qcode:Q_KEY_CODE_KP_4 (kp_4) -> linux:75 (KEY_KP4) -> atset2:107 */
+  [Q_KEY_CODE_KP_5] = 0x73, /* qcode:Q_KEY_CODE_KP_5 (kp_5) -> linux:76 (KEY_KP5) -> atset2:115 */
+  [Q_KEY_CODE_KP_6] = 0x74, /* qcode:Q_KEY_CODE_KP_6 (kp_6) -> linux:77 (KEY_KP6) -> atset2:116 */
+  [Q_KEY_CODE_KP_7] = 0x6c, /* qcode:Q_KEY_CODE_KP_7 (kp_7) -> linux:71 (KEY_KP7) -> atset2:108 */
+  [Q_KEY_CODE_KP_8] = 0x75, /* qcode:Q_KEY_CODE_KP_8 (kp_8) -> linux:72 (KEY_KP8) -> atset2:117 */
+  [Q_KEY_CODE_KP_9] = 0x7d, /* qcode:Q_KEY_CODE_KP_9 (kp_9) -> linux:73 (KEY_KP9) -> atset2:125 */
+  [Q_KEY_CODE_KP_ADD] = 0x79, /* qcode:Q_KEY_CODE_KP_ADD (kp_add) -> linux:78 (KEY_KPPLUS) -> atset2:121 */
+  [Q_KEY_CODE_KP_COMMA] = 0x6d, /* qcode:Q_KEY_CODE_KP_COMMA (kp_comma) -> linux:121 (KEY_KPCOMMA) -> atset2:109 */
+  [Q_KEY_CODE_KP_DECIMAL] = 0x71, /* qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) -> linux:83 (KEY_KPDOT) -> atset2:113 */
+  [Q_KEY_CODE_KP_DIVIDE] = 0xe04a, /* qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) -> linux:98 (KEY_KPSLASH) -> atset2:57418 */
+  [Q_KEY_CODE_KP_ENTER] = 0xe05a, /* qcode:Q_KEY_CODE_KP_ENTER (kp_enter) -> linux:96 (KEY_KPENTER) -> atset2:57434 */
+  [Q_KEY_CODE_KP_EQUALS] = 0xf, /* qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) -> linux:117 (KEY_KPEQUAL) -> atset2:15 */
+  [Q_KEY_CODE_KP_MULTIPLY] = 0x7c, /* qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> atset2:124 */
+  [Q_KEY_CODE_KP_SUBTRACT] = 0x7b, /* qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) -> linux:74 (KEY_KPMINUS) -> atset2:123 */
+  [Q_KEY_CODE_L] = 0x4b, /* qcode:Q_KEY_CODE_L (l) -> linux:38 (KEY_L) -> atset2:75 */
+  [Q_KEY_CODE_LEFT] = 0xe06b, /* qcode:Q_KEY_CODE_LEFT (left) -> linux:105 (KEY_LEFT) -> atset2:57451 */
+  [Q_KEY_CODE_LESS] = 0x61, /* qcode:Q_KEY_CODE_LESS (less) -> linux:86 (KEY_102ND) -> atset2:97 */
+  [Q_KEY_CODE_M] = 0x3a, /* qcode:Q_KEY_CODE_M (m) -> linux:50 (KEY_M) -> atset2:58 */
+  [Q_KEY_CODE_MAIL] = 0xe048, /* qcode:Q_KEY_CODE_MAIL (mail) -> linux:155 (KEY_MAIL) -> atset2:57416 */
+  [Q_KEY_CODE_MEDIASELECT] = 0xe050, /* qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) -> linux:226 (KEY_MEDIA) -> atset2:57424 */
+  [Q_KEY_CODE_META_L] = 0xe01f, /* qcode:Q_KEY_CODE_META_L (meta_l) -> linux:125 (KEY_LEFTMETA) -> atset2:57375 */
+  [Q_KEY_CODE_META_R] = 0xe027, /* qcode:Q_KEY_CODE_META_R (meta_r) -> linux:126 (KEY_RIGHTMETA) -> atset2:57383 */
+  [Q_KEY_CODE_MINUS] = 0x4e, /* qcode:Q_KEY_CODE_MINUS (minus) -> linux:12 (KEY_MINUS) -> atset2:78 */
+  [Q_KEY_CODE_N] = 0x31, /* qcode:Q_KEY_CODE_N (n) -> linux:49 (KEY_N) -> atset2:49 */
+  [Q_KEY_CODE_NUM_LOCK] = 0x77, /* qcode:Q_KEY_CODE_NUM_LOCK (num_lock) -> linux:69 (KEY_NUMLOCK) -> atset2:119 */
+  [Q_KEY_CODE_O] = 0x44, /* qcode:Q_KEY_CODE_O (o) -> linux:24 (KEY_O) -> atset2:68 */
+  [Q_KEY_CODE_P] = 0x4d, /* qcode:Q_KEY_CODE_P (p) -> linux:25 (KEY_P) -> atset2:77 */
+  [Q_KEY_CODE_PAUSE] = 0xe077, /* qcode:Q_KEY_CODE_PAUSE (pause) -> linux:119 (KEY_PAUSE) -> atset2:57463 */
+  [Q_KEY_CODE_PGDN] = 0xe07a, /* qcode:Q_KEY_CODE_PGDN (pgdn) -> linux:109 (KEY_PAGEDOWN) -> atset2:57466 */
+  [Q_KEY_CODE_PGUP] = 0xe07d, /* qcode:Q_KEY_CODE_PGUP (pgup) -> linux:104 (KEY_PAGEUP) -> atset2:57469 */
+  [Q_KEY_CODE_POWER] = 0xe037, /* qcode:Q_KEY_CODE_POWER (power) -> linux:116 (KEY_POWER) -> atset2:57399 */
+  [Q_KEY_CODE_PRINT] = 0x7f, /* qcode:Q_KEY_CODE_PRINT (sysrq) -> linux:99 (KEY_SYSRQ) -> atset2:127 */
+  [Q_KEY_CODE_Q] = 0x15, /* qcode:Q_KEY_CODE_Q (q) -> linux:16 (KEY_Q) -> atset2:21 */
+  [Q_KEY_CODE_R] = 0x2d, /* qcode:Q_KEY_CODE_R (r) -> linux:19 (KEY_R) -> atset2:45 */
+  [Q_KEY_CODE_RET] = 0x5a, /* qcode:Q_KEY_CODE_RET (ret) -> linux:28 (KEY_ENTER) -> atset2:90 */
+  [Q_KEY_CODE_RIGHT] = 0xe074, /* qcode:Q_KEY_CODE_RIGHT (right) -> linux:106 (KEY_RIGHT) -> atset2:57460 */
+  [Q_KEY_CODE_RO] = 0x51, /* qcode:Q_KEY_CODE_RO (ro) -> linux:89 (KEY_RO) -> atset2:81 */
+  [Q_KEY_CODE_S] = 0x1b, /* qcode:Q_KEY_CODE_S (s) -> linux:31 (KEY_S) -> atset2:27 */
+  [Q_KEY_CODE_SCROLL_LOCK] = 0x7e, /* qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) -> linux:70 (KEY_SCROLLLOCK) -> atset2:126 */
+  [Q_KEY_CODE_SEMICOLON] = 0x4c, /* qcode:Q_KEY_CODE_SEMICOLON (semicolon) -> linux:39 (KEY_SEMICOLON) -> atset2:76 */
+  [Q_KEY_CODE_SHIFT] = 0x12, /* qcode:Q_KEY_CODE_SHIFT (shift) -> linux:42 (KEY_LEFTSHIFT) -> atset2:18 */
+  [Q_KEY_CODE_SHIFT_R] = 0x59, /* qcode:Q_KEY_CODE_SHIFT_R (shift_r) -> linux:54 (KEY_RIGHTSHIFT) -> atset2:89 */
+  [Q_KEY_CODE_SLASH] = 0x4a, /* qcode:Q_KEY_CODE_SLASH (slash) -> linux:53 (KEY_SLASH) -> atset2:74 */
+  [Q_KEY_CODE_SLEEP] = 0xe03f, /* qcode:Q_KEY_CODE_SLEEP (sleep) -> linux:142 (KEY_SLEEP) -> atset2:57407 */
+  [Q_KEY_CODE_SPC] = 0x29, /* qcode:Q_KEY_CODE_SPC (spc) -> linux:57 (KEY_SPACE) -> atset2:41 */
+  [Q_KEY_CODE_STOP] = 0xe028, /* qcode:Q_KEY_CODE_STOP (stop) -> linux:128 (KEY_STOP) -> atset2:57384 */
+  [Q_KEY_CODE_SYSRQ] = 0x7f, /* qcode:Q_KEY_CODE_SYSRQ (sysrq) -> linux:99 (KEY_SYSRQ) -> atset2:127 */
+  [Q_KEY_CODE_T] = 0x2c, /* qcode:Q_KEY_CODE_T (t) -> linux:20 (KEY_T) -> atset2:44 */
+  [Q_KEY_CODE_TAB] = 0xd, /* qcode:Q_KEY_CODE_TAB (tab) -> linux:15 (KEY_TAB) -> atset2:13 */
+  [Q_KEY_CODE_U] = 0x3c, /* qcode:Q_KEY_CODE_U (u) -> linux:22 (KEY_U) -> atset2:60 */
+  [Q_KEY_CODE_UP] = 0xe075, /* qcode:Q_KEY_CODE_UP (up) -> linux:103 (KEY_UP) -> atset2:57461 */
+  [Q_KEY_CODE_V] = 0x2a, /* qcode:Q_KEY_CODE_V (v) -> linux:47 (KEY_V) -> atset2:42 */
+  [Q_KEY_CODE_VOLUMEDOWN] = 0xe021, /* qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) -> linux:114 (KEY_VOLUMEDOWN) -> atset2:57377 */
+  [Q_KEY_CODE_VOLUMEUP] = 0xe032, /* qcode:Q_KEY_CODE_VOLUMEUP (volumeup) -> linux:115 (KEY_VOLUMEUP) -> atset2:57394 */
+  [Q_KEY_CODE_W] = 0x1d, /* qcode:Q_KEY_CODE_W (w) -> linux:17 (KEY_W) -> atset2:29 */
+  [Q_KEY_CODE_WAKE] = 0xe05e, /* qcode:Q_KEY_CODE_WAKE (wake) -> linux:143 (KEY_WAKEUP) -> atset2:57438 */
+  [Q_KEY_CODE_X] = 0x22, /* qcode:Q_KEY_CODE_X (x) -> linux:45 (KEY_X) -> atset2:34 */
+  [Q_KEY_CODE_Y] = 0x35, /* qcode:Q_KEY_CODE_Y (y) -> linux:21 (KEY_Y) -> atset2:53 */
+  [Q_KEY_CODE_YEN] = 0x6a, /* qcode:Q_KEY_CODE_YEN (yen) -> linux:124 (KEY_YEN) -> atset2:106 */
+  [Q_KEY_CODE_Z] = 0x1a, /* qcode:Q_KEY_CODE_Z (z) -> linux:44 (KEY_Z) -> atset2:26 */
+};
+const guint qemu_input_map_qcode_to_atset2_len = sizeof(qemu_input_map_qcode_to_atset2)/sizeof(qemu_input_map_qcode_to_atset2[0]);
diff --git a/ui/input-keymap-qcode-to-atset3.c b/ui/input-keymap-qcode-to-atset3.c
new file mode 100644
index 0000000000..58aaed63a1
--- /dev/null
+++ b/ui/input-keymap-qcode-to-atset3.c
@@ -0,0 +1,138 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:06
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_qcode_to_atset3 code-map keymaps.csv qcode atset3
+*/
+const guint16 qemu_input_map_qcode_to_atset3[Q_KEY_CODE__MAX] = {
+  [Q_KEY_CODE_0] = 0x45, /* qcode:Q_KEY_CODE_0 (0) -> linux:11 (KEY_0) -> atset3:69 */
+  [Q_KEY_CODE_1] = 0x16, /* qcode:Q_KEY_CODE_1 (1) -> linux:2 (KEY_1) -> atset3:22 */
+  [Q_KEY_CODE_2] = 0x1e, /* qcode:Q_KEY_CODE_2 (2) -> linux:3 (KEY_2) -> atset3:30 */
+  [Q_KEY_CODE_3] = 0x26, /* qcode:Q_KEY_CODE_3 (3) -> linux:4 (KEY_3) -> atset3:38 */
+  [Q_KEY_CODE_4] = 0x25, /* qcode:Q_KEY_CODE_4 (4) -> linux:5 (KEY_4) -> atset3:37 */
+  [Q_KEY_CODE_5] = 0x2e, /* qcode:Q_KEY_CODE_5 (5) -> linux:6 (KEY_5) -> atset3:46 */
+  [Q_KEY_CODE_6] = 0x36, /* qcode:Q_KEY_CODE_6 (6) -> linux:7 (KEY_6) -> atset3:54 */
+  [Q_KEY_CODE_7] = 0x3d, /* qcode:Q_KEY_CODE_7 (7) -> linux:8 (KEY_7) -> atset3:61 */
+  [Q_KEY_CODE_8] = 0x3e, /* qcode:Q_KEY_CODE_8 (8) -> linux:9 (KEY_8) -> atset3:62 */
+  [Q_KEY_CODE_9] = 0x46, /* qcode:Q_KEY_CODE_9 (9) -> linux:10 (KEY_9) -> atset3:70 */
+  [Q_KEY_CODE_A] = 0x1c, /* qcode:Q_KEY_CODE_A (a) -> linux:30 (KEY_A) -> atset3:28 */
+  [Q_KEY_CODE_AC_HOME] = 0x97, /* qcode:Q_KEY_CODE_AC_HOME (ac_home) -> linux:172 (KEY_HOMEPAGE) -> atset3:151 */
+  [Q_KEY_CODE_AGAIN] = 0xb, /* qcode:Q_KEY_CODE_AGAIN (again) -> linux:129 (KEY_AGAIN) -> atset3:11 */
+  [Q_KEY_CODE_ALT] = 0x19, /* qcode:Q_KEY_CODE_ALT (alt) -> linux:56 (KEY_LEFTALT) -> atset3:25 */
+  [Q_KEY_CODE_ALT_R] = 0x39, /* qcode:Q_KEY_CODE_ALT_R (alt_r) -> linux:100 (KEY_RIGHTALT) -> atset3:57 */
+  [Q_KEY_CODE_APOSTROPHE] = 0x52, /* qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) -> linux:40 (KEY_APOSTROPHE) -> atset3:82 */
+  [Q_KEY_CODE_ASTERISK] = 0x7e, /* qcode:Q_KEY_CODE_ASTERISK (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> atset3:126 */
+  [Q_KEY_CODE_AUDIOMUTE] = 0x9c, /* qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) -> linux:113 (KEY_MUTE) -> atset3:156 */
+  [Q_KEY_CODE_AUDIONEXT] = 0x93, /* qcode:Q_KEY_CODE_AUDIONEXT (audionext) -> linux:163 (KEY_NEXTSONG) -> atset3:147 */
+  [Q_KEY_CODE_AUDIOPREV] = 0x94, /* qcode:Q_KEY_CODE_AUDIOPREV (audioprev) -> linux:165 (KEY_PREVIOUSSONG) -> atset3:148 */
+  [Q_KEY_CODE_AUDIOSTOP] = 0x98, /* qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) -> linux:166 (KEY_STOPCD) -> atset3:152 */
+  [Q_KEY_CODE_B] = 0x32, /* qcode:Q_KEY_CODE_B (b) -> linux:48 (KEY_B) -> atset3:50 */
+  [Q_KEY_CODE_BACKSLASH] = 0x5c, /* qcode:Q_KEY_CODE_BACKSLASH (backslash) -> linux:43 (KEY_BACKSLASH) -> atset3:92 */
+  [Q_KEY_CODE_BACKSPACE] = 0x66, /* qcode:Q_KEY_CODE_BACKSPACE (backspace) -> linux:14 (KEY_BACKSPACE) -> atset3:102 */
+  [Q_KEY_CODE_BRACKET_LEFT] = 0x54, /* qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) -> linux:26 (KEY_LEFTBRACE) -> atset3:84 */
+  [Q_KEY_CODE_BRACKET_RIGHT] = 0x5b, /* qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) -> linux:27 (KEY_RIGHTBRACE) -> atset3:91 */
+  [Q_KEY_CODE_C] = 0x21, /* qcode:Q_KEY_CODE_C (c) -> linux:46 (KEY_C) -> atset3:33 */
+  [Q_KEY_CODE_CALCULATOR] = 0xa3, /* qcode:Q_KEY_CODE_CALCULATOR (calculator) -> linux:140 (KEY_CALC) -> atset3:163 */
+  [Q_KEY_CODE_CAPS_LOCK] = 0x14, /* qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) -> linux:58 (KEY_CAPSLOCK) -> atset3:20 */
+  [Q_KEY_CODE_COMMA] = 0x41, /* qcode:Q_KEY_CODE_COMMA (comma) -> linux:51 (KEY_COMMA) -> atset3:65 */
+  [Q_KEY_CODE_COMPOSE] = 0x8d, /* qcode:Q_KEY_CODE_COMPOSE (compose) -> linux:127 (KEY_COMPOSE) -> atset3:141 */
+  [Q_KEY_CODE_COPY] = 0x18, /* qcode:Q_KEY_CODE_COPY (copy) -> linux:133 (KEY_COPY) -> atset3:24 */
+  [Q_KEY_CODE_CTRL] = 0x11, /* qcode:Q_KEY_CODE_CTRL (ctrl) -> linux:29 (KEY_LEFTCTRL) -> atset3:17 */
+  [Q_KEY_CODE_CTRL_R] = 0x58, /* qcode:Q_KEY_CODE_CTRL_R (ctrl_r) -> linux:97 (KEY_RIGHTCTRL) -> atset3:88 */
+  [Q_KEY_CODE_CUT] = 0x38, /* qcode:Q_KEY_CODE_CUT (cut) -> linux:137 (KEY_CUT) -> atset3:56 */
+  [Q_KEY_CODE_D] = 0x23, /* qcode:Q_KEY_CODE_D (d) -> linux:32 (KEY_D) -> atset3:35 */
+  [Q_KEY_CODE_DELETE] = 0x64, /* qcode:Q_KEY_CODE_DELETE (delete) -> linux:111 (KEY_DELETE) -> atset3:100 */
+  [Q_KEY_CODE_DOT] = 0x49, /* qcode:Q_KEY_CODE_DOT (dot) -> linux:52 (KEY_DOT) -> atset3:73 */
+  [Q_KEY_CODE_DOWN] = 0x60, /* qcode:Q_KEY_CODE_DOWN (down) -> linux:108 (KEY_DOWN) -> atset3:96 */
+  [Q_KEY_CODE_E] = 0x24, /* qcode:Q_KEY_CODE_E (e) -> linux:18 (KEY_E) -> atset3:36 */
+  [Q_KEY_CODE_END] = 0x65, /* qcode:Q_KEY_CODE_END (end) -> linux:107 (KEY_END) -> atset3:101 */
+  [Q_KEY_CODE_EQUAL] = 0x55, /* qcode:Q_KEY_CODE_EQUAL (equal) -> linux:13 (KEY_EQUAL) -> atset3:85 */
+  [Q_KEY_CODE_ESC] = 0x8, /* qcode:Q_KEY_CODE_ESC (esc) -> linux:1 (KEY_ESC) -> atset3:8 */
+  [Q_KEY_CODE_F] = 0x2b, /* qcode:Q_KEY_CODE_F (f) -> linux:33 (KEY_F) -> atset3:43 */
+  [Q_KEY_CODE_F1] = 0x7, /* qcode:Q_KEY_CODE_F1 (f1) -> linux:59 (KEY_F1) -> atset3:7 */
+  [Q_KEY_CODE_F10] = 0x4f, /* qcode:Q_KEY_CODE_F10 (f10) -> linux:68 (KEY_F10) -> atset3:79 */
+  [Q_KEY_CODE_F11] = 0x56, /* qcode:Q_KEY_CODE_F11 (f11) -> linux:87 (KEY_F11) -> atset3:86 */
+  [Q_KEY_CODE_F12] = 0x5e, /* qcode:Q_KEY_CODE_F12 (f12) -> linux:88 (KEY_F12) -> atset3:94 */
+  [Q_KEY_CODE_F2] = 0xf, /* qcode:Q_KEY_CODE_F2 (f2) -> linux:60 (KEY_F2) -> atset3:15 */
+  [Q_KEY_CODE_F3] = 0x17, /* qcode:Q_KEY_CODE_F3 (f3) -> linux:61 (KEY_F3) -> atset3:23 */
+  [Q_KEY_CODE_F4] = 0x1f, /* qcode:Q_KEY_CODE_F4 (f4) -> linux:62 (KEY_F4) -> atset3:31 */
+  [Q_KEY_CODE_F5] = 0x27, /* qcode:Q_KEY_CODE_F5 (f5) -> linux:63 (KEY_F5) -> atset3:39 */
+  [Q_KEY_CODE_F6] = 0x2f, /* qcode:Q_KEY_CODE_F6 (f6) -> linux:64 (KEY_F6) -> atset3:47 */
+  [Q_KEY_CODE_F7] = 0x37, /* qcode:Q_KEY_CODE_F7 (f7) -> linux:65 (KEY_F7) -> atset3:55 */
+  [Q_KEY_CODE_F8] = 0x3f, /* qcode:Q_KEY_CODE_F8 (f8) -> linux:66 (KEY_F8) -> atset3:63 */
+  [Q_KEY_CODE_F9] = 0x47, /* qcode:Q_KEY_CODE_F9 (f9) -> linux:67 (KEY_F9) -> atset3:71 */
+  [Q_KEY_CODE_FIND] = 0x30, /* qcode:Q_KEY_CODE_FIND (find) -> linux:136 (KEY_FIND) -> atset3:48 */
+  [Q_KEY_CODE_G] = 0x34, /* qcode:Q_KEY_CODE_G (g) -> linux:34 (KEY_G) -> atset3:52 */
+  [Q_KEY_CODE_GRAVE_ACCENT] = 0xe, /* qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) -> linux:41 (KEY_GRAVE) -> atset3:14 */
+  [Q_KEY_CODE_H] = 0x33, /* qcode:Q_KEY_CODE_H (h) -> linux:35 (KEY_H) -> atset3:51 */
+  [Q_KEY_CODE_HELP] = 0x9, /* qcode:Q_KEY_CODE_HELP (help) -> linux:138 (KEY_HELP) -> atset3:9 */
+  [Q_KEY_CODE_HENKAN] = 0x86, /* qcode:Q_KEY_CODE_HENKAN (henkan) -> linux:92 (KEY_HENKAN) -> atset3:134 */
+  [Q_KEY_CODE_HIRAGANA] = 0x87, /* qcode:Q_KEY_CODE_HIRAGANA (hiragana) -> linux:91 (KEY_HIRAGANA) -> atset3:135 */
+  [Q_KEY_CODE_HOME] = 0x6e, /* qcode:Q_KEY_CODE_HOME (home) -> linux:102 (KEY_HOME) -> atset3:110 */
+  [Q_KEY_CODE_I] = 0x43, /* qcode:Q_KEY_CODE_I (i) -> linux:23 (KEY_I) -> atset3:67 */
+  [Q_KEY_CODE_INSERT] = 0x67, /* qcode:Q_KEY_CODE_INSERT (insert) -> linux:110 (KEY_INSERT) -> atset3:103 */
+  [Q_KEY_CODE_J] = 0x3b, /* qcode:Q_KEY_CODE_J (j) -> linux:36 (KEY_J) -> atset3:59 */
+  [Q_KEY_CODE_K] = 0x42, /* qcode:Q_KEY_CODE_K (k) -> linux:37 (KEY_K) -> atset3:66 */
+  [Q_KEY_CODE_KP_0] = 0x70, /* qcode:Q_KEY_CODE_KP_0 (kp_0) -> linux:82 (KEY_KP0) -> atset3:112 */
+  [Q_KEY_CODE_KP_1] = 0x69, /* qcode:Q_KEY_CODE_KP_1 (kp_1) -> linux:79 (KEY_KP1) -> atset3:105 */
+  [Q_KEY_CODE_KP_2] = 0x72, /* qcode:Q_KEY_CODE_KP_2 (kp_2) -> linux:80 (KEY_KP2) -> atset3:114 */
+  [Q_KEY_CODE_KP_3] = 0x7a, /* qcode:Q_KEY_CODE_KP_3 (kp_3) -> linux:81 (KEY_KP3) -> atset3:122 */
+  [Q_KEY_CODE_KP_4] = 0x6b, /* qcode:Q_KEY_CODE_KP_4 (kp_4) -> linux:75 (KEY_KP4) -> atset3:107 */
+  [Q_KEY_CODE_KP_5] = 0x73, /* qcode:Q_KEY_CODE_KP_5 (kp_5) -> linux:76 (KEY_KP5) -> atset3:115 */
+  [Q_KEY_CODE_KP_6] = 0x74, /* qcode:Q_KEY_CODE_KP_6 (kp_6) -> linux:77 (KEY_KP6) -> atset3:116 */
+  [Q_KEY_CODE_KP_7] = 0x6c, /* qcode:Q_KEY_CODE_KP_7 (kp_7) -> linux:71 (KEY_KP7) -> atset3:108 */
+  [Q_KEY_CODE_KP_8] = 0x75, /* qcode:Q_KEY_CODE_KP_8 (kp_8) -> linux:72 (KEY_KP8) -> atset3:117 */
+  [Q_KEY_CODE_KP_9] = 0x7d, /* qcode:Q_KEY_CODE_KP_9 (kp_9) -> linux:73 (KEY_KP9) -> atset3:125 */
+  [Q_KEY_CODE_KP_ADD] = 0x7c, /* qcode:Q_KEY_CODE_KP_ADD (kp_add) -> linux:78 (KEY_KPPLUS) -> atset3:124 */
+  [Q_KEY_CODE_KP_DECIMAL] = 0x71, /* qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) -> linux:83 (KEY_KPDOT) -> atset3:113 */
+  [Q_KEY_CODE_KP_DIVIDE] = 0x4a, /* qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) -> linux:98 (KEY_KPSLASH) -> atset3:74 */
+  [Q_KEY_CODE_KP_ENTER] = 0x79, /* qcode:Q_KEY_CODE_KP_ENTER (kp_enter) -> linux:96 (KEY_KPENTER) -> atset3:121 */
+  [Q_KEY_CODE_KP_MULTIPLY] = 0x7e, /* qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) -> linux:55 (KEY_KPASTERISK) -> atset3:126 */
+  [Q_KEY_CODE_KP_SUBTRACT] = 0x4e, /* qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) -> linux:74 (KEY_KPMINUS) -> atset3:78 */
+  [Q_KEY_CODE_L] = 0x4b, /* qcode:Q_KEY_CODE_L (l) -> linux:38 (KEY_L) -> atset3:75 */
+  [Q_KEY_CODE_LEFT] = 0x61, /* qcode:Q_KEY_CODE_LEFT (left) -> linux:105 (KEY_LEFT) -> atset3:97 */
+  [Q_KEY_CODE_LESS] = 0x13, /* qcode:Q_KEY_CODE_LESS (less) -> linux:86 (KEY_102ND) -> atset3:19 */
+  [Q_KEY_CODE_M] = 0x3a, /* qcode:Q_KEY_CODE_M (m) -> linux:50 (KEY_M) -> atset3:58 */
+  [Q_KEY_CODE_MENU] = 0x91, /* qcode:Q_KEY_CODE_MENU (menu) -> linux:139 (KEY_MENU) -> atset3:145 */
+  [Q_KEY_CODE_META_L] = 0x8b, /* qcode:Q_KEY_CODE_META_L (meta_l) -> linux:125 (KEY_LEFTMETA) -> atset3:139 */
+  [Q_KEY_CODE_META_R] = 0x8c, /* qcode:Q_KEY_CODE_META_R (meta_r) -> linux:126 (KEY_RIGHTMETA) -> atset3:140 */
+  [Q_KEY_CODE_MINUS] = 0x4e, /* qcode:Q_KEY_CODE_MINUS (minus) -> linux:12 (KEY_MINUS) -> atset3:78 */
+  [Q_KEY_CODE_N] = 0x31, /* qcode:Q_KEY_CODE_N (n) -> linux:49 (KEY_N) -> atset3:49 */
+  [Q_KEY_CODE_NUM_LOCK] = 0x76, /* qcode:Q_KEY_CODE_NUM_LOCK (num_lock) -> linux:69 (KEY_NUMLOCK) -> atset3:118 */
+  [Q_KEY_CODE_O] = 0x44, /* qcode:Q_KEY_CODE_O (o) -> linux:24 (KEY_O) -> atset3:68 */
+  [Q_KEY_CODE_OPEN] = 0x20, /* qcode:Q_KEY_CODE_OPEN (open) -> linux:134 (KEY_OPEN) -> atset3:32 */
+  [Q_KEY_CODE_P] = 0x4d, /* qcode:Q_KEY_CODE_P (p) -> linux:25 (KEY_P) -> atset3:77 */
+  [Q_KEY_CODE_PASTE] = 0x28, /* qcode:Q_KEY_CODE_PASTE (paste) -> linux:135 (KEY_PASTE) -> atset3:40 */
+  [Q_KEY_CODE_PAUSE] = 0x62, /* qcode:Q_KEY_CODE_PAUSE (pause) -> linux:119 (KEY_PAUSE) -> atset3:98 */
+  [Q_KEY_CODE_PGDN] = 0x6d, /* qcode:Q_KEY_CODE_PGDN (pgdn) -> linux:109 (KEY_PAGEDOWN) -> atset3:109 */
+  [Q_KEY_CODE_PGUP] = 0x6f, /* qcode:Q_KEY_CODE_PGUP (pgup) -> linux:104 (KEY_PAGEUP) -> atset3:111 */
+  [Q_KEY_CODE_PRINT] = 0x57, /* qcode:Q_KEY_CODE_PRINT (sysrq) -> linux:99 (KEY_SYSRQ) -> atset3:87 */
+  [Q_KEY_CODE_PROPS] = 0xc, /* qcode:Q_KEY_CODE_PROPS (props) -> linux:130 (KEY_PROPS) -> atset3:12 */
+  [Q_KEY_CODE_Q] = 0x15, /* qcode:Q_KEY_CODE_Q (q) -> linux:16 (KEY_Q) -> atset3:21 */
+  [Q_KEY_CODE_R] = 0x2d, /* qcode:Q_KEY_CODE_R (r) -> linux:19 (KEY_R) -> atset3:45 */
+  [Q_KEY_CODE_RET] = 0x5a, /* qcode:Q_KEY_CODE_RET (ret) -> linux:28 (KEY_ENTER) -> atset3:90 */
+  [Q_KEY_CODE_RIGHT] = 0x6a, /* qcode:Q_KEY_CODE_RIGHT (right) -> linux:106 (KEY_RIGHT) -> atset3:106 */
+  [Q_KEY_CODE_S] = 0x1b, /* qcode:Q_KEY_CODE_S (s) -> linux:31 (KEY_S) -> atset3:27 */
+  [Q_KEY_CODE_SCROLL_LOCK] = 0x5f, /* qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) -> linux:70 (KEY_SCROLLLOCK) -> atset3:95 */
+  [Q_KEY_CODE_SEMICOLON] = 0x4c, /* qcode:Q_KEY_CODE_SEMICOLON (semicolon) -> linux:39 (KEY_SEMICOLON) -> atset3:76 */
+  [Q_KEY_CODE_SHIFT] = 0x12, /* qcode:Q_KEY_CODE_SHIFT (shift) -> linux:42 (KEY_LEFTSHIFT) -> atset3:18 */
+  [Q_KEY_CODE_SHIFT_R] = 0x59, /* qcode:Q_KEY_CODE_SHIFT_R (shift_r) -> linux:54 (KEY_RIGHTSHIFT) -> atset3:89 */
+  [Q_KEY_CODE_SLASH] = 0x4a, /* qcode:Q_KEY_CODE_SLASH (slash) -> linux:53 (KEY_SLASH) -> atset3:74 */
+  [Q_KEY_CODE_SPC] = 0x29, /* qcode:Q_KEY_CODE_SPC (spc) -> linux:57 (KEY_SPACE) -> atset3:41 */
+  [Q_KEY_CODE_STOP] = 0xa, /* qcode:Q_KEY_CODE_STOP (stop) -> linux:128 (KEY_STOP) -> atset3:10 */
+  [Q_KEY_CODE_SYSRQ] = 0x57, /* qcode:Q_KEY_CODE_SYSRQ (sysrq) -> linux:99 (KEY_SYSRQ) -> atset3:87 */
+  [Q_KEY_CODE_T] = 0x2c, /* qcode:Q_KEY_CODE_T (t) -> linux:20 (KEY_T) -> atset3:44 */
+  [Q_KEY_CODE_TAB] = 0xd, /* qcode:Q_KEY_CODE_TAB (tab) -> linux:15 (KEY_TAB) -> atset3:13 */
+  [Q_KEY_CODE_U] = 0x3c, /* qcode:Q_KEY_CODE_U (u) -> linux:22 (KEY_U) -> atset3:60 */
+  [Q_KEY_CODE_UNDO] = 0x10, /* qcode:Q_KEY_CODE_UNDO (undo) -> linux:131 (KEY_UNDO) -> atset3:16 */
+  [Q_KEY_CODE_UP] = 0x63, /* qcode:Q_KEY_CODE_UP (up) -> linux:103 (KEY_UP) -> atset3:99 */
+  [Q_KEY_CODE_V] = 0x2a, /* qcode:Q_KEY_CODE_V (v) -> linux:47 (KEY_V) -> atset3:42 */
+  [Q_KEY_CODE_VOLUMEDOWN] = 0x9d, /* qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) -> linux:114 (KEY_VOLUMEDOWN) -> atset3:157 */
+  [Q_KEY_CODE_VOLUMEUP] = 0x95, /* qcode:Q_KEY_CODE_VOLUMEUP (volumeup) -> linux:115 (KEY_VOLUMEUP) -> atset3:149 */
+  [Q_KEY_CODE_W] = 0x1d, /* qcode:Q_KEY_CODE_W (w) -> linux:17 (KEY_W) -> atset3:29 */
+  [Q_KEY_CODE_X] = 0x22, /* qcode:Q_KEY_CODE_X (x) -> linux:45 (KEY_X) -> atset3:34 */
+  [Q_KEY_CODE_Y] = 0x35, /* qcode:Q_KEY_CODE_Y (y) -> linux:21 (KEY_Y) -> atset3:53 */
+  [Q_KEY_CODE_YEN] = 0x5d, /* qcode:Q_KEY_CODE_YEN (yen) -> linux:124 (KEY_YEN) -> atset3:93 */
+  [Q_KEY_CODE_Z] = 0x1a, /* qcode:Q_KEY_CODE_Z (z) -> linux:44 (KEY_Z) -> atset3:26 */
+};
+const guint qemu_input_map_qcode_to_atset3_len = sizeof(qemu_input_map_qcode_to_atset3)/sizeof(qemu_input_map_qcode_to_atset3[0]);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 6e543d651f..d90f6a16f7 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -6,6 +6,9 @@
 #include "standard-headers/linux/input.h"
 
 #include "ui/input-keymap-linux-to-qcode.c"
+#include "ui/input-keymap-qcode-to-atset1.c"
+#include "ui/input-keymap-qcode-to-atset2.c"
+#include "ui/input-keymap-qcode-to-atset3.c"
 #include "ui/input-keymap-qcode-to-linux.c"
 #include "ui/input-keymap-qcode-to-qnum.c"
 #include "ui/input-keymap-qnum-to-qcode.c"
-- 
2.13.5
