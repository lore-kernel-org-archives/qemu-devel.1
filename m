Received: from eggs.gnu.org ([2001:4830:134:3::10]:54218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckBND-0002Dp-Cw
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckBNC-0003BZ-3r
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:13:31 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckBNB-0003BS-P2
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:13:30 -0500
Received: by mail-wm0-x22e.google.com with SMTP id t193so34894069wmt.1
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 07:13:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488558530-21016-2-git-send-email-pbonzini@redhat.com>
References: <1488558530-21016-2-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 15:13:08 +0000
Message-ID: <CAFEAcA-sFKPdLHS+T-2jk=wq-FpyWR+nCJKoNrbVgtPapGWGZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] nios2: avoid anonymous unions in
 designated initializers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 3 March 2017 at 16:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> These cause compilation failures on CentOS 6 or other operating
> systems with older GCCs.
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         Peter, please consider applying this as a build fix, because
>         the centos6 docker target is broken.

Applied to master, thanks.

(The mailing list server seems to have eaten this mail -- I got
the copy directly by being on cc but patchwork never saw it.)

thanks
-- PMM


>  target/nios2/translate.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> index 2d73839..cfec479 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -48,14 +48,14 @@
>      struct {                               \
>          uint8_t op;                        \
>          union {                            \
> -            uint16_t imm16;                \
> -            int16_t imm16s;                \
> -        };                                 \
> +            uint16_t u;                    \
> +            int16_t s;                     \
> +        } imm16;                           \
>          uint8_t b;                         \
>          uint8_t a;                         \
>      } (instr) = {                          \
>          .op    = extract32((code), 0, 6),  \
> -        .imm16 = extract32((code), 6, 16), \
> +        .imm16.u = extract32((code), 6, 16), \
>          .b     = extract32((code), 22, 5), \
>          .a     = extract32((code), 27, 5), \
>      }
> @@ -232,7 +232,7 @@ static void gen_ldx(DisasContext *dc, uint32_t code, uint32_t flags)
>          data = tcg_temp_new();
>      }
>
> -    tcg_gen_addi_tl(addr, load_gpr(dc, instr.a), instr.imm16s);
> +    tcg_gen_addi_tl(addr, load_gpr(dc, instr.a), instr.imm16.s);
>      tcg_gen_qemu_ld_tl(data, addr, dc->mem_idx, flags);
>
>      if (unlikely(instr.b == R_ZERO)) {
> @@ -249,7 +249,7 @@ static void gen_stx(DisasContext *dc, uint32_t code, uint32_t flags)
>      TCGv val = load_gpr(dc, instr.b);
>
>      TCGv addr = tcg_temp_new();
> -    tcg_gen_addi_tl(addr, load_gpr(dc, instr.a), instr.imm16s);
> +    tcg_gen_addi_tl(addr, load_gpr(dc, instr.a), instr.imm16.s);
>      tcg_gen_qemu_st_tl(val, addr, dc->mem_idx, flags);
>      tcg_temp_free(addr);
>  }
> @@ -259,7 +259,7 @@ static void br(DisasContext *dc, uint32_t code, uint32_t flags)
>  {
>      I_TYPE(instr, code);
>
> -    gen_goto_tb(dc, 0, dc->pc + 4 + (instr.imm16s & -4));
> +    gen_goto_tb(dc, 0, dc->pc + 4 + (instr.imm16.s & -4));
>      dc->is_jmp = DISAS_TB_JUMP;
>  }
>
> @@ -271,7 +271,7 @@ static void gen_bxx(DisasContext *dc, uint32_t code, uint32_t flags)
>      tcg_gen_brcond_tl(flags, dc->cpu_R[instr.a], dc->cpu_R[instr.b], l1);
>      gen_goto_tb(dc, 0, dc->pc + 4);
>      gen_set_label(l1);
> -    gen_goto_tb(dc, 1, dc->pc + 4 + (instr.imm16s & -4));
> +    gen_goto_tb(dc, 1, dc->pc + 4 + (instr.imm16.s & -4));
>      dc->is_jmp = DISAS_TB_JUMP;
>  }
>
> @@ -284,8 +284,8 @@ static void (fname)(DisasContext *dc, uint32_t code, uint32_t flags)         \
>                          (op3));                                              \
>  }
>
> -gen_i_cmpxx(gen_cmpxxsi, instr.imm16s)
> -gen_i_cmpxx(gen_cmpxxui, instr.imm16)
> +gen_i_cmpxx(gen_cmpxxsi, instr.imm16.s)
> +gen_i_cmpxx(gen_cmpxxui, instr.imm16.u)
>
>  /* Math/logic instructions */
>  #define gen_i_math_logic(fname, insn, resimm, op3)                          \
> @@ -302,16 +302,16 @@ static void (fname)(DisasContext *dc, uint32_t code, uint32_t flags)        \
>      }                                                                       \
>  }
>
> -gen_i_math_logic(addi,  addi, 1, instr.imm16s)
> -gen_i_math_logic(muli,  muli, 0, instr.imm16s)
> +gen_i_math_logic(addi,  addi, 1, instr.imm16.s)
> +gen_i_math_logic(muli,  muli, 0, instr.imm16.s)
>
> -gen_i_math_logic(andi,  andi, 0, instr.imm16)
> -gen_i_math_logic(ori,   ori,  1, instr.imm16)
> -gen_i_math_logic(xori,  xori, 1, instr.imm16)
> +gen_i_math_logic(andi,  andi, 0, instr.imm16.u)
> +gen_i_math_logic(ori,   ori,  1, instr.imm16.u)
> +gen_i_math_logic(xori,  xori, 1, instr.imm16.u)
>
> -gen_i_math_logic(andhi, andi, 0, instr.imm16 << 16)
> -gen_i_math_logic(orhi , ori,  1, instr.imm16 << 16)
> -gen_i_math_logic(xorhi, xori, 1, instr.imm16 << 16)
> +gen_i_math_logic(andhi, andi, 0, instr.imm16.u << 16)
> +gen_i_math_logic(orhi , ori,  1, instr.imm16.u << 16)
> +gen_i_math_logic(xorhi, xori, 1, instr.imm16.u << 16)
>
>  /* Prototype only, defined below */
>  static void handle_r_type_instr(DisasContext *dc, uint32_t code,
> --
> 1.8.3.1
>
