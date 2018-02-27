Received: from eggs.gnu.org ([2001:4830:134:3::10]:50146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqg8H-0003lC-9V
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqg8G-0008N9-4P
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:21:29 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:41078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqg8F-0008Mu-Vt
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:21:28 -0500
Received: by mail-oi0-x242.google.com with SMTP id g5so6805106oiy.8
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:21:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-53-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-53-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 14:21:06 +0000
Message-ID: <CAFEAcA_ocCQF9Ha45kKiBAQLAHr4jOYGcdArqDgYGDLfQL87Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 52/67] target/arm: Implement
 SVE store vector/predicate register
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 101 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |   6 +++
>  2 files changed, 107 insertions(+)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index b000a2482e..9c724980a0 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3501,6 +3501,95 @@ static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
>      tcg_temp_free_i64(t0);
>  }
>
> +/* Similarly for stores.  */
> +static void do_str(DisasContext *s, uint32_t vofs, uint32_t len,
> +                   int rn, int imm)
> +{
> +    uint32_t len_align = QEMU_ALIGN_DOWN(len, 8);
> +    uint32_t len_remain = len % 8;
> +    uint32_t nparts = len / 8 + ctpop8(len_remain);
> +    int midx = get_mem_index(s);
> +    TCGv_i64 addr, t0;
> +
> +    addr = tcg_temp_new_i64();
> +    t0 = tcg_temp_new_i64();
> +
> +    /* Note that unpredicated load/store of vector/predicate registers
> +     * are defined as a stream of bytes, which equates to little-endian
> +     * operations on larger quantities.  There is no nice way to force
> +     * a little-endian load for aarch64_be-linux-user out of line.

"store" in this case, I assume.

> +     *
> +     * Attempt to keep code expansion to a minimum by limiting the
> +     * amount of unrolling done.
> +     */
> +    if (nparts <= 4) {
> +        int i;
> +
> +        for (i = 0; i < len_align; i += 8) {
> +            tcg_gen_ld_i64(t0, cpu_env, vofs + i);
> +            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
> +            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEQ);
> +        }
> +    } else {
> +        TCGLabel *loop = gen_new_label();
> +        TCGv_ptr i = TCGV_NAT_TO_PTR(glue(tcg_const_local_, ptr)(0));
> +        TCGv_ptr src;
> +
> +        gen_set_label(loop);
> +
> +        src = tcg_temp_new_ptr();
> +        tcg_gen_add_ptr(src, cpu_env, i);
> +        tcg_gen_ld_i64(t0, src, vofs);
> +
> +        /* Minimize the number of local temps that must be re-read from
> +         * the stack each iteration.  Instead, re-compute values other
> +         * than the loop counter.
> +         */
> +        tcg_gen_addi_ptr(src, i, imm);
> +#if UINTPTR_MAX == UINT32_MAX
> +        tcg_gen_extu_i32_i64(addr, TCGV_PTR_TO_NAT(src));
> +        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
> +#else
> +        tcg_gen_add_i64(addr, TCGV_PTR_TO_NAT(src), cpu_reg_sp(s, rn));
> +#endif

We should be able to avoid the ifdef with more support for tcg_*_ptr
ops (similar to an earlier patch in the series).

> +        tcg_temp_free_ptr(src);
> +
> +        tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEQ);
> +
> +        tcg_gen_addi_ptr(i, i, 8);
> +
> +        glue(tcg_gen_brcondi_, ptr)(TCG_COND_LTU, TCGV_PTR_TO_NAT(i),
> +                                   len_align, loop);
> +        tcg_temp_free_ptr(i);
> +    }
> +
> +    /* Predicate register stores can be any multiple of 2.  */
> +    if (len_remain) {
> +        tcg_gen_ld_i64(t0, cpu_env, vofs + len_align);
> +        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
> +
> +        switch (len_remain) {
> +        case 2:
> +        case 4:
> +        case 8:
> +            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LE | ctz32(len_remain));
> +            break;
> +
> +        case 6:
> +            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUL);
> +            tcg_gen_addi_i64(addr, addr, 4);
> +            tcg_gen_shri_i64(addr, addr, 32);
> +            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUW);
> +            break;
> +
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +    tcg_temp_free_i64(addr);
> +    tcg_temp_free_i64(t0);
> +}
> +
>  #undef ptr

thanks
-- PMM
