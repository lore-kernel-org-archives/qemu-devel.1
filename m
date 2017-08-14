Received: from eggs.gnu.org ([2001:4830:134:3::10]:60010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhAvL-0008WN-R6
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhAvH-0001Sb-NB
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:40:35 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:37695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhAvH-0001Ro-GW
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:40:31 -0400
Received: by mail-wr0-f170.google.com with SMTP id 33so32117959wrz.4
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 01:40:31 -0700 (PDT)
References: <20170812213330.20539-1-mtparkr@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51a21727-6af3-cd8e-b542-d1e9e8e5ce8a@redhat.com>
Date: Mon, 14 Aug 2017 10:40:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170812213330.20539-1-mtparkr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: rtl8139: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt Parker <mtparkr@gmail.com>, qemu-devel@nognu.org
Cc: Jason Wang <jasowang@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 12/08/2017 23:33, Matt Parker wrote:
> This updates the current MemoryRegionOps for the bar 1 memory region
> from using the old_mmio accessors to the .read and .write accessors.
> 
> Signed-off-by: Matt Parker <mtparkr@gmail.com>
> ---
>  hw/net/rtl8139.c | 60 +++++++++++++++-----------------------------------------
>  1 file changed, 16 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 671c7e48c6..b3aefda291 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -3131,39 +3131,6 @@ static uint32_t rtl8139_io_readl(void *opaque, uint8_t addr)
>  }
>  
>  /* */
> -
> -static void rtl8139_mmio_writeb(void *opaque, hwaddr addr, uint32_t val)
> -{
> -    rtl8139_io_writeb(opaque, addr & 0xFF, val);
> -}
> -
> -static void rtl8139_mmio_writew(void *opaque, hwaddr addr, uint32_t val)
> -{
> -    rtl8139_io_writew(opaque, addr & 0xFF, val);
> -}
> -
> -static void rtl8139_mmio_writel(void *opaque, hwaddr addr, uint32_t val)
> -{
> -    rtl8139_io_writel(opaque, addr & 0xFF, val);
> -}
> -
> -static uint32_t rtl8139_mmio_readb(void *opaque, hwaddr addr)
> -{
> -    return rtl8139_io_readb(opaque, addr & 0xFF);
> -}
> -
> -static uint32_t rtl8139_mmio_readw(void *opaque, hwaddr addr)
> -{
> -    uint32_t val = rtl8139_io_readw(opaque, addr & 0xFF);
> -    return val;
> -}
> -
> -static uint32_t rtl8139_mmio_readl(void *opaque, hwaddr addr)
> -{
> -    uint32_t val = rtl8139_io_readl(opaque, addr & 0xFF);
> -    return val;
> -}
> -
>  static int rtl8139_post_load(void *opaque, int version_id)
>  {
>      RTL8139State* s = opaque;
> @@ -3344,18 +3311,23 @@ static const MemoryRegionOps rtl8139_io_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> +static uint64_t rtl8139_mmio_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +   return rtl8139_ioport_read(opaque, addr & 0xFF, size);
> +}
> +
> +static void rtl8139_mmio_write(void *opaque, hwaddr addr, uint64_t val,
> +                               unsigned size)
> +{
> +    return rtl8139_ioport_write(opaque, addr & 0xFF, val, size);
> +}
> +
>  static const MemoryRegionOps rtl8139_mmio_ops = {

I think you don't even need to declare a separate MemoryRegionOps, and
can just recycle rtl8139_io_ops?

Paolo

> -    .old_mmio = {
> -        .read = {
> -            rtl8139_mmio_readb,
> -            rtl8139_mmio_readw,
> -            rtl8139_mmio_readl,
> -        },
> -        .write = {
> -            rtl8139_mmio_writeb,
> -            rtl8139_mmio_writew,
> -            rtl8139_mmio_writel,
> -        },
> +    .read = rtl8139_mmio_read,
> +    .write = rtl8139_mmio_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
>      },
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> 
