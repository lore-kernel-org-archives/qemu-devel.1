Received: from eggs.gnu.org ([2001:4830:134:3::10]:38776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15Yz-0005kk-1N
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15Yu-0001RV-SY
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:32:05 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:55892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f15Yu-0001NS-Mb
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:32:00 -0400
Received: from player688.ha.ovh.net (unknown [10.109.105.117])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0E6297607
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:31:57 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-9-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f30ab1d3-cde8-6907-3985-fc755a97d10e@kaod.org>
Date: Wed, 28 Mar 2018 09:31:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-9-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 08/12] target/ppc: Make hash64_opts
 field mandatory for 64-bit hash MMUs
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
> Currently some cpus set the hash64_opts field in the class structure, w=
ith
> specific details of their variant of the 64-bit hash mmu.  For the
> remaining cpus with that mmu, ppc_hash64_realize() fills in defaults.
>=20
> But there are only a couple of cpus that use those fallbacks, so just h=
ave
> them to set the has64_opts field instead, simplifying the logic.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-hash64.c     | 36 ++++++++++++++++++------------------
>  target/ppc/mmu-hash64.h     |  1 +
>  target/ppc/translate_init.c |  2 ++
>  3 files changed, 21 insertions(+), 18 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index d7a0e5615f..d369b1bf86 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1100,25 +1100,12 @@ void ppc_hash64_init(PowerPCCPU *cpu)
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
> -    if (pcc->hash64_opts) {
> -        cpu->hash64_opts =3D g_memdup(pcc->hash64_opts,
> -                                    sizeof(*cpu->hash64_opts));
> -    } else if (env->mmu_model & POWERPC_MMU_64) {
> -        /* Use default sets of page sizes. We don't support MPSS */
> -        static const PPCHash64Options defopts =3D {
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
> -        cpu->hash64_opts =3D g_memdup(&defopts, sizeof(*cpu->hash64_op=
ts));
> +    if (!pcc->hash64_opts) {
> +        assert(!(env->mmu_model & POWERPC_MMU_64));
> +        return;
>      }
> +
> +    cpu->hash64_opts =3D g_memdup(pcc->hash64_opts, sizeof(*cpu->hash6=
4_opts));
>  }
> =20
>  void ppc_hash64_finalize(PowerPCCPU *cpu)
> @@ -1126,6 +1113,19 @@ void ppc_hash64_finalize(PowerPCCPU *cpu)
>      g_free(cpu->hash64_opts);
>  }
> =20
> +const PPCHash64Options ppc_hash64_opts_basic =3D {
> +    .sps =3D {
> +        { .page_shift =3D 12, /* 4K */
> +          .slb_enc =3D 0,
> +          .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 } }
> +        },
> +        { .page_shift =3D 24, /* 16M */
> +          .slb_enc =3D 0x100,
> +          .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 } }
> +        },
> +    },
> +};
> +
>  const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
>      .sps =3D {
>          {
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index d42cbc2762..ff0c48af55 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -155,6 +155,7 @@ struct PPCHash64Options {
>      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
>  };
> =20
> +extern const PPCHash64Options ppc_hash64_opts_basic;
>  extern const PPCHash64Options ppc_hash64_opts_POWER7;
> =20
>  #endif /* CONFIG_USER_ONLY */
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 040d6fbac3..ae005b2a54 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8242,6 +8242,7 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
>      pcc->mmu_model =3D POWERPC_MMU_64B;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> +    pcc->hash64_opts =3D &ppc_hash64_opts_basic;
>  #endif
>      pcc->excp_model =3D POWERPC_EXCP_970;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_970;
> @@ -8319,6 +8320,7 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *da=
ta)
>      pcc->mmu_model =3D POWERPC_MMU_2_03;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> +    pcc->hash64_opts =3D &ppc_hash64_opts_basic;
>  #endif
>      pcc->excp_model =3D POWERPC_EXCP_970;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_970;
>=20
