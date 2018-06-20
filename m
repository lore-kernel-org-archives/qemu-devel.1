Received: from eggs.gnu.org ([2001:4830:134:3::10]:50808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVb5S-0007Fz-IZ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVb5M-0004r3-IB
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:15:42 -0400
Date: Wed, 20 Jun 2018 19:06:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620090601.GF24636@umbus.fritz.box>
References: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
	<152937387811.15330.6346338944477555198@sif>
	<20180619131128.17a22f15@bahia.lan>
	<20180620012240.GH3546@umbus.fritz.box>
	<20180620092727.62d6a71d@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <20180620092727.62d6a71d@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.11.2] spapr: make pseries-2.11 the
 default machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 09:27:27AM +0200, Greg Kurz wrote:
> On Wed, 20 Jun 2018 11:22:40 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jun 19, 2018 at 01:11:28PM +0200, Greg Kurz wrote:
> > > On Mon, 18 Jun 2018 21:04:38 -0500
> > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > >  =20
> > > > Quoting Greg Kurz (2018-05-22 12:17:28) =20
> > > > > The spapr capability framework was introduced in QEMU 2.12. It al=
lows
> > > > > to have an explicit control on how host features are exposed to t=
he
> > > > > guest. This is especially needed to handle migration between hete=
ro-
> > > > > geneous hosts (eg, POWER8 to POWER9). It is also used to expose f=
ixes/
> > > > > workarounds against speculative execution vulnerabilities to gues=
ts.
> > > > > The framework was hence backported to QEMU 2.11.1, especially the=
se
> > > > > commits:
> > > > >=20
> > > > > 0fac4aa93074 spapr: Add pseries-2.12 machine type
> > > > > 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as =
an
> > > > >  optional capability
> > > > >=20
> > > > > 0fac4aa93074 has the confusing effect of making pseries-2.12 the =
default
> > > > > machine type for QEMU 2.11.1, instead of the expected pseries-2.1=
1. This
> > > > > patch changes the default machine back to pseries-2.11.
> > > > >=20
> > > > > Unfortunately, 9070f408f491 enforces the HTM capability for pseri=
es-2.11.
> > > > > This isn't supported by TCG and breaks 'make check'. So this patc=
h also
> > > > > adds a hack to turn HTM off when using TCG.   =20
> > > >=20
> > > > I noticed this ends up breaking TCG migration for 2.11.2 -> 2.12, I
> > > > get this on the target side even when specifying -machine
> > > > pseries-2.11,cap-htm=3Doff for both ends:
> > > >=20
> > > >   qemu-system-ppc64: cap-htm higher level (1) in incoming stream th=
an on destination (0)
> > > >   qemu-system-ppc64: error while loading state for instance 0x0 of =
device 'spapr'
> > > >   qemu-system-ppc64: load of migration failed: Invalid argument
> > > >=20
> > > > I'm not sure we care all that much about it but it's a regression f=
rom 2.11.1
> > > > at least. The main issue seems to be the default caps for 2.11.2 fo=
r TCG are
> > > > now different from 2.11 and 2.12+, but spapr_cap_##cap##_needed sti=
ll assumes
> > > > everything is the same across all these versions and as such opts n=
ot to
> > > > migrate cap-htm=3Doff, since that's the default for 2.11.2. This re=
sults in the
> > > > target assuming the source was using the default, which is cap-htm=
=3Don,
> > > > and since that disagrees with the spapr->eff we get a failure.
> > > >=20
> > > > It seems spapr_cap_##cap##_needed needs to be fixed up to address t=
hat,
> > > > but I'm not sure how best to deal with backward compatibility in th=
at case.
> > > > Any ideas? If it ends up being a trade-off I think forward compatib=
ility is
> > > > more important.
> > > >  =20
> > >=20
> > > Yeah, we shouldn't change the default since it affects the migration =
logic :-\
> > >=20
> > > The motivation behind this hack is to fix TCG based 'make check', bec=
ause
> > > it doesn't pass cap-htm=3Doff, and thus can't run with pseries-2.11.
> > >=20
> > > Another possibility is to let the default as is, and to disable HTM a=
fter the
> > > default caps have been applied.
> > >=20
> > > Something like that squashed into this patch:
> > >=20
> > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > index 82043e60e78b..26e6be043b18 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -285,11 +285,6 @@ static sPAPRCapabilities default_caps_with_cpu(s=
PAPRMachineState *spapr,
> > > =20
> > >      caps =3D smc->default_caps;
> > > =20
> > > -    /* HACK for 2.11.2: fix make check */
> > > -    if (tcg_enabled()) {
> > > -        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > -    }
> > > -
> > >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> > >                            0, spapr->max_compat_pvr)) {
> > >          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > @@ -405,6 +400,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
> > >          }
> > >      }
> > > =20
> > > +    /* HACK for 2.11.2: fix make check */
> > > +    if (tcg_enabled()) {
> > > +        spapr->eff.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > +    }
> > > +
> > >      /* .. then apply those caps to the virtual hardware */
> > > =20
> > >      for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > > --------------------- =20
> >=20
> > Nooooo!  The whole point of the caps stuff is to stop changing guest
> > visible behaviours based on host side configuration like the
> > accelerator.  So, really, let's not put it back in.
> >=20
>=20
> Yes I'm aware of all the work we're doing to hide host details.
> I was just thinking this small violation would be an acceptable
> tradeoff.

The reason I wrote the caps stuff was that I kept finding that
supposedly small violations of this still kept biting us in the arse.

> > The correct fix is to add cap-htm=3Doff to the testcases.  Gross, but
> > necessary.
> >=20
>=20
> Ok, then I'll try to come up with patches ASAP so that Mike can release
> 2.11.2.

After I sent that I did think of some alternatives.  We can't change
the behaviour based on the accelerator, but we might be able to change
it based on qtest_enabled().


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsqGPUACgkQbDjKyiDZ
s5IMEw/4rUfJvVxDE5iRLsVMl+6dmU/lO4TDalJXVhRdhhexpfmMcuLcHUGVENpI
eKwwQ4mm3oIRePHQR2eGQwSxCnUvzC5xbIwgOykFoEbFSjGDdOWAcQKQ2fWRkZL1
ObdzsjBgMUsCbScq4vOWjXOOhBUpjAbaVNjP2EewEEBhkjZfN3AFKe9HdBYS1X7O
8GUfiNx/Co4Y84vR6DWMNMjSbXE8I3M2AhtDymigoiYKKjHOtH2EIHiN53ci0hh1
CWRSpLxiWGGeX6+XkqMOE2wa3t/O3pMTDzaysIFC9P03735E8PX+rIa0jE1zFxAK
lXqlqO4MdRSUqiHEWITZSppkYh+JRZnE0I4cao7yrKFl7EDymphySvmJrJQD8IVM
zsAUk20n0X2ipb+QGIrkO3KLjKPzIpFsrd0ULKYieoIAgEyfUr/cauD6kqAWzS8e
Qmd56yG5VZTmoCK3a/Zd4b+iqtj74+lzObhTbFJ0+WknfbwaTYnNbAJdGvPP4D3N
q0uv/oMq6D993+a1eCeV0m0nxu7uht/8istty2iDfxxRQS+laVIlpAuqJGRR3Bwx
uKhWHmUerR/N0OWoPofVTjVyKFAMpLPVbx3jgp/yLunc7hP5XRpdVU/lF6HByoJU
xCngHIcPNfMQe2DmNsgLlMlCf0CsQWNO9QyQeLP/LVhCge4m7w==
=JXRj
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
