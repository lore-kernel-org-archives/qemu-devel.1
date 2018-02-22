Received: from eggs.gnu.org ([2001:4830:134:3::10]:54046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eouRG-0001R9-Ln
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eouRF-0008B1-AJ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:13:46 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:43793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eouRF-0008AK-47
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:13:45 -0500
Received: by mail-ot0-x231.google.com with SMTP id q12so5263517otg.10
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 09:13:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180219040342.12686-4-mdavidsaver@gmail.com>
References: <20180219040342.12686-1-mdavidsaver@gmail.com>
	<20180219040342.12686-4-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 17:13:23 +0000
Message-ID: <CAFEAcA88Uq3VYBnpkME_63ezTVt9irj-J0nGUMwMb5HP9L6J2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/5] timer: generalize Dallas/Maxim RTC i2c
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Paul Brook <paul@codesourcery.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 19 February 2018 at 04:03, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> Support for: ds1307, ds1337, ds1338, ds1339,
> ds1340, ds1375, ds1388, and ds3231.
>
> Tested with ds1338 and ds1375.
>
> The existing ds1338 model has two bugs
> with almost no practical impact.
>
> 1. Trying to set time in 12-hour mode works,
> but the 12 hour mode bit isn't stored.
> So time always reads in 24 hour mode.
>
> 2. wday_offset is always stored for the
> local time zone.  When the RTC is set
> and rtc_utc=1 and the local timezone
> has a different day than UTC, then
> wday_offset will be off by one.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  default-configs/arm-softmmu.mak |   2 +-
>  hw/timer/Makefile.objs          |   2 +-
>  hw/timer/ds-rtc-i2c.c           | 466 ++++++++++++++++++++++++++++++++++++++++
>  hw/timer/ds1338.c               | 248 ---------------------

This patch is really hard for me to read because it's
basically "throw away the old file and implement a new one".
Can you split it up a bit please? I'd recommend starting with
"just a plain file rename" and then piecemeal changes of
behaviour. Then it's easy to see what has been changed.


> --- /dev/null
> +++ b/hw/timer/ds-rtc-i2c.c
> @@ -0,0 +1,466 @@
> +/* Emulation of various Dallas/Maxim RTCs accessed via I2C bus
> + *
> + * Copyright (c) 2017 Michael Davidsaver
> + * Copyright (c) 2009 CodeSourcery
> + *
> + * Authors: Michael Davidsaver
> + *          Paul Brook
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.

This has lost the "contributions after 2012 are GPL-2-or-later"
part of the licensing information.

> +#ifdef DEBUG_DSRTC
> +#define DPRINTK(FMT, ...) info_report(TYPE_DSRTC " : " FMT, ## __VA_ARGS__)
> +#else
> +#define DPRINTK(FMT, ...) do {} while (0)
> +#endif

If we're overhauling the device it might be nice to convert it
to tracepoints, but I don't insist on that.

> +#define TYPE_DSRTC "ds-rtc-i2c"
> +#define DSRTC(obj) OBJECT_CHECK(DSRTCState, (obj), TYPE_DSRTC)
> +#define DSRTC_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(DSRTCClass, obj, TYPE_DSRTC)
> +#define DSRTC_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(DSRTCClass, klass, TYPE_DSRTC)
> +
> +static const VMStateDescription vmstate_dsrtc = {
> +    .name = TYPE_DSRTC,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(parent_obj, DSRTCState),
> +        VMSTATE_INT64(time_offset, DSRTCState),
> +        VMSTATE_INT8_V(wday_offset, DSRTCState, 2),
> +        VMSTATE_UINT8_ARRAY(regs, DSRTCState, DSRTC_REGSIZE),
> +        VMSTATE_UINT8(addr, DSRTCState),
> +        VMSTATE_BOOL(addrd, DSRTCState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

Changing the VMState name and fields will break cross-version
migration from old QEMU versions of all the boards which use a
DS1338. I'd strongly prefer to avoid that. There are ways to
do that, like subsections and pre/post-load functions, but a
big part of it is not changing fields if you don't really need to.

> +
> +static void dsrtc_reset(DeviceState *device);
> +
> +/* update current time registers */
> +static

Can you not put newlines after the 'static' keyword, please?

> +void dsrtc_latch(DSRTCState *ds)
> +{


thanks
-- PMM
