Received: from eggs.gnu.org ([2001:4830:134:3::10]:58545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFdj-0002yg-U6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFdi-0001Up-Td
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:55:24 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:36396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEFdi-0001Ub-Om
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:55:22 -0400
Received: by mail-oi0-x22b.google.com with SMTP id v2-v6so16338697oif.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 07:55:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427002651.28356-9-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 15:55:01 +0100
Message-ID: <CAFEAcA_ZaP8Wxe3P+5SKpmQxzJqOEQxnKcdh7StGytOi9iR0yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Implement CAS and CASP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 April 2018 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.h    |   2 +
>  target/arm/helper-a64.c    |  43 ++++++++++++++++
>  target/arm/translate-a64.c | 119 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 161 insertions(+), 3 deletions(-)

> +static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
> +                                      int rn, int size)
> +{
> +    TCGv_i64 s1 = cpu_reg(s, rs);
> +    TCGv_i64 s2 = cpu_reg(s, rs + 1);
> +    TCGv_i64 t1 = cpu_reg(s, rt);
> +    TCGv_i64 t2 = cpu_reg(s, rt + 1);
> +    TCGv_i64 addr = cpu_reg_sp(s, rn);
> +    int memidx = get_mem_index(s);
> +
> +    if (rn == 31) {
> +        gen_check_sp_alignment(s);
> +    }
> +
> +    if (size == 2) {
> +        TCGv_i64 cmp = tcg_temp_new_i64();
> +        TCGv_i64 val = tcg_temp_new_i64();
> +
> +        if (s->be_data == MO_LE) {
> +            tcg_gen_concat32_i64(val, t1, t2);
> +            tcg_gen_concat32_i64(cmp, s1, s2);
> +        } else {
> +            tcg_gen_concat32_i64(val, t2, t1);
> +            tcg_gen_concat32_i64(cmp, s2, s1);
> +        }
> +
> +        tcg_gen_atomic_cmpxchg_i64(cmp, addr, cmp, val, memidx,
> +                                   MO_64 | MO_ALIGN | s->be_data);
> +        tcg_temp_free_i64(val);
> +
> +        if (s->be_data == MO_LE) {
> +            tcg_gen_extr32_i64(s1, s2, cmp);
> +        } else {
> +            tcg_gen_extr32_i64(s2, s1, cmp);
> +        }
> +        tcg_temp_free_i64(cmp);
> +    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> +        TCGv_i32 tcg_rs = tcg_const_i32(rs);
> +
> +        if (s->be_data == MO_LE) {
> +            gen_helper_casp_le_parallel(cpu_env, tcg_rs, addr, t1, t2);
> +        } else {
> +            gen_helper_casp_be_parallel(cpu_env, tcg_rs, addr, t1, t2);
> +        }
> +        tcg_temp_free_i32(tcg_rs);
> +    } else {
> +        TCGv_i64 d1 = tcg_temp_new_i64();
> +        TCGv_i64 d2 = tcg_temp_new_i64();
> +        TCGv_i64 a2 = tcg_temp_new_i64();
> +        TCGv_i64 c1 = tcg_temp_new_i64();
> +        TCGv_i64 c2 = tcg_temp_new_i64();
> +        TCGv_i64 zero = tcg_const_i64(0);
> +
> +        /* Load the two words, in memory order.  */
> +        tcg_gen_qemu_ld_i64(d1, addr, memidx,
> +                            MO_64 | MO_ALIGN_16 | s->be_data);
> +        tcg_gen_addi_i64(a2, addr, 8);
> +        tcg_gen_qemu_ld_i64(d2, addr, memidx, MO_64 | s->be_data);
> +
> +        /* Compare the two words, also in memory order.  */
> +        tcg_gen_setcond_i64(TCG_COND_EQ, c1, d1, s1);
> +        tcg_gen_setcond_i64(TCG_COND_EQ, c2, d2, s2);
> +        tcg_gen_and_i64(c2, c2, c1);
> +
> +        /* If compare equal, write back new data, else write back old data.  */
> +        tcg_gen_movcond_i64(TCG_COND_NE, c1, c2, zero, t1, d1);
> +        tcg_gen_movcond_i64(TCG_COND_NE, c2, c2, zero, t2, d2);
> +        tcg_gen_qemu_st_i64(c1, addr, memidx, MO_64 | s->be_data);
> +        tcg_gen_qemu_st_i64(c2, a2, memidx, MO_64 | s->be_data);

I think this has the wrong behaviour if you do a CASP-with-mismatched-value
to read-only memory -- architecturally this should fail the comparison
and return the memory value in registers, it's not allowed to do a
memory write and take a data abort because the memory isn't writable.

> +        tcg_temp_free_i64(a2);
> +        tcg_temp_free_i64(c1);
> +        tcg_temp_free_i64(c2);
> +        tcg_temp_free_i64(zero);
> +
> +        /* Write back the data from memory to Rs.  */
> +        tcg_gen_mov_i64(s1, d1);
> +        tcg_gen_mov_i64(s2, d2);
> +        tcg_temp_free_i64(d1);
> +        tcg_temp_free_i64(d2);
> +    }
> +}
> +

thanks
-- PMM
