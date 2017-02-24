Received: from eggs.gnu.org ([2001:4830:134:3::10]:43094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGrb-0004qu-Lo
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGra-0004ma-Jh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:28:51 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chGra-0004m9-BC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:28:50 -0500
Received: by mail-wm0-x233.google.com with SMTP id v77so15730064wmv.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:28:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <84d7cdceac575c23bd4ee4bdcb80a03966b96db8.1487522123.git.balaton@eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<84d7cdceac575c23bd4ee4bdcb80a03966b96db8.1487522123.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 14:28:28 +0000
Message-ID: <CAFEAcA9oWpaG98KT+zSBE11-vzs-Cs6bgBT_VGQVvm4RVUO7pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 02/10] sm501: Use defines instead of
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

On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
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

s->misc_control was set to 0x1000, but is now set to
SM501_MISC_IRQ_INVERT, which is (1 << 16), which is not the
same value... 0x1000 would be SM501_MISC_DAC_POWER.

thanks
-- PMM
