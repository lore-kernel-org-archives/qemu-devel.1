Received: from eggs.gnu.org ([2001:4830:134:3::10]:42987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOiJ-0003MD-7Y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOiF-0005V0-9h
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:26:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601141223.26630-1-peter.maydell@linaro.org>
	<20180601141223.26630-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fa8eff50-9d32-cdde-fd0d-9d64069eedb9@amsat.org>
Date: Mon, 11 Jun 2018 12:26:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180601141223.26630-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/input/pckbd: Convert away from
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
> Convert the pckbd device away from using the old_mmio field
> of MemoryRegionOps. This change only affects the memory-mapped
> variant of the i8042, which is used by the Unicore32 'puv3'
> board and the MIPS Jazz boards 'magnum' and 'pica61'.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/input/pckbd.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index f17f18e51b..f33e3fc63d 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -434,7 +434,7 @@ static const VMStateDescription vmstate_kbd = {
>  };
>  
>  /* Memory mapped interface */
> -static uint32_t kbd_mm_readb (void *opaque, hwaddr addr)
> +static uint64_t kbd_mm_readfn(void *opaque, hwaddr addr, unsigned size)
>  {
>      KBDState *s = opaque;
>  
> @@ -444,7 +444,8 @@ static uint32_t kbd_mm_readb (void *opaque, hwaddr addr)
>          return kbd_read_data(s, 0, 1) & 0xff;
>  }
>  
> -static void kbd_mm_writeb (void *opaque, hwaddr addr, uint32_t value)
> +static void kbd_mm_writefn(void *opaque, hwaddr addr,
> +                           uint64_t value, unsigned size)
>  {
>      KBDState *s = opaque;
>  
> @@ -454,12 +455,13 @@ static void kbd_mm_writeb (void *opaque, hwaddr addr, uint32_t value)
>          kbd_write_data(s, 0, value & 0xff, 1);
>  }
>  
> +
>  static const MemoryRegionOps i8042_mmio_ops = {
> +    .read = kbd_mm_readfn,
> +    .write = kbd_mm_writefn,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> -    .old_mmio = {
> -        .read = { kbd_mm_readb, kbd_mm_readb, kbd_mm_readb },
> -        .write = { kbd_mm_writeb, kbd_mm_writeb, kbd_mm_writeb },
> -    },
>  };
>  
>  void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
> 
