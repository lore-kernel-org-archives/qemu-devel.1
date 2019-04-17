Received: from eggs.gnu.org ([209.51.188.92]:37640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGqF2-0000SR-J7
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGqF1-0000Is-9j
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:29:08 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGqF0-0000Gz-Rr
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:29:07 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so12473351plp.10
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 12:29:06 -0700 (PDT)
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1555515206-9352-2-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d533932a-1bc4-6199-9e68-6c1d128d1724@linaro.org>
Date: Wed, 17 Apr 2019 09:29:00 -1000
MIME-Version: 1.0
In-Reply-To: <1555515206-9352-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 1/6] target/mips: Optimize
 ILVOD.<B|H|W|D> MSA instructions
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
> Optimize set of MSA instructions ILVOD.<B|H|W|D>, using
> directly tcg registers and performing logic on them instead
> of using helpers.
> 
> In the following table, the first column is the performance
> before this patch. The second represents the performance
> after converting from helpers to tcg, but without using
> tcg_gen_deposit function. The third one is with the deposit
> function and with using a uint64_t constant bit mask, and
> the fourth is with the deposit function and with a mask
> which is a tcg constant. The fourth is implemented in this
> patch.
> 
> Performance measurement is done by executing the
> instructions 10 million times on a computer
> with Intel Core i7-3770 CPU @ 3.40GHz×8.
> 
> ==================================================================
> || instruction ||     1     ||     2    ||     3    ||     4    ||
> ==================================================================
> ||   ilvod.b   || 117.50 ms || 24.13 ms || 24.45 ms || 23.24 ms ||
> ||   ilvod.h   ||  93.16 ms || 24.21 ms || 24.28 ms || 23.20 ms ||
> ||   ilvod.w   || 119.90 ms || 24.15 ms || 23.19 ms || 22.95 ms ||
> ||   ilvod.d   ||  43.01 ms || 21.17 ms || 23.07 ms || 22.59 ms ||
> ==================================================================
> 1 - before
> 2 - no-deposit-no-mask-as-tcg-constant
> 3 - with-deposit-no-mask-as-tcg-constant
> 4 - with-deposit-with-mask-as-tcg-constant (final)
> 
> The deposit function is used only in ILVOD.W.
> 
> No-deposit version of the ILVOD.W implementation:
> 
> static inline void gen_ilvod_w(CPUMIPSState *env, uint32_t wd,
>                                uint32_t ws, uint32_t wt)
> {
>     TCGv_i64 t1 = tcg_temp_new_i64();
>     TCGv_i64 t2 = tcg_temp_new_i64();
>     TCGv_i64 mask = tcg_const_i64(0xffffffff00000000ULL);
> 
>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
>     tcg_gen_shri_i64(t1, t1, 32);
>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> 
>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>     tcg_gen_shri_i64(t1, t1, 32);
>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> 
>     tcg_temp_free_i64(mask);
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
>  target/mips/msa_helper.c |  7 ----
>  target/mips/translate.c  | 91 +++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 90 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
