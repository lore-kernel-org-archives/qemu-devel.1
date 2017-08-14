Received: from eggs.gnu.org ([2001:4830:134:3::10]:60906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dhK1X-0006eQ-Q3
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dhK1W-0007D1-KO
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:23:35 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170812154131.29372-1-richard.henderson@linaro.org>
References: <20170812154131.29372-1-richard.henderson@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 14 Aug 2017 11:23:01 -0700
Message-ID: <CAKmqyKOnfiLhXh7G3jqjv0aF-HHCNHsfHPvy6h1X3g5NUNzXrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Correct load/store exclusive
 pairing and alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth7680@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Sat, Aug 12, 2017 at 8:41 AM, Richard Henderson <rth7680@gmail.com> wrote:
> SetExclusiveMonitors in the pseudocode is on the address + width,
> and says nothing about the manner of the load.  Therefore
>
>         ldxp    w0, w1, [x2]
> vs
>         ldxr    x0, [x2]
>
> must record the same metadata so that either may pair with
>
>         stxp    w3, w0, w1, [x2]
> vs
>         stxr    w3, x0, [x2]
>
> Fix this by ignoring cpu_exclusive_high except for 64-bit LDXP/STXP.
>
> Also note that we were not providing the required single-copy atomic
> semantics for 32-bit LDXP.  This is trivially fixed alongside the
> cpu_exclusive_val change.
>
> At the same time, exclusive loads require the same alignment as
> exclusive stores.  For 64-bit LDXP, this means adding MO_ALIGN_16;
> for the others adding MO_ALIGN.
>
> Reported-by: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This passes the same tests that my patch series passes.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Tested-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair


> ---
>  target/arm/translate-a64.c | 65 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 24 deletions(-)
> ---
>
> I have not yet constructed test cases for all of the combinations
> listed above.  I wanted to put this into your hands so that you could
> test against your existing code using LDXP/STXP.
>
>
> r~
>
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 58ed4c6d05..f3643ac8dc 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1853,29 +1853,45 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
>  static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
>                                 TCGv_i64 addr, int size, bool is_pair)
>  {
> -    TCGv_i64 tmp = tcg_temp_new_i64();
> -    TCGMemOp memop = s->be_data + size;
> +    int idx = get_mem_index(s);
> +    TCGMemOp memop = s->be_data;
>
>      g_assert(size <= 3);
> -    tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s), memop);
> -
>      if (is_pair) {
> -        TCGv_i64 addr2 = tcg_temp_new_i64();
> -        TCGv_i64 hitmp = tcg_temp_new_i64();
> -
>          g_assert(size >= 2);
> -        tcg_gen_addi_i64(addr2, addr, 1 << size);
> -        tcg_gen_qemu_ld_i64(hitmp, addr2, get_mem_index(s), memop);
> -        tcg_temp_free_i64(addr2);
> -        tcg_gen_mov_i64(cpu_exclusive_high, hitmp);
> -        tcg_gen_mov_i64(cpu_reg(s, rt2), hitmp);
> -        tcg_temp_free_i64(hitmp);
> -    }
> +        if (size == 2) {
> +            /* The pair must be single-copy atomic for the doubleword.  */
> +            memop |= MO_64 | MO_ALIGN;
> +            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
> +            if (s->be_data == MO_LE) {
> +                tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
> +                tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 32, 32);
> +            } else {
> +                tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 32, 32);
> +                tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 0, 32);
> +            }
> +        } else {
> +            /* The pair must be single-copy atomic for *each* doubleword,
> +               but not the entire quadword.  It must, however, be aligned.  */
> +            TCGv_i64 addr2;
>
> -    tcg_gen_mov_i64(cpu_exclusive_val, tmp);
> -    tcg_gen_mov_i64(cpu_reg(s, rt), tmp);
> +            memop |= MO_64;
> +            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx,
> +                                memop | MO_ALIGN_16);
>
> -    tcg_temp_free_i64(tmp);
> +            addr2 = tcg_temp_new_i64();
> +            tcg_gen_addi_i64(addr2, addr, 8);
> +            tcg_gen_qemu_ld_i64(cpu_exclusive_high, addr2, idx, memop);
> +            tcg_temp_free_i64(addr2);
> +
> +            tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
> +            tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
> +        }
> +    } else {
> +        memop |= size | MO_ALIGN;
> +        tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
> +        tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
> +    }
>      tcg_gen_mov_i64(cpu_exclusive_addr, addr);
>  }
>
> @@ -1908,14 +1924,15 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
>      tmp = tcg_temp_new_i64();
>      if (is_pair) {
>          if (size == 2) {
> -            TCGv_i64 val = tcg_temp_new_i64();
> -            tcg_gen_concat32_i64(tmp, cpu_reg(s, rt), cpu_reg(s, rt2));
> -            tcg_gen_concat32_i64(val, cpu_exclusive_val, cpu_exclusive_high);
> -            tcg_gen_atomic_cmpxchg_i64(tmp, addr, val, tmp,
> +            if (s->be_data == MO_LE) {
> +                tcg_gen_concat32_i64(tmp, cpu_reg(s, rt), cpu_reg(s, rt2));
> +            } else {
> +                tcg_gen_concat32_i64(tmp, cpu_reg(s, rt2), cpu_reg(s, rt));
> +            }
> +            tcg_gen_atomic_cmpxchg_i64(tmp, addr, cpu_exclusive_val, tmp,
>                                         get_mem_index(s),
> -                                       size | MO_ALIGN | s->be_data);
> -            tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);
> -            tcg_temp_free_i64(val);
> +                                       MO_64 | MO_ALIGN | s->be_data);
> +            tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
>          } else if (s->be_data == MO_LE) {
>              gen_helper_paired_cmpxchg64_le(tmp, cpu_env, addr, cpu_reg(s, rt),
>                                             cpu_reg(s, rt2));
> --
> 2.13.4
>
>
