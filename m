Received: from eggs.gnu.org ([2001:4830:134:3::10]:35853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEvlW-0003mt-Ps
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEvlT-0002Xy-15
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:26:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEvlR-0002Ux-1i
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:26:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so581994wrv.6
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 05:26:23 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c6ccdcc-8456-5243-8211-64c81610fb67@redhat.com>
Date: Tue, 23 Oct 2018 14:26:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/7] target/riscv: Convert @cs_2 insns to
 share translation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 23/10/18 14:04, Richard Henderson wrote:
> These all expand simply to R format instructions.
> ---
>   target/riscv/insn_trans/trans_rvc.inc.c | 36 -------------------------
>   target/riscv/translate.c                | 20 +++++++++++---
>   target/riscv/insn16.decode              | 17 +++++++-----
>   3 files changed, 26 insertions(+), 47 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
> index 7e2668c03d..152c1c9bca 100644
> --- a/target/riscv/insn_trans/trans_rvc.inc.c
> +++ b/target/riscv/insn_trans/trans_rvc.inc.c
> @@ -176,42 +176,6 @@ static bool trans_c_andi(DisasContext *ctx, arg_c_andi *a)
>       return trans_andi(ctx, &arg);
>   }
>   
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
> -static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
> -{
> -    arg_subw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -    return trans_subw(ctx, &arg);
> -}
> -
> -static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
> -{
> -    arg_addw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
> -    return trans_addw(ctx, &arg);
> -}
> -
>   static bool trans_c_j(DisasContext *ctx, arg_c_j *a)
>   {
>       arg_jal arg = { .rd = 0, .imm = a->imm };
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index e7fe8720ac..f4d2a56f9a 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -322,10 +322,25 @@ static int ex_rvc_register(int reg)
>       return 8 + reg;
>   }
>   
> +/*
> + * Include the auto-generated decoders.
> + * Note that the 16-bit decoder reuses some of the trans_* functions
> + * from the 32-bit decoder, which results in duplicate declarations
> + * of the relevant helpers.  Suppress the warning.
> + */
>   bool decode_insn32(DisasContext *ctx, uint32_t insn);
> -/* Include the auto-generated decoder for 32 bit insn */
> +bool decode_insn16(DisasContext *ctx, uint16_t insn);
> +
>   #include "decode_insn32.inc.c"
>   
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wredundant-decls"

We might move that to a generic Makefile rule, this will be useful for 
other archs.

Something like:

translate*.o: CPPFLAGS += -Wno-redundant-decls

> +
> +#include "decode_insn16.inc.c"
> +
> +#pragma GCC diagnostic pop
> +
> +
>   static bool gen_arith_imm(DisasContext *ctx, arg_i *a,
>                             void(*func)(TCGv, TCGv, TCGv))
>   {
> @@ -410,9 +425,6 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>   #include "insn_trans/trans_rvd.inc.c"
>   #include "insn_trans/trans_privileged.inc.c"
>   
> -bool decode_insn16(DisasContext *ctx, uint16_t insn);
> -/* auto-generated decoder*/
> -#include "decode_insn16.inc.c"
>   #include "insn_trans/trans_rvc.inc.c"
>   
>   static void decode_opc(DisasContext *ctx)
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index 138290c450..16525486ae 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -39,6 +39,9 @@
>   %imm_addi16sp  12:s1 3:2 5:1 2:1 6:1 !function=ex_shift_4
>   %imm_lui       12:s1 2:5             !function=ex_shift_12
>   
> +# Argument sets imported from insn32.decode:
> +&r         rd rs1 rs2   !extern
> +
>   # Argument sets:
>   &cl               rs1 rd
>   &cl_dw     uimm   rs1 rd
> @@ -65,7 +68,7 @@
>   @cl_w      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
>   @cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
>   @cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
> -@cs_2      ... ... ... .. ... .. &cr                      rd=%rs1_3   rs2=%rs2_3
> +@cs_2      ... ... ... .. ... .. &r      rd=%rs1_3 rs1=%rs1_3 rs2=%rs2_3
>   @cs_d      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
>   @cs_w      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
>   @cb        ... ... ... .. ... .. &cb     imm=%imm_cb      rs1=%rs1_3
> @@ -104,12 +107,12 @@ c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
>   c_srli            100 . 00 ...  ..... 01 @c_shift
>   c_srai            100 . 01 ...  ..... 01 @c_shift
>   c_andi            100 . 10 ...  ..... 01 @c_andi
> -c_sub             100 0 11 ... 00 ... 01 @cs_2
> -c_xor             100 0 11 ... 01 ... 01 @cs_2
> -c_or              100 0 11 ... 10 ... 01 @cs_2
> -c_and             100 0 11 ... 11 ... 01 @cs_2
> -c_subw            100 1 11 ... 00 ... 01 @cs_2
> -c_addw            100 1 11 ... 01 ... 01 @cs_2
> +sub               100 0 11 ... 00 ... 01 @cs_2
> +xor               100 0 11 ... 01 ... 01 @cs_2
> +or                100 0 11 ... 10 ... 01 @cs_2
> +and               100 0 11 ... 11 ... 01 @cs_2
> +subw              100 1 11 ... 00 ... 01 @cs_2
> +addw              100 1 11 ... 01 ... 01 @cs_2
>   c_j               101     ........... 01 @cj
>   c_beqz            110  ... ...  ..... 01 @cb
>   c_bnez            111  ... ...  ..... 01 @cb
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
