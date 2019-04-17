Received: from eggs.gnu.org ([209.51.188.92]:38997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGqKE-0004ik-AW
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGqKD-0004MY-79
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:34:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGqKC-0004KQ-RO
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:34:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id y3so12445977pgk.12
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 12:34:28 -0700 (PDT)
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1555515206-9352-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf8101ba-e5b1-ad42-9615-ee6cae402cee@linaro.org>
Date: Wed, 17 Apr 2019 09:34:22 -1000
MIME-Version: 1.0
In-Reply-To: <1555515206-9352-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 2/6] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, philmd@redhat.com, amarkovic@wavecomp.com, arikalo@wavecomp.com

On 4/17/19 5:33 AM, Mateja Marjanovic wrote:
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> 
> Optimize set of MSA instructions ILVEV.<B|H|W|D>, using
> directly tcg registers and performing logic on them
> instead of using helpers.
> 
> In the following table, the first column is the performance
> before this patch. The second represents the performance
> after converting from helpers to tcg, but without using
> tcg_gen_deposit function. The third one is with using the
> tcg_gen_deposit function and with using a uint64_t constant
> bit mask, and the fourth is with using the tcg_gen_deposit
> function and with a mask which is a tcg constant. The fourth
> is implemented in this patch.
> 
> Performance measurement is done by executing the
> instructions 10 million times on a computer
> with Intel Core i7-3770 CPU @ 3.40GHz×8.
> 
> ==================================================================
> || instruction ||     1     ||     2    ||     3    ||     4    ||
> ==================================================================
> ||   ilvev.b   || 126.92 ms || 24.52 ms || 25.19 ms || 23.89 ms ||
> ||   ilvev.h   ||  93.67 ms || 23.92 ms || 24.76 ms || 24.31 ms ||
> ||   ilvev.w   || 117.86 ms || 23.83 ms || 21.84 ms || 21.99 ms ||
> ||   ilvev.d   ||  45.49 ms || 19.74 ms || 20.21 ms || 20.07 ms ||
> ==================================================================
> 1 - before
> 2 - no-deposit-no-mask-as-tcg-constant
> 3 - with-deposit-no-mask-as-tcg-constant
> 4 - with-deposit-with-mask-as-tcg-constant (final)
> 
> The deposit function is used only in ILVEV.W.
> 
> No-deposit version of the ILVEV.W implementation:
> 
> static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
>                                uint32_t ws, uint32_t wt)
> {
>     TCGv_i64 t1 = tcg_temp_new_i64();
>     TCGv_i64 t2 = tcg_temp_new_i64();
>     uint64_t mask = 0x00000000ffffffffULL;
> 
>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
>     tcg_gen_shli_i64(t2, t2, 32);
>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> 
>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>     tcg_gen_shli_i64(t2, t2, 32);
>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> 
>     tcg_temp_free_i64(t1);
>     tcg_temp_free_i64(t2);
> }
> 
> Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/helper.h     |  1 -
>  target/mips/msa_helper.c |  9 -----
>  target/mips/translate.c  | 87 +++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 86 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
