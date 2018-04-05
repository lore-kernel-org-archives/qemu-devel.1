Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f43h9-0003Jg-DI
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f43h5-0006er-BV
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:08:47 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:36227)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f43h5-0006ZB-2W
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:08:43 -0400
Received: from player158.ha.ovh.net (unknown [10.109.120.90])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5F629122622
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 14:08:34 +0200 (CEST)
Date: Thu, 5 Apr 2018 14:06:19 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180405140619.5f6112b9@bahia.lan>
In-Reply-To: <20180405021437.16761-10-david@gibson.dropbear.id.au>
References: <20180405021437.16761-1-david@gibson.dropbear.id.au>
	<20180405021437.16761-10-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13 09/13] target/ppc: Move 1T segment
 and AMR options to PPCHash64Options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com

On Thu,  5 Apr 2018 12:14:33 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently env->mmu_model is a bit of an unholy mess of an enum of distinct
> MMU types, with various flag bits as well.  This makes which bits of the
> field should be compared pretty confusing.
>=20
> Make a start on cleaning that up by moving two of the flags bits -
> POWERPC_MMU_1TSEG and POWERPC_MMU_AMR - which are specific to the 64-bit
> hash MMU into a new flags field in PPCHash64Options structure.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---

While investigating a migration failure from an older QEMU, I realized
this patch has a problem. The *cpu->hash64_opts structure is zeroed in
kvm_fixup_page_sizes(), which has now the unwanted effect of clearing
the cpu->hash64_opts->flags as well.

We only need to zero the segment page sizes actually. The following
fixes migration:

@@ -442,7 +442,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     }
=20
     /* Convert to QEMU form */
-    memset(cpu->hash64_opts, 0, sizeof(*cpu->hash64_opts));
+    memset(&cpu->hash64_opts->sps, 0, sizeof(cpu->hash64_opts->sps));
=20
     /* If we have HV KVM, we need to forbid CI large pages if our
      * host page size is smaller than 64K.

>  hw/ppc/pnv.c            |  3 ++-
>  hw/ppc/spapr.c          |  2 +-
>  target/ppc/cpu-qom.h    | 11 +++--------
>  target/ppc/kvm.c        |  4 ++--
>  target/ppc/mmu-hash64.c |  6 ++++--
>  target/ppc/mmu-hash64.h |  8 ++++++++
>  6 files changed, 20 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 5a79b24828..5905be3f71 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -36,6 +36,7 @@
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
>  #include "hw/ipmi/ipmi.h"
> +#include "target/ppc/mmu-hash64.h"
> =20
>  #include "hw/ppc/xics.h"
>  #include "hw/ppc/pnv_xscom.h"
> @@ -187,7 +188,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, v=
oid *fdt)
>          _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
>      }
> =20
> -    if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
>                             segs, sizeof(segs))));
>      }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 14c31f82fa..f86cb09080 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -557,7 +557,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>          _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
>      }
> =20
> -    if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
>                            segs, sizeof(segs))));
>      }
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 3e5ef7375f..2bd58b2a84 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -68,22 +68,17 @@ enum powerpc_mmu_t {
>      /* PowerPC 601 MMU model (specific BATs format)            */
>      POWERPC_MMU_601        =3D 0x0000000A,
>  #define POWERPC_MMU_64       0x00010000
> -#define POWERPC_MMU_1TSEG    0x00020000
> -#define POWERPC_MMU_AMR      0x00040000
>  #define POWERPC_MMU_V3       0x00100000 /* ISA V3.00 MMU Support */
>      /* 64 bits PowerPC MMU                                     */
>      POWERPC_MMU_64B        =3D POWERPC_MMU_64 | 0x00000001,
>      /* Architecture 2.03 and later (has LPCR) */
>      POWERPC_MMU_2_03       =3D POWERPC_MMU_64 | 0x00000002,
>      /* Architecture 2.06 variant                               */
> -    POWERPC_MMU_2_06       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_AMR | 0x00000003,
> +    POWERPC_MMU_2_06       =3D POWERPC_MMU_64 | 0x00000003,
>      /* Architecture 2.07 variant                               */
> -    POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_AMR | 0x00000004,
> +    POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | 0x00000004,
>      /* Architecture 3.00 variant                               */
> -    POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_AMR | POWERPC_MMU_V3
> +    POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_V3
>                               | 0x00000005,
>  };
>  #define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index bc6d0a8314..22487cef06 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -302,7 +302,7 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
u,
>          /* HV KVM has backing store size restrictions */
>          info->flags =3D KVM_PPC_PAGE_SIZES_REAL;
> =20
> -        if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +        if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
>              info->flags |=3D KVM_PPC_1T_SEGMENTS;
>          }
> =20
> @@ -482,7 +482,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      }
>      env->slb_nr =3D smmu_info.slb_size;
>      if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> -        env->mmu_model &=3D ~POWERPC_MMU_1TSEG;
> +        cpu->hash64_opts->flags &=3D ~PPC_HASH64_1TSEG;
>      }
>  }
> =20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 2809c31170..c9ee55e1ea 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -160,7 +160,7 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
>      if (vsid & (SLB_VSID_B & ~SLB_VSID_B_1T)) {
>          return -1; /* Bad segment size */
>      }
> -    if ((vsid & SLB_VSID_B) && !(env->mmu_model & POWERPC_MMU_1TSEG)) {
> +    if ((vsid & SLB_VSID_B) && !(ppc_hash64_has(cpu, PPC_HASH64_1TSEG)))=
 {
>          return -1; /* 1T segment on MMU that doesn't support it */
>      }
> =20
> @@ -369,7 +369,7 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_h=
ash_pte64_t pte)
>      int prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> =20
>      /* Only recent MMUs implement Virtual Page Class Key Protection */
> -    if (!(env->mmu_model & POWERPC_MMU_AMR)) {
> +    if (!ppc_hash64_has(cpu, PPC_HASH64_AMR)) {
>          return prot;
>      }
> =20
> @@ -1114,6 +1114,7 @@ void ppc_hash64_finalize(PowerPCCPU *cpu)
>  }
> =20
>  const PPCHash64Options ppc_hash64_opts_basic =3D {
> +    .flags =3D 0,
>      .sps =3D {
>          { .page_shift =3D 12, /* 4K */
>            .slb_enc =3D 0,
> @@ -1127,6 +1128,7 @@ const PPCHash64Options ppc_hash64_opts_basic =3D {
>  };
> =20
>  const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
> +    .flags =3D PPC_HASH64_1TSEG | PPC_HASH64_AMR,
>      .sps =3D {
>          {
>              .page_shift =3D 12, /* 4K */
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 341c1524c2..b2b5d25238 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -153,12 +153,20 @@ struct PPCHash64SegmentPageSizes {
>  };
> =20
>  struct PPCHash64Options {
> +#define PPC_HASH64_1TSEG        0x00001
> +#define PPC_HASH64_AMR          0x00002
> +    unsigned flags;
>      PPCHash64SegmentPageSizes sps[PPC_PAGE_SIZES_MAX_SZ];
>  };
> =20
>  extern const PPCHash64Options ppc_hash64_opts_basic;
>  extern const PPCHash64Options ppc_hash64_opts_POWER7;
> =20
> +static inline bool ppc_hash64_has(PowerPCCPU *cpu, unsigned feature)
> +{
> +    return !!(cpu->hash64_opts->flags & feature);
> +}
> +
>  #endif /* CONFIG_USER_ONLY */
> =20
>  #if defined(CONFIG_USER_ONLY) || !defined(TARGET_PPC64)
