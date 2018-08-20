Received: from eggs.gnu.org ([2001:4830:134:3::10]:36121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1frfsg-0002gS-65
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1frfsc-0006hg-VU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:49:46 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:41337
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1frfsc-0006g9-EZ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:49:42 -0400
References: <20180817114619.22354-1-peter.maydell@linaro.org>
	<20180817114619.22354-2-peter.maydell@linaro.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <a5a2a7d6-8a20-f666-22b1-7e793d68d690@adacore.com>
Date: Mon, 20 Aug 2018 10:49:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180817114619.22354-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/ssi/xilinx_spips: Remove unneeded
 MMIO request_ptr code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>



Le 08/17/2018 =C3=A0 01:46 PM, Peter Maydell a =C3=A9crit=C2=A0:
> We now support direct execution from MMIO regions in the
> core memory subsystem. This means that we don't need to
> have device-specific support for it, and we can remove
> the request_ptr handling from the Xilinx SPIPS device.
> (It was broken anyway due to race conditions, and disabled
> by default.)
>=20
> This device is the only in-tree user of this API.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/ssi/xilinx_spips.c | 46 ------------------------------------------=
-
>   1 file changed, 46 deletions(-)
>=20
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index c052bfc4b3c..16f88f74029 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1031,14 +1031,6 @@ static const MemoryRegionOps spips_ops =3D {
>  =20
>   static void xilinx_qspips_invalidate_mmio_ptr(XilinxQSPIPS *q)

I'd drop this function and replace the calls by
q->lqspi_cached_addr =3D ~0ULL;

Otherwise:

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

>   {
> -    XilinxSPIPS *s =3D &q->parent_obj;
> -
> -    if ((q->mmio_execution_enabled) && (q->lqspi_cached_addr !=3D ~0UL=
L)) {
> -        /* Invalidate the current mapped mmio */
> -        memory_region_invalidate_mmio_ptr(&s->mmlqspi, q->lqspi_cached=
_addr,
> -                                          LQSPI_CACHE_SIZE);
> -    }
> -
>       q->lqspi_cached_addr =3D ~0ULL;
>   }
>  =20
> @@ -1207,23 +1199,6 @@ static void lqspi_load_cache(void *opaque, hwadd=
r addr)
>       }
>   }
>  =20
> -static void *lqspi_request_mmio_ptr(void *opaque, hwaddr addr, unsigne=
d *size,
> -                                    unsigned *offset)
> -{
> -    XilinxQSPIPS *q =3D opaque;
> -    hwaddr offset_within_the_region;
> -
> -    if (!q->mmio_execution_enabled) {
> -        return NULL;
> -    }
> -
> -    offset_within_the_region =3D addr & ~(LQSPI_CACHE_SIZE - 1);
> -    lqspi_load_cache(opaque, offset_within_the_region);
> -    *size =3D LQSPI_CACHE_SIZE;
> -    *offset =3D offset_within_the_region;
> -    return q->lqspi_buf;
> -}
> -
>   static uint64_t
>   lqspi_read(void *opaque, hwaddr addr, unsigned int size)
>   {
> @@ -1245,7 +1220,6 @@ lqspi_read(void *opaque, hwaddr addr, unsigned in=
t size)
>  =20
>   static const MemoryRegionOps lqspi_ops =3D {
>       .read =3D lqspi_read,
> -    .request_ptr =3D lqspi_request_mmio_ptr,
>       .endianness =3D DEVICE_NATIVE_ENDIAN,
>       .valid =3D {
>           .min_access_size =3D 1,
> @@ -1322,15 +1296,6 @@ static void xilinx_qspips_realize(DeviceState *d=
ev, Error **errp)
>       sysbus_init_mmio(sbd, &s->mmlqspi);
>  =20
>       q->lqspi_cached_addr =3D ~0ULL;
> -
> -    /* mmio_execution breaks migration better aborting than having str=
ange
> -     * bugs.
> -     */
> -    if (q->mmio_execution_enabled) {
> -        error_setg(&q->migration_blocker,
> -                   "enabling mmio_execution breaks migration");
> -        migrate_add_blocker(q->migration_blocker, &error_fatal);
> -    }
>   }
>  =20
>   static void xlnx_zynqmp_qspips_realize(DeviceState *dev, Error **errp=
)
> @@ -1427,16 +1392,6 @@ static Property xilinx_zynqmp_qspips_properties[=
] =3D {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> -static Property xilinx_qspips_properties[] =3D {
> -    /* We had to turn this off for 2.10 as it is not compatible with m=
igration.
> -     * It can be enabled but will prevent the device to be migrated.
> -     * This will go aways when a fix will be released.
> -     */
> -    DEFINE_PROP_BOOL("x-mmio-exec", XilinxQSPIPS, mmio_execution_enabl=
ed,
> -                     false),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>   static Property xilinx_spips_properties[] =3D {
>       DEFINE_PROP_UINT8("num-busses", XilinxSPIPS, num_busses, 1),
>       DEFINE_PROP_UINT8("num-ss-bits", XilinxSPIPS, num_cs, 4),
> @@ -1450,7 +1405,6 @@ static void xilinx_qspips_class_init(ObjectClass =
*klass, void * data)
>       XilinxSPIPSClass *xsc =3D XILINX_SPIPS_CLASS(klass);
>  =20
>       dc->realize =3D xilinx_qspips_realize;
> -    dc->props =3D xilinx_qspips_properties;
>       xsc->reg_ops =3D &qspips_ops;
>       xsc->rx_fifo_size =3D RXFF_A_Q;
>       xsc->tx_fifo_size =3D TXFF_A_Q;
>=20
