Received: from eggs.gnu.org ([2001:4830:134:3::10]:56592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1764-0000iG-Ao
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f175z-0004rE-AD
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:20 -0400
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:38866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f175y-0004qK-Tn
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:15 -0400
Received: from player726.ha.ovh.net (unknown [10.109.122.111])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 57FF0ACA0A
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 11:10:13 +0200 (CEST)
Date: Wed, 28 Mar 2018 11:10:04 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180328111004.7bfd41db@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180327043741.7705-12-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-12-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 11/12] target/ppc: Remove
 unnecessary POWERPC_MMU_V3 flag from mmu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, clg@kaod.org

On Tue, 27 Mar 2018 15:37:40 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The only place we test this flag is in conjunction with
> ppc64_use_proc_tbl().  That checks for the LPCR_UPRT bit, which we already
> ensure can't be set except on a machine with a v3 MMU (i.e. POWER9).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu-qom.h    | 4 +---
>  target/ppc/mmu-hash64.c | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 2bd58b2a84..ef96d42cf2 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -68,7 +68,6 @@ enum powerpc_mmu_t {
>      /* PowerPC 601 MMU model (specific BATs format)            */
>      POWERPC_MMU_601        = 0x0000000A,
>  #define POWERPC_MMU_64       0x00010000
> -#define POWERPC_MMU_V3       0x00100000 /* ISA V3.00 MMU Support */
>      /* 64 bits PowerPC MMU                                     */
>      POWERPC_MMU_64B        = POWERPC_MMU_64 | 0x00000001,
>      /* Architecture 2.03 and later (has LPCR) */
> @@ -78,8 +77,7 @@ enum powerpc_mmu_t {
>      /* Architecture 2.07 variant                               */
>      POWERPC_MMU_2_07       = POWERPC_MMU_64 | 0x00000004,
>      /* Architecture 3.00 variant                               */
> -    POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_V3
> -                             | 0x00000005,
> +    POWERPC_MMU_3_00       = POWERPC_MMU_64 | 0x00000005,
>  };
>  #define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
>  #define POWERPC_MMU_VER_64B POWERPC_MMU_VER(POWERPC_MMU_64B)
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 3b00bdee91..d964f2f5b0 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -761,7 +761,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>      slb = slb_lookup(cpu, eaddr);
>      if (!slb) {
>          /* No entry found, check if in-memory segment tables are in use */
> -        if ((env->mmu_model & POWERPC_MMU_V3) && ppc64_use_proc_tbl(cpu)) {
> +        if (ppc64_use_proc_tbl(cpu)) {
>              /* TODO - Unsupported */
>              error_report("Segment Table Support Unimplemented");
>              exit(1);
