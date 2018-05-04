Received: from eggs.gnu.org ([2001:4830:134:3::10]:43868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETmP-0007jA-Gg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETmL-00026Y-Cl
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:01:17 -0400
Date: Fri, 4 May 2018 16:01:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504060101.GY13229@umbus.fritz.box>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
	<152538218900.223014.9011319433623501285.stgit@bahia.lan>
	<20180504001223.GI13229@umbus.fritz.box>
	<20180504075419.4eb70618@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BzhqTaE66jeIVBY0"
Content-Disposition: inline
In-Reply-To: <20180504075419.4eb70618@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc: always set PPC_MEM_TLBIE
 in pre 2.8 migration hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--BzhqTaE66jeIVBY0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 07:54:19AM +0200, Greg Kurz wrote:
> On Fri, 4 May 2018 10:12:23 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, May 03, 2018 at 11:16:29PM +0200, Greg Kurz wrote:
> > > The pseries-2.7 and older machine types require CPUPPCState::insns_fl=
ags
> > > to be strictly equal between source and destination. This checking is
> > > abusive and breaks migration of KVM guests when the host CPU models
> > > are different, even if they are compatible enough to allow the guest
> > > to run transparently. This buggy behaviour was fixed for pseries-2.8
> > > and we added some hacks to allow backward migration of older machine
> > > types. These hacks assume that the CPU belongs to the POWER8 family,
> > > which was true for most KVM based setup we cared about at the time.
> > > But now POWER9 systems are coming, and backward migration of pre 2.8
> > > guests running in POWER8 architected mode from a POWER9 host to a
> > > POWER8 host is broken:
> > >=20
> > > qemu-system-ppc64: error while loading state for instance 0x0 of devi=
ce
> > >  'cpu'
> > > qemu-system-ppc64: load of migration failed: Invalid argument
> > >=20
> > > This happens because POWER9 doesn't set PPC_MEM_TLBIE in insns_flags,
> > > while POWER8 does. Let's force PPC_MEM_TLBIE in the migration hack to
> > > fix the issue. This is an acceptable hack because these old machine
> > > types only support CPU models that do set PPC_MEM_TLBIE.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  target/ppc/machine.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > > index 3d6434a006fa..ba1b9e531f97 100644
> > > --- a/target/ppc/machine.c
> > > +++ b/target/ppc/machine.c
> > > @@ -212,6 +212,11 @@ static int cpu_pre_save(void *opaque)
> > >              ;
> > >          cpu->mig_msr_mask =3D env->msr_mask & ~metamask;
> > >          cpu->mig_insns_flags =3D env->insns_flags & insns_compat_mas=
k;
> > > +        /* CPU models supported by old machines all have PPC_MEM_TLB=
IE,
> > > +         * so we set it unconditionally to allow backward migration =
=66rom
> > > +         * a POWER9 host to a POWER8 host. =20
> >=20
> > So.. the comment's slightly misleading.  This code is common to all
> > cpus, not just those used on pseries, so across that set it's not
> > really accurate.  But pseries is the only machine we support migration
> > to/from old versions with so it doesn't really matter.
>=20
> Oh... I was assuming that we only supported migration for pseries
> machine, irrespective of the versions.

Actually, that's probably true.  Although there are a couple where it
might just about work.  pseries is *definitely* the only one that we
properly check and care about cross-version compatibility though.


>=20
> > > +         */
> > > +        cpu->mig_insns_flags |=3D PPC_MEM_TLBIE;
> > >          cpu->mig_insns_flags2 =3D env->insns_flags2 & insns_compat_m=
ask2;
> > >          cpu->mig_nb_BATs =3D env->nb_BATs;
> > >      }
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BzhqTaE66jeIVBY0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr9xoACgkQbDjKyiDZ
s5Ia4A//VzqX/iGlZh8AR28PCx0uNaAmMkMFZ7E54HMGHrnOOwPYeRSjEEB/Vn1O
8evqMHGiRMYcoupG3Nb1iSEyJro1OsGVGtRJFRsAnZoV7diY/hYRqbynp5eyB7qg
TeHYZZtl63Z3qPsTQEmHjoktXZsF90IkYsBA00rPQkA9+ZO9jxKHUEtXrLUM4Bk9
E/Su53FzXbVCVDl/ngg2ZstcoF0pPT73kjPRGzyC+0d8bDg+P2POb+TdVa4wcQKy
viH9nnZ5JRwNzzEn6ZrVW5Lebjvs/cDK0gMw4laoo6i02WLvtIPrNlzc0LSSjG8x
hXxVOwrnBktfGVm+7mrt/w1uHMiuMFVxAGUydHs7f6AWyHbX+qKY0UfeW0GhI3ip
Hnk65kO0eJg8D6lhBOvpFD2AC+KyRjObGexvPh0oD9K/MerB8C08av1QJbm4ZDdV
ofhq2QXBkhM2OWSV33/+O55mx8kEU1PLCYBwalNTL3Jdbmy0d6cUPOafynJKjtb+
f3UUxOqRHyU4ML9Ao70JhS0sjw+fbDTlxJ3GN0KlNEQXEaT+7rabugpb27tBUvsb
D0mb3WF6OCInbQbCB7zTJRjhI8GKM7Z5km3TH2CpFozA4Zo07H4rTyDK8GGRZduY
1UbeRcucDiTzacWaAKAcI5QSIhMy+ZqTfGI20+TbVwTxyGLLQs8=
=ZRYd
-----END PGP SIGNATURE-----

--BzhqTaE66jeIVBY0--
