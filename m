Received: from eggs.gnu.org ([2001:4830:134:3::10]:36323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEvms-0004RZ-Un
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEvmp-00045R-KZ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:27:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEvmp-00043h-C1
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:27:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id i4-v6so1466459wrr.13
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 05:27:50 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <83838e55-e621-b761-424d-cb951eff56d4@redhat.com>
Date: Tue, 23 Oct 2018 14:27:48 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/7] target/riscv: Convert @cl_d, @cl_w,
 @cs_d, @cs_w insns
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

With S-o-b:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

On 23/10/18 14:04, Richard Henderson wrote:
> ---
>   target/riscv/insn_trans/trans_rvc.inc.c | 34 +++----------------------
>   target/riscv/insn16.decode              | 18 +++++++------
>   target/riscv/insn32.decode              |  3 ++-
>   3 files changed, 16 insertions(+), 39 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
> index 152c1c9bca..c5ffb3bf7c 100644
> --- a/target/riscv/insn_trans/trans_rvc.inc.c
> +++ b/target/riscv/insn_trans/trans_rvc.inc.c
> @@ -28,18 +28,6 @@ static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
>       return trans_addi(ctx, &arg);
>   }
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
>   static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
>   {
>   #ifdef TARGET_RISCV32
> @@ -50,25 +38,12 @@ static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
>       return trans_flw(ctx, &arg, insn);
>   #else
>       /* C.LD ( RV64C/RV128C-only ) */
> -    arg_c_fld tmp;
> +    arg_i tmp;
>       extract_cl_d(&tmp, 0); // FIXME
> -    arg_ld arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
> -    return trans_ld(ctx, &arg);
> +    return trans_ld(ctx, &tmp);
>   #endif
>   }
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
>   static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
>   {
>   #ifdef TARGET_RISCV32
> @@ -79,10 +54,9 @@ static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
>       return trans_fsw(ctx, &arg, insn);
>   #else
>       /* C.SD ( RV64C/RV128C-only ) */
> -    arg_c_fsd tmp;
> +    arg_s tmp;
>       extract_cs_d(&tmp, 0); // FIXME
> -    arg_sd arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
> -    return trans_sd(ctx, &arg);
> +    return trans_sd(ctx, &tmp);
>   #endif
>   }
>   
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index 16525486ae..73b385ad19 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -41,6 +41,8 @@
>   
>   # Argument sets imported from insn32.decode:
>   &r         rd rs1 rs2   !extern
> +&i         imm rs1 rd   !extern
> +&s         imm rs1 rs2  !extern
>   
>   # Argument sets:
>   &cl               rs1 rd
> @@ -64,13 +66,13 @@
>   @cr        ....  ..... .....  .. &cr                      rs2=%rs2_5  %rd
>   @ci        ... . ..... .....  .. &ci     imm=%imm_ci                  %rd
>   @ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
> -@cl_d      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
> -@cl_w      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
> +@cl_d      ... ... ... .. ... .. &i  imm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
> +@cl_w      ... ... ... .. ... .. &i  imm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
>   @cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
>   @cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
>   @cs_2      ... ... ... .. ... .. &r      rd=%rs1_3 rs1=%rs1_3 rs2=%rs2_3
> -@cs_d      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
> -@cs_w      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
> +@cs_d      ... ... ... .. ... .. &s  imm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
> +@cs_w      ... ... ... .. ... .. &s  imm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
>   @cb        ... ... ... .. ... .. &cb     imm=%imm_cb      rs1=%rs1_3
>   @cj        ...    ........... .. &c_j    imm=%imm_cj
>   
> @@ -92,11 +94,11 @@
>   
>   # *** RV64C Standard Extension (Quadrant 0) ***
>   c_addi4spn        000    ........ ... 00 @ciw
> -c_fld             001  ... ... .. ... 00 @cl_d
> -c_lw              010  ... ... .. ... 00 @cl_w
> +fld               001  ... ... .. ... 00 @cl_d
> +lw                010  ... ... .. ... 00 @cl_w
>   c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
> -c_fsd             101  ... ... .. ... 00 @cs_d
> -c_sw              110  ... ... .. ... 00 @cs_w
> +fsd               101  ... ... .. ... 00 @cs_d
> +sw                110  ... ... .. ... 00 @cs_w
>   c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
>   
>   # *** RV64C Standard Extension (Quadrant 1) ***
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 77e093a060..e1fccc57c6 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -40,6 +40,7 @@
>   # Argument sets:
>   &b         imm rs2 rs1
>   &i         imm rs1 rd
> +&s         imm rs2 rs1
>   &r         rd rs1 rs2
>   &shift     shamt rs1 rd
>   &atomic    aq rl rs2 rs1 rd
> @@ -49,7 +50,7 @@
>   @r       .......   ..... ..... ... ..... ....... &r    %rs2 %rs1 %rd
>   @i       ............    ..... ... ..... ....... &i    imm=%imm_i %rs1 %rd
>   @b       .......   ..... ..... ... ..... ....... &b    imm=%imm_b %rs2 %rs1
> -@s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
> +@s       .......   ..... ..... ... ..... ....... &s    imm=%imm_s %rs2 %rs1
>   @u       ....................      ..... .......         imm=%imm_u          %rd
>   @j       ....................      ..... .......         imm=%imm_j          %rd
>   
> 
