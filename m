Received: from eggs.gnu.org ([2001:4830:134:3::10]:55164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df2AE-000296-HV
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df2AB-00018K-Fq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:55:06 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:36580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1df2AB-00017Y-8I
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:55:03 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 3765B8BABA
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 12:55:01 +0200 (CEST)
Date: Tue, 8 Aug 2017 12:54:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170808125451.3281c2ce@bahia.lan>
In-Reply-To: <96975486-48cd-1ccc-209c-3f06f73f5d0e@kaod.org>
References: <20170808060817.2832-1-david@gibson.dropbear.id.au>
	<20170808060817.2832-3-david@gibson.dropbear.id.au>
	<96975486-48cd-1ccc-209c-3f06f73f5d0e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/wU+pmlzWZsbB/+ystS+EE6g";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/2] target/ppc: Add stub
 implementation of the PSSCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, agraf@suse.de

--Sig_/wU+pmlzWZsbB/+ystS+EE6g
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Aug 2017 11:19:58 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 08/08/2017 08:08 AM, David Gibson wrote:
> > The PSSCR register added in POWER9 controls certain power saving mode
> > behaviours.  Mostly, it's not relevant to TCG, however because qemu
> > doesn't know about it yet, it doesn't synchronize the state with KVM,
> > and thus it doesn't get migrated.
> >=20
> > To fix that, this adds a minimal stub implementation of the register.
> > This isn't complete, even to the extent that an implementation is
> > possible in TCG, just enough to get migration working.  We need to
> > come back later and at least properly filter the various fields in the
> > register based on privilege level. =20
>=20
> yes a lot of the fields are only accessible to the hypervisor, and the=20
> hypervisor also uses a different SPR number to access the PSSCR bits.
>=20

This patch uses 0x357 (855) which is the SPR number for hypervisor state
access. But, yes, part of the register is also accessible in privileged
non-hypervisor state with SPR number 0x337 (823). This will have to be
covered later, but for now:

Reviewed-by: Greg Kurz <groug@kaod.org>

> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> C.
>  =20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/cpu.h            | 1 +
> >  target/ppc/translate_init.c | 5 +++++
> >  2 files changed, 6 insertions(+)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index f6e5413fad..46d3dd88f6 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1771,6 +1771,7 @@ void ppc_compat_add_property(Object *obj, const c=
har *name,
> >  #define SPR_IC                (0x350)
> >  #define SPR_VTB               (0x351)
> >  #define SPR_MMCRC             (0x353)
> > +#define SPR_PSSCR             (0x357)
> >  #define SPR_440_INV0          (0x370)
> >  #define SPR_440_INV1          (0x371)
> >  #define SPR_440_INV2          (0x372)
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index 94800cd29d..8fb407ed73 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -8846,6 +8846,11 @@ static void init_proc_POWER9(CPUPPCState *env)
> >                       spr_read_generic, spr_write_generic,
> >                       KVM_REG_PPC_TIDR, 0);
> > =20
> > +    /* FIXME: Filter fields properly based on privilege level */
> > +    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NUL=
L,
> > +                        spr_read_generic, spr_write_generic,
> > +                        KVM_REG_PPC_PSSCR, 0);
> > +
> >      /* env variables */
> >  #if !defined(CONFIG_USER_ONLY)
> >      env->slb_nr =3D 32;
> >  =20
>=20


--Sig_/wU+pmlzWZsbB/+ystS+EE6g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmJmHsACgkQAvw66wEB28JGUwCfZBa1QxbMDXu2XHZSj095X8M6
CjQAoJKDgDMy1zpyKGcE7t0KsDOu8zrf
=Haj5
-----END PGP SIGNATURE-----

--Sig_/wU+pmlzWZsbB/+ystS+EE6g--
