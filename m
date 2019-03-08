Received: from eggs.gnu.org ([209.51.188.92]:42245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240N-0006FB-Gk
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240K-000107-C3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:54 -0500
Date: Fri, 8 Mar 2019 11:28:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308002806.GJ7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b0R8ugpUbPHtGZft"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-7-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 06/15] ppc/pnv: add a LPC Controller
 model for POWER9
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


--b0R8ugpUbPHtGZft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:39PM +0100, C=E9dric Le Goater wrote:
> The LPC Controller on POWER9 is very similar to the one found on
> POWER8 but accesses are now done via on MMIOs, without the XSCOM and
> ECCB logic. The device tree is populated differently so we add a
> specific POWER9 routine for the purpose.
>=20
> SerIRQ routing is yet to be done.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

[snip]
> +static uint64_t pnv_lpc_mmio_read(void *opaque, hwaddr addr, unsigned si=
ze)
> +{
> +    PnvLpcController *lpc =3D PNV_LPC(opaque);
> +    uint64_t val =3D 0;
> +    uint32_t opb_addr =3D addr & ECCB_CTL_ADDR_MASK;
> +    MemTxResult result;
> +
> +    switch (size) {
> +    case 4:
> +        val =3D address_space_ldl(&lpc->opb_as, opb_addr, MEMTXATTRS_UNS=
PECIFIED,
> +                                &result);

This extra level of indirection via the opb_as still seems very
dubious to me.  But I guess it's something we can fix later, so,
applied.


> +        break;
> +    case 1:
> +        val =3D address_space_ldub(&lpc->opb_as, opb_addr, MEMTXATTRS_UN=
SPECIFIED,
> +                                 &result);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB read failed at @0x%"
> +                      HWADDR_PRIx " invalid size %d\n", addr, size);
> +        return 0;
> +    }
> +
> +    if (result !=3D MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB read failed at @0x%"
> +                      HWADDR_PRIx "\n", addr);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_lpc_mmio_write(void *opaque, hwaddr addr,
> +                                uint64_t val, unsigned size)
> +{
> +    PnvLpcController *lpc =3D PNV_LPC(opaque);
> +    uint32_t opb_addr =3D addr & ECCB_CTL_ADDR_MASK;
> +    MemTxResult result;
> +
> +    switch (size) {
> +    case 4:
> +        address_space_stl(&lpc->opb_as, opb_addr, val, MEMTXATTRS_UNSPEC=
IFIED,
> +                          &result);
> +         break;
> +    case 1:
> +        address_space_stb(&lpc->opb_as, opb_addr, val, MEMTXATTRS_UNSPEC=
IFIED,
> +                          &result);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB write failed at @0x%"
> +                      HWADDR_PRIx " invalid size %d\n", addr, size);
> +        return;
> +    }
> +
> +    if (result !=3D MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB write failed at @0x%"
> +                      HWADDR_PRIx "\n", addr);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_lpc_mmio_ops =3D {
> +    .read =3D pnv_lpc_mmio_read,
> +    .write =3D pnv_lpc_mmio_write,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +    },
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
>  static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
>  {
>      bool lpc_to_opb_irq =3D false;
> @@ -465,6 +627,43 @@ static const TypeInfo pnv_lpc_power8_info =3D {
>      }
>  };
> =20
> +static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvLpcController *lpc =3D PNV_LPC(dev);
> +    PnvLpcClass *plc =3D PNV_LPC_GET_CLASS(dev);
> +    Error *local_err =3D NULL;
> +
> +    plc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /* P9 uses a MMIO region */
> +    memory_region_init_io(&lpc->xscom_regs, OBJECT(lpc), &pnv_lpc_mmio_o=
ps,
> +                          lpc, "lpcm", PNV9_LPCM_SIZE);
> +}
> +
> +static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PnvLpcClass *plc =3D PNV_LPC_CLASS(klass);
> +
> +    dc->desc =3D "PowerNV LPC Controller POWER9";
> +
> +    plc->psi_irq =3D PSIHB9_IRQ_LPCHC;
> +
> +    device_class_set_parent_realize(dc, pnv_lpc_power9_realize,
> +                                    &plc->parent_realize);
> +}
> +
> +static const TypeInfo pnv_lpc_power9_info =3D {
> +    .name          =3D TYPE_PNV9_LPC,
> +    .parent        =3D TYPE_PNV_LPC,
> +    .instance_size =3D sizeof(PnvLpcController),
> +    .class_init    =3D pnv_lpc_power9_class_init,
> +};
> +
>  static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>  {
>      PnvLpcController *lpc =3D PNV_LPC(dev);
> @@ -540,6 +739,7 @@ static void pnv_lpc_register_types(void)
>  {
>      type_register_static(&pnv_lpc_info);
>      type_register_static(&pnv_lpc_power8_info);
> +    type_register_static(&pnv_lpc_power9_info);
>  }
> =20
>  type_init(pnv_lpc_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b0R8ugpUbPHtGZft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBtxYACgkQbDjKyiDZ
s5KB5A/9G2vXSxdNgPrV6bLHUVgk84tceoQPmWBTUb54A+9qlgGrPmw+ox0Icxgn
bgRM1pi6re4WgzSWPgt6v2cXMzGuS7DkwTf7tTy5ywqRFMtveDLpmGG/tXi0Qfim
rSBSfJcMnuim/ouHG1syJ77oYe8Pfu+VF/A1RNnU7G+UzJQrv1NmjZq7E++x1bi1
FpbgWyqPnWi3SGMsEa382+bIUVNK4dcVLJVLRmTziif5KZHJG1jDZgMBSh/aLgKP
DA3zCBHvVAlBm/O2FBecSWOKc050IN12ycbPcrd6A9nP5gDlggi3+pHRlyd84+dM
vbqmtdkL5blV1e40WTladB+rqvKF6DTH/FdzcSzYhezRQ6b40nGmwE7MJhIC0hQS
h9uMDHrwy7IPSsp2tw7aDLQ/nPxwlYmE/ueGoWaQtMCOpQ53UomTH6yGHEfvCqGo
HYHjGmI1wdhtcHIkWpPGQorvzOHnzFqxv6fYq3gJe6ja9XRVG9jzq3a7Qu+KK/YC
VqPn8AUBMDHgXLaVqBT3+sHtjmPSivuyywBjKSKPQzmMT5mOfbQLKkdg1vDvoDTQ
9NR5aO1L9aSKi7KQ8csC+r2tbVz/GLt4ycumD7FqvfOmpT1uUzU22a/2uxEXNrmK
uI7xzEOZSLWDBfqC74d8nsRMq46H2UBYh+3N/vC8UYsyW70JIU0=
=envz
-----END PGP SIGNATURE-----

--b0R8ugpUbPHtGZft--
