Received: from eggs.gnu.org ([2001:4830:134:3::10]:48530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYraD-00088K-NG
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYra9-00008M-Sv
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:52:09 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:35177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cYra9-00007y-Le
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:52:05 -0500
Received: by mail-yw0-x241.google.com with SMTP id l16so10079624ywb.2
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 01:52:05 -0800 (PST)
MIME-Version: 1.0
References: <1485940779-24225-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485940779-24225-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 01 Feb 2017 09:51:53 +0000
Message-ID: <CAJ+F1CJUciyf2KON6nqSHiW6Zba2wr5O7S2V+_ygCGoh+6ST0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] Add wctablet device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anatoli Huseu1 <avg.tolik@gmail.com>

Hi

On Wed, Feb 1, 2017 at 1:21 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> From: Anatoli Huseu1 <avg.tolik@gmail.com>
>
> Add QEMU Wacom Penpartner serial tablet emulation.
> GSoC 2016 project.
>
> Signed-off-by: Anatoli Huseu1 <avg.tolik@gmail.com>
>
> Various cleanups.
> Add line speed tracking.
> Implement ST and SP commands.
> Adapted to chardev QOMification.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  Makefile.objs            |   1 +
>  backends/Makefile.objs   |   2 +-
>  backends/trace-events    |  10 ++
>  backends/wctablet.c      | 374
> +++++++++++++++++++++++++++++++++++++++++++++++
>  docs/qdev-device-use.txt |   2 +-
>  qapi-schema.json         |   3 +-
>  qemu-char.c              |   1 +
>  7 files changed, 390 insertions(+), 3 deletions(-)
>  create mode 100644 backends/trace-events
>  create mode 100644 backends/wctablet.c
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 01cef86..5ac7f34 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -124,6 +124,7 @@ trace-events-y +=3D crypto/trace-events
>  trace-events-y +=3D io/trace-events
>  trace-events-y +=3D migration/trace-events
>  trace-events-y +=3D block/trace-events
> +trace-events-y +=3D backends/trace-events
>  trace-events-y +=3D hw/block/trace-events
>  trace-events-y +=3D hw/char/trace-events
>  trace-events-y +=3D hw/intc/trace-events
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 1846998..0e0f156 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -1,7 +1,7 @@
>  common-obj-y +=3D rng.o rng-egd.o
>  common-obj-$(CONFIG_POSIX) +=3D rng-random.o
>
> -common-obj-y +=3D msmouse.o testdev.o
> +common-obj-y +=3D msmouse.o wctablet.o testdev.o
>  common-obj-$(CONFIG_BRLAPI) +=3D baum.o
>  baum.o-cflags :=3D $(SDL_CFLAGS)
>
> diff --git a/backends/trace-events b/backends/trace-events
> new file mode 100644
> index 0000000..8c3289a
> --- /dev/null
> +++ b/backends/trace-events
> @@ -0,0 +1,10 @@
> +# See docs/tracing.txt for syntax documentation.
> +
> +# backends/wctablet.c
> +wct_init(void) ""
> +wct_cmd_re(void) ""
> +wct_cmd_st(void) ""
> +wct_cmd_sp(void) ""
> +wct_cmd_ts(int input) "0x%02x"
> +wct_cmd_other(const char *cmd) "%s"
> +wct_speed(int speed) "%d"
> diff --git a/backends/wctablet.c b/backends/wctablet.c
> new file mode 100644
> index 0000000..7668254
> --- /dev/null
> +++ b/backends/wctablet.c
> @@ -0,0 +1,374 @@
> +/*
> + * QEMU Wacom Penpartner serial tablet emulation
> + *
> + * some protocol details:
> + *   http://linuxwacom.sourceforge.net/wiki/index.php/Serial_Protocol_IV
> + *
> + * Copyright (c) 2016 Anatoli Huseu1
> + * Copyright (c) 2016,17 Gerd Hoffmann
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining
> a copy
> + * of this software and associated documentation files (the "Software"),
> to
> + * deal in the Software without restriction, including without limitatio=
n
> + * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S
> IN
> + * THE SOFTWARE.
> + */
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/time.h>
> +#include <time.h>
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "sysemu/char.h"
> +#include "ui/console.h"
> +#include "ui/input.h"
> +#include "trace.h"
> +
> +
> +#define WC_OUTPUT_BUF_MAX_LEN 512
> +#define WC_COMMAND_MAX_LEN 60
> +
> +#define WC_L7(n) ((n) & 127)
> +#define WC_M7(n) (((n) >> 7) & 127)
> +#define WC_H2(n) ((n) >> 14)
> +
> +#define WC_L4(n) ((n) & 15)
> +#define WC_H4(n) (((n) >> 4) & 15)
> +
> +/* Model string and config string */
> +#define WC_MODEL_STRING_LENGTH 18
> +uint8_t WC_MODEL_STRING[WC_MODEL_STRING_LENGTH + 1] =3D
> "~#CT-0045R,V1.3-5,";
> +
> +#define WC_CONFIG_STRING_LENGTH 8
> +uint8_t WC_CONFIG_STRING[WC_CONFIG_STRING_LENGTH + 1] =3D "96,N,8,0";
> +
> +#define WC_FULL_CONFIG_STRING_LENGTH 61
> +uint8_t WC_FULL_CONFIG_STRING[WC_FULL_CONFIG_STRING_LENGTH + 1] =3D {
> +    0x5c, 0x39, 0x36, 0x2c, 0x4e, 0x2c, 0x38, 0x2c,
> +    0x31, 0x28, 0x01, 0x24, 0x57, 0x41, 0x43, 0x30,
> +    0x30, 0x34, 0x35, 0x5c, 0x5c, 0x50, 0x45, 0x4e, 0x5c,
> +    0x57, 0x41, 0x43, 0x30, 0x30, 0x30, 0x30, 0x5c,
> +    0x54, 0x61, 0x62, 0x6c, 0x65, 0x74, 0x0d, 0x0a,
> +    0x43, 0x54, 0x2d, 0x30, 0x30, 0x34, 0x35, 0x52,
> +    0x2c, 0x56, 0x31, 0x2e, 0x33, 0x2d, 0x35, 0x0d,
> +    0x0a, 0x45, 0x37, 0x29
> +};
> +
> +/* This structure is used to save private info for Wacom Tablet. */
> +typedef struct {
> +    Chardev parent;
> +    QemuInputHandlerState *hs;
> +
> +    /* Query string from serial */
> +    uint8_t query[100];
> +    int query_index;
> +
> +    /* Command to be sent to serial port */
> +    uint8_t outbuf[WC_OUTPUT_BUF_MAX_LEN];
> +    int outlen;
> +
> +    int line_speed;
> +    bool send_events;
> +    int axis[INPUT_AXIS__MAX];
> +    bool btns[INPUT_BUTTON__MAX];
> +
> +} TabletChardev;
> +
> +#define TYPE_CHARDEV_WCTABLET "chardev-wctablet"
> +#define WCTABLET_CHARDEV(obj)                                      \
> +    OBJECT_CHECK(TabletChardev, (obj), TYPE_CHARDEV_WCTABLET)
> +
> +
> +static void wctablet_chr_accept_input(Chardev *chr);
> +
> +static void wctablet_shift_input(TabletChardev *tablet, int count)
> +{
> +    tablet->query_index -=3D count;
> +    memmove(tablet->query, tablet->query + count, tablet->query_index);
> +    tablet->query[tablet->query_index] =3D 0;
> +}
> +
> +static void wctablet_queue_output(TabletChardev *tablet, uint8_t *buf,
> int count)
> +{
> +    if (tablet->outlen + count > sizeof(tablet->outbuf)) {
> +        return;
> +    }
> +
> +    memcpy(tablet->outbuf + tablet->outlen, buf, count);
> +    tablet->outlen +=3D count;
> +    wctablet_chr_accept_input(CHARDEV(tablet));
> +}
> +
> +static void wctablet_reset(TabletChardev *tablet)
> +{
> +    /* clear buffers */
> +    tablet->query_index =3D 0;
> +    tablet->outlen =3D 0;
> +    /* reset state */
> +    tablet->send_events =3D false;
> +}
> +
> +static void wctablet_queue_event(TabletChardev *tablet)
> +{
> +    uint8_t codes[8] =3D { 0xe0, 0, 0, 0, 0, 0, 0 };
> +
> +    if (tablet->line_speed !=3D 9600) {
> +        return;
> +    }
> +
> +    int newX =3D tablet->axis[INPUT_AXIS_X] * 0.1537;
> +    int nexY =3D tablet->axis[INPUT_AXIS_Y] * 0.1152;
> +
> +    codes[0] =3D codes[0] | WC_H2(newX);
> +    codes[1] =3D codes[1] | WC_M7(newX);
> +    codes[2] =3D codes[2] | WC_L7(newX);
> +
> +    codes[3] =3D codes[3] | WC_H2(nexY);
> +    codes[4] =3D codes[4] | WC_M7(nexY);
> +    codes[5] =3D codes[5] | WC_L7(nexY);
> +
> +    if (tablet->btns[INPUT_BUTTON_LEFT]) {
> +        codes[0] =3D 0xa0;
> +    }
> +
> +    wctablet_queue_output(tablet, codes, 7);
> +}
> +
> +static void wctablet_input_event(DeviceState *dev, QemuConsole *src,
> +                                InputEvent *evt)
> +{
> +    TabletChardev *tablet =3D (TabletChardev *)dev;
> +    InputMoveEvent *move;
> +    InputBtnEvent *btn;
> +
> +    switch (evt->type) {
> +    case INPUT_EVENT_KIND_ABS:
> +        move =3D evt->u.abs.data;
> +        tablet->axis[move->axis] =3D move->value;
> +        break;
> +
> +    case INPUT_EVENT_KIND_BTN:
> +        btn =3D evt->u.btn.data;
> +        tablet->btns[btn->button] =3D btn->down;
> +        break;
> +
> +    default:
> +        /* keep gcc happy */
> +        break;
> +    }
> +}
> +
> +static void wctablet_input_sync(DeviceState *dev)
> +{
> +    TabletChardev *tablet =3D (TabletChardev *)dev;
> +
> +    if (tablet->send_events) {
> +        wctablet_queue_event(tablet);
> +    }
> +}
> +
> +static QemuInputHandler wctablet_handler =3D {
> +    .name  =3D "QEMU Wacome Pen Tablet",
> +    .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
> +    .event =3D wctablet_input_event,
> +    .sync  =3D wctablet_input_sync,
> +};
> +
> +static void wctablet_chr_accept_input(Chardev *chr)
> +{
> +    TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);
> +    int len, canWrite;
> +
> +    canWrite =3D qemu_chr_be_can_write(chr);
> +    len =3D canWrite;
> +    if (len > tablet->outlen) {
> +        len =3D tablet->outlen;
> +    }
> +
> +    if (len) {
> +        qemu_chr_be_write(chr, tablet->outbuf, len);
> +        tablet->outlen -=3D len;
> +        if (tablet->outlen) {
> +            memmove(tablet->outbuf, tablet->outbuf + len, tablet->outlen=
);
> +        }
> +    }
> +}
> +
> +static int wctablet_chr_write(struct Chardev *chr,
> +                              const uint8_t *buf, int len)
> +{
> +    TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);
> +    unsigned int i, clen;
> +    char *pos;
> +
> +    if (tablet->line_speed !=3D 9600) {
> +        return len;
> +    }
> +    for (i =3D 0; i < len && tablet->query_index < sizeof(tablet->query)=
 -
> 1; i++) {
> +        tablet->query[tablet->query_index++] =3D buf[i];
> +    }
> +    tablet->query[tablet->query_index] =3D 0;
> +
> +    while (tablet->query_index > 0 && (tablet->query[0] =3D=3D '@'  ||
> +                                       tablet->query[0] =3D=3D '\r' ||
> +                                       tablet->query[0] =3D=3D '\n')) {
> +        wctablet_shift_input(tablet, 1);
> +    }
> +    if (!tablet->query_index) {
> +        return len;
> +    }
> +
> +    if (strncmp((char *)tablet->query, "~#", 2) =3D=3D 0) {
> +        /* init / detect sequence */
> +        trace_wct_init();
> +        wctablet_shift_input(tablet, 2);
> +        wctablet_queue_output(tablet, WC_MODEL_STRING,
> +                              WC_MODEL_STRING_LENGTH);
> +        return len;
> +    }
> +
> +    /* detect line */
> +    pos =3D strchr((char *)tablet->query, '\r');
> +    if (!pos) {
> +        pos =3D strchr((char *)tablet->query, '\n');
> +    }
> +    if (!pos) {
> +        return len;
> +    }
> +    clen =3D pos - (char *)tablet->query;
> +
> +    /* process commands */
> +    if (strncmp((char *)tablet->query, "RE", 2) =3D=3D 0 &&
> +        clen =3D=3D 2) {
> +        trace_wct_cmd_re();
> +        wctablet_shift_input(tablet, 3);
> +        wctablet_queue_output(tablet, WC_CONFIG_STRING,
> +                              WC_CONFIG_STRING_LENGTH);
> +
> +    } else if (strncmp((char *)tablet->query, "ST", 2) =3D=3D 0 &&
> +               clen =3D=3D 2) {
> +        trace_wct_cmd_st();
> +        wctablet_shift_input(tablet, 3);
> +        tablet->send_events =3D true;
> +        wctablet_queue_event(tablet);
> +
> +    } else if (strncmp((char *)tablet->query, "SP", 2) =3D=3D 0 &&
> +               clen =3D=3D 2) {
> +        trace_wct_cmd_sp();
> +        wctablet_shift_input(tablet, 3);
> +        tablet->send_events =3D false;
> +
> +    } else if (strncmp((char *)tablet->query, "TS", 2) =3D=3D 0 &&
> +               clen =3D=3D 3) {
> +        unsigned int input =3D tablet->query[2];
> +        uint8_t codes[7] =3D {
> +            0xa3,
> +            ((input & 0x80) =3D=3D 0) ? 0x7e : 0x7f,
> +            (((WC_H4(input) & 0x7) ^ 0x5) << 4) | (WC_L4(input) ^ 0x7),
> +            0x03,
> +            0x7f,
> +            0x7f,
> +            0x00,
> +        };
> +        trace_wct_cmd_ts(input);
> +        wctablet_shift_input(tablet, 4);
> +        wctablet_queue_output(tablet, codes, 7);
> +
> +    } else {
> +        tablet->query[clen] =3D 0; /* terminate line for printing */
> +        trace_wct_cmd_other((char *)tablet->query);
> +        wctablet_shift_input(tablet, clen + 1);
> +
> +    }
> +
> +    return len;
> +}
> +
> +static int wctablet_chr_ioctl(Chardev *chr, int cmd, void *arg)
> +{
> +    TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);
> +    QEMUSerialSetParams *ssp;
> +
> +    switch (cmd) {
> +    case CHR_IOCTL_SERIAL_SET_PARAMS:
> +        ssp =3D arg;
> +        if (tablet->line_speed !=3D ssp->speed) {
> +            trace_wct_speed(ssp->speed);
> +            wctablet_reset(tablet);
> +            tablet->line_speed =3D ssp->speed;
> +        }
> +        break;
> +    default:
> +        return -ENOTSUP;
> +    }
> +    return 0;
> +}
> +
> +static void wctablet_chr_free(struct Chardev *chr)
> +{
> +    TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);
> +
> +    qemu_input_handler_unregister(tablet->hs);
> +    g_free(tablet);
> +}
> +
> +static void wctablet_chr_open(Chardev *chr,
> +                              ChardevBackend *backend,
> +                              bool *be_opened,
> +                              Error **errp)
> +{
> +    TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);
> +
> +    *be_opened =3D true;
> +
> +    /* init state machine */
> +    memcpy(tablet->outbuf, WC_FULL_CONFIG_STRING,
> WC_FULL_CONFIG_STRING_LENGTH);
> +    tablet->outlen =3D WC_FULL_CONFIG_STRING_LENGTH;
> +    tablet->query_index =3D 0;
> +
> +    tablet->hs =3D qemu_input_handler_register((DeviceState *)tablet,
> +                                             &wctablet_handler);
> +}
> +
> +static void wctablet_chr_class_init(ObjectClass *oc, void *data)
> +{
> +    ChardevClass *cc =3D CHARDEV_CLASS(oc);
> +
> +    cc->open =3D wctablet_chr_open;
> +    cc->chr_write =3D wctablet_chr_write;
> +    cc->chr_ioctl =3D wctablet_chr_ioctl;
> +    cc->chr_free =3D wctablet_chr_free;
>

chr_free is going away in the last pull request, you can replace it with
qom finalize.


> +    cc->chr_accept_input =3D wctablet_chr_accept_input;
> +}
> +
> +static const TypeInfo wctablet_type_info =3D {
> +    .name =3D TYPE_CHARDEV_WCTABLET,
> +    .parent =3D TYPE_CHARDEV,
> +    .instance_size =3D sizeof(TabletChardev),
> +    .class_init =3D wctablet_chr_class_init,
> +};
> +
> +static const CharDriver wctablet_char_driver =3D {
> +    .kind =3D CHARDEV_BACKEND_KIND_WCTABLET,
> +};
> +
> +static void register_types(void)
> +{
> +     register_char_driver(&wctablet_char_driver);
> +     type_register_static(&wctablet_type_info);
> +}
> +
> +type_init(register_types);
> diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
> index 136d271..b059405 100644
> --- a/docs/qdev-device-use.txt
> +++ b/docs/qdev-device-use.txt
> @@ -200,7 +200,7 @@ LEGACY-CHARDEV translates to -chardev HOST-OPTS... as
> follows:
>
>  * null becomes -chardev null
>
> -* pty, msmouse, braille, stdio likewise
> +* pty, msmouse, wctablet, braille, stdio likewise
>
>  * vc:WIDTHxHEIGHT becomes -chardev vc,width=3DWIDTH,height=3DHEIGHT
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 82fabc6..d2257ee 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4865,7 +4865,7 @@
>  #
>  # Configuration info for the new chardev backend.
>  #
> -# Since: 1.4 (testdev since 2.2)
> +# Since: 1.4 (testdev since 2.2, wctablet since 2.9)
>  ##
>  { 'union': 'ChardevBackend', 'data': { 'file'   : 'ChardevFile',
>                                         'serial' : 'ChardevHostdev',
> @@ -4877,6 +4877,7 @@
>                                         'null'   : 'ChardevCommon',
>                                         'mux'    : 'ChardevMux',
>                                         'msmouse': 'ChardevCommon',
> +                                       'wctablet' : 'ChardevCommon',
>                                         'braille': 'ChardevCommon',
>                                         'testdev': 'ChardevCommon',
>                                         'stdio'  : 'ChardevStdio',
> diff --git a/qemu-char.c b/qemu-char.c
> index 6b4a299..dfb11c4 100644
> --- a/qemu-char.c
> +++ b/qemu-char.c
> @@ -3698,6 +3698,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label,
> const char *filename)
>      if (strcmp(filename, "null")    =3D=3D 0 ||
>          strcmp(filename, "pty")     =3D=3D 0 ||
>          strcmp(filename, "msmouse") =3D=3D 0 ||
> +        strcmp(filename, "wctablet") =3D=3D 0 ||
>          strcmp(filename, "braille") =3D=3D 0 ||
>          strcmp(filename, "testdev") =3D=3D 0 ||
>          strcmp(filename, "stdio")   =3D=3D 0) {
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
