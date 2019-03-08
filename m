Received: from eggs.gnu.org ([209.51.188.92]:42252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240N-0006FM-N6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240K-00010M-D9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:55 -0500
Date: Fri, 8 Mar 2019 11:31:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308003116.GN7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1f4qkB5Yv+YDR+z0"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-11-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 10/15] ppc/pnv: extend XSCOM core
 support for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--1f4qkB5Yv+YDR+z0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:43PM +0100, C=E9dric Le Goater wrote:
> Provide a new class attribute to define XSCOM operations per CPU
> family and add a couple of XSCOM addresses controlling the power
> management states of the core on POWER9.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>=20
>  Changes in v2 :
>=20
>  - new class attribute to define XSCOM operations per CPU family
>=20
>  include/hw/ppc/pnv_core.h |   2 +
>  hw/ppc/pnv_core.c         | 100 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 89 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 6874bb847a01..cbe9ad36f32c 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -42,6 +42,8 @@ typedef struct PnvCore {
> =20
>  typedef struct PnvCoreClass {
>      DeviceClass parent_class;
> +
> +    const MemoryRegionOps *xscom_ops;
>  } PnvCoreClass;
> =20
>  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 38179cdc53dc..171474e0805c 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -60,8 +60,8 @@ static void pnv_cpu_reset(void *opaque)
>  #define PNV_XSCOM_EX_DTS_RESULT0     0x50000
>  #define PNV_XSCOM_EX_DTS_RESULT1     0x50001
> =20
> -static uint64_t pnv_core_xscom_read(void *opaque, hwaddr addr,
> -                                    unsigned int width)
> +static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
> +                                           unsigned int width)
>  {
>      uint32_t offset =3D addr >> 3;
>      uint64_t val =3D 0;
> @@ -82,16 +82,74 @@ static uint64_t pnv_core_xscom_read(void *opaque, hwa=
ddr addr,
>      return val;
>  }
> =20
> -static void pnv_core_xscom_write(void *opaque, hwaddr addr, uint64_t val,
> -                                 unsigned int width)
> +static void pnv_core_power8_xscom_write(void *opaque, hwaddr addr, uint6=
4_t val,
> +                                        unsigned int width)
>  {
>      qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_PRIx=
 "\n",
>                    addr);
>  }
> =20
> -static const MemoryRegionOps pnv_core_xscom_ops =3D {
> -    .read =3D pnv_core_xscom_read,
> -    .write =3D pnv_core_xscom_write,
> +static const MemoryRegionOps pnv_core_power8_xscom_ops =3D {
> +    .read =3D pnv_core_power8_xscom_read,
> +    .write =3D pnv_core_power8_xscom_write,
> +    .valid.min_access_size =3D 8,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 8,
> +    .impl.max_access_size =3D 8,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +
> +/*
> + * POWER9 core controls
> + */
> +#define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
> +#define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
> +
> +static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
> +                                           unsigned int width)
> +{
> +    uint32_t offset =3D addr >> 3;
> +    uint64_t val =3D 0;
> +
> +    /* The result should be 38 C */
> +    switch (offset) {
> +    case PNV_XSCOM_EX_DTS_RESULT0:
> +        val =3D 0x26f024f023f0000ull;
> +        break;
> +    case PNV_XSCOM_EX_DTS_RESULT1:
> +        val =3D 0x24f000000000000ull;
> +        break;
> +    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP:
> +    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
> +        val =3D 0x0;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=3D0x%" HWADDR_PRI=
x "\n",
> +                  addr);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_core_power9_xscom_write(void *opaque, hwaddr addr, uint6=
4_t val,
> +                                        unsigned int width)
> +{
> +    uint32_t offset =3D addr >> 3;
> +
> +    switch (offset) {
> +    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP:
> +    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_=
PRIx "\n",
> +                      addr);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_core_power9_xscom_ops =3D {
> +    .read =3D pnv_core_power9_xscom_read,
> +    .write =3D pnv_core_power9_xscom_write,
>      .valid.min_access_size =3D 8,
>      .valid.max_access_size =3D 8,
>      .impl.min_access_size =3D 8,
> @@ -138,6 +196,7 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip=
 *chip, Error **errp)
>  static void pnv_core_realize(DeviceState *dev, Error **errp)
>  {
>      PnvCore *pc =3D PNV_CORE(OBJECT(dev));
> +    PnvCoreClass *pcc =3D PNV_CORE_GET_CLASS(pc);
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
>      const char *typename =3D pnv_core_cpu_typename(pc);
>      Error *local_err =3D NULL;
> @@ -180,7 +239,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      }
> =20
>      snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
> -    pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), &pnv_core_xscom_=
ops,
> +    pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
>                            pc, name, PNV_XSCOM_EX_SIZE);
>      return;
> =20
> @@ -222,6 +281,20 @@ static Property pnv_core_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +static void pnv_core_power8_class_init(ObjectClass *oc, void *data)
> +{
> +    PnvCoreClass *pcc =3D PNV_CORE_CLASS(oc);
> +
> +    pcc->xscom_ops =3D &pnv_core_power8_xscom_ops;
> +}
> +
> +static void pnv_core_power9_class_init(ObjectClass *oc, void *data)
> +{
> +    PnvCoreClass *pcc =3D PNV_CORE_CLASS(oc);
> +
> +    pcc->xscom_ops =3D &pnv_core_power9_xscom_ops;
> +}
> +
>  static void pnv_core_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> @@ -231,10 +304,11 @@ static void pnv_core_class_init(ObjectClass *oc, vo=
id *data)
>      dc->props =3D pnv_core_properties;
>  }
> =20
> -#define DEFINE_PNV_CORE_TYPE(cpu_model)         \
> +#define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
>      {                                           \
>          .parent =3D TYPE_PNV_CORE,                \
>          .name =3D PNV_CORE_TYPE_NAME(cpu_model),  \
> +        .class_init =3D pnv_core_##family##_class_init, \
>      }
> =20
>  static const TypeInfo pnv_core_infos[] =3D {
> @@ -246,10 +320,10 @@ static const TypeInfo pnv_core_infos[] =3D {
>          .class_init =3D pnv_core_class_init,
>          .abstract       =3D true,
>      },
> -    DEFINE_PNV_CORE_TYPE("power8e_v2.1"),
> -    DEFINE_PNV_CORE_TYPE("power8_v2.0"),
> -    DEFINE_PNV_CORE_TYPE("power8nvl_v1.0"),
> -    DEFINE_PNV_CORE_TYPE("power9_v2.0"),
> +    DEFINE_PNV_CORE_TYPE(power8, "power8e_v2.1"),
> +    DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
> +    DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
> +    DEFINE_PNV_CORE_TYPE(power9, "power9_v2.0"),
>  };
> =20
>  DEFINE_TYPES(pnv_core_infos)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1f4qkB5Yv+YDR+z0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBt9MACgkQbDjKyiDZ
s5IyLBAA4hlgLNAgBsg6mN3A1vx8q5EGLdiEbkoaqr4uyP01bU2sadwGgIPrtvRm
LcYPHQcjhDZ3AvK/o0PTvNd6L9U7XPLmJEvRVsoL2KQPfVhsfxV8VK7zjKjh8zD0
XPIv/HB2tn7r1kcf6j2n1w2A5IQhWK+gwQSlObu4JeXwDx4wFBVMVWNETaAERsyV
MV+6LRA8ZYcnXK8kKNOh+dhVg3Ih1Wwdl0kta1qPoeUO5GrF7lry48U4Dz9eqxjY
RST/507uqLF9xSoqu8/gu2fG9Yb28+DQ+y/bvZ5ZTrzTPEjQm7DpVps0UFtGXlon
6YgzYhLsCDL0zQqTUaNsCBOzOcLCxLyPx0ngG3BQl/ECYGKcff9n+/T3/ig33V9v
8TR3odbGs4YNANpEvYrf1wE9RgjlOfrYgjAM3V8UGEeCup+XABGBJy7LOo4wgjp6
EZcBCly1LQnFHq8GRFSKZ5dMdeGDYbny5c6WNKTd9xVqJRoVMZYUM2y1GJHi4xl6
SngFlMiw4RWDIY/op+Z2XMvdRiwSOL2xhGK55LkYosyUlJ0p0qePxGviqsIlnH3H
E68S5VDtiDqmbUfEK1tAuBMN7gbDWo/rN8SdMVOJv7NnItTsvcor8xzgN8c48T/+
Z2bd7Ed+onh28HT6A4/16dAfaqk9iDXCjt0SpYllWt3GouSmDWY=
=adad
-----END PGP SIGNATURE-----

--1f4qkB5Yv+YDR+z0--
