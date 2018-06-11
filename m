Received: from eggs.gnu.org ([2001:4830:134:3::10]:49472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSP2y-0005WW-S2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSP2y-0005fq-0Z
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:47:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601141223.26630-1-peter.maydell@linaro.org>
	<20180601141223.26630-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4ab36972-d612-7d2b-45a5-99cecef891a8@amsat.org>
Date: Mon, 11 Jun 2018 12:47:45 -0300
MIME-Version: 1.0
In-Reply-To: <20180601141223.26630-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] hw/sh/sh7750: Convert away from
 old_mmio
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
> Convert the sh7750 device away from using the old_mmio field
> of MemoryRegionOps. This device is used by the sh4 r2d board.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sh4/sh7750.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
> index 5a7d47d31e..b932f33409 100644
> --- a/hw/sh4/sh7750.c
> +++ b/hw/sh4/sh7750.c
> @@ -451,15 +451,43 @@ static void sh7750_mem_writel(void *opaque, hwaddr addr,
>      }
>  }
>  
> +static uint64_t sh7750_mem_readfn(void *opaque, hwaddr addr, unsigned size)
> +{
> +    switch (size) {
> +    case 1:
> +        return sh7750_mem_readb(opaque, addr);
> +    case 2:
> +        return sh7750_mem_readw(opaque, addr);
> +    case 4:
> +        return sh7750_mem_readl(opaque, addr);
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void sh7750_mem_writefn(void *opaque, hwaddr addr,
> +                               uint64_t value, unsigned size)
> +{
> +    switch (size) {
> +    case 1:
> +        sh7750_mem_writeb(opaque, addr, value);
> +        break;
> +    case 2:
> +        sh7750_mem_writew(opaque, addr, value);
> +        break;
> +    case 4:
> +        sh7750_mem_writel(opaque, addr, value);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  static const MemoryRegionOps sh7750_mem_ops = {
> -    .old_mmio = {
> -        .read = {sh7750_mem_readb,
> -                 sh7750_mem_readw,
> -                 sh7750_mem_readl },
> -        .write = {sh7750_mem_writeb,
> -                  sh7750_mem_writew,
> -                  sh7750_mem_writel },
> -    },
> +    .read = sh7750_mem_readfn,
> +    .write = sh7750_mem_writefn,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> 
