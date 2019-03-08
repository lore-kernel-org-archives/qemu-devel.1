Received: from eggs.gnu.org ([209.51.188.92]:42077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240E-0006By-It
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240C-0000tb-CO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:46 -0500
Date: Fri, 8 Mar 2019 11:19:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308001904.GI7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-19-clg@kaod.org>
	<20190307041816.GL7722@umbus.fritz.box>
	<05109d65-4917-5929-2431-99ea25d4fb67@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qZVVwWJgpX9Jzs7f"
Content-Disposition: inline
In-Reply-To: <05109d65-4917-5929-2431-99ea25d4fb67@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 18/27] ppc/pnv: add a LPC Controller model
 for POWER9
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


--qZVVwWJgpX9Jzs7f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 08:07:41AM +0100, C=E9dric Le Goater wrote:
> On 3/7/19 5:18 AM, David Gibson wrote:
> > On Wed, Mar 06, 2019 at 09:50:23AM +0100, C=E9dric Le Goater wrote:
[snip]
> >> +static uint64_t pnv_lpc_mmio_read(void *opaque, hwaddr addr, unsigned=
 size)
> >> +{
> >> +    PnvLpcController *lpc =3D PNV_LPC(opaque);
> >> +    uint64_t val =3D 0;
> >> +    uint32_t opb_addr =3D addr & ECCB_CTL_ADDR_MASK;
> >> +    MemTxResult result;
> >> +
> >> +    switch (size) {
> >> +    case 4:
> >> +        val =3D address_space_ldl(&lpc->opb_as, opb_addr, MEMTXATTRS_=
UNSPECIFIED,
> >> +                                &result);
> >> +        break;
> >> +    case 1:
> >> +        val =3D address_space_ldub(&lpc->opb_as, opb_addr, MEMTXATTRS=
_UNSPECIFIED,
> >> +                                 &result);
> >> +        break;
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB read failed at @0x%"
> >> +                      HWADDR_PRIx " invalid size %d\n", addr, size);
> >> +        return 0;
> >> +    }
> >> +
> >> +    if (result !=3D MEMTX_OK) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB read failed at @0x%"
> >> +                      HWADDR_PRIx "\n", addr);
> >> +    }
> >> +
> >> +    return val;
> >=20
> > Couldn't you just map the relevant portion of the OPB AS into the MMIO
> > AS, rather than having to forward the IOs with explicit read/write
> > functions?
>=20
> The underlying memory regions (ISA space, LPC HC, OPB regs) are the
> same on POWER8. So this is one way to share the overall initialization.=
=20

I don't understand how that relates to my question.  If anything that
sounds like it makes even more sense to map the common MR with the
actual registers into the MMIO AS as a subregion, rather than having a
redirect via the OPB AS.

> What I would have liked to do is to simplified the ECCB interface=20
> (see pnv_lpc_do_eccb()).
>=20
> Thanks,
>=20
> C.=20
>=20
>=20
> >> +}
> >> +
> >> +static void pnv_lpc_mmio_write(void *opaque, hwaddr addr,
> >> +                                uint64_t val, unsigned size)
> >> +{
> >> +    PnvLpcController *lpc =3D PNV_LPC(opaque);
> >> +    uint32_t opb_addr =3D addr & ECCB_CTL_ADDR_MASK;
> >> +    MemTxResult result;
> >> +
> >> +    switch (size) {
> >> +    case 4:
> >> +        address_space_stl(&lpc->opb_as, opb_addr, val, MEMTXATTRS_UNS=
PECIFIED,
> >> +                          &result);
> >> +         break;
> >> +    case 1:
> >> +        address_space_stb(&lpc->opb_as, opb_addr, val, MEMTXATTRS_UNS=
PECIFIED,
> >> +                          &result);
> >> +        break;
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB write failed at @0x%"
> >> +                      HWADDR_PRIx " invalid size %d\n", addr, size);
> >> +        return;
> >> +    }
> >> +
> >> +    if (result !=3D MEMTX_OK) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB write failed at @0x%"
> >> +                      HWADDR_PRIx "\n", addr);
> >> +    }
> >> +}
> >> +
> >> +static const MemoryRegionOps pnv_lpc_mmio_ops =3D {
> >> +    .read =3D pnv_lpc_mmio_read,
> >> +    .write =3D pnv_lpc_mmio_write,
> >> +    .impl =3D {
> >> +        .min_access_size =3D 1,
> >> +        .max_access_size =3D 4,
> >> +    },
> >> +    .endianness =3D DEVICE_BIG_ENDIAN,
> >> +};
> >> +
> >>  static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
> >>  {
> >>      bool lpc_to_opb_irq =3D false;
> >> @@ -465,6 +627,43 @@ static const TypeInfo pnv_lpc_power8_info =3D {
> >>      }
> >>  };
> >> =20
> >> +static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    PnvLpcController *lpc =3D PNV_LPC(dev);
> >> +    PnvLpcClass *plc =3D PNV_LPC_GET_CLASS(dev);
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    plc->parent_realize(dev, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >> +    /* P9 uses a MMIO region */
> >> +    memory_region_init_io(&lpc->xscom_regs, OBJECT(lpc), &pnv_lpc_mmi=
o_ops,
> >> +                          lpc, "lpcm", PNV9_LPCM_SIZE);
> >> +}
> >> +
> >> +static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +    PnvLpcClass *plc =3D PNV_LPC_CLASS(klass);
> >> +
> >> +    dc->desc =3D "PowerNV LPC Controller POWER9";
> >> +
> >> +    plc->psi_irq =3D PSIHB9_IRQ_LPCHC;
> >> +
> >> +    device_class_set_parent_realize(dc, pnv_lpc_power9_realize,
> >> +                                    &plc->parent_realize);
> >> +}
> >> +
> >> +static const TypeInfo pnv_lpc_power9_info =3D {
> >> +    .name          =3D TYPE_PNV9_LPC,
> >> +    .parent        =3D TYPE_PNV_LPC,
> >> +    .instance_size =3D sizeof(PnvLpcController),
> >> +    .class_init    =3D pnv_lpc_power9_class_init,
> >> +};
> >> +
> >>  static void pnv_lpc_realize(DeviceState *dev, Error **errp)
> >>  {
> >>      PnvLpcController *lpc =3D PNV_LPC(dev);
> >> @@ -540,6 +739,7 @@ static void pnv_lpc_register_types(void)
> >>  {
> >>      type_register_static(&pnv_lpc_info);
> >>      type_register_static(&pnv_lpc_power8_info);
> >> +    type_register_static(&pnv_lpc_power9_info);
> >>  }
> >> =20
> >>  type_init(pnv_lpc_register_types)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qZVVwWJgpX9Jzs7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBtPgACgkQbDjKyiDZ
s5JthBAAggXa+xcX6dgmKWux6w7WESruZxyBU5weXEmvT8safeHf99uxJZ4iSN3f
wQ0NY1NaMDfKC362UnAWiX7M8OTlkIyMdgPxMuTNvnvdGWn4St0RfvSRDWbetHnk
GTnd5HJ5lNy++uJpMQKUeRs4U/BeKujGYeyRx9E73rPGeoi6W3bwRnwwTbYkA+a7
cQQfwPDTPj98h9l8sKGVxo3xKHftrg4gfTEOK5uP8FLBBoCM2hVWZiMpycNsmz1Z
/sGYjlAmD/2z2eIJxLGsDha3Mf9Kmn/NORUSsATAscHOn8qXTaR2bmirkz/Ysj6U
ALPiCdxBtL2IBjRlWdSCVnbA2eHE0MQ6OJghkruboapf9vkQ94csT6Xkj6yjnNb6
oiFWYmV9kF0jWBmY+htA55L2miLibQBRukRWsg1VvdSDQUIs1oB09Rfi9AJogfhZ
xi5/DYqrsW0n2JBOh+BwojXnGwwfohiXciK4jMmd/SDLP5I4XuHCYLJHZztC5Iny
Almlii6lMA7bwj4oMsbrwRBY1kwCPQkZ3gXDrEdJ+fjW8OEdI9GDPizf3CZfPFH9
e7+5ihM0I/uJD1UJnRLpx9otFNKU6RVsG5Wd0IhyVS6tfapRFl7GoxppdEo55/2/
qgZZy+SsF9m/IfdTaTCgxYTrBJjv1zY2eDcnj2H+Eb2Oavm2NK0=
=biqf
-----END PGP SIGNATURE-----

--qZVVwWJgpX9Jzs7f--
