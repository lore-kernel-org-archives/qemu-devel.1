Received: from eggs.gnu.org ([2001:4830:134:3::10]:56208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cwA3u-0005ht-AG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cwA3t-0002dr-B8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:15:06 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<20170406102249.20383-4-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2f858a60-0824-96c1-8248-49325fac2721@twiddle.net>
Date: Thu, 6 Apr 2017 09:15:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170406102249.20383-4-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v1 3/3] target/ppc: Generate fence
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

On 04/06/2017 03:22 AM, Nikunj A Dadhania wrote:
> @@ -3028,6 +3030,7 @@ static void gen_##name(DisasContext *ctx)                            \
>      tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop);                \
>      tcg_gen_mov_tl(cpu_reserve, t0);                                 \
>      tcg_gen_mov_tl(cpu_reserve_val, gpr);                            \
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);                           \

Please put the barrier next to the load.
I hope we can merge these soon.


> @@ -3196,6 +3199,7 @@ static void gen_##name(DisasContext *ctx)                   \
>      if (len > 1) {                                          \
>          gen_check_align(ctx, t0, (len) - 1);                \
>      }                                                       \
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);                  \
>      gen_conditional_store(ctx, t0, rS(ctx->opcode), memop); \
>      tcg_temp_free(t0);                                      \
>  }

This one is more complicated...

The success path includes an atomic_cmpxchg, which itself is a SC barrier. 
However, the fail path branches across the cmpxchg and so sees no barrier, but 
one is still required by the architecture.  How about a gen_conditional_store 
that looks like this:

{
   TCGLabel *l1 = gen_new_label();
   TCGLabel *l2 = gen_new_label();
   TCGv t0;

   tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);

   t0 = tcg_temp_new();
   tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
                             cpu_gpr[reg], ctx->mem_idx,
                             DEF_MEMOP(memop) | MO_ALIGN);
   tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
   tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
   tcg_gen_or_tl(t0, t0, cpu_so);
   tcg_gen_trunc_tl(cpu_crf[0], t0);
   tcg_temp_free(t0);
   tcg_gen_br(l2);

   gen_set_label(l1);

   /* Address mismatch implies failure.  But we still need to provide the
      memory barrier semantics of the instruction.  */
   tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
   tcg_gen_trunc_tl(cpu_crf[0], cpu_so);

   gen_set_label(l2);
   tcg_gen_movi_tl(cpu_reserve, -1);
}

Note that you don't need to reset cpu_reserve_val at all.

I just thought of something we might need to check for this and other ll/sc 
implemetations -- do we need to check for address misalignment along the 
address comparison failure path?  I suspect that we do.


r~
