Received: from eggs.gnu.org ([2001:4830:134:3::10]:50524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVXWo-0002vf-Jt
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVXWk-0000eV-Ha
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:27:42 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:57745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fVXWk-0000eM-80
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:27:38 -0400
Received: from player159.ha.ovh.net (unknown [10.109.122.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8050BE4CAD
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:27:36 +0200 (CEST)
Date: Wed, 20 Jun 2018 09:27:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180620092727.62d6a71d@bahia.lan>
In-Reply-To: <20180620012240.GH3546@umbus.fritz.box>
References: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
	<152937387811.15330.6346338944477555198@sif>
	<20180619131128.17a22f15@bahia.lan>
	<20180620012240.GH3546@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/AWDXllsSqqa8goy=Np/s6z1";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

--Sig_/AWDXllsSqqa8goy=Np/s6z1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Jun 2018 11:22:40 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 19, 2018 at 01:11:28PM +0200, Greg Kurz wrote:
> > On Mon, 18 Jun 2018 21:04:38 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> >  =20
> > > Quoting Greg Kurz (2018-05-22 12:17:28) =20
> > > > The spapr capability framework was introduced in QEMU 2.12. It allo=
ws
> > > > to have an explicit control on how host features are exposed to the
> > > > guest. This is especially needed to handle migration between hetero-
> > > > geneous hosts (eg, POWER8 to POWER9). It is also used to expose fix=
es/
> > > > workarounds against speculative execution vulnerabilities to guests.
> > > > The framework was hence backported to QEMU 2.11.1, especially these
> > > > commits:
> > > >=20
> > > > 0fac4aa93074 spapr: Add pseries-2.12 machine type
> > > > 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
> > > >  optional capability
> > > >=20
> > > > 0fac4aa93074 has the confusing effect of making pseries-2.12 the de=
fault
> > > > machine type for QEMU 2.11.1, instead of the expected pseries-2.11.=
 This
> > > > patch changes the default machine back to pseries-2.11.
> > > >=20
> > > > Unfortunately, 9070f408f491 enforces the HTM capability for pseries=
-2.11.
> > > > This isn't supported by TCG and breaks 'make check'. So this patch =
also
> > > > adds a hack to turn HTM off when using TCG.   =20
> > >=20
> > > I noticed this ends up breaking TCG migration for 2.11.2 -> 2.12, I
> > > get this on the target side even when specifying -machine
> > > pseries-2.11,cap-htm=3Doff for both ends:
> > >=20
> > >   qemu-system-ppc64: cap-htm higher level (1) in incoming stream than=
 on destination (0)
> > >   qemu-system-ppc64: error while loading state for instance 0x0 of de=
vice 'spapr'
> > >   qemu-system-ppc64: load of migration failed: Invalid argument
> > >=20
> > > I'm not sure we care all that much about it but it's a regression fro=
m 2.11.1
> > > at least. The main issue seems to be the default caps for 2.11.2 for =
TCG are
> > > now different from 2.11 and 2.12+, but spapr_cap_##cap##_needed still=
 assumes
> > > everything is the same across all these versions and as such opts not=
 to
> > > migrate cap-htm=3Doff, since that's the default for 2.11.2. This resu=
lts in the
> > > target assuming the source was using the default, which is cap-htm=3D=
on,
> > > and since that disagrees with the spapr->eff we get a failure.
> > >=20
> > > It seems spapr_cap_##cap##_needed needs to be fixed up to address tha=
t,
> > > but I'm not sure how best to deal with backward compatibility in that=
 case.
> > > Any ideas? If it ends up being a trade-off I think forward compatibil=
ity is
> > > more important.
> > >  =20
> >=20
> > Yeah, we shouldn't change the default since it affects the migration lo=
gic :-\
> >=20
> > The motivation behind this hack is to fix TCG based 'make check', becau=
se
> > it doesn't pass cap-htm=3Doff, and thus can't run with pseries-2.11.
> >=20
> > Another possibility is to let the default as is, and to disable HTM aft=
er the
> > default caps have been applied.
> >=20
> > Something like that squashed into this patch:
> >=20
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 82043e60e78b..26e6be043b18 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -285,11 +285,6 @@ static sPAPRCapabilities default_caps_with_cpu(sPA=
PRMachineState *spapr,
> > =20
> >      caps =3D smc->default_caps;
> > =20
> > -    /* HACK for 2.11.2: fix make check */
> > -    if (tcg_enabled()) {
> > -        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > -    }
> > -
> >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> >                            0, spapr->max_compat_pvr)) {
> >          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > @@ -405,6 +400,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
> >          }
> >      }
> > =20
> > +    /* HACK for 2.11.2: fix make check */
> > +    if (tcg_enabled()) {
> > +        spapr->eff.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > +    }
> > +
> >      /* .. then apply those caps to the virtual hardware */
> > =20
> >      for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > --------------------- =20
>=20
> Nooooo!  The whole point of the caps stuff is to stop changing guest
> visible behaviours based on host side configuration like the
> accelerator.  So, really, let's not put it back in.
>=20

Yes I'm aware of all the work we're doing to hide host details.
I was just thinking this small violation would be an acceptable
tradeoff.

> The correct fix is to add cap-htm=3Doff to the testcases.  Gross, but
> necessary.
>=20

Ok, then I'll try to come up with patches ASAP so that Mike can release
2.11.2.=20

>=20
> >=20
> > This allows:
> > - TCG 'make check' to be happy with pseries-2.11
> > - 2.11.2 --> 2.12 migration and backward
> >  =20
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/ppc/spapr.c      |    4 ++--
> > > >  hw/ppc/spapr_caps.c |    5 +++++
> > > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 1a2dd1f597d9..6499a867520f 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(=
MachineClass *mc)
> > > >      /* Defaults for the latest behaviour inherited from the base c=
lass */
> > > >  }
> > > >=20
> > > > -DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> > > > +DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> > > >=20
> > > >  /*
> > > >   * pseries-2.11
> > > > @@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(=
MachineClass *mc)
> > > >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
> > > >  }
> > > >=20
> > > > -DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> > > > +DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> > > >=20
> > > >  /*
> > > >   * pseries-2.10
> > > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > > index 7b229517be38..82043e60e78b 100644
> > > > --- a/hw/ppc/spapr_caps.c
> > > > +++ b/hw/ppc/spapr_caps.c
> > > > @@ -285,6 +285,11 @@ static sPAPRCapabilities default_caps_with_cpu=
(sPAPRMachineState *spapr,
> > > >=20
> > > >      caps =3D smc->default_caps;
> > > >=20
> > > > +    /* HACK for 2.11.2: fix make check */
> > > > +    if (tcg_enabled()) {
> > > > +        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > > +    }
> > > > +
> > > >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> > > >                            0, spapr->max_compat_pvr)) {
> > > >          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > >    =20
> >  =20
>=20


--Sig_/AWDXllsSqqa8goy=Np/s6z1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsqAd8ACgkQcdTV5YIv
c9ZwTA//cHU2VKYsMqGDSalDDxG8ULJsEv0Rik0gi5vxgRgl8CnoYJ6njmbQNlm7
72jELalAPbw5OlSQq4bcVCLmqdHA6ytIQlKiRtYEtp/CexvsTRIl0coXzJQrI9SK
a/Bk5dpta80rpPrG85PvmOR9Iez4rfL7rf0GOQZYhTIWLCB3iXZE9v7ICvb5zx2H
ad7J0xHWjPpXaFAVYfv4qhsrQ5MhbRUdG/dz79eIN6/zxVDAEtRVkjbWgmeIoQK4
eeza9rjf4CaPqQaf3kL8RIZ7C3XGCRp/ZFbchP8Jz8tWxQR9+BqUi4qAQ9AufIRt
HssvxSzynI5Sf0JQGxXp9+Oc9nV3ygao7Uw6QilJSUP0S7vJszbm+yTegsheezNb
nB0lSyk3HhHc+odDkwsltx3zwq0At0QeUkZG4unqjMHJXby8qO09Pu9QZR8JuIcG
/qaBhPJkGlYTGxbGyh0E2/gmM35JzFiwEFo6xee9Y+Bna/Ct7SCAAkSFb3p7YGR3
PJgfb4jApIUsbNwZWqC4tAtGirzuIh3WxzsoJ0SY2qmQvNwnnfER4soZoF6lMDg7
eASylsFhkpk3MjY9dIHYd6RNDLPZ2VsMyYFOm1D9X4oPhx6GG91iQsrrs0sH/kfs
l4aIX6ejt79YFaw0FfBaWI2Bzlfw3t6JgLIj+E9lFrIUQdw75d8=
=aIiW
-----END PGP SIGNATURE-----

--Sig_/AWDXllsSqqa8goy=Np/s6z1--
