Received: from eggs.gnu.org ([2001:4830:134:3::10]:59293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fWFkY-0003gy-Gb
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fWFkV-0000At-DV
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:40:50 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:40650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fWFkV-0000AS-5k
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:40:47 -0400
Received: by mail-pf0-x243.google.com with SMTP id z24-v6so2724733pfe.7
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 23:40:47 -0700 (PDT)
Date: Fri, 22 Jun 2018 15:40:43 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180622064043.GE24595@lianli.shorne-pla.net>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-13-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618184046.6270-13-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 12/22] target/openrisc: Fix tlb flushing
 in mtspr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Jun 18, 2018 at 08:40:36AM -1000, Richard Henderson wrote:
> The previous code was confused, avoiding the flush of the old entry
> if the new entry is invalid.  We need to flush the old page if the
> old entry is valid and the new page if the new entry is valid.
> 
> This bug was masked by over-flushing elsewhere.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/openrisc/sys_helper.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index 8ad7a7d898..e00aaa332e 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -32,6 +32,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>  #ifndef CONFIG_USER_ONLY
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
>      CPUState *cs = CPU(cpu);
> +    target_ulong mr;
>      int idx;
>  
>      switch (spr) {
> @@ -84,12 +85,15 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>  
>      case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
>          idx = spr - TO_SPR(1, 512);
> -        if (!(rb & 1)) {
> -            tlb_flush_page(cs, env->tlb.dtlb[idx].mr & TARGET_PAGE_MASK);
> +        mr = env->tlb.dtlb[idx].mr;
> +        if (mr & 1) {
> +            tlb_flush_page(cs, mr & TARGET_PAGE_MASK);
> +        }
> +        if (rb & 1) {
> +            tlb_flush_page(cs, rb & TARGET_PAGE_MASK);

Hi Richard,

On openrisc we write 0 to the TLB SPR to flush the old entry out of the TLB, I
don't see much documentation on this, but this is what is done in the kernel.
This patch is causing the linux kernel to not boot.

I thought flush is to get rid of the old mapping from the tlb, if we need to do
it for new mappings too should we do.  Why do we need to flush new mappings?

    /* flush old page if it was valid or we are invalidating */
    if ((mr & 1) || !(rb & 1)) {
	tlb_flush_page(cs, mr & TARGET_PAGE_MASK);
    }
    /* flush new page if its being entered into tlb */
    if (rb & 1) {
	tlb_flush_page(cs, rb & TARGET_PAGE_MASK);
    }

I didn't write the original code, but I think it was right as is.

>          }
>          env->tlb.dtlb[idx].mr = rb;
>          break;
> -
>      case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
>          idx = spr - TO_SPR(1, 640);
>          env->tlb.dtlb[idx].tr = rb;
> @@ -101,14 +105,18 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>      case TO_SPR(1, 1280) ... TO_SPR(1, 1407): /* DTLBW3MR 0-127 */
>      case TO_SPR(1, 1408) ... TO_SPR(1, 1535): /* DTLBW3TR 0-127 */
>          break;
> +
>      case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1):   /* ITLBW0MR 0-127 */
>          idx = spr - TO_SPR(2, 512);
> -        if (!(rb & 1)) {
> -            tlb_flush_page(cs, env->tlb.itlb[idx].mr & TARGET_PAGE_MASK);
> +        mr = env->tlb.itlb[idx].mr;
> +        if (mr & 1) {
> +            tlb_flush_page(cs, mr & TARGET_PAGE_MASK);
> +        }
> +        if (rb & 1) {
> +            tlb_flush_page(cs, rb & TARGET_PAGE_MASK);
>          }

Likewise.

>          env->tlb.itlb[idx].mr = rb;
>          break;
> -
>      case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
>          idx = spr - TO_SPR(2, 640);
>          env->tlb.itlb[idx].tr = rb;
> @@ -120,6 +128,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>      case TO_SPR(2, 1280) ... TO_SPR(2, 1407): /* ITLBW3MR 0-127 */
>      case TO_SPR(2, 1408) ... TO_SPR(2, 1535): /* ITLBW3TR 0-127 */
>          break;
> +
>      case TO_SPR(5, 1):  /* MACLO */
>          env->mac = deposit64(env->mac, 0, 32, rb);
>          break;
> -- 
> 2.17.1
> 
