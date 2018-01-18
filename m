Received: from eggs.gnu.org ([2001:4830:134:3::10]:50563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fw-0005x0-D6
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fs-0001Dg-CZ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:44 -0500
Date: Thu, 18 Jan 2018 16:06:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118050616.GM30352@umbus.fritz.box>
References: <20180115063235.7518-2-sjitindarsingh@gmail.com>
	<20180115065837.12431-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="deSP9Bnrq3taYiYM"
Content-Disposition: inline
In-Reply-To: <20180115065837.12431-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V4 1/6] target/ppc/kvm: Add
 cap_ppc_safe_[cache/bounds_check/indirect_branch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org


--deSP9Bnrq3taYiYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 05:58:37PM +1100, Suraj Jitindar Singh wrote:
> Add three new kvm capabilities used to represent the level of host support
> for three corresponding workarounds.
>=20
> Host support for each of the capabilities is queried through the
> new ioctl KVM_PPC_GET_CPU_CHAR which returns four uint64 quantities. The
> first two, character and behaviour, represent the available
> characteristics of the cpu and the behaviour of the cpu respectively.
> The second two, c_mask and b_mask, represent the mask of known bits for
> the character and beheviour dwords respectively.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Waiting for the kernel part to go in before merging, though.

> ---
>=20
> V3 -> V4:
> - Move kvmppc_get_cpu_characteristics() function implementation to fix
>   compilation on some targets.
>=20
> ---
>  include/hw/ppc/spapr.h          | 12 +++++++++
>  linux-headers/asm-powerpc/kvm.h |  8 ++++++
>  linux-headers/linux/kvm.h       |  3 +++
>  target/ppc/kvm.c                | 58 +++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/kvm_ppc.h            | 18 +++++++++++++
>  5 files changed, 99 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 0f5628f22e..eded0ea57d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -295,6 +295,18 @@ struct sPAPRMachineState {
>  #define H_DABRX_KERNEL     (1ULL<<(63-62))
>  #define H_DABRX_USER       (1ULL<<(63-63))
> =20
> +/* Values for KVM_PPC_GET_CPU_CHAR & H_GET_CPU_CHARACTERISTICS */
> +#define H_CPU_CHAR_SPEC_BAR_ORI31               PPC_BIT(0)
> +#define H_CPU_CHAR_BCCTRL_SERIALISED            PPC_BIT(1)
> +#define H_CPU_CHAR_L1D_FLUSH_ORI30              PPC_BIT(2)
> +#define H_CPU_CHAR_L1D_FLUSH_TRIG2              PPC_BIT(3)
> +#define H_CPU_CHAR_L1D_THREAD_PRIV              PPC_BIT(4)
> +#define H_CPU_CHAR_HON_BRANCH_HINTS             PPC_BIT(5)
> +#define H_CPU_CHAR_THR_RECONF_TRIG              PPC_BIT(6)
> +#define H_CPU_BEHAV_FAVOUR_SECURITY             PPC_BIT(0)
> +#define H_CPU_BEHAV_L1D_FLUSH_PR                PPC_BIT(1)
> +#define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR           PPC_BIT(2)
> +
>  /* Each control block has to be on a 4K boundary */
>  #define H_CB_ALIGNMENT     4096
> =20
> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/=
kvm.h
> index 61d6049f4c..5d2cb26848 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -443,6 +443,14 @@ struct kvm_ppc_rmmu_info {
>  	__u32	ap_encodings[8];
>  };
> =20
> +/* For KVM_PPC_GET_CPU_CHAR */
> +struct kvm_ppc_cpu_char {
> +        __u64   character;      /* characteristics of the CPU */
> +        __u64   behaviour;      /* recommended software behaviour */
> +        __u64   c_mask;         /* valid bits in character */
> +        __u64   b_mask;         /* valid bits in behaviour */
> +};
> +
>  /* Per-vcpu XICS interrupt controller state */
>  #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
> =20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index ce6c2f11f4..c35f1bd363 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -932,6 +932,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_SYNIC2 148
>  #define KVM_CAP_HYPERV_VP_INDEX 149
>  #define KVM_CAP_S390_AIS_MIGRATION 150
> +#define KVM_CAP_PPC_GET_CPU_CHAR 151
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20
> @@ -1261,6 +1262,8 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_PPC_CONFIGURE_V3_MMU  _IOW(KVMIO,  0xaf, struct kvm_ppc_mmuv=
3_cfg)
>  /* Available with KVM_CAP_PPC_RADIX_MMU */
>  #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_i=
nfo)
> +/* Available with KVM_CAP_PPC_GET_CPU_CHAR */
> +#define KVM_PPC_GET_CPU_CHAR      _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_=
char)
> =20
>  /* ioctl for vm fd */
>  #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 914be687e7..b16f731522 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -89,6 +89,9 @@ static int cap_mmu_radix;
>  static int cap_mmu_hash_v3;
>  static int cap_resize_hpt;
>  static int cap_ppc_pvr_compat;
> +static int cap_ppc_safe_cache;
> +static int cap_ppc_safe_bounds_check;
> +static int cap_ppc_safe_indirect_branch;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -121,6 +124,7 @@ static bool kvmppc_is_pr(KVMState *ks)
>  }
> =20
>  static int kvm_ppc_register_host_cpu_type(MachineState *ms);
> +static void kvmppc_get_cpu_characteristics(KVMState *s);
> =20
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> @@ -147,6 +151,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
> +    kvmppc_get_cpu_characteristics(s);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2456,6 +2461,59 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
> +static void kvmppc_get_cpu_characteristics(KVMState *s)
> +{
> +    struct kvm_ppc_cpu_char c;
> +    int ret;
> +
> +    /* Assume broken */
> +    cap_ppc_safe_cache =3D 0;
> +    cap_ppc_safe_bounds_check =3D 0;
> +    cap_ppc_safe_indirect_branch =3D 0;
> +
> +    ret =3D kvm_vm_check_extension(s, KVM_CAP_PPC_GET_CPU_CHAR);
> +    if (!ret) {
> +        return;
> +    }
> +    ret =3D kvm_vm_ioctl(s, KVM_PPC_GET_CPU_CHAR, &c);
> +    if (ret < 0) {
> +        return;
> +    }
> +    /* Parse and set cap_ppc_safe_cache */
> +    if (~c.behaviour & c.b_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
> +        cap_ppc_safe_cache =3D 2;
> +    } else if ((c.character & c.c_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
> +               (c.character & c.c_mask & (H_CPU_CHAR_L1D_FLUSH_ORI30 |
> +                                          H_CPU_CHAR_L1D_FLUSH_TRIG2))) {
> +        cap_ppc_safe_cache =3D 1;
> +    }
> +    /* Parse and set cap_ppc_safe_bounds_check */
> +    if (~c.behaviour & c.b_mask & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR) {
> +        cap_ppc_safe_bounds_check =3D 2;
> +    } else if (c.character & c.c_mask & H_CPU_CHAR_SPEC_BAR_ORI31) {
> +        cap_ppc_safe_bounds_check =3D 1;
> +    }
> +    /* Parse and set cap_ppc_safe_indirect_branch */
> +    if (c.character & H_CPU_CHAR_BCCTRL_SERIALISED) {
> +        cap_ppc_safe_indirect_branch =3D 2;
> +    }
> +}
> +
> +int kvmppc_get_cap_safe_cache(void)
> +{
> +    return cap_ppc_safe_cache;
> +}
> +
> +int kvmppc_get_cap_safe_bounds_check(void)
> +{
> +    return cap_ppc_safe_bounds_check;
> +}
> +
> +int kvmppc_get_cap_safe_indirect_branch(void)
> +{
> +    return cap_ppc_safe_indirect_branch;
> +}
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr =3D mfpvr();
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index ecb55493cc..39830baa77 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -59,6 +59,9 @@ bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
>  bool kvmppc_has_cap_mmu_radix(void);
>  bool kvmppc_has_cap_mmu_hash_v3(void);
> +int kvmppc_get_cap_safe_cache(void);
> +int kvmppc_get_cap_safe_bounds_check(void);
> +int kvmppc_get_cap_safe_indirect_branch(void);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> @@ -290,6 +293,21 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
>      return false;
>  }
> =20
> +static inline int kvmppc_get_cap_safe_cache(void)
> +{
> +    return 0;
> +}
> +
> +static inline int kvmppc_get_cap_safe_bounds_check(void)
> +{
> +    return 0;
> +}
> +
> +static inline int kvmppc_get_cap_safe_indirect_branch(void)
> +{
> +    return 0;
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

--deSP9Bnrq3taYiYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgK0gACgkQbDjKyiDZ
s5JnJw/+P94MCq/Q40SIGA49WTG0U7PWMjqUg0VqMUiJJ3anTgO6Qx2LlI3zh0oI
6LtqbcAe3pbYonE6xXPruAUjsRu/8VEfID4icLvss5CWOcBH3fGexq9YUoFoArrx
PmZ1u3q6kVdLZe5vlVGSe/6zmTuWfdrdIsOwrCiqFr9RtxE91Vek515ilMjn9krb
IVQJIWoln96xhVo+7B4GNWkDHpbwvW0HuGOyBohiHJRhCVU7YVoBLdyQBVmTBxoh
5sHslclw+3Eruwp0cfXbdFE7lq69445spjcz8DCsemF/FGCUdgB1rVbXFgQIsDbA
W+UEmeUrGPM7CQAASyzXhPEn7Q7fuWvv9loPpiyLrQYtYq8VMyhYw0C7CEoP3tXn
YdeOSbpcfJRf9is4s93pAeorWu1RmJTNYS4nDQL6gilRxj+dkB87eRCgvkYCTKbO
R9rfn91l1lDoFtuKw8uIS9U3H08PE9Y5OXkSNDKHEP+zp9pCascN9MXmGEkoANYS
2C9e6pFpnKxWWqCyyi9oSjOeEhPUMJauF1tMV3QNxwCil2LoZ5029HgCN7FKH2Yz
+1Ynixx9gzhIJLRIIiPTFRgefIhXJeqSj56r61E1W7nz0dqgAAm9FhjD9lZz8r8R
mZ7vuXJvCyGTxUPvLgOXA8FMG+tDUAhOIzOEOjJM9c8ITDUp3J8=
=rELI
-----END PGP SIGNATURE-----

--deSP9Bnrq3taYiYM--
