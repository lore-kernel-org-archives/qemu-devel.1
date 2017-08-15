Received: from eggs.gnu.org ([2001:4830:134:3::10]:46858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dhXB6-00037n-JM
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dhXB3-00052m-8P
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:26:20 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:33511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dhXB3-0004ws-1t
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:26:17 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C782111AA30
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 10:26:07 +0200 (CEST)
Date: Tue, 15 Aug 2017 10:26:01 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170815102601.78639e8b@bahia.lan>
In-Reply-To: <1502761234.2143.4.camel@gmail.com>
References: <150273295665.11087.17582111045419718285.stgit@bahia.lan>
	<1502761234.2143.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/UO+zmTMtpAUx2r8TcmYw0np";
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
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/UO+zmTMtpAUx2r8TcmYw0np
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Aug 2017 11:40:34 +1000
Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:

> On Mon, 2017-08-14 at 19:49 +0200, Greg Kurz wrote:
> > When running in KVM PR mode, kvmppc_set_compat() always fail because
> > the
> > current PR implementation doesn't handle KVM_REG_PPC_ARCH_COMPAT. Now
> > that
> > the machine code inconditionally calls ppc_set_compat_all() at reset
> > time
> > to restore the compat mode default value (commit 66d5c492dd3a9), it
> > is
> > impossible to start a guest with PR:
> >=20
> > qemu-system-ppc64: Unable to set CPU compatibility mode in KVM:
> > =C2=A0Invalid argument
> >=20
> > A tentative patch [1] was recently sent by Suraj to address the
> > issue, but
> > it would prevent the compat mode to be turned off on reset. And we
> > really
> > don't want to explicitely check for KVM PR. During the patch's
> > review,
> > David suggested that we should only call the KVM ioctl() if the
> > compat
> > PVR changes. This allows at least to run with KVM PR, provided no
> > compat
> > mode is requested from the command line (which should be the case
> > when
> > running PR nested). This is what this patch does.
> >=20
> > While here, we also fix the side effect where KVM would fail but we
> > would
> > change the CPU state in QEMU anyway.
> >=20
> > [1] http://patchwork.ozlabs.org/patch/782039/
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> I meant to send a follow up but it fell on my priority list so thanks
> for this
>=20

No problem :)

This is more a workaround than an actual fix since CAS will still want to
change the compat mode and fail, but at least QEMU doesn't exit right away.
I needed that to chase down another bug that breaks loadvm of a KVM PR gues=
t.

> Looks good to me
>=20
> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20

Thanks!

> > ---
> > =C2=A0target/ppc/compat.c |=C2=A0=C2=A0=C2=A0=C2=A09 +++++----
> > =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> > index f1b67faa97e3..f8729fe46d61 100644
> > --- a/target/ppc/compat.c
> > +++ b/target/ppc/compat.c
> > @@ -140,16 +140,17 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t
> > compat_pvr, Error **errp)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu_synchronize_state(CPU(cpu));
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0cpu->compat_pvr =3D compat_pvr;
> > -=C2=A0=C2=A0=C2=A0=C2=A0env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0if (kvm_enabled()) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (kvm_enabled() && cpu->compat_pvr !=3D comp=
at_pvr) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D kvmpp=
c_set_compat(cpu, cpu->compat_pvr);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0error_setg_errno(errp, -ret,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"Unable to set CPU compatibility mode
> > in KVM");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0cpu->compat_pvr =3D compat_pvr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> > =C2=A0}
> > =C2=A0
> > =C2=A0typedef struct {
> >  =20


--Sig_/UO+zmTMtpAUx2r8TcmYw0np
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmSsBkACgkQAvw66wEB28LIZgCeN+JBgZRftFt7cQzvlia5tXl9
EjEAoJ2fDq6gp7JMc2GG2w/Vue0F2Zn2
=7xYH
-----END PGP SIGNATURE-----

--Sig_/UO+zmTMtpAUx2r8TcmYw0np--
