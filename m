Received: from eggs.gnu.org ([2001:4830:134:3::10]:50906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gA6dL-0002w8-BR
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 01:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gA6dI-0000gf-0o
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 01:02:07 -0400
Date: Wed, 10 Oct 2018 15:32:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181010043252.GL7004@umbus.fritz.box>
References: <20181008032539.6437-1-sjitindarsingh@gmail.com>
	<20181008032539.6437-4-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9YpAf2t6OxtMGzg"
Content-Disposition: inline
In-Reply-To: <20181008032539.6437-4-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 3/3] ppc/spapr_caps: Add
 SPAPR_CAP_NESTED_KVM_HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@ozlabs.org


--M9YpAf2t6OxtMGzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 02:25:39PM +1100, Suraj Jitindar Singh wrote:
> Add the spapr cap SPAPR_CAP_NESTED_KVM_HV to be used to control the
> availability of nested kvm-hv to the level 1 (L1) guest.
>=20
> Assuming a hypervisor with support enabled an L1 guest can be allowed to
> use the kvm-hv module (and thus run it's own kvm-hv guests) by setting:
> -machine pseries,cap-nested-hv=3Dtrue
> or disabled with:
> -machine pseries,cap-nested-hv=3Dfalse
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 32 ++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  5 ++++-
>  target/ppc/kvm.c       | 12 ++++++++++++
>  target/ppc/kvm_ppc.h   | 12 ++++++++++++
>  5 files changed, 62 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 98868d893a..8ce97900e9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1915,6 +1915,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_sbbc,
>          &vmstate_spapr_cap_ibs,
>          &vmstate_spapr_irq_map,
> +        &vmstate_spapr_cap_nested_kvm_hv,
>          NULL
>      }
>  };
> @@ -3886,6 +3887,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB */
> +    smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_xics;
>  }
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index aa605cea91..64f98ae68d 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -368,6 +368,28 @@ static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachi=
neState *spapr,
>      ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
>  }
> =20
> +static void cap_nested_kvm_hv_apply(sPAPRMachineState *spapr,
> +                                    uint8_t val, Error **errp)
> +{
> +    if (!val) {
> +        /* capability disabled by default */
> +        return;
> +    }
> +
> +    if (tcg_enabled()) {
> +        error_setg(errp,
> +                   "No Nested KVM-HV support in tcg, try cap-nested-hv=
=3Doff");
> +    } else if (kvm_enabled()) {
> +        if (!kvmppc_has_cap_nested_kvm_hv()) {
> +            error_setg(errp,
> +"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=3D=
off");
> +        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
> +                error_setg(errp,
> +"Error enabling cap-nested-hv with KVM, try cap-nested-hv=3Doff");
> +        }
> +    }
> +}
> +
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -437,6 +459,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .apply =3D cap_hpt_maxpagesize_apply,
>          .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
>      },
> +    [SPAPR_CAP_NESTED_KVM_HV] =3D {
> +        .name =3D "nested-hv",
> +        .description =3D "Allow Nested KVM-HV",
> +        .index =3D SPAPR_CAP_NESTED_KVM_HV,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_nested_kvm_hv_apply,
> +    },
>  };
> =20
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -564,6 +595,7 @@ SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
>  SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
>  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> +SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> =20
>  void spapr_caps_init(sPAPRMachineState *spapr)
>  {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index ad4d7cfd97..bced85dd92 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -70,8 +70,10 @@ typedef enum {
>  #define SPAPR_CAP_IBS                   0x05
>  /* HPT Maximum Page Size (encoded as a shift) */
>  #define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
> +/* Nested KVM-HV */
> +#define SPAPR_CAP_NESTED_KVM_HV         0x07
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_HPT_MAXPAGESIZE + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_KVM_HV + 1)
> =20
>  /*
>   * Capability Values
> @@ -793,6 +795,7 @@ extern const VMStateDescription vmstate_spapr_cap_dfp;
>  extern const VMStateDescription vmstate_spapr_cap_cfpc;
>  extern const VMStateDescription vmstate_spapr_cap_sbbc;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
> +extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> =20
>  static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 30aeafa7de..f81327d6cd 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -91,6 +91,7 @@ static int cap_ppc_pvr_compat;
>  static int cap_ppc_safe_cache;
>  static int cap_ppc_safe_bounds_check;
>  static int cap_ppc_safe_indirect_branch;
> +static int cap_ppc_nested_kvm_hv;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -150,6 +151,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
>      kvmppc_get_cpu_characteristics(s);
> +    cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2422,6 +2424,16 @@ int kvmppc_get_cap_safe_indirect_branch(void)
>      return cap_ppc_safe_indirect_branch;
>  }
> =20
> +bool kvmppc_has_cap_nested_kvm_hv(void)
> +{
> +    return !!cap_ppc_nested_kvm_hv;
> +}
> +
> +int kvmppc_set_cap_nested_kvm_hv(int enable)
> +{
> +    return kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_NESTED_HV, 0, enable=
);
> +}
> +
>  bool kvmppc_has_cap_spapr_vfio(void)
>  {
>      return cap_spapr_vfio;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f696c6e498..bdfaa4e70a 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -62,6 +62,8 @@ bool kvmppc_has_cap_mmu_hash_v3(void);
>  int kvmppc_get_cap_safe_cache(void);
>  int kvmppc_get_cap_safe_bounds_check(void);
>  int kvmppc_get_cap_safe_indirect_branch(void);
> +bool kvmppc_has_cap_nested_kvm_hv(void);
> +int kvmppc_set_cap_nested_kvm_hv(int enable);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> @@ -320,6 +322,16 @@ static inline int kvmppc_get_cap_safe_indirect_branc=
h(void)
>      return 0;
>  }
> =20
> +static inline bool kvmppc_has_cap_nested_kvm_hv(void)
> +{
> +    return false;
> +}
> +
> +static inline int kvmppc_set_cap_nested_kvm_hv(int enable)
> +{
> +    return -1;
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

--M9YpAf2t6OxtMGzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu9gPQACgkQbDjKyiDZ
s5IqThAAqOahTmpyd6f/D2XBl5O7KxZCMBcXnVeiJCw80Ur1uOnQ00nRG7B4bsLC
IrGvAN0KvICfFN/pmBh/QnivZa+Lv1CzclS4vPj3FGx+mv2d6yoAY1CRoA/hOCIk
RWyhyyaQlrHAnN9FNUaOdF3mZr3/iRSm0nXXi4e9PEEJXGR1MUCgj9tLX3EaA7lp
EC7LbhGa5lvm4ScJRg2e0m/fgc7HzMcQc8wiNcT7jqhw8fC660F+EUcdYdrGrmZ+
P5Ny07zo0Sb5+9GInRNA0UZYzUUC1PPiJx4W8l4bYrPejDSBO4p2z17H9Wed1UM8
Jgepx82icWrSJwjxgxsdM3hySv2l2LCu2YiFuUxmvJvINwb0OhLlq6E0zjzUkrYi
/ZUq+3SS0XfqcS8ehHdy9XKPPZcI/4DY6klOteo3hqZNkIJQXAtVj5pXI1ZX2szd
JSd4dd/4+jz3tMBfX63TBE3JyaLaneX6ssRwa8Si9VsOvCkJSjBAyursufKSZ4zv
gtbjE2lwMuc/46HZHjf0JnVITpMDf1rnSjFJ4oh9RZAu2kI8T/rny7Xrmgtcxzko
1P4Y+vdfBjAktHJwf2aUrW4fY8Tyy7cfZFxSkluFwc2DXzmHZrfPdfHs157T14oi
3imfA5p9bHcG/eDOz4faNkNCNedJfQ8AeY/6B5th/xJdE7y1mGw=
=qi1G
-----END PGP SIGNATURE-----

--M9YpAf2t6OxtMGzg--
