Received: from eggs.gnu.org ([2001:4830:134:3::10]:58156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePABP-0004r3-8w
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePABL-0000ZT-UJ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:46:59 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:37687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ePABL-0000ZD-Mh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:46:55 -0500
Received: by mail-io0-x241.google.com with SMTP id d16so3501307iob.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 08:46:55 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171212142500.3909-2-berrange@redhat.com>
Date: Wed, 13 Dec 2017 11:46:52 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <F15FBF55-D3A6-413A-A054-4E4385A782E8@gmail.com>
References: <20171212142500.3909-1-berrange@redhat.com>
	<20171212142500.3909-2-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] hw: convert the adb device to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Peter Maydell ]" <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>


> On Dec 12, 2017, at 9:24 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> Replace the qcode_to_adb_keycode table with automatically
> generated tables.
>=20
> Missing entries in qcode_to_adb_keycode now fixed:
>=20
> - Q_KEY_CODE_KP_COMMA -> 0x47
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> Makefile                    |   1 +
> hw/input/adb.c              | 124 =
+-------------------------------------
> include/hw/input/adb-keys.h | 141 =
--------------------------------------------
> include/ui/input.h          |   2 +
> ui/input-keymap.c           |   1 +
> 5 files changed, 6 insertions(+), 263 deletions(-)
> delete mode 100644 include/hw/input/adb-keys.h
>=20
> diff --git a/Makefile b/Makefile
> index ab0354c153..6e8cbe5d6f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -227,6 +227,7 @@ KEYCODEMAP_CSV =3D =
$(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
>=20
> KEYCODEMAP_FILES =3D \
> 		 ui/input-keymap-linux-to-qcode.c \
> +		 ui/input-keymap-qcode-to-adb.c \
> 		 ui/input-keymap-qcode-to-qnum.c \
> 		 ui/input-keymap-qnum-to-qcode.c \
> 		 $(NULL)
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index fcca3a8eb9..1fe5d298a3 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -25,7 +25,6 @@
> #include "hw/hw.h"
> #include "hw/input/adb.h"
> #include "ui/console.h"
> -#include "include/hw/input/adb-keys.h"
> #include "ui/input.h"
> #include "sysemu/sysemu.h"
>=20
> @@ -193,125 +192,6 @@ typedef struct ADBKeyboardClass {
>     DeviceRealize parent_realize;
> } ADBKeyboardClass;
>=20
> -int qcode_to_adb_keycode[] =3D {
> -     /* Make sure future additions are automatically set to NO_KEY */
> -    [0 ... 0xff]               =3D NO_KEY,
> -
> -    [Q_KEY_CODE_SHIFT]         =3D ADB_KEY_LEFT_SHIFT,
> -    [Q_KEY_CODE_SHIFT_R]       =3D ADB_KEY_RIGHT_SHIFT,
> -    [Q_KEY_CODE_ALT]           =3D ADB_KEY_LEFT_OPTION,
> -    [Q_KEY_CODE_ALT_R]         =3D ADB_KEY_RIGHT_OPTION,
> -    [Q_KEY_CODE_CTRL]          =3D ADB_KEY_LEFT_CONTROL,
> -    [Q_KEY_CODE_CTRL_R]        =3D ADB_KEY_RIGHT_CONTROL,
> -    [Q_KEY_CODE_META_L]        =3D ADB_KEY_COMMAND,
> -    [Q_KEY_CODE_META_R]        =3D ADB_KEY_COMMAND,
> -    [Q_KEY_CODE_SPC]           =3D ADB_KEY_SPACEBAR,
> -
> -    [Q_KEY_CODE_ESC]           =3D ADB_KEY_ESC,
> -    [Q_KEY_CODE_1]             =3D ADB_KEY_1,
> -    [Q_KEY_CODE_2]             =3D ADB_KEY_2,
> -    [Q_KEY_CODE_3]             =3D ADB_KEY_3,
> -    [Q_KEY_CODE_4]             =3D ADB_KEY_4,
> -    [Q_KEY_CODE_5]             =3D ADB_KEY_5,
> -    [Q_KEY_CODE_6]             =3D ADB_KEY_6,
> -    [Q_KEY_CODE_7]             =3D ADB_KEY_7,
> -    [Q_KEY_CODE_8]             =3D ADB_KEY_8,
> -    [Q_KEY_CODE_9]             =3D ADB_KEY_9,
> -    [Q_KEY_CODE_0]             =3D ADB_KEY_0,
> -    [Q_KEY_CODE_MINUS]         =3D ADB_KEY_MINUS,
> -    [Q_KEY_CODE_EQUAL]         =3D ADB_KEY_EQUAL,
> -    [Q_KEY_CODE_BACKSPACE]     =3D ADB_KEY_DELETE,
> -    [Q_KEY_CODE_TAB]           =3D ADB_KEY_TAB,
> -    [Q_KEY_CODE_Q]             =3D ADB_KEY_Q,
> -    [Q_KEY_CODE_W]             =3D ADB_KEY_W,
> -    [Q_KEY_CODE_E]             =3D ADB_KEY_E,
> -    [Q_KEY_CODE_R]             =3D ADB_KEY_R,
> -    [Q_KEY_CODE_T]             =3D ADB_KEY_T,
> -    [Q_KEY_CODE_Y]             =3D ADB_KEY_Y,
> -    [Q_KEY_CODE_U]             =3D ADB_KEY_U,
> -    [Q_KEY_CODE_I]             =3D ADB_KEY_I,
> -    [Q_KEY_CODE_O]             =3D ADB_KEY_O,
> -    [Q_KEY_CODE_P]             =3D ADB_KEY_P,
> -    [Q_KEY_CODE_BRACKET_LEFT]  =3D ADB_KEY_LEFT_BRACKET,
> -    [Q_KEY_CODE_BRACKET_RIGHT] =3D ADB_KEY_RIGHT_BRACKET,
> -    [Q_KEY_CODE_RET]           =3D ADB_KEY_RETURN,
> -    [Q_KEY_CODE_A]             =3D ADB_KEY_A,
> -    [Q_KEY_CODE_S]             =3D ADB_KEY_S,
> -    [Q_KEY_CODE_D]             =3D ADB_KEY_D,
> -    [Q_KEY_CODE_F]             =3D ADB_KEY_F,
> -    [Q_KEY_CODE_G]             =3D ADB_KEY_G,
> -    [Q_KEY_CODE_H]             =3D ADB_KEY_H,
> -    [Q_KEY_CODE_J]             =3D ADB_KEY_J,
> -    [Q_KEY_CODE_K]             =3D ADB_KEY_K,
> -    [Q_KEY_CODE_L]             =3D ADB_KEY_L,
> -    [Q_KEY_CODE_SEMICOLON]     =3D ADB_KEY_SEMICOLON,
> -    [Q_KEY_CODE_APOSTROPHE]    =3D ADB_KEY_APOSTROPHE,
> -    [Q_KEY_CODE_GRAVE_ACCENT]  =3D ADB_KEY_GRAVE_ACCENT,
> -    [Q_KEY_CODE_BACKSLASH]     =3D ADB_KEY_BACKSLASH,
> -    [Q_KEY_CODE_Z]             =3D ADB_KEY_Z,
> -    [Q_KEY_CODE_X]             =3D ADB_KEY_X,
> -    [Q_KEY_CODE_C]             =3D ADB_KEY_C,
> -    [Q_KEY_CODE_V]             =3D ADB_KEY_V,
> -    [Q_KEY_CODE_B]             =3D ADB_KEY_B,
> -    [Q_KEY_CODE_N]             =3D ADB_KEY_N,
> -    [Q_KEY_CODE_M]             =3D ADB_KEY_M,
> -    [Q_KEY_CODE_COMMA]         =3D ADB_KEY_COMMA,
> -    [Q_KEY_CODE_DOT]           =3D ADB_KEY_PERIOD,
> -    [Q_KEY_CODE_SLASH]         =3D ADB_KEY_FORWARD_SLASH,
> -    [Q_KEY_CODE_ASTERISK]      =3D ADB_KEY_KP_MULTIPLY,
> -    [Q_KEY_CODE_CAPS_LOCK]     =3D ADB_KEY_CAPS_LOCK,
> -
> -    [Q_KEY_CODE_F1]            =3D ADB_KEY_F1,
> -    [Q_KEY_CODE_F2]            =3D ADB_KEY_F2,
> -    [Q_KEY_CODE_F3]            =3D ADB_KEY_F3,
> -    [Q_KEY_CODE_F4]            =3D ADB_KEY_F4,
> -    [Q_KEY_CODE_F5]            =3D ADB_KEY_F5,
> -    [Q_KEY_CODE_F6]            =3D ADB_KEY_F6,
> -    [Q_KEY_CODE_F7]            =3D ADB_KEY_F7,
> -    [Q_KEY_CODE_F8]            =3D ADB_KEY_F8,
> -    [Q_KEY_CODE_F9]            =3D ADB_KEY_F9,
> -    [Q_KEY_CODE_F10]           =3D ADB_KEY_F10,
> -    [Q_KEY_CODE_F11]           =3D ADB_KEY_F11,
> -    [Q_KEY_CODE_F12]           =3D ADB_KEY_F12,
> -    [Q_KEY_CODE_PRINT]         =3D ADB_KEY_F13,
> -    [Q_KEY_CODE_SYSRQ]         =3D ADB_KEY_F13,
> -    [Q_KEY_CODE_SCROLL_LOCK]   =3D ADB_KEY_F14,
> -    [Q_KEY_CODE_PAUSE]         =3D ADB_KEY_F15,
> -
> -    [Q_KEY_CODE_NUM_LOCK]      =3D ADB_KEY_KP_CLEAR,
> -    [Q_KEY_CODE_KP_EQUALS]     =3D ADB_KEY_KP_EQUAL,
> -    [Q_KEY_CODE_KP_DIVIDE]     =3D ADB_KEY_KP_DIVIDE,
> -    [Q_KEY_CODE_KP_MULTIPLY]   =3D ADB_KEY_KP_MULTIPLY,
> -    [Q_KEY_CODE_KP_SUBTRACT]   =3D ADB_KEY_KP_SUBTRACT,
> -    [Q_KEY_CODE_KP_ADD]        =3D ADB_KEY_KP_PLUS,
> -    [Q_KEY_CODE_KP_ENTER]      =3D ADB_KEY_KP_ENTER,
> -    [Q_KEY_CODE_KP_DECIMAL]    =3D ADB_KEY_KP_PERIOD,
> -    [Q_KEY_CODE_KP_0]          =3D ADB_KEY_KP_0,
> -    [Q_KEY_CODE_KP_1]          =3D ADB_KEY_KP_1,
> -    [Q_KEY_CODE_KP_2]          =3D ADB_KEY_KP_2,
> -    [Q_KEY_CODE_KP_3]          =3D ADB_KEY_KP_3,
> -    [Q_KEY_CODE_KP_4]          =3D ADB_KEY_KP_4,
> -    [Q_KEY_CODE_KP_5]          =3D ADB_KEY_KP_5,
> -    [Q_KEY_CODE_KP_6]          =3D ADB_KEY_KP_6,
> -    [Q_KEY_CODE_KP_7]          =3D ADB_KEY_KP_7,
> -    [Q_KEY_CODE_KP_8]          =3D ADB_KEY_KP_8,
> -    [Q_KEY_CODE_KP_9]          =3D ADB_KEY_KP_9,
> -
> -    [Q_KEY_CODE_UP]            =3D ADB_KEY_UP,
> -    [Q_KEY_CODE_DOWN]          =3D ADB_KEY_DOWN,
> -    [Q_KEY_CODE_LEFT]          =3D ADB_KEY_LEFT,
> -    [Q_KEY_CODE_RIGHT]         =3D ADB_KEY_RIGHT,
> -
> -    [Q_KEY_CODE_HELP]          =3D ADB_KEY_HELP,
> -    [Q_KEY_CODE_INSERT]        =3D ADB_KEY_HELP,
> -    [Q_KEY_CODE_DELETE]        =3D ADB_KEY_FORWARD_DELETE,
> -    [Q_KEY_CODE_HOME]          =3D ADB_KEY_HOME,
> -    [Q_KEY_CODE_END]           =3D ADB_KEY_END,
> -    [Q_KEY_CODE_PGUP]          =3D ADB_KEY_PAGE_UP,
> -    [Q_KEY_CODE_PGDN]          =3D ADB_KEY_PAGE_DOWN,
> -
> -    [Q_KEY_CODE_POWER]         =3D ADB_KEY_POWER
> -};
>=20
> static void adb_kbd_put_keycode(void *opaque, int keycode)
> {
> @@ -439,11 +319,11 @@ static void adb_keyboard_event(DeviceState *dev, =
QemuConsole *src,
>     int qcode, keycode;
>=20
>     qcode =3D qemu_input_key_value_to_qcode(evt->u.key.data->key);
> -    if (qcode >=3D ARRAY_SIZE(qcode_to_adb_keycode)) {
> +    if (qcode >=3D qemu_input_map_qcode_to_adb_len) {
>         return;
>     }
>     /* FIXME: take handler into account when translating qcode */
> -    keycode =3D qcode_to_adb_keycode[qcode];
> +    keycode =3D qemu_input_map_qcode_to_adb[qcode];
>     if (keycode =3D=3D NO_KEY) {  /* We don't want to send this to the =
guest */
>         ADB_DPRINTF("Ignoring NO_KEY\n");
>         return;
> diff --git a/include/hw/input/adb-keys.h b/include/hw/input/adb-keys.h
> deleted file mode 100644
> index 525fba8a61..0000000000
> --- a/include/hw/input/adb-keys.h
> +++ /dev/null
> @@ -1,141 +0,0 @@
> -/*
> - * QEMU System Emulator
> - *
> - * Copyright (c) 2016 John Arbuckle
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> - * See the COPYING file in the top-level directory.
> - */
> -
> -/*
> - *  adb-keys.h
> - *
> - *  Provides an enum of all the Macintosh keycodes.
> - *  Additional information: =
http://www.archive.org/stream/apple-guide-macintosh-family-hardware/Apple_=
Guide_to_the_Macintosh_Family_Hardware_2e#page/n345/mode/2up
> - *                          page 308
> - */
> -
> -#ifndef ADB_KEYS_H
> -#define ADB_KEYS_H
> -
> -enum {
> -    ADB_KEY_A =3D 0x00,
> -    ADB_KEY_B =3D 0x0b,
> -    ADB_KEY_C =3D 0x08,
> -    ADB_KEY_D =3D 0x02,
> -    ADB_KEY_E =3D 0x0e,
> -    ADB_KEY_F =3D 0x03,
> -    ADB_KEY_G =3D 0x05,
> -    ADB_KEY_H =3D 0x04,
> -    ADB_KEY_I =3D 0x22,
> -    ADB_KEY_J =3D 0x26,
> -    ADB_KEY_K =3D 0x28,
> -    ADB_KEY_L =3D 0x25,
> -    ADB_KEY_M =3D 0x2e,
> -    ADB_KEY_N =3D 0x2d,
> -    ADB_KEY_O =3D 0x1f,
> -    ADB_KEY_P =3D 0x23,
> -    ADB_KEY_Q =3D 0x0c,
> -    ADB_KEY_R =3D 0x0f,
> -    ADB_KEY_S =3D 0x01,
> -    ADB_KEY_T =3D 0x11,
> -    ADB_KEY_U =3D 0x20,
> -    ADB_KEY_V =3D 0x09,
> -    ADB_KEY_W =3D 0x0d,
> -    ADB_KEY_X =3D 0x07,
> -    ADB_KEY_Y =3D 0x10,
> -    ADB_KEY_Z =3D 0x06,
> -
> -    ADB_KEY_0 =3D 0x1d,
> -    ADB_KEY_1 =3D 0x12,
> -    ADB_KEY_2 =3D 0x13,
> -    ADB_KEY_3 =3D 0x14,
> -    ADB_KEY_4 =3D 0x15,
> -    ADB_KEY_5 =3D 0x17,
> -    ADB_KEY_6 =3D 0x16,
> -    ADB_KEY_7 =3D 0x1a,
> -    ADB_KEY_8 =3D 0x1c,
> -    ADB_KEY_9 =3D 0x19,
> -
> -    ADB_KEY_GRAVE_ACCENT =3D 0x32,
> -    ADB_KEY_MINUS =3D 0x1b,
> -    ADB_KEY_EQUAL =3D 0x18,
> -    ADB_KEY_DELETE =3D 0x33,
> -    ADB_KEY_CAPS_LOCK =3D 0x39,
> -    ADB_KEY_TAB =3D 0x30,
> -    ADB_KEY_RETURN =3D 0x24,
> -    ADB_KEY_LEFT_BRACKET =3D 0x21,
> -    ADB_KEY_RIGHT_BRACKET =3D 0x1e,
> -    ADB_KEY_BACKSLASH =3D 0x2a,
> -    ADB_KEY_SEMICOLON =3D 0x29,
> -    ADB_KEY_APOSTROPHE =3D 0x27,
> -    ADB_KEY_COMMA =3D 0x2b,
> -    ADB_KEY_PERIOD =3D 0x2f,
> -    ADB_KEY_FORWARD_SLASH =3D 0x2c,
> -    ADB_KEY_LEFT_SHIFT =3D 0x38,
> -    ADB_KEY_RIGHT_SHIFT =3D 0x7b,
> -    ADB_KEY_SPACEBAR =3D 0x31,
> -    ADB_KEY_LEFT_CONTROL =3D 0x36,
> -    ADB_KEY_RIGHT_CONTROL =3D 0x7d,
> -    ADB_KEY_LEFT_OPTION =3D 0x3a,
> -    ADB_KEY_RIGHT_OPTION =3D 0x7c,
> -    ADB_KEY_COMMAND =3D 0x37,
> -
> -    ADB_KEY_KP_0 =3D 0x52,
> -    ADB_KEY_KP_1 =3D 0x53,
> -    ADB_KEY_KP_2 =3D 0x54,
> -    ADB_KEY_KP_3 =3D 0x55,
> -    ADB_KEY_KP_4 =3D 0x56,
> -    ADB_KEY_KP_5 =3D 0x57,
> -    ADB_KEY_KP_6 =3D 0x58,
> -    ADB_KEY_KP_7 =3D 0x59,
> -    ADB_KEY_KP_8 =3D 0x5b,
> -    ADB_KEY_KP_9 =3D 0x5c,
> -    ADB_KEY_KP_PERIOD =3D 0x41,
> -    ADB_KEY_KP_ENTER =3D 0x4c,
> -    ADB_KEY_KP_PLUS =3D 0x45,
> -    ADB_KEY_KP_SUBTRACT =3D 0x4e,
> -    ADB_KEY_KP_MULTIPLY =3D 0x43,
> -    ADB_KEY_KP_DIVIDE =3D 0x4b,
> -    ADB_KEY_KP_EQUAL =3D 0x51,
> -    ADB_KEY_KP_CLEAR =3D 0x47,
> -
> -    ADB_KEY_UP =3D 0x3e,
> -    ADB_KEY_DOWN =3D 0x3d,
> -    ADB_KEY_LEFT =3D 0x3b,
> -    ADB_KEY_RIGHT =3D 0x3c,
> -
> -    ADB_KEY_HELP =3D 0x72,
> -    ADB_KEY_HOME =3D 0x73,
> -    ADB_KEY_PAGE_UP =3D 0x74,
> -    ADB_KEY_PAGE_DOWN =3D 0x79,
> -    ADB_KEY_END =3D 0x77,
> -    ADB_KEY_FORWARD_DELETE =3D 0x75,
> -
> -    ADB_KEY_ESC =3D 0x35,
> -    ADB_KEY_F1 =3D 0x7a,
> -    ADB_KEY_F2 =3D 0x78,
> -    ADB_KEY_F3 =3D 0x63,
> -    ADB_KEY_F4 =3D 0x76,
> -    ADB_KEY_F5 =3D 0x60,
> -    ADB_KEY_F6 =3D 0x61,
> -    ADB_KEY_F7 =3D 0x62,
> -    ADB_KEY_F8 =3D 0x64,
> -    ADB_KEY_F9 =3D 0x65,
> -    ADB_KEY_F10 =3D 0x6d,
> -    ADB_KEY_F11 =3D 0x67,
> -    ADB_KEY_F12 =3D 0x6f,
> -    ADB_KEY_F13 =3D 0x69,
> -    ADB_KEY_F14 =3D 0x6b,
> -    ADB_KEY_F15 =3D 0x71,
> -
> -    ADB_KEY_VOLUME_UP =3D 0x48,
> -    ADB_KEY_VOLUME_DOWN =3D 0x49,
> -    ADB_KEY_VOLUME_MUTE =3D 0x4a,
> -    ADB_KEY_POWER =3D 0x7f7f
> -};
> -
> -/* Could not find the value for this key. */
> -/* #define ADB_KEY_EJECT */
> -
> -#endif /* ADB_KEYS_H */
> diff --git a/include/ui/input.h b/include/ui/input.h
> index f8cee43f65..25aabc9986 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -71,6 +71,8 @@ void qemu_remove_mouse_mode_change_notifier(Notifier =
*notify);
> extern const guint qemu_input_map_linux_to_qcode_len;
> extern const guint16 qemu_input_map_linux_to_qcode[];
>=20
> +extern const guint qemu_input_map_qcode_to_adb_len;
> +extern const guint16 qemu_input_map_qcode_to_adb[];
> extern const guint qemu_input_map_qcode_to_qnum_len;
> extern const guint16 qemu_input_map_qcode_to_qnum[];
>=20
> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index 3a19a169f5..c373e41948 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -6,6 +6,7 @@
> #include "standard-headers/linux/input.h"
>=20
> #include "ui/input-keymap-linux-to-qcode.c"
> +#include "ui/input-keymap-qcode-to-adb.c"
> #include "ui/input-keymap-qcode-to-qnum.c"
> #include "ui/input-keymap-qnum-to-qcode.c"
>=20
> --=20
> 2.14.3
>=20

Tested using Mac OS 9.2 and Mac OS 10.4.11. ADB keyboard functions =
correctly. The only problem I noticed is with the caps lock key on Mac =
OS 9.2. It doesn't appear to work. This problem is also present in QEMU =
2.10.1 so I wouldn't worry about it.=20

Reviewed-By: John Arbuckle <programmingkidx@gmail.com>
