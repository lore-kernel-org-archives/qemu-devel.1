Received: from eggs.gnu.org ([209.51.188.92]:44425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrE-0000ho-QC
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrC-0001wl-UL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:20 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJgrA-0001ft-VE
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:18 -0400
Received: by mail-pf1-x442.google.com with SMTP id 188so127511pfd.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:04:14 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:04:11 -0700 (PDT)
In-Reply-To: <20190401031155.21293-5-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-f65ff93d-20e5-4c4a-919a-c311ae97649d@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 4/8] target/riscv: Merge argument
 decode for RVC shifti
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

On Sun, 31 Mar 2019 20:11:51 PDT (-0700), richard.henderson@linaro.org wrote:
> Special handling for IMM==0 is the only difference between
> RVC shifti and RVI shifti.  This can be handled with !function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/insn_trans/trans_rvc.inc.c | 47 -------------------------
>  target/riscv/translate.c                |  6 ++++
>  target/riscv/insn16.decode              | 12 +++----
>  3 files changed, 12 insertions(+), 53 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
> index dfb46a2348..691b1e2725 100644
> --- a/target/riscv/insn_trans/trans_rvc.inc.c
> +++ b/target/riscv/insn_trans/trans_rvc.inc.c
> @@ -97,37 +97,6 @@ static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a)
>      return false;
>  }
>
> -static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a)
> -{
> -    int shamt = a->shamt;
> -    if (shamt == 0) {
> -        /* For RV128 a shamt of 0 means a shift by 64 */
> -        shamt = 64;
> -    }
> -    /* Ensure, that shamt[5] is zero for RV32 */
> -    if (shamt >= TARGET_LONG_BITS) {
> -        return false;
> -    }
> -
> -    arg_srli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
> -    return trans_srli(ctx, &arg);
> -}
> -
> -static bool trans_c_srai(DisasContext *ctx, arg_c_srai *a)
> -{
> -    int shamt = a->shamt;
> -    if (shamt == 0) {
> -        /* For RV128 a shamt of 0 means a shift by 64 */
> -        shamt = 64;
> -    }
> -    /* Ensure, that shamt[5] is zero for RV32 */
> -    if (shamt >= TARGET_LONG_BITS) {
> -        return false;
> -    }
> -
> -    arg_srai arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
> -    return trans_srai(ctx, &arg);
> -}
>
>  static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
>  {
> @@ -147,22 +116,6 @@ static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
>  #endif
>  }
>
> -static bool trans_c_slli(DisasContext *ctx, arg_c_slli *a)
> -{
> -    int shamt = a->shamt;
> -    if (shamt == 0) {
> -        /* For RV128 a shamt of 0 means a shift by 64 */
> -        shamt = 64;
> -    }
> -    /* Ensure, that shamt[5] is zero for RV32 */
> -    if (shamt >= TARGET_LONG_BITS) {
> -        return false;
> -    }
> -
> -    arg_slli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
> -    return trans_slli(ctx, &arg);
> -}
> -
>  static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
>  {
>  #ifdef TARGET_RISCV32
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9e016d8e50..a1cd29f80f 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -538,6 +538,12 @@ static int ex_rvc_register(int reg)
>      return 8 + reg;
>  }
>
> +static int ex_rvc_shifti(int imm)
> +{
> +    /* For RV128 a shamt of 0 means a shift by 64. */
> +    return imm ? imm : 64;
> +}
> +
>  /* Include the auto-generated decoder for 32 bit insn */
>  #include "decode_insn32.inc.c"
>
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index d0cc778bc9..add9cf3923 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -30,7 +30,7 @@
>  %imm_cb        12:s1 5:2 2:1 10:2 3:2 !function=ex_shift_1
>  %imm_cj        12:s1 8:1 9:2 6:1 7:1 2:1 11:1 3:3 !function=ex_shift_1
>
> -%nzuimm_6bit   12:1 2:5
> +%shimm_6bit   12:1 2:5               !function=ex_rvc_shifti
>  %uimm_6bit_ld 2:3 12:1 5:2           !function=ex_shift_3
>  %uimm_6bit_lw 2:2 12:1 4:3           !function=ex_shift_2
>  %uimm_6bit_sd 7:3 10:3               !function=ex_shift_3
> @@ -94,9 +94,9 @@
>      uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
>
>  @c_shift        ... . .. ... ..... .. \
> -                &shift rd=%rs1_3 rs1=%rs1_3 shamt=%nzuimm_6bit
> +                &shift rd=%rs1_3 rs1=%rs1_3 shamt=%shimm_6bit
>  @c_shift2       ... . .. ... ..... .. \
> -                &shift rd=%rd rs1=%rd shamt=%nzuimm_6bit
> +                &shift rd=%rd rs1=%rd shamt=%shimm_6bit
>
>  @c_andi         ... . .. ... ..... .. &i imm=%imm_ci rs1=%rs1_3 rd=%rs1_3
>
> @@ -114,8 +114,8 @@ addi              000 .  .....  ..... 01 @ci
>  c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
>  addi              010 .  .....  ..... 01 @c_li
>  c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
> -c_srli            100 . 00 ...  ..... 01 @c_shift
> -c_srai            100 . 01 ...  ..... 01 @c_shift
> +srli              100 . 00 ...  ..... 01 @c_shift
> +srai              100 . 01 ...  ..... 01 @c_shift
>  andi              100 . 10 ...  ..... 01 @c_andi
>  sub               100 0 11 ... 00 ... 01 @cs_2
>  xor               100 0 11 ... 01 ... 01 @cs_2
> @@ -128,7 +128,7 @@ beq               110  ... ...  ..... 01 @cb_z
>  bne               111  ... ...  ..... 01 @cb_z
>
>  # *** RV64C Standard Extension (Quadrant 2) ***
> -c_slli            000 .  .....  ..... 10 @c_shift2
> +slli              000 .  .....  ..... 10 @c_shift2

This is another one where rd=0 is illegal in the compressed ISA, but again we
don't appear to handle these correctly before the cleanups.

>  fld               001 .  .....  ..... 10 @c_ldsp
>  lw                010 .  .....  ..... 10 @c_lwsp
>  c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
