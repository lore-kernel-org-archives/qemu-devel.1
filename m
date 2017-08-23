Received: from eggs.gnu.org ([2001:4830:134:3::10]:40276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dkc2L-0000Jz-PC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dkc2K-0000Ke-MM
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:14:01 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:33456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mtparkr@gmail.com>) id 1dkc2K-0000KQ-IE
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:14:00 -0400
Received: by mail-yw0-x243.google.com with SMTP id u133so379718ywc.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 13:14:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823193703.10808-1-mtparkr@gmail.com>
References: <20170823193703.10808-1-mtparkr@gmail.com>
From: Matt Parker <mtparkr@gmail.com>
Date: Wed, 23 Aug 2017 21:13:59 +0100
Message-ID: <CAOOZdTgBfYoCxYZd0RTxcDsVb5kLDAvL1iLA14S2+0DHsA-jag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] audio: intel-hda: do not use old_mmio
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "open list:All patches CC here" <qemu-devel@nongnu.org>

I've just noticed the suggested changes from the v1 patch regarding
using MAKE_64BIT_MASK.
This patch is can be ignored for now.

On 23 August 2017 at 20:37, Matt Parker <mtparkr@gmail.com> wrote:
> intel-hda is currently using the old_mmio accessors for io.
> This updates the device to use .read and .write accessors instead.
>
> Signed-off-by: Matt Parker <mtparkr@gmail.com>
> ---
>  hw/audio/intel-hda.c | 57 +++++++++-------------------------------------------
>  1 file changed, 10 insertions(+), 47 deletions(-)
>
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 06acc98f7b..95e3e460fb 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -1043,66 +1043,29 @@ static void intel_hda_regs_reset(IntelHDAState *d)
>
>  /* --------------------------------------------------------------------- */
>
> -static void intel_hda_mmio_writeb(void *opaque, hwaddr addr, uint32_t val)
> +static void intel_hda_mmio_write(void *opaque, hwaddr addr, uint64_t val,
> +                                 unsigned size)
>  {
>      IntelHDAState *d = opaque;
>      const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
>
> -    intel_hda_reg_write(d, reg, val, 0xff);
> +    intel_hda_reg_write(d, reg, val, (1UL << (size * 8)) - 1);
>  }
>
> -static void intel_hda_mmio_writew(void *opaque, hwaddr addr, uint32_t val)
> +static uint64_t intel_hda_mmio_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      IntelHDAState *d = opaque;
>      const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
>
> -    intel_hda_reg_write(d, reg, val, 0xffff);
> -}
> -
> -static void intel_hda_mmio_writel(void *opaque, hwaddr addr, uint32_t val)
> -{
> -    IntelHDAState *d = opaque;
> -    const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
> -
> -    intel_hda_reg_write(d, reg, val, 0xffffffff);
> -}
> -
> -static uint32_t intel_hda_mmio_readb(void *opaque, hwaddr addr)
> -{
> -    IntelHDAState *d = opaque;
> -    const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
> -
> -    return intel_hda_reg_read(d, reg, 0xff);
> -}
> -
> -static uint32_t intel_hda_mmio_readw(void *opaque, hwaddr addr)
> -{
> -    IntelHDAState *d = opaque;
> -    const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
> -
> -    return intel_hda_reg_read(d, reg, 0xffff);
> -}
> -
> -static uint32_t intel_hda_mmio_readl(void *opaque, hwaddr addr)
> -{
> -    IntelHDAState *d = opaque;
> -    const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
> -
> -    return intel_hda_reg_read(d, reg, 0xffffffff);
> +    return intel_hda_reg_read(d, reg, (1UL << (size * 8)) - 1);
>  }
>
>  static const MemoryRegionOps intel_hda_mmio_ops = {
> -    .old_mmio = {
> -        .read = {
> -            intel_hda_mmio_readb,
> -            intel_hda_mmio_readw,
> -            intel_hda_mmio_readl,
> -        },
> -        .write = {
> -            intel_hda_mmio_writeb,
> -            intel_hda_mmio_writew,
> -            intel_hda_mmio_writel,
> -        },
> +    .read = intel_hda_mmio_read,
> +    .write = intel_hda_mmio_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
>      },
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
> --
> 2.13.2
>
