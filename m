Received: from eggs.gnu.org ([2001:4830:134:3::10]:58793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVbbv-0004Mn-3z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVbbq-0002gf-8Y
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:49:15 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:36751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fVbbp-0002fl-Ul
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:49:10 -0400
Received: from player756.ha.ovh.net (unknown [10.109.105.24])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 68DF0C609B
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 13:49:06 +0200 (CEST)
Date: Wed, 20 Jun 2018 13:48:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180620134859.28c3f9ab@bahia.lan>
In-Reply-To: <20180620090601.GF24636@umbus.fritz.box>
References: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
	<152937387811.15330.6346338944477555198@sif>
	<20180619131128.17a22f15@bahia.lan>
	<20180620012240.GH3546@umbus.fritz.box>
	<20180620092727.62d6a71d@bahia.lan>
	<20180620090601.GF24636@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/kW1qLLTFQr16iTi_W.C5AQ+";
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

--Sig_/kW1qLLTFQr16iTi_W.C5AQ+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Jun 2018 19:06:01 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jun 20, 2018 at 09:27:27AM +0200, Greg Kurz wrote:
> > On Wed, 20 Jun 2018 11:22:40 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Tue, Jun 19, 2018 at 01:11:28PM +0200, Greg Kurz wrote: =20
> > > > On Mon, 18 Jun 2018 21:04:38 -0500
> > > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > > >    =20
> > > > > Quoting Greg Kurz (2018-05-22 12:17:28)   =20
> > > > > > The spapr capability framework was introduced in QEMU 2.12. It =
allows
> > > > > > to have an explicit control on how host features are exposed to=
 the
> > > > > > guest. This is especially needed to handle migration between he=
tero-
> > > > > > geneous hosts (eg, POWER8 to POWER9). It is also used to expose=
 fixes/
> > > > > > workarounds against speculative execution vulnerabilities to gu=
ests.
> > > > > > The framework was hence backported to QEMU 2.11.1, especially t=
hese
> > > > > > commits:
> > > > > >=20
> > > > > > 0fac4aa93074 spapr: Add pseries-2.12 machine type
> > > > > > 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) a=
s an
> > > > > >  optional capability
> > > > > >=20
> > > > > > 0fac4aa93074 has the confusing effect of making pseries-2.12 th=
e default
> > > > > > machine type for QEMU 2.11.1, instead of the expected pseries-2=
.11. This
> > > > > > patch changes the default machine back to pseries-2.11.
> > > > > >=20
> > > > > > Unfortunately, 9070f408f491 enforces the HTM capability for pse=
ries-2.11.
> > > > > > This isn't supported by TCG and breaks 'make check'. So this pa=
tch also
> > > > > > adds a hack to turn HTM off when using TCG.     =20
> > > > >=20
> > > > > I noticed this ends up breaking TCG migration for 2.11.2 -> 2.12,=
 I
> > > > > get this on the target side even when specifying -machine
> > > > > pseries-2.11,cap-htm=3Doff for both ends:
> > > > >=20
> > > > >   qemu-system-ppc64: cap-htm higher level (1) in incoming stream =
than on destination (0)
> > > > >   qemu-system-ppc64: error while loading state for instance 0x0 o=
f device 'spapr'
> > > > >   qemu-system-ppc64: load of migration failed: Invalid argument
> > > > >=20
> > > > > I'm not sure we care all that much about it but it's a regression=
 from 2.11.1
> > > > > at least. The main issue seems to be the default caps for 2.11.2 =
for TCG are
> > > > > now different from 2.11 and 2.12+, but spapr_cap_##cap##_needed s=
till assumes
> > > > > everything is the same across all these versions and as such opts=
 not to
> > > > > migrate cap-htm=3Doff, since that's the default for 2.11.2. This =
results in the
> > > > > target assuming the source was using the default, which is cap-ht=
m=3Don,
> > > > > and since that disagrees with the spapr->eff we get a failure.
> > > > >=20
> > > > > It seems spapr_cap_##cap##_needed needs to be fixed up to address=
 that,
> > > > > but I'm not sure how best to deal with backward compatibility in =
that case.
> > > > > Any ideas? If it ends up being a trade-off I think forward compat=
ibility is
> > > > > more important.
> > > > >    =20
> > > >=20
> > > > Yeah, we shouldn't change the default since it affects the migratio=
n logic :-\
> > > >=20
> > > > The motivation behind this hack is to fix TCG based 'make check', b=
ecause
> > > > it doesn't pass cap-htm=3Doff, and thus can't run with pseries-2.11.
> > > >=20
> > > > Another possibility is to let the default as is, and to disable HTM=
 after the
> > > > default caps have been applied.
> > > >=20
> > > > Something like that squashed into this patch:
> > > >=20
> > > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > > index 82043e60e78b..26e6be043b18 100644
> > > > --- a/hw/ppc/spapr_caps.c
> > > > +++ b/hw/ppc/spapr_caps.c
> > > > @@ -285,11 +285,6 @@ static sPAPRCapabilities default_caps_with_cpu=
(sPAPRMachineState *spapr,
> > > > =20
> > > >      caps =3D smc->default_caps;
> > > > =20
> > > > -    /* HACK for 2.11.2: fix make check */
> > > > -    if (tcg_enabled()) {
> > > > -        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > > -    }
> > > > -
> > > >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> > > >                            0, spapr->max_compat_pvr)) {
> > > >          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > > @@ -405,6 +400,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
> > > >          }
> > > >      }
> > > > =20
> > > > +    /* HACK for 2.11.2: fix make check */
> > > > +    if (tcg_enabled()) {
> > > > +        spapr->eff.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > > > +    }
> > > > +
> > > >      /* .. then apply those caps to the virtual hardware */
> > > > =20
> > > >      for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > > > ---------------------   =20
> > >=20
> > > Nooooo!  The whole point of the caps stuff is to stop changing guest
> > > visible behaviours based on host side configuration like the
> > > accelerator.  So, really, let's not put it back in.
> > >  =20
> >=20
> > Yes I'm aware of all the work we're doing to hide host details.
> > I was just thinking this small violation would be an acceptable
> > tradeoff. =20
>=20
> The reason I wrote the caps stuff was that I kept finding that
> supposedly small violations of this still kept biting us in the arse.
>=20

Fair enough.

> > > The correct fix is to add cap-htm=3Doff to the testcases.  Gross, but
> > > necessary.
> > >  =20
> >=20
> > Ok, then I'll try to come up with patches ASAP so that Mike can release
> > 2.11.2. =20
>=20
> After I sent that I did think of some alternatives.  We can't change
> the behaviour based on the accelerator, but we might be able to change
> it based on qtest_enabled().
>=20

No. qtest is the accelerator used by qtest based testcases, and the
failing testcases aren't qtest:
- tests/boot-serial-test.c
- tests/migration-test.c
- tests/prom-env-test.c
- tests/pxe-test.c

These all start QEMU with TCG on non-ppc64 hosts, and the modifications
to add cap-htm=3Doff aren't that gross in the end. I'll do some more
testing and post a v2.

--Sig_/kW1qLLTFQr16iTi_W.C5AQ+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsqPysACgkQcdTV5YIv
c9ZSdA//SlV4bjPlIgzdhj0xf7isrr5nY1U1hZqiaMzUXtasM5Eb0Xv4JGyllQiK
hUBlL+BkEnN0Zt96HUvynTrdzeGPewidO9U7L1nsnzW7O9vYM1MrMtaOTDjfZiO1
cBAsx5H99+EgB2jpD09zx0U/t0KBAXJHB4TpHYRHMaDv1/ylg4HA4qyJ4B8wTYaZ
x3OmL9OwNn7q6rk9rr5ptgZdcyCXIxODgiSOt0JmIDS0fDD3NARCJ2mN/Eqn+zUX
k13HyIKMHz2sVKXs7LxifAKNWf77VTitb7m/vK9V/Cr2ubv8H9GxH/Yxg0upi0ez
KFZavmK7mwt+rkZpjVOuA3px1Bwt8KI9iLoS1oi/egr/7r9+YsFsdH8Gs+aoxdEe
UU4fzCWEZYAPCRpPvXWbVEHdXVcnE4Zis1r9m9si+nusb7413fCyBbwLwn1Ayyg4
4D+fY2C3cPXuCoiRglbr/nW9FhwjcXKQDX32TlbskS26/ci7ZMJUZG2/r3P0eGH+
0s9a9kmnOyfABcgsi5i3Xymd845z4kpPTKgY9ju5y9FCfCg6Y+ytiLC5+0DJsjKD
+OmNuPE63xnMCvHuyWmny4n5xu1BrVTW3nUZ4ix1vHlbmmscvXZCU1/SusWGu8Bk
SwqbFdjwgmJ21dR4fxf2AHKUgY8popAca1ARum1nE6D2dc1T3gQ=
=tYkB
-----END PGP SIGNATURE-----

--Sig_/kW1qLLTFQr16iTi_W.C5AQ+--
