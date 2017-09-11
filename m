Received: from eggs.gnu.org ([2001:4830:134:3::10]:46094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drFp8-0001Ys-Eu
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 23:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drFp6-0002ky-UX
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 23:55:50 -0400
Date: Mon, 11 Sep 2017 13:54:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170911035437.GC17405@umbus.fritz.box>
References: <20170908143344.12960-1-clg@kaod.org>
	<20170908143344.12960-4-clg@kaod.org>
	<20170910031942.GZ2735@umbus.fritz.box>
	<48cf83e0-8404-3b1e-2bac-7a0443756ac2@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <48cf83e0-8404-3b1e-2bac-7a0443756ac2@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] spapr: generate a CAS reset for
 the XIVE exploitation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2017 at 09:30:18PM +0200, C=E9dric Le Goater wrote:
> On 09/10/2017 05:19 AM, David Gibson wrote:
> > On Fri, Sep 08, 2017 at 04:33:44PM +0200, C=E9dric Le Goater wrote:
> >> When the platform and the guest agree on using the XIVE exploitation
> >> mode for interrupts, the "interrupt-controller" node needs to reflect
> >> the change and the device tree needs an update.
> >>
> >> Reseting the guest after the CAS negotiation makes this change
> >> possible, as the device tree is built at reset time. We use the
> >> 'ov5_cas' field to check which interrupt model was negotiated before
> >> reset and populate the tree accordingly.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Looks reasonable, though I'm not going to apply it until we actually
> > have something to go..
>=20
> Yes. I agree. A simplified XIVE patchset for sPAPR should be ready=20
> soon for comments. Please see below for one question.
>=20
> >> ---
> >>  hw/ppc/spapr.c       | 6 +++++-
> >>  hw/ppc/spapr_hcall.c | 6 ++++++
> >>  2 files changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 3e3ff1fbc988..be467ab61ad0 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1073,7 +1073,11 @@ static void *spapr_build_fdt(sPAPRMachineState =
*spapr,
> >>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> >> =20
> >>      /* /interrupt controller */
> >> -    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
> >> +    } else {
> >> +        /* populate device tree for XIVE */ ;
> >=20
> > .. here.
>=20
> How should we handle the PHANDLE_XICP for xive ? as it is done
> for xics ?=20
>=20
> The DT node is now :	"interrupt-controller@6030203180000"

Is there just one node that needs to be referenced?  If so, then yes,
the XICS approach of just using a well known phandle for it should be
fine.


>=20
> >> +    }
> >> =20
> >>      ret =3D spapr_populate_memory(spapr, fdt);
> >>      if (ret < 0) {
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 92f1e21358b8..ba00b8d3fdd6 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1613,6 +1613,12 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> >>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
> >>                                            ov5_updates) !=3D 0);
> >>      }
> >> +
> >> +    /* We need to rebuild the device tree for XIVE, generate a reset =
*/
> >> +    if (!spapr->cas_reboot) {
> >> +        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_E=
XPLOIT);
> >> +    }
> >=20
> > At some point we may well want to make XIVE exploitation the default
> > for POWER9 guests, but that's a detail easily adjusted later.
>=20
> ah yes. we can do that.
>=20
> Thanks,
>=20
> C.=20
> =20
> >>      spapr_ovec_cleanup(ov5_updates);
> >> =20
> >>      if (spapr->cas_reboot) {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm2CPkACgkQbDjKyiDZ
s5J90A/8CLXGP7mJAx5u+1QPTH+uB8HAXt5VLue3uMwoKvGwoHwuET2A8VgEswS4
kFKEQycJAu9XXBqRh5C6YCvu4MrpGaGQlE1aTgmApAKucwam9S4fR+VlAODzw589
aDQXJIf22CSDq3pe3Iee3fTNOZg1chjANbl8/tJCKf3Qzc6EqKHQxGR2ChWR9LrE
Tsi4hPEuFirA37VYDCjuNYckyGFRcJDANZIY3PFK/mkVhRRpMYMci9smuilc398X
V9pO/52G3v1i4jpfIEww4w+m7+FLd8Mnh0ilu+DgD4dhtqpvMb6wAn7x+aKAYUeR
R0ffUkiQPmOcju88QYhEMWDdWVSUdalml65Fiq4MtnRVuyj68dr3oGKh/8sT6qNV
X4I8bo+4zF3sOPdsjNzGBnnQ33clghAu2eqzd7bTgxqz2od2vVRIpkHfBKYTidPd
8sbsrsXFI2ftSGow/O8TykKoPlqHCt/TD2Z6nyVPjV677/KJv7EIewb92ni9N0mQ
AIkngouC2riVEoqymYaBN+o2hsMFFlxdjP806a2+Lzyak1R3Ll4m0zDeXJLNRSZo
63zBglUI4coeSDVHRJqzsfnl0idvvPeA9maUIXhQ9bT9k/etzjT1VKcl9l4LxO7W
MXQBzvae+t3OJ4s6Cmb7Q8lVYrrb56adwgwVLL6uOMZ4XqySt40=
=195x
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
