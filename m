Received: from eggs.gnu.org ([2001:4830:134:3::10]:43669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsiyj-0006Hg-Bj
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsiyf-0005nN-Sl
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:15:49 -0400
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541714343.1616.11893912014879112098.stgit@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <19f09a67-5b16-6bdf-5c72-c2df84537ea7@redhat.com>
Date: Fri, 15 Sep 2017 07:15:41 +0200
MIME-Version: 1.0
In-Reply-To: <150541714343.1616.11893912014879112098.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/kvm: check some capabilities with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 14.09.2017 21:25, Greg Kurz wrote:
> The following capabilities are VM specific:
> - KVM_CAP_PPC_SMT_POSSIBLE
> - KVM_CAP_PPC_HTAB_FD

BTW, looks like kvmppc_has_cap_htab_fd() is dead code ... should we
either remove it or check it somewhere?

> - KVM_CAP_PPC_ALLOC_HTAB
>=20
> If both KVM HV and KVM PR are present, checking them always return
> the HV value, even if we explicitely requested to use PR.
>=20
> This has no visible effect for KVM_CAP_PPC_ALLOC_HTAB, because we also
> try the KVM_PPC_ALLOCATE_HTAB ioctl which is only suppored by HV. As
> a consequence, the spapr code doesn't even check KVM_CAP_PPC_HTAB_FD.
>
> However, this will cause kvmppc_hint_smt_possible(), introduced by
> commit fa98fbfcdfcb9, to report several VSMT modes (eg, Available
> VSMT modes: 8 4 2 1) whereas PR only support mode 1.
>=20
> This patch fixes all three anyway to use kvm_vm_check_extension(). It
> is okay since the VM is already created at the time kvm_arch_init() or
> kvmppc_reset_htab() is called.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/kvm.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 1deaf106d2b9..208c70e81426 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -131,7 +131,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_interrupt_level =3D kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEV=
EL);
>      cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
>      cap_booke_sregs =3D kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS=
);
> -    cap_ppc_smt_possible =3D kvm_check_extension(s, KVM_CAP_PPC_SMT_PO=
SSIBLE);
> +    cap_ppc_smt_possible =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SMT=
_POSSIBLE);
>      cap_ppc_rma =3D kvm_check_extension(s, KVM_CAP_PPC_RMA);
>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>      cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
> @@ -143,7 +143,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_ppc_watchdog =3D kvm_check_extension(s, KVM_CAP_PPC_BOOKE_WATC=
HDOG);
>      /* Note: we don't set cap_papr here, because this capability is
>       * only activated after this by kvmppc_set_papr() */
> -    cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
> +    cap_htab_fd =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
>      cap_fixup_hcalls =3D kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCAL=
L);
>      cap_ppc_smt =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SMT);
>      cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
> @@ -2353,7 +2353,7 @@ int kvmppc_reset_htab(int shift_hint)
>          /* Full emulation, tell caller to allocate htab itself */
>          return 0;
>      }
> -    if (kvm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
> +    if (kvm_vm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
>          int ret;
>          ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_ALLOCATE_HTAB, &shift)=
;
>          if (ret =3D=3D -ENOTTY) {

Looking at the comment in the code after the "if (ret =3D=3D -ENOTTY)" li=
ne,
it sounds like there is a bug in the kernel and the
KVM_CAP_PPC_ALLOC_HTAB should depend on the hv_enabled variable, too?
Anyway, that's another topic, your patch is fine!

Reviewed-by: Thomas Huth <thuth@redhat.com>
