Received: from eggs.gnu.org ([2001:4830:134:3::10]:60956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flG2U-0007un-OV
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flG2P-0003VE-W2
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:01:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
	<20180802144430.13870-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <232a0bd8-257e-f17d-f613-1618efad9b05@amsat.org>
Date: Thu, 2 Aug 2018 13:00:56 -0300
MIME-Version: 1.0
In-Reply-To: <20180802144430.13870-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/ppc/ppc405_uc: Convert away from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, patches@linaro.org

On 08/02/2018 11:44 AM, Peter Maydell wrote:
> Convert the devices in ppc405_uc away from using the old_mmio
> MemoryRegion accessors:
> 
>  * opba's 32-bit and 16-bit accessors were just calling the
>    8-bit accessors and assembling a big-endian order number,
>    which we can do by setting the .impl.max_access_size to 1
>    and the endianness to DEVICE_BIG_ENDIAN, and letting the
>    core memory code do the assembly
>  * ppc405_gpio's accessors were all just stubs
>  * ppc4xx_gpt's 8-bit and 16-bit accessors were treating the
>    access as invalid, which we can do by setting the
>    .valid.min_access_size and .valid.max_access_size fields
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/ppc/ppc405_uc.c | 173 +++++++--------------------------------------
>  1 file changed, 25 insertions(+), 148 deletions(-)
> 
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 4bd9fbcc1ef..5c58415cf1f 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -283,7 +283,7 @@ struct ppc4xx_opba_t {
>      uint8_t pr;
>  };
>  
> -static uint32_t opba_readb (void *opaque, hwaddr addr)
> +static uint64_t opba_readb(void *opaque, hwaddr addr, unsigned size)
>  {
>      ppc4xx_opba_t *opba;
>      uint32_t ret;
> @@ -307,8 +307,8 @@ static uint32_t opba_readb (void *opaque, hwaddr addr)
>      return ret;
>  }
>  
> -static void opba_writeb (void *opaque,
> -                         hwaddr addr, uint32_t value)
> +static void opba_writeb(void *opaque, hwaddr addr, uint64_t value,
> +                        unsigned size)
>  {
>      ppc4xx_opba_t *opba;
>  
> @@ -328,61 +328,14 @@ static void opba_writeb (void *opaque,
>          break;
>      }
>  }
> -
> -static uint32_t opba_readw (void *opaque, hwaddr addr)
> -{
> -    uint32_t ret;
> -
> -#ifdef DEBUG_OPBA
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    ret = opba_readb(opaque, addr) << 8;
> -    ret |= opba_readb(opaque, addr + 1);
> -
> -    return ret;
> -}
> -
> -static void opba_writew (void *opaque,
> -                         hwaddr addr, uint32_t value)
> -{
> -#ifdef DEBUG_OPBA
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
> -           value);
> -#endif
> -    opba_writeb(opaque, addr, value >> 8);
> -    opba_writeb(opaque, addr + 1, value);
> -}
> -
> -static uint32_t opba_readl (void *opaque, hwaddr addr)
> -{
> -    uint32_t ret;
> -
> -#ifdef DEBUG_OPBA
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    ret = opba_readb(opaque, addr) << 24;
> -    ret |= opba_readb(opaque, addr + 1) << 16;
> -
> -    return ret;
> -}
> -
> -static void opba_writel (void *opaque,
> -                         hwaddr addr, uint32_t value)
> -{
> -#ifdef DEBUG_OPBA
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
> -           value);
> -#endif
> -    opba_writeb(opaque, addr, value >> 24);
> -    opba_writeb(opaque, addr + 1, value >> 16);
> -}
> -
>  static const MemoryRegionOps opba_ops = {
> -    .old_mmio = {
> -        .read = { opba_readb, opba_readw, opba_readl, },
> -        .write = { opba_writeb, opba_writew, opba_writel, },
> -    },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .read = opba_readb,
> +    .write = opba_writeb,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 1,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_BIG_ENDIAN,

Except the eventual issue commented in the previous patch,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  };
>  
>  static void ppc4xx_opba_reset (void *opaque)
> @@ -750,65 +703,27 @@ struct ppc405_gpio_t {
>      uint32_t isr1l;
>  };
>  
> -static uint32_t ppc405_gpio_readb (void *opaque, hwaddr addr)
> +static uint64_t ppc405_gpio_read(void *opaque, hwaddr addr, unsigned size)
>  {
>  #ifdef DEBUG_GPIO
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> +    printf("%s: addr " TARGET_FMT_plx " size %d\n", __func__, addr, size);
>  #endif
>  
>      return 0;
>  }
>  
> -static void ppc405_gpio_writeb (void *opaque,
> -                                hwaddr addr, uint32_t value)
> +static void ppc405_gpio_write(void *opaque, hwaddr addr, uint64_t value,
> +                              unsigned size)
>  {
>  #ifdef DEBUG_GPIO
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
> -           value);
> -#endif
> -}
> -
> -static uint32_t ppc405_gpio_readw (void *opaque, hwaddr addr)
> -{
> -#ifdef DEBUG_GPIO
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -
> -    return 0;
> -}
> -
> -static void ppc405_gpio_writew (void *opaque,
> -                                hwaddr addr, uint32_t value)
> -{
> -#ifdef DEBUG_GPIO
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
> -           value);
> -#endif
> -}
> -
> -static uint32_t ppc405_gpio_readl (void *opaque, hwaddr addr)
> -{
> -#ifdef DEBUG_GPIO
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -
> -    return 0;
> -}
> -
> -static void ppc405_gpio_writel (void *opaque,
> -                                hwaddr addr, uint32_t value)
> -{
> -#ifdef DEBUG_GPIO
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
> -           value);
> +    printf("%s: addr " TARGET_FMT_plx " size %d val %08" PRIx32 "\n",
> +           __func__, addr, size, value);
>  #endif
>  }
>  
>  static const MemoryRegionOps ppc405_gpio_ops = {
> -    .old_mmio = {
> -        .read = { ppc405_gpio_readb, ppc405_gpio_readw, ppc405_gpio_readl, },
> -        .write = { ppc405_gpio_writeb, ppc405_gpio_writew, ppc405_gpio_writel, },
> -    },
> +    .read = ppc405_gpio_read,
> +    .write = ppc405_gpio_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> @@ -1017,44 +932,6 @@ struct ppc4xx_gpt_t {
>      uint32_t mask[5];
>  };
>  
> -static uint32_t ppc4xx_gpt_readb (void *opaque, hwaddr addr)
> -{
> -#ifdef DEBUG_GPT
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    /* XXX: generate a bus fault */
> -    return -1;
> -}
> -
> -static void ppc4xx_gpt_writeb (void *opaque,
> -                               hwaddr addr, uint32_t value)
> -{
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
> -           value);
> -#endif
> -    /* XXX: generate a bus fault */
> -}
> -
> -static uint32_t ppc4xx_gpt_readw (void *opaque, hwaddr addr)
> -{
> -#ifdef DEBUG_GPT
> -    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
> -#endif
> -    /* XXX: generate a bus fault */
> -    return -1;
> -}
> -
> -static void ppc4xx_gpt_writew (void *opaque,
> -                               hwaddr addr, uint32_t value)
> -{
> -#ifdef DEBUG_I2C
> -    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
> -           value);
> -#endif
> -    /* XXX: generate a bus fault */
> -}
> -
>  static int ppc4xx_gpt_compare (ppc4xx_gpt_t *gpt, int n)
>  {
>      /* XXX: TODO */
> @@ -1107,7 +984,7 @@ static void ppc4xx_gpt_compute_timer (ppc4xx_gpt_t *gpt)
>      /* XXX: TODO */
>  }
>  
> -static uint32_t ppc4xx_gpt_readl (void *opaque, hwaddr addr)
> +static uint64_t ppc4xx_gpt_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      ppc4xx_gpt_t *gpt;
>      uint32_t ret;
> @@ -1162,8 +1039,8 @@ static uint32_t ppc4xx_gpt_readl (void *opaque, hwaddr addr)
>      return ret;
>  }
>  
> -static void ppc4xx_gpt_writel (void *opaque,
> -                               hwaddr addr, uint32_t value)
> +static void ppc4xx_gpt_write(void *opaque, hwaddr addr, uint64_t value,
> +                             unsigned size)
>  {
>      ppc4xx_gpt_t *gpt;
>      int idx;
> @@ -1225,10 +1102,10 @@ static void ppc4xx_gpt_writel (void *opaque,
>  }
>  
>  static const MemoryRegionOps gpt_ops = {
> -    .old_mmio = {
> -        .read = { ppc4xx_gpt_readb, ppc4xx_gpt_readw, ppc4xx_gpt_readl, },
> -        .write = { ppc4xx_gpt_writeb, ppc4xx_gpt_writew, ppc4xx_gpt_writel, },
> -    },
> +    .read = ppc4xx_gpt_read,
> +    .write = ppc4xx_gpt_write,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> 
