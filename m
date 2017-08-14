Received: from eggs.gnu.org ([2001:4830:134:3::10]:47623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCww-0007ci-UE
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhCwu-0001wa-N4
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhCwu-0001wA-D0
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52FC767BA7
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 10:50:19 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 14 Aug 2017 11:49:52 +0100
Message-Id: <20170814104958.29434-7-berrange@redhat.com>
In-Reply-To: <20170814104958.29434-1-berrange@redhat.com>
References: <20170814104958.29434-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/12] input: convert ps2 device to
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
 hw/input/ps2.c     | 406 +----------------------------------------------------
 include/ui/input.h |   9 ++
 ui/Makefile.objs   |   3 +
 ui/input-keymap.c  |   3 +
 4 files changed, 22 insertions(+), 399 deletions(-)

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
index 11915a9bb4..b92d49ccc8 100644
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
2.13.3
