Received: from eggs.gnu.org ([208.118.235.92]:49947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYDCL-00089A-G7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYDCH-00078n-4t
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:17:05 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:15299)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYDCG-00077Y-UN
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:17:01 -0400
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<cdee8fc6142bf90381edff96edc5773fd53f530d.1500378931.git-series.james.hogan@imgtec.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <92f9c6d4-f0c7-246d-df74-61bb7d6c6389@imgtec.com>
Date: Thu, 20 Jul 2017 16:16:53 +0100
MIME-Version: 1.0
In-Reply-To: <cdee8fc6142bf90381edff96edc5773fd53f530d.1500378931.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/14] target/mips: Fix TLBWI shadow flush
 for EHINV, XI, RI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>



On 18/07/2017 12:55, James Hogan wrote:
> Writing specific TLB entries with TLBWI flushes shadow TLB entries
> unless an existing entry is having its access permissions upgraded. This
> is necessary as software would from then on expect the previous mapping
> in that entry to no longer be in effect (even if QEMU has quietly
> evicted it to the shadow TLB on a TLBWR).
> 
> However it won't do this if only EHINV, XI, or RI bits have been set,
> even if that results in a reduction of permissions, so add the necessary
> checks to invoke the flush when these bits are set.
> 
> Fixes: 2fb58b73746e ("target-mips: add RI and XI fields to TLB entry")
> Fixes: 9456c2fbcd82 ("target-mips: add TLBINV support")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Changes in v2:
> - New patch.
> ---
>  target/mips/op_helper.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index e5f3ea40420e..1961cacfab18 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2029,7 +2029,7 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
>      int idx;
>      target_ulong VPN;
>      uint16_t ASID;
> -    bool G, V0, D0, V1, D1;
> +    bool EHINV, G, V0, D0, V1, D1, XI0, XI1, RI0, RI1;
>  
>      idx = (env->CP0_Index & ~0x80000000) % env->tlb->nb_tlb;
>      tlb = &env->tlb->mmu.r4k.tlb[idx];
> @@ -2038,17 +2038,25 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
>      VPN &= env->SEGMask;
>  #endif
>      ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
> +    EHINV = (env->CP0_EntryHi & (1 << CP0EnHi_EHINV)) != 0;
>      G = env->CP0_EntryLo0 & env->CP0_EntryLo1 & 1;
>      V0 = (env->CP0_EntryLo0 & 2) != 0;
>      D0 = (env->CP0_EntryLo0 & 4) != 0;
> +    XI0 = (env->CP0_EntryLo0 >> CP0EnLo_XI) & 1;
> +    RI0 = (env->CP0_EntryLo0 >> CP0EnLo_RI) & 1;
>      V1 = (env->CP0_EntryLo1 & 2) != 0;
>      D1 = (env->CP0_EntryLo1 & 4) != 0;
> +    XI1 = (env->CP0_EntryLo1 >> CP0EnLo_XI) & 1;
> +    RI1 = (env->CP0_EntryLo1 >> CP0EnLo_RI) & 1;
>  
>      /* Discard cached TLB entries, unless tlbwi is just upgrading access
>         permissions on the current entry. */
>      if (tlb->VPN != VPN || tlb->ASID != ASID || tlb->G != G ||
> +        (!tlb->EHINV && EHINV) ||
>          (tlb->V0 && !V0) || (tlb->D0 && !D0) ||
> -        (tlb->V1 && !V1) || (tlb->D1 && !D1)) {
> +        (!tlb->XI0 && XI0) || (!tlb->RI0 && RI0) ||
> +        (tlb->V1 && !V1) || (tlb->D1 && !D1) ||
> +        (!tlb->XI1 && XI1) || (!tlb->RI1 && RI1)) {
>          r4k_mips_tlb_flush_extra(env, env->tlb->nb_tlb);
>      }
>  
> 

Tested-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok
