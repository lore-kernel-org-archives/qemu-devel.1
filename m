Received: from eggs.gnu.org ([2001:4830:134:3::10]:50954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcypP-0007S1-Sf
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 14:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcypL-00060J-Pb
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 14:57:07 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcypL-00060D-Km
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 14:57:03 -0400
Received: by mail-qk0-x243.google.com with SMTP id m84so5434878qki.5
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 11:57:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501682311-16370-1-git-send-email-yongbok.kim@imgtec.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f0aa868-90a9-12a4-36ea-63c569a8b869@amsat.org>
Date: Wed, 2 Aug 2017 15:56:59 -0300
MIME-Version: 1.0
In-Reply-To: <1501682311-16370-1-git-send-email-yongbok.kim@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-mips: apply CP0.PageMask before
 writing into TLB entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leon Alrae <leon.alrae@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, qemu-devel@nongnu.org

Hi Leon,

On 08/02/2017 10:58 AM, Yongbok Kim wrote:
> From: Leon Alrae <leon.alrae@imgtec.com>
> 
> PFN0 and PFN1 have to be masked out with PageMask_Mask.
> 
> Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
> Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
> [Yongbok Kim:
>    Added commit message]
> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
> ---
>   target/mips/op_helper.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 526f8e4..320f2b0 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2008,6 +2008,7 @@ static inline uint64_t get_tlb_pfn_from_entrylo(uint64_t entrylo)
>   static void r4k_fill_tlb(CPUMIPSState *env, int idx)
>   {
>       r4k_tlb_t *tlb;
> +    uint64_t mask = env->CP0_PageMask >> (TARGET_PAGE_BITS + 1);
>   
>       /* XXX: detect conflicting TLBs and raise a MCHECK exception when needed */
>       tlb = &env->tlb->mmu.r4k.tlb[idx];
> @@ -2028,13 +2029,13 @@ static void r4k_fill_tlb(CPUMIPSState *env, int idx)
>       tlb->C0 = (env->CP0_EntryLo0 >> 3) & 0x7;
>       tlb->XI0 = (env->CP0_EntryLo0 >> CP0EnLo_XI) & 1;
>       tlb->RI0 = (env->CP0_EntryLo0 >> CP0EnLo_RI) & 1;
> -    tlb->PFN[0] = get_tlb_pfn_from_entrylo(env->CP0_EntryLo0) << 12;
> +    tlb->PFN[0] = (get_tlb_pfn_from_entrylo(env->CP0_EntryLo0) & ~mask) << 12;
>       tlb->V1 = (env->CP0_EntryLo1 & 2) != 0;
>       tlb->D1 = (env->CP0_EntryLo1 & 4) != 0;
>       tlb->C1 = (env->CP0_EntryLo1 >> 3) & 0x7;
>       tlb->XI1 = (env->CP0_EntryLo1 >> CP0EnLo_XI) & 1;
>       tlb->RI1 = (env->CP0_EntryLo1 >> CP0EnLo_RI) & 1;
> -    tlb->PFN[1] = get_tlb_pfn_from_entrylo(env->CP0_EntryLo1) << 12;
> +    tlb->PFN[1] = (get_tlb_pfn_from_entrylo(env->CP0_EntryLo1) & ~mask) << 12;
>   }
>   
>   void r4k_helper_tlbinv(CPUMIPSState *env)
> 

What about refactoring get_tlb_pfn_from_entrylo(uint64_t entrylo) -> 
r4k_get_tlb_pfn_from_entrylo(uint64_t entrylo, uint64_t pagemask) to 
directly masked pfn?

Regards,

Phil.
