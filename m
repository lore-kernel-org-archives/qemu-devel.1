Received: from eggs.gnu.org ([2001:4830:134:3::10]:56524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV6T2-0005Ql-Nz
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 22:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV6Sz-0003w9-J1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 22:34:00 -0400
Date: Tue, 19 Jun 2018 12:33:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619023347.GB11674@umbus.fritz.box>
References: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
	<152937387811.15330.6346338944477555198@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <152937387811.15330.6346338944477555198@sif>
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org, qemu-devel@nongnu.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 09:04:38PM -0500, Michael Roth wrote:
> Quoting Greg Kurz (2018-05-22 12:17:28)
> > The spapr capability framework was introduced in QEMU 2.12. It allows
> > to have an explicit control on how host features are exposed to the
> > guest. This is especially needed to handle migration between hetero-
> > geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
> > workarounds against speculative execution vulnerabilities to guests.
> > The framework was hence backported to QEMU 2.11.1, especially these
> > commits:
> >=20
> > 0fac4aa93074 spapr: Add pseries-2.12 machine type
> > 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
> >  optional capability
> >=20
> > 0fac4aa93074 has the confusing effect of making pseries-2.12 the default
> > machine type for QEMU 2.11.1, instead of the expected pseries-2.11. This
> > patch changes the default machine back to pseries-2.11.
> >=20
> > Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2.1=
1.
> > This isn't supported by TCG and breaks 'make check'. So this patch also
> > adds a hack to turn HTM off when using TCG.
>=20
> I noticed this ends up breaking TCG migration for 2.11.2 -> 2.12, I
> get this on the target side even when specifying -machine
> pseries-2.11,cap-htm=3Doff for both ends:
>=20
>   qemu-system-ppc64: cap-htm higher level (1) in incoming stream than on =
destination (0)
>   qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'spapr'
>   qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> I'm not sure we care all that much about it but it's a regression from 2.=
11.1
> at least. The main issue seems to be the default caps for 2.11.2 for TCG =
are
> now different from 2.11 and 2.12+, but spapr_cap_##cap##_needed still ass=
umes

Um.. yeah, we shouldn't be changing default caps between 2.11 and 2.11.z.

> everything is the same across all these versions and as such opts not to
> migrate cap-htm=3Doff, since that's the default for 2.11.2. This results =
in the
> target assuming the source was using the default, which is cap-htm=3Don,
> and since that disagrees with the spapr->eff we get a failure.
>=20
> It seems spapr_cap_##cap##_needed needs to be fixed up to address that,
> but I'm not sure how best to deal with backward compatibility in that cas=
e.
> Any ideas? If it ends up being a trade-off I think forward compatibility =
is
> more important.
>=20
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c      |    4 ++--
> >  hw/ppc/spapr_caps.c |    5 +++++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 1a2dd1f597d9..6499a867520f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(Mach=
ineClass *mc)
> >      /* Defaults for the latest behaviour inherited from the base class=
 */
> >  }
> >=20
> > -DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> > +DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> >=20
> >  /*
> >   * pseries-2.11
> > @@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(Mach=
ineClass *mc)
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
> >  }
> >=20
> > -DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> > +DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> >=20
> >  /*
> >   * pseries-2.10
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 7b229517be38..82043e60e78b 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -285,6 +285,11 @@ static sPAPRCapabilities default_caps_with_cpu(sPA=
PRMachineState *spapr,
> >=20
> >      caps =3D smc->default_caps;
> >=20
> > +    /* HACK for 2.11.2: fix make check */
> > +    if (tcg_enabled()) {
> > +        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > +    }
> > +
> >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> >                            0, spapr->max_compat_pvr)) {
> >          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoa4kACgkQbDjKyiDZ
s5IgJxAAwOPqH5I85ThbTwqd6cE61etlZ9h3NO2w67isfBGaYVngULKogMvZp8eK
bT2KNk8XGNdy6ZRW7tBLiS2m/AmKcvBwPU+g3ZjGXge6O6hiO0y82eBENFaHS/JD
mplgyRSW7ipRIXSVWZqBWLSt2cQlapJ/gosqj08pkB6NevRDwDqbux55hd2XKj80
w3FPml1GCjvVZWrR1Lr18rMKFmQNJ/q1s3UmC+vSxEYqZbnm/mm3f0mX9rDXblam
Rb2P5gI+zETDHQ7fonr0KxbXCPz0k1cG2xN16gb1Nz32Tmlh+ZYTXhsl3jA8tz3Y
/tnNNTlluEptmMUU9pVlgBrtUWFwz8oXq8DWIgxXB+oB2fV61Du93eIhhEw3N/3z
05tnLa3zozOTD7aYF9dQCW8lcaFvsKhl8RfmSABn7t5FNxySZZdUar38t7gGGDq2
uxlUl8gp9WyxyMNNyigQjkYOnAJqeHovUJYuek5hpEG8kaK/udAGbm9nS5COCfag
Sa3YEtWgMOh30kPCqGqnDv/MLSv0ffQrsNMY3qSgM8kGlFB+OIWUlnLUiUhRY7c0
8F5ggZ/b/MxozKQntx/r4ikgyOz94ZbsiUc5nolMctjJvju+7KWp7mSO/gibTgWx
rZM5tdnVVA+CUELGYTarNwvlmcRn9MfA+4hYKFAbIE1fQshPX8M=
=XpQj
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
