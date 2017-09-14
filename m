Received: from eggs.gnu.org ([2001:4830:134:3::10]:42496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsS9e-0004Ai-4n
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsS9Y-0003Cm-7j
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:17:58 -0400
References: <150538608438.12346.9391407971434352383.stgit@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0cb6cfca-05e6-d2e2-7345-541fa21490dd@redhat.com>
Date: Thu, 14 Sep 2017 13:17:48 +0200
MIME-Version: 1.0
In-Reply-To: <150538608438.12346.9391407971434352383.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 14.09.2017 12:48, Greg Kurz wrote:
> If the host has both KVM PR and KVM HV loaded and we pass:
>=20
> 	-machine pseries,accel=3Dkvm,kvm-type=3DPR
>=20
> the kvmppc_is_pr() returns false instead of true. Since the helper
> is mostly used as fallback, it doesn't have any real impact with
> recent kernels. A notable exception is the workaround to allow
> migration between compatible hosts with different PVRs (eg, POWER8
> and POWER8E), since KVM still doesn't provide a way to check if a
> specific PVR is supported (see commit c363a37a450f for details).
>=20
> According to the official KVM API documentation [1], KVM_PPC_GET_PVINFO
> is "vm ioctl", but we check it as a global ioctl. The following functio=
n
> in KVM is hence called with kvm =3D=3D NULL and considers we're in HV m=
ode.
>=20
> int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> {
> 	int r;
> 	/* Assume we're using HV mode when the HV module is loaded */
> 	int hv_enabled =3D kvmppc_hv_ops ? 1 : 0;
>=20
> 	if (kvm) {
> 		/*
> 		 * Hooray - we know which VM type we're running on. Depend on
> 		 * that rather than the guess above.
> 		 */
> 		hv_enabled =3D is_kvmppc_hv_enabled(kvm);
> 	}
>=20
> Let's use kvm_vm_check_extension() to fix the issue.

By the way, what about the other CAPs that rely on hv_enabled? grepping
through the QEMU sources, I can see:

 cap_ppc_smt =3D kvm_check_extension(s, KVM_CAP_PPC_SMT);

 cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);

 int ret =3D kvm_check_extension(s, KVM_CAP_NR_VCPUS);

 return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);

 !kvm_check_extension(cs->kvm_state, KVM_CAP_SW_TLB)) {

... do we need to fix them, too?

 Thomas
