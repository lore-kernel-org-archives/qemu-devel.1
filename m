Received: from eggs.gnu.org ([2001:4830:134:3::10]:45369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM31V-0000wK-Ga
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 21:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM31S-00038j-C0
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 21:31:53 -0500
Date: Tue, 5 Dec 2017 13:24:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205022431.GD3057@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-22-clg@kaod.org>
	<20171204075208.GT2130@umbus.fritz.box>
	<c24567a8-1dd0-2914-0f42-faf251fe3311@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <c24567a8-1dd0-2914-0f42-faf251fe3311@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 21/25] spapr: introduce a helper to map the
 XIVE memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 04:30:36PM +0100, C=E9dric Le Goater wrote:
> On 12/04/2017 08:52 AM, David Gibson wrote:
> > On Thu, Nov 23, 2017 at 02:29:51PM +0100, C=E9dric Le Goater wrote:
> >> When the XIVE interrupt mode is activated, the machine needs to expose
> >> to the guest the MMIO regions use by the controller :
> >>
> >>   - Event State Buffer (ESB)
> >>   - Thread Interrupt Management Area (TIMA)
> >>
> >> Migration will also need to reflect the current interrupt mode in use.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/spapr_xive_hcall.c  | 14 ++++++++++++++
> >>  hw/ppc/spapr.c              |  5 +++++
> >>  include/hw/ppc/spapr_xive.h |  1 +
> >>  3 files changed, 20 insertions(+)
> >>
> >> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
> >> index 60c6c9f4be8f..ba217144878e 100644
> >> --- a/hw/intc/spapr_xive_hcall.c
> >> +++ b/hw/intc/spapr_xive_hcall.c
> >> @@ -933,3 +933,17 @@ void spapr_xive_populate(sPAPRMachineState *spapr=
, int nr_servers,
> >>      _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> >>                       plat_res_int_priorities, sizeof(plat_res_int_pri=
orities)));
> >>  }
> >> +
> >> +void spapr_xive_mmio_map(sPAPRMachineState *spapr)
> >> +{
> >> +    sPAPRXive *xive =3D spapr->xive;
> >> +
> >> +    /* ESBs */
> >> +    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->esb_base);
> >> +
> >> +    /* Thread Management Interrupt Areas */
> >> +    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
> >> +     * region needs some rework in the handlers */
> >> +    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1,
> >> +                    xive->tm_base + (1 << xive->tm_shift));
> >=20
> > You probably shouldn't be exposing the user TIMA in the DT if you're
> > only allowing the OS TIME to be mapped.
>=20
> The specs requires to map both Uset and OS TIMA.

Ok.

> >=20
> >> +}
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 3a62369883cc..734706c18cb3 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1132,6 +1132,7 @@ static void *spapr_build_fdt(sPAPRMachineState *=
spapr,
> >>      } else {
> >>          /* Populate device tree for XIVE */
> >>          spapr_xive_populate(spapr, xics_max_server_number(), fdt, PHA=
NDLE_XICP);
> >> +        spapr_xive_mmio_map(spapr);
> >=20
> > This doesn't belong here, spapr_build_fdt() should _just_ build the
> > fdt, not have side effects on the actual device state.
>=20
> Yes. I will move the rest of the XIVE setup in the reset handler
> before the device tree is built.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlomA10ACgkQbDjKyiDZ
s5LJyRAAmitijNqoOr2DHOMBXzM52XwT7DZx9fhKWOW7e0+CXsMywjXgoyW1NqPJ
EL2XyM01Fx4PpRherRSyPrzZKAsInGvy3XcG4iVcrwNZ5Fm6b0aIwNJ52Rr+zHoK
KaPZt532JfTKOYkTc7obfD1DT27sf4Gnb4PWnWq2vQFToPkTWzW7nxXdyVRj/4ci
EFDKCBFCjx/T3nd34d24aAhf40QWMXoh9wCEkjmw5d9UE4+r970QUZwDyWLKcqD7
iWDU+6o4D0VGK9Pg7xhb/uIWnRnzqopxm/d8aX55+ROQ2jKCA172QYTJM2/qcveB
cBc27aJA5hIO5ZTmqpStN+AF8Yl4POjck+m9kzLPPLtGmsNrMVt4mJ7s8l4UP7s+
RKIOFrpcMZOj5eq3P0FQs0mvS05QpFokM0gvPvjQOlOsF2nyDuAzuGz9fwpFzZz7
04GXV76bIxHte+Ddcrywgf7ROAsGtEPtc39OQBqfLlo9Ce+huxmbv5w1/oMpxvJR
Ipa0gsWkDfe+kpZ3k4/UO1wQr0bpnqEM8dAJV++n0n8GbJ75Nb+pN7BjnTi041Xv
h19Dih9thirsApuIFVb0pYmIWHzgWqnTNGo22cEw4JpQ+C8nuzonJEZoQVx38aHM
2pOWExR6WLOm/mRQqTq1qzsu+ZTeGOSqNi/xdLGoWvd3617XpGg=
=LuRj
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
