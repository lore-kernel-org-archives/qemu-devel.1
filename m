Received: from eggs.gnu.org ([2001:4830:134:3::10]:36598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9aHB-0007iS-Li
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9aH8-0001p4-BO
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:29:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9aH8-0001oN-3w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:29:02 -0400
Date: Mon, 8 Oct 2018 14:29:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181008182900.GA10471@flamenco>
References: <20181008010522.7885-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008010522.7885-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tcg: Add tlb_index and tlb_entry helpers
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

On Sun, Oct 07, 2018 at 18:05:22 -0700, Richard Henderson wrote:
> Isolate the computation of an index from an address into a
> helper before we change that function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Emilio, this should make your dynamic tlb sizing patch 1/6
> significantly smaller.

Nice! I'm adding this as patch 1 for v2. Had to fix the conflicts
with the .addr_write conversion to atomic_write, and also
fixed a few typos like the following:

>  void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
>                         TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    unsigned mmu_idx = get_mmuidx(oi);
> -    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
> +    uintptr_t mmu_idx = get_mmuidx(oi);
> +    uintptr_t index = tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, index);

Should be tlb_entry(env, mmu_idx, addr)

Thanks,

		Emilio
