Received: from eggs.gnu.org ([2001:4830:134:3::10]:54068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f0kNW-0000Ln-CD
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f0kNT-0008MU-7w
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:54:50 -0400
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:60099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f0kNS-0008Ls-Tr
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:54:47 -0400
Received: from player762.ha.ovh.net (unknown [10.109.122.16])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 14869964F2
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 10:54:44 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-6-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <64ab3f43-21af-e577-4eff-d0d9cc40af91@kaod.org>
Date: Tue, 27 Mar 2018 10:54:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 05/12] target/ppc: Remove fallback
 64k pagesize information
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
> CPU definitions for cpus with the 64-bit hash MMU can include a table o=
f
> available pagesizes.  If this isn't supplied ppc_cpu_instance_init() wi=
ll
> fill it in a fallback table based on the POWERPC_MMU_64K bit in mmu_mod=
el.
>=20
> However, it turns out all the cpus which support 64K pages already incl=
ude
> an explicit table of page sizes, so there's no point to the fallback ta=
ble
> including 64k pages.
>=20
> That removes the only place which tests POWERPC_MMU_64K, so we can remo=
ve
> it.  Which in turn allows some logic to be removed from
> kvm_fixup_page_sizes().
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  target/ppc/cpu-qom.h        |  4 ----
>  target/ppc/kvm.c            |  7 -------
>  target/ppc/translate_init.c | 20 ++------------------
>  3 files changed, 2 insertions(+), 29 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index deaa46a14b..9bbb05cf62 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -70,7 +70,6 @@ enum powerpc_mmu_t {
>  #define POWERPC_MMU_64       0x00010000
>  #define POWERPC_MMU_1TSEG    0x00020000
>  #define POWERPC_MMU_AMR      0x00040000
> -#define POWERPC_MMU_64K      0x00080000
>  #define POWERPC_MMU_V3       0x00100000 /* ISA V3.00 MMU Support */
>      /* 64 bits PowerPC MMU                                     */
>      POWERPC_MMU_64B        =3D POWERPC_MMU_64 | 0x00000001,
> @@ -78,15 +77,12 @@ enum powerpc_mmu_t {
>      POWERPC_MMU_2_03       =3D POWERPC_MMU_64 | 0x00000002,
>      /* Architecture 2.06 variant                               */
>      POWERPC_MMU_2_06       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_64K
>                               | POWERPC_MMU_AMR | 0x00000003,
>      /* Architecture 2.07 variant                               */
>      POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_64K
>                               | POWERPC_MMU_AMR | 0x00000004,
>      /* Architecture 3.00 variant                               */
>      POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_64K
>                               | POWERPC_MMU_AMR | POWERPC_MMU_V3
>                               | 0x00000005,
>  };
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 79a436a384..6160356a4a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -425,7 +425,6 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      static bool has_smmu_info;
>      CPUPPCState *env =3D &cpu->env;
>      int iq, ik, jq, jk;
> -    bool has_64k_pages =3D false;
> =20
>      /* We only handle page sizes for 64-bit server guests for now */
>      if (!(env->mmu_model & POWERPC_MMU_64)) {
> @@ -471,9 +470,6 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>                                       ksps->enc[jk].page_shift)) {
>                  continue;
>              }
> -            if (ksps->enc[jk].page_shift =3D=3D 16) {
> -                has_64k_pages =3D true;
> -            }
>              qsps->enc[jq].page_shift =3D ksps->enc[jk].page_shift;
>              qsps->enc[jq].pte_enc =3D ksps->enc[jk].pte_enc;
>              if (++jq >=3D PPC_PAGE_SIZES_MAX_SZ) {
> @@ -488,9 +484,6 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
>          env->mmu_model &=3D ~POWERPC_MMU_1TSEG;
>      }
> -    if (!has_64k_pages) {
> -        env->mmu_model &=3D ~POWERPC_MMU_64K;
> -    }
>  }
> =20
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 29bd6f3654..99be6fcd68 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10469,7 +10469,7 @@ static void ppc_cpu_instance_init(Object *obj)
>          env->sps =3D *pcc->sps;
>      } else if (env->mmu_model & POWERPC_MMU_64) {
>          /* Use default sets of page sizes. We don't support MPSS */
> -        static const struct ppc_segment_page_sizes defsps_4k =3D {
> +        static const struct ppc_segment_page_sizes defsps =3D {
>              .sps =3D {
>                  { .page_shift =3D 12, /* 4K */
>                    .slb_enc =3D 0,
> @@ -10481,23 +10481,7 @@ static void ppc_cpu_instance_init(Object *obj)
>                  },
>              },
>          };
> -        static const struct ppc_segment_page_sizes defsps_64k =3D {
> -            .sps =3D {
> -                { .page_shift =3D 12, /* 4K */
> -                  .slb_enc =3D 0,
> -                  .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 } }
> -                },
> -                { .page_shift =3D 16, /* 64K */
> -                  .slb_enc =3D 0x110,
> -                  .enc =3D { { .page_shift =3D 16, .pte_enc =3D 1 } }
> -                },
> -                { .page_shift =3D 24, /* 16M */
> -                  .slb_enc =3D 0x100,
> -                  .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 } }
> -                },
> -            },
> -        };
> -        env->sps =3D (env->mmu_model & POWERPC_MMU_64K) ? defsps_64k :=
 defsps_4k;
> +        env->sps =3D defsps;
>      }
>  #endif /* defined(TARGET_PPC64) */
>  }
>=20
