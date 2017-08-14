Received: from eggs.gnu.org ([2001:4830:134:3::10]:60921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh5fl-0000dQ-Bl
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh5fi-0002Tx-7v
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:04:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dh5fh-0002Rs-Vw
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:04:06 -0400
References: <20170812213448.20624-1-mtparkr@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <98d64249-0d86-d412-d8b7-7c2c7a3ebac4@redhat.com>
Date: Mon, 14 Aug 2017 10:58:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170812213448.20624-1-mtparkr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: rtl8139: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt Parker <mtparkr@gmail.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B408=E6=9C=8813=E6=97=A5 05:34, Matt Parker wrote:
> This updates the current MemoryRegionOps for the bar 1 memory region
> from using the old_mmio accessors to the .read and .write accessors.
>
> Signed-off-by: Matt Parker <mtparkr@gmail.com>
> ---
>   hw/net/rtl8139.c | 60 +++++++++++++++--------------------------------=
---------
>   1 file changed, 16 insertions(+), 44 deletions(-)
>
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 671c7e48c6..b3aefda291 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -3131,39 +3131,6 @@ static uint32_t rtl8139_io_readl(void *opaque, u=
int8_t addr)
>   }
>  =20
>   /* */
> -
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
> @@ -3344,18 +3311,23 @@ static const MemoryRegionOps rtl8139_io_ops =3D=
 {
>       .endianness =3D DEVICE_LITTLE_ENDIAN,
>   };
>  =20
> +static uint64_t rtl8139_mmio_read(void *opaque, hwaddr addr, unsigned =
size)
> +{
> +   return rtl8139_ioport_read(opaque, addr & 0xFF, size);
> +}
> +
> +static void rtl8139_mmio_write(void *opaque, hwaddr addr, uint64_t val=
,
> +                               unsigned size)
> +{
> +    return rtl8139_ioport_write(opaque, addr & 0xFF, val, size);
> +}
> +
>   static const MemoryRegionOps rtl8139_mmio_ops =3D {
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
> +    .read =3D rtl8139_mmio_read,
> +    .write =3D rtl8139_mmio_write,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
>       },
>       .endianness =3D DEVICE_LITTLE_ENDIAN,
>   };

Queued for 2.11.

Thanks
