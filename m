Received: from eggs.gnu.org ([2001:4830:134:3::10]:38722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flGGR-0006ot-I7
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flGGQ-0003qB-Fu
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:15:47 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:42329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flGGQ-0003pw-9e
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:15:46 -0400
Received: by mail-ua0-x243.google.com with SMTP id w7-v6so1829320uan.9
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 09:15:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180802155147.1863-1-peter.maydell@linaro.org>
	<20180802155147.1863-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c499af1e-c0fd-1e54-6732-237330801b4d@amsat.org>
Date: Thu, 2 Aug 2018 13:15:31 -0300
MIME-Version: 1.0
In-Reply-To: <20180802155147.1863-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/display/vga-isa-mm: Convert away
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, patches@linaro.org

On 08/02/2018 12:51 PM, Peter Maydell wrote:
> Convert the vga-isa-mm device away from the old_mmio
> MemoryRegion accessors.
> 
> This device is only used by the MIPS 'jazz' boards
> "magnum" and "pica61".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/vga-isa-mm.c | 60 +++++++++--------------------------------
>  1 file changed, 13 insertions(+), 47 deletions(-)
> 
> diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
> index 232216cad0a..215e6497190 100644
> --- a/hw/display/vga-isa-mm.c
> +++ b/hw/display/vga-isa-mm.c
> @@ -36,64 +36,30 @@ typedef struct ISAVGAMMState {
>  } ISAVGAMMState;
>  
>  /* Memory mapped interface */
> -static uint32_t vga_mm_readb (void *opaque, hwaddr addr)
> +static uint64_t vga_mm_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      ISAVGAMMState *s = opaque;
>  
> -    return vga_ioport_read(&s->vga, addr >> s->it_shift) & 0xff;
> +    return vga_ioport_read(&s->vga, addr >> s->it_shift) &
> +        MAKE_64BIT_MASK(0, size * 8);
>  }
>  
> -static void vga_mm_writeb (void *opaque,
> -                           hwaddr addr, uint32_t value)
> +static void vga_mm_write(void *opaque, hwaddr addr, uint64_t value,
> +                         unsigned size)
>  {
>      ISAVGAMMState *s = opaque;
>  
> -    vga_ioport_write(&s->vga, addr >> s->it_shift, value & 0xff);
> -}
> -
> -static uint32_t vga_mm_readw (void *opaque, hwaddr addr)
> -{
> -    ISAVGAMMState *s = opaque;
> -
> -    return vga_ioport_read(&s->vga, addr >> s->it_shift) & 0xffff;
> -}
> -
> -static void vga_mm_writew (void *opaque,
> -                           hwaddr addr, uint32_t value)
> -{
> -    ISAVGAMMState *s = opaque;
> -
> -    vga_ioport_write(&s->vga, addr >> s->it_shift, value & 0xffff);
> -}
> -
> -static uint32_t vga_mm_readl (void *opaque, hwaddr addr)
> -{
> -    ISAVGAMMState *s = opaque;
> -
> -    return vga_ioport_read(&s->vga, addr >> s->it_shift);
> -}
> -
> -static void vga_mm_writel (void *opaque,
> -                           hwaddr addr, uint32_t value)
> -{
> -    ISAVGAMMState *s = opaque;
> -
> -    vga_ioport_write(&s->vga, addr >> s->it_shift, value);
> +    vga_ioport_write(&s->vga, addr >> s->it_shift,
> +                     value & MAKE_64BIT_MASK(0, size * 8));
>  }
>  
>  static const MemoryRegionOps vga_mm_ctrl_ops = {
> -    .old_mmio = {
> -        .read = {
> -            vga_mm_readb,
> -            vga_mm_readw,
> -            vga_mm_readl,
> -        },
> -        .write = {
> -            vga_mm_writeb,
> -            vga_mm_writew,
> -            vga_mm_writel,
> -        },
> -    },
> +    .read = vga_mm_read,
> +    .write = vga_mm_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 4,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> 
