Received: from eggs.gnu.org ([2001:4830:134:3::10]:39354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVmY-00058C-W7
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVmU-00058V-S8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:47 -0500
Date: Tue, 28 Feb 2017 11:13:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228001305.GC17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<8d7198bfc4cf9a4f9a9f135cacdedaecd7b29990.1487829585.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ijzeh677kh28wBBZ"
Content-Disposition: inline
In-Reply-To: <8d7198bfc4cf9a4f9a9f135cacdedaecd7b29990.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/12] target-ppc: support
 KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com


--Ijzeh677kh28wBBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 05:00:00PM +1100, Sam Bobroff wrote:
> Query and cache the value of two new KVM capabilities that indicate
> KVM's support for new radix and hash modes of the MMU.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>=20
> * cap_mmu_hash renamed to cap_mmu_hash_v3.
>=20
>  target/ppc/kvm.c     | 14 ++++++++++++++
>  target/ppc/kvm_ppc.h | 12 ++++++++++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index cf62a42c1f..8b153808fd 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -83,6 +83,8 @@ static int cap_papr;
>  static int cap_htab_fd;
>  static int cap_fixup_hcalls;
>  static int cap_htm;             /* Hardware transactional memory support=
 */
> +static int cap_mmu_radix;
> +static int cap_mmu_hash_v3;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -136,6 +138,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
>      cap_fixup_hcalls =3D kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
>      cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
> +    cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
> +    cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
> =20
>      if (!cap_interrupt_level) {
>          fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
> @@ -2430,6 +2434,16 @@ bool kvmppc_has_cap_htm(void)
>      return cap_htm;
>  }
> =20
> +bool kvmppc_has_cap_mmu_radix(void)
> +{
> +    return cap_mmu_radix;
> +}
> +
> +bool kvmppc_has_cap_mmu_hash_v3(void)
> +{
> +    return cap_mmu_hash_v3;
> +}
> +
>  static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(pcc);
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 8da2ee418a..56e222dfc2 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -56,6 +56,8 @@ void kvmppc_hash64_write_pte(CPUPPCState *env, target_u=
long pte_index,
>                               target_ulong pte0, target_ulong pte1);
>  bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
> +bool kvmppc_has_cap_mmu_radix(void);
> +bool kvmppc_has_cap_mmu_hash_v3(void);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> @@ -262,6 +264,16 @@ static inline bool kvmppc_has_cap_htm(void)
>      return false;
>  }
> =20
> +static inline bool kvmppc_has_cap_mmu_radix(void)
> +{
> +    return false;
> +}
> +
> +static inline bool kvmppc_has_cap_mmu_hash_v3(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_enable_hwrng(void)
>  {
>      return -1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ijzeh677kh28wBBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtMCRAAoJEGw4ysog2bOSkVUP/izocPmKn9yiqp64EaENUPox
OEDEunXCJ+9bPry9yap8N3yuuK+G5kTRJ9GZXebR4gXp5CcDPlwmdoUiGjeFYZ/1
sWAs6VvTPvm4ItnwVBHbex6CZY13ewwwck944vHo1rqrteXA1ySyBi1lsT7lbpTj
myJ7074zIi1nj+8sIglvku/qNwQOhwBHULkXLk0kNAEH9EmTJMrBSo/j9bEM/ymo
IqZoKtSMJFs4uBCtVVyXbAei0yzqrHxlCaq2wUFzCIigIdXTiMCynYSS4/1oPB/R
W5PVK8NCs2VMpZpilqVitZQRCUAW3cuewlf1N/FElTPpdOqG4+e5ivsdPQTk0LGx
1oH3IzBtGNWXrNJk2Rylp5D5v2+MX1UrShVmcwyyoTHT8EcRUp/p44yCT6q8hpt2
gKRqxAXOwTixuNwydcsFHuoyjRZleTDyKwDhUVZjafI993UsCKvYUvHVpj77BrUC
iwNLbT8xLBUQqnyMn97p+lVvGm1rOww2NG7Y+7RUIalZpDtXKmKJkAg6kLJlSJcJ
fp1Bgs8r1lBgvtkrWBcaLlh311CWVZgKzc0p9/grtFdZI0f86w7QFtxf20SPyy5t
xIG8BCBmoQz+JEjbkAmiK9e5Z154ADnbmB0suNaXzfGbImJPWvbhGD5bRv2zly8O
4XuuLNIXtyRrPTfFA5Gz
=H2HO
-----END PGP SIGNATURE-----

--Ijzeh677kh28wBBZ--
