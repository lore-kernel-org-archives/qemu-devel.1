Received: from eggs.gnu.org ([2001:4830:134:3::10]:45133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsVIX-0004NU-LH
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsVIS-00013t-LE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:39:21 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:53162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsVIS-00012i-EX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:39:16 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id C8BD3ABBB5
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 16:39:14 +0200 (CEST)
Date: Thu, 14 Sep 2017 16:39:06 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170914163906.37aee76e@bahia.lan>
In-Reply-To: <20170914132749.14e35c64@bahia.lan>
References: <150538608438.12346.9391407971434352383.stgit@bahia.lan>
	<0cb6cfca-05e6-d2e2-7345-541fa21490dd@redhat.com>
	<20170914132749.14e35c64@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/fAPKW+T0U1V4RMi5UF0DdNO";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/kvm: use
 kvm_vm_check_extension() in kvmppc_is_pr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/fAPKW+T0U1V4RMi5UF0DdNO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2017 13:27:49 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Thu, 14 Sep 2017 13:17:48 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> > On 14.09.2017 12:48, Greg Kurz wrote: =20
> > > If the host has both KVM PR and KVM HV loaded and we pass:
> > >=20
> > > 	-machine pseries,accel=3Dkvm,kvm-type=3DPR
> > >=20
> > > the kvmppc_is_pr() returns false instead of true. Since the helper
> > > is mostly used as fallback, it doesn't have any real impact with
> > > recent kernels. A notable exception is the workaround to allow
> > > migration between compatible hosts with different PVRs (eg, POWER8
> > > and POWER8E), since KVM still doesn't provide a way to check if a
> > > specific PVR is supported (see commit c363a37a450f for details).
> > >=20
> > > According to the official KVM API documentation [1], KVM_PPC_GET_PVIN=
FO
> > > is "vm ioctl", but we check it as a global ioctl. The following funct=
ion
> > > in KVM is hence called with kvm =3D=3D NULL and considers we're in HV=
 mode.
> > >=20
> > > int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> > > {
> > > 	int r;
> > > 	/* Assume we're using HV mode when the HV module is loaded */
> > > 	int hv_enabled =3D kvmppc_hv_ops ? 1 : 0;
> > >=20
> > > 	if (kvm) {
> > > 		/*
> > > 		 * Hooray - we know which VM type we're running on. Depend on
> > > 		 * that rather than the guess above.
> > > 		 */
> > > 		hv_enabled =3D is_kvmppc_hv_enabled(kvm);
> > > 	}
> > >=20
> > > Let's use kvm_vm_check_extension() to fix the issue.   =20
> >=20
> > By the way, what about the other CAPs that rely on hv_enabled? grepping
> > through the QEMU sources, I can see:
> >=20
> >  cap_ppc_smt =3D kvm_check_extension(s, KVM_CAP_PPC_SMT);
> >=20

So this one was already fixed in David's ppc-for-2.11 branch thanks to
commit fa98fbfcdfcb9... which introduced a new KVM_CAP_PPC_SMT_POSSIBLE
cap, which is also a VM ioctl and needs to be fixed :)

    cap_ppc_smt_possible =3D kvm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBL=
E);

> >  cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
> >=20

Needs fixing.

> >  int ret =3D kvm_check_extension(s, KVM_CAP_NR_VCPUS);
> >=20

Needs fixing.

> >  return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
> >=20

Needs fixing.

> >  !kvm_check_extension(cs->kvm_state, KVM_CAP_SW_TLB)) {
> >=20

This seems to be e500 specific, and thus isn't affected.

> > ... do we need to fix them, too?
> >  =20
>=20
> I'm currently going through the KVM code to see which ones need to be
> fixed. I'll send more patches shortly :)
>=20
> Cheers,
>=20
> --
> Greg
>=20
> >  Thomas =20
>=20


--Sig_/fAPKW+T0U1V4RMi5UF0DdNO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbqUigAKCRAC/DrrAQHb
wqFDAJ9TpsaDQiuiHTMI0x1VVNLWxjrHKwCgkeFAGsXC5rhtMHSEmjhnSF9TNtM=
=0PEq
-----END PGP SIGNATURE-----

--Sig_/fAPKW+T0U1V4RMi5UF0DdNO--
