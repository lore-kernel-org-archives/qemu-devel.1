Received: from eggs.gnu.org ([2001:4830:134:3::10]:56222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eos5U-0007DB-Je
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eos5T-0004uT-Gr
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:43:08 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eos5T-0004tG-B2
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:43:07 -0500
Received: by mail-oi0-x244.google.com with SMTP id 123so1400535oig.5
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:43:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217140051.22731-2-linus.walleij@linaro.org>
References: <20180217140051.22731-1-linus.walleij@linaro.org>
	<20180217140051.22731-2-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:42:46 +0000
Message-ID: <CAFEAcA8QVBRLs1ZfgMP1nTUG4xQJRH9WrwxdXzrwAR8pZJJ4ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/3] hw/sii9022: Add support for
 Silicon Image SII9022
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 14:00, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds support for emulating the Silicon Image SII9022 DVI/HDMI
> bridge. It's not very clever right now, it just acknowledges
> the switch into DDC I2C mode and back. Combining this with the
> existing DDC I2C emulation gives the right behavior on the Versatile
> Express emulation passing through the QEMU EDID to the emulated
> platform.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  hw/display/Makefile.objs |   1 +
>  hw/display/sii9022.c     | 185 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+)
>  create mode 100644 hw/display/sii9022.c
>
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index d3a4cb396eb9..3c7c75b94da5 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -3,6 +3,7 @@ common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
>  common-obj-$(CONFIG_G364FB) += g364fb.o
>  common-obj-$(CONFIG_JAZZ_LED) += jazz_led.o
>  common-obj-$(CONFIG_PL110) += pl110.o
> +common-obj-$(CONFIG_SII9022) += sii9022.o
>  common-obj-$(CONFIG_SSD0303) += ssd0303.o
>  common-obj-$(CONFIG_SSD0323) += ssd0323.o
>  common-obj-$(CONFIG_XEN) += xenfb.o
> diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
> new file mode 100644
> index 000000000000..d6f3cdc04293
> --- /dev/null
> +++ b/hw/display/sii9022.c
> @@ -0,0 +1,185 @@
> +/*
> + * Silicon Image SiI9022
> + *
> + * This is a pretty hollow emulation: all we do is acknowledge that we
> + * exist (chip ID) and confirm that we get switched over into DDC mode
> + * so the emulated host can proceed to read out EDID data. All subsequent
> + * set-up of connectors etc will be acknowledged and ignored.
> + *
> + * Copyright (c) 2018 Linus Walleij

Sanity check: really copyright you and not Linaro ?

> + *
> + * This code is licensed under the GNU GPL v2.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.

If this is copyright 2018 then what parts of it are not covered by
the "contributions after 2012-01-13" condition? Could we just have
this be GPL-v2-or-later, which is what most new code is ?


> +static void sii9022_reset(DeviceState *dev)
> +{
> +    sii9022_state *s = SII9022(dev);
> +
> +    s->ptr = 0;
> +    s->addr_byte = false;

I think we should reset ddc/ddc_skip_finish/ddc_req
here too. I suspect the state machine logic means we
can't get to a place where their values are used once
we reset ptr and addr_byte, but it's easier to reason
about if we just reset all the device's state.

I agree with Philippe that we should use trace events here rather
than the DPRINTF macro. Otherwise the code looks fine.

thanks
-- PMM
