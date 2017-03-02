Received: from eggs.gnu.org ([2001:4830:134:3::10]:44008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjVqx-0006rV-3m
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjVqw-0000YZ-3A
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:53:27 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjVqv-0000XY-TL
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:53:26 -0500
Received: by mail-wr0-x22b.google.com with SMTP id u108so59161642wrb.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 10:53:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <65f979bc1683c46f74ddb5e931810f4e2b8ea27c.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<65f979bc1683c46f74ddb5e931810f4e2b8ea27c.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 18:53:04 +0000
Message-ID: <CAFEAcA8hgztzBZ=4EK7GR_1V4WnKL_hp-CopC1q5NwxeARkgSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 02/14] sm501: Use defines instead of
 constants where available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 7 November 2016 at 09:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> This also fixes the initial value of misc_control register to match the
> comment which is likely what was intended but the DAC_POWER bit was set
> instead. This value is unused so it does not really matter but is
> fixed here for consistency.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c          | 8 ++++----
>  hw/display/sm501_template.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 4f40dee..4eb085c 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -555,7 +555,7 @@ static uint32_t get_local_mem_size_index(uint32_t size)
>  static inline int is_hwc_enabled(SM501State *state, int crt)
>  {
>      uint32_t addr = crt ? state->dc_crt_hwc_addr : state->dc_panel_hwc_addr;
> -    return addr & 0x80000000;
> +    return addr & SM501_HWC_EN;
>  }
>
>  /**
> @@ -1411,9 +1411,9 @@ void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
>      s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
>      SM501_DPRINTF("local mem size=%x. index=%d\n", get_local_mem_size(s),
>                    s->local_mem_size_index);
> -    s->system_control = 0x00100000;
> -    s->misc_control = 0x00001000; /* assumes SH, active=low */
> -    s->dc_panel_control = 0x00010000;
> +    s->system_control = 0x00100000; /* 2D engine FIFO empty */
> +    s->misc_control = SM501_MISC_IRQ_INVERT; /* assumes SH, active=low */
> +    s->dc_panel_control = 0x00010000; /* FIFO level 3 */
>      s->dc_crt_control = 0x00010000;

I just found a datasheet which says that the power-on-default
for the misc-control register is 0b0000.0000.0000.00x0.0001.0000.xxx0.0xxx
which means that the 0x1000 decimal value is correct and setting
the IRQ_INVERT bit is wrong.

I think the "active=low" bit is referencing the fact that the
DAC_POWER bit is 1 for "disable" and 0 for "enable".

It makes sense hardware-wise for the DAC to be powered off by default
at reset as well I think.

thanks
-- PMM
