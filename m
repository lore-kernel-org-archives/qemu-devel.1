Received: from eggs.gnu.org ([2001:4830:134:3::10]:60759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEvdB-00009M-DL
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEvd6-0002yo-On
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:17:53 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEvd6-0002r7-Af
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:17:48 -0400
Received: by mail-wr1-f49.google.com with SMTP id d2-v6so1449926wro.7
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 05:17:44 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f83baed8-35fe-62f1-29e4-f1c1300a198e@redhat.com>
Date: Tue, 23 Oct 2018 14:17:40 +0200
MIME-Version: 1.0
In-Reply-To: <20181023120454.28553-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/riscv: Splice decodetree inputs
 for riscv32 vs riscv64
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
> This primarily solves the case for RVC that several insns are
> completely different, decode and all, between the two.  But it
> also means that we need less ifdefing for RV{I,M,A,F,D}.

Lovely!

Probably due to the jet lag you forgot your S-o-b :p
With it:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   target/riscv/insn_trans/trans_rva.inc.c | 46 +---------------
>   target/riscv/insn_trans/trans_rvc.inc.c | 71 -------------------------
>   target/riscv/insn_trans/trans_rvd.inc.c | 26 +--------
>   target/riscv/insn_trans/trans_rvf.inc.c | 18 +------
>   target/riscv/insn_trans/trans_rvi.inc.c | 49 +++--------------
>   target/riscv/insn_trans/trans_rvm.inc.c | 22 +-------
>   target/riscv/Makefile.objs              | 23 ++++++--
>   target/riscv/insn16-32.decode           | 31 +++++++++++
>   target/riscv/insn16-64.decode           | 33 ++++++++++++
>   target/riscv/insn16.decode              | 24 +++------
>   target/riscv/insn32.decode              | 53 +-----------------
>   target/riscv/insn64.decode              | 71 +++++++++++++++++++++++++
>   12 files changed, 176 insertions(+), 291 deletions(-)
>   create mode 100644 target/riscv/insn16-32.decode
>   create mode 100644 target/riscv/insn16-64.decode
>   create mode 100644 target/riscv/insn64.decode
> 
> diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
> index e658bf32c4..e63d8a5127 100644
> --- a/target/riscv/insn_trans/trans_rva.inc.c
> +++ b/target/riscv/insn_trans/trans_rva.inc.c
> @@ -144,101 +144,59 @@ static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
>   }
>   
> +#ifdef TARGET_RISCV64
>   static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_lr(ctx, a, MO_ALIGN | MO_TEQ);
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_sc(ctx, a, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEQ));
> -#else
> -    return false;
> -#endif
>   }
> +#endif /* TARGET_RISCV64 */
> diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
> index c5ffb3bf7c..e77bcdb2c6 100644
> --- a/target/riscv/insn_trans/trans_rvc.inc.c
> +++ b/target/riscv/insn_trans/trans_rvc.inc.c
> @@ -28,38 +28,6 @@ static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
>       return trans_addi(ctx, &arg);
>   }
>   
> -static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
> -{
> -#ifdef TARGET_RISCV32
> -    /* C.FLW ( RV32FC-only ) */
> -    arg_c_lw tmp;
> -    extract_cl_w(&tmp, insn);
> -    arg_flw arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
> -    return trans_flw(ctx, &arg, insn);
> -#else
> -    /* C.LD ( RV64C/RV128C-only ) */
> -    arg_i tmp;
> -    extract_cl_d(&tmp, 0); // FIXME
> -    return trans_ld(ctx, &tmp);
> -#endif
> -}
> -
> -static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
> -{
> -#ifdef TARGET_RISCV32
> -    /* C.FSW ( RV32FC-only ) */
> -    arg_c_sw tmp;
> -    extract_cs_w(&tmp, insn);
> -    arg_fsw arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
> -    return trans_fsw(ctx, &arg, insn);
> -#else
> -    /* C.SD ( RV64C/RV128C-only ) */
> -    arg_s tmp;
> -    extract_cs_d(&tmp, 0); // FIXME
> -    return trans_sd(ctx, &tmp);
> -#endif
> -}
> -
>   static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a)
>   {
>       if (a->imm == 0) {
> @@ -70,19 +38,6 @@ static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a)
>       return trans_addi(ctx, &arg);
>   }
>   
> -static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
> -{
> -#ifdef TARGET_RISCV32
> -    /* C.JAL */
> -    arg_jal arg = { .rd = 1, .imm = a->imm };
> -    return trans_jal(ctx, &arg, insn);
> -#else
> -    /* C.ADDIW */
> -    arg_addiw arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
> -    return trans_addiw(ctx, &arg);
> -#endif
> -}
> -
>   static bool trans_c_li(DisasContext *ctx, arg_c_li *a)
>   {
>       if (a->rd == 0) {
> @@ -196,20 +151,6 @@ static bool trans_c_lwsp(DisasContext *ctx, arg_c_lwsp *a)
>       return trans_lw(ctx, &arg);
>   }
>   
> -static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
> -{
> -#ifdef TARGET_RISCV32
> -    /* C.FLWSP */
> -    arg_flw arg_flw = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_flwsp };
> -    return trans_flw(ctx, &arg_flw);
> -#else
> -    /* C.LDSP */
> -    arg_ld arg_ld = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_ldsp };
> -    return trans_ld(ctx, &arg_ld);
> -#endif
> -    return false;
> -}
> -
>   static bool trans_c_jr_mv(DisasContext *ctx, arg_c_jr_mv *a)
>   {
>       if (a->rd != 0 && a->rs2 == 0) {
> @@ -255,15 +196,3 @@ static bool trans_c_swsp(DisasContext *ctx, arg_c_swsp *a)
>       arg_sw arg = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm };
>       return trans_sw(ctx, &arg);
>   }
> -
> -static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
> -{
> -#ifdef TARGET_RISCV32
> -    /* C.FSWSP */
> -    arg_fsw a_fsw = { .rs1 = a->rs2, .rs2 = 2, .imm = a->uimm_fswsp };
> -    return trans_fsw(ctx, &a_fsw, insn);
> -#endif
> -    /* C.SDSP */
> -    arg_sd a_sd = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_sdsp };
> -    return trans_sd(ctx, &a_sd);
> -}
> diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
> index 4b2face7c5..fab6621d08 100644
> --- a/target/riscv/insn_trans/trans_rvd.inc.c
> +++ b/target/riscv/insn_trans/trans_rvd.inc.c
> @@ -318,9 +318,9 @@ static bool trans_fcvt_d_wu(DisasContext *ctx, arg_fcvt_d_wu *a)
>       return true;
>   }
>   
> +#ifdef TARGET_RISCV64
>   static bool trans_fcvt_l_d(DisasContext *ctx, arg_fcvt_l_d *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -328,15 +328,11 @@ static bool trans_fcvt_l_d(DisasContext *ctx, arg_fcvt_l_d *a)
>       gen_helper_fcvt_l_d(t0, cpu_env, cpu_fpr[a->rs1]);
>       gen_set_gpr(a->rd, t0);
>       tcg_temp_free(t0);
> -#else
> -    gen_exception_illegal(ctx);
> -#endif
>       return true;
>   }
>   
>   static bool trans_fcvt_lu_d(DisasContext *ctx, arg_fcvt_lu_d *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -344,27 +340,19 @@ static bool trans_fcvt_lu_d(DisasContext *ctx, arg_fcvt_lu_d *a)
>       gen_helper_fcvt_lu_d(t0, cpu_env, cpu_fpr[a->rs1]);
>       gen_set_gpr(a->rd, t0);
>       tcg_temp_free(t0);
> -#else
> -    gen_exception_illegal(ctx);
> -#endif
>       return true;
>   }
>   
>   static bool trans_fmv_x_d(DisasContext *ctx, arg_fmv_x_d *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       gen_set_gpr(a->rd, cpu_fpr[a->rs1]);
> -#else
> -    gen_exception_illegal(ctx);
> -#endif
>       return true;
>   }
>   
>   static bool trans_fcvt_d_l(DisasContext *ctx, arg_fcvt_d_l *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -373,15 +361,11 @@ static bool trans_fcvt_d_l(DisasContext *ctx, arg_fcvt_d_l *a)
>       gen_set_rm(ctx, a->rm);
>       gen_helper_fcvt_d_l(cpu_fpr[a->rd], cpu_env, t0);
>       tcg_temp_free(t0);
> -#else
> -    gen_exception_illegal(ctx);
> -#endif
>       return true;
>   }
>   
>   static bool trans_fcvt_d_lu(DisasContext *ctx, arg_fcvt_d_lu *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -390,15 +374,11 @@ static bool trans_fcvt_d_lu(DisasContext *ctx, arg_fcvt_d_lu *a)
>       gen_set_rm(ctx, a->rm);
>       gen_helper_fcvt_d_lu(cpu_fpr[a->rd], cpu_env, t0);
>       tcg_temp_free(t0);
> -#else
> -    gen_exception_illegal(ctx);
> -#endif
>       return true;
>   }
>   
>   static bool trans_fmv_d_x(DisasContext *ctx, arg_fmv_d_x *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -406,8 +386,6 @@ static bool trans_fmv_d_x(DisasContext *ctx, arg_fmv_d_x *a)
>   
>       tcg_gen_mov_tl(cpu_fpr[a->rd], t0);
>       tcg_temp_free(t0);
> -#else
> -    gen_exception_illegal(ctx);
> -#endif
>       return true;
>   }
> +#endif /* TARGET_RISCV64 */
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> index 6f055e77bf..0007cf0980 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -333,9 +333,9 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
>       return true;
>   }
>   
> +#ifdef TARGET_RISCV64
>   static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -344,14 +344,10 @@ static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)
>       gen_set_gpr(a->rd, t0);
>       tcg_temp_free(t0);
>       return true;
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -360,14 +356,10 @@ static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)
>       gen_set_gpr(a->rd, t0);
>       tcg_temp_free(t0);
>       return true;
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -378,14 +370,10 @@ static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a)
>   
>       tcg_temp_free(t0);
>       return true;
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a)
>   {
> -#if defined(TARGET_RISCV64)
>       REQUIRE_FPU;
>   
>       TCGv t0 = tcg_temp_new();
> @@ -396,7 +384,5 @@ static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a)
>   
>       tcg_temp_free(t0);
>       return true;
> -#else
> -    return false;
> -#endif
>   }
> +#endif /* TARGET_RISCV64 */
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 7e676fe2e4..16bfd23739 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -168,23 +168,17 @@ static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
>       return gen_load(ctx, a, MO_TEUW);
>   }
>   
> +#ifdef TARGET_RISCV64
>   static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_load(ctx, a, MO_TEUL);
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_ld(DisasContext *ctx, arg_ld *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_load(ctx, a, MO_TEQ);
> -#else
> -    return false;
> -#endif
>   }
> +#endif /* TARGET_RISCV64 */
>   
>   static bool gen_store(DisasContext *ctx, arg_sb *a, int memop)
>   {
> @@ -216,14 +210,12 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
>       return gen_store(ctx, a, MO_TESL);
>   }
>   
> +#ifdef TARGET_RISCV64
>   static bool trans_sd(DisasContext *ctx, arg_sd *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_store(ctx, a, MO_TEQ);
> -#else
> -    return false;
> -#endif
>   }
> +#endif
>   
>   static bool trans_addi(DisasContext *ctx, arg_addi *a)
>   {
> @@ -387,20 +379,16 @@ static bool trans_and(DisasContext *ctx, arg_and *a)
>       return gen_arith(ctx, a, &tcg_gen_and_tl);
>   }
>   
> +#ifdef TARGET_RISCV64
>   static bool trans_addiw(DisasContext *ctx, arg_addiw *a)
>   {
> -#ifdef TARGET_RISCV64
>       bool res = gen_arith_imm(ctx, a, &tcg_gen_add_tl);
>       tcg_gen_ext32s_tl(cpu_gpr[a->rd], cpu_gpr[a->rd]);
>       return res;
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_slliw(DisasContext *ctx, arg_slliw *a)
>   {
> -#ifdef TARGET_RISCV64
>       TCGv source1;
>       source1 = tcg_temp_new();
>       gen_get_gpr(source1, a->rs1);
> @@ -411,14 +399,10 @@ static bool trans_slliw(DisasContext *ctx, arg_slliw *a)
>   
>       tcg_temp_free(source1);
>       return true;
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_srliw(DisasContext *ctx, arg_srliw *a)
>   {
> -#ifdef TARGET_RISCV64
>       TCGv t = tcg_temp_new();
>       gen_get_gpr(t, a->rs1);
>       tcg_gen_extract_tl(t, t, a->shamt, 32 - a->shamt);
> @@ -427,14 +411,10 @@ static bool trans_srliw(DisasContext *ctx, arg_srliw *a)
>       gen_set_gpr(a->rd, t);
>       tcg_temp_free(t);
>       return true;
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
>   {
> -#ifdef TARGET_RISCV64
>       TCGv t = tcg_temp_new();
>       gen_get_gpr(t, a->rs1);
>       tcg_gen_sextract_tl(t, t, a->shamt, 32 - a->shamt);
> @@ -443,32 +423,20 @@ static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
>       gen_set_gpr(a->rd, t);
>       tcg_temp_free(t);
>       return true;
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_addw(DisasContext *ctx, arg_addw *a)
>   {
> -#if !defined(TARGET_RISCV64)
> -    return false;
> -#endif
>       return gen_arith(ctx, a, &tcg_gen_add_tl);
>   }
>   
>   static bool trans_subw(DisasContext *ctx, arg_subw *a)
>   {
> -#if !defined(TARGET_RISCV64)
> -    return false;
> -#endif
>       return gen_arith(ctx, a, &tcg_gen_sub_tl);
>   }
>   
>   static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
>   {
> -#if !defined(TARGET_RISCV64)
> -    return false;
> -#endif
>       TCGv source1 = tcg_temp_new();
>       TCGv source2 = tcg_temp_new();
>   
> @@ -486,9 +454,6 @@ static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
>   
>   static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
>   {
> -#if !defined(TARGET_RISCV64)
> -    return false;
> -#endif
>       TCGv source1 = tcg_temp_new();
>       TCGv source2 = tcg_temp_new();
>   
> @@ -508,9 +473,6 @@ static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
>   
>   static bool trans_sraw(DisasContext *ctx, arg_sraw *a)
>   {
> -#if !defined(TARGET_RISCV64)
> -    return false;
> -#endif
>       TCGv source1 = tcg_temp_new();
>       TCGv source2 = tcg_temp_new();
>   
> @@ -528,6 +490,7 @@ static bool trans_sraw(DisasContext *ctx, arg_sraw *a)
>       tcg_temp_free(source2);
>       return true;
>   }
> +#endif /* TARGET_RISCV64 */
>   
>   static bool trans_fence(DisasContext *ctx, arg_fence *a)
>   {
> diff --git a/target/riscv/insn_trans/trans_rvm.inc.c b/target/riscv/insn_trans/trans_rvm.inc.c
> index 7809bcb187..ee0ff4deb9 100644
> --- a/target/riscv/insn_trans/trans_rvm.inc.c
> +++ b/target/riscv/insn_trans/trans_rvm.inc.c
> @@ -79,47 +79,29 @@ static bool trans_remu(DisasContext *ctx, arg_remu *a)
>       return gen_arith(ctx, a, &gen_remu);
>   }
>   
> +#ifdef TARGET_RISCV64
>   static bool trans_mulw(DisasContext *ctx, arg_mulw *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_arith(ctx, a, &tcg_gen_mul_tl);
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_divw(DisasContext *ctx, arg_divw *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_arith_w(ctx, a, &gen_div);
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_divuw(DisasContext *ctx, arg_divuw *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_arith_w(ctx, a, &gen_divu);
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_remw(DisasContext *ctx, arg_remw *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_arith_w(ctx, a, &gen_rem);
> -#else
> -    return false;
> -#endif
>   }
>   
>   static bool trans_remuw(DisasContext *ctx, arg_remuw *a)
>   {
> -#ifdef TARGET_RISCV64
>       return gen_arith_w(ctx, a, &gen_remu);
> -#else
> -    return false;
> -#endif
>   }
> +#endif /* TARGET_RISCV64 */
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index ec7326f1c7..45cc2e8c8a 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -2,14 +2,29 @@ obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
>   
>   DECODETREE = $(SRC_PATH)/scripts/decodetree.py
>   
> -target/riscv/decode_insn32.inc.c: \
> -  $(SRC_PATH)/target/riscv/insn32.decode $(DECODETREE)
> +decode32-y = $(SRC_PATH)/target/riscv/insn32.decode
> +decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn64.decode
> +
> +decode16-y = $(SRC_PATH)/target/riscv/insn16.decode
> +decode16-$(TARGET_RISCV32) += $(SRC_PATH)/target/riscv/insn16-32.decode
> +decode16-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn16-64.decode
> +
> +target/riscv/insn32.decode: $(decode32-y)
> +	$(call quiet-command, \
> +	  cat $(decode32-y) > target/riscv/insn32.decode, \
> +          "CAT", $(TARGET_DIR)$@)
> +
> +target/riscv/insn16.decode: $(decode16-y)
> +	$(call quiet-command, \
> +	  cat $(decode16-y) > target/riscv/insn16.decode, \
> +          "CAT", $(TARGET_DIR)$@)
> +
> +target/riscv/decode_insn32.inc.c: target/riscv/insn32.decode $(DECODETREE)
>   	$(call quiet-command, \
>   	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $<, \
>   	  "GEN", $(TARGET_DIR)$@)
>   
> -target/riscv/decode_insn16.inc.c: \
> -  $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
> +target/riscv/decode_insn16.inc.c: target/riscv/insn16.decode $(DECODETREE)
>   	$(call quiet-command, \
>   	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 $<, \
>   	  "GEN", $(TARGET_DIR)$@)
> diff --git a/target/riscv/insn16-32.decode b/target/riscv/insn16-32.decode
> new file mode 100644
> index 0000000000..efb7f5bdc8
> --- /dev/null
> +++ b/target/riscv/insn16-32.decode
> @@ -0,0 +1,31 @@
> +#
> +# RISC-V translation routines for the RVC Instruction Set.
> +#
> +# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
> +#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms and conditions of the GNU General Public License,
> +# version 2 or later, as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope it will be useful, but WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +# more details.
> +#
> +# You should have received a copy of the GNU General Public License along with
> +# this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +# This is concatenated with insn16.decode for risc32 targets.
> +# All of the fields and formats are there.
> +
> +# *** RV32C Standard Extension (Quadrant 0) ***
> +flw     011 ... ... .. ... 00   @cl_w
> +fsw     111 ... ... .. ... 00   @cs_w
> +
> +# *** RV32C Standard Extension (Quadrant 1) ***
> +jal     001 ......   ..... 01   &j imm=%imm_cj rd=1
> +
> +# *** RV32C Standard Extension (Quadrant 2) ***
> +flw     011 . .....  ..... 10   &i imm=%uimm_6bit_lw %rd rs1=2
> +fsw     111 ......   ..... 10   &s imm=%uimm_6bit_sw rs2=%rs2_5 rs1=2
> diff --git a/target/riscv/insn16-64.decode b/target/riscv/insn16-64.decode
> new file mode 100644
> index 0000000000..163fd5014a
> --- /dev/null
> +++ b/target/riscv/insn16-64.decode
> @@ -0,0 +1,33 @@
> +#
> +# RISC-V translation routines for the RVC Instruction Set.
> +#
> +# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
> +#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms and conditions of the GNU General Public License,
> +# version 2 or later, as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope it will be useful, but WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +# more details.
> +#
> +# You should have received a copy of the GNU General Public License along with
> +# this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +# This is concatenated with insn16.decode for risc64 targets.
> +# All of the fields and formats are there.
> +
> +# *** RV64C Standard Extension (Quadrant 0) ***
> +ld      011  ... ... .. ... 00 @cl_d
> +sd      111  ... ... .. ... 00 @cs_d
> +
> +# *** RV64C Standard Extension (Quadrant 1) ***
> +addiw   001 .  .....  ..... 01 @ci
> +subw              100 1 11 ... 00 ... 01 @cs_2
> +addw              100 1 11 ... 01 ... 01 @cs_2
> +
> +# *** RV64C Standard Extension (Quadrant 2) ***
> +ld      011 .  .....  ..... 10 &i imm=%uimm_6bit_ld %rd rs1=2
> +sd      111 .  .....  ..... 10 &s imm=%uimm_6bit_sw rs2=%rs2_5 rs1=2
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index 73b385ad19..345629b649 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -42,6 +42,7 @@
>   # Argument sets imported from insn32.decode:
>   &r         rd rs1 rs2   !extern
>   &i         imm rs1 rd   !extern
> +&j         imm rd       !extern
>   &s         imm rs1 rs2  !extern
>   
>   # Argument sets:
> @@ -64,12 +65,10 @@
>   
>   # Formats 16:
>   @cr        ....  ..... .....  .. &cr                      rs2=%rs2_5  %rd
> -@ci        ... . ..... .....  .. &ci     imm=%imm_ci                  %rd
> +@ci        ... . ..... .....  .. &i  imm=%imm_ci %rd rs1=%rd
>   @ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
>   @cl_d      ... ... ... .. ... .. &i  imm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
>   @cl_w      ... ... ... .. ... .. &i  imm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
> -@cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
> -@cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
>   @cs_2      ... ... ... .. ... .. &r      rd=%rs1_3 rs1=%rs1_3 rs2=%rs2_3
>   @cs_d      ... ... ... .. ... .. &s  imm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
>   @cs_w      ... ... ... .. ... .. &s  imm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
> @@ -82,28 +81,21 @@
>   @c_sw      ... . .....  ..... .. &c_sd     uimm=%uimm_6bit_sw  rs2=%rs2_5
>   
>   @c_addi16sp_lui ... .  ..... ..... .. &c_addi16sp_lui %imm_lui %imm_addi16sp %rd
> -@c_flwsp_ldsp   ... .  ..... ..... .. &c_flwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
> -    uimm_ldsp=%uimm_6bit_ld %rd
> -@c_fswsp_sdsp   ... .  ..... ..... .. &c_fswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
> -    uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
>   
>   @c_shift        ... . .. ... ..... .. &c_shift rd=%rs1_3 shamt=%nzuimm_6bit
>   @c_shift2       ... . .. ... ..... .. &c_shift rd=%rd    shamt=%nzuimm_6bit
>   
> -@c_andi         ... . .. ... ..... .. &ci imm=%imm_ci rd=%rs1_3
> +@c_andi         ... . .. ... ..... .. &i imm=%imm_ci rd=%rs1_3 rs1=%rs1_3
>   
> -# *** RV64C Standard Extension (Quadrant 0) ***
> +# *** RVC Standard Extension (Quadrant 0) ***
>   c_addi4spn        000    ........ ... 00 @ciw
>   fld               001  ... ... .. ... 00 @cl_d
>   lw                010  ... ... .. ... 00 @cl_w
> -c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
>   fsd               101  ... ... .. ... 00 @cs_d
>   sw                110  ... ... .. ... 00 @cs_w
> -c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
>   
> -# *** RV64C Standard Extension (Quadrant 1) ***
> +# *** RVC Standard Extension (Quadrant 1) ***
>   c_addi            000 .  .....  ..... 01 @ci
> -c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
>   c_li              010 .  .....  ..... 01 @ci
>   c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
>   c_srli            100 . 00 ...  ..... 01 @c_shift
> @@ -113,19 +105,15 @@ sub               100 0 11 ... 00 ... 01 @cs_2
>   xor               100 0 11 ... 01 ... 01 @cs_2
>   or                100 0 11 ... 10 ... 01 @cs_2
>   and               100 0 11 ... 11 ... 01 @cs_2
> -subw              100 1 11 ... 00 ... 01 @cs_2
> -addw              100 1 11 ... 01 ... 01 @cs_2
>   c_j               101     ........... 01 @cj
>   c_beqz            110  ... ...  ..... 01 @cb
>   c_bnez            111  ... ...  ..... 01 @cb
>   
> -# *** RV64C Standard Extension (Quadrant 2) ***
> +# *** RVC Standard Extension (Quadrant 2) ***
>   c_slli            000 .  .....  ..... 10 @c_shift2
>   c_fldsp           001 .  .....  ..... 10 @c_ld
>   c_lwsp            010 .  .....  ..... 10 @c_lw
> -c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
>   c_jr_mv           100 0  .....  ..... 10 @cr
>   c_ebreak_jalr_add 100 1  .....  ..... 10 @cr
>   c_fsdsp           101   ......  ..... 10 @c_sd
>   c_swsp            110 .  .....  ..... 10 @c_sw
> -c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index e1fccc57c6..7fcc9a3074 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -23,7 +23,6 @@
>   %rd        7:5
>   
>   %sh6    20:6
> -%sh5    20:5
>   %csr    20:12
>   %rm     12:3
>   
> @@ -40,6 +39,7 @@
>   # Argument sets:
>   &b         imm rs2 rs1
>   &i         imm rs1 rd
> +&j         imm rd
>   &s         imm rs2 rs1
>   &r         rd rs1 rs2
>   &shift     shamt rs1 rd
> @@ -52,10 +52,9 @@
>   @b       .......   ..... ..... ... ..... ....... &b    imm=%imm_b %rs2 %rs1
>   @s       .......   ..... ..... ... ..... ....... &s    imm=%imm_s %rs2 %rs1
>   @u       ....................      ..... .......         imm=%imm_u          %rd
> -@j       ....................      ..... .......         imm=%imm_j          %rd
> +@j       ....................      ..... ....... &j      imm=%imm_j          %rd
>   
>   @sh6     ......  ...... .....  ... ..... ....... &shift  shamt=%sh6      %rs1 %rd
> -@sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
>   @csr     ............   .....  ... ..... .......               %csr     %rs1 %rd
>   
>   @atom_ld ..... aq:1 rl:1 ..... ........ ..... ....... &atomic rs2=0     %rs1 %rd
> @@ -129,20 +128,6 @@ csrrsi   ............     ..... 110 ..... 1110011 @csr
>   csrrci   ............     ..... 111 ..... 1110011 @csr
>   
>   
> -# *** RV64I Base Instruction Set (in addition to RV32I) ***
> -lwu      ............   ..... 110 ..... 0000011 @i
> -ld       ............   ..... 011 ..... 0000011 @i
> -sd       ....... .....  ..... 011 ..... 0100011 @s
> -addiw    ............   ..... 000 ..... 0011011 @i
> -slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
> -srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
> -sraiw    0100000 .....  ..... 101 ..... 0011011 @sh5
> -addw     0000000 .....  ..... 000 ..... 0111011 @r
> -subw     0100000 .....  ..... 000 ..... 0111011 @r
> -sllw     0000000 .....  ..... 001 ..... 0111011 @r
> -srlw     0000000 .....  ..... 101 ..... 0111011 @r
> -sraw     0100000 .....  ..... 101 ..... 0111011 @r
> -
>   # *** RV32M Standard Extension ***
>   mul      0000001 .....  ..... 000 ..... 0110011 @r
>   mulh     0000001 .....  ..... 001 ..... 0110011 @r
> @@ -153,13 +138,6 @@ divu     0000001 .....  ..... 101 ..... 0110011 @r
>   rem      0000001 .....  ..... 110 ..... 0110011 @r
>   remu     0000001 .....  ..... 111 ..... 0110011 @r
>   
> -# *** RV64M Standard Extension (in addition to RV32M) ***
> -mulw     0000001 .....  ..... 000 ..... 0111011 @r
> -divw     0000001 .....  ..... 100 ..... 0111011 @r
> -divuw    0000001 .....  ..... 101 ..... 0111011 @r
> -remw     0000001 .....  ..... 110 ..... 0111011 @r
> -remuw    0000001 .....  ..... 111 ..... 0111011 @r
> -
>   # *** RV32A Standard Extension ***
>   lr_w       00010 . . 00000 ..... 010 ..... 0101111 @atom_ld
>   sc_w       00011 . . ..... ..... 010 ..... 0101111 @atom_st
> @@ -173,19 +151,6 @@ amomax_w   10100 . . ..... ..... 010 ..... 0101111 @atom_st
>   amominu_w  11000 . . ..... ..... 010 ..... 0101111 @atom_st
>   amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
>   
> -# *** RV64A Standard Extension (in addition to RV32A) ***
> -lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
> -sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
> -amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
> -amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
> -amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
> -amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
> -amoor_d    01000 . . ..... ..... 011 ..... 0101111 @atom_st
> -amomin_d   10000 . . ..... ..... 011 ..... 0101111 @atom_st
> -amomax_d   10100 . . ..... ..... 011 ..... 0101111 @atom_st
> -amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
> -amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
> -
>   # *** RV32F Standard Extension ***
>   flw        ............   ..... 010 ..... 0000111 @i
>   fsw        .......  ..... ..... 010 ..... 0100111 @s
> @@ -214,12 +179,6 @@ fcvt_s_w   1101000  00000 ..... ... ..... 1010011 @r2_rm
>   fcvt_s_wu  1101000  00001 ..... ... ..... 1010011 @r2_rm
>   fmv_w_x    1111000  00000 ..... 000 ..... 1010011 @r2
>   
> -# *** RV64F Standard Extension (in addition to RV32F) ***
> -fcvt_l_s   1100000  00010 ..... ... ..... 1010011 @r2_rm
> -fcvt_lu_s  1100000  00011 ..... ... ..... 1010011 @r2_rm
> -fcvt_s_l   1101000  00010 ..... ... ..... 1010011 @r2_rm
> -fcvt_s_lu  1101000  00011 ..... ... ..... 1010011 @r2_rm
> -
>   # *** RV32D Standard Extension ***
>   fld        ............   ..... 011 ..... 0000111 @i
>   fsd        ....... .....  ..... 011 ..... 0100111 @s
> @@ -247,11 +206,3 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011 @r2_rm
>   fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
>   fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
>   fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
> -
> -# *** RV64D Standard Extension (in addition to RV32D) ***
> -fcvt_l_d   1100001  00010 ..... ... ..... 1010011 @r2_rm
> -fcvt_lu_d  1100001  00011 ..... ... ..... 1010011 @r2_rm
> -fmv_x_d    1110001  00000 ..... 000 ..... 1010011 @r2
> -fcvt_d_l   1101001  00010 ..... ... ..... 1010011 @r2_rm
> -fcvt_d_lu  1101001  00011 ..... ... ..... 1010011 @r2_rm
> -fmv_d_x    1111001  00000 ..... 000 ..... 1010011 @r2
> diff --git a/target/riscv/insn64.decode b/target/riscv/insn64.decode
> new file mode 100644
> index 0000000000..92ac363a11
> --- /dev/null
> +++ b/target/riscv/insn64.decode
> @@ -0,0 +1,71 @@
> +#
> +# RISC-V translation routines for the RV Instruction Set.
> +#
> +# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
> +#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms and conditions of the GNU General Public License,
> +# version 2 or later, as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope it will be useful, but WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +# more details.
> +#
> +# You should have received a copy of the GNU General Public License along with
> +# this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +# This is concatenated with insn32.decode for risc64 targets.
> +# Most of the fields and formats are there.
> +
> +%sh5    20:5
> +@sh5     .......  ..... .....  ... ..... ....... &shift shamt=%sh5 %rs1 %rd
> +
> +# *** RV64I Base Instruction Set (in addition to RV32I) ***
> +lwu      ............   ..... 110 ..... 0000011 @i
> +ld       ............   ..... 011 ..... 0000011 @i
> +sd       ....... .....  ..... 011 ..... 0100011 @s
> +addiw    ............   ..... 000 ..... 0011011 @i
> +slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
> +srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
> +sraiw    0100000 .....  ..... 101 ..... 0011011 @sh5
> +addw     0000000 .....  ..... 000 ..... 0111011 @r
> +subw     0100000 .....  ..... 000 ..... 0111011 @r
> +sllw     0000000 .....  ..... 001 ..... 0111011 @r
> +srlw     0000000 .....  ..... 101 ..... 0111011 @r
> +sraw     0100000 .....  ..... 101 ..... 0111011 @r
> +
> +# *** RV64M Standard Extension (in addition to RV32M) ***
> +mulw     0000001 .....  ..... 000 ..... 0111011 @r
> +divw     0000001 .....  ..... 100 ..... 0111011 @r
> +divuw    0000001 .....  ..... 101 ..... 0111011 @r
> +remw     0000001 .....  ..... 110 ..... 0111011 @r
> +remuw    0000001 .....  ..... 111 ..... 0111011 @r
> +
> +# *** RV64A Standard Extension (in addition to RV32A) ***
> +lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
> +sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
> +amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
> +amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
> +amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
> +amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
> +amoor_d    01000 . . ..... ..... 011 ..... 0101111 @atom_st
> +amomin_d   10000 . . ..... ..... 011 ..... 0101111 @atom_st
> +amomax_d   10100 . . ..... ..... 011 ..... 0101111 @atom_st
> +amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
> +amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
> +
> +# *** RV64F Standard Extension (in addition to RV32F) ***
> +fcvt_l_s   1100000  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_lu_s  1100000  00011 ..... ... ..... 1010011 @r2_rm
> +fcvt_s_l   1101000  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_s_lu  1101000  00011 ..... ... ..... 1010011 @r2_rm
> +
> +# *** RV64D Standard Extension (in addition to RV32D) ***
> +fcvt_l_d   1100001  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_lu_d  1100001  00011 ..... ... ..... 1010011 @r2_rm
> +fmv_x_d    1110001  00000 ..... 000 ..... 1010011 @r2
> +fcvt_d_l   1101001  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_d_lu  1101001  00011 ..... ... ..... 1010011 @r2_rm
> +fmv_d_x    1111001  00000 ..... 000 ..... 1010011 @r2
> 
