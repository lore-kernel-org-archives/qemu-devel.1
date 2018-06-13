Received: from eggs.gnu.org ([2001:4830:134:3::10]:44176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSxNi-0004nu-Hj
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSxNh-0002NT-4Y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:27:38 -0400
Date: Wed, 13 Jun 2018 14:27:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613042726.GU30690@umbus.fritz.box>
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-3-clg@kaod.org>
	<20180526114023.49ee54e9@bahia.lan>
	<20180605034418.GV5140@umbus.fritz.box>
	<e9631178-7bd1-170a-ff28-f1ab717cb8bf@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QXliVHAuIB9eJ4yJ"
Content-Disposition: inline
In-Reply-To: <e9631178-7bd1-170a-ff28-f1ab717cb8bf@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/4] sparp_pci: simplify how the PCI LSIs
 are allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>


--QXliVHAuIB9eJ4yJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 08:31:49AM +0200, C=E9dric Le Goater wrote:
> On 06/05/2018 05:44 AM, David Gibson wrote:
> > On Sat, May 26, 2018 at 11:40:23AM +0200, Greg Kurz wrote:
> >> On Fri, 18 May 2018 18:44:03 +0200
> >> C=E9dric Le Goater <clg@kaod.org> wrote:
> >>
> >>> PCI LSIs are today allocated one by one using the IRQ alloc_block
> >>> routine. Change the code sequence to first allocate a PCI_NUM_PINS
> >>> block. It will help us providing a generic IRQ framework to the
> >>> machine.
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>> ---
> >>>  hw/ppc/spapr_pci.c | 21 ++++++++++-----------
> >>>  1 file changed, 10 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> >>> index 39a14980d397..4fd97ffe4c6e 100644
> >>> --- a/hw/ppc/spapr_pci.c
> >>> +++ b/hw/ppc/spapr_pci.c
> >>> @@ -1546,6 +1546,8 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> >>>      sPAPRTCETable *tcet;
> >>>      const unsigned windows_supported =3D
> >>>          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> >>> +    uint32_t irq;
> >>> +    Error *local_err =3D NULL;
> >>> =20
> >>>      if (!spapr) {
> >>>          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pserie=
s machine");
> >>> @@ -1694,18 +1696,15 @@ static void spapr_phb_realize(DeviceState *de=
v, Error **errp)
> >>>      QLIST_INSERT_HEAD(&spapr->phbs, sphb, list);
> >>> =20
> >>>      /* Initialize the LSI table */
> >>> -    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >>> -        uint32_t irq;
> >>> -        Error *local_err =3D NULL;
> >>> -
> >>> -        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &local_=
err);
> >>> -        if (local_err) {
> >>> -            error_propagate(errp, local_err);
> >>> -            error_prepend(errp, "can't allocate LSIs: ");
> >>> -            return;
> >>> -        }
> >>> +    irq =3D spapr_irq_alloc_block(spapr, PCI_NUM_PINS, true, false, =
&local_err);
> >>> +    if (local_err) {
> >>> +        error_propagate(errp, local_err);
> >>> +        error_prepend(errp, "can't allocate LSIs: ");
> >>> +        return;
> >>> +    }
> >>> =20
> >>
> >> It isn't strictly equivalent. The current code would be happy with
> >> sparse IRQ numbers, while the proposed one wouldn't... Anyway, this
> >> cannot happen since we don't have PHB hotplug.
> >=20
> > This makes me pretty nervous, because it's not obvious it will come up
> > with the same numbers in all circumstances, which we have to do for
> > existing machine types.
>=20
> Given that :=20
>=20
>  - irq_hint is "unused"
>  - all IRQs are allocated sequentially at machine init, =20
>  - spapr_pci is the only model using the block allocation for MSIs,=20
>    potentially fragmenting more the IRQ number space but done at=20
>    guest runtime.=20
>  - the PHB LSI are the allocated at realize time doing the loop above,=20
>  - we don't support PHB hotplug=20
>  - we do support PHB coldplug but then the IRQ allocation is done
>    at machine time,
>=20
> it seems highly improbable that the IRQ number space is fragmented
> to a point which would not allow the loop above to return four=20
> contiguous IRQ numbers, always.

Well, assuming irq_hint really is unused, that's right.  But we can't
assume that - that's the whole point of the deprecation thing.

Given that, AIUI, just one vio device with irq=3D set to a value that
would be within an LSI block allocated under the old scheme would
result in the new scheme returning a non-contiguous set of LSIs -
i.e. a different result from what we used to have.

> That is why I felt confident changing the loop to a single block=20
> allocation.=20
>=20
> > It's also not obvious to me why it's useful
> > to go via this step before going straight to static allocation of the
> > irq numbers.
>=20
> It pollutes the new sPAPR IRQ interface API with an extra parameter=20
> to support both underlying backend and it complexifies the code=20
> to handle block allocation of a single IRQ (like above) within an=20
> IRQ range (the PCI LSIs).
>=20
> So you end up having a family, a device index, a count, an alignment,
> and an index within the range. pffut.
>=20
> Also, could we kill the alignment ?

Since we sometimes pass 'true', no, we can't, without changing the
existing pattern of allocations, which we can't do.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QXliVHAuIB9eJ4yJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgnS4ACgkQbDjKyiDZ
s5K0gg/+P4qX0md9IOBmiidI35ZcAXZGqKB/qg//gCV4soBilNbyCEVvOvh9xZn6
wYchOWY90qnHKLCJGqNDisodIBcYUx476w4j78dFsy+V53cz1Sla7LzsC8Z78Ks5
044NTht4nUl43XnxGO6XCgmY2LyOC60tZOf/20doE3aCpsHzps7a/K1eynsuawJ0
P6DTkkq1mH8xr+Lp2PhMG9Pcvdl8ZivbeGmPBI+2XkpBRx1xKvgbXecVmQ0/Jzr/
A2nKEDa+8n2r+8kuRShuCGjywQEn2HQ5Yc2+41ovIOyuqAMwGSb5uguO2fmu4LZM
ewThHqDY1dXEGgG6bCR1mvsVCI5/et0YZC9oUgwA7Av6TWoT4oakJZpWiH/qs/sA
JAF/02pZoXzOAvbW7SQY+sWPjoglY3BYwx95pjmz247XRF+oRVeHTAbl4XwVqMcA
rJWiWgUzifmOC7Sqn4VySbbg1WzPqzHlv1LfrYkKsQN34bZVMlpmgoQhyx3ipWrF
80uIVmquN7w9MyYP0k7M+OFjrhYIGDl8/FwPH/BN4XKZK/1cyiz+Wak3sj7eDuz1
18I6KPIVT3oodyg0w0fMwejD3ltlYnkbyqhBbrNaIPaScy48uCd2La6naxdu2jl5
p9+Kr0j+1EEDJsnkwGybh59wJ/x3rkcSqQwE/Fy8k8i+j/gPld8=
=67U5
-----END PGP SIGNATURE-----

--QXliVHAuIB9eJ4yJ--
