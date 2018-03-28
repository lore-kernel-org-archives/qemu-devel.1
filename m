Received: from eggs.gnu.org ([2001:4830:134:3::10]:40308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15h6-00012O-Ob
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15h1-0003pd-Rl
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:40:28 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:46337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f15h1-0003mo-Dv
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:40:23 -0400
Received: from player688.ha.ovh.net (unknown [10.109.105.122])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id B534AB700
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:40:21 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-10-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <67545c30-df9d-e498-cc31-eb30b7c63ba1@kaod.org>
Date: Wed, 28 Mar 2018 09:40:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-10-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 09/12] target/ppc: Move 1T segment
 and AMR options to PPCHash64Options
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
> Currently env->mmu_model is a bit of an unholy mess of an enum of disti=
nct
> MMU types, with various flag bits as well.  This makes which bits of th=
e
> field should be compared pretty confusing.
>=20
> Make a start on cleaning that up by moving two of the flags bits -
> POWERPC_MMU_1TSEG and POWERPC_MMU_AMR - which are specific to the 64-bi=
t
> hash MMU into a new flags field in PPCHash64Options structure.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Maybe introduce a small helper :

	#define ppc_hash64_has(cpu, opt) ((cpu)->hash64_opts->flags & (opt))

Thanks,

C.=20

> ---
>  hw/ppc/pnv.c            |  3 ++-
>  hw/ppc/spapr.c          |  2 +-
>  target/ppc/cpu-qom.h    | 11 +++--------
>  target/ppc/kvm.c        |  4 ++--
>  target/ppc/mmu-hash64.c |  6 ++++--
>  target/ppc/mmu-hash64.h |  3 +++
>  6 files changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 5a79b24828..0aa878b771 100644
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
> @@ -187,7 +188,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
>          _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
>      }
> =20
> -    if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +    if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
>                             segs, sizeof(segs))));
>      }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a35bffd524..436ed39f7f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -557,7 +557,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, voi=
d *fdt, int offset,
>          _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
>      }
> =20
> -    if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +    if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
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
> index 01947169c9..3424917381 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -302,7 +302,7 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *=
cpu,
>          /* HV KVM has backing store size restrictions */
>          info->flags =3D KVM_PPC_PAGE_SIZES_REAL;
> =20
> -        if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +        if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
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
> index d369b1bf86..1d785f50d7 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -160,7 +160,7 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slo=
t,
>      if (vsid & (SLB_VSID_B & ~SLB_VSID_B_1T)) {
>          return -1; /* Bad segment size */
>      }
> -    if ((vsid & SLB_VSID_B) && !(env->mmu_model & POWERPC_MMU_1TSEG)) =
{
> +    if ((vsid & SLB_VSID_B) && !(cpu->hash64_opts->flags & PPC_HASH64_=
1TSEG)) {
>          return -1; /* 1T segment on MMU that doesn't support it */
>      }
> =20
> @@ -369,7 +369,7 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc=
_hash_pte64_t pte)
>      int prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> =20
>      /* Only recent MMUs implement Virtual Page Class Key Protection */
> -    if (!(env->mmu_model & POWERPC_MMU_AMR)) {
> +    if (!(cpu->hash64_opts->flags & PPC_HASH64_AMR)) {
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
> @@ -1127,6 +1128,7 @@ const PPCHash64Options ppc_hash64_opts_basic =3D =
{
>  };
> =20
>  const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
> +    .flags =3D PPC_HASH64_1TSEG | PPC_HASH64_AMR,
>      .sps =3D {
>          {
>              .page_shift =3D 12, /* 4K */
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index ff0c48af55..6cfca97a60 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -152,6 +152,9 @@ struct ppc_one_seg_page_size {
>  };
> =20
>  struct PPCHash64Options {
> +#define PPC_HASH64_1TSEG        0x00001
> +#define PPC_HASH64_AMR          0x00002
> +    unsigned flags;
>      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
>  };
> =20
>=20
