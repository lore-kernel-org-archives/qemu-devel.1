Received: from eggs.gnu.org ([2001:4830:134:3::10]:53609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4013c3533=owen.smith@citrix.com>)
	id 1dkRh0-0002zY-7z
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4013c3533=owen.smith@citrix.com>)
	id 1dkRgw-0007Ac-67
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:11:18 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:20533
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4013c3533=owen.smith@citrix.com>)
	id 1dkRgv-000783-LV
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:11:14 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Wed, 23 Aug 2017 09:11:09 +0000
Message-ID: <119a989bcec34b97827bf655bd10fb2f@AMSPEX02CL02.citrite.net>
References: <1501081831-9587-1-git-send-email-owen.smith@citrix.com>
	<1501081831-9587-2-git-send-email-owen.smith@citrix.com>
	<alpine.DEB.2.10.1708211556570.12143@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1708211556570.12143@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2 v3] xenfb: Use Input Handlers directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony
	Perard <anthony.perard@citrix.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 22 August 2017 00:12
> To: Owen Smith <owen.smith@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org;
> sstabellini@kernel.org; Anthony Perard <anthony.perard@citrix.com>
> Subject: Re: [PATCH 1/2 v3] xenfb: Use Input Handlers directly
>=20
> Anthony,
>=20
> The code looks good. I tested this patch with Linux guests and seems to w=
ork
> OK, can you also confirm?
>=20
> One comment below.
>=20
>=20
> On Wed, 26 Jul 2017, Owen Smith wrote:
> > Avoid the unneccessary calls through the input-legacy.c file by using
> > the qemu_input_handler_*() calls directly. This did require reworking
> > the event and sync handlers and a direct mapping from QEMU's qcodes to
> > linux KEY_* identifiers required by the ring protocol. Removes the
> > scancode2linux mapping, and supporting documention.
> >
> > Signed-off-by: Owen Smith <owen.smith@citrix.com>
> > ---
> >  hw/display/xenfb.c | 401
> > +++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 247 insertions(+), 154 deletions(-)
> >
> > diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c index
> > df8b78f..e412753 100644
> > --- a/hw/display/xenfb.c
> > +++ b/hw/display/xenfb.c
> > @@ -27,6 +27,7 @@
> >  #include "qemu/osdep.h"
> >
> >  #include "hw/hw.h"
> > +#include "ui/input.h"
> >  #include "ui/console.h"
> >  #include "hw/xen/xen_backend.h"
> >
> > @@ -37,9 +38,7 @@
> >
> >  #include "trace.h"
> >
> > -#ifndef BTN_LEFT
> > -#define BTN_LEFT 0x110 /* from <linux/input.h> */ -#endif
> > +#include "standard-headers/linux/input.h"
> >
> >  /*
> > --------------------------------------------------------------------
> > */
> >
> > @@ -51,9 +50,10 @@ struct common {
> >  struct XenInput {
> >      struct common c;
> >      int abs_pointer_wanted; /* Whether guest supports absolute pointer=
 */
> > -    int button_state;       /* Last seen pointer button state */
> > -    int extended;
> > -    QEMUPutMouseEntry *qmouse;
> > +    QemuInputHandlerState *qkbd;
> > +    QemuInputHandlerState *qmou;
> > +    int mouse_axes[INPUT_AXIS__MAX];
> > +    int mouse_wheel;
> >  };
> >
> >  #define UP_QUEUE 8
> > @@ -120,77 +120,125 @@ static void common_unbind(struct common *c)
> >
> >  /*
> > --------------------------------------------------------------------
> > */
> >
> > -#if 0
> > -/*
> > - * These two tables are not needed any more, but left in here
> > - * intentionally as documentation, to show how scancode2linux[]
> > - * was generated.
> > - *
> > - * Tables to map from scancode to Linux input layer keycode.
> > - * Scancodes are hardware-specific.  These maps assumes a
> > - * standard AT or PS/2 keyboard which is what QEMU feeds us.
> > - */
> > -const unsigned char atkbd_set2_keycode[512] =3D {
> > -
> > -     0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41,117,
> > -     0, 56, 42, 93, 29, 16,  2,  0,  0,  0, 44, 31, 30, 17,  3,  0,
> > -     0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
> > -     0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
> > -     0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
> > -     0, 89, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0, 85,
> > -     0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
> > -    82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
> > -
> > -      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> > -    217,100,255,  0, 97,165,  0,  0,156,  0,  0,  0,  0,  0,  0,125,
> > -    173,114,  0,113,  0,  0,  0,126,128,  0,  0,140,  0,  0,  0,127,
> > -    159,  0,115,  0,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
> > -    157,  0,  0,  0,  0,  0,  0,  0,155,  0, 98,  0,  0,163,  0,  0,
> > -    226,  0,  0,  0,  0,  0,  0,  0,  0,255, 96,  0,  0,  0,143,  0,
> > -      0,  0,  0,  0,  0,  0,  0,  0,  0,107,  0,105,102,  0,  0,112,
> > -    110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119,  0,
> > -
> > -};
> > -
> > -const unsigned char atkbd_unxlate_table[128] =3D {
> > -
> > -      0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
> > -     21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
> > -     35, 43, 52, 51, 59, 66, 75, 76, 82, 14, 18, 93, 26, 34, 33, 42,
> > -     50, 49, 58, 65, 73, 74, 89,124, 17, 41, 88,  5,  6,  4, 12,  3,
> > -     11,  2, 10,  1,  9,119,126,108,117,125,123,107,115,116,121,105,
> > -    114,122,112,113,127, 96, 97,120,  7, 15, 23, 31, 39, 47, 55, 63,
> > -     71, 79, 86, 94,  8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 87,111,
> > -     19, 25, 57, 81, 83, 92, 95, 98, 99,100,101,103,104,106,109,110
> > -
> > +static const unsigned int keymap_qcode[Q_KEY_CODE__MAX] =3D {
> > +    [Q_KEY_CODE_ESC]                 =3D KEY_ESC,
> > +    [Q_KEY_CODE_1]                   =3D KEY_1,
> > +    [Q_KEY_CODE_2]                   =3D KEY_2,
> > +    [Q_KEY_CODE_3]                   =3D KEY_3,
> > +    [Q_KEY_CODE_4]                   =3D KEY_4,
> > +    [Q_KEY_CODE_5]                   =3D KEY_5,
> > +    [Q_KEY_CODE_6]                   =3D KEY_6,
> > +    [Q_KEY_CODE_7]                   =3D KEY_7,
> > +    [Q_KEY_CODE_8]                   =3D KEY_8,
> > +    [Q_KEY_CODE_9]                   =3D KEY_9,
> > +    [Q_KEY_CODE_0]                   =3D KEY_0,
> > +    [Q_KEY_CODE_MINUS]               =3D KEY_MINUS,
> > +    [Q_KEY_CODE_EQUAL]               =3D KEY_EQUAL,
> > +    [Q_KEY_CODE_BACKSPACE]           =3D KEY_BACKSPACE,
> > +
> > +    [Q_KEY_CODE_TAB]                 =3D KEY_TAB,
> > +    [Q_KEY_CODE_Q]                   =3D KEY_Q,
> > +    [Q_KEY_CODE_W]                   =3D KEY_W,
> > +    [Q_KEY_CODE_E]                   =3D KEY_E,
> > +    [Q_KEY_CODE_R]                   =3D KEY_R,
> > +    [Q_KEY_CODE_T]                   =3D KEY_T,
> > +    [Q_KEY_CODE_Y]                   =3D KEY_Y,
> > +    [Q_KEY_CODE_U]                   =3D KEY_U,
> > +    [Q_KEY_CODE_I]                   =3D KEY_I,
> > +    [Q_KEY_CODE_O]                   =3D KEY_O,
> > +    [Q_KEY_CODE_P]                   =3D KEY_P,
> > +    [Q_KEY_CODE_BRACKET_LEFT]        =3D KEY_LEFTBRACE,
> > +    [Q_KEY_CODE_BRACKET_RIGHT]       =3D KEY_RIGHTBRACE,
> > +    [Q_KEY_CODE_RET]                 =3D KEY_ENTER,
> > +
> > +    [Q_KEY_CODE_CTRL]                =3D KEY_LEFTCTRL,
> > +    [Q_KEY_CODE_A]                   =3D KEY_A,
> > +    [Q_KEY_CODE_S]                   =3D KEY_S,
> > +    [Q_KEY_CODE_D]                   =3D KEY_D,
> > +    [Q_KEY_CODE_F]                   =3D KEY_F,
> > +    [Q_KEY_CODE_G]                   =3D KEY_G,
> > +    [Q_KEY_CODE_H]                   =3D KEY_H,
> > +    [Q_KEY_CODE_J]                   =3D KEY_J,
> > +    [Q_KEY_CODE_K]                   =3D KEY_K,
> > +    [Q_KEY_CODE_L]                   =3D KEY_L,
> > +    [Q_KEY_CODE_SEMICOLON]           =3D KEY_SEMICOLON,
> > +    [Q_KEY_CODE_APOSTROPHE]          =3D KEY_APOSTROPHE,
> > +    [Q_KEY_CODE_GRAVE_ACCENT]        =3D KEY_GRAVE,
> > +
> > +    [Q_KEY_CODE_SHIFT]               =3D KEY_LEFTSHIFT,
> > +    [Q_KEY_CODE_BACKSLASH]           =3D KEY_BACKSLASH,
> > +    [Q_KEY_CODE_LESS]                =3D KEY_102ND,
> > +    [Q_KEY_CODE_Z]                   =3D KEY_Z,
> > +    [Q_KEY_CODE_X]                   =3D KEY_X,
> > +    [Q_KEY_CODE_C]                   =3D KEY_C,
> > +    [Q_KEY_CODE_V]                   =3D KEY_V,
> > +    [Q_KEY_CODE_B]                   =3D KEY_B,
> > +    [Q_KEY_CODE_N]                   =3D KEY_N,
> > +    [Q_KEY_CODE_M]                   =3D KEY_M,
> > +    [Q_KEY_CODE_COMMA]               =3D KEY_COMMA,
> > +    [Q_KEY_CODE_DOT]                 =3D KEY_DOT,
> > +    [Q_KEY_CODE_SLASH]               =3D KEY_SLASH,
> > +    [Q_KEY_CODE_SHIFT_R]             =3D KEY_RIGHTSHIFT,
> > +
> > +    [Q_KEY_CODE_ALT]                 =3D KEY_LEFTALT,
> > +    [Q_KEY_CODE_SPC]                 =3D KEY_SPACE,
> > +    [Q_KEY_CODE_CAPS_LOCK]           =3D KEY_CAPSLOCK,
> > +
> > +    [Q_KEY_CODE_F1]                  =3D KEY_F1,
> > +    [Q_KEY_CODE_F2]                  =3D KEY_F2,
> > +    [Q_KEY_CODE_F3]                  =3D KEY_F3,
> > +    [Q_KEY_CODE_F4]                  =3D KEY_F4,
> > +    [Q_KEY_CODE_F5]                  =3D KEY_F5,
> > +    [Q_KEY_CODE_F6]                  =3D KEY_F6,
> > +    [Q_KEY_CODE_F7]                  =3D KEY_F7,
> > +    [Q_KEY_CODE_F8]                  =3D KEY_F8,
> > +    [Q_KEY_CODE_F9]                  =3D KEY_F9,
> > +    [Q_KEY_CODE_F10]                 =3D KEY_F10,
> > +    [Q_KEY_CODE_NUM_LOCK]            =3D KEY_NUMLOCK,
> > +    [Q_KEY_CODE_SCROLL_LOCK]         =3D KEY_SCROLLLOCK,
> > +
> > +    [Q_KEY_CODE_KP_0]                =3D KEY_KP0,
> > +    [Q_KEY_CODE_KP_1]                =3D KEY_KP1,
> > +    [Q_KEY_CODE_KP_2]                =3D KEY_KP2,
> > +    [Q_KEY_CODE_KP_3]                =3D KEY_KP3,
> > +    [Q_KEY_CODE_KP_4]                =3D KEY_KP4,
> > +    [Q_KEY_CODE_KP_5]                =3D KEY_KP5,
> > +    [Q_KEY_CODE_KP_6]                =3D KEY_KP6,
> > +    [Q_KEY_CODE_KP_7]                =3D KEY_KP7,
> > +    [Q_KEY_CODE_KP_8]                =3D KEY_KP8,
> > +    [Q_KEY_CODE_KP_9]                =3D KEY_KP9,
> > +    [Q_KEY_CODE_KP_SUBTRACT]         =3D KEY_KPMINUS,
> > +    [Q_KEY_CODE_KP_ADD]              =3D KEY_KPPLUS,
> > +    [Q_KEY_CODE_KP_DECIMAL]          =3D KEY_KPDOT,
> > +    [Q_KEY_CODE_KP_ENTER]            =3D KEY_KPENTER,
> > +    [Q_KEY_CODE_KP_DIVIDE]           =3D KEY_KPSLASH,
> > +    [Q_KEY_CODE_KP_MULTIPLY]         =3D KEY_KPASTERISK,
> > +
> > +    [Q_KEY_CODE_F11]                 =3D KEY_F11,
> > +    [Q_KEY_CODE_F12]                 =3D KEY_F12,
> > +
> > +    [Q_KEY_CODE_CTRL_R]              =3D KEY_RIGHTCTRL,
> > +    [Q_KEY_CODE_SYSRQ]               =3D KEY_SYSRQ,
> > +    [Q_KEY_CODE_PRINT]               =3D KEY_SYSRQ,
>=20
> I take that KEY_PRINT is not supported by the protocol?
>=20

KEY_PRINT should be supported - I think I made a copy/paste error here, as=
=20
it's supposed to be the reverse of the mapping done by qemu_input_linux_to_=
qcode()

>=20
> > +    [Q_KEY_CODE_PAUSE]               =3D KEY_PAUSE,
> > +    [Q_KEY_CODE_ALT_R]               =3D KEY_RIGHTALT,
> > +
> > +    [Q_KEY_CODE_HOME]                =3D KEY_HOME,
> > +    [Q_KEY_CODE_UP]                  =3D KEY_UP,
> > +    [Q_KEY_CODE_PGUP]                =3D KEY_PAGEUP,
> > +    [Q_KEY_CODE_LEFT]                =3D KEY_LEFT,
> > +    [Q_KEY_CODE_RIGHT]               =3D KEY_RIGHT,
> > +    [Q_KEY_CODE_END]                 =3D KEY_END,
> > +    [Q_KEY_CODE_DOWN]                =3D KEY_DOWN,
> > +    [Q_KEY_CODE_PGDN]                =3D KEY_PAGEDOWN,
> > +    [Q_KEY_CODE_INSERT]              =3D KEY_INSERT,
> > +    [Q_KEY_CODE_DELETE]              =3D KEY_DELETE,
> > +
> > +    [Q_KEY_CODE_META_L]              =3D KEY_LEFTMETA,
> > +    [Q_KEY_CODE_META_R]              =3D KEY_RIGHTMETA,
> > +    [Q_KEY_CODE_MENU]                =3D KEY_MENU,
> >  };
> > -#endif
> >
> > -/*
> > - * for (i =3D 0; i < 128; i++) {
> > - *     scancode2linux[i] =3D atkbd_set2_keycode[atkbd_unxlate_table[i]=
];
> > - *     scancode2linux[i | 0x80] =3D
> atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
> > - * }
> > - */
> > -static const unsigned char scancode2linux[512] =3D {
> > -      0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
> > -     16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
> > -     32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
> > -     48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
> > -     64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
> > -     80, 81, 82, 83, 99,  0, 86, 87, 88,117,  0,  0, 95,183,184,185,
> > -      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> > -     93,  0,  0, 89,  0,  0, 85, 91, 90, 92,  0, 94,  0,124,121,  0,
> > -
> > -      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> > -    165,  0,  0,  0,  0,  0,  0,  0,  0,163,  0,  0, 96, 97,  0,  0,
> > -    113,140,164,  0,166,  0,  0,  0,  0,  0,255,  0,  0,  0,114,  0,
> > -    115,  0,150,  0,  0, 98,255, 99,100,  0,  0,  0,  0,  0,  0,  0,
> > -      0,  0,  0,  0,  0,119,119,102,103,104,  0,105,112,106,118,107,
> > -    108,109,110,111,  0,  0,  0,  0,  0,  0,  0,125,126,127,116,142,
> > -      0,  0,  0,143,  0,217,156,173,128,159,158,157,155,226,  0,112,
> > -      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> > -};
> >
> >  /* Send an event to the keyboard frontend driver */  static int
> > xenfb_kbd_event(struct XenInput *xenfb, @@ -260,87 +308,123 @@ static
> > int xenfb_send_position(struct XenInput *xenfb,
> >      return xenfb_kbd_event(xenfb, &event);  }
> >
> > -/*
> > - * Send a key event from the client to the guest OS
> > - * QEMU gives us a raw scancode from an AT / PS/2 style keyboard.
> > - * We have to turn this into a Linux Input layer keycode.
> > - *
> > - * Extra complexity from the fact that with extended scancodes
> > - * (like those produced by arrow keys) this method gets called
> > - * twice, but we only want to send a single event. So we have to
> > - * track the '0xe0' scancode state & collapse the extended keys
> > - * as needed.
> > - *
> > - * Wish we could just send scancodes straight to the guest which
> > - * already has code for dealing with this...
> > - */
> > -static void xenfb_key_event(void *opaque, int scancode)
> > +static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
> > +                            InputEvent *evt)
> >  {
> > -    struct XenInput *xenfb =3D opaque;
> > -    int down =3D 1;
> > +    struct XenInput *in =3D (struct XenInput *)dev;
> > +    InputKeyEvent *key =3D evt->u.key.data;
> > +    int qcode =3D qemu_input_key_value_to_qcode(key->key);
> >
> > -    if (scancode =3D=3D 0xe0) {
> > -	xenfb->extended =3D 1;
> > -	return;
> > -    } else if (scancode & 0x80) {
> > -	scancode &=3D 0x7f;
> > -	down =3D 0;
> > +    if (qcode && keymap_qcode[qcode]) {
> > +        xenfb_send_key(in, key->down, keymap_qcode[qcode]);
> >      }
> > -    if (xenfb->extended) {
> > -	scancode |=3D 0x80;
> > -	xenfb->extended =3D 0;
> > +}
> > +
> > +static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
> > +                              InputEvent *evt) {
> > +    struct XenInput *in =3D (struct XenInput *)dev;
> > +    InputBtnEvent *btn;
> > +    InputMoveEvent *move;
> > +
> > +    switch (evt->type) {
> > +    case INPUT_EVENT_KIND_BTN:
> > +        btn =3D evt->u.btn.data;
> > +        switch (btn->button) {
> > +        case INPUT_BUTTON_LEFT:
> > +            xenfb_send_key(in, btn->down, BTN_LEFT);
> > +            break;
> > +        case INPUT_BUTTON_RIGHT:
> > +            xenfb_send_key(in, btn->down, BTN_RIGHT);
> > +            break;
> > +        case INPUT_BUTTON_MIDDLE:
> > +            xenfb_send_key(in, btn->down, BTN_MIDDLE);
> > +            break;
> > +        case INPUT_BUTTON_WHEEL_UP:
> > +            if (btn->down) {
> > +                in->mouse_wheel--;
> > +            }
> > +            break;
> > +        case INPUT_BUTTON_WHEEL_DOWN:
> > +            if (btn->down) {
> > +                in->mouse_wheel++;
> > +            }
> > +            break;
> > +        default:
> > +            break;
> > +        }
> > +        break;
> > +    case INPUT_EVENT_KIND_ABS:
> > +        move =3D evt->u.abs.data;
> > +        in->mouse_axes[move->axis] =3D move->value;
> > +        break;
> > +    case INPUT_EVENT_KIND_REL:
> > +        move =3D evt->u.rel.data;
> > +        in->mouse_axes[move->axis] +=3D move->value;
> > +        break;
> > +    default:
> > +        break;
> >      }
> > -    xenfb_send_key(xenfb, down, scancode2linux[scancode]);
> >  }
> >
> > -/*
> > - * Send a mouse event from the client to the guest OS
> > - *
> > - * The QEMU mouse can be in either relative, or absolute mode.
> > - * Movement is sent separately from button state, which has to
> > - * be encoded as virtual key events. We also don't actually get
> > - * given any button up/down events, so have to track changes in
> > - * the button state.
> > - */
> > -static void xenfb_mouse_event(void *opaque,
> > -			      int dx, int dy, int dz, int button_state)
> > +static void xenfb_mouse_sync(DeviceState *dev)
> >  {
> > -    struct XenInput *xenfb =3D opaque;
> > -    QemuConsole *con =3D qemu_console_lookup_by_index(0);
> > -    DisplaySurface *surface;
> > -    int dw, dh, i;
> > +    struct XenInput *in =3D (struct XenInput *)dev;
> > +    int dx, dy, dz;
> >
> > -    if (!con) {
> > -        xen_pv_printf(&xenfb->c.xendev, 0, "No QEMU console available"=
);
> > -        return;
> > -    }
> > +    dx =3D in->mouse_axes[INPUT_AXIS_X];
> > +    dy =3D in->mouse_axes[INPUT_AXIS_Y];
> > +    dz =3D in->mouse_wheel;
> > +
> > +    trace_xenfb_mouse_event(in, dx, dy, dz, 0,
> > +                            in->abs_pointer_wanted);
> > +
> > +    if (in->abs_pointer_wanted) {
> > +        QemuConsole *con =3D qemu_console_lookup_by_index(0);
> > +        DisplaySurface *surface;
> > +        int dw, dh;
> > +
> > +        if (!con) {
> > +            xen_pv_printf(&in->c.xendev, 0, "No QEMU console available=
");
> > +            return;
> > +        }
> >
> > -    surface =3D qemu_console_surface(con);
> > -    dw =3D surface_width(surface);
> > -    dh =3D surface_height(surface);
> > -
> > -    trace_xenfb_mouse_event(opaque, dx, dy, dz, button_state,
> > -                            xenfb->abs_pointer_wanted);
> > -    if (xenfb->abs_pointer_wanted)
> > -	xenfb_send_position(xenfb,
> > -			    dx * (dw - 1) / 0x7fff,
> > -			    dy * (dh - 1) / 0x7fff,
> > -			    dz);
> > -    else
> > -	xenfb_send_motion(xenfb, dx, dy, dz);
> > -
> > -    for (i =3D 0 ; i < 8 ; i++) {
> > -	int lastDown =3D xenfb->button_state & (1 << i);
> > -	int down =3D button_state & (1 << i);
> > -	if (down =3D=3D lastDown)
> > -	    continue;
> > -
> > -	if (xenfb_send_key(xenfb, down, BTN_LEFT+i) < 0)
> > -	    return;
> > +        surface =3D qemu_console_surface(con);
> > +        dw =3D surface_width(surface);
> > +        dh =3D surface_height(surface);
> > +
> > +        dx =3D dx * (dw - 1) / 0x7fff;
> > +        dy =3D dy * (dh - 1) / 0x7fff;
> > +
> > +        xenfb_send_position(in, dx, dy, dz);
> > +    } else {
> > +        xenfb_send_motion(in, dx, dy, dz);
> > +
> > +        in->mouse_axes[INPUT_AXIS_X] =3D 0;
> > +        in->mouse_axes[INPUT_AXIS_Y] =3D 0;
> >      }
> > -    xenfb->button_state =3D button_state;
> > +
> > +    in->mouse_wheel =3D 0;
> >  }
> >
> > +static QemuInputHandler xenfb_keyboard =3D {
> > +    .name  =3D "Xen PVFB Keyboard",
> > +    .mask  =3D INPUT_EVENT_MASK_KEY,
> > +    .event =3D xenfb_key_event,
> > +};
> > +static QemuInputHandler xenfb_abs_mouse =3D {
> > +    .name  =3D "Xen PVFB Absolute Mouse",
> > +    .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
> > +    .event =3D xenfb_mouse_event,
> > +    .sync  =3D xenfb_mouse_sync
> > +};
> > +static QemuInputHandler xenfb_rel_mouse =3D {
> > +    .name  =3D "Xen PVFB Mouse",
> > +    .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
> > +    .event =3D xenfb_mouse_event,
> > +    .sync  =3D xenfb_mouse_sync,
> > +};
> > +
> >  static int input_init(struct XenDevice *xendev)  {
> >      xenstore_write_be_int(xendev, "feature-abs-pointer", 1); @@
> > -356,7 +440,6 @@ static int input_initialise(struct XenDevice *xendev)
> >      if (rc !=3D 0)
> >  	return rc;
> >
> > -    qemu_add_kbd_event_handler(xenfb_key_event, in);
> >      return 0;
> >  }
> >
> > @@ -369,24 +452,34 @@ static void input_connected(struct XenDevice
> *xendev)
> >          in->abs_pointer_wanted =3D 0;
> >      }
> >
> > -    if (in->qmouse) {
> > -        qemu_remove_mouse_event_handler(in->qmouse);
> > +    if (in->qkbd) {
> > +        qemu_input_handler_unregister(in->qkbd);
> > +    }
> > +    if (in->qmou) {
> > +        qemu_input_handler_unregister(in->qmou);
> >      }
> >      trace_xenfb_input_connected(xendev, in->abs_pointer_wanted);
> > -    in->qmouse =3D
> qemu_add_mouse_event_handler(xenfb_mouse_event, in,
> > -					      in->abs_pointer_wanted,
> > -					      "Xen PVFB Mouse");
> > +
> > +    in->qkbd =3D qemu_input_handler_register((DeviceState *)in,
> &xenfb_keyboard);
> > +    in->qmou =3D qemu_input_handler_register((DeviceState *)in,
> > +        (in->abs_pointer_wanted ? &xenfb_abs_mouse :
> > + &xenfb_rel_mouse));
> > +
> > +    qemu_input_handler_activate(in->qkbd);
> > +    qemu_input_handler_activate(in->qmou);
> >  }
> >
> >  static void input_disconnect(struct XenDevice *xendev)  {
> >      struct XenInput *in =3D container_of(xendev, struct XenInput,
> > c.xendev);
> >
> > -    if (in->qmouse) {
> > -	qemu_remove_mouse_event_handler(in->qmouse);
> > -	in->qmouse =3D NULL;
> > +    if (in->qkbd) {
> > +        qemu_input_handler_unregister(in->qkbd);
> > +        in->qkbd =3D NULL;
> > +    }
> > +    if (in->qmou) {
> > +        qemu_input_handler_unregister(in->qmou);
> > +        in->qmou =3D NULL;
> >      }
> > -    qemu_add_kbd_event_handler(NULL, NULL);
> >      common_unbind(&in->c);
> >  }
