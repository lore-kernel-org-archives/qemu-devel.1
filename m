Received: from eggs.gnu.org ([2001:4830:134:3::10]:52379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1djdXc-0000Bo-DC
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1djdXX-0001I8-GP
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:38:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1djdXX-0001I3-73
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:38:11 -0400
References: <20170815200607.16232-1-mtparkr@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1d91e7e8-0f49-4dd1-de64-eff1df5050db@redhat.com>
Date: Mon, 21 Aug 2017 11:38:05 +0800
MIME-Version: 1.0
In-Reply-To: <20170815200607.16232-1-mtparkr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] net: rtl8139: do not use old_mmio
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt Parker <mtparkr@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com



On 2017=E5=B9=B408=E6=9C=8816=E6=97=A5 04:06, Matt Parker wrote:
> Both io and memory use the same mmio functions in the rtl8139 device.
> This patch removes the separate MemoryRegionOps and old_mmio accessors
> for memory, and replaces it with an alias to the io memory region.
>
> Signed-off-by: Matt Parker <mtparkr@gmail.com>
> ---
>   hw/net/rtl8139.c | 53 +++--------------------------------------------=
------
>   1 file changed, 3 insertions(+), 50 deletions(-)
>
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 671c7e48c6..3be24bbee7 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -3132,38 +3132,6 @@ static uint32_t rtl8139_io_readl(void *opaque, u=
int8_t addr)
>  =20
>   /* */
>  =20
> -static void rtl8139_mmio_writeb(void *opaque, hwaddr addr, uint32_t va=
l)
> -{
> -    rtl8139_io_writeb(opaque, addr & 0xFF, val);
> -}
> -
> -static void rtl8139_mmio_writew(void *opaque, hwaddr addr, uint32_t va=
l)
> -{
> -    rtl8139_io_writew(opaque, addr & 0xFF, val);
> -}
> -
> -static void rtl8139_mmio_writel(void *opaque, hwaddr addr, uint32_t va=
l)
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
> -    uint32_t val =3D rtl8139_io_readw(opaque, addr & 0xFF);
> -    return val;
> -}
> -
> -static uint32_t rtl8139_mmio_readl(void *opaque, hwaddr addr)
> -{
> -    uint32_t val =3D rtl8139_io_readl(opaque, addr & 0xFF);
> -    return val;
> -}
> -
>   static int rtl8139_post_load(void *opaque, int version_id)
>   {
>       RTL8139State* s =3D opaque;
> @@ -3344,22 +3312,6 @@ static const MemoryRegionOps rtl8139_io_ops =3D =
{
>       .endianness =3D DEVICE_LITTLE_ENDIAN,
>   };
>  =20
> -static const MemoryRegionOps rtl8139_mmio_ops =3D {
> -    .old_mmio =3D {
> -        .read =3D {
> -            rtl8139_mmio_readb,
> -            rtl8139_mmio_readw,
> -            rtl8139_mmio_readl,
> -        },
> -        .write =3D {
> -            rtl8139_mmio_writeb,
> -            rtl8139_mmio_writew,
> -            rtl8139_mmio_writel,
> -        },
> -    },
> -    .endianness =3D DEVICE_LITTLE_ENDIAN,
> -};
> -
>   static void rtl8139_timer(void *opaque)
>   {
>       RTL8139State *s =3D opaque;
> @@ -3422,8 +3374,9 @@ static void pci_rtl8139_realize(PCIDevice *dev, E=
rror **errp)
>  =20
>       memory_region_init_io(&s->bar_io, OBJECT(s), &rtl8139_io_ops, s,
>                             "rtl8139", 0x100);
> -    memory_region_init_io(&s->bar_mem, OBJECT(s), &rtl8139_mmio_ops, s=
,
> -                          "rtl8139", 0x100);
> +    memory_region_init_alias(&s->bar_mem, OBJECT(s), "rtl8139-mem", &s=
->bar_io,
> +                             0, 0x100);
> +
>       pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->bar_io);
>       pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar_m=
em);
>  =20

Applied.

Thanks
