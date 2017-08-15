Received: from eggs.gnu.org ([2001:4830:134:3::10]:54553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dhYmd-0005R3-GZ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dhYma-0005I9-6K
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:09:11 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:41070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dhYmZ-0005HN-Vo
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:09:08 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5C6B211AA8F
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 12:09:06 +0200 (CEST)
Date: Tue, 15 Aug 2017 12:09:00 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170815120900.2eff984f@bahia.lan>
In-Reply-To: <20170815040409.GN3452@umbus.fritz.box>
References: <150273295665.11087.17582111045419718285.stgit@bahia.lan>
	<20170815040409.GN3452@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/lWCJYnLiWLVwZjiNh6txSNW";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] ppc: fix ppc_set_compat() with KVM PR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

--Sig_/lWCJYnLiWLVwZjiNh6txSNW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Aug 2017 14:04:09 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Aug 14, 2017 at 07:49:16PM +0200, Greg Kurz wrote:
> > When running in KVM PR mode, kvmppc_set_compat() always fail because the
> > current PR implementation doesn't handle KVM_REG_PPC_ARCH_COMPAT. Now t=
hat
> > the machine code inconditionally calls ppc_set_compat_all() at reset ti=
me
> > to restore the compat mode default value (commit 66d5c492dd3a9), it is
> > impossible to start a guest with PR:
> >=20
> > qemu-system-ppc64: Unable to set CPU compatibility mode in KVM:
> >  Invalid argument
> >=20
> > A tentative patch [1] was recently sent by Suraj to address the issue, =
but
> > it would prevent the compat mode to be turned off on reset. And we real=
ly
> > don't want to explicitely check for KVM PR. During the patch's review,
> > David suggested that we should only call the KVM ioctl() if the compat
> > PVR changes. This allows at least to run with KVM PR, provided no compat
> > mode is requested from the command line (which should be the case when
> > running PR nested). This is what this patch does. =20
>=20
> I'm not sure that's true any more, since we now prefer compat modes
> during CAS.  I guess we could exclude the compat modes from the

Oops, I wanted to talk about CAS and I... forgot :(

So, indeed, CAS fails to apply compat mode and immediately returns H_HARDWA=
RE
to the guest, ie the rest of CAS isn't done :-\. Linux guests print a warni=
ng:

WARNING: ibm,client-architecture-support call FAILED!
 done

and (luckily?) continue to boot anyway (at least that's what happens with
RHEL7 guests).

> advertised list based on what KVM supports, but that seems pretty
> awkward.
>=20

I'll re-read the details in LoPAPR and try to come up with something.

Cheers,

--
Greg

> > While here, we also fix the side effect where KVM would fail but we wou=
ld
> > change the CPU state in QEMU anyway.
> >=20
> > [1] http://patchwork.ozlabs.org/patch/782039/
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> In any case, this makes things better than they were, so I'm applying.
>=20
> > ---
> >  target/ppc/compat.c |    9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> > index f1b67faa97e3..f8729fe46d61 100644
> > --- a/target/ppc/compat.c
> > +++ b/target/ppc/compat.c
> > @@ -140,16 +140,17 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t com=
pat_pvr, Error **errp)
> > =20
> >      cpu_synchronize_state(CPU(cpu));
> > =20
> > -    cpu->compat_pvr =3D compat_pvr;
> > -    env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> > -
> > -    if (kvm_enabled()) {
> > +    if (kvm_enabled() && cpu->compat_pvr !=3D compat_pvr) {
> >          int ret =3D kvmppc_set_compat(cpu, cpu->compat_pvr);
> >          if (ret < 0) {
> >              error_setg_errno(errp, -ret,
> >                               "Unable to set CPU compatibility mode in =
KVM");
> > +            return;
> >          }
> >      }
> > +
> > +    cpu->compat_pvr =3D compat_pvr;
> > +    env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> >  }
> > =20
> >  typedef struct {
> >  =20
>=20


--Sig_/lWCJYnLiWLVwZjiNh6txSNW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmSyDwACgkQAvw66wEB28JihQCgmplcSEnUL68D8mz/cH2B2L92
YEsAn1M7ECrxcRwIoy+SXo3KznTK1ZHr
=eYwY
-----END PGP SIGNATURE-----

--Sig_/lWCJYnLiWLVwZjiNh6txSNW--
