Received: from eggs.gnu.org ([2001:4830:134:3::10]:59093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRNeE-0003rW-Ss
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 14:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRNe9-0005aC-Nz
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 14:33:54 -0500
Received: from chuckie.co.uk ([82.165.15.123]:39589
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRNe9-0005YV-5V
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 14:33:49 -0500
References: <20171219115447.17948-1-laurent@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <17b9df1d-9a1d-392a-8b64-431740e34a07@ilande.co.uk>
Date: Tue, 19 Dec 2017 19:33:29 +0000
MIME-Version: 1.0
In-Reply-To: <20171219115447.17948-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Split adb.c into adb.c,
 adb-mouse.c and adb-kbd.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 19/12/17 11:54, Laurent Vivier wrote:

> It makes the code clearer to separate the bus implementation
> from the devices one.
> 
> Remove ADB_DPRINTF() from adb.c instead of adding it to new files.
> Some minor changes to make checkpatch.pl happy.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/input/Makefile.objs |   2 +-
>   hw/input/adb-kbd.c     | 395 +++++++++++++++++++++++++++++++
>   hw/input/adb-mouse.c   | 250 ++++++++++++++++++++
>   hw/input/adb.c         | 621 +------------------------------------------------
>   include/hw/input/adb.h |  26 +++
>   5 files changed, 673 insertions(+), 621 deletions(-)
>   create mode 100644 hw/input/adb-kbd.c
>   create mode 100644 hw/input/adb-mouse.c
> 
> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
> index 636f794b6b..77e53e6883 100644
> --- a/hw/input/Makefile.objs
> +++ b/hw/input/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-$(CONFIG_ADB) += adb.o
> +common-obj-$(CONFIG_ADB) += adb.o adb-mouse.o adb-kbd.o
>   common-obj-y += hid.o
>   common-obj-$(CONFIG_LM832X) += lm832x.o
>   common-obj-$(CONFIG_PCKBD) += pckbd.o
> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
> new file mode 100644
> index 0000000000..c405ac814e
> --- /dev/null
> +++ b/hw/input/adb-kbd.c
> @@ -0,0 +1,395 @@
> +/*
> + * QEMU ADB keyboard support
> + *
> + * Copyright (c) 2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "hw/input/adb.h"
> +#include "ui/input.h"
> +#include "hw/input/adb-keys.h"
> +#include "sysemu/sysemu.h"
> +
> +#define ADB_KEYBOARD(obj) OBJECT_CHECK(KBDState, (obj), TYPE_ADB_KEYBOARD)
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
> +int qcode_to_adb_keycode[] = {
> +     /* Make sure future additions are automatically set to NO_KEY */
> +    [0 ... 0xff]               = NO_KEY,
> +
> +    [Q_KEY_CODE_SHIFT]         = ADB_KEY_LEFT_SHIFT,
> +    [Q_KEY_CODE_SHIFT_R]       = ADB_KEY_RIGHT_SHIFT,
> +    [Q_KEY_CODE_ALT]           = ADB_KEY_LEFT_OPTION,
> +    [Q_KEY_CODE_ALT_R]         = ADB_KEY_RIGHT_OPTION,
> +    [Q_KEY_CODE_CTRL]          = ADB_KEY_LEFT_CONTROL,
> +    [Q_KEY_CODE_CTRL_R]        = ADB_KEY_RIGHT_CONTROL,
> +    [Q_KEY_CODE_META_L]        = ADB_KEY_COMMAND,
> +    [Q_KEY_CODE_META_R]        = ADB_KEY_COMMAND,
> +    [Q_KEY_CODE_SPC]           = ADB_KEY_SPACEBAR,
> +
> +    [Q_KEY_CODE_ESC]           = ADB_KEY_ESC,
> +    [Q_KEY_CODE_1]             = ADB_KEY_1,
> +    [Q_KEY_CODE_2]             = ADB_KEY_2,
> +    [Q_KEY_CODE_3]             = ADB_KEY_3,
> +    [Q_KEY_CODE_4]             = ADB_KEY_4,
> +    [Q_KEY_CODE_5]             = ADB_KEY_5,
> +    [Q_KEY_CODE_6]             = ADB_KEY_6,
> +    [Q_KEY_CODE_7]             = ADB_KEY_7,
> +    [Q_KEY_CODE_8]             = ADB_KEY_8,
> +    [Q_KEY_CODE_9]             = ADB_KEY_9,
> +    [Q_KEY_CODE_0]             = ADB_KEY_0,
> +    [Q_KEY_CODE_MINUS]         = ADB_KEY_MINUS,
> +    [Q_KEY_CODE_EQUAL]         = ADB_KEY_EQUAL,
> +    [Q_KEY_CODE_BACKSPACE]     = ADB_KEY_DELETE,
> +    [Q_KEY_CODE_TAB]           = ADB_KEY_TAB,
> +    [Q_KEY_CODE_Q]             = ADB_KEY_Q,
> +    [Q_KEY_CODE_W]             = ADB_KEY_W,
> +    [Q_KEY_CODE_E]             = ADB_KEY_E,
> +    [Q_KEY_CODE_R]             = ADB_KEY_R,
> +    [Q_KEY_CODE_T]             = ADB_KEY_T,
> +    [Q_KEY_CODE_Y]             = ADB_KEY_Y,
> +    [Q_KEY_CODE_U]             = ADB_KEY_U,
> +    [Q_KEY_CODE_I]             = ADB_KEY_I,
> +    [Q_KEY_CODE_O]             = ADB_KEY_O,
> +    [Q_KEY_CODE_P]             = ADB_KEY_P,
> +    [Q_KEY_CODE_BRACKET_LEFT]  = ADB_KEY_LEFT_BRACKET,
> +    [Q_KEY_CODE_BRACKET_RIGHT] = ADB_KEY_RIGHT_BRACKET,
> +    [Q_KEY_CODE_RET]           = ADB_KEY_RETURN,
> +    [Q_KEY_CODE_A]             = ADB_KEY_A,
> +    [Q_KEY_CODE_S]             = ADB_KEY_S,
> +    [Q_KEY_CODE_D]             = ADB_KEY_D,
> +    [Q_KEY_CODE_F]             = ADB_KEY_F,
> +    [Q_KEY_CODE_G]             = ADB_KEY_G,
> +    [Q_KEY_CODE_H]             = ADB_KEY_H,
> +    [Q_KEY_CODE_J]             = ADB_KEY_J,
> +    [Q_KEY_CODE_K]             = ADB_KEY_K,
> +    [Q_KEY_CODE_L]             = ADB_KEY_L,
> +    [Q_KEY_CODE_SEMICOLON]     = ADB_KEY_SEMICOLON,
> +    [Q_KEY_CODE_APOSTROPHE]    = ADB_KEY_APOSTROPHE,
> +    [Q_KEY_CODE_GRAVE_ACCENT]  = ADB_KEY_GRAVE_ACCENT,
> +    [Q_KEY_CODE_BACKSLASH]     = ADB_KEY_BACKSLASH,
> +    [Q_KEY_CODE_Z]             = ADB_KEY_Z,
> +    [Q_KEY_CODE_X]             = ADB_KEY_X,
> +    [Q_KEY_CODE_C]             = ADB_KEY_C,
> +    [Q_KEY_CODE_V]             = ADB_KEY_V,
> +    [Q_KEY_CODE_B]             = ADB_KEY_B,
> +    [Q_KEY_CODE_N]             = ADB_KEY_N,
> +    [Q_KEY_CODE_M]             = ADB_KEY_M,
> +    [Q_KEY_CODE_COMMA]         = ADB_KEY_COMMA,
> +    [Q_KEY_CODE_DOT]           = ADB_KEY_PERIOD,
> +    [Q_KEY_CODE_SLASH]         = ADB_KEY_FORWARD_SLASH,
> +    [Q_KEY_CODE_ASTERISK]      = ADB_KEY_KP_MULTIPLY,
> +    [Q_KEY_CODE_CAPS_LOCK]     = ADB_KEY_CAPS_LOCK,
> +
> +    [Q_KEY_CODE_F1]            = ADB_KEY_F1,
> +    [Q_KEY_CODE_F2]            = ADB_KEY_F2,
> +    [Q_KEY_CODE_F3]            = ADB_KEY_F3,
> +    [Q_KEY_CODE_F4]            = ADB_KEY_F4,
> +    [Q_KEY_CODE_F5]            = ADB_KEY_F5,
> +    [Q_KEY_CODE_F6]            = ADB_KEY_F6,
> +    [Q_KEY_CODE_F7]            = ADB_KEY_F7,
> +    [Q_KEY_CODE_F8]            = ADB_KEY_F8,
> +    [Q_KEY_CODE_F9]            = ADB_KEY_F9,
> +    [Q_KEY_CODE_F10]           = ADB_KEY_F10,
> +    [Q_KEY_CODE_F11]           = ADB_KEY_F11,
> +    [Q_KEY_CODE_F12]           = ADB_KEY_F12,
> +    [Q_KEY_CODE_PRINT]         = ADB_KEY_F13,
> +    [Q_KEY_CODE_SYSRQ]         = ADB_KEY_F13,
> +    [Q_KEY_CODE_SCROLL_LOCK]   = ADB_KEY_F14,
> +    [Q_KEY_CODE_PAUSE]         = ADB_KEY_F15,
> +
> +    [Q_KEY_CODE_NUM_LOCK]      = ADB_KEY_KP_CLEAR,
> +    [Q_KEY_CODE_KP_EQUALS]     = ADB_KEY_KP_EQUAL,
> +    [Q_KEY_CODE_KP_DIVIDE]     = ADB_KEY_KP_DIVIDE,
> +    [Q_KEY_CODE_KP_MULTIPLY]   = ADB_KEY_KP_MULTIPLY,
> +    [Q_KEY_CODE_KP_SUBTRACT]   = ADB_KEY_KP_SUBTRACT,
> +    [Q_KEY_CODE_KP_ADD]        = ADB_KEY_KP_PLUS,
> +    [Q_KEY_CODE_KP_ENTER]      = ADB_KEY_KP_ENTER,
> +    [Q_KEY_CODE_KP_DECIMAL]    = ADB_KEY_KP_PERIOD,
> +    [Q_KEY_CODE_KP_0]          = ADB_KEY_KP_0,
> +    [Q_KEY_CODE_KP_1]          = ADB_KEY_KP_1,
> +    [Q_KEY_CODE_KP_2]          = ADB_KEY_KP_2,
> +    [Q_KEY_CODE_KP_3]          = ADB_KEY_KP_3,
> +    [Q_KEY_CODE_KP_4]          = ADB_KEY_KP_4,
> +    [Q_KEY_CODE_KP_5]          = ADB_KEY_KP_5,
> +    [Q_KEY_CODE_KP_6]          = ADB_KEY_KP_6,
> +    [Q_KEY_CODE_KP_7]          = ADB_KEY_KP_7,
> +    [Q_KEY_CODE_KP_8]          = ADB_KEY_KP_8,
> +    [Q_KEY_CODE_KP_9]          = ADB_KEY_KP_9,
> +
> +    [Q_KEY_CODE_UP]            = ADB_KEY_UP,
> +    [Q_KEY_CODE_DOWN]          = ADB_KEY_DOWN,
> +    [Q_KEY_CODE_LEFT]          = ADB_KEY_LEFT,
> +    [Q_KEY_CODE_RIGHT]         = ADB_KEY_RIGHT,
> +
> +    [Q_KEY_CODE_HELP]          = ADB_KEY_HELP,
> +    [Q_KEY_CODE_INSERT]        = ADB_KEY_HELP,
> +    [Q_KEY_CODE_DELETE]        = ADB_KEY_FORWARD_DELETE,
> +    [Q_KEY_CODE_HOME]          = ADB_KEY_HOME,
> +    [Q_KEY_CODE_END]           = ADB_KEY_END,
> +    [Q_KEY_CODE_PGUP]          = ADB_KEY_PAGE_UP,
> +    [Q_KEY_CODE_PGDN]          = ADB_KEY_PAGE_DOWN,
> +
> +    [Q_KEY_CODE_POWER]         = ADB_KEY_POWER
> +};
> +
> +static void adb_kbd_put_keycode(void *opaque, int keycode)
> +{
> +    KBDState *s = opaque;
> +
> +    if (s->count < sizeof(s->data)) {
> +        s->data[s->wptr] = keycode;
> +        if (++s->wptr == sizeof(s->data)) {
> +            s->wptr = 0;
> +        }
> +        s->count++;
> +    }
> +}
> +
> +static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
> +{
> +    KBDState *s = ADB_KEYBOARD(d);
> +    int keycode;
> +    int olen;
> +
> +    olen = 0;
> +    if (s->count == 0) {
> +        return 0;
> +    }
> +    keycode = s->data[s->rptr];
> +    s->rptr++;
> +    if (s->rptr == sizeof(s->data)) {
> +        s->rptr = 0;
> +    }
> +    s->count--;
> +    /*
> +     * The power key is the only two byte value key, so it is a special case.
> +     * Since 0x7f is not a used keycode for ADB we overload it to indicate the
> +     * power button when we're storing keycodes in our internal buffer, and
> +     * expand it out to two bytes when we send to the guest.
> +     */
> +    if (keycode == 0x7f) {
> +        obuf[0] = 0x7f;
> +        obuf[1] = 0x7f;
> +        olen = 2;
> +    } else {
> +        obuf[0] = keycode;
> +        /* NOTE: the power key key-up is the two byte sequence 0xff 0xff;
> +         * otherwise we could in theory send a second keycode in the second
> +         * byte, but choose not to bother.
> +         */
> +        obuf[1] = 0xff;
> +        olen = 2;
> +    }
> +
> +    return olen;
> +}
> +
> +static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
> +                           const uint8_t *buf, int len)
> +{
> +    KBDState *s = ADB_KEYBOARD(d);
> +    int cmd, reg, olen;
> +
> +    if ((buf[0] & 0x0f) == ADB_FLUSH) {
> +        /* flush keyboard fifo */
> +        s->wptr = s->rptr = s->count = 0;
> +        return 0;
> +    }
> +
> +    cmd = buf[0] & 0xc;
> +    reg = buf[0] & 0x3;
> +    olen = 0;
> +    switch (cmd) {
> +    case ADB_WRITEREG:
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
> +                d->devaddr = buf[1] & 0xf;
> +                break;
> +            default:
> +                d->devaddr = buf[1] & 0xf;
> +                /* we support handlers:
> +                 * 1: Apple Standard Keyboard
> +                 * 2: Apple Extended Keyboard (LShift = RShift)
> +                 * 3: Apple Extended Keyboard (LShift != RShift)
> +                 */
> +                if (buf[2] == 1 || buf[2] == 2 || buf[2] == 3) {
> +                    d->handler = buf[2];
> +                }
> +                break;
> +            }
> +        }
> +        break;
> +    case ADB_READREG:
> +        switch (reg) {
> +        case 0:
> +            olen = adb_kbd_poll(d, obuf);
> +            break;
> +        case 1:
> +            break;
> +        case 2:
> +            obuf[0] = 0x00; /* XXX: check this */
> +            obuf[1] = 0x07; /* led status */
> +            olen = 2;
> +            break;
> +        case 3:
> +            obuf[0] = d->handler;
> +            obuf[1] = d->devaddr;
> +            olen = 2;
> +            break;
> +        }
> +        break;
> +    }
> +    return olen;
> +}
> +
> +/* This is where keyboard events enter this file */
> +static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
> +                               InputEvent *evt)
> +{
> +    KBDState *s = (KBDState *)dev;
> +    int qcode, keycode;
> +
> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
> +    if (qcode >= ARRAY_SIZE(qcode_to_adb_keycode)) {
> +        return;
> +    }
> +    /* FIXME: take handler into account when translating qcode */
> +    keycode = qcode_to_adb_keycode[qcode];
> +    if (keycode == NO_KEY) {  /* We don't want to send this to the guest */
> +        return;
> +    }
> +    if (evt->u.key.data->down == false) { /* if key release event */
> +        keycode = keycode | 0x80;   /* create keyboard break code */
> +    }
> +
> +    adb_kbd_put_keycode(s, keycode);
> +}
> +
> +static const VMStateDescription vmstate_adb_kbd = {
> +    .name = "adb_kbd",
> +    .version_id = 2,
> +    .minimum_version_id = 2,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT(parent_obj, KBDState, 0, vmstate_adb_device, ADBDevice),
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
> +    ADBDevice *d = ADB_DEVICE(dev);
> +    KBDState *s = ADB_KEYBOARD(dev);
> +
> +    d->handler = 1;
> +    d->devaddr = ADB_DEVID_KEYBOARD;
> +    memset(s->data, 0, sizeof(s->data));
> +    s->rptr = 0;
> +    s->wptr = 0;
> +    s->count = 0;
> +}
> +
> +static QemuInputHandler adb_keyboard_handler = {
> +    .name  = "QEMU ADB Keyboard",
> +    .mask  = INPUT_EVENT_MASK_KEY,
> +    .event = adb_keyboard_event,
> +};
> +
> +static void adb_kbd_realizefn(DeviceState *dev, Error **errp)
> +{
> +    ADBKeyboardClass *akc = ADB_KEYBOARD_GET_CLASS(dev);
> +    akc->parent_realize(dev, errp);
> +    qemu_input_handler_register(dev, &adb_keyboard_handler);
> +}
> +
> +static void adb_kbd_initfn(Object *obj)
> +{
> +    ADBDevice *d = ADB_DEVICE(obj);
> +
> +    d->devaddr = ADB_DEVID_KEYBOARD;
> +}
> +
> +static void adb_kbd_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
> +    ADBKeyboardClass *akc = ADB_KEYBOARD_CLASS(oc);
> +
> +    akc->parent_realize = dc->realize;
> +    dc->realize = adb_kbd_realizefn;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +
> +    adc->devreq = adb_kbd_request;
> +    dc->reset = adb_kbd_reset;
> +    dc->vmsd = &vmstate_adb_kbd;
> +}
> +
> +static const TypeInfo adb_kbd_type_info = {
> +    .name = TYPE_ADB_KEYBOARD,
> +    .parent = TYPE_ADB_DEVICE,
> +    .instance_size = sizeof(KBDState),
> +    .instance_init = adb_kbd_initfn,
> +    .class_init = adb_kbd_class_init,
> +    .class_size = sizeof(ADBKeyboardClass),
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
> index 0000000000..8d96da6640
> --- /dev/null
> +++ b/hw/input/adb-mouse.c
> @@ -0,0 +1,250 @@
> +/*
> + * QEMU ADB mouse support
> + *
> + * Copyright (c) 2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "ui/console.h"
> +#include "hw/input/adb.h"
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
> +                            int dx1, int dy1, int dz1, int buttons_state)
> +{
> +    MouseState *s = opaque;
> +
> +    s->dx += dx1;
> +    s->dy += dy1;
> +    s->dz += dz1;
> +    s->buttons_state = buttons_state;
> +}
> +
> +
> +static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
> +{
> +    MouseState *s = ADB_MOUSE(d);
> +    int dx, dy;
> +
> +    if (s->last_buttons_state == s->buttons_state &&
> +        s->dx == 0 && s->dy == 0) {
> +        return 0;
> +    }
> +
> +    dx = s->dx;
> +    if (dx < -63) {
> +        dx = -63;
> +    } else if (dx > 63) {
> +        dx = 63;
> +    }
> +
> +    dy = s->dy;
> +    if (dy < -63) {
> +        dy = -63;
> +    } else if (dy > 63) {
> +        dy = 63;
> +    }
> +
> +    s->dx -= dx;
> +    s->dy -= dy;
> +    s->last_buttons_state = s->buttons_state;
> +
> +    dx &= 0x7f;
> +    dy &= 0x7f;
> +
> +    if (!(s->buttons_state & MOUSE_EVENT_LBUTTON)) {
> +        dy |= 0x80;
> +    }
> +    if (!(s->buttons_state & MOUSE_EVENT_RBUTTON)) {
> +        dx |= 0x80;
> +    }
> +
> +    obuf[0] = dy;
> +    obuf[1] = dx;
> +    return 2;
> +}
> +
> +static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
> +                             const uint8_t *buf, int len)
> +{
> +    MouseState *s = ADB_MOUSE(d);
> +    int cmd, reg, olen;
> +
> +    if ((buf[0] & 0x0f) == ADB_FLUSH) {
> +        /* flush mouse fifo */
> +        s->buttons_state = s->last_buttons_state;
> +        s->dx = 0;
> +        s->dy = 0;
> +        s->dz = 0;
> +        return 0;
> +    }
> +
> +    cmd = buf[0] & 0xc;
> +    reg = buf[0] & 0x3;
> +    olen = 0;
> +    switch (cmd) {
> +    case ADB_WRITEREG:
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
> +                d->devaddr = buf[1] & 0xf;
> +                break;
> +            default:
> +                d->devaddr = buf[1] & 0xf;
> +                /* we support handlers:
> +                 * 0x01: Classic Apple Mouse Protocol / 100 cpi operations
> +                 * 0x02: Classic Apple Mouse Protocol / 200 cpi operations
> +                 * we don't support handlers (at least):
> +                 * 0x03: Mouse systems A3 trackball
> +                 * 0x04: Extended Apple Mouse Protocol
> +                 * 0x2f: Microspeed mouse
> +                 * 0x42: Macally
> +                 * 0x5f: Microspeed mouse
> +                 * 0x66: Microspeed mouse
> +                 */
> +                if (buf[2] == 1 || buf[2] == 2) {
> +                    d->handler = buf[2];
> +                }
> +                break;
> +            }
> +        }
> +        break;
> +    case ADB_READREG:
> +        switch (reg) {
> +        case 0:
> +            olen = adb_mouse_poll(d, obuf);
> +            break;
> +        case 1:
> +            break;
> +        case 3:
> +            obuf[0] = d->handler;
> +            obuf[1] = d->devaddr;
> +            olen = 2;
> +            break;
> +        }
> +        break;
> +    }
> +    return olen;
> +}
> +
> +static void adb_mouse_reset(DeviceState *dev)
> +{
> +    ADBDevice *d = ADB_DEVICE(dev);
> +    MouseState *s = ADB_MOUSE(dev);
> +
> +    d->handler = 2;
> +    d->devaddr = ADB_DEVID_MOUSE;
> +    s->last_buttons_state = s->buttons_state = 0;
> +    s->dx = s->dy = s->dz = 0;
> +}
> +
> +static const VMStateDescription vmstate_adb_mouse = {
> +    .name = "adb_mouse",
> +    .version_id = 2,
> +    .minimum_version_id = 2,
> +    .fields = (VMStateField[]) {
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
> +    MouseState *s = ADB_MOUSE(dev);
> +    ADBMouseClass *amc = ADB_MOUSE_GET_CLASS(dev);
> +
> +    amc->parent_realize(dev, errp);
> +
> +    qemu_add_mouse_event_handler(adb_mouse_event, s, 0, "QEMU ADB Mouse");
> +}
> +
> +static void adb_mouse_initfn(Object *obj)
> +{
> +    ADBDevice *d = ADB_DEVICE(obj);
> +
> +    d->devaddr = ADB_DEVID_MOUSE;
> +}
> +
> +static void adb_mouse_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
> +    ADBMouseClass *amc = ADB_MOUSE_CLASS(oc);
> +
> +    amc->parent_realize = dc->realize;
> +    dc->realize = adb_mouse_realizefn;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +
> +    adc->devreq = adb_mouse_request;
> +    dc->reset = adb_mouse_reset;
> +    dc->vmsd = &vmstate_adb_mouse;
> +}
> +
> +static const TypeInfo adb_mouse_type_info = {
> +    .name = TYPE_ADB_MOUSE,
> +    .parent = TYPE_ADB_DEVICE,
> +    .instance_size = sizeof(MouseState),
> +    .instance_init = adb_mouse_initfn,
> +    .class_init = adb_mouse_class_init,
> +    .class_size = sizeof(ADBMouseClass),
> +};
> +
> +static void adb_mouse_register_types(void)
> +{
> +    type_register_static(&adb_mouse_type_info);
> +}
> +
> +type_init(adb_mouse_register_types)
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index 924a3f9fd5..a9ad07fa55 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -22,49 +22,11 @@
>    * THE SOFTWARE.
>    */
>   #include "qemu/osdep.h"
> -#include "hw/hw.h"
>   #include "hw/input/adb.h"
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
> -#define ADB_BUSRESET		0x00
> -#define ADB_FLUSH               0x01
> -#define ADB_WRITEREG		0x08
> -#define ADB_READREG		0x0c
> -
> -/* ADB device commands */
> -#define ADB_CMD_SELF_TEST		0xff
> -#define ADB_CMD_CHANGE_ID		0xfe
> -#define ADB_CMD_CHANGE_ID_AND_ACT	0xfd
> -#define ADB_CMD_CHANGE_ID_AND_ENABLE	0x00
> -
> -/* ADB default device IDs (upper 4 bits of ADB command byte) */
> -#define ADB_DEVID_DONGLE   1
> -#define ADB_DEVID_KEYBOARD 2
> -#define ADB_DEVID_MOUSE    3
> -#define ADB_DEVID_TABLET   4
> -#define ADB_DEVID_MODEM    5
> -#define ADB_DEVID_MISC     7
>   
>   /* error codes */
>   #define ADB_RET_NOTPRESENT (-2)
>   
> -/* The adb keyboard doesn't have every key imaginable */
> -#define NO_KEY 0xff
> -
>   static void adb_device_reset(ADBDevice *d)
>   {
>       qdev_reset_all(DEVICE(d));
> @@ -127,7 +89,7 @@ static const TypeInfo adb_bus_type_info = {
>       .instance_size = sizeof(ADBBusState),
>   };
>   
> -static const VMStateDescription vmstate_adb_device = {
> +const VMStateDescription vmstate_adb_device = {
>       .name = "adb_device",
>       .version_id = 0,
>       .minimum_version_id = 0,
> @@ -166,591 +128,10 @@ static const TypeInfo adb_device_type_info = {
>       .class_init = adb_device_class_init,
>   };
>   
> -/***************************************************************/
> -/* Keyboard ADB device */
> -
> -#define ADB_KEYBOARD(obj) OBJECT_CHECK(KBDState, (obj), TYPE_ADB_KEYBOARD)
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
> -int qcode_to_adb_keycode[] = {
> -     /* Make sure future additions are automatically set to NO_KEY */
> -    [0 ... 0xff]               = NO_KEY,
> -
> -    [Q_KEY_CODE_SHIFT]         = ADB_KEY_LEFT_SHIFT,
> -    [Q_KEY_CODE_SHIFT_R]       = ADB_KEY_RIGHT_SHIFT,
> -    [Q_KEY_CODE_ALT]           = ADB_KEY_LEFT_OPTION,
> -    [Q_KEY_CODE_ALT_R]         = ADB_KEY_RIGHT_OPTION,
> -    [Q_KEY_CODE_CTRL]          = ADB_KEY_LEFT_CONTROL,
> -    [Q_KEY_CODE_CTRL_R]        = ADB_KEY_RIGHT_CONTROL,
> -    [Q_KEY_CODE_META_L]        = ADB_KEY_COMMAND,
> -    [Q_KEY_CODE_META_R]        = ADB_KEY_COMMAND,
> -    [Q_KEY_CODE_SPC]           = ADB_KEY_SPACEBAR,
> -
> -    [Q_KEY_CODE_ESC]           = ADB_KEY_ESC,
> -    [Q_KEY_CODE_1]             = ADB_KEY_1,
> -    [Q_KEY_CODE_2]             = ADB_KEY_2,
> -    [Q_KEY_CODE_3]             = ADB_KEY_3,
> -    [Q_KEY_CODE_4]             = ADB_KEY_4,
> -    [Q_KEY_CODE_5]             = ADB_KEY_5,
> -    [Q_KEY_CODE_6]             = ADB_KEY_6,
> -    [Q_KEY_CODE_7]             = ADB_KEY_7,
> -    [Q_KEY_CODE_8]             = ADB_KEY_8,
> -    [Q_KEY_CODE_9]             = ADB_KEY_9,
> -    [Q_KEY_CODE_0]             = ADB_KEY_0,
> -    [Q_KEY_CODE_MINUS]         = ADB_KEY_MINUS,
> -    [Q_KEY_CODE_EQUAL]         = ADB_KEY_EQUAL,
> -    [Q_KEY_CODE_BACKSPACE]     = ADB_KEY_DELETE,
> -    [Q_KEY_CODE_TAB]           = ADB_KEY_TAB,
> -    [Q_KEY_CODE_Q]             = ADB_KEY_Q,
> -    [Q_KEY_CODE_W]             = ADB_KEY_W,
> -    [Q_KEY_CODE_E]             = ADB_KEY_E,
> -    [Q_KEY_CODE_R]             = ADB_KEY_R,
> -    [Q_KEY_CODE_T]             = ADB_KEY_T,
> -    [Q_KEY_CODE_Y]             = ADB_KEY_Y,
> -    [Q_KEY_CODE_U]             = ADB_KEY_U,
> -    [Q_KEY_CODE_I]             = ADB_KEY_I,
> -    [Q_KEY_CODE_O]             = ADB_KEY_O,
> -    [Q_KEY_CODE_P]             = ADB_KEY_P,
> -    [Q_KEY_CODE_BRACKET_LEFT]  = ADB_KEY_LEFT_BRACKET,
> -    [Q_KEY_CODE_BRACKET_RIGHT] = ADB_KEY_RIGHT_BRACKET,
> -    [Q_KEY_CODE_RET]           = ADB_KEY_RETURN,
> -    [Q_KEY_CODE_A]             = ADB_KEY_A,
> -    [Q_KEY_CODE_S]             = ADB_KEY_S,
> -    [Q_KEY_CODE_D]             = ADB_KEY_D,
> -    [Q_KEY_CODE_F]             = ADB_KEY_F,
> -    [Q_KEY_CODE_G]             = ADB_KEY_G,
> -    [Q_KEY_CODE_H]             = ADB_KEY_H,
> -    [Q_KEY_CODE_J]             = ADB_KEY_J,
> -    [Q_KEY_CODE_K]             = ADB_KEY_K,
> -    [Q_KEY_CODE_L]             = ADB_KEY_L,
> -    [Q_KEY_CODE_SEMICOLON]     = ADB_KEY_SEMICOLON,
> -    [Q_KEY_CODE_APOSTROPHE]    = ADB_KEY_APOSTROPHE,
> -    [Q_KEY_CODE_GRAVE_ACCENT]  = ADB_KEY_GRAVE_ACCENT,
> -    [Q_KEY_CODE_BACKSLASH]     = ADB_KEY_BACKSLASH,
> -    [Q_KEY_CODE_Z]             = ADB_KEY_Z,
> -    [Q_KEY_CODE_X]             = ADB_KEY_X,
> -    [Q_KEY_CODE_C]             = ADB_KEY_C,
> -    [Q_KEY_CODE_V]             = ADB_KEY_V,
> -    [Q_KEY_CODE_B]             = ADB_KEY_B,
> -    [Q_KEY_CODE_N]             = ADB_KEY_N,
> -    [Q_KEY_CODE_M]             = ADB_KEY_M,
> -    [Q_KEY_CODE_COMMA]         = ADB_KEY_COMMA,
> -    [Q_KEY_CODE_DOT]           = ADB_KEY_PERIOD,
> -    [Q_KEY_CODE_SLASH]         = ADB_KEY_FORWARD_SLASH,
> -    [Q_KEY_CODE_ASTERISK]      = ADB_KEY_KP_MULTIPLY,
> -    [Q_KEY_CODE_CAPS_LOCK]     = ADB_KEY_CAPS_LOCK,
> -
> -    [Q_KEY_CODE_F1]            = ADB_KEY_F1,
> -    [Q_KEY_CODE_F2]            = ADB_KEY_F2,
> -    [Q_KEY_CODE_F3]            = ADB_KEY_F3,
> -    [Q_KEY_CODE_F4]            = ADB_KEY_F4,
> -    [Q_KEY_CODE_F5]            = ADB_KEY_F5,
> -    [Q_KEY_CODE_F6]            = ADB_KEY_F6,
> -    [Q_KEY_CODE_F7]            = ADB_KEY_F7,
> -    [Q_KEY_CODE_F8]            = ADB_KEY_F8,
> -    [Q_KEY_CODE_F9]            = ADB_KEY_F9,
> -    [Q_KEY_CODE_F10]           = ADB_KEY_F10,
> -    [Q_KEY_CODE_F11]           = ADB_KEY_F11,
> -    [Q_KEY_CODE_F12]           = ADB_KEY_F12,
> -    [Q_KEY_CODE_PRINT]         = ADB_KEY_F13,
> -    [Q_KEY_CODE_SYSRQ]         = ADB_KEY_F13,
> -    [Q_KEY_CODE_SCROLL_LOCK]   = ADB_KEY_F14,
> -    [Q_KEY_CODE_PAUSE]         = ADB_KEY_F15,
> -
> -    [Q_KEY_CODE_NUM_LOCK]      = ADB_KEY_KP_CLEAR,
> -    [Q_KEY_CODE_KP_EQUALS]     = ADB_KEY_KP_EQUAL,
> -    [Q_KEY_CODE_KP_DIVIDE]     = ADB_KEY_KP_DIVIDE,
> -    [Q_KEY_CODE_KP_MULTIPLY]   = ADB_KEY_KP_MULTIPLY,
> -    [Q_KEY_CODE_KP_SUBTRACT]   = ADB_KEY_KP_SUBTRACT,
> -    [Q_KEY_CODE_KP_ADD]        = ADB_KEY_KP_PLUS,
> -    [Q_KEY_CODE_KP_ENTER]      = ADB_KEY_KP_ENTER,
> -    [Q_KEY_CODE_KP_DECIMAL]    = ADB_KEY_KP_PERIOD,
> -    [Q_KEY_CODE_KP_0]          = ADB_KEY_KP_0,
> -    [Q_KEY_CODE_KP_1]          = ADB_KEY_KP_1,
> -    [Q_KEY_CODE_KP_2]          = ADB_KEY_KP_2,
> -    [Q_KEY_CODE_KP_3]          = ADB_KEY_KP_3,
> -    [Q_KEY_CODE_KP_4]          = ADB_KEY_KP_4,
> -    [Q_KEY_CODE_KP_5]          = ADB_KEY_KP_5,
> -    [Q_KEY_CODE_KP_6]          = ADB_KEY_KP_6,
> -    [Q_KEY_CODE_KP_7]          = ADB_KEY_KP_7,
> -    [Q_KEY_CODE_KP_8]          = ADB_KEY_KP_8,
> -    [Q_KEY_CODE_KP_9]          = ADB_KEY_KP_9,
> -
> -    [Q_KEY_CODE_UP]            = ADB_KEY_UP,
> -    [Q_KEY_CODE_DOWN]          = ADB_KEY_DOWN,
> -    [Q_KEY_CODE_LEFT]          = ADB_KEY_LEFT,
> -    [Q_KEY_CODE_RIGHT]         = ADB_KEY_RIGHT,
> -
> -    [Q_KEY_CODE_HELP]          = ADB_KEY_HELP,
> -    [Q_KEY_CODE_INSERT]        = ADB_KEY_HELP,
> -    [Q_KEY_CODE_DELETE]        = ADB_KEY_FORWARD_DELETE,
> -    [Q_KEY_CODE_HOME]          = ADB_KEY_HOME,
> -    [Q_KEY_CODE_END]           = ADB_KEY_END,
> -    [Q_KEY_CODE_PGUP]          = ADB_KEY_PAGE_UP,
> -    [Q_KEY_CODE_PGDN]          = ADB_KEY_PAGE_DOWN,
> -
> -    [Q_KEY_CODE_POWER]         = ADB_KEY_POWER
> -};
> -
> -static void adb_kbd_put_keycode(void *opaque, int keycode)
> -{
> -    KBDState *s = opaque;
> -
> -    if (s->count < sizeof(s->data)) {
> -        s->data[s->wptr] = keycode;
> -        if (++s->wptr == sizeof(s->data))
> -            s->wptr = 0;
> -        s->count++;
> -    }
> -}
> -
> -static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
> -{
> -    KBDState *s = ADB_KEYBOARD(d);
> -    int keycode;
> -    int olen;
> -
> -    olen = 0;
> -    if (s->count == 0) {
> -        return 0;
> -    }
> -    keycode = s->data[s->rptr];
> -    s->rptr++;
> -    if (s->rptr == sizeof(s->data)) {
> -        s->rptr = 0;
> -    }
> -    s->count--;
> -    /*
> -     * The power key is the only two byte value key, so it is a special case.
> -     * Since 0x7f is not a used keycode for ADB we overload it to indicate the
> -     * power button when we're storing keycodes in our internal buffer, and
> -     * expand it out to two bytes when we send to the guest.
> -     */
> -    if (keycode == 0x7f) {
> -        obuf[0] = 0x7f;
> -        obuf[1] = 0x7f;
> -        olen = 2;
> -    } else {
> -        obuf[0] = keycode;
> -        /* NOTE: the power key key-up is the two byte sequence 0xff 0xff;
> -         * otherwise we could in theory send a second keycode in the second
> -         * byte, but choose not to bother.
> -         */
> -        obuf[1] = 0xff;
> -        olen = 2;
> -    }
> -
> -    return olen;
> -}
> -
> -static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
> -                           const uint8_t *buf, int len)
> -{
> -    KBDState *s = ADB_KEYBOARD(d);
> -    int cmd, reg, olen;
> -
> -    if ((buf[0] & 0x0f) == ADB_FLUSH) {
> -        /* flush keyboard fifo */
> -        s->wptr = s->rptr = s->count = 0;
> -        return 0;
> -    }
> -
> -    cmd = buf[0] & 0xc;
> -    reg = buf[0] & 0x3;
> -    olen = 0;
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
> -                d->devaddr = buf[1] & 0xf;
> -                break;
> -            default:
> -                d->devaddr = buf[1] & 0xf;
> -                /* we support handlers:
> -                 * 1: Apple Standard Keyboard
> -                 * 2: Apple Extended Keyboard (LShift = RShift)
> -                 * 3: Apple Extended Keyboard (LShift != RShift)
> -                 */
> -                if (buf[2] == 1 || buf[2] == 2 || buf[2] == 3) {
> -                    d->handler = buf[2];
> -                }
> -                break;
> -            }
> -        }
> -        break;
> -    case ADB_READREG:
> -        switch(reg) {
> -        case 0:
> -            olen = adb_kbd_poll(d, obuf);
> -            break;
> -        case 1:
> -            break;
> -        case 2:
> -            obuf[0] = 0x00; /* XXX: check this */
> -            obuf[1] = 0x07; /* led status */
> -            olen = 2;
> -            break;
> -        case 3:
> -            obuf[0] = d->handler;
> -            obuf[1] = d->devaddr;
> -            olen = 2;
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
> -    KBDState *s = (KBDState *)dev;
> -    int qcode, keycode;
> -
> -    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
> -    if (qcode >= ARRAY_SIZE(qcode_to_adb_keycode)) {
> -        return;
> -    }
> -    /* FIXME: take handler into account when translating qcode */
> -    keycode = qcode_to_adb_keycode[qcode];
> -    if (keycode == NO_KEY) {  /* We don't want to send this to the guest */
> -        ADB_DPRINTF("Ignoring NO_KEY\n");
> -        return;
> -    }
> -    if (evt->u.key.data->down == false) { /* if key release event */
> -        keycode = keycode | 0x80;   /* create keyboard break code */
> -    }
> -
> -    adb_kbd_put_keycode(s, keycode);
> -}
> -
> -static const VMStateDescription vmstate_adb_kbd = {
> -    .name = "adb_kbd",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_STRUCT(parent_obj, KBDState, 0, vmstate_adb_device, ADBDevice),
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
> -    ADBDevice *d = ADB_DEVICE(dev);
> -    KBDState *s = ADB_KEYBOARD(dev);
> -
> -    d->handler = 1;
> -    d->devaddr = ADB_DEVID_KEYBOARD;
> -    memset(s->data, 0, sizeof(s->data));
> -    s->rptr = 0;
> -    s->wptr = 0;
> -    s->count = 0;
> -}
> -
> -static QemuInputHandler adb_keyboard_handler = {
> -    .name  = "QEMU ADB Keyboard",
> -    .mask  = INPUT_EVENT_MASK_KEY,
> -    .event = adb_keyboard_event,
> -};
> -
> -static void adb_kbd_realizefn(DeviceState *dev, Error **errp)
> -{
> -    ADBKeyboardClass *akc = ADB_KEYBOARD_GET_CLASS(dev);
> -    akc->parent_realize(dev, errp);
> -    qemu_input_handler_register(dev, &adb_keyboard_handler);
> -}
> -
> -static void adb_kbd_initfn(Object *obj)
> -{
> -    ADBDevice *d = ADB_DEVICE(obj);
> -
> -    d->devaddr = ADB_DEVID_KEYBOARD;
> -}
> -
> -static void adb_kbd_class_init(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(oc);
> -    ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
> -    ADBKeyboardClass *akc = ADB_KEYBOARD_CLASS(oc);
> -
> -    akc->parent_realize = dc->realize;
> -    dc->realize = adb_kbd_realizefn;
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -
> -    adc->devreq = adb_kbd_request;
> -    dc->reset = adb_kbd_reset;
> -    dc->vmsd = &vmstate_adb_kbd;
> -}
> -
> -static const TypeInfo adb_kbd_type_info = {
> -    .name = TYPE_ADB_KEYBOARD,
> -    .parent = TYPE_ADB_DEVICE,
> -    .instance_size = sizeof(KBDState),
> -    .instance_init = adb_kbd_initfn,
> -    .class_init = adb_kbd_class_init,
> -    .class_size = sizeof(ADBKeyboardClass),
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
> -                            int dx1, int dy1, int dz1, int buttons_state)
> -{
> -    MouseState *s = opaque;
> -
> -    s->dx += dx1;
> -    s->dy += dy1;
> -    s->dz += dz1;
> -    s->buttons_state = buttons_state;
> -}
> -
> -
> -static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
> -{
> -    MouseState *s = ADB_MOUSE(d);
> -    int dx, dy;
> -
> -    if (s->last_buttons_state == s->buttons_state &&
> -        s->dx == 0 && s->dy == 0)
> -        return 0;
> -
> -    dx = s->dx;
> -    if (dx < -63)
> -        dx = -63;
> -    else if (dx > 63)
> -        dx = 63;
> -
> -    dy = s->dy;
> -    if (dy < -63)
> -        dy = -63;
> -    else if (dy > 63)
> -        dy = 63;
> -
> -    s->dx -= dx;
> -    s->dy -= dy;
> -    s->last_buttons_state = s->buttons_state;
> -
> -    dx &= 0x7f;
> -    dy &= 0x7f;
> -
> -    if (!(s->buttons_state & MOUSE_EVENT_LBUTTON))
> -        dy |= 0x80;
> -    if (!(s->buttons_state & MOUSE_EVENT_RBUTTON))
> -        dx |= 0x80;
> -
> -    obuf[0] = dy;
> -    obuf[1] = dx;
> -    return 2;
> -}
> -
> -static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
> -                             const uint8_t *buf, int len)
> -{
> -    MouseState *s = ADB_MOUSE(d);
> -    int cmd, reg, olen;
> -
> -    if ((buf[0] & 0x0f) == ADB_FLUSH) {
> -        /* flush mouse fifo */
> -        s->buttons_state = s->last_buttons_state;
> -        s->dx = 0;
> -        s->dy = 0;
> -        s->dz = 0;
> -        return 0;
> -    }
> -
> -    cmd = buf[0] & 0xc;
> -    reg = buf[0] & 0x3;
> -    olen = 0;
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
> -                d->devaddr = buf[1] & 0xf;
> -                break;
> -            default:
> -                d->devaddr = buf[1] & 0xf;
> -                /* we support handlers:
> -                 * 0x01: Classic Apple Mouse Protocol / 100 cpi operations
> -                 * 0x02: Classic Apple Mouse Protocol / 200 cpi operations
> -                 * we don't support handlers (at least):
> -                 * 0x03: Mouse systems A3 trackball
> -                 * 0x04: Extended Apple Mouse Protocol
> -                 * 0x2f: Microspeed mouse
> -                 * 0x42: Macally
> -                 * 0x5f: Microspeed mouse
> -                 * 0x66: Microspeed mouse
> -                 */
> -                if (buf[2] == 1 || buf[2] == 2) {
> -                    d->handler = buf[2];
> -                }
> -                break;
> -            }
> -        }
> -        break;
> -    case ADB_READREG:
> -        switch(reg) {
> -        case 0:
> -            olen = adb_mouse_poll(d, obuf);
> -            break;
> -        case 1:
> -            break;
> -        case 3:
> -            obuf[0] = d->handler;
> -            obuf[1] = d->devaddr;
> -            olen = 2;
> -            break;
> -        }
> -        ADB_DPRINTF("read reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x\n", reg,
> -                    obuf[0], obuf[1]);
> -        break;
> -    }
> -    return olen;
> -}
> -
> -static void adb_mouse_reset(DeviceState *dev)
> -{
> -    ADBDevice *d = ADB_DEVICE(dev);
> -    MouseState *s = ADB_MOUSE(dev);
> -
> -    d->handler = 2;
> -    d->devaddr = ADB_DEVID_MOUSE;
> -    s->last_buttons_state = s->buttons_state = 0;
> -    s->dx = s->dy = s->dz = 0;
> -}
> -
> -static const VMStateDescription vmstate_adb_mouse = {
> -    .name = "adb_mouse",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .fields = (VMStateField[]) {
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
> -    MouseState *s = ADB_MOUSE(dev);
> -    ADBMouseClass *amc = ADB_MOUSE_GET_CLASS(dev);
> -
> -    amc->parent_realize(dev, errp);
> -
> -    qemu_add_mouse_event_handler(adb_mouse_event, s, 0, "QEMU ADB Mouse");
> -}
> -
> -static void adb_mouse_initfn(Object *obj)
> -{
> -    ADBDevice *d = ADB_DEVICE(obj);
> -
> -    d->devaddr = ADB_DEVID_MOUSE;
> -}
> -
> -static void adb_mouse_class_init(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(oc);
> -    ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
> -    ADBMouseClass *amc = ADB_MOUSE_CLASS(oc);
> -
> -    amc->parent_realize = dc->realize;
> -    dc->realize = adb_mouse_realizefn;
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -
> -    adc->devreq = adb_mouse_request;
> -    dc->reset = adb_mouse_reset;
> -    dc->vmsd = &vmstate_adb_mouse;
> -}
> -
> -static const TypeInfo adb_mouse_type_info = {
> -    .name = TYPE_ADB_MOUSE,
> -    .parent = TYPE_ADB_DEVICE,
> -    .instance_size = sizeof(MouseState),
> -    .instance_init = adb_mouse_initfn,
> -    .class_init = adb_mouse_class_init,
> -    .class_size = sizeof(ADBMouseClass),
> -};
> -
> -
>   static void adb_register_types(void)
>   {
>       type_register_static(&adb_bus_type_info);
>       type_register_static(&adb_device_type_info);
> -    type_register_static(&adb_kbd_type_info);
> -    type_register_static(&adb_mouse_type_info);
>   }
>   
>   type_init(adb_register_types)
> diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
> index 3ae8445e95..df21b51117 100644
> --- a/include/hw/input/adb.h
> +++ b/include/hw/input/adb.h
> @@ -33,6 +33,30 @@
>   #define ADB_MAX_OUT_LEN 16
>   
>   typedef struct ADBBusState ADBBusState;
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
>   typedef struct ADBDevice ADBDevice;
>   
>   /* buf = NULL means polling */
> @@ -77,6 +101,8 @@ struct ADBBusState {
>       int poll_index;
>   };
>   
> +extern const VMStateDescription vmstate_adb_device;
> +
>   int adb_request(ADBBusState *s, uint8_t *buf_out,
>                   const uint8_t *buf, int len);
>   int adb_poll(ADBBusState *s, uint8_t *buf_out, uint16_t poll_mask);
> 

This is definitely a welcome refactoring! My only comment is that I'd 
like to keep the ADB_DPRINTF() (or convert to tracepoints) because some 
versions of MacOS 9 do strange things to the ADB bus which means that 
these are sadly still required :/


ATB,

Mark.
