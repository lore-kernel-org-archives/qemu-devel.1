Received: from eggs.gnu.org ([2001:4830:134:3::10]:53767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdax-0006To-Bb
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdaw-0005XC-Cr
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:19 -0400
Date: Mon, 22 May 2017 12:44:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522024448.GL30246@umbus.fritz.box>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
	<20170519063614.GG3446@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aYrjF+tKt+ApYAdb"
Content-Disposition: inline
In-Reply-To: <20170519063614.GG3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] spapr: Fix migration of Radix
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


--aYrjF+tKt+ApYAdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 12:06:14PM +0530, Bharata B Rao wrote:
> On Fri, May 19, 2017 at 11:10:39AM +0530, Bharata B Rao wrote:
> > Fix migration of radix guests by ensuring that we issue
> > KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> >=20
> > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index daf335c..8f20f14 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int ver=
sion_id)
> >          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset=
);
> >      }
> >=20
> > +    if (spapr->patb_entry) {
> > +        PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> > +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> > +            err =3D kvmppc_configure_v3_mmu(cpu, SPAPR_PROC_TABLE_RADI=
X,
> > +                ((cpu->env.spr[SPR_LPCR] & LPCR_GTSE) ? SPAPR_PROC_TAB=
LE_GTSE :
> > +                0), spapr->patb_entry);
>=20
> Better to use explicit 'true' and 'false' in the above call. Here is
> the updated patch:

Or just !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE) and avoid the ?:
entirely.

With this version you no longer need patch 3/4 AFAICT.

>=20
> >From 937c51cac73b4211ef153c1f5940215960383494 Mon Sep 17 00:00:00 2001
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Date: Tue, 16 May 2017 12:19:54 +0530
> Subject: [RFC PATCH v2.1 4/4] spapr: Fix migration of Radix guests
>=20
> Fix migration of radix guests by ensuring that we issue
> KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
>=20
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index daf335c..69e184b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
>      }
> =20
> +    if (spapr->patb_entry) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> +            err =3D kvmppc_configure_v3_mmu(cpu, true,
> +                ((cpu->env.spr[SPR_LPCR] & LPCR_GTSE) ? true : false),
> +                spapr->patb_entry);
> +        } else {
> +            error_report("Radix guest is unsupported by the host");
> +            return -EINVAL;
> +        }
> +    }
> +
>      return err;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aYrjF+tKt+ApYAdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIlCgAAoJEGw4ysog2bOSMy4P/isDMpjfYVFuWM/dueU9x9jh
8NJALs44Xk2FPk0wvaGsUTSkHY4wqwG41SM9RjV2WETgnYrjmJblwztDuYND3h3P
6/QdcO5gl2URtt9Bto3SXtoa6cWvdfekL2r/mFMLUL9vo0acDfsScqoko9toBn6t
lZxeIeY5NhsD6Q9e38Vh25z6xHdDs6ewdXCrV+qoVD9LcFiLB7a5xxqoW2FAtByO
zRekn3qEuUKtO/Hp308VkzdvRWMsaDwZ1GTDxjLrTEV0fj8pmt4w0a8vC2hRSKVV
ElPsd/GB/u/lYcMfRPmeFfbhg5WgSARSTQ8Py0OiSV/x6mPVPc3wlBZTqUL3X56P
47pQ7RZPtdZ6SNr9Ams90R8qDF1ELu57wZyHYy4BmO1wgbhmnfZiPXyHbtg+2OAi
IU23SixErOj4mk8k+AbFz6UYGN9sBG8KP2VXceFnq3I+2o75o9HXdivZk9Xp5cjO
gaHv4WjKneI6EpfyiRkJJlDcArHMeJqa5V+7H7yuE1/zeGS6SkPD5nV88BdmQ6dk
NzQ8jnqxBQiWA+LRFhgggbOPrZOyBrsx0UmJII/895i4lCvbCPbatZCbbgiAe09u
wY4fT1Lkj8yxxjT0xT5RpcgG6gjR4s/CmYmTwhn11xmCp/AA+VbJSWbOkaT+y/fM
L9MRRK7uk/36DY+7rJLq
=JpWY
-----END PGP SIGNATURE-----

--aYrjF+tKt+ApYAdb--
