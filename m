Received: from eggs.gnu.org ([2001:4830:134:3::10]:51756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eReF0-0002M2-4n
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eReEv-000271-7r
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:16:58 -0500
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:45036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eReEu-00025w-VA
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:16:53 -0500
Received: by mail-it0-x230.google.com with SMTP id b5so6706531itc.3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 05:16:52 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171220121406.24056-1-laurent@vivier.eu>
References: <20171220121406.24056-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 20 Dec 2017 10:16:50 -0300
Message-ID: <CAAdtpL5QmaXbGN_q5nMiUuoJRtNf4QF2yz1xWUK0-b6ZRo+dng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Split adb.c into adb.c,
 adb-mouse.c and adb-kbd.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Dec 20, 2017 at 9:14 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> It makes the code clearer to separate the bus implementation
> from the devices one.
>
> Replace ADB_DPRINTF() with trace events (and adding new ones in adb-kbd.c=
).
> Some minor changes to make checkpatch.pl happy.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> v2: move internal declarations to adb-internal.h
>     replace ADB_DPRINTF() with trace event.
>
>  hw/input/Makefile.objs  |   2 +-
>  hw/input/adb-internal.h |  49 ++++
>  hw/input/adb-kbd.c      | 400 +++++++++++++++++++++++++++++++
>  hw/input/adb-mouse.c    | 254 ++++++++++++++++++++
>  hw/input/adb.c          | 622 +-----------------------------------------=
------
>  hw/input/trace-events   |   8 +
>  6 files changed, 714 insertions(+), 621 deletions(-)
>  create mode 100644 hw/input/adb-internal.h
>  create mode 100644 hw/input/adb-kbd.c
>  create mode 100644 hw/input/adb-mouse.c
>
> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
> index 636f794b6b..77e53e6883 100644
> --- a/hw/input/Makefile.objs
> +++ b/hw/input/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-$(CONFIG_ADB) +=3D adb.o
> +common-obj-$(CONFIG_ADB) +=3D adb.o adb-mouse.o adb-kbd.o
>  common-obj-y +=3D hid.o
>  common-obj-$(CONFIG_LM832X) +=3D lm832x.o
>  common-obj-$(CONFIG_PCKBD) +=3D pckbd.o
> diff --git a/hw/input/adb-internal.h b/hw/input/adb-internal.h
> new file mode 100644
> index 0000000000..2a779b8a0a
> --- /dev/null
> +++ b/hw/input/adb-internal.h

thanks :)

> @@ -0,0 +1,49 @@
> +/*
> + * QEMU ADB support
> + *
> + * Copyright (c) 2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +/* ADB commands */
> +
> +#define ADB_BUSRESET            0x00
> +#define ADB_FLUSH               0x01
> +#define ADB_WRITEREG            0x08
> +#define ADB_READREG             0x0c
> +
> +/* ADB device commands */
> +
> +#define ADB_CMD_SELF_TEST               0xff
> +#define ADB_CMD_CHANGE_ID               0xfe
> +#define ADB_CMD_CHANGE_ID_AND_ACT       0xfd
> +#define ADB_CMD_CHANGE_ID_AND_ENABLE    0x00
> +
> +/* ADB default device IDs (upper 4 bits of ADB command byte) */
> +
> +#define ADB_DEVID_DONGLE      1
> +#define ADB_DEVID_KEYBOARD    2
> +#define ADB_DEVID_MOUSE       3
> +#define ADB_DEVID_TABLET      4
> +#define ADB_DEVID_MODEM       5
> +#define ADB_DEVID_MISC        7
> +
> +extern const VMStateDescription vmstate_adb_device;
> +
> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
> new file mode 100644
> index 0000000000..354f56e41e
> --- /dev/null
> +++ b/hw/input/adb-kbd.c
> @@ -0,0 +1,400 @@
> +/*
> + * QEMU ADB keyboard support
> + *
> + * Copyright (c) 2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "hw/input/adb.h"
> +#include "ui/input.h"
> +#include "hw/input/adb-keys.h"
> +#include "sysemu/sysemu.h"
> +#include "adb-internal.h"
> +#include "trace.h"
> +
> +#define ADB_KEYBOARD(obj) OBJECT_CHECK(KBDState, (obj), TYPE_ADB_KEYBOAR=
D)
> +
> +typedef struct KBDState {
> +    /*< private >*/
> +    ADBDevice parent_obj;
> +    /*< public >*/
> +
> +    uint8_t data[128];
> +    int rptr, wptr, count;
> +} KBDState;
> +
> +#define ADB_KEYBOARD_CLASS(class) \
> +    OBJECT_CLASS_CHECK(ADBKeyboardClass, (class), TYPE_ADB_KEYBOARD)
> +#define ADB_KEYBOARD_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(ADBKeyboardClass, (obj), TYPE_ADB_KEYBOARD)
> +
> +typedef struct ADBKeyboardClass {
> +    /*< private >*/
> +    ADBDeviceClass parent_class;
> +    /*< public >*/
> +
> +    DeviceRealize parent_realize;
> +} ADBKeyboardClass;
> +
> +/* The adb keyboard doesn't have every key imaginable */
> +#define NO_KEY 0xff
> +
> +int qcode_to_adb_keycode[] =3D {
> +     /* Make sure future additions are automatically set to NO_KEY */
> +    [0 ... 0xff]               =3D NO_KEY,
> +
> +    [Q_KEY_CODE_SHIFT]         =3D ADB_KEY_LEFT_SHIFT,
> +    [Q_KEY_CODE_SHIFT_R]       =3D ADB_KEY_RIGHT_SHIFT,
> +    [Q_KEY_CODE_ALT]           =3D ADB_KEY_LEFT_OPTION,
> +    [Q_KEY_CODE_ALT_R]         =3D ADB_KEY_RIGHT_OPTION,
> +    [Q_KEY_CODE_CTRL]          =3D ADB_KEY_LEFT_CONTROL,
> +    [Q_KEY_CODE_CTRL_R]        =3D ADB_KEY_RIGHT_CONTROL,
> +    [Q_KEY_CODE_META_L]        =3D ADB_KEY_COMMAND,
> +    [Q_KEY_CODE_META_R]        =3D ADB_KEY_COMMAND,
> +    [Q_KEY_CODE_SPC]           =3D ADB_KEY_SPACEBAR,
> +
> +    [Q_KEY_CODE_ESC]           =3D ADB_KEY_ESC,
> +    [Q_KEY_CODE_1]             =3D ADB_KEY_1,
> +    [Q_KEY_CODE_2]             =3D ADB_KEY_2,
> +    [Q_KEY_CODE_3]             =3D ADB_KEY_3,
> +    [Q_KEY_CODE_4]             =3D ADB_KEY_4,
> +    [Q_KEY_CODE_5]             =3D ADB_KEY_5,
> +    [Q_KEY_CODE_6]             =3D ADB_KEY_6,
> +    [Q_KEY_CODE_7]             =3D ADB_KEY_7,
> +    [Q_KEY_CODE_8]             =3D ADB_KEY_8,
> +    [Q_KEY_CODE_9]             =3D ADB_KEY_9,
> +    [Q_KEY_CODE_0]             =3D ADB_KEY_0,
> +    [Q_KEY_CODE_MINUS]         =3D ADB_KEY_MINUS,
> +    [Q_KEY_CODE_EQUAL]         =3D ADB_KEY_EQUAL,
> +    [Q_KEY_CODE_BACKSPACE]     =3D ADB_KEY_DELETE,
> +    [Q_KEY_CODE_TAB]           =3D ADB_KEY_TAB,
> +    [Q_KEY_CODE_Q]             =3D ADB_KEY_Q,
> +    [Q_KEY_CODE_W]             =3D ADB_KEY_W,
> +    [Q_KEY_CODE_E]             =3D ADB_KEY_E,
> +    [Q_KEY_CODE_R]             =3D ADB_KEY_R,
> +    [Q_KEY_CODE_T]             =3D ADB_KEY_T,
> +    [Q_KEY_CODE_Y]             =3D ADB_KEY_Y,
> +    [Q_KEY_CODE_U]             =3D ADB_KEY_U,
> +    [Q_KEY_CODE_I]             =3D ADB_KEY_I,
> +    [Q_KEY_CODE_O]             =3D ADB_KEY_O,
> +    [Q_KEY_CODE_P]             =3D ADB_KEY_P,
> +    [Q_KEY_CODE_BRACKET_LEFT]  =3D ADB_KEY_LEFT_BRACKET,
> +    [Q_KEY_CODE_BRACKET_RIGHT] =3D ADB_KEY_RIGHT_BRACKET,
> +    [Q_KEY_CODE_RET]           =3D ADB_KEY_RETURN,
> +    [Q_KEY_CODE_A]             =3D ADB_KEY_A,
> +    [Q_KEY_CODE_S]             =3D ADB_KEY_S,
> +    [Q_KEY_CODE_D]             =3D ADB_KEY_D,
> +    [Q_KEY_CODE_F]             =3D ADB_KEY_F,
> +    [Q_KEY_CODE_G]             =3D ADB_KEY_G,
> +    [Q_KEY_CODE_H]             =3D ADB_KEY_H,
> +    [Q_KEY_CODE_J]             =3D ADB_KEY_J,
> +    [Q_KEY_CODE_K]             =3D ADB_KEY_K,
> +    [Q_KEY_CODE_L]             =3D ADB_KEY_L,
> +    [Q_KEY_CODE_SEMICOLON]     =3D ADB_KEY_SEMICOLON,
> +    [Q_KEY_CODE_APOSTROPHE]    =3D ADB_KEY_APOSTROPHE,
> +    [Q_KEY_CODE_GRAVE_ACCENT]  =3D ADB_KEY_GRAVE_ACCENT,
> +    [Q_KEY_CODE_BACKSLASH]     =3D ADB_KEY_BACKSLASH,
> +    [Q_KEY_CODE_Z]             =3D ADB_KEY_Z,
> +    [Q_KEY_CODE_X]             =3D ADB_KEY_X,
> +    [Q_KEY_CODE_C]             =3D ADB_KEY_C,
> +    [Q_KEY_CODE_V]             =3D ADB_KEY_V,
> +    [Q_KEY_CODE_B]             =3D ADB_KEY_B,
> +    [Q_KEY_CODE_N]             =3D ADB_KEY_N,
> +    [Q_KEY_CODE_M]             =3D ADB_KEY_M,
> +    [Q_KEY_CODE_COMMA]         =3D ADB_KEY_COMMA,
> +    [Q_KEY_CODE_DOT]           =3D ADB_KEY_PERIOD,
> +    [Q_KEY_CODE_SLASH]         =3D ADB_KEY_FORWARD_SLASH,
> +    [Q_KEY_CODE_ASTERISK]      =3D ADB_KEY_KP_MULTIPLY,
> +    [Q_KEY_CODE_CAPS_LOCK]     =3D ADB_KEY_CAPS_LOCK,
> +
> +    [Q_KEY_CODE_F1]            =3D ADB_KEY_F1,
> +    [Q_KEY_CODE_F2]            =3D ADB_KEY_F2,
> +    [Q_KEY_CODE_F3]            =3D ADB_KEY_F3,
> +    [Q_KEY_CODE_F4]            =3D ADB_KEY_F4,
> +    [Q_KEY_CODE_F5]            =3D ADB_KEY_F5,
> +    [Q_KEY_CODE_F6]            =3D ADB_KEY_F6,
> +    [Q_KEY_CODE_F7]            =3D ADB_KEY_F7,
> +    [Q_KEY_CODE_F8]            =3D ADB_KEY_F8,
> +    [Q_KEY_CODE_F9]            =3D ADB_KEY_F9,
> +    [Q_KEY_CODE_F10]           =3D ADB_KEY_F10,
> +    [Q_KEY_CODE_F11]           =3D ADB_KEY_F11,
> +    [Q_KEY_CODE_F12]           =3D ADB_KEY_F12,
> +    [Q_KEY_CODE_PRINT]         =3D ADB_KEY_F13,
> +    [Q_KEY_CODE_SYSRQ]         =3D ADB_KEY_F13,
> +    [Q_KEY_CODE_SCROLL_LOCK]   =3D ADB_KEY_F14,
> +    [Q_KEY_CODE_PAUSE]         =3D ADB_KEY_F15,
> +
> +    [Q_KEY_CODE_NUM_LOCK]      =3D ADB_KEY_KP_CLEAR,
> +    [Q_KEY_CODE_KP_EQUALS]     =3D ADB_KEY_KP_EQUAL,
> +    [Q_KEY_CODE_KP_DIVIDE]     =3D ADB_KEY_KP_DIVIDE,
> +    [Q_KEY_CODE_KP_MULTIPLY]   =3D ADB_KEY_KP_MULTIPLY,
> +    [Q_KEY_CODE_KP_SUBTRACT]   =3D ADB_KEY_KP_SUBTRACT,
> +    [Q_KEY_CODE_KP_ADD]        =3D ADB_KEY_KP_PLUS,
> +    [Q_KEY_CODE_KP_ENTER]      =3D ADB_KEY_KP_ENTER,
> +    [Q_KEY_CODE_KP_DECIMAL]    =3D ADB_KEY_KP_PERIOD,
> +    [Q_KEY_CODE_KP_0]          =3D ADB_KEY_KP_0,
> +    [Q_KEY_CODE_KP_1]          =3D ADB_KEY_KP_1,
> +    [Q_KEY_CODE_KP_2]          =3D ADB_KEY_KP_2,
> +    [Q_KEY_CODE_KP_3]          =3D ADB_KEY_KP_3,
> +    [Q_KEY_CODE_KP_4]          =3D ADB_KEY_KP_4,
> +    [Q_KEY_CODE_KP_5]          =3D ADB_KEY_KP_5,
> +    [Q_KEY_CODE_KP_6]          =3D ADB_KEY_KP_6,
> +    [Q_KEY_CODE_KP_7]          =3D ADB_KEY_KP_7,
> +    [Q_KEY_CODE_KP_8]          =3D ADB_KEY_KP_8,
> +    [Q_KEY_CODE_KP_9]          =3D ADB_KEY_KP_9,
> +
> +    [Q_KEY_CODE_UP]            =3D ADB_KEY_UP,
> +    [Q_KEY_CODE_DOWN]          =3D ADB_KEY_DOWN,
> +    [Q_KEY_CODE_LEFT]          =3D ADB_KEY_LEFT,
> +    [Q_KEY_CODE_RIGHT]         =3D ADB_KEY_RIGHT,
> +
> +    [Q_KEY_CODE_HELP]          =3D ADB_KEY_HELP,
> +    [Q_KEY_CODE_INSERT]        =3D ADB_KEY_HELP,
> +    [Q_KEY_CODE_DELETE]        =3D ADB_KEY_FORWARD_DELETE,
> +    [Q_KEY_CODE_HOME]          =3D ADB_KEY_HOME,
> +    [Q_KEY_CODE_END]           =3D ADB_KEY_END,
> +    [Q_KEY_CODE_PGUP]          =3D ADB_KEY_PAGE_UP,
> +    [Q_KEY_CODE_PGDN]          =3D ADB_KEY_PAGE_DOWN,
> +
> +    [Q_KEY_CODE_POWER]         =3D ADB_KEY_POWER
> +};
> +
> +static void adb_kbd_put_keycode(void *opaque, int keycode)
> +{
> +    KBDState *s =3D opaque;
> +
> +    if (s->count < sizeof(s->data)) {
> +        s->data[s->wptr] =3D keycode;
> +        if (++s->wptr =3D=3D sizeof(s->data)) {
> +            s->wptr =3D 0;
> +        }
> +        s->count++;
> +    }
> +}
> +
> +static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
> +{
> +    KBDState *s =3D ADB_KEYBOARD(d);
> +    int keycode;
> +    int olen;
> +
> +    olen =3D 0;
> +    if (s->count =3D=3D 0) {
> +        return 0;
> +    }
> +    keycode =3D s->data[s->rptr];
> +    s->rptr++;
> +    if (s->rptr =3D=3D sizeof(s->data)) {
> +        s->rptr =3D 0;
> +    }
> +    s->count--;
> +    /*
> +     * The power key is the only two byte value key, so it is a special =
case.
> +     * Since 0x7f is not a used keycode for ADB we overload it to indica=
te the
> +     * power button when we're storing keycodes in our internal buffer, =
and
> +     * expand it out to two bytes when we send to the guest.
> +     */
> +    if (keycode =3D=3D 0x7f) {
> +        obuf[0] =3D 0x7f;
> +        obuf[1] =3D 0x7f;
> +        olen =3D 2;
> +    } else {
> +        obuf[0] =3D keycode;
> +        /* NOTE: the power key key-up is the two byte sequence 0xff 0xff=
;
> +         * otherwise we could in theory send a second keycode in the sec=
ond
> +         * byte, but choose not to bother.
> +         */
> +        obuf[1] =3D 0xff;
> +        olen =3D 2;
> +    }
> +
> +    return olen;
> +}
> +
> +static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
> +                           const uint8_t *buf, int len)
> +{
> +    KBDState *s =3D ADB_KEYBOARD(d);
> +    int cmd, reg, olen;
> +
> +    if ((buf[0] & 0x0f) =3D=3D ADB_FLUSH) {
> +        /* flush keyboard fifo */
> +        s->wptr =3D s->rptr =3D s->count =3D 0;
> +        return 0;
> +    }
> +
> +    cmd =3D buf[0] & 0xc;
> +    reg =3D buf[0] & 0x3;
> +    olen =3D 0;
> +    switch (cmd) {
> +    case ADB_WRITEREG:
> +        trace_adb_kbd_writereg(reg, buf[1]);
> +        switch (reg) {
> +        case 2:
> +            /* LED status */
> +            break;
> +        case 3:
> +            switch (buf[2]) {
> +            case ADB_CMD_SELF_TEST:
> +                break;
> +            case ADB_CMD_CHANGE_ID:
> +            case ADB_CMD_CHANGE_ID_AND_ACT:
> +            case ADB_CMD_CHANGE_ID_AND_ENABLE:
> +                d->devaddr =3D buf[1] & 0xf;
> +                break;
> +            default:
> +                d->devaddr =3D buf[1] & 0xf;
> +                /* we support handlers:
> +                 * 1: Apple Standard Keyboard
> +                 * 2: Apple Extended Keyboard (LShift =3D RShift)
> +                 * 3: Apple Extended Keyboard (LShift !=3D RShift)
> +                 */
> +                if (buf[2] =3D=3D 1 || buf[2] =3D=3D 2 || buf[2] =3D=3D =
3) {
> +                    d->handler =3D buf[2];
> +                }
> +                break;
> +            }
> +        }
> +        break;
> +    case ADB_READREG:
> +        switch (reg) {
> +        case 0:
> +            olen =3D adb_kbd_poll(d, obuf);
> +            break;
> +        case 1:
> +            break;
> +        case 2:
> +            obuf[0] =3D 0x00; /* XXX: check this */
> +            obuf[1] =3D 0x07; /* led status */
> +            olen =3D 2;
> +            break;
> +        case 3:
> +            obuf[0] =3D d->handler;
> +            obuf[1] =3D d->devaddr;
> +            olen =3D 2;
> +            break;
> +        }
> +        trace_adb_kbd_readreg(reg, obuf[0], obuf[1]);
> +        break;
> +    }
> +    return olen;
> +}
> +
> +/* This is where keyboard events enter this file */
> +static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
> +                               InputEvent *evt)
> +{
> +    KBDState *s =3D (KBDState *)dev;
> +    int qcode, keycode;
> +
> +    qcode =3D qemu_input_key_value_to_qcode(evt->u.key.data->key);
> +    if (qcode >=3D ARRAY_SIZE(qcode_to_adb_keycode)) {
> +        return;
> +    }
> +    /* FIXME: take handler into account when translating qcode */
> +    keycode =3D qcode_to_adb_keycode[qcode];
> +    if (keycode =3D=3D NO_KEY) {  /* We don't want to send this to the g=
uest */
> +        trace_adb_kbd_no_key();
> +        return;
> +    }
> +    if (evt->u.key.data->down =3D=3D false) { /* if key release event */
> +        keycode =3D keycode | 0x80;   /* create keyboard break code */
> +    }
> +
> +    adb_kbd_put_keycode(s, keycode);
> +}
> +
> +static const VMStateDescription vmstate_adb_kbd =3D {
> +    .name =3D "adb_kbd",
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_STRUCT(parent_obj, KBDState, 0, vmstate_adb_device, ADBD=
evice),
> +        VMSTATE_BUFFER(data, KBDState),
> +        VMSTATE_INT32(rptr, KBDState),
> +        VMSTATE_INT32(wptr, KBDState),
> +        VMSTATE_INT32(count, KBDState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void adb_kbd_reset(DeviceState *dev)
> +{
> +    ADBDevice *d =3D ADB_DEVICE(dev);
> +    KBDState *s =3D ADB_KEYBOARD(dev);
> +
> +    d->handler =3D 1;
> +    d->devaddr =3D ADB_DEVID_KEYBOARD;
> +    memset(s->data, 0, sizeof(s->data));
> +    s->rptr =3D 0;
> +    s->wptr =3D 0;
> +    s->count =3D 0;
> +}
> +
> +static QemuInputHandler adb_keyboard_handler =3D {
> +    .name  =3D "QEMU ADB Keyboard",
> +    .mask  =3D INPUT_EVENT_MASK_KEY,
> +    .event =3D adb_keyboard_event,
> +};
> +
> +static void adb_kbd_realizefn(DeviceState *dev, Error **errp)
> +{
> +    ADBKeyboardClass *akc =3D ADB_KEYBOARD_GET_CLASS(dev);
> +    akc->parent_realize(dev, errp);
> +    qemu_input_handler_register(dev, &adb_keyboard_handler);
> +}
> +
> +static void adb_kbd_initfn(Object *obj)
> +{
> +    ADBDevice *d =3D ADB_DEVICE(obj);
> +
> +    d->devaddr =3D ADB_DEVID_KEYBOARD;
> +}
> +
> +static void adb_kbd_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    ADBDeviceClass *adc =3D ADB_DEVICE_CLASS(oc);
> +    ADBKeyboardClass *akc =3D ADB_KEYBOARD_CLASS(oc);
> +
> +    akc->parent_realize =3D dc->realize;
> +    dc->realize =3D adb_kbd_realizefn;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +
> +    adc->devreq =3D adb_kbd_request;
> +    dc->reset =3D adb_kbd_reset;
> +    dc->vmsd =3D &vmstate_adb_kbd;
> +}
> +
> +static const TypeInfo adb_kbd_type_info =3D {
> +    .name =3D TYPE_ADB_KEYBOARD,
> +    .parent =3D TYPE_ADB_DEVICE,
> +    .instance_size =3D sizeof(KBDState),
> +    .instance_init =3D adb_kbd_initfn,
> +    .class_init =3D adb_kbd_class_init,
> +    .class_size =3D sizeof(ADBKeyboardClass),
> +};
> +
> +static void adb_kbd_register_types(void)
> +{
> +    type_register_static(&adb_kbd_type_info);
> +}
> +
> +type_init(adb_kbd_register_types)
> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
> new file mode 100644
> index 0000000000..c9004233b8
> --- /dev/null
> +++ b/hw/input/adb-mouse.c
> @@ -0,0 +1,254 @@
> +/*
> + * QEMU ADB mouse support
> + *
> + * Copyright (c) 2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "ui/console.h"
> +#include "hw/input/adb.h"
> +#include "adb-internal.h"
> +#include "trace.h"
> +
> +#define ADB_MOUSE(obj) OBJECT_CHECK(MouseState, (obj), TYPE_ADB_MOUSE)
> +
> +typedef struct MouseState {
> +    /*< public >*/
> +    ADBDevice parent_obj;
> +    /*< private >*/
> +
> +    int buttons_state, last_buttons_state;
> +    int dx, dy, dz;
> +} MouseState;
> +
> +#define ADB_MOUSE_CLASS(class) \
> +    OBJECT_CLASS_CHECK(ADBMouseClass, (class), TYPE_ADB_MOUSE)
> +#define ADB_MOUSE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(ADBMouseClass, (obj), TYPE_ADB_MOUSE)
> +
> +typedef struct ADBMouseClass {
> +    /*< public >*/
> +    ADBDeviceClass parent_class;
> +    /*< private >*/
> +
> +    DeviceRealize parent_realize;
> +} ADBMouseClass;
> +
> +static void adb_mouse_event(void *opaque,
> +                            int dx1, int dy1, int dz1, int buttons_state=
)
> +{
> +    MouseState *s =3D opaque;
> +
> +    s->dx +=3D dx1;
> +    s->dy +=3D dy1;
> +    s->dz +=3D dz1;
> +    s->buttons_state =3D buttons_state;
> +}
> +
> +
> +static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
> +{
> +    MouseState *s =3D ADB_MOUSE(d);
> +    int dx, dy;
> +
> +    if (s->last_buttons_state =3D=3D s->buttons_state &&
> +        s->dx =3D=3D 0 && s->dy =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    dx =3D s->dx;
> +    if (dx < -63) {
> +        dx =3D -63;
> +    } else if (dx > 63) {
> +        dx =3D 63;
> +    }
> +
> +    dy =3D s->dy;
> +    if (dy < -63) {
> +        dy =3D -63;
> +    } else if (dy > 63) {
> +        dy =3D 63;
> +    }
> +
> +    s->dx -=3D dx;
> +    s->dy -=3D dy;
> +    s->last_buttons_state =3D s->buttons_state;
> +
> +    dx &=3D 0x7f;
> +    dy &=3D 0x7f;
> +
> +    if (!(s->buttons_state & MOUSE_EVENT_LBUTTON)) {
> +        dy |=3D 0x80;
> +    }
> +    if (!(s->buttons_state & MOUSE_EVENT_RBUTTON)) {
> +        dx |=3D 0x80;
> +    }
> +
> +    obuf[0] =3D dy;
> +    obuf[1] =3D dx;
> +    return 2;
> +}
> +
> +static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
> +                             const uint8_t *buf, int len)
> +{
> +    MouseState *s =3D ADB_MOUSE(d);
> +    int cmd, reg, olen;
> +
> +    if ((buf[0] & 0x0f) =3D=3D ADB_FLUSH) {
> +        /* flush mouse fifo */
> +        s->buttons_state =3D s->last_buttons_state;
> +        s->dx =3D 0;
> +        s->dy =3D 0;
> +        s->dz =3D 0;
> +        return 0;
> +    }
> +
> +    cmd =3D buf[0] & 0xc;
> +    reg =3D buf[0] & 0x3;
> +    olen =3D 0;
> +    switch (cmd) {
> +    case ADB_WRITEREG:
> +        trace_adb_mouse_writereg(reg, buf[1]);
> +        switch (reg) {
> +        case 2:
> +            break;
> +        case 3:
> +            switch (buf[2]) {
> +            case ADB_CMD_SELF_TEST:
> +                break;
> +            case ADB_CMD_CHANGE_ID:
> +            case ADB_CMD_CHANGE_ID_AND_ACT:
> +            case ADB_CMD_CHANGE_ID_AND_ENABLE:
> +                d->devaddr =3D buf[1] & 0xf;
> +                break;
> +            default:
> +                d->devaddr =3D buf[1] & 0xf;
> +                /* we support handlers:
> +                 * 0x01: Classic Apple Mouse Protocol / 100 cpi operatio=
ns
> +                 * 0x02: Classic Apple Mouse Protocol / 200 cpi operatio=
ns
> +                 * we don't support handlers (at least):
> +                 * 0x03: Mouse systems A3 trackball
> +                 * 0x04: Extended Apple Mouse Protocol
> +                 * 0x2f: Microspeed mouse
> +                 * 0x42: Macally
> +                 * 0x5f: Microspeed mouse
> +                 * 0x66: Microspeed mouse
> +                 */
> +                if (buf[2] =3D=3D 1 || buf[2] =3D=3D 2) {
> +                    d->handler =3D buf[2];
> +                }
> +                break;
> +            }
> +        }
> +        break;
> +    case ADB_READREG:
> +        switch (reg) {
> +        case 0:
> +            olen =3D adb_mouse_poll(d, obuf);
> +            break;
> +        case 1:
> +            break;
> +        case 3:
> +            obuf[0] =3D d->handler;
> +            obuf[1] =3D d->devaddr;
> +            olen =3D 2;
> +            break;
> +        }
> +        trace_adb_mouse_readreg(reg, obuf[0], obuf[1]);
> +        break;
> +    }
> +    return olen;
> +}
> +
> +static void adb_mouse_reset(DeviceState *dev)
> +{
> +    ADBDevice *d =3D ADB_DEVICE(dev);
> +    MouseState *s =3D ADB_MOUSE(dev);
> +
> +    d->handler =3D 2;
> +    d->devaddr =3D ADB_DEVID_MOUSE;
> +    s->last_buttons_state =3D s->buttons_state =3D 0;
> +    s->dx =3D s->dy =3D s->dz =3D 0;
> +}
> +
> +static const VMStateDescription vmstate_adb_mouse =3D {
> +    .name =3D "adb_mouse",
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_STRUCT(parent_obj, MouseState, 0, vmstate_adb_device,
> +                       ADBDevice),
> +        VMSTATE_INT32(buttons_state, MouseState),
> +        VMSTATE_INT32(last_buttons_state, MouseState),
> +        VMSTATE_INT32(dx, MouseState),
> +        VMSTATE_INT32(dy, MouseState),
> +        VMSTATE_INT32(dz, MouseState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
> +{
> +    MouseState *s =3D ADB_MOUSE(dev);
> +    ADBMouseClass *amc =3D ADB_MOUSE_GET_CLASS(dev);
> +
> +    amc->parent_realize(dev, errp);
> +
> +    qemu_add_mouse_event_handler(adb_mouse_event, s, 0, "QEMU ADB Mouse"=
);
> +}
> +
> +static void adb_mouse_initfn(Object *obj)
> +{
> +    ADBDevice *d =3D ADB_DEVICE(obj);
> +
> +    d->devaddr =3D ADB_DEVID_MOUSE;
> +}
> +
> +static void adb_mouse_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    ADBDeviceClass *adc =3D ADB_DEVICE_CLASS(oc);
> +    ADBMouseClass *amc =3D ADB_MOUSE_CLASS(oc);
> +
> +    amc->parent_realize =3D dc->realize;
> +    dc->realize =3D adb_mouse_realizefn;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +
> +    adc->devreq =3D adb_mouse_request;
> +    dc->reset =3D adb_mouse_reset;
> +    dc->vmsd =3D &vmstate_adb_mouse;
> +}
> +
> +static const TypeInfo adb_mouse_type_info =3D {
> +    .name =3D TYPE_ADB_MOUSE,
> +    .parent =3D TYPE_ADB_DEVICE,
> +    .instance_size =3D sizeof(MouseState),
> +    .instance_init =3D adb_mouse_initfn,
> +    .class_init =3D adb_mouse_class_init,
> +    .class_size =3D sizeof(ADBMouseClass),
> +};
> +
> +static void adb_mouse_register_types(void)
> +{
> +    type_register_static(&adb_mouse_type_info);
> +}
> +
> +type_init(adb_mouse_register_types)
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index 924a3f9fd5..23ae6f0d75 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -22,49 +22,12 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> -#include "hw/hw.h"
>  #include "hw/input/adb.h"
> -#include "hw/input/adb-keys.h"
> -#include "ui/console.h"
> -#include "ui/input.h"
> -#include "sysemu/sysemu.h"
> -
> -/* debug ADB */
> -//#define DEBUG_ADB
> -
> -#ifdef DEBUG_ADB
> -#define ADB_DPRINTF(fmt, ...) \
> -do { printf("ADB: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define ADB_DPRINTF(fmt, ...)
> -#endif
> -
> -/* ADB commands */
> -#define ADB_BUSRESET           0x00
> -#define ADB_FLUSH               0x01
> -#define ADB_WRITEREG           0x08
> -#define ADB_READREG            0x0c
> -
> -/* ADB device commands */
> -#define ADB_CMD_SELF_TEST              0xff
> -#define ADB_CMD_CHANGE_ID              0xfe
> -#define ADB_CMD_CHANGE_ID_AND_ACT      0xfd
> -#define ADB_CMD_CHANGE_ID_AND_ENABLE   0x00
> -
> -/* ADB default device IDs (upper 4 bits of ADB command byte) */
> -#define ADB_DEVID_DONGLE   1
> -#define ADB_DEVID_KEYBOARD 2
> -#define ADB_DEVID_MOUSE    3
> -#define ADB_DEVID_TABLET   4
> -#define ADB_DEVID_MODEM    5
> -#define ADB_DEVID_MISC     7
> +#include "adb-internal.h"
>
>  /* error codes */
>  #define ADB_RET_NOTPRESENT (-2)
>
> -/* The adb keyboard doesn't have every key imaginable */
> -#define NO_KEY 0xff
> -
>  static void adb_device_reset(ADBDevice *d)
>  {
>      qdev_reset_all(DEVICE(d));
> @@ -127,7 +90,7 @@ static const TypeInfo adb_bus_type_info =3D {
>      .instance_size =3D sizeof(ADBBusState),
>  };
>
> -static const VMStateDescription vmstate_adb_device =3D {
> +const VMStateDescription vmstate_adb_device =3D {
>      .name =3D "adb_device",
>      .version_id =3D 0,
>      .minimum_version_id =3D 0,
> @@ -166,591 +129,10 @@ static const TypeInfo adb_device_type_info =3D {
>      .class_init =3D adb_device_class_init,
>  };
>
> -/***************************************************************/
> -/* Keyboard ADB device */
> -
> -#define ADB_KEYBOARD(obj) OBJECT_CHECK(KBDState, (obj), TYPE_ADB_KEYBOAR=
D)
> -
> -typedef struct KBDState {
> -    /*< private >*/
> -    ADBDevice parent_obj;
> -    /*< public >*/
> -
> -    uint8_t data[128];
> -    int rptr, wptr, count;
> -} KBDState;
> -
> -#define ADB_KEYBOARD_CLASS(class) \
> -    OBJECT_CLASS_CHECK(ADBKeyboardClass, (class), TYPE_ADB_KEYBOARD)
> -#define ADB_KEYBOARD_GET_CLASS(obj) \
> -    OBJECT_GET_CLASS(ADBKeyboardClass, (obj), TYPE_ADB_KEYBOARD)
> -
> -typedef struct ADBKeyboardClass {
> -    /*< private >*/
> -    ADBDeviceClass parent_class;
> -    /*< public >*/
> -
> -    DeviceRealize parent_realize;
> -} ADBKeyboardClass;
> -
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
> -
> -static void adb_kbd_put_keycode(void *opaque, int keycode)
> -{
> -    KBDState *s =3D opaque;
> -
> -    if (s->count < sizeof(s->data)) {
> -        s->data[s->wptr] =3D keycode;
> -        if (++s->wptr =3D=3D sizeof(s->data))
> -            s->wptr =3D 0;
> -        s->count++;
> -    }
> -}
> -
> -static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
> -{
> -    KBDState *s =3D ADB_KEYBOARD(d);
> -    int keycode;
> -    int olen;
> -
> -    olen =3D 0;
> -    if (s->count =3D=3D 0) {
> -        return 0;
> -    }
> -    keycode =3D s->data[s->rptr];
> -    s->rptr++;
> -    if (s->rptr =3D=3D sizeof(s->data)) {
> -        s->rptr =3D 0;
> -    }
> -    s->count--;
> -    /*
> -     * The power key is the only two byte value key, so it is a special =
case.
> -     * Since 0x7f is not a used keycode for ADB we overload it to indica=
te the
> -     * power button when we're storing keycodes in our internal buffer, =
and
> -     * expand it out to two bytes when we send to the guest.
> -     */
> -    if (keycode =3D=3D 0x7f) {
> -        obuf[0] =3D 0x7f;
> -        obuf[1] =3D 0x7f;
> -        olen =3D 2;
> -    } else {
> -        obuf[0] =3D keycode;
> -        /* NOTE: the power key key-up is the two byte sequence 0xff 0xff=
;
> -         * otherwise we could in theory send a second keycode in the sec=
ond
> -         * byte, but choose not to bother.
> -         */
> -        obuf[1] =3D 0xff;
> -        olen =3D 2;
> -    }
> -
> -    return olen;
> -}
> -
> -static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
> -                           const uint8_t *buf, int len)
> -{
> -    KBDState *s =3D ADB_KEYBOARD(d);
> -    int cmd, reg, olen;
> -
> -    if ((buf[0] & 0x0f) =3D=3D ADB_FLUSH) {
> -        /* flush keyboard fifo */
> -        s->wptr =3D s->rptr =3D s->count =3D 0;
> -        return 0;
> -    }
> -
> -    cmd =3D buf[0] & 0xc;
> -    reg =3D buf[0] & 0x3;
> -    olen =3D 0;
> -    switch(cmd) {
> -    case ADB_WRITEREG:
> -        switch(reg) {
> -        case 2:
> -            /* LED status */
> -            break;
> -        case 3:
> -            switch(buf[2]) {
> -            case ADB_CMD_SELF_TEST:
> -                break;
> -            case ADB_CMD_CHANGE_ID:
> -            case ADB_CMD_CHANGE_ID_AND_ACT:
> -            case ADB_CMD_CHANGE_ID_AND_ENABLE:
> -                d->devaddr =3D buf[1] & 0xf;
> -                break;
> -            default:
> -                d->devaddr =3D buf[1] & 0xf;
> -                /* we support handlers:
> -                 * 1: Apple Standard Keyboard
> -                 * 2: Apple Extended Keyboard (LShift =3D RShift)
> -                 * 3: Apple Extended Keyboard (LShift !=3D RShift)
> -                 */
> -                if (buf[2] =3D=3D 1 || buf[2] =3D=3D 2 || buf[2] =3D=3D =
3) {
> -                    d->handler =3D buf[2];
> -                }
> -                break;
> -            }
> -        }
> -        break;
> -    case ADB_READREG:
> -        switch(reg) {
> -        case 0:
> -            olen =3D adb_kbd_poll(d, obuf);
> -            break;
> -        case 1:
> -            break;
> -        case 2:
> -            obuf[0] =3D 0x00; /* XXX: check this */
> -            obuf[1] =3D 0x07; /* led status */
> -            olen =3D 2;
> -            break;
> -        case 3:
> -            obuf[0] =3D d->handler;
> -            obuf[1] =3D d->devaddr;
> -            olen =3D 2;
> -            break;
> -        }
> -        break;
> -    }
> -    return olen;
> -}
> -
> -/* This is where keyboard events enter this file */
> -static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
> -                               InputEvent *evt)
> -{
> -    KBDState *s =3D (KBDState *)dev;
> -    int qcode, keycode;
> -
> -    qcode =3D qemu_input_key_value_to_qcode(evt->u.key.data->key);
> -    if (qcode >=3D ARRAY_SIZE(qcode_to_adb_keycode)) {
> -        return;
> -    }
> -    /* FIXME: take handler into account when translating qcode */
> -    keycode =3D qcode_to_adb_keycode[qcode];
> -    if (keycode =3D=3D NO_KEY) {  /* We don't want to send this to the g=
uest */
> -        ADB_DPRINTF("Ignoring NO_KEY\n");
> -        return;
> -    }
> -    if (evt->u.key.data->down =3D=3D false) { /* if key release event */
> -        keycode =3D keycode | 0x80;   /* create keyboard break code */
> -    }
> -
> -    adb_kbd_put_keycode(s, keycode);
> -}
> -
> -static const VMStateDescription vmstate_adb_kbd =3D {
> -    .name =3D "adb_kbd",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_STRUCT(parent_obj, KBDState, 0, vmstate_adb_device, ADBD=
evice),
> -        VMSTATE_BUFFER(data, KBDState),
> -        VMSTATE_INT32(rptr, KBDState),
> -        VMSTATE_INT32(wptr, KBDState),
> -        VMSTATE_INT32(count, KBDState),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static void adb_kbd_reset(DeviceState *dev)
> -{
> -    ADBDevice *d =3D ADB_DEVICE(dev);
> -    KBDState *s =3D ADB_KEYBOARD(dev);
> -
> -    d->handler =3D 1;
> -    d->devaddr =3D ADB_DEVID_KEYBOARD;
> -    memset(s->data, 0, sizeof(s->data));
> -    s->rptr =3D 0;
> -    s->wptr =3D 0;
> -    s->count =3D 0;
> -}
> -
> -static QemuInputHandler adb_keyboard_handler =3D {
> -    .name  =3D "QEMU ADB Keyboard",
> -    .mask  =3D INPUT_EVENT_MASK_KEY,
> -    .event =3D adb_keyboard_event,
> -};
> -
> -static void adb_kbd_realizefn(DeviceState *dev, Error **errp)
> -{
> -    ADBKeyboardClass *akc =3D ADB_KEYBOARD_GET_CLASS(dev);
> -    akc->parent_realize(dev, errp);
> -    qemu_input_handler_register(dev, &adb_keyboard_handler);
> -}
> -
> -static void adb_kbd_initfn(Object *obj)
> -{
> -    ADBDevice *d =3D ADB_DEVICE(obj);
> -
> -    d->devaddr =3D ADB_DEVID_KEYBOARD;
> -}
> -
> -static void adb_kbd_class_init(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    ADBDeviceClass *adc =3D ADB_DEVICE_CLASS(oc);
> -    ADBKeyboardClass *akc =3D ADB_KEYBOARD_CLASS(oc);
> -
> -    akc->parent_realize =3D dc->realize;
> -    dc->realize =3D adb_kbd_realizefn;
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -
> -    adc->devreq =3D adb_kbd_request;
> -    dc->reset =3D adb_kbd_reset;
> -    dc->vmsd =3D &vmstate_adb_kbd;
> -}
> -
> -static const TypeInfo adb_kbd_type_info =3D {
> -    .name =3D TYPE_ADB_KEYBOARD,
> -    .parent =3D TYPE_ADB_DEVICE,
> -    .instance_size =3D sizeof(KBDState),
> -    .instance_init =3D adb_kbd_initfn,
> -    .class_init =3D adb_kbd_class_init,
> -    .class_size =3D sizeof(ADBKeyboardClass),
> -};
> -
> -/***************************************************************/
> -/* Mouse ADB device */
> -
> -#define ADB_MOUSE(obj) OBJECT_CHECK(MouseState, (obj), TYPE_ADB_MOUSE)
> -
> -typedef struct MouseState {
> -    /*< public >*/
> -    ADBDevice parent_obj;
> -    /*< private >*/
> -
> -    int buttons_state, last_buttons_state;
> -    int dx, dy, dz;
> -} MouseState;
> -
> -#define ADB_MOUSE_CLASS(class) \
> -    OBJECT_CLASS_CHECK(ADBMouseClass, (class), TYPE_ADB_MOUSE)
> -#define ADB_MOUSE_GET_CLASS(obj) \
> -    OBJECT_GET_CLASS(ADBMouseClass, (obj), TYPE_ADB_MOUSE)
> -
> -typedef struct ADBMouseClass {
> -    /*< public >*/
> -    ADBDeviceClass parent_class;
> -    /*< private >*/
> -
> -    DeviceRealize parent_realize;
> -} ADBMouseClass;
> -
> -static void adb_mouse_event(void *opaque,
> -                            int dx1, int dy1, int dz1, int buttons_state=
)
> -{
> -    MouseState *s =3D opaque;
> -
> -    s->dx +=3D dx1;
> -    s->dy +=3D dy1;
> -    s->dz +=3D dz1;
> -    s->buttons_state =3D buttons_state;
> -}
> -
> -
> -static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
> -{
> -    MouseState *s =3D ADB_MOUSE(d);
> -    int dx, dy;
> -
> -    if (s->last_buttons_state =3D=3D s->buttons_state &&
> -        s->dx =3D=3D 0 && s->dy =3D=3D 0)
> -        return 0;
> -
> -    dx =3D s->dx;
> -    if (dx < -63)
> -        dx =3D -63;
> -    else if (dx > 63)
> -        dx =3D 63;
> -
> -    dy =3D s->dy;
> -    if (dy < -63)
> -        dy =3D -63;
> -    else if (dy > 63)
> -        dy =3D 63;
> -
> -    s->dx -=3D dx;
> -    s->dy -=3D dy;
> -    s->last_buttons_state =3D s->buttons_state;
> -
> -    dx &=3D 0x7f;
> -    dy &=3D 0x7f;
> -
> -    if (!(s->buttons_state & MOUSE_EVENT_LBUTTON))
> -        dy |=3D 0x80;
> -    if (!(s->buttons_state & MOUSE_EVENT_RBUTTON))
> -        dx |=3D 0x80;
> -
> -    obuf[0] =3D dy;
> -    obuf[1] =3D dx;
> -    return 2;
> -}
> -
> -static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
> -                             const uint8_t *buf, int len)
> -{
> -    MouseState *s =3D ADB_MOUSE(d);
> -    int cmd, reg, olen;
> -
> -    if ((buf[0] & 0x0f) =3D=3D ADB_FLUSH) {
> -        /* flush mouse fifo */
> -        s->buttons_state =3D s->last_buttons_state;
> -        s->dx =3D 0;
> -        s->dy =3D 0;
> -        s->dz =3D 0;
> -        return 0;
> -    }
> -
> -    cmd =3D buf[0] & 0xc;
> -    reg =3D buf[0] & 0x3;
> -    olen =3D 0;
> -    switch(cmd) {
> -    case ADB_WRITEREG:
> -        ADB_DPRINTF("write reg %d val 0x%2.2x\n", reg, buf[1]);
> -        switch(reg) {
> -        case 2:
> -            break;
> -        case 3:
> -            switch(buf[2]) {
> -            case ADB_CMD_SELF_TEST:
> -                break;
> -            case ADB_CMD_CHANGE_ID:
> -            case ADB_CMD_CHANGE_ID_AND_ACT:
> -            case ADB_CMD_CHANGE_ID_AND_ENABLE:
> -                d->devaddr =3D buf[1] & 0xf;
> -                break;
> -            default:
> -                d->devaddr =3D buf[1] & 0xf;
> -                /* we support handlers:
> -                 * 0x01: Classic Apple Mouse Protocol / 100 cpi operatio=
ns
> -                 * 0x02: Classic Apple Mouse Protocol / 200 cpi operatio=
ns
> -                 * we don't support handlers (at least):
> -                 * 0x03: Mouse systems A3 trackball
> -                 * 0x04: Extended Apple Mouse Protocol
> -                 * 0x2f: Microspeed mouse
> -                 * 0x42: Macally
> -                 * 0x5f: Microspeed mouse
> -                 * 0x66: Microspeed mouse
> -                 */
> -                if (buf[2] =3D=3D 1 || buf[2] =3D=3D 2) {
> -                    d->handler =3D buf[2];
> -                }
> -                break;
> -            }
> -        }
> -        break;
> -    case ADB_READREG:
> -        switch(reg) {
> -        case 0:
> -            olen =3D adb_mouse_poll(d, obuf);
> -            break;
> -        case 1:
> -            break;
> -        case 3:
> -            obuf[0] =3D d->handler;
> -            obuf[1] =3D d->devaddr;
> -            olen =3D 2;
> -            break;
> -        }
> -        ADB_DPRINTF("read reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x\n", reg=
,
> -                    obuf[0], obuf[1]);
> -        break;
> -    }
> -    return olen;
> -}
> -
> -static void adb_mouse_reset(DeviceState *dev)
> -{
> -    ADBDevice *d =3D ADB_DEVICE(dev);
> -    MouseState *s =3D ADB_MOUSE(dev);
> -
> -    d->handler =3D 2;
> -    d->devaddr =3D ADB_DEVID_MOUSE;
> -    s->last_buttons_state =3D s->buttons_state =3D 0;
> -    s->dx =3D s->dy =3D s->dz =3D 0;
> -}
> -
> -static const VMStateDescription vmstate_adb_mouse =3D {
> -    .name =3D "adb_mouse",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_STRUCT(parent_obj, MouseState, 0, vmstate_adb_device,
> -                       ADBDevice),
> -        VMSTATE_INT32(buttons_state, MouseState),
> -        VMSTATE_INT32(last_buttons_state, MouseState),
> -        VMSTATE_INT32(dx, MouseState),
> -        VMSTATE_INT32(dy, MouseState),
> -        VMSTATE_INT32(dz, MouseState),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
> -{
> -    MouseState *s =3D ADB_MOUSE(dev);
> -    ADBMouseClass *amc =3D ADB_MOUSE_GET_CLASS(dev);
> -
> -    amc->parent_realize(dev, errp);
> -
> -    qemu_add_mouse_event_handler(adb_mouse_event, s, 0, "QEMU ADB Mouse"=
);
> -}
> -
> -static void adb_mouse_initfn(Object *obj)
> -{
> -    ADBDevice *d =3D ADB_DEVICE(obj);
> -
> -    d->devaddr =3D ADB_DEVID_MOUSE;
> -}
> -
> -static void adb_mouse_class_init(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    ADBDeviceClass *adc =3D ADB_DEVICE_CLASS(oc);
> -    ADBMouseClass *amc =3D ADB_MOUSE_CLASS(oc);
> -
> -    amc->parent_realize =3D dc->realize;
> -    dc->realize =3D adb_mouse_realizefn;
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -
> -    adc->devreq =3D adb_mouse_request;
> -    dc->reset =3D adb_mouse_reset;
> -    dc->vmsd =3D &vmstate_adb_mouse;
> -}
> -
> -static const TypeInfo adb_mouse_type_info =3D {
> -    .name =3D TYPE_ADB_MOUSE,
> -    .parent =3D TYPE_ADB_DEVICE,
> -    .instance_size =3D sizeof(MouseState),
> -    .instance_init =3D adb_mouse_initfn,
> -    .class_init =3D adb_mouse_class_init,
> -    .class_size =3D sizeof(ADBMouseClass),
> -};
> -
> -
>  static void adb_register_types(void)
>  {
>      type_register_static(&adb_bus_type_info);
>      type_register_static(&adb_device_type_info);
> -    type_register_static(&adb_kbd_type_info);
> -    type_register_static(&adb_mouse_type_info);
>  }
>
>  type_init(adb_register_types)
> diff --git a/hw/input/trace-events b/hw/input/trace-events
> index 88150ef7a6..a8d46cb766 100644
> --- a/hw/input/trace-events
> +++ b/hw/input/trace-events
> @@ -1,5 +1,13 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
> +# hw/input/adb-kbd.c
> +adb_kbd_no_key(void) "Ignoring NO_KEY"
> +adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
> +adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%=
2.2x obuf[1] 0x%2.2x"

Minor aesthetical change:
adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf
[0x%2.2x, 0x%2.2x]"

Anyway, regardless this:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +# hw/input/adb-mouse.c
> +adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
> +adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0=
x%2.2x obuf[1] 0x%2.2x"

Ditto:
adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf
[0x%2.2x, 0x%2.2x]"

> +
>  # hw/input/ps2.c
>  ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"
>  ps2_keyboard_event(void *opaque, int qcode, int down, unsigned int modif=
ier, unsigned int modifiers) "%p qcode %d down %d modifier 0x%x modifiers 0=
x%x"
> --
> 2.14.3
>
