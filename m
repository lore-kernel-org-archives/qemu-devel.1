Received: from eggs.gnu.org ([2001:4830:134:3::10]:36808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ8Wl-00025O-FG
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ8Wi-0002VW-BI
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:02:15 -0500
Date: Wed, 10 Jan 2018 15:54:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180110045426.GA19773@umbus.fritz.box>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20180109092103.18458-3-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [RFC 2/3] hw/spapr/spapr_caps: Add new
 caps safe_[cache/bounds_check/indirect_branch]
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


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 08:21:02PM +1100, Suraj Jitindar Singh wrote:
> This patch adds three new capabilities:
> cap-cfpc -> safe_cache
> cap-sbbc -> safe_bounds_check
> cap-ibs  -> safe_indirect_branch
>=20
> Each capability is tristate with the possible values "broken",
> "workaround" or "fixed". Add generic getter and setter functions for
> this new capability type. Add these new capabilities to the capabilities
> list. The maximum value for the capabilities is queried from kvm through
> new kvm capabilities. The requested values are considered to be
> compatible if kvm can support an equal or higher value for each
> capability.
>=20
> Discussion:
> Currently these new capabilities default to broken to allow for
> backwards compatibility, is this the best option?
> ---
>  hw/ppc/spapr.c            |   6 ++
>  hw/ppc/spapr_caps.c       | 224 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h    |  15 +++-
>  linux-headers/linux/kvm.h |   3 +
>  target/ppc/kvm.c          |  28 ++++++
>  target/ppc/kvm_ppc.h      |  18 ++++
>  6 files changed, 293 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7fa45729ba..d9700b0254 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1765,6 +1765,9 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_htm,
>          &vmstate_spapr_cap_vsx,
>          &vmstate_spapr_cap_dfp,
> +        &vmstate_spapr_cap_cfpc,
> +        &vmstate_spapr_cap_sbbc,
> +        &vmstate_spapr_cap_ibs,
>          NULL
>      }
>  };
> @@ -3837,6 +3840,9 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      spapr_caps_add_properties(smc, &error_abort);
>  }
> =20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index af40f2e469..e6910aa191 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -75,6 +75,64 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v=
, const char *name,
>                                               SPAPR_CAP_CMD_LINE;
>  }
> =20
> +static void spapr_cap_get_tristate(Object *obj, Visitor *v, const char *=
name,
> +                                   void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    char *val =3D NULL;
> +    uint8_t value =3D spapr_get_cap(spapr, cap->index);
> +
> +    switch (value) {
> +    case SPAPR_CAP_BROKEN:
> +        val =3D g_strdup("broken");
> +        break;
> +    case SPAPR_CAP_WORKAROUND:
> +        val =3D g_strdup("workaround");
> +        break;
> +    case SPAPR_CAP_FIXED:
> +        val =3D g_strdup("fixed");
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    visit_type_str(v, name, &val, errp);
> +    g_free(val);
> +}
> +
> +static void spapr_cap_set_tristate(Object *obj, Visitor *v, const char *=
name,
> +                                   void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    char *val;
> +    Error *local_err =3D NULL;
> +    uint8_t value;
> +
> +    visit_type_str(v, name, &val, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (!strcasecmp(val, "broken")) {
> +        value =3D SPAPR_CAP_BROKEN;
> +    } else if (!strcasecmp(val, "workaround")) {
> +        value =3D SPAPR_CAP_WORKAROUND;
> +    } else if (!strcasecmp(val, "fixed")) {
> +        value =3D SPAPR_CAP_FIXED;
> +    } else {
> +        error_setg(errp, "Invalid capability mode \"%s\" for cap-%s", va=
l,
> +                   cap->name);
> +        goto out;
> +    }
> +
> +    spapr->cmd_line_caps.caps[cap->index] =3D value | SPAPR_CAP_CMD_LINE;
> +out:
> +    g_free(val);
> +}
> +
>  static void cap_htm_allow(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
>  {
>      if (!val) {
> @@ -122,6 +180,31 @@ static void cap_dfp_allow(sPAPRMachineState *spapr, =
uint8_t val, Error **errp)
>      }
>  }
> =20
> +static void cap_safe_cache_allow(sPAPRMachineState *spapr, uint8_t val,
> +                                 Error **errp)
> +{
> +    if (kvm_enabled() && (val > kvmppc_get_cap_safe_cache())) {
> +        error_setg(errp, "Requested safe cache capability level not supp=
orted by kvm, try a different value for cap-cfpc");
> +    }

Maybe throw in a FIXME comment for TCG.  Given the bugs can be
triggered via Javascript, there's a good chance they can be triggered
via TCG as well - but obviously we don't want to delay the KVM fixes
to work out what the TCG situation is.

> +}
> +
> +static void cap_safe_bounds_check_allow(sPAPRMachineState *spapr, uint8_=
t val,
> +                                        Error **errp)
> +{
> +    if (kvm_enabled() && (val > kvmppc_get_cap_safe_bounds_check())) {
> +        error_setg(errp, "Requested safe bounds check capability level n=
ot supported by kvm, try a different value for cap-sbbc");
> +    }
> +}
> +
> +static void cap_safe_indirect_branch_allow(sPAPRMachineState *spapr,
> +                                           uint8_t val, Error **errp)
> +{
> +    if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_branch())) {
> +        error_setg(errp, "Requested safe indirect branch capability leve=
l not supported by kvm, try a different value for cap-ibs");
> +    }
> +}
> +
> +#define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
> =20
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
> @@ -154,6 +237,36 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .allow =3D cap_dfp_allow,
>      },
> +    [SPAPR_CAP_CFPC] =3D {
> +        .name =3D "cfpc",
> +        .description =3D "Cache Flush on Privilege Change",
> +        .options =3D VALUE_DESC_TRISTATE,
> +        .index =3D SPAPR_CAP_CFPC,
> +        .get =3D spapr_cap_get_tristate,
> +        .set =3D spapr_cap_set_tristate,
> +        .type =3D "string",
> +        .allow =3D cap_safe_cache_allow,
> +    },
> +    [SPAPR_CAP_SBBC] =3D {
> +        .name =3D "sbbc",
> +        .description =3D "Speculation Barrier Bounds Checking",
> +        .options =3D VALUE_DESC_TRISTATE,
> +        .index =3D SPAPR_CAP_SBBC,
> +        .get =3D spapr_cap_get_tristate,
> +        .set =3D spapr_cap_set_tristate,
> +        .type =3D "string",
> +        .allow =3D cap_safe_bounds_check_allow,
> +    },
> +    [SPAPR_CAP_IBS] =3D {
> +        .name =3D "ibs",
> +        .description =3D "Indirect Branch Serialisation",
> +        .options =3D VALUE_DESC_TRISTATE,
> +        .index =3D SPAPR_CAP_IBS,
> +        .get =3D spapr_cap_get_tristate,
> +        .set =3D spapr_cap_set_tristate,
> +        .type =3D "string",
> +        .allow =3D cap_safe_indirect_branch_allow,
> +    },
>  };
> =20
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -326,6 +439,117 @@ const VMStateDescription vmstate_spapr_cap_dfp =3D {
>      },
>  };
> =20
> +static bool spapr_cap_safe_cache_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_CFPC] & SPAPR_CAP_CMD_=
LINE);
> +}
> +
> +static int spapr_cap_safe_cache_pre_save(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_CFPC] =3D
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_CFPC];
> +    return 0;
> +}
> +
> +static int spapr_cap_safe_cache_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_CFPC] =3D 0;
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_cfpc =3D {
> +    .name =3D "spapr/cap_cfpc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cap_safe_cache_needed,
> +    .pre_save =3D spapr_cap_safe_cache_pre_save,
> +    .pre_load =3D spapr_cap_safe_cache_pre_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_CFPC], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool spapr_cap_safe_bounds_check_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_SBBC] & SPAPR_CAP_CMD_=
LINE);
> +}
> +
> +static int spapr_cap_safe_bounds_check_pre_save(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_SBBC] =3D
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_SBBC];
> +    return 0;
> +}
> +
> +static int spapr_cap_safe_bounds_check_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_SBBC] =3D 0;
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_sbbc =3D {
> +    .name =3D "spapr/cap_sbbc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cap_safe_bounds_check_needed,
> +    .pre_save =3D spapr_cap_safe_bounds_check_pre_save,
> +    .pre_load =3D spapr_cap_safe_bounds_check_pre_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_SBBC], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool spapr_cap_safe_indirect_branch_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_IBS] & SPAPR_CAP_CMD_L=
INE);
> +}
> +
> +static int spapr_cap_safe_indirect_branch_pre_save(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_IBS] =3D
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_IBS];
> +    return 0;
> +}
> +
> +static int spapr_cap_safe_indirect_branch_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_IBS] =3D 0;
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_ibs =3D {
> +    .name =3D "spapr/cap_ibs",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cap_safe_indirect_branch_needed,
> +    .pre_save =3D spapr_cap_safe_indirect_branch_pre_save,
> +    .pre_load =3D spapr_cap_safe_indirect_branch_pre_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_IBS], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {
>      sPAPRCapabilities caps;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2804fbbf12..2db2f3e2e2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -62,8 +62,14 @@ typedef enum {
>  #define SPAPR_CAP_VSX                   0x01
>  /* Decimal Floating Point */
>  #define SPAPR_CAP_DFP                   0x02
> +/* Cache Flush on Privilege Change */
> +#define SPAPR_CAP_CFPC                  0x03
> +/* Speculation Barrier Bounds Checking */
> +#define SPAPR_CAP_SBBC                  0x04
> +/* Indirect Branch Serialisation */
> +#define SPAPR_CAP_IBS                   0x05
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_DFP + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
> =20
>  /*
>   * Capability Values
> @@ -73,6 +79,10 @@ typedef enum {
>  /* Bool Caps */
>  #define SPAPR_CAP_OFF                   0x00
>  #define SPAPR_CAP_ON                    0x01
> +/* Broken | Workaround | Fixed Caps */
> +#define SPAPR_CAP_BROKEN                0x00
> +#define SPAPR_CAP_WORKAROUND            0x01
> +#define SPAPR_CAP_FIXED                 0x02
> =20
>  typedef struct sPAPRCapabilities sPAPRCapabilities;
>  struct sPAPRCapabilities {
> @@ -763,6 +773,9 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq=
);
>  extern const VMStateDescription vmstate_spapr_cap_htm;
>  extern const VMStateDescription vmstate_spapr_cap_vsx;
>  extern const VMStateDescription vmstate_spapr_cap_dfp;
> +extern const VMStateDescription vmstate_spapr_cap_cfpc;
> +extern const VMStateDescription vmstate_spapr_cap_sbbc;
> +extern const VMStateDescription vmstate_spapr_cap_ibs;
> =20
>  static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index ce6c2f11f4..0abe0a0abb 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -932,6 +932,9 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_SYNIC2 148
>  #define KVM_CAP_HYPERV_VP_INDEX 149
>  #define KVM_CAP_S390_AIS_MIGRATION 150
> +#define KVM_CAP_PPC_SAFE_CACHE 151
> +#define KVM_CAP_PPC_SAFE_BOUNDS_CHECK 152
> +#define KVM_CAP_PPC_SAFE_INDIRECT_BRANCH 153
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 518dd06e98..818499237c 100644
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
> @@ -147,6 +150,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
> +    cap_ppc_safe_cache =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SAFE_CA=
CHE);
> +    cap_ppc_safe_cache =3D cap_ppc_safe_cache > 0 ? cap_ppc_safe_cache :=
 0;
> +    cap_ppc_safe_bounds_check =3D kvm_vm_check_extension(s,
> +                                KVM_CAP_PPC_SAFE_BOUNDS_CHECK);
> +    cap_ppc_safe_bounds_check =3D cap_ppc_safe_bounds_check > 0 ?
> +                                cap_ppc_safe_bounds_check : 0;
> +    cap_ppc_safe_indirect_branch =3D kvm_vm_check_extension(s,
> +                                   KVM_CAP_PPC_SAFE_INDIRECT_BRANCH);
> +    cap_ppc_safe_indirect_branch =3D cap_ppc_safe_indirect_branch > 0 ?
> +                                   cap_ppc_safe_indirect_branch : 0;
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2456,6 +2469,21 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
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

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpVnIAACgkQbDjKyiDZ
s5LXdw//d6IzrVul1oil+cWxrQRgyxjJb+MtJXKgl9d+Z3HE1PsVjk8mcQgjv06K
RYC/qKhFQrnU5Tmw+smzesVWc0LV8Gyt69ZG08YU2vqq7FW4jIqFvsQ+0Yo4DVSm
jj7tGUKhw5jmoZGMxmsylX2BsMi8awKlpwh7a2cd4LkGdNCORk63dlkpJZC1b1ZW
AyXikqR/e5CNcIE1AtJtx8zGcnoNBLIEKjUQJ599YXAFzpSAB6xBXFhBA+uj3prK
PuaxeRH2/DljB65Xd/IQdHLGf0EJJXZ8joAwvYAkep8wnzcJ+6ESHYd+BIcHuQ4V
iHHw+4iIgprrcDI2rYT3fzi+wKmftDZOKNkzuH2wIyyQTeRLMUbdYK0/7dbnLKKP
xV1UT66kwR0GmzGCKtgyciWQOJKesHGDgW0xPRXSQlrX8sNIx61yWV7WsDBRyG4f
V/Tt/B+2PvwYqKKBWTFc684Ryrsqtz+L1EZGoGGh1pKkiwhiqmSS4JkGLLwBiu1L
/iUC/Or5/79MVcu1rR07j9CJa85dzFTS6Mk1dGEylWRPdexu0Nzs2eLP+N5KzVN8
JhoOQQTEZaoEBOqZHqp6A2Q5AmmzTDHfQyCmux/bhF5mHuLkRXC73s87F/wFH7A/
dHpi7lGVXXvz8WaqbPTjTJ0QkE2dr1jr9hhNnFEnlPKIH9k+7rg=
=8QH9
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
