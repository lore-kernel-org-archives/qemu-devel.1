Received: from eggs.gnu.org ([2001:4830:134:3::10]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSP3R-0005mL-WB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSP3R-0005o8-2E
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:48:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601141223.26630-1-peter.maydell@linaro.org>
	<20180601141223.26630-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1139a021-63e7-e25e-be5d-c8278db8f2b7@amsat.org>
Date: Mon, 11 Jun 2018 12:48:15 -0300
MIME-Version: 1.0
In-Reply-To: <20180601141223.26630-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] hw/watchdog/wdt_i6300esb: Convert away
 from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <huth@tuxfamily.org>, patches@linaro.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 06/01/2018 11:12 AM, Peter Maydell wrote:
> Convert the wdt_i6300esb device away from using the old_mmio field
> of MemoryRegionOps.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/watchdog/wdt_i6300esb.c | 48 ++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
> index e596b0804d..7b59469888 100644
> --- a/hw/watchdog/wdt_i6300esb.c
> +++ b/hw/watchdog/wdt_i6300esb.c
> @@ -361,19 +361,43 @@ static void i6300esb_mem_writel(void *vp, hwaddr addr, uint32_t val)
>      }
>  }
>  
> +static uint64_t i6300esb_mem_readfn(void *opaque, hwaddr addr, unsigned size)
> +{
> +    switch (size) {
> +    case 1:
> +        return i6300esb_mem_readb(opaque, addr);
> +    case 2:
> +        return i6300esb_mem_readw(opaque, addr);
> +    case 4:
> +        return i6300esb_mem_readl(opaque, addr);
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void i6300esb_mem_writefn(void *opaque, hwaddr addr,
> +                                 uint64_t value, unsigned size)
> +{
> +    switch (size) {
> +    case 1:
> +        i6300esb_mem_writeb(opaque, addr, value);
> +        break;
> +    case 2:
> +        i6300esb_mem_writew(opaque, addr, value);
> +        break;
> +    case 4:
> +        i6300esb_mem_writel(opaque, addr, value);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  static const MemoryRegionOps i6300esb_ops = {
> -    .old_mmio = {
> -        .read = {
> -            i6300esb_mem_readb,
> -            i6300esb_mem_readw,
> -            i6300esb_mem_readl,
> -        },
> -        .write = {
> -            i6300esb_mem_writeb,
> -            i6300esb_mem_writew,
> -            i6300esb_mem_writel,
> -        },
> -    },
> +    .read = i6300esb_mem_readfn,
> +    .write = i6300esb_mem_writefn,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> 
