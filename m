Received: from eggs.gnu.org ([2001:4830:134:3::10]:42106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fETfx-0003s9-BR
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fETft-0001mQ-6s
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:54:37 -0400
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:57916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fETft-0001kr-0R
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:54:33 -0400
Received: from player691.ha.ovh.net (unknown [10.109.108.111])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id CCDEC157F24
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 07:54:29 +0200 (CEST)
Date: Fri, 4 May 2018 07:54:19 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180504075419.4eb70618@bahia.lan>
In-Reply-To: <20180504001223.GI13229@umbus.fritz.box>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
	<152538218900.223014.9011319433623501285.stgit@bahia.lan>
	<20180504001223.GI13229@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/o5W=5hGAtUiMt4JfBvKLBdx";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

--Sig_/o5W=5hGAtUiMt4JfBvKLBdx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 4 May 2018 10:12:23 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 03, 2018 at 11:16:29PM +0200, Greg Kurz wrote:
> > The pseries-2.7 and older machine types require CPUPPCState::insns_flags
> > to be strictly equal between source and destination. This checking is
> > abusive and breaks migration of KVM guests when the host CPU models
> > are different, even if they are compatible enough to allow the guest
> > to run transparently. This buggy behaviour was fixed for pseries-2.8
> > and we added some hacks to allow backward migration of older machine
> > types. These hacks assume that the CPU belongs to the POWER8 family,
> > which was true for most KVM based setup we cared about at the time.
> > But now POWER9 systems are coming, and backward migration of pre 2.8
> > guests running in POWER8 architected mode from a POWER9 host to a
> > POWER8 host is broken:
> >=20
> > qemu-system-ppc64: error while loading state for instance 0x0 of device
> >  'cpu'
> > qemu-system-ppc64: load of migration failed: Invalid argument
> >=20
> > This happens because POWER9 doesn't set PPC_MEM_TLBIE in insns_flags,
> > while POWER8 does. Let's force PPC_MEM_TLBIE in the migration hack to
> > fix the issue. This is an acceptable hack because these old machine
> > types only support CPU models that do set PPC_MEM_TLBIE.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  target/ppc/machine.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 3d6434a006fa..ba1b9e531f97 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -212,6 +212,11 @@ static int cpu_pre_save(void *opaque)
> >              ;
> >          cpu->mig_msr_mask =3D env->msr_mask & ~metamask;
> >          cpu->mig_insns_flags =3D env->insns_flags & insns_compat_mask;
> > +        /* CPU models supported by old machines all have PPC_MEM_TLBIE,
> > +         * so we set it unconditionally to allow backward migration fr=
om
> > +         * a POWER9 host to a POWER8 host. =20
>=20
> So.. the comment's slightly misleading.  This code is common to all
> cpus, not just those used on pseries, so across that set it's not
> really accurate.  But pseries is the only machine we support migration
> to/from old versions with so it doesn't really matter.
>=20

Oh... I was assuming that we only supported migration for pseries
machine, irrespective of the versions.

> > +         */
> > +        cpu->mig_insns_flags |=3D PPC_MEM_TLBIE;
> >          cpu->mig_insns_flags2 =3D env->insns_flags2 & insns_compat_mas=
k2;
> >          cpu->mig_nb_BATs =3D env->nb_BATs;
> >      }
> >  =20
>=20


--Sig_/o5W=5hGAtUiMt4JfBvKLBdx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlrr9YsACgkQcdTV5YIv
c9aBlhAAoP8HjM8xnsGYvsVEUWcG1YHu3WN1WbO8cJt9FSep24IpDSkfHA+k6NWk
hWaxF9ZAZfdLtPZEA6LkyurchDL4hUBoPp8+wAsGkXwTPcuHKQBoph2Gu/qskyn9
dfTBO2DNcBu66k7MjUlsZCWO2XafLYCv3xVnHpFpcI8GDIK2XAO6kLpG0Psnv9ZF
SGoCnCBHPT6yg3srK1JdYiue4hz3RG2hJ/C/8cSGAzaegzAafeJFt+M45B2HxmvU
mO7EfWbnP0lUkcsUsh86uHxpS4Q2z6SHP/smmfdBoQOOU1pTrkHQ4N4VxbLZ/td4
TK+J/tFhS1Tqoe81WAnQjUZ4nY2KRS7tKjsO7oVraxJuE7amzbVMAVtngj7hOui1
pgikStM3xanz0Ril97oRfu4NguSMF5hpuBtsBNXmAnDaTvyMKgFZYDmbRnjJvTY8
RgjbWt4M+y58p9TsH1yE+xSfS/Zao2b/9p3Rj5VjaJq+SqonollM6Ym/npety8+8
7QdGJbpcbOs8AjbLiInpH+rsBtjeLcvNskVRKDLxKvXV0Vn0UJsEC6l968L8/7vg
/N2bvweSiNQWWJBA6DvTJoJpDjI4rMC8I9XvnVB3LFqFHwk6/b//UyzCyVNWC44s
JKl6DTKrTb+6kgCOjYKJIAAEzCIt5bnln3J7k68xCbc6NJACaG4=
=9tIK
-----END PGP SIGNATURE-----

--Sig_/o5W=5hGAtUiMt4JfBvKLBdx--
