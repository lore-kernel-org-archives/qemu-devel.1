Received: from eggs.gnu.org ([2001:4830:134:3::10]:40515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15hy-0001Xe-2V
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15ht-00053N-64
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:41:22 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:49541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f15hs-000514-SR
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:41:17 -0400
Received: from player688.ha.ovh.net (unknown [10.109.105.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 74A79BC09
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:41:15 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-11-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f428d9fd-57c2-e302-e0fe-f2fb29e8666b@kaod.org>
Date: Wed, 28 Mar 2018 09:41:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-11-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 10/12] target/ppc: Fold
 ci_large_pages flag into PPCHash64Options
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
> The ci_large_pages boolean in CPUPPCState is only relevant to 64-bit ha=
sh
> MMU machines, indicating whether it's possible to map large (> 4kiB) pa=
ges
> as cache-inhibitied (i.e. for IO, rather than memory).  Fold it as anot=
her
> flag into the PPCHash64Options structure.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr.c              | 3 +--
>  target/ppc/cpu.h            | 1 -
>  target/ppc/kvm.c            | 6 +++++-
>  target/ppc/mmu-hash64.c     | 2 +-
>  target/ppc/mmu-hash64.h     | 1 +
>  target/ppc/translate_init.c | 3 ---
>  6 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 436ed39f7f..95063df54d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -263,7 +263,6 @@ static void spapr_populate_pa_features(sPAPRMachine=
State *spapr,
>                                         void *fdt, int offset,
>                                         bool legacy_guest)
>  {
> -    CPUPPCState *env =3D &cpu->env;
>      uint8_t pa_features_206[] =3D { 6, 0,
>          0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
>      uint8_t pa_features_207[] =3D { 24, 0,
> @@ -315,7 +314,7 @@ static void spapr_populate_pa_features(sPAPRMachine=
State *spapr,
>          return;
>      }
> =20
> -    if (env->ci_large_pages) {
> +    if (cpu->hash64_opts->flags & PPC_HASH64_CI_LARGEPAGE) {
>          /*
>           * Note: we keep CI large pages off by default because a 64K c=
apable
>           * guest provisioned with large pages might otherwise try to m=
ap a qemu
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index fb6c578eb5..76ce67e9de 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1088,7 +1088,6 @@ struct CPUPPCState {
>  #if defined(TARGET_PPC64)
>      ppc_slb_t vrma_slb;
>      target_ulong rmls;
> -    bool ci_large_pages;
>  #endif
> =20
>  #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 3424917381..6c45815ee6 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -448,7 +448,11 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>       * host page size is smaller than 64K.
>       */
>      if (smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL) {
> -        env->ci_large_pages =3D getpagesize() >=3D 0x10000;
> +        if (getpagesize() >=3D 0x10000) {
> +            cpu->hash64_opts->flags |=3D PPC_HASH64_CI_LARGEPAGE;
> +        } else {
> +            cpu->hash64_opts->flags &=3D ~PPC_HASH64_CI_LARGEPAGE;
> +        }
>      }
> =20
>      /*
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 1d785f50d7..3b00bdee91 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1128,7 +1128,7 @@ const PPCHash64Options ppc_hash64_opts_basic =3D =
{
>  };
> =20
>  const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
> -    .flags =3D PPC_HASH64_1TSEG | PPC_HASH64_AMR,
> +    .flags =3D PPC_HASH64_1TSEG | PPC_HASH64_AMR | PPC_HASH64_CI_LARGE=
PAGE,
>      .sps =3D {
>          {
>              .page_shift =3D 12, /* 4K */
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 6cfca97a60..cddfe06a8b 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -154,6 +154,7 @@ struct ppc_one_seg_page_size {
>  struct PPCHash64Options {
>  #define PPC_HASH64_1TSEG        0x00001
>  #define PPC_HASH64_AMR          0x00002
> +#define PPC_HASH64_CI_LARGEPAGE 0x00004
>      unsigned flags;
>      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
>  };
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index ae005b2a54..a925cf5cd3 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8392,7 +8392,6 @@ static void init_proc_POWER7(CPUPPCState *env)
>  #if !defined(CONFIG_USER_ONLY)
>      env->slb_nr =3D 32;
>  #endif
> -    env->ci_large_pages =3D true;
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;
> =20
> @@ -8547,7 +8546,6 @@ static void init_proc_POWER8(CPUPPCState *env)
>  #if !defined(CONFIG_USER_ONLY)
>      env->slb_nr =3D 32;
>  #endif
> -    env->ci_large_pages =3D true;
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;
> =20
> @@ -8748,7 +8746,6 @@ static void init_proc_POWER9(CPUPPCState *env)
>  #if !defined(CONFIG_USER_ONLY)
>      env->slb_nr =3D 32;
>  #endif
> -    env->ci_large_pages =3D true;
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;
> =20
>=20
