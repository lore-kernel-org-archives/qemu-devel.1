Received: from eggs.gnu.org ([2001:4830:134:3::10]:33596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gGCHj-00023F-Gv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 20:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gGCHf-0003SW-Dv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 20:16:59 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33285)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gGCHf-0003Rb-4I
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 20:16:55 -0400
Date: Fri, 26 Oct 2018 20:16:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181027001652.GA12509@flamenco>
References: <20181023070253.6407-1-richard.henderson@linaro.org>
	<20181023070253.6407-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023070253.6407-6-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 04/10] cputlb: Split large page tracking
 per mmu_idx
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

On Tue, Oct 23, 2018 at 08:02:47 +0100, Richard Henderson wrote:
> +static void tlb_flush_page_locked(CPUArchState *env, int midx,
> +                                  target_ulong addr)
> +{
> +    target_ulong lp_addr = env->tlb_d[midx].large_page_addr;
> +    target_ulong lp_mask = env->tlb_d[midx].large_page_mask;
> +
> +    /* Check if we need to flush due to large pages.  */
> +    if ((addr & lp_mask) == lp_addr) {
> +        tlb_debug("forcing full flush midx %d ("
> +                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
> +                  midx, lp_addr, lp_mask);
> +        tlb_flush_one_mmuidx_locked(env, midx);
> +    } else {
> +        int pidx = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> +        tlb_flush_entry_locked(&env->tlb_table[midx][pidx], addr);
> +        tlb_flush_vtlb_page_locked(env, midx, addr);

Just noticed that we should use tlb_entry here, e.g.:

     } else {
-        int pidx = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-        tlb_flush_entry_locked(&env->tlb_table[midx][pidx], addr);
+        CPUTLBEntry *entry = tlb_entry(env, midx, addr);
+
+        tlb_flush_entry_locked(entry, addr);
         tlb_flush_vtlb_page_locked(env, midx, addr);
     }

Thanks,

		Emilio
