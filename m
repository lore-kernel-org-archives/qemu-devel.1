Received: from eggs.gnu.org ([2001:4830:134:3::10]:41931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRu5-0004RA-Tv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 21:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRu1-0003ZZ-Q1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 21:27:21 -0400
Date: Wed, 20 Jun 2018 11:22:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620012240.GH3546@umbus.fritz.box>
References: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
	<152937387811.15330.6346338944477555198@sif>
	<20180619131128.17a22f15@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <20180619131128.17a22f15@bahia.lan>
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


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 01:11:28PM +0200, Greg Kurz wrote:
> On Mon, 18 Jun 2018 21:04:38 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>=20
> > Quoting Greg Kurz (2018-05-22 12:17:28)
> > > The spapr capability framework was introduced in QEMU 2.12. It allows
> > > to have an explicit control on how host features are exposed to the
> > > guest. This is especially needed to handle migration between hetero-
> > > geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
> > > workarounds against speculative execution vulnerabilities to guests.
> > > The framework was hence backported to QEMU 2.11.1, especially these
> > > commits:
> > >=20
> > > 0fac4aa93074 spapr: Add pseries-2.12 machine type
> > > 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
> > >  optional capability
> > >=20
> > > 0fac4aa93074 has the confusing effect of making pseries-2.12 the defa=
ult
> > > machine type for QEMU 2.11.1, instead of the expected pseries-2.11. T=
his
> > > patch changes the default machine back to pseries-2.11.
> > >=20
> > > Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2=
=2E11.
> > > This isn't supported by TCG and breaks 'make check'. So this patch al=
so
> > > adds a hack to turn HTM off when using TCG. =20
> >=20
> > I noticed this ends up breaking TCG migration for 2.11.2 -> 2.12, I
> > get this on the target side even when specifying -machine
> > pseries-2.11,cap-htm=3Doff for both ends:
> >=20
> >   qemu-system-ppc64: cap-htm higher level (1) in incoming stream than o=
n destination (0)
> >   qemu-system-ppc64: error while loading state for instance 0x0 of devi=
ce 'spapr'
> >   qemu-system-ppc64: load of migration failed: Invalid argument
> >=20
> > I'm not sure we care all that much about it but it's a regression from =
2.11.1
> > at least. The main issue seems to be the default caps for 2.11.2 for TC=
G are
> > now different from 2.11 and 2.12+, but spapr_cap_##cap##_needed still a=
ssumes
> > everything is the same across all these versions and as such opts not to
> > migrate cap-htm=3Doff, since that's the default for 2.11.2. This result=
s in the
> > target assuming the source was using the default, which is cap-htm=3Don,
> > and since that disagrees with the spapr->eff we get a failure.
> >=20
> > It seems spapr_cap_##cap##_needed needs to be fixed up to address that,
> > but I'm not sure how best to deal with backward compatibility in that c=
ase.
> > Any ideas? If it ends up being a trade-off I think forward compatibilit=
y is
> > more important.
> >=20
>=20
> Yeah, we shouldn't change the default since it affects the migration logi=
c :-\
>=20
> The motivation behind this hack is to fix TCG based 'make check', because
> it doesn't pass cap-htm=3Doff, and thus can't run with pseries-2.11.
>=20
> Another possibility is to let the default as is, and to disable HTM after=
 the
> default caps have been applied.
>=20
> Something like that squashed into this patch:
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 82043e60e78b..26e6be043b18 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -285,11 +285,6 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPR=
MachineState *spapr,
> =20
>      caps =3D smc->default_caps;
> =20
> -    /* HACK for 2.11.2: fix make check */
> -    if (tcg_enabled()) {
> -        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> -    }
> -
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
>                            0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> @@ -405,6 +400,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
>          }
>      }
> =20
> +    /* HACK for 2.11.2: fix make check */
> +    if (tcg_enabled()) {
> +        spapr->eff.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> +    }
> +
>      /* .. then apply those caps to the virtual hardware */
> =20
>      for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> ---------------------

Nooooo!  The whole point of the caps stuff is to stop changing guest
visible behaviours based on host side configuration like the
accelerator.  So, really, let's not put it back in.

The correct fix is to add cap-htm=3Doff to the testcases.  Gross, but
necessary.


>=20
> This allows:
> - TCG 'make check' to be happy with pseries-2.11
> - 2.11.2 --> 2.12 migration and backward
>=20
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/ppc/spapr.c      |    4 ++--
> > >  hw/ppc/spapr_caps.c |    5 +++++
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 1a2dd1f597d9..6499a867520f 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(Ma=
chineClass *mc)
> > >      /* Defaults for the latest behaviour inherited from the base cla=
ss */
> > >  }
> > >=20
> > > -DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> > > +DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> > >=20
> > >  /*
> > >   * pseries-2.11
> > > @@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(Ma=
chineClass *mc)
> > >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
> > >  }
> > >=20
> > > -DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> > > +DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> > >=20
> > >  /*
> > >   * pseries-2.10
> > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > index 7b229517be38..82043e60e78b 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -285,6 +285,11 @@ static sPAPRCapabilities default_caps_with_cpu(s=
PAPRMachineState *spapr,
> > >=20
> > >      caps =3D smc->default_caps;
> > >=20
> > > +    /* HACK for 2.11.2: fix make check */
> > > +    if (tcg_enabled()) {
> > > +        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > +    }
> > > +
> > >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> > >                            0, spapr->max_compat_pvr)) {
> > >          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > >  =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsprF4ACgkQbDjKyiDZ
s5K6Tw/+IEcS1U5fRPuVHntqPI+KXLCkGYMpJF4IVqI0P/gwH+7pXQg+VrBKW7s9
m/SH2MUcCYYGefwMsJ64WiRp66l3/OjV1rzgJKF2BYI8uCvVOz7zVyceAzyNE5Tf
7BiDAh8OHM7ATAU4SC4Xh9OCjFxPGnRbIo7+2hLwkKxieLaj8Nxc0D5jG5m4+Mj3
CwtvhTXc8Oiu233eIhP/zJoXRQn7RJQivu2EUJWbZRdc4bjNSEwCXctl6Eo/j2Er
t6cb1p5P0/7aL5wXXf5PRb3zFDmF/IrkZichlc1ZIe9cMBm0S3Xr33ow8EdIkve0
OIXvmDiU25HwWNLJ97igytUMD3HHLYUuHuXlGTbgXgWtHhTLQpc+9skO3I6mNG/E
AB/O5ivPde6bSiM12WsGIcfFvMHkMf8hazhwjpYIGCo8Co0ZwCS8OA94GN3QvzWv
H3hHMa6AszGm/7JrvH1sPuVJZrjC/yoz3VPIf2mciWdP55EWXhJh9ZGwPinXeU0F
YsCb+0Ip7krRVLh13gLNRCs0JMYuU2KPNFPtyLMKaBRty2IJtoTbD1nmnEuaSUud
GmEpHylpfUmfQT9mnENAAJlEYozgLPvmeF/OF9cAbrQMgzayM2gcWhJgOZ31AxPW
prw5Qdu9mkQLkTzsNHowhIhjnMe4qeIstelynvul3hcgWuwdYZ0=
=rfDY
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
