Received: from eggs.gnu.org ([2001:4830:134:3::10]:58239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePABz-0005Uk-6O
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePABv-0000q9-RH
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:47:35 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ePABv-0000po-MU
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:47:31 -0500
Received: by mail-it0-x243.google.com with SMTP id d16so4377967itj.1
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 08:47:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171212142500.3909-3-berrange@redhat.com>
Date: Wed, 13 Dec 2017 11:47:29 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <887F9CCC-DD15-4D46-B4D1-C3EB225481B5@gmail.com>
References: <20171212142500.3909-1-berrange@redhat.com>
	<20171212142500.3909-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] ui: convert cocoa frontend to
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


> On Dec 12, 2017, at 9:25 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> Replace the mac_to_qkeycode_map table with automatically
> generated table.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> Makefile           |   1 +
> include/ui/input.h |   3 ++
> ui/cocoa.m         | 129 =
+----------------------------------------------------
> ui/input-keymap.c  |   1 +
> 4 files changed, 7 insertions(+), 127 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 6e8cbe5d6f..10d8e5b8a3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -227,6 +227,7 @@ KEYCODEMAP_CSV =3D =
$(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
>=20
> KEYCODEMAP_FILES =3D \
> 		 ui/input-keymap-linux-to-qcode.c \
> +		 ui/input-keymap-osx-to-qcode.c \
> 		 ui/input-keymap-qcode-to-adb.c \
> 		 ui/input-keymap-qcode-to-qnum.c \
> 		 ui/input-keymap-qnum-to-qcode.c \
> diff --git a/include/ui/input.h b/include/ui/input.h
> index 25aabc9986..c2087e7d48 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -71,6 +71,9 @@ void qemu_remove_mouse_mode_change_notifier(Notifier =
*notify);
> extern const guint qemu_input_map_linux_to_qcode_len;
> extern const guint16 qemu_input_map_linux_to_qcode[];
>=20
> +extern const guint qemu_input_map_osx_to_qcode_len;
> +extern const guint16 qemu_input_map_osx_to_qcode[];
> +
> extern const guint qemu_input_map_qcode_to_adb_len;
> extern const guint16 qemu_input_map_qcode_to_adb[];
> extern const guint qemu_input_map_qcode_to_qnum_len;
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 330ccebf90..57dfee2db5 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -106,139 +106,14 @@ bool stretch_video;
> NSTextField *pauseLabel;
> NSArray * supportedImageFileTypes;
>=20
> -// Mac to QKeyCode conversion
> -const int mac_to_qkeycode_map[] =3D {
> -    [kVK_ANSI_A] =3D Q_KEY_CODE_A,
> -    [kVK_ANSI_B] =3D Q_KEY_CODE_B,
> -    [kVK_ANSI_C] =3D Q_KEY_CODE_C,
> -    [kVK_ANSI_D] =3D Q_KEY_CODE_D,
> -    [kVK_ANSI_E] =3D Q_KEY_CODE_E,
> -    [kVK_ANSI_F] =3D Q_KEY_CODE_F,
> -    [kVK_ANSI_G] =3D Q_KEY_CODE_G,
> -    [kVK_ANSI_H] =3D Q_KEY_CODE_H,
> -    [kVK_ANSI_I] =3D Q_KEY_CODE_I,
> -    [kVK_ANSI_J] =3D Q_KEY_CODE_J,
> -    [kVK_ANSI_K] =3D Q_KEY_CODE_K,
> -    [kVK_ANSI_L] =3D Q_KEY_CODE_L,
> -    [kVK_ANSI_M] =3D Q_KEY_CODE_M,
> -    [kVK_ANSI_N] =3D Q_KEY_CODE_N,
> -    [kVK_ANSI_O] =3D Q_KEY_CODE_O,
> -    [kVK_ANSI_P] =3D Q_KEY_CODE_P,
> -    [kVK_ANSI_Q] =3D Q_KEY_CODE_Q,
> -    [kVK_ANSI_R] =3D Q_KEY_CODE_R,
> -    [kVK_ANSI_S] =3D Q_KEY_CODE_S,
> -    [kVK_ANSI_T] =3D Q_KEY_CODE_T,
> -    [kVK_ANSI_U] =3D Q_KEY_CODE_U,
> -    [kVK_ANSI_V] =3D Q_KEY_CODE_V,
> -    [kVK_ANSI_W] =3D Q_KEY_CODE_W,
> -    [kVK_ANSI_X] =3D Q_KEY_CODE_X,
> -    [kVK_ANSI_Y] =3D Q_KEY_CODE_Y,
> -    [kVK_ANSI_Z] =3D Q_KEY_CODE_Z,
> -
> -    [kVK_ANSI_0] =3D Q_KEY_CODE_0,
> -    [kVK_ANSI_1] =3D Q_KEY_CODE_1,
> -    [kVK_ANSI_2] =3D Q_KEY_CODE_2,
> -    [kVK_ANSI_3] =3D Q_KEY_CODE_3,
> -    [kVK_ANSI_4] =3D Q_KEY_CODE_4,
> -    [kVK_ANSI_5] =3D Q_KEY_CODE_5,
> -    [kVK_ANSI_6] =3D Q_KEY_CODE_6,
> -    [kVK_ANSI_7] =3D Q_KEY_CODE_7,
> -    [kVK_ANSI_8] =3D Q_KEY_CODE_8,
> -    [kVK_ANSI_9] =3D Q_KEY_CODE_9,
> -
> -    [kVK_ANSI_Grave] =3D Q_KEY_CODE_GRAVE_ACCENT,
> -    [kVK_ANSI_Minus] =3D Q_KEY_CODE_MINUS,
> -    [kVK_ANSI_Equal] =3D Q_KEY_CODE_EQUAL,
> -    [kVK_Delete] =3D Q_KEY_CODE_BACKSPACE,
> -    [kVK_CapsLock] =3D Q_KEY_CODE_CAPS_LOCK,
> -    [kVK_Tab] =3D Q_KEY_CODE_TAB,
> -    [kVK_Return] =3D Q_KEY_CODE_RET,
> -    [kVK_ANSI_LeftBracket] =3D Q_KEY_CODE_BRACKET_LEFT,
> -    [kVK_ANSI_RightBracket] =3D Q_KEY_CODE_BRACKET_RIGHT,
> -    [kVK_ANSI_Backslash] =3D Q_KEY_CODE_BACKSLASH,
> -    [kVK_ANSI_Semicolon] =3D Q_KEY_CODE_SEMICOLON,
> -    [kVK_ANSI_Quote] =3D Q_KEY_CODE_APOSTROPHE,
> -    [kVK_ANSI_Comma] =3D Q_KEY_CODE_COMMA,
> -    [kVK_ANSI_Period] =3D Q_KEY_CODE_DOT,
> -    [kVK_ANSI_Slash] =3D Q_KEY_CODE_SLASH,
> -    [kVK_Shift] =3D Q_KEY_CODE_SHIFT,
> -    [kVK_RightShift] =3D Q_KEY_CODE_SHIFT_R,
> -    [kVK_Control] =3D Q_KEY_CODE_CTRL,
> -    [kVK_RightControl] =3D Q_KEY_CODE_CTRL_R,
> -    [kVK_Option] =3D Q_KEY_CODE_ALT,
> -    [kVK_RightOption] =3D Q_KEY_CODE_ALT_R,
> -    [kVK_Command] =3D Q_KEY_CODE_META_L,
> -    [0x36] =3D Q_KEY_CODE_META_R, /* There is no kVK_RightCommand */
> -    [kVK_Space] =3D Q_KEY_CODE_SPC,
> -
> -    [kVK_ANSI_Keypad0] =3D Q_KEY_CODE_KP_0,
> -    [kVK_ANSI_Keypad1] =3D Q_KEY_CODE_KP_1,
> -    [kVK_ANSI_Keypad2] =3D Q_KEY_CODE_KP_2,
> -    [kVK_ANSI_Keypad3] =3D Q_KEY_CODE_KP_3,
> -    [kVK_ANSI_Keypad4] =3D Q_KEY_CODE_KP_4,
> -    [kVK_ANSI_Keypad5] =3D Q_KEY_CODE_KP_5,
> -    [kVK_ANSI_Keypad6] =3D Q_KEY_CODE_KP_6,
> -    [kVK_ANSI_Keypad7] =3D Q_KEY_CODE_KP_7,
> -    [kVK_ANSI_Keypad8] =3D Q_KEY_CODE_KP_8,
> -    [kVK_ANSI_Keypad9] =3D Q_KEY_CODE_KP_9,
> -    [kVK_ANSI_KeypadDecimal] =3D Q_KEY_CODE_KP_DECIMAL,
> -    [kVK_ANSI_KeypadEnter] =3D Q_KEY_CODE_KP_ENTER,
> -    [kVK_ANSI_KeypadPlus] =3D Q_KEY_CODE_KP_ADD,
> -    [kVK_ANSI_KeypadMinus] =3D Q_KEY_CODE_KP_SUBTRACT,
> -    [kVK_ANSI_KeypadMultiply] =3D Q_KEY_CODE_KP_MULTIPLY,
> -    [kVK_ANSI_KeypadDivide] =3D Q_KEY_CODE_KP_DIVIDE,
> -    [kVK_ANSI_KeypadEquals] =3D Q_KEY_CODE_KP_EQUALS,
> -    [kVK_ANSI_KeypadClear] =3D Q_KEY_CODE_NUM_LOCK,
> -
> -    [kVK_UpArrow] =3D Q_KEY_CODE_UP,
> -    [kVK_DownArrow] =3D Q_KEY_CODE_DOWN,
> -    [kVK_LeftArrow] =3D Q_KEY_CODE_LEFT,
> -    [kVK_RightArrow] =3D Q_KEY_CODE_RIGHT,
> -
> -    [kVK_Help] =3D Q_KEY_CODE_INSERT,
> -    [kVK_Home] =3D Q_KEY_CODE_HOME,
> -    [kVK_PageUp] =3D Q_KEY_CODE_PGUP,
> -    [kVK_PageDown] =3D Q_KEY_CODE_PGDN,
> -    [kVK_End] =3D Q_KEY_CODE_END,
> -    [kVK_ForwardDelete] =3D Q_KEY_CODE_DELETE,
> -
> -    [kVK_Escape] =3D Q_KEY_CODE_ESC,
> -
> -    /* The Power key can't be used directly because the operating =
system uses
> -     * it. This key can be emulated by using it in place of another =
key such as
> -     * F1. Don't forget to disable the real key binding.
> -     */
> -    /* [kVK_F1] =3D Q_KEY_CODE_POWER, */
> -
> -    [kVK_F1] =3D Q_KEY_CODE_F1,
> -    [kVK_F2] =3D Q_KEY_CODE_F2,
> -    [kVK_F3] =3D Q_KEY_CODE_F3,
> -    [kVK_F4] =3D Q_KEY_CODE_F4,
> -    [kVK_F5] =3D Q_KEY_CODE_F5,
> -    [kVK_F6] =3D Q_KEY_CODE_F6,
> -    [kVK_F7] =3D Q_KEY_CODE_F7,
> -    [kVK_F8] =3D Q_KEY_CODE_F8,
> -    [kVK_F9] =3D Q_KEY_CODE_F9,
> -    [kVK_F10] =3D Q_KEY_CODE_F10,
> -    [kVK_F11] =3D Q_KEY_CODE_F11,
> -    [kVK_F12] =3D Q_KEY_CODE_F12,
> -    [kVK_F13] =3D Q_KEY_CODE_PRINT,
> -    [kVK_F14] =3D Q_KEY_CODE_SCROLL_LOCK,
> -    [kVK_F15] =3D Q_KEY_CODE_PAUSE,
> -
> -    /*
> -     * The eject and volume keys can't be used here because they are =
handled at
> -     * a lower level than what an Application can see.
> -     */
> -};
>=20
> static int cocoa_keycode_to_qemu(int keycode)
> {
> -    if (ARRAY_SIZE(mac_to_qkeycode_map) <=3D keycode) {
> +    if (keycode >=3D qemu_input_map_osx_to_qcode_len) {
>         fprintf(stderr, "(cocoa) warning unknown keycode 0x%x\n", =
keycode);
>         return 0;
>     }
> -    return mac_to_qkeycode_map[keycode];
> +    return qemu_input_map_osx_to_qcode[keycode];
> }
>=20
> /* Displays an alert dialog box with the specified message */
> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index c373e41948..caf5c76f50 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -6,6 +6,7 @@
> #include "standard-headers/linux/input.h"
>=20
> #include "ui/input-keymap-linux-to-qcode.c"
> +#include "ui/input-keymap-osx-to-qcode.c"
> #include "ui/input-keymap-qcode-to-adb.c"
> #include "ui/input-keymap-qcode-to-qnum.c"
> #include "ui/input-keymap-qnum-to-qcode.c"
> --=20
> 2.14.3
>=20

Reviewed-By: John Arbuckle <programmingkidx@gmail.com>=
