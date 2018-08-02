Received: from eggs.gnu.org ([2001:4830:134:3::10]:52324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flIun-00036l-Ar
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flIuk-0001Vo-51
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:05:37 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:41325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flIuj-0001Uw-VC
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:05:34 -0400
Received: by mail-ua0-x241.google.com with SMTP id h1-v6so2184941uao.8
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 12:05:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180802180602.22047-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bde6d996-200d-433b-0819-fe9428997f1d@amsat.org>
Date: Thu, 2 Aug 2018 16:05:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180802180602.22047-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/timer/m48t59: Move away from old_mmio
 accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, patches@linaro.org

On 08/02/2018 03:06 PM, Peter Maydell wrote:
> Move the m48t59 device away from using old_mmio MemoryRegionOps
> accessors.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Tested with 'make check' and by booting a sparc guest.
> 
>  hw/timer/m48t59.c | 59 +++++++++--------------------------------------
>  1 file changed, 11 insertions(+), 48 deletions(-)
> 
> diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
> index f2991762ab0..ca3ed445de7 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/timer/m48t59.c
> @@ -493,66 +493,29 @@ static uint64_t NVRAM_readb(void *opaque, hwaddr addr, unsigned size)
>      return retval;
>  }
>  
> -static void nvram_writeb (void *opaque, hwaddr addr, uint32_t value)
> -{
> -    M48t59State *NVRAM = opaque;
> -
> -    m48t59_write(NVRAM, addr, value & 0xff);
> -}
> -
> -static void nvram_writew (void *opaque, hwaddr addr, uint32_t value)
> -{
> -    M48t59State *NVRAM = opaque;
> -
> -    m48t59_write(NVRAM, addr, (value >> 8) & 0xff);
> -    m48t59_write(NVRAM, addr + 1, value & 0xff);
> -}
> -
> -static void nvram_writel (void *opaque, hwaddr addr, uint32_t value)
> -{
> -    M48t59State *NVRAM = opaque;
> -
> -    m48t59_write(NVRAM, addr, (value >> 24) & 0xff);
> -    m48t59_write(NVRAM, addr + 1, (value >> 16) & 0xff);
> -    m48t59_write(NVRAM, addr + 2, (value >> 8) & 0xff);
> -    m48t59_write(NVRAM, addr + 3, value & 0xff);
> -}
> -
> -static uint32_t nvram_readb (void *opaque, hwaddr addr)
> +static uint64_t nvram_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      M48t59State *NVRAM = opaque;
>  
>      return m48t59_read(NVRAM, addr);
>  }
>  
> -static uint32_t nvram_readw (void *opaque, hwaddr addr)
> +static void nvram_write(void *opaque, hwaddr addr, uint64_t value,
> +                        unsigned size)
>  {
>      M48t59State *NVRAM = opaque;
> -    uint32_t retval;
>  
> -    retval = m48t59_read(NVRAM, addr) << 8;
> -    retval |= m48t59_read(NVRAM, addr + 1);
> -    return retval;
> -}
> -
> -static uint32_t nvram_readl (void *opaque, hwaddr addr)
> -{
> -    M48t59State *NVRAM = opaque;
> -    uint32_t retval;
> -
> -    retval = m48t59_read(NVRAM, addr) << 24;
> -    retval |= m48t59_read(NVRAM, addr + 1) << 16;
> -    retval |= m48t59_read(NVRAM, addr + 2) << 8;
> -    retval |= m48t59_read(NVRAM, addr + 3);
> -    return retval;
> +    return m48t59_write(NVRAM, addr, value);
>  }
>  
>  static const MemoryRegionOps nvram_ops = {
> -    .old_mmio = {
> -        .read = { nvram_readb, nvram_readw, nvram_readl, },
> -        .write = { nvram_writeb, nvram_writew, nvram_writel, },
> -    },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .read = nvram_read,
> +    .write = nvram_write,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 1,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_BIG_ENDIAN,
>  };
>  
>  static const VMStateDescription vmstate_m48t59 = {
> 
