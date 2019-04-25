Received: from eggs.gnu.org ([209.51.188.92]:44395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrC-0000gO-QJ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgr6-0001eL-WB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJgr6-0001cK-O5
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:12 -0400
Received: by mail-pg1-x541.google.com with SMTP id d31so66664pgl.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:04:12 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:04:08 -0700 (PDT)
In-Reply-To: <20190401031155.21293-4-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-3e3866ac-838d-4c70-8dd4-880201b74b8a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On Sun, 31 Mar 2019 20:11:50 PDT (-0700), richard.henderson@linaro.org wrote:
> In some cases this allows us to directly use the insn32
> translator function.  In some cases we still need a shim.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/insn_trans/trans_rvc.inc.c | 144 ++----------------------
>  target/riscv/translate.c                |  13 ++-
>  target/riscv/insn16.decode              |  82 ++++++++------
>  3 files changed, 69 insertions(+), 170 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
> index ebcd977b2f..dfb46a2348 100644
> --- a/target/riscv/insn_trans/trans_rvc.inc.c
> +++ b/target/riscv/insn_trans/trans_rvc.inc.c
> @@ -28,18 +28,6 @@ static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
>      return trans_addi(ctx, &arg);
>  }
>
> -static bool trans_c_fld(DisasContext *ctx, arg_c_fld *a)
> -{
> -    arg_fld arg = { .rd = a->rd, .rs1 = a->rs1, .imm = a->uimm };
> -    return trans_fld(ctx, &arg);
> -}
> -
> -static bool trans_c_lw(DisasContext *ctx, arg_c_lw *a)
> -{
> -    arg_lw arg = { .rd = a->rd, .rs1 = a->rs1, .imm = a->uimm };
> -    return trans_lw(ctx, &arg);
> -}
> -
>  static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
>  {
>  #ifdef TARGET_RISCV32
> @@ -47,31 +35,17 @@ static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> -    arg_c_lw tmp;
> -    decode_insn16_extract_cl_w(&tmp, ctx->opcode);
> -    arg_flw arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
> +    arg_i arg;
> +    decode_insn16_extract_cl_w(&arg, ctx->opcode);
>      return trans_flw(ctx, &arg);
>  #else
>      /* C.LD ( RV64C/RV128C-only ) */
> -    arg_c_fld tmp;
> -    decode_insn16_extract_cl_d(&tmp, ctx->opcode);
> -    arg_ld arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
> +    arg_i arg;
> +    decode_insn16_extract_cl_d(&arg, ctx->opcode);
>      return trans_ld(ctx, &arg);
>  #endif
>  }
>
> -static bool trans_c_fsd(DisasContext *ctx, arg_c_fsd *a)
> -{
> -    arg_fsd arg = { .rs1 = a->rs1, .rs2 = a->rs2, .imm = a->uimm };
> -    return trans_fsd(ctx, &arg);
> -}
> -
> -static bool trans_c_sw(DisasContext *ctx, arg_c_sw *a)
> -{
> -    arg_sw arg = { .rs1 = a->rs1, .rs2 = a->rs2, .imm = a->uimm };
> -    return trans_sw(ctx, &arg);
> -}
> -
>  static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
>  {
>  #ifdef TARGET_RISCV32
> @@ -79,34 +53,22 @@ static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> -    arg_c_sw tmp;
> -    decode_insn16_extract_cs_w(&tmp, ctx->opcode);
> -    arg_fsw arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
> +    arg_s arg;
> +    decode_insn16_extract_cs_w(&arg, ctx->opcode);
>      return trans_fsw(ctx, &arg);
>  #else
>      /* C.SD ( RV64C/RV128C-only ) */
> -    arg_c_fsd tmp;
> -    decode_insn16_extract_cs_d(&tmp, ctx->opcode);
> -    arg_sd arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
> +    arg_s arg;
> +    decode_insn16_extract_cs_d(&arg, ctx->opcode);
>      return trans_sd(ctx, &arg);
>  #endif
>  }
>
> -static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a)
> -{
> -    if (a->imm == 0) {
> -        /* Hint: insn is valid but does not affect state */
> -        return true;
> -    }
> -    arg_addi arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
> -    return trans_addi(ctx, &arg);
> -}
> -
>  static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
>  {
>  #ifdef TARGET_RISCV32
>      /* C.JAL */
> -    arg_c_j tmp;
> +    arg_j tmp;
>      decode_insn16_extract_cj(&tmp, ctx->opcode);
>      arg_jal arg = { .rd = 1, .imm = tmp.imm };
>      return trans_jal(ctx, &arg);
> @@ -117,16 +79,6 @@ static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
>  #endif
>  }
>
> -static bool trans_c_li(DisasContext *ctx, arg_c_li *a)
> -{
> -    if (a->rd == 0) {
> -        /* Hint: insn is valid but does not affect state */
> -        return true;
> -    }
> -    arg_addi arg = { .rd = a->rd, .rs1 = 0, .imm = a->imm };
> -    return trans_addi(ctx, &arg);
> -}
> -
>  static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a)
>  {
>      if (a->rd == 2) {
> @@ -177,41 +129,10 @@ static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a)
>      return trans_srai(ctx, &arg);
>  }
>
> -static bool trans_c_andi(DisasContext *ctx, arg_c_andi *a)
> -{
> -    arg_andi arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
> -    return trans_andi(ctx, &arg);
> -}
> -
> -static bool trans_c_sub(DisasContext *ctx, arg_c_sub *a)
> -{
> -    arg_sub arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -    return trans_sub(ctx, &arg);
> -}
> -
> -static bool trans_c_xor(DisasContext *ctx, arg_c_xor *a)
> -{
> -    arg_xor arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -    return trans_xor(ctx, &arg);
> -}
> -
> -static bool trans_c_or(DisasContext *ctx, arg_c_or *a)
> -{
> -    arg_or arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -    return trans_or(ctx, &arg);
> -}
> -
> -static bool trans_c_and(DisasContext *ctx, arg_c_and *a)
> -{
> -    arg_and arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -    return trans_and(ctx, &arg);
> -}
> -
>  static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
>  {
>  #ifdef TARGET_RISCV64
> -    arg_subw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -    return trans_subw(ctx, &arg);
> +    return trans_subw(ctx, a);
>  #else
>      return false;
>  #endif
> @@ -220,31 +141,12 @@ static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
>  static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
>  {
>  #ifdef TARGET_RISCV64
> -    arg_addw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -    return trans_addw(ctx, &arg);
> +    return trans_addw(ctx, a);
>  #else
>      return false;
>  #endif
>  }
>
> -static bool trans_c_j(DisasContext *ctx, arg_c_j *a)
> -{
> -    arg_jal arg = { .rd = 0, .imm = a->imm };
> -    return trans_jal(ctx, &arg);
> -}
> -
> -static bool trans_c_beqz(DisasContext *ctx, arg_c_beqz *a)
> -{
> -    arg_beq arg = { .rs1 = a->rs1, .rs2 = 0, .imm = a->imm };
> -    return trans_beq(ctx, &arg);
> -}
> -
> -static bool trans_c_bnez(DisasContext *ctx, arg_c_bnez *a)
> -{
> -    arg_bne arg = { .rs1 = a->rs1, .rs2 = 0, .imm = a->imm };
> -    return trans_bne(ctx, &arg);
> -}
> -
>  static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
>  {
>      int shamt = a->shamt;
> @@ -261,18 +163,6 @@ static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
>      return trans_slli(ctx, &arg);
>  }
>
> -static bool trans_c_fldsp(DisasContext *ctx, arg_c_fldsp *a)
> -{
> -    arg_fld arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
> -    return trans_fld(ctx, &arg);
> -}
> -
> -static bool trans_c_lwsp(DisasContext *ctx, arg_c_lwsp *a)
> -{
> -    arg_lw arg = { .rd = a->rd, .rs1 = 2, .imm = a->uimm };
> -    return trans_lw(ctx, &arg);
> -}

c.lwsp with rd=0 should be an illegal instruction, but it's not.  We'd need to
re-introduce the shim to handle that quirk, but since it's not actually a new
bug I'm OK taking the patch set and fixing that later.

> -
>  static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
>  {
>  #ifdef TARGET_RISCV32
> @@ -321,18 +211,6 @@ static bool trans_c_ebreak_jalr_add(DisasContext *ctx, arg_c_ebreak_jalr_add *a)
>      return false;
>  }
>
> -static bool trans_c_fsdsp(DisasContext *ctx, arg_c_fsdsp *a)
> -{
> -    arg_fsd arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
> -    return trans_fsd(ctx, &arg);
> -}
> -
> -static bool trans_c_swsp(DisasContext *ctx, arg_c_swsp *a)
> -{
> -    arg_sw arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
> -    return trans_sw(ctx, &arg);
> -}
> -
>  static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
>  {
>  #ifdef TARGET_RISCV32
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 7ebd590486..9e016d8e50 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -666,8 +666,19 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rvd.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>
> -/* auto-generated decoder*/
> +/*
> + * Auto-generated decoder.
> + * Note that the 16-bit decoder reuses some of the trans_* functions
> + * initially declared by the 32-bit decoder, which results in duplicate
> + * declaration warnings.  Suppress them.
> + */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wredundant-decls"
> +
>  #include "decode_insn16.inc.c"
> +
> +#pragma GCC diagnostic pop
> +
>  #include "insn_trans/trans_rvc.inc.c"
>
>  static void decode_opc(DisasContext *ctx)
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index 17cc52cf2a..d0cc778bc9 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -40,17 +40,24 @@
>  %imm_lui       12:s1 2:5             !function=ex_shift_12
>
>
> +# Argument sets imported from insn32.decode:
> +&empty                  !extern
> +&r         rd rs1 rs2   !extern
> +&i         imm rs1 rd   !extern
> +&s         imm rs1 rs2  !extern
> +&j         imm rd       !extern
> +&b         imm rs2 rs1  !extern
> +&u         imm rd       !extern
> +&shift     shamt rs1 rd !extern
>
>  # Argument sets:
>  &cl               rs1 rd
>  &cl_dw     uimm   rs1 rd
> -&ci        imm        rd
>  &ciw       nzuimm     rd
>  &cs               rs1 rs2
>  &cs_dw     uimm   rs1 rs2
>  &cb        imm    rs1
>  &cr               rd  rs2
> -&cj       imm
>  &c_shift   shamt      rd
>
>  &c_ld      uimm  rd
> @@ -61,23 +68,24 @@
>  &cfswsp_sdsp    uimm_fswsp uimm_sdsp rs2
>
>  # Formats 16:
> -@cr        ....  ..... .....  .. &cr                      rs2=%rs2_5  %rd
> -@ci        ... . ..... .....  .. &ci     imm=%imm_ci                  %rd
> +@cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
> +@ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
>  @ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
> -@cl_d      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
> -@cl_w      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
> +@cl_d      ... ... ... .. ... .. &i      imm=%uimm_cl_d   rs1=%rs1_3  rd=%rs2_3
> +@cl_w      ... ... ... .. ... .. &i      imm=%uimm_cl_w   rs1=%rs1_3  rd=%rs2_3
>  @cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
>  @cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
> -@cs_2      ... ... ... .. ... .. &cr                      rd=%rs1_3   rs2=%rs2_3
> -@cs_d      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
> -@cs_w      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
> -@cb        ... ... ... .. ... .. &cb     imm=%imm_cb      rs1=%rs1_3
> -@cj        ...    ........... .. &cj     imm=%imm_cj
> +@cs_2      ... ... ... .. ... .. &r      rs2=%rs2_3       rs1=%rs1_3  rd=%rs1_3
> +@cs_d      ... ... ... .. ... .. &s      imm=%uimm_cl_d   rs1=%rs1_3  rs2=%rs2_3
> +@cs_w      ... ... ... .. ... .. &s      imm=%uimm_cl_w   rs1=%rs1_3  rs2=%rs2_3
> +@cj        ...    ........... .. &j      imm=%imm_cj
> +@cb_z      ... ... ... .. ... .. &b      imm=%imm_cb      rs1=%rs1_3  rs2=0
>
> -@c_ld      ... . .....  ..... .. &c_ld     uimm=%uimm_6bit_ld  %rd
> -@c_lw      ... . .....  ..... .. &c_ld     uimm=%uimm_6bit_lw  %rd
> -@c_sd      ... . .....  ..... .. &c_sd     uimm=%uimm_6bit_sd  rs2=%rs2_5
> -@c_sw      ... . .....  ..... .. &c_sd     uimm=%uimm_6bit_sw  rs2=%rs2_5
> +@c_ldsp    ... . .....  ..... .. &i      imm=%uimm_6bit_ld rs1=2 %rd
> +@c_lwsp    ... . .....  ..... .. &i      imm=%uimm_6bit_lw rs1=2 %rd
> +@c_sdsp    ... . .....  ..... .. &s      imm=%uimm_6bit_sd rs1=2 rs2=%rs2_5
> +@c_swsp    ... . .....  ..... .. &s      imm=%uimm_6bit_sw rs1=2 rs2=%rs2_5
> +@c_li      ... . .....  ..... .. &i      imm=%imm_ci rs1=0 %rd
>
>  @c_addi16sp_lui ... .  ..... ..... .. &caddi16sp_lui %imm_lui %imm_addi16sp %rd
>  @c_flwsp_ldsp   ... .  ..... ..... .. &cflwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
> @@ -85,45 +93,47 @@
>  @c_fswsp_sdsp   ... .  ..... ..... .. &cfswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
>      uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
>
> -@c_shift        ... . .. ... ..... .. &c_shift rd=%rs1_3 shamt=%nzuimm_6bit
> -@c_shift2       ... . .. ... ..... .. &c_shift rd=%rd    shamt=%nzuimm_6bit
> +@c_shift        ... . .. ... ..... .. \
> +                &shift rd=%rs1_3 rs1=%rs1_3 shamt=%nzuimm_6bit
> +@c_shift2       ... . .. ... ..... .. \
> +                &shift rd=%rd rs1=%rd shamt=%nzuimm_6bit
>
> -@c_andi         ... . .. ... ..... .. &ci imm=%imm_ci rd=%rs1_3
> +@c_andi         ... . .. ... ..... .. &i imm=%imm_ci rs1=%rs1_3 rd=%rs1_3
>
>  # *** RV64C Standard Extension (Quadrant 0) ***
>  c_addi4spn        000    ........ ... 00 @ciw
> -c_fld             001  ... ... .. ... 00 @cl_d
> -c_lw              010  ... ... .. ... 00 @cl_w
> +fld               001  ... ... .. ... 00 @cl_d
> +lw                010  ... ... .. ... 00 @cl_w
>  c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
> -c_fsd             101  ... ... .. ... 00 @cs_d
> -c_sw              110  ... ... .. ... 00 @cs_w
> +fsd               101  ... ... .. ... 00 @cs_d
> +sw                110  ... ... .. ... 00 @cs_w
>  c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
>
>  # *** RV64C Standard Extension (Quadrant 1) ***
> -c_addi            000 .  .....  ..... 01 @ci
> +addi              000 .  .....  ..... 01 @ci
>  c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
> -c_li              010 .  .....  ..... 01 @ci
> +addi              010 .  .....  ..... 01 @c_li
>  c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
>  c_srli            100 . 00 ...  ..... 01 @c_shift
>  c_srai            100 . 01 ...  ..... 01 @c_shift
> -c_andi            100 . 10 ...  ..... 01 @c_andi
> -c_sub             100 0 11 ... 00 ... 01 @cs_2
> -c_xor             100 0 11 ... 01 ... 01 @cs_2
> -c_or              100 0 11 ... 10 ... 01 @cs_2
> -c_and             100 0 11 ... 11 ... 01 @cs_2
> +andi              100 . 10 ...  ..... 01 @c_andi
> +sub               100 0 11 ... 00 ... 01 @cs_2
> +xor               100 0 11 ... 01 ... 01 @cs_2
> +or                100 0 11 ... 10 ... 01 @cs_2
> +and               100 0 11 ... 11 ... 01 @cs_2
>  c_subw            100 1 11 ... 00 ... 01 @cs_2
>  c_addw            100 1 11 ... 01 ... 01 @cs_2
> -c_j               101     ........... 01 @cj
> -c_beqz            110  ... ...  ..... 01 @cb
> -c_bnez            111  ... ...  ..... 01 @cb
> +jal               101     ........... 01 @cj    rd=0  # C.J
> +beq               110  ... ...  ..... 01 @cb_z
> +bne               111  ... ...  ..... 01 @cb_z
>
>  # *** RV64C Standard Extension (Quadrant 2) ***
>  c_slli            000 .  .....  ..... 10 @c_shift2
> -c_fldsp           001 .  .....  ..... 10 @c_ld
> -c_lwsp            010 .  .....  ..... 10 @c_lw
> +fld               001 .  .....  ..... 10 @c_ldsp
> +lw                010 .  .....  ..... 10 @c_lwsp
>  c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
>  c_jr_mv           100 0  .....  ..... 10 @cr
>  c_ebreak_jalr_add 100 1  .....  ..... 10 @cr
> -c_fsdsp           101   ......  ..... 10 @c_sd
> -c_swsp            110 .  .....  ..... 10 @c_sw
> +fsd               101   ......  ..... 10 @c_sdsp
> +sw                110 .  .....  ..... 10 @c_swsp
>  c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
