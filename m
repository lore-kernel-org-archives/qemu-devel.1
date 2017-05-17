Received: from eggs.gnu.org ([2001:4830:134:3::10]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAtGf-0002ij-0v
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAtGa-0003uK-Ql
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:21:09 -0400
Date: Wed, 17 May 2017 17:20:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517072031.GO15596@umbus.fritz.box>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-7-git-send-email-bharata@linux.vnet.ibm.com>
	<20170517070049.GN15596@umbus.fritz.box>
	<20170517071539.GB3446@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
Content-Disposition: inline
In-Reply-To: <20170517071539.GB3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 6/6] spapr: Fix migration of Radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 12:45:39PM +0530, Bharata B Rao wrote:
> On Wed, May 17, 2017 at 05:00:49PM +1000, David Gibson wrote:
> > On Wed, May 17, 2017 at 09:19:22AM +0530, Bharata B Rao wrote:
> > > Fix migration of radix guests by ensuring that we issue
> > > KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> > >=20
> > > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > ---
> > >  hw/ppc/spapr.c         | 15 +++++++++++++++
> > >  hw/ppc/spapr_hcall.c   |  1 +
> > >  include/hw/ppc/spapr.h |  1 +
> > >  3 files changed, 17 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 05abfc1..dd1d687 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1443,6 +1443,20 @@ static int spapr_post_load(void *opaque, int v=
ersion_id)
> > >          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offs=
et);
> > >      }
> > > =20
> > > +    if (spapr->patb_entry) {
> > > +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> > > +            err =3D kvmppc_configure_v3_mmu(POWERPC_CPU(first_cpu),
> > > +                                          spapr->patb_flags &
> > > +                                          SPAPR_PROC_TABLE_RADIX,
> > > +                                          spapr->patb_flags &
> > > +                                          SPAPR_PROC_TABLE_GTSE,
> >=20
> > You should be able to work out the things you need here from
> > patb_entry without adding the new patb_flags field.
>=20
> kvmppc_configure_v3_mmu() needs two bools: radix and gtse. The radix
> bit can be implied from patb_entry, I needed patb_flags to get the
> gtse value. Not immediately obvious of how to get gtse bit from patb_entr=
y,
> but let me take a relook.

Oh, sorry, you can't get GTSE from the patb_entry, but you can get it
=66rom the LPCR.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG/m9AAoJEGw4ysog2bOSkuUQAJdI/DkB8WCkaaEGV+LH+oVc
0wt4PKdVtC21tvMmByeFFsUdZ3bcbUzaykTz5k0R0+gG51EZtRcWQwB2yo5IXocQ
ZbyQvkCQ1BQkXskdZ0bwOeE2gxcOvW3bUN9fAC6D1zsJtaLMP/J5hsA5i4bTH/xN
5E83lrXvQWz82FG96p4C89jvsFVawKQO6/YBMPbSZCr9iPWR94Ml/hZEQYcn00ye
XnGBK8w5LTqvXbmiFbpx+NSdS4OkQXRN6MvmJsT/KGAsLe+83PlNg0OENVT6yV5a
7pHrGGJG1/tlsTCRiRtWc6nrfi+inomUiF10FYnmbkRiHmr6rXr8xH+Ukmlh8FVR
OvdF6A9k/RpuNSCXbfBoRQNMbqGJlAzmK+NL9PModKMfqR4ofuLr3bBwn8CiySGX
NabN3GDSgmORs69PidUEtdWV5jeR6aLNqgKP9Pv6f1Z1fvVRh+VCMt9bWiPflK9w
e9C9Kk7GkrxpfFX1qIsAg9vYChk7/ahW9pntHO2QqaUlaGvrKh9qPOgns5DcBaUa
ICteCK/fkYICWTKUvsa0upt1Zj2MulkmUeAsr8ZjFuq3Ruy0FC+G+x7PMOc6KlmH
8pkobo8j2MK9lm+RFVwqH9NjbTN0k+/T03c1bYkQj0nNDji9WK8u6ZGZez1O6ks/
lETSPGE5Bc/5V9aijcIG
=Hdj/
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
