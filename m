Received: from eggs.gnu.org ([2001:4830:134:3::10]:41694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOew-0000ji-Ck
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOev-0003eV-8e
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:23:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601141223.26630-1-peter.maydell@linaro.org>
	<20180601141223.26630-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <be3f714f-ddb3-7aea-4976-30f0305b0a3b@amsat.org>
Date: Mon, 11 Jun 2018 12:22:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180601141223.26630-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] hw/block/pflash_cfi02: Convert away
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
> Convert the pflash_cfi02 device away from using the old_mmio field
> of MemoryRegionOps.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/block/pflash_cfi02.c | 97 ++++++++---------------------------------
>  1 file changed, 18 insertions(+), 79 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 75d1ae1026..84d4584100 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -494,102 +494,41 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>      pfl->cmd = 0;
>  }
>  
> -
> -static uint32_t pflash_readb_be(void *opaque, hwaddr addr)
> +static uint64_t pflash_be_readfn(void *opaque, hwaddr addr, unsigned size)
>  {
> -    return pflash_read(opaque, addr, 1, 1);
> +    return pflash_read(opaque, addr, size, 1);
>  }
>  
> -static uint32_t pflash_readb_le(void *opaque, hwaddr addr)
> +static void pflash_be_writefn(void *opaque, hwaddr addr,
> +                              uint64_t value, unsigned size)
>  {
> -    return pflash_read(opaque, addr, 1, 0);
> +    pflash_write(opaque, addr, value, size, 1);
>  }
>  
> -static uint32_t pflash_readw_be(void *opaque, hwaddr addr)
> +static uint64_t pflash_le_readfn(void *opaque, hwaddr addr, unsigned size)
>  {
> -    pflash_t *pfl = opaque;
> -
> -    return pflash_read(pfl, addr, 2, 1);
> +    return pflash_read(opaque, addr, size, 0);
>  }
>  
> -static uint32_t pflash_readw_le(void *opaque, hwaddr addr)
> +static void pflash_le_writefn(void *opaque, hwaddr addr,
> +                              uint64_t value, unsigned size)
>  {
> -    pflash_t *pfl = opaque;
> -
> -    return pflash_read(pfl, addr, 2, 0);
> -}
> -
> -static uint32_t pflash_readl_be(void *opaque, hwaddr addr)
> -{
> -    pflash_t *pfl = opaque;
> -
> -    return pflash_read(pfl, addr, 4, 1);
> -}
> -
> -static uint32_t pflash_readl_le(void *opaque, hwaddr addr)
> -{
> -    pflash_t *pfl = opaque;
> -
> -    return pflash_read(pfl, addr, 4, 0);
> -}
> -
> -static void pflash_writeb_be(void *opaque, hwaddr addr,
> -                             uint32_t value)
> -{
> -    pflash_write(opaque, addr, value, 1, 1);
> -}
> -
> -static void pflash_writeb_le(void *opaque, hwaddr addr,
> -                             uint32_t value)
> -{
> -    pflash_write(opaque, addr, value, 1, 0);
> -}
> -
> -static void pflash_writew_be(void *opaque, hwaddr addr,
> -                             uint32_t value)
> -{
> -    pflash_t *pfl = opaque;
> -
> -    pflash_write(pfl, addr, value, 2, 1);
> -}
> -
> -static void pflash_writew_le(void *opaque, hwaddr addr,
> -                             uint32_t value)
> -{
> -    pflash_t *pfl = opaque;
> -
> -    pflash_write(pfl, addr, value, 2, 0);
> -}
> -
> -static void pflash_writel_be(void *opaque, hwaddr addr,
> -                             uint32_t value)
> -{
> -    pflash_t *pfl = opaque;
> -
> -    pflash_write(pfl, addr, value, 4, 1);
> -}
> -
> -static void pflash_writel_le(void *opaque, hwaddr addr,
> -                             uint32_t value)
> -{
> -    pflash_t *pfl = opaque;
> -
> -    pflash_write(pfl, addr, value, 4, 0);
> +    pflash_write(opaque, addr, value, size, 0);
>  }
>  
>  static const MemoryRegionOps pflash_cfi02_ops_be = {
> -    .old_mmio = {
> -        .read = { pflash_readb_be, pflash_readw_be, pflash_readl_be, },
> -        .write = { pflash_writeb_be, pflash_writew_be, pflash_writel_be, },
> -    },
> +    .read = pflash_be_readfn,
> +    .write = pflash_be_writefn,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
>  static const MemoryRegionOps pflash_cfi02_ops_le = {
> -    .old_mmio = {
> -        .read = { pflash_readb_le, pflash_readw_le, pflash_readl_le, },
> -        .write = { pflash_writeb_le, pflash_writew_le, pflash_writel_le, },
> -    },
> +    .read = pflash_le_readfn,
> +    .write = pflash_le_writefn,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> 
