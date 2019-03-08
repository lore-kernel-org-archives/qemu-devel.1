Received: from eggs.gnu.org ([209.51.188.92]:42072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240E-0006Bv-IT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240C-0000ta-C8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:46 -0500
Date: Fri, 8 Mar 2019 11:29:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308002913.GL7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h3BncCmUfYp8450W"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-9-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 08/15] ppc/pnv: add a OCC model class
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


--h3BncCmUfYp8450W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:41PM +0100, C=E9dric Le Goater wrote:
> To ease the introduction of the OCC model for POWER9, provide a new
> class attributes to define XSCOM operations per CPU family and a PSI
> IRQ number.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied, thanks.

> ---
>=20
>  Changes in v2:
>=20
>  - new attributes to define XSCOM operations per CPU family and a PSI
>    IRQ number.
>=20
>  include/hw/ppc/pnv_occ.h | 15 +++++++++++
>  hw/ppc/pnv.c             |  2 +-
>  hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++-------------
>  3 files changed, 54 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
> index 82f299dc76ff..dab5a05f8e99 100644
> --- a/include/hw/ppc/pnv_occ.h
> +++ b/include/hw/ppc/pnv_occ.h
> @@ -23,6 +23,8 @@
> =20
>  #define TYPE_PNV_OCC "pnv-occ"
>  #define PNV_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV_OCC)
> +#define TYPE_PNV8_OCC TYPE_PNV_OCC "-POWER8"
> +#define PNV8_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
> =20
>  typedef struct PnvOCC {
>      DeviceState xd;
> @@ -35,4 +37,17 @@ typedef struct PnvOCC {
>      MemoryRegion xscom_regs;
>  } PnvOCC;
> =20
> +#define PNV_OCC_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(PnvOCCClass, (klass), TYPE_PNV_OCC)
> +#define PNV_OCC_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(PnvOCCClass, (obj), TYPE_PNV_OCC)
> +
> +typedef struct PnvOCCClass {
> +    DeviceClass parent_class;
> +
> +    int xscom_size;
> +    const MemoryRegionOps *xscom_ops;
> +    int psi_irq;
> +} PnvOCCClass;
> +
>  #endif /* _PPC_PNV_OCC_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 918fae057b5c..6ae9ce679505 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -790,7 +790,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
>                                     OBJECT(&chip8->psi), &error_abort);
> =20
>      object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ),
> -                            TYPE_PNV_OCC, &error_abort, NULL);
> +                            TYPE_PNV8_OCC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
>                                     OBJECT(&chip8->psi), &error_abort);
>  }
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index 04880f26d612..ea725647c988 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -34,15 +34,17 @@
>  static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
>  {
>      bool irq_state;
> +    PnvOCCClass *poc =3D PNV_OCC_GET_CLASS(occ);
> =20
>      val &=3D 0xffff000000000000ull;
> =20
>      occ->occmisc =3D val;
>      irq_state =3D !!(val >> 63);
> -    pnv_psi_irq_set(occ->psi, PSIHB_IRQ_OCC, irq_state);
> +    pnv_psi_irq_set(occ->psi, poc->psi_irq, irq_state);
>  }
> =20
> -static uint64_t pnv_occ_xscom_read(void *opaque, hwaddr addr, unsigned s=
ize)
> +static uint64_t pnv_occ_power8_xscom_read(void *opaque, hwaddr addr,
> +                                          unsigned size)
>  {
>      PnvOCC *occ =3D PNV_OCC(opaque);
>      uint32_t offset =3D addr >> 3;
> @@ -54,13 +56,13 @@ static uint64_t pnv_occ_xscom_read(void *opaque, hwad=
dr addr, unsigned size)
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> -                      HWADDR_PRIx "\n", addr);
> +                      HWADDR_PRIx "\n", addr >> 3);
>      }
>      return val;
>  }
> =20
> -static void pnv_occ_xscom_write(void *opaque, hwaddr addr,
> -                                uint64_t val, unsigned size)
> +static void pnv_occ_power8_xscom_write(void *opaque, hwaddr addr,
> +                                       uint64_t val, unsigned size)
>  {
>      PnvOCC *occ =3D PNV_OCC(opaque);
>      uint32_t offset =3D addr >> 3;
> @@ -77,13 +79,13 @@ static void pnv_occ_xscom_write(void *opaque, hwaddr =
addr,
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> -                      HWADDR_PRIx "\n", addr);
> +                      HWADDR_PRIx "\n", addr >> 3);
>      }
>  }
> =20
> -static const MemoryRegionOps pnv_occ_xscom_ops =3D {
> -    .read =3D pnv_occ_xscom_read,
> -    .write =3D pnv_occ_xscom_write,
> +static const MemoryRegionOps pnv_occ_power8_xscom_ops =3D {
> +    .read =3D pnv_occ_power8_xscom_read,
> +    .write =3D pnv_occ_power8_xscom_write,
>      .valid.min_access_size =3D 8,
>      .valid.max_access_size =3D 8,
>      .impl.min_access_size =3D 8,
> @@ -91,27 +93,42 @@ static const MemoryRegionOps pnv_occ_xscom_ops =3D {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> +static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
> +{
> +    PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
> +
> +    poc->xscom_size =3D PNV_XSCOM_OCC_SIZE;
> +    poc->xscom_ops =3D &pnv_occ_power8_xscom_ops;
> +    poc->psi_irq =3D PSIHB_IRQ_OCC;
> +}
> +
> +static const TypeInfo pnv_occ_power8_type_info =3D {
> +    .name          =3D TYPE_PNV8_OCC,
> +    .parent        =3D TYPE_PNV_OCC,
> +    .instance_size =3D sizeof(PnvOCC),
> +    .class_init    =3D pnv_occ_power8_class_init,
> +};
> =20
>  static void pnv_occ_realize(DeviceState *dev, Error **errp)
>  {
>      PnvOCC *occ =3D PNV_OCC(dev);
> +    PnvOCCClass *poc =3D PNV_OCC_GET_CLASS(occ);
>      Object *obj;
> -    Error *error =3D NULL;
> +    Error *local_err =3D NULL;
> =20
>      occ->occmisc =3D 0;
> =20
> -    /* get PSI object from chip */
> -    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
> +    obj =3D object_property_get_link(OBJECT(dev), "psi", &local_err);
>      if (!obj) {
> -        error_setg(errp, "%s: required link 'psi' not found: %s",
> -                   __func__, error_get_pretty(error));
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "required link 'psi' not found: ");
>          return;
>      }
>      occ->psi =3D PNV_PSI(obj);
> =20
>      /* XScom region for OCC registers */
> -    pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), &pnv_occ_xscom_=
ops,
> -                  occ, "xscom-occ", PNV_XSCOM_OCC_SIZE);
> +    pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), poc->xscom_ops,
> +                          occ, "xscom-occ", poc->xscom_size);
>  }
> =20
>  static void pnv_occ_class_init(ObjectClass *klass, void *data)
> @@ -119,6 +136,7 @@ static void pnv_occ_class_init(ObjectClass *klass, vo=
id *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->realize =3D pnv_occ_realize;
> +    dc->desc =3D "PowerNV OCC Controller";
>  }
> =20
>  static const TypeInfo pnv_occ_type_info =3D {
> @@ -126,11 +144,14 @@ static const TypeInfo pnv_occ_type_info =3D {
>      .parent        =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(PnvOCC),
>      .class_init    =3D pnv_occ_class_init,
> +    .class_size    =3D sizeof(PnvOCCClass),
> +    .abstract      =3D true,
>  };
> =20
>  static void pnv_occ_register_types(void)
>  {
>      type_register_static(&pnv_occ_type_info);
> +    type_register_static(&pnv_occ_power8_type_info);
>  }
> =20
> -type_init(pnv_occ_register_types)
> +type_init(pnv_occ_register_types);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h3BncCmUfYp8450W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBt1kACgkQbDjKyiDZ
s5JlLhAA4j6Jfmwtd/0I3HhKyn1DIHDS00hcBcNzFo+4pugRnebeixl4Qf0NDcKi
Wbe9BZka1mIdPm3Ku39CEKiqAcGQQ451lsPawj5zzJcYR22RhS89PbigL5/KgZoO
D0pKCtAaMU8NtI1nRy1OrSkWNNKm7Bov0+sJqCWicR58kY3/RX5YNVqURVkpdbVD
zQ3wvoEvhhQ3ARdz8d1fdYMb88m7C4j02RT8r2Xsb3lZBUaHupdRkig3IfT4whGn
ePQdgP3fyukkZ1lKoJvMH/9bPJU34fcpO/xq0vuiwhNju2IJR844Sq8fEuOkf/dL
kLa0jAatgdnkZ7HhkedM9yzCzGgMbaZjncHeHnpeQja5WkEZnGXPC3MjLi++2PPY
xxuE7WWGbl66O9UhnHEl0OBiW6WgiYTaMX3KRz1JsCA+qpVwJ9bNPRJ63rtO5ydj
quJUoaiEfSTGAeZpetf6w2wgT2nIc9L/HHbkiOUolA0Bhh/uE1QB1fqol6GM6Lqn
FduQVxGY8Zp2frDyWw0N8Np0T0ZN/gQeHVG4s2MAIHHIZ22c9ThtP/O+qMKTJ+ra
MzQ7KTCENRRSNss9HNrNBpIXQwN4G39n/uMT4GRM12aKXZQw7bSUNztCLSUt1QW2
rNteqwmokkSNZSeCzin7axmwlC38jgUA2/aBtUwNArKfcWBysyM=
=KQ2l
-----END PGP SIGNATURE-----

--h3BncCmUfYp8450W--
