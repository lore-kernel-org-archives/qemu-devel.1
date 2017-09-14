Received: from eggs.gnu.org ([2001:4830:134:3::10]:48552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsSJM-0001MS-39
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsSJI-0002oy-W6
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:28:00 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:59436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsSJI-0002ng-Qq
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:27:56 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 57A7AAC031
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 13:27:55 +0200 (CEST)
Date: Thu, 14 Sep 2017 13:27:49 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170914132749.14e35c64@bahia.lan>
In-Reply-To: <0cb6cfca-05e6-d2e2-7345-541fa21490dd@redhat.com>
References: <150538608438.12346.9391407971434352383.stgit@bahia.lan>
	<0cb6cfca-05e6-d2e2-7345-541fa21490dd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/divoOOuM5Op=nXq6Bx._Fer";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] ppc/kvm: use kvm_vm_check_extension() in
 kvmppc_is_pr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/divoOOuM5Op=nXq6Bx._Fer
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2017 13:17:48 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 14.09.2017 12:48, Greg Kurz wrote:
> > If the host has both KVM PR and KVM HV loaded and we pass:
> >=20
> > 	-machine pseries,accel=3Dkvm,kvm-type=3DPR
> >=20
> > the kvmppc_is_pr() returns false instead of true. Since the helper
> > is mostly used as fallback, it doesn't have any real impact with
> > recent kernels. A notable exception is the workaround to allow
> > migration between compatible hosts with different PVRs (eg, POWER8
> > and POWER8E), since KVM still doesn't provide a way to check if a
> > specific PVR is supported (see commit c363a37a450f for details).
> >=20
> > According to the official KVM API documentation [1], KVM_PPC_GET_PVINFO
> > is "vm ioctl", but we check it as a global ioctl. The following function
> > in KVM is hence called with kvm =3D=3D NULL and considers we're in HV m=
ode.
> >=20
> > int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> > {
> > 	int r;
> > 	/* Assume we're using HV mode when the HV module is loaded */
> > 	int hv_enabled =3D kvmppc_hv_ops ? 1 : 0;
> >=20
> > 	if (kvm) {
> > 		/*
> > 		 * Hooray - we know which VM type we're running on. Depend on
> > 		 * that rather than the guess above.
> > 		 */
> > 		hv_enabled =3D is_kvmppc_hv_enabled(kvm);
> > 	}
> >=20
> > Let's use kvm_vm_check_extension() to fix the issue. =20
>=20
> By the way, what about the other CAPs that rely on hv_enabled? grepping
> through the QEMU sources, I can see:
>=20
>  cap_ppc_smt =3D kvm_check_extension(s, KVM_CAP_PPC_SMT);
>=20
>  cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
>=20
>  int ret =3D kvm_check_extension(s, KVM_CAP_NR_VCPUS);
>=20
>  return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
>=20
>  !kvm_check_extension(cs->kvm_state, KVM_CAP_SW_TLB)) {
>=20
> ... do we need to fix them, too?
>=20

I'm currently going through the KVM code to see which ones need to be
fixed. I'll send more patches shortly :)

Cheers,

--
Greg

>  Thomas


--Sig_/divoOOuM5Op=nXq6Bx._Fer
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbpntQAKCRAC/DrrAQHb
wgTxAJkBIBZ7F5VzT6jXJsJX6ksps31apwCcDseYePK+x3Gwi6thJ6tmvDMg7fU=
=0Lh4
-----END PGP SIGNATURE-----

--Sig_/divoOOuM5Op=nXq6Bx._Fer--
