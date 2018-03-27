Received: from eggs.gnu.org ([2001:4830:134:3::10]:54590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f0kPD-0001b8-O2
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f0kPA-0000pK-KL
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:56:35 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:47682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f0kPA-0000ok-Av
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:56:32 -0400
Received: from player762.ha.ovh.net (unknown [10.109.120.83])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5883914FFD6
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 10:56:29 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-7-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1097f7d5-865c-7b09-0026-e8d06d1211a7@kaod.org>
Date: Tue, 27 Mar 2018 10:56:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-7-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 06/12] target/ppc: Move page size
 setup to helper function
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
> Initialization of the env->sps structure at the end of instance_init is
> specific to the 64-bit hash MMU, so move the code into a helper functio=
n
> in mmu-hash64.c.
>=20
> We also create a corresponding function to be called at finalize time -
> it's empty for now, but we'll need it shortly.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-hash64.c     | 29 +++++++++++++++++++++++++++++
>  target/ppc/mmu-hash64.h     | 11 +++++++++++
>  target/ppc/translate_init.c | 29 +++++++++--------------------
>  3 files changed, 49 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index a87fa7c83f..4cb7d1cf07 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1095,3 +1095,32 @@ void helper_store_lpcr(CPUPPCState *env, target_=
ulong val)
>      ppc_hash64_update_rmls(cpu);
>      ppc_hash64_update_vrma(cpu);
>  }
> +
> +void ppc_hash64_init(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +
> +    if (pcc->sps) {
> +        env->sps =3D *pcc->sps;
> +    } else if (env->mmu_model & POWERPC_MMU_64) {
> +        /* Use default sets of page sizes. We don't support MPSS */
> +        static const struct ppc_segment_page_sizes defsps =3D {
> +            .sps =3D {
> +                { .page_shift =3D 12, /* 4K */
> +                  .slb_enc =3D 0,
> +                  .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 } }
> +                },
> +                { .page_shift =3D 24, /* 16M */
> +                  .slb_enc =3D 0x100,
> +                  .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 } }
> +                },
> +            },
> +        };
> +        env->sps =3D defsps;
> +    }
> +}
> +
> +void ppc_hash64_finalize(PowerPCCPU *cpu)
> +{
> +}
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 95a8c330d6..074ded4c27 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -19,6 +19,8 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU =
*cpu,
>                                            uint64_t pte0, uint64_t pte1=
);
>  void ppc_hash64_update_vrma(PowerPCCPU *cpu);
>  void ppc_hash64_update_rmls(PowerPCCPU *cpu);
> +void ppc_hash64_init(PowerPCCPU *cpu);
> +void ppc_hash64_finalize(PowerPCCPU *cpu);
>  #endif
> =20
>  /*
> @@ -136,4 +138,13 @@ static inline uint64_t ppc_hash64_hpte1(PowerPCCPU=
 *cpu,
> =20
>  #endif /* CONFIG_USER_ONLY */
> =20
> +#if defined(CONFIG_USER_ONLY) || !defined(TARGET_PPC64)
> +static inline void ppc_hash64_init(PowerPCCPU *cpu)
> +{
> +}
> +static inline void ppc_hash64_finalize(PowerPCCPU *cpu)
> +{
> +}
> +#endif
> +
>  #endif /* MMU_HASH64_H */
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 99be6fcd68..aa63a5dcb3 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10464,26 +10464,14 @@ static void ppc_cpu_instance_init(Object *obj=
)
>      env->has_hv_mode =3D !!(env->msr_mask & MSR_HVB);
>  #endif
> =20
> -#if defined(TARGET_PPC64)
> -    if (pcc->sps) {
> -        env->sps =3D *pcc->sps;
> -    } else if (env->mmu_model & POWERPC_MMU_64) {
> -        /* Use default sets of page sizes. We don't support MPSS */
> -        static const struct ppc_segment_page_sizes defsps =3D {
> -            .sps =3D {
> -                { .page_shift =3D 12, /* 4K */
> -                  .slb_enc =3D 0,
> -                  .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 } }
> -                },
> -                { .page_shift =3D 24, /* 16M */
> -                  .slb_enc =3D 0x100,
> -                  .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 } }
> -                },
> -            },
> -        };
> -        env->sps =3D defsps;
> -    }
> -#endif /* defined(TARGET_PPC64) */
> +    ppc_hash64_init(cpu);
> +}
> +
> +static void ppc_cpu_instance_finalize(Object *obj)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(obj);
> +
> +    ppc_hash64_finalize(cpu);
>  }
> =20
>  static bool ppc_pvr_match_default(PowerPCCPUClass *pcc, uint32_t pvr)
> @@ -10601,6 +10589,7 @@ static const TypeInfo ppc_cpu_type_info =3D {
>      .parent =3D TYPE_CPU,
>      .instance_size =3D sizeof(PowerPCCPU),
>      .instance_init =3D ppc_cpu_instance_init,
> +    .instance_finalize =3D ppc_cpu_instance_finalize,
>      .abstract =3D true,
>      .class_size =3D sizeof(PowerPCCPUClass),
>      .class_init =3D ppc_cpu_class_init,
>=20
