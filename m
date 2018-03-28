Received: from eggs.gnu.org ([2001:4830:134:3::10]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15Vz-0004lP-GB
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15Vw-0007Q8-9Y
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:28:59 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:34104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f15Vv-0007Pp-Ur
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:28:56 -0400
Received: from player688.ha.ovh.net (unknown [10.109.120.125])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5E894AC8BA
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:28:54 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <167be985-82e0-fcbf-f5a7-406f1ee92353@kaod.org>
Date: Wed, 28 Mar 2018 09:28:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 07/12] target/ppc: Split page size
 information into a separate allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, groug@kaod.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com

On 03/27/2018 06:37 AM, David Gibson wrote:
> env->sps contains page size encoding information as an embedded structu=
re.
> Since this information is specific to 64-bit hash MMUs, split it out in=
to
> a separately allocated structure, to reduce the basic env size for othe=
r
> cpus.  Along the way we make a few other cleanups:
>=20
>     * Rename to PPCHash64Options which is more in line with qemu name
>       conventions, and reflects that we're going to merge some more has=
h64
>       mmu specific details in there in future
>=20
>     * Move structure definitions to the mmu-hash64.[ch] files.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

While you are at changing things, maybe you could CamelCase=20

	struct ppc_one_seg_page_size
	struct ppc_one_page_size

No big deal.

Thanks,

C.

> ---
>  hw/ppc/fdt.c                |  4 ++--
>  target/ppc/cpu-qom.h        |  4 ++--
>  target/ppc/cpu.h            | 22 +--------------------
>  target/ppc/kvm.c            |  4 ++--
>  target/ppc/mmu-hash64.c     | 47 ++++++++++++++++++++++++++++++++++++-=
--------
>  target/ppc/mmu-hash64.h     | 21 ++++++++++++++++++++
>  target/ppc/translate_init.c | 36 +++-------------------------------
>  7 files changed, 69 insertions(+), 69 deletions(-)
>=20
> diff --git a/hw/ppc/fdt.c b/hw/ppc/fdt.c
> index 2721603ffa..c4ba16f6b4 100644
> --- a/hw/ppc/fdt.c
> +++ b/hw/ppc/fdt.c
> @@ -9,6 +9,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "target/ppc/cpu.h"
> +#include "target/ppc/mmu-hash64.h"
> =20
>  #include "hw/ppc/fdt.h"
> =20
> @@ -16,13 +17,12 @@
>  size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
>                                    size_t maxsize)
>  {
> -    CPUPPCState *env =3D &cpu->env;
>      size_t maxcells =3D maxsize / sizeof(uint32_t);
>      int i, j, count;
>      uint32_t *p =3D prop;
> =20
>      for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> -        struct ppc_one_seg_page_size *sps =3D &env->sps.sps[i];
> +        struct ppc_one_seg_page_size *sps =3D &cpu->hash64_opts->sps[i=
];
> =20
>          if (!sps->page_shift) {
>              break;
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 9bbb05cf62..3e5ef7375f 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -160,7 +160,7 @@ enum powerpc_input_t {
>      PPC_FLAGS_INPUT_RCPU,
>  };
> =20
> -struct ppc_segment_page_sizes;
> +typedef struct PPCHash64Options PPCHash64Options;
> =20
>  /**
>   * PowerPCCPUClass:
> @@ -194,7 +194,7 @@ typedef struct PowerPCCPUClass {
>      uint32_t flags;
>      int bfd_mach;
>      uint32_t l1_dcache_size, l1_icache_size;
> -    const struct ppc_segment_page_sizes *sps;
> +    const PPCHash64Options *hash64_opts;
>      struct ppc_radix_page_info *radix_page_info;
>      void (*init_proc)(CPUPPCState *env);
>      int  (*check_pow)(CPUPPCState *env);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c621a6bd5e..fb6c578eb5 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -948,28 +948,8 @@ enum {
> =20
>  #define DBELL_PROCIDTAG_MASK           PPC_BITMASK(44, 63)
> =20
> -/*********************************************************************=
********/
> -/* Segment page size information, used by recent hash MMUs
> - * The format of this structure mirrors kvm_ppc_smmu_info
> - */
> -
>  #define PPC_PAGE_SIZES_MAX_SZ   8
> =20
> -struct ppc_one_page_size {
> -    uint32_t page_shift;  /* Page shift (or 0) */
> -    uint32_t pte_enc;     /* Encoding in the HPTE (>>12) */
> -};
> -
> -struct ppc_one_seg_page_size {
> -    uint32_t page_shift;  /* Base page shift of segment (or 0) */
> -    uint32_t slb_enc;     /* SLB encoding for BookS */
> -    struct ppc_one_page_size enc[PPC_PAGE_SIZES_MAX_SZ];
> -};
> -
> -struct ppc_segment_page_sizes {
> -    struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
> -};
> -
>  struct ppc_radix_page_info {
>      uint32_t count;
>      uint32_t entries[PPC_PAGE_SIZES_MAX_SZ];
> @@ -1106,7 +1086,6 @@ struct CPUPPCState {
>      uint64_t insns_flags;
>      uint64_t insns_flags2;
>  #if defined(TARGET_PPC64)
> -    struct ppc_segment_page_sizes sps;
>      ppc_slb_t vrma_slb;
>      target_ulong rmls;
>      bool ci_large_pages;
> @@ -1227,6 +1206,7 @@ struct PowerPCCPU {
>      PPCVirtualHypervisor *vhyp;
>      Object *intc;
>      int32_t node_id; /* NUMA node this CPU belongs to */
> +    PPCHash64Options *hash64_opts;
> =20
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 6160356a4a..01947169c9 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -442,7 +442,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      }
> =20
>      /* Convert to QEMU form */
> -    memset(&env->sps, 0, sizeof(env->sps));
> +    memset(cpu->hash64_opts, 0, sizeof(*cpu->hash64_opts));
> =20
>      /* If we have HV KVM, we need to forbid CI large pages if our
>       * host page size is smaller than 64K.
> @@ -456,7 +456,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>       *     the selected CPU has with the capabilities that KVM support=
s.
>       */
>      for (ik =3D iq =3D 0; ik < KVM_PPC_PAGE_SIZES_MAX_SZ; ik++) {
> -        struct ppc_one_seg_page_size *qsps =3D &env->sps.sps[iq];
> +        struct ppc_one_seg_page_size *qsps =3D &cpu->hash64_opts->sps[=
iq];
>          struct kvm_ppc_one_seg_page_size *ksps =3D &smmu_info.sps[ik];
> =20
>          if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_size,
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 4cb7d1cf07..d7a0e5615f 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -165,7 +165,7 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slo=
t,
>      }
> =20
>      for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> -        const struct ppc_one_seg_page_size *sps1 =3D &env->sps.sps[i];
> +        const struct ppc_one_seg_page_size *sps1 =3D &cpu->hash64_opts=
->sps[i];
> =20
>          if (!sps1->page_shift) {
>              break;
> @@ -552,7 +552,7 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *cp=
u,
>      /* If ISL is set in LPCR we need to clamp the page size to 4K */
>      if (env->spr[SPR_LPCR] & LPCR_ISL) {
>          /* We assume that when using TCG, 4k is first entry of SPS */
> -        sps =3D &env->sps.sps[0];
> +        sps =3D &cpu->hash64_opts->sps[0];
>          assert(sps->page_shift =3D=3D 12);
>      }
> =20
> @@ -605,7 +605,6 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *cp=
u,
>  unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
>                                            uint64_t pte0, uint64_t pte1=
)
>  {
> -    CPUPPCState *env =3D &cpu->env;
>      int i;
> =20
>      if (!(pte0 & HPTE64_V_LARGE)) {
> @@ -617,7 +616,7 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCP=
U *cpu,
>       * this gives an unambiguous result.
>       */
>      for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> -        const struct ppc_one_seg_page_size *sps =3D &env->sps.sps[i];
> +        const struct ppc_one_seg_page_size *sps =3D &cpu->hash64_opts-=
>sps[i];
>          unsigned shift;
> =20
>          if (!sps->page_shift) {
> @@ -1005,7 +1004,7 @@ void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>      esid =3D SLB_ESID_V;
> =20
>      for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> -        const struct ppc_one_seg_page_size *sps1 =3D &env->sps.sps[i];
> +        const struct ppc_one_seg_page_size *sps1 =3D &cpu->hash64_opts=
->sps[i];
> =20
>          if (!sps1->page_shift) {
>              break;
> @@ -1101,11 +1100,12 @@ void ppc_hash64_init(PowerPCCPU *cpu)
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
> -    if (pcc->sps) {
> -        env->sps =3D *pcc->sps;
> +    if (pcc->hash64_opts) {
> +        cpu->hash64_opts =3D g_memdup(pcc->hash64_opts,
> +                                    sizeof(*cpu->hash64_opts));
>      } else if (env->mmu_model & POWERPC_MMU_64) {
>          /* Use default sets of page sizes. We don't support MPSS */
> -        static const struct ppc_segment_page_sizes defsps =3D {
> +        static const PPCHash64Options defopts =3D {
>              .sps =3D {
>                  { .page_shift =3D 12, /* 4K */
>                    .slb_enc =3D 0,
> @@ -1117,10 +1117,39 @@ void ppc_hash64_init(PowerPCCPU *cpu)
>                  },
>              },
>          };
> -        env->sps =3D defsps;
> +        cpu->hash64_opts =3D g_memdup(&defopts, sizeof(*cpu->hash64_op=
ts));
>      }
>  }
> =20
>  void ppc_hash64_finalize(PowerPCCPU *cpu)
>  {
> +    g_free(cpu->hash64_opts);
>  }
> +
> +const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
> +    .sps =3D {
> +        {
> +            .page_shift =3D 12, /* 4K */
> +            .slb_enc =3D 0,
> +            .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 },
> +                     { .page_shift =3D 16, .pte_enc =3D 0x7 },
> +                     { .page_shift =3D 24, .pte_enc =3D 0x38 }, },
> +        },
> +        {
> +            .page_shift =3D 16, /* 64K */
> +            .slb_enc =3D SLB_VSID_64K,
> +            .enc =3D { { .page_shift =3D 16, .pte_enc =3D 0x1 },
> +                     { .page_shift =3D 24, .pte_enc =3D 0x8 }, },
> +        },
> +        {
> +            .page_shift =3D 24, /* 16M */
> +            .slb_enc =3D SLB_VSID_16M,
> +            .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 }, },
> +        },
> +        {
> +            .page_shift =3D 34, /* 16G */
> +            .slb_enc =3D SLB_VSID_16G,
> +            .enc =3D { { .page_shift =3D 34, .pte_enc =3D 0x3 }, },
> +        },
> +    }
> +};
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 074ded4c27..d42cbc2762 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -136,6 +136,27 @@ static inline uint64_t ppc_hash64_hpte1(PowerPCCPU=
 *cpu,
>      return ldq_p(&(hptes[i].pte1));
>  }
> =20
> +/*
> + * MMU Options
> + */
> +
> +struct ppc_one_page_size {
> +    uint32_t page_shift;  /* Page shift (or 0) */
> +    uint32_t pte_enc;     /* Encoding in the HPTE (>>12) */
> +};
> +
> +struct ppc_one_seg_page_size {
> +    uint32_t page_shift;  /* Base page shift of segment (or 0) */
> +    uint32_t slb_enc;     /* SLB encoding for BookS */
> +    struct ppc_one_page_size enc[PPC_PAGE_SIZES_MAX_SZ];
> +};
> +
> +struct PPCHash64Options {
> +    struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
> +};
> +
> +extern const PPCHash64Options ppc_hash64_opts_POWER7;
> +
>  #endif /* CONFIG_USER_ONLY */
> =20
>  #if defined(CONFIG_USER_ONLY) || !defined(TARGET_PPC64)
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index aa63a5dcb3..040d6fbac3 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8368,36 +8368,6 @@ static Property powerpc_servercpu_properties[] =3D=
 {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> -#ifdef CONFIG_SOFTMMU
> -static const struct ppc_segment_page_sizes POWER7_POWER8_sps =3D {
> -    .sps =3D {
> -        {
> -            .page_shift =3D 12, /* 4K */
> -            .slb_enc =3D 0,
> -            .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 },
> -                     { .page_shift =3D 16, .pte_enc =3D 0x7 },
> -                     { .page_shift =3D 24, .pte_enc =3D 0x38 }, },
> -        },
> -        {
> -            .page_shift =3D 16, /* 64K */
> -            .slb_enc =3D SLB_VSID_64K,
> -            .enc =3D { { .page_shift =3D 16, .pte_enc =3D 0x1 },
> -                     { .page_shift =3D 24, .pte_enc =3D 0x8 }, },
> -        },
> -        {
> -            .page_shift =3D 24, /* 16M */
> -            .slb_enc =3D SLB_VSID_16M,
> -            .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 }, },
> -        },
> -        {
> -            .page_shift =3D 34, /* 16G */
> -            .slb_enc =3D SLB_VSID_16G,
> -            .enc =3D { { .page_shift =3D 34, .pte_enc =3D 0x3 }, },
> -        },
> -    }
> -};
> -#endif /* CONFIG_SOFTMMU */
> -
>  static void init_proc_POWER7(CPUPPCState *env)
>  {
>      /* Common Registers */
> @@ -8526,7 +8496,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *dat=
a)
>      pcc->mmu_model =3D POWERPC_MMU_2_06;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> -    pcc->sps =3D &POWER7_POWER8_sps;
> +    pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
>  #endif
>      pcc->excp_model =3D POWERPC_EXCP_POWER7;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
> @@ -8698,7 +8668,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *dat=
a)
>      pcc->mmu_model =3D POWERPC_MMU_2_07;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> -    pcc->sps =3D &POWER7_POWER8_sps;
> +    pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
>  #endif
>      pcc->excp_model =3D POWERPC_EXCP_POWER8;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
> @@ -8893,7 +8863,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *dat=
a)
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc64_v3_handle_mmu_fault;
>      /* segment page size remain the same */
> -    pcc->sps =3D &POWER7_POWER8_sps;
> +    pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
>      pcc->radix_page_info =3D &POWER9_radix_page_info;
>  #endif
>      pcc->excp_model =3D POWERPC_EXCP_POWER8;
>=20
