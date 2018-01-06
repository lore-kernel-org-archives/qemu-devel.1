Received: from eggs.gnu.org ([2001:4830:134:3::10]:49984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXeCf-0003VY-IV
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXeCe-0001yX-AJ
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:27:21 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103162400.10396-7-f4bug@amsat.org>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-7-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 5 Jan 2018 18:26:44 -0800
Message-ID: <CAKmqyKPkSe-F_Q0hC_L7LWgu9qmEFj+t8Pwix1+bSCRcLv-BPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/sd: move sdcard legacy API to
 "hw/sd/sdcard_legacy.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Stefan Weil <sw@weilnetz.de>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 8:24 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> roughly 2 users left.

Exciting!

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair


>
>  include/hw/sd/sd.h            | 17 ---------------
>  include/hw/sd/sdcard_legacy.h | 51 +++++++++++++++++++++++++++++++++++++=
++++++
>  hw/sd/omap_mmc.c              |  2 +-
>  hw/sd/pl181.c                 |  1 +
>  hw/sd/sd.c                    |  1 +
>  5 files changed, 54 insertions(+), 18 deletions(-)
>  create mode 100644 include/hw/sd/sdcard_legacy.h
>
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index 96caefe373..a342e7bc3e 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -114,23 +114,6 @@ typedef struct {
>      void (*set_readonly)(DeviceState *dev, bool readonly);
>  } SDBusClass;
>
> -/* Legacy functions to be used only by non-qdevified callers */
> -SDState *sd_init(BlockBackend *bs, bool is_spi);
> -int sd_do_command(SDState *sd, SDRequest *req,
> -                  uint8_t *response);
> -void sd_write_data(SDState *sd, uint8_t value);
> -uint8_t sd_read_data(SDState *sd);
> -void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert);
> -bool sd_data_ready(SDState *sd);
> -/* sd_enable should not be used -- it is only used on the nseries boards=
,
> - * where it is part of a broken implementation of the MMC card slot swit=
ch
> - * (there should be two card slots which are multiplexed to a single MMC
> - * controller, but instead we model it with one card and controller and
> - * disable the card when the second slot is selected, so it looks like t=
he
> - * second slot is always empty).
> - */
> -void sd_enable(SDState *sd, bool enable);
> -
>  /* Functions to be used by qdevified callers (working via
>   * an SDBus rather than directly with SDState)
>   */
> diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.=
h
> new file mode 100644
> index 0000000000..882e13a8f1
> --- /dev/null
> +++ b/include/hw/sd/sdcard_legacy.h
> @@ -0,0 +1,51 @@
> +/*
> + * SD Memory Card emulation (deprecated legacy API)
> + *
> + * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in
> + *    the documentation and/or other materials provided with the
> + *    distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS''
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> + * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> + * PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR
> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
> + * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> + * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
> + * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
> + * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +#ifndef HW_SDCARD_LEGACY_H
> +#define HW_SDCARD_LEGACY_H
> +
> +#include "hw/sd/sd.h"
> +
> +/* Legacy functions to be used only by non-qdevified callers */
> +SDState *sd_init(BlockBackend *blk, bool is_spi);
> +int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
> +void sd_write_data(SDState *card, uint8_t value);
> +uint8_t sd_read_data(SDState *card);
> +void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
> +bool sd_data_ready(SDState *card);
> +
> +/* sd_enable should not be used -- it is only used on the nseries boards=
,
> + * where it is part of a broken implementation of the MMC card slot swit=
ch
> + * (there should be two card slots which are multiplexed to a single MMC
> + * controller, but instead we model it with one card and controller and
> + * disable the card when the second slot is selected, so it looks like t=
he
> + * second slot is always empty).
> + */
> +void sd_enable(SDState *card, bool enable);
> +
> +#endif /* HW_SDCARD_LEGACY_H */
> diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
> index e934cd3656..9cfdc7a6ad 100644
> --- a/hw/sd/omap_mmc.c
> +++ b/hw/sd/omap_mmc.c
> @@ -19,7 +19,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "hw/arm/omap.h"
> -#include "hw/sd/sd.h"
> +#include "hw/sd/sdcard_legacy.h"
>
>  struct omap_mmc_s {
>      qemu_irq irq;
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index ce696c5d7d..7591d016cd 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -12,6 +12,7 @@
>  #include "sysemu/blockdev.h"
>  #include "hw/sysbus.h"
>  #include "hw/sd/sd.h"
> +#include "hw/sd/sdcard_legacy.h"
>  #include "qemu/log.h"
>  #include "qapi/error.h"
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 35347a5bbc..7755bedfa0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -34,6 +34,7 @@
>  #include "hw/hw.h"
>  #include "sysemu/block-backend.h"
>  #include "hw/sd/sd.h"
> +#include "hw/sd/sdcard_legacy.h"
>  #include "qapi/error.h"
>  #include "qemu/bitmap.h"
>  #include "hw/qdev-properties.h"
> --
> 2.15.1
>
>
