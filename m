Received: from eggs.gnu.org ([2001:4830:134:3::10]:37924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhSGp-0007wy-S7
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhSGn-0004bt-Ud
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:16:27 -0400
Date: Mon, 23 Jul 2018 14:16:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180723041614.GD6830@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<bc6c5befa0a24b35f439419d6dea493dc19035b9.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline
In-Reply-To: <bc6c5befa0a24b35f439419d6dea493dc19035b9.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 06:03:29PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-07-18 at 16:12 +1000, David Gibson wrote:
> > On Thu, Jun 28, 2018 at 10:36:32AM +0200, C=E9dric Le Goater wrote:
> > > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Can you trim your replies ? It's really hard to find your comments in
> such a long patch...
>=20
> > > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > > index 6ac8a9392da6..966a996c2eac 100644
> > > --- a/include/hw/ppc/xics.h
> > > +++ b/include/hw/ppc/xics.h
> > > @@ -194,6 +194,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
> > >  uint32_t icp_accept(ICPState *ss);
> > >  uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
> > >  void icp_eoi(ICPState *icp, uint32_t xirr);
> > > +void icp_irq(ICSState *ics, int server, int nr, uint8_t priority);
> >=20
> > Hrm... are you sure you need to expose this?

[snip]
> > > +    limit =3D pci_config_size(pdev);
> > > +    if (limit <=3D cfg_addr) {
> > > +        /* conventional pci device can be behind pcie-to-pci bridge.
> > > +           256 <=3D addr < 4K has no effects. */
> > > +        return ~0ull;
> > > +    }
> > > +    val =3D pci_host_config_read_common(pdev, cfg_addr, limit, size);
> > > +    switch (size) {
> > > +    case 1:
> > > +        return val;
> > > +    case 2:
> > > +        return bswap16(val);
> > > +    case 4:
> > > +        return bswap32(val);
> > > +    default:
> > > +        g_assert_not_reached();
> > > +    }
> > > +}
> > > +
> > > +static void pnv_phb3_check_m32(PnvPHB3 *phb)
> > > +{
> > > +    uint64_t base, start, size;
> > > +    MemoryRegion *parent;
> > > +    PnvPBCQState *pbcq =3D &phb->pbcq;
> > > +
> > > +    if (phb->m32_mapped) {
> > > +        memory_region_del_subregion(phb->mr_m32.container, &phb->mr_=
m32);
> > > +        phb->m32_mapped =3D false;
> >=20
> > Could you use memory_region_set_enabled() rather than having to add
> > and delete the subregion and keep track of it in this separate
> > variable?
>=20
> There was a reason for that but it's years old and I forgot... I think
> when re-enabled it moves around, among other things. So it's not more
> efficient.

Hm, ok.  It'd be good to know what this is.

> > > +    }
> > > +
> > > +    /* Disabled ? move on with life ... */
> >=20
> > Trivial: "nothing to do" seems to be the standard way to express this.
> > Even trivialler: usual English rules don't put a space before '?' or
> > '!' punctuation.
>=20
> No, that's the tasteless English rule :-) It shall be overridden by
> anybody interested in making things actually readable :-)
>=20
> > > +
> > > +static void pnv_phb3_lxivt_write(PnvPHB3 *phb, unsigned idx, uint64_=
t val)
> > > +{
> > > +    ICSState *ics =3D &phb->lsis;
> > > +    uint8_t server, prio;
> > > +
> > > +    phb->ioda_LXIVT[idx] =3D val & (IODA2_LXIVT_SERVER |
> > > +                                  IODA2_LXIVT_PRIORITY |
> > > +                                  IODA2_LXIVT_NODE_ID);
> > > +    server =3D GETFIELD(IODA2_LXIVT_SERVER, val);
> > > +    prio =3D GETFIELD(IODA2_LXIVT_PRIORITY, val);
> > > +
> > > +    /*
> > > +     * The low order 2 bits are the link pointer (Type II interrupts=
).
> >=20
> > I don't think we've currently implemented link pointers in our xics
> > code.  Do we need to do that?
>=20
> Not until somebody uses them (other than pHyp).
>=20
> > > +     * Shift back to get a valid IRQ server.
> > > +     */
> > > +    server >>=3D 2;
> > > +
> > > +    ics_simple_write_xive(ics, idx, server, prio, prio);
> > > +}
> > > +
> > > +static uint64_t *pnv_phb3_ioda_access(PnvPHB3 *phb,
> > > +                                      unsigned *out_table, unsigned =
*out_idx)
> > > +{
> > > +    uint64_t adreg =3D phb->regs[PHB_IODA_ADDR >> 3];
> > > +    unsigned int index =3D GETFIELD(PHB_IODA_AD_TADR, adreg);
> > > +    unsigned int table =3D GETFIELD(PHB_IODA_AD_TSEL, adreg);
> > > +    unsigned int mask;
> > > +    uint64_t *tptr =3D NULL;
> > > +
> > > +    switch (table) {
> > > +    case IODA2_TBL_LIST:
> > > +        tptr =3D phb->ioda_LIST;
> > > +        mask =3D 7;
> >=20
> > I'd suggest hex for the masks.
>=20
> This is more readable when matched with the documentation but not a big
> deal.

Matching the docs is a good enough reason to keep decimal.

> > > +        break;
> > > +    case IODA2_TBL_LXIVT:
> > > +        tptr =3D phb->ioda_LXIVT;
> > > +        mask =3D 7;
> > > +        break;
> > > +    case IODA2_TBL_IVC_CAM:
> > > +    case IODA2_TBL_RBA:
> > > +        mask =3D 31;
> > > +        break;
> > > +    case IODA2_TBL_RCAM:
> > > +        mask =3D 63;
> > > +        break;
> > > +    case IODA2_TBL_MRT:
> > > +        mask =3D 7;
> > > +        break;
> > > +    case IODA2_TBL_PESTA:
> > > +    case IODA2_TBL_PESTB:
> > > +        mask =3D 255;
> > > +        break;
> > > +    case IODA2_TBL_TVT:
> > > +        tptr =3D phb->ioda_TVT;
> > > +        mask =3D 511;
> > > +        break;
> > > +    case IODA2_TBL_TCAM:
> > > +    case IODA2_TBL_TDR:
> > > +        mask =3D 63;
> > > +        break;
> > > +    case IODA2_TBL_M64BT:
> > > +        tptr =3D phb->ioda_M64BT;
> > > +        mask =3D 15;
> > > +        break;
> > > +    case IODA2_TBL_M32DT:
> > > +        tptr =3D phb->ioda_MDT;
> > > +        mask =3D 255;
> > > +        break;
> > > +    case IODA2_TBL_PEEV:
> > > +        tptr =3D phb->ioda_PEEV;
> > > +        mask =3D 3;
> > > +        break;
> > > +    default:
> > > +        return NULL;
> > > +    }
> > > +    index &=3D mask;
> >=20
> > Do we want to silently mask, rather than logging an error if there's
> > an access out of bounds for a particular table?
>=20
> We could do both, as to behave like the HW but also flag an error.

Sounds reasonable.

> But
> you have to be careful with the auto-increment below.

Hm, ok.

> > > +    if (out_idx) {
> > > +        *out_idx =3D index;
> > > +    }
> > > +    if (out_table) {
> > > +        *out_table =3D table;
> > > +    }
> > > +    if (adreg & PHB_IODA_AD_AUTOINC) {
> > > +        index =3D (index + 1) & mask;
> > > +        adreg =3D SETFIELD(PHB_IODA_AD_TADR, adreg, index);
> > > +    }
> > > +    if (tptr) {
> > > +        tptr +=3D index;
> > > +    }
> > > +    phb->regs[PHB_IODA_ADDR >> 3] =3D adreg;
> > > +    return tptr;
> > > +}
>=20
>  ../..
>=20
> > > +    if ((comp & mask) !=3D comp) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                      "IRQ compare bits not in mask: comp=3D0x%x mas=
k=3D0x%x",
> > > +                      comp, mask);
> > > +        comp &=3D mask;
> > > +    }
> > > +    /* Setup LSI offset */
> > > +    ics->offset =3D comp + global;
> >=20
> > Oh.. changing ICS offset at runtime.  I hadn't considered that case..
>=20
> As above, see further down.
>=20
> > > +    /* Special case configuration data */
> > > +    if ((off & 0xfffc) =3D=3D PHB_CONFIG_DATA) {
> > > +        pnv_phb3_config_write(phb, off & 0x3, size, val);
> > > +        return;
> > > +    }
> > > +
> > > +    /* Other registers are 64-bit only */
> > > +    if (size !=3D 8 || off & 0x7) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                      "Invalid register access, offset: 0x%"PRIx64" =
size: %d",
> > > +                      off, size);
> > > +        return;
> > > +    }
> > > +
> > > +    /* Handle masking */
> > > +    switch (off) {
> > > +    case PHB_M64_UPPER_BITS:
> >=20
> > Couldn't you handle this in the switch below - it should be ok to
> > momentarily have the invalid bits set in your reg case, as long as you
> > mask them before applying the side-effects, yes?
>=20
> That felt easier that way ...
>=20
> > That said... shouldn't you filter our invalid or read-only regs before
> > updating the cache?
>=20
> Well, I had a reason for doing it that way, I do have a vague memory of
> that but I can't remember it now :-)
>=20
> > > +/*
> > > + * MSI/MSIX memory region implementation.
> > > + * The handler handles both MSI and MSIX.
> > > + */
> > > +static void pnv_phb3_msi_write(void *opaque, hwaddr addr,
> > > +                               uint64_t data, unsigned size)
> > > +{
> > > +    PnvPhb3DMASpace *ds =3D opaque;
> > > +
> > > +    /* Resolve PE# */
> > > +    if (!pnv_phb3_resolve_pe(ds)) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                      "Failed to resolve PE# for bus @%p (%d) devfn =
0x%x",
> > > +                      ds->bus, pci_bus_num(ds->bus), ds->devfn);
> > > +        return;
> > > +    }
> > > +
> > > +    pnv_phb3_msi_send(&ds->phb->msis, addr, data, ds->pe_num);
> > > +}
> > > +
> > > +static const MemoryRegionOps pnv_phb3_msi_ops =3D {
> > > +    /* There is no .read as the read result is undefined by PCI spec=
 */
> >=20
> > What will qemu do if it hits a NULL read here?  The behaviour may be
> > undefind, but we'd prefer it didn't crash qemu..
>=20
> Yeah.

[snip]
> > > +    /*
> > > +     * The low order 2 bits are the link pointer (Type II interrupts=
).
> > > +     * Shift back to get a valid IRQ server.
> > > +     */
> > > +    server >>=3D 2;
> > > +
> > > +    switch (pq) {
> > > +    case 0: /* 00 */
> > > +        if (prio =3D=3D 0xff) {
> > > +            /* Masked, set Q */
> > > +            phb3_msi_set_q(msi, srcno);
> > > +        } else {
> > > +            /* Enabled, set P and send */
> > > +            phb3_msi_set_p(msi, srcno, gen);
> > > +            icp_irq(ics, server, srcno + ics->offset, prio);
> >=20
> > Can't you just pulse the right qirq here, which will use the core ICS
> > logic to propagate to the ICP?
>=20
> Ok, interrupts ... sooooo...
>=20
> This code predates a pile of XICS work you guys did to start with.
>=20
> Now, this is an ICS subclass, so why shouldn't it directly poke at the
> target ICP ?

That's ok in theory, but causing it to expose the icp interface to a
new module isn't great.

> It's an alternate to the normal ICS since it behaves a bit
> differently (PQ bits & all).

AFAICT the PQ bits are effectively another filtering layer on top of
the same ICS logic as elsewhere.  I think it's better if we can share
that shared logic, rather than replicating it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltVVo4ACgkQbDjKyiDZ
s5LzqBAAprXRdaRNSFgdk38/lzc2FC9A2dWShL0EpUfUel0IAvw13W+khqQVoPRa
QEdpxPAKuf64uLhwLTfvbSoBoiL2qKRIm4H9vmYxDY+T3KzFYPe+C3tCFl3gTtot
xMqbFCfSmbyuoToEnL381qcGl4Qxuc0yiO0SGJUOR4EqkxY7GOeBulflm2zCatYy
0chwV/CDuHdMxjRM4AgP1n1Q0Bc5/KSdMzZVUqTQrek8fRHHJN7c2nJSoI9G9ZBs
kEybzjsHW80ikceoQn+HkaQup8az1qQz8pCGY6gMy1drijpfbh14qaMj8rO6JFXG
Me/LuEze8W5EtHC8v/0JgUqAcAzMHg08Kr1ulMxocHq4Pfbva6IPBhdgtqJDECD3
c2vXK8Mni+l7Ia7vMQMLGsDgFMRKbppGsSA4REtiz0a4vwlLnID/xv/NdQXRkCJP
jrZbF8ehp5jLAL61bcfnIhZNDLcTjWgg0OjsGxyTq8VBAxsJuQrAvlOyKUg/y5/X
BcQ/j9G2N7LCVDQvz7+5G+FHcmv+O3XmoOKgcqTcM7eLRFmyt+Owaw+866B2wCLV
PBDvGfB8eRlmsZvX7SrUO5/VBljF00zvvTjPIvrEtMvzB9pu4Lqmpj5Bp1F5jCQH
9SBkTC6XQPfR2fsYQyCDqXIwyITbDGauI+EnHYRQpbUoWw/X4lU=
=vD5m
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
