Received: from eggs.gnu.org ([2001:4830:134:3::10]:46815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuZe7-0000wL-Ea
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuZe4-0000Gv-7I
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:09:55 -0400
Date: Sun, 2 Apr 2017 16:48:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170402064850.GG16790@umbus.fritz.box>
References: <1490795611-4762-1-git-send-email-clg@kaod.org>
	<1490795611-4762-3-git-send-email-clg@kaod.org>
	<20170330064605.GF22163@umbus>
	<3e6f5e93-6b87-1304-98f7-73c828fe14af@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <3e6f5e93-6b87-1304-98f7-73c828fe14af@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 2/9] spapr: move the IRQ server number
 mapping under the machine
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


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 03:04:47PM +0200, C=E9dric Le Goater wrote:
> On 03/30/2017 08:46 AM, David Gibson wrote:
> > On Wed, Mar 29, 2017 at 03:53:24PM +0200, C=E9dric Le Goater wrote:
> >> This is the second step to abstract the IRQ 'server' number of the
> >> XICS layer. Now that the prereq cleanups have been done in the
> >> previous patch, we can move down the 'cpu_dt_id' to 'cpu_index'
> >> mapping in the sPAPR machine handler.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >> ---
> >>  hw/intc/xics_spapr.c    | 5 ++---
> >>  hw/ppc/spapr.c          | 3 ++-
> >>  hw/ppc/spapr_cpu_core.c | 2 +-
> >>  3 files changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> >> index 58f100d379cb..f05308b897f2 100644
> >> --- a/hw/intc/xics_spapr.c
> >> +++ b/hw/intc/xics_spapr.c
> >> @@ -52,9 +52,8 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
> >>  static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >>                            target_ulong opcode, target_ulong *args)
> >>  {
> >> -    target_ulong server =3D xics_get_cpu_index_by_dt_id(args[0]);
> >>      target_ulong mfrr =3D args[1];
> >> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), server);
> >> +    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
> >> =20
> >>      if (!icp) {
> >>          return H_PARAMETER;
> >> @@ -122,7 +121,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
> >>      }
> >> =20
> >>      nr =3D rtas_ld(args, 0);
> >> -    server =3D xics_get_cpu_index_by_dt_id(rtas_ld(args, 1));
> >> +    server =3D rtas_ld(args, 1);
> >>      priority =3D rtas_ld(args, 2);
> >> =20
> >>      if (!ics_valid_irq(ics, nr) || !xics_icp_get(XICS_FABRIC(spapr), =
server)
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 8aecea3dd10c..b9f7f8607869 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -3024,9 +3024,10 @@ static void spapr_ics_resend(XICSFabric *dev)
> >>      ics_resend(spapr->ics);
> >>  }
> >> =20
> >> -static ICPState *spapr_icp_get(XICSFabric *xi, int server)
> >> +static ICPState *spapr_icp_get(XICSFabric *xi, int cpu_dt_id)
> >>  {
> >>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> >> +    int server =3D xics_get_cpu_index_by_dt_id(cpu_dt_id);
> >=20
> > The idea is good, but this is a bad name (as it was in the original
> > version, too).  The whole point here is that the XICS server number
> > (as it appears in the ICS registers) is the input to this function,
> > and we no longer assume that is equal to cpu_index.
> >=20
> > Seems we could just get the cpu object by dt_id here, then go to ICP(cp=
u->intc).
>=20
> yes that would be nice and this is exactly what pnv does now, but=20
> this is only possible because the PnvICPState objects are allocated=20
> from under PnvCore. This is not the case for sPAPR yet.
>=20
> Currently, when the sPAPR core are realized, we call spapr_cpu_init()=20
> which first gets its ICP with :
>=20
> 	xics_icp_get(xi, cpu->cpu_dt_id);
>=20
> so we cannot use ICP(cpu->intc) in this XICSFabric handler, it is not
> assigned yet. It only will be at the end of spapr_cpu_init() when=20
>=20
> 	xics_cpu_setup(xi, cpu, icp);
>=20
> is called.

Uh.. but spapr_cpu_init() has the spapr pointer and can obviously get
the cpu_index.  So it could look up the right ICP in the array easily
enough instead of using xics_icp_get().

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4J7RAAoJEGw4ysog2bOSCREQAIlOQfp41vruqoFdfBZvqes+
CbjIdmLxXwIdYXXxV3OeAoZFCjbhzhqoCMelZMCvwkXwJ0lar9OibXKYOGOpoJHC
5NgO5r54eGcolUhSbeTIIh5CODKtDRO3MaleU9avvQ/MPQWqEC1e/AxCsMz6rhGc
iv8LrIyarsNRPjuxMdiDnQYJw3Vnbk7JbYjQhtC/ujP+O7UFFuWVQq3i61VifboG
hOD+APyx6ghWpoLo/SCraNm1zY38UO9hu/mpQ5XaP632vk0uPv5JLSmjCLtgcqkw
diud1aQnXTaLts9i4FKv3TF4/XUhd37YYAE14Om7UpQ0Aho0H5lY4b3CEgMqH2id
0YAhYmrGwoWfFw4uqjJNctBh/j/kWCv+qqS96laMWbMEoabsz66WhO9+p+afoMWw
Mhccg9PnFY+YbaQI/J0Mgc72bdiKS5aaF1j6YuhRStphooFg3CPCtpIb6SXcSfSq
nUTdKmQc13Wrsre1cssKIqqHG19s3buDfiuSUl9yeT21hVWln1cAre1Ri/d3nqP9
vs6hRZAUaezYSGDR9QrZyWO7bNGUAXV6ri/HHFOlq5zvh0pJrMfSyskhCTTssgTG
NOezHM/S08KUa/XPv+yCi7akUfsFWQk+oBbEw3K166PIJQCKWeUKMrMnvpZnz74e
YU6ZCpjrWzuIb6TzHl0R
=duZS
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
