Received: from eggs.gnu.org ([2001:4830:134:3::10]:38161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnoQo-0004p5-In
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnoQn-0006t4-D6
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:09:02 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fnoQn-0006sZ-3I
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:09:01 -0400
Received: by mail-wm0-x242.google.com with SMTP id t25-v6so1005912wmi.3
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 10:09:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-8-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-8-contrib@steffen-goertz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Aug 2018 18:08:59 +0100
Message-ID: <CAJSP0QWvmCaWiCGphnS90+-7mQ5rqc804LFzRUaT=Ae=y_pj_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] hw/display/led_matrix: Add LED matrix
 display device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Aug 6, 2018 at 11:01 AM, Steffen G=C3=B6rtz
<contrib@steffen-goertz.de> wrote:
> +static void led_timer_expire(void *opaque)
> +{
> +    LEDMatrixState *s =3D LED_MATRIX(opaque);
> +/*
> +    uint8_t divider =3D s->strobe_row ? s->nrows : s->ncols;
> +    int64_t max_on =3D (s->refresh_period * 1000) / divider;
> +*/

Please remove dead code.

> +
> +    update_on_times(s);
> +
> +    memcpy(s->led_frame_dc, s->led_working_dc,
> +           sizeof(int64_t) * s->nrows * s->ncols);
> +    memset(s->led_working_dc, 0x00, sizeof(int64_t) * s->nrows * s->ncol=
s);
> +
> +    timer_mod(&s->timer,
> +            qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->refresh_period);
> +    s->redraw =3D true;
> +}

Have you considered an approach based on the access pattern rather
than a timer (sampling)?

Sampling-based approaches are more CPU intensive and may result in
artifacts if the guest doesn't update pins at exactly the refresh
rate.

The access pattern approach assumes that the rows/columns are scanned
in a certain way.  It uses the guest's pin accesses as the event for
checking the matrix state.  It's more efficient, doesn't suffer from
sampling artifacts, but requires knowledge of how rows/columns are
scanned.

> +static void draw_pixel(DisplaySurface *ds, int x, int y, uint32_t color)
> +{
> +    int bpp;
> +    uint8_t *d;
> +    bpp =3D (surface_bits_per_pixel(ds) + 7) >> 3;
> +    d =3D surface_data(ds) + surface_stride(ds) * y + bpp * x;
> +    switch (bpp) {
> +    case 1:
> +        *((uint8_t *) d) =3D color;
> +        d++;
> +        break;
> +    case 2:
> +        *((uint16_t *) d) =3D color;
> +        d +=3D 2;
> +        break;
> +    case 4:
> +        *((uint32_t *) d) =3D color;
> +        d +=3D 4;
> +        break;
> +    }

There is no need to increment d.

> +    for (x =3D 0; x < s->nrows ; x++) {
> +        for (y =3D 0; y < s->ncols; y++) {
> +            idx =3D x * s->ncols + y;

I'm confused by the naming here.  "rows" is height/vertical/y.
"columns" is width/horizontal/x.  Why is "x" used for vertical and "y"
for horizontal?

> +            red =3D (s->led_frame_dc[idx] * 0xFF) / (s->refresh_period *=
 1000);
> +            color_led =3D colorfunc(red, 0x00, 0x00);
> +
> +            draw_box(surface, idx * 10, 0, 5, 10, color_led);

Are the LEDs layed out horizontally?  The y coordinate is hardcoded to
0.  I thought this would be a 2D LED matrix.

> +static void led_matrix_unrealize(DeviceState *dev, Error **errp)
> +{
> +    LEDMatrixState *s =3D LED_MATRIX(dev);
> +
> +    g_free(s->led_working_dc);
> +    s->led_working_dc =3D NULL;

led_frame_dc is leaked.

graphic_console_close() is missing.

> diff --git a/include/hw/display/led_matrix.h b/include/hw/display/led_mat=
rix.h
> new file mode 100644
> index 0000000000..4a43b69f5b
> --- /dev/null
> +++ b/include/hw/display/led_matrix.h
> @@ -0,0 +1,38 @@
> +/*
> + * LED Matrix Demultiplexer
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +#ifndef LED_MATRIX_H
> +#define LED_MATRIX_H
> +
> +#include "hw/sysbus.h"
> +#include "qemu/timer.h"
> +#define TYPE_LED_MATRIX "led_matrix"
> +#define LED_MATRIX(obj) OBJECT_CHECK(LEDMatrixState, (obj), TYPE_LED_MAT=
RIX)
> +
> +typedef struct LEDMatrixState {

There is too little documentation here for a generic device that could
be reused by other boards.  Please describe the purpose and
functionality of this device.
