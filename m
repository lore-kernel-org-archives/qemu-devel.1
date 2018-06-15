Received: from eggs.gnu.org ([2001:4830:134:3::10]:58362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTeeJ-0001oh-9j
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTeeH-00065z-P5
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:39:39 -0400
Date: Fri, 15 Jun 2018 12:38:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615023850.GJ4129@umbus.fritz.box>
References: <20180614140043.9231-1-clg@kaod.org>
	<20180614140043.9231-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ELVYuRnMxQ5nnKRy"
Content-Disposition: inline
In-Reply-To: <20180614140043.9231-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/6] ppc/pnv: introduce a 'primary' field
 under the LPC model
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


--ELVYuRnMxQ5nnKRy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 04:00:38PM +0200, C=E9dric Le Goater wrote:
> When a PowerNV system is started, the firmware (skiboot) looks for a
> "primary" property to determine which LPC bus is the default on a
> multichip system. This property is currently populated in the main
> routine creating the device tree of a chip, which is the not the right
> place to do so.
>=20
> Check the chip id to flag the LPC controller as "primary", or not, and
> use that to add the property in the LPC device tree routine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This doesn't seem particularly useful to me.  Is there ever likely to
be a case where we want the primary LPC to be something other than the
one on chip 0?

If not, we seem to be just creating properties and states and a bunch
of stuff just to cache a (chip# =3D=3D 0) test.

> ---
>  include/hw/ppc/pnv_lpc.h |  2 ++
>  hw/ppc/pnv.c             | 19 ++++++-------------
>  hw/ppc/pnv_lpc.c         | 29 ++++++++++++++++++++---------
>  3 files changed, 28 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 53fdd5bb6450..fddcb1c054b3 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -68,6 +68,8 @@ typedef struct PnvLpcController {
> =20
>      /* PSI to generate interrupts */
>      PnvPsi *psi;
> +
> +    bool   primary;
>  } PnvLpcController;
> =20
>  qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 031488131629..b419d3323100 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -285,16 +285,6 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
> =20
>      pnv_dt_xscom(chip, fdt, 0);
> =20
> -    /* The default LPC bus of a multichip system is on chip 0. It's
> -     * recognized by the firmware (skiboot) using a "primary"
> -     * property.
> -     */
> -    if (chip->chip_id =3D=3D 0x0) {
> -        int lpc_offset =3D pnv_chip_lpc_offset(chip, fdt);
> -
> -        _FDT((fdt_setprop(fdt, lpc_offset, "primary", NULL, 0)));
> -    }
> -
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> =20
> @@ -814,9 +804,12 @@ static void pnv_chip_init(Object *obj)
>      object_property_add_const_link(OBJECT(&chip->occ), "psi",
>                                     OBJECT(&chip->psi), &error_abort);
> =20
> -    /* The LPC controller needs PSI to generate interrupts */
> -    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
> -                                   OBJECT(&chip->psi), &error_abort);
> +    /*
> +     * The LPC controller needs a few things from the chip : to know
> +     * if it's primary and PSI to generate interrupts
> +     */
> +    object_property_add_const_link(OBJECT(&chip->lpc), "chip",
> +                                   OBJECT(chip), &error_abort);
>  }
> =20
>  static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 402c4fefa886..1e70c8c19d52 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -113,6 +113,14 @@ static int pnv_lpc_dt_xscom(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
>      _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
>      _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
>      _FDT((fdt_setprop(fdt, offset, "compatible", compat, sizeof(compat))=
));
> +
> +    /*
> +     * The default LPC bus of a multichip system is on chip 0. It's
> +     * recognized by the firmware (skiboot) using a "primary" property.
> +     */
> +    if (PNV_LPC(dev)->primary) {
> +        _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
> +    }
>      return 0;
>  }
> =20
> @@ -416,6 +424,18 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
>      PnvLpcController *lpc =3D PNV_LPC(dev);
>      Object *obj;
>      Error *error =3D NULL;
> +    PnvChip *chip;
> +
> +    /* get PSI object from chip */
> +    obj =3D object_property_get_link(OBJECT(dev), "chip", &error);
> +    if (!obj) {
> +        error_propagate(errp, error);
> +        error_prepend(errp, "required link 'chip' not found: ");
> +        return;
> +    }
> +    chip =3D PNV_CHIP(obj);
> +    lpc->psi =3D &chip->psi;
> +    lpc->primary =3D chip->chip_id =3D=3D 0;
> =20
>      /* Reg inits */
>      lpc->lpc_hc_fw_rd_acc_size =3D LPC_HC_FW_RD_4B;
> @@ -460,15 +480,6 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
>      pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(dev),
>                            &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
>                            PNV_XSCOM_LPC_SIZE);
> -
> -    /* get PSI object from chip */
> -    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
> -    if (!obj) {
> -        error_setg(errp, "%s: required link 'psi' not found: %s",
> -                   __func__, error_get_pretty(error));
> -        return;
> -    }
> -    lpc->psi =3D PNV_PSI(obj);
>  }
> =20
>  static void pnv_lpc_class_init(ObjectClass *klass, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ELVYuRnMxQ5nnKRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjJrgACgkQbDjKyiDZ
s5KfixAAnAYFJ91kAq4vIvuP2Gc96LlzhWrgPaIr30niX1lkq65vrLKcJsDNNguk
v1t6lkAIIhAUNq4pS8uKeYeWcWEbZ188tDdfcXX1G8Zj36ID1Ga3BeIznclLHHTU
Q/XT6SKQuACgQx/+KYmTaHGnBbJcqsNIMHIdSMEu3qlBDPc3JmcHy5d27uN/o/Rb
B1zbhmEOfUUtpE42OcC19/wqKHdQ3Q4tlBypsEI9kfcKEYJQYAC3kAkM0FGjUXy/
N5rBM9kJhLG/Ma8DAwSAqMEC+Zgb5CdzMvcgVQC+lchyTlJtjsQ4RVd+creYzxE6
MvqsVoKMembi+mFLzVw79d9f5F71Fv0C0CjOi5xxItCOHFAiDscjPzXDmq+VW6rF
yCgwjQyKCmGVqyMafX4mv9k6flHYKOOs+wmIOfj5l5iz+fJ5LLeocYFzl6NugE5A
VEQfIafch/IgpJ3YAh5xPC/+ldxAcOkBaee7Q/yGIcNQrNIzMT1HWnlXSiy/duE5
DCtgZvO0eKQHUYLEs1ubXm5z+Vk0e+eDi6eZX4AZJi0tIoJlahj1lSMbMnZjZl7u
DhyTGi3sQbejpKYpVU47xrdwZOvkV7wHXMmUQw358sxY18gHdKdbo8Chq+6XMAVh
YKKE81GysdgC6BA5g0GtDPD7GZgtX8AB1CXwISEX5vDKsLdjs3U=
=mGol
-----END PGP SIGNATURE-----

--ELVYuRnMxQ5nnKRy--
