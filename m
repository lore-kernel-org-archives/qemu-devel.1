Received: from eggs.gnu.org ([2001:4830:134:3::10]:35228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmkkc-0003CS-Su
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmkkZ-0005Mv-Np
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:01:06 -0400
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com
	([104.47.33.104]:53440
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fmkkZ-0005Kc-8o
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:01:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 6 Aug 2018 19:00:38 +0000
Message-ID: <BN7PR08MB48680E7FAC242C2A2E8B2BF1C6200@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-40-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-40-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 39/80] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

> +    case NM_APPEND:
> +        gen_load_gpr(t0, rs);
> +
> +        if (rd !=3D 0) {
> +            tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd=
);
> +        }
> +        tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +        break;

Missing check_dspr2(). Please fix in next version.

________________________________________
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Sent: Monday, August 6, 2018 7:00:06 PM
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org; laurent@vivier.eu; riku.voipio@iki.fi; philip=
pe.mathieu.daude@gmail.com; aurelien@aurel32.net; richard.henderson@linaro.=
org; Aleksandar Markovic; Stefan Markovic; Petar Jovanovic; Paul Burton; Al=
eksandar Rikalo; thuth@redhat.com; armbru@redhat.com
Subject: [PATCH v7 39/80] target/mips: Add emulation of DSP ASE for nanoMIP=
S - part 1

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 1.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 619 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 619 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 441431d..78b1c72 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17661,6 +17661,619 @@ static void gen_pool32f_nanomips_insn(DisasContex=
t *ctx)
     }
 }

+static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
+                                       int rd, int rs, int rt)
+{
+    int ret =3D rd;
+
+    TCGv t0;
+    TCGv v1_t;
+    TCGv v2_t;
+
+    t0 =3D tcg_temp_new();
+    v1_t =3D tcg_temp_new();
+    v2_t =3D tcg_temp_new();
+
+    gen_load_gpr(v1_t, rs);
+    gen_load_gpr(v2_t, rt);
+
+    switch (opc) {
+    case NM_CMP_EQ_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_eq_ph(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMP_LT_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_lt_ph(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMP_LE_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_le_ph(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMPU_EQ_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_eq_qb(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMPU_LT_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_lt_qb(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMPU_LE_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_le_qb(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMPGU_EQ_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGU_LT_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGU_LE_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGDU_EQ_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
+        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGDU_LT_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
+        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGDU_LE_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
+        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PACKRL_PH:
+        check_dsp(ctx);
+        gen_helper_packrl_ph(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PICK_QB:
+        check_dsp(ctx);
+        gen_helper_pick_qb(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PICK_PH:
+        check_dsp(ctx);
+        gen_helper_pick_ph(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_ADDQ_S_W:
+        check_dsp(ctx);
+        gen_helper_addq_s_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SUBQ_S_W:
+        check_dsp(ctx);
+        gen_helper_subq_s_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_ADDSC:
+        check_dsp(ctx);
+        gen_helper_addsc(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_ADDWC:
+        check_dsp(ctx);
+        gen_helper_addwc(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_ADDQ_S_PH:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDQ_PH */
+            gen_helper_addq_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDQ_S_PH */
+            gen_helper_addq_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_ADDQH_R_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDQH_PH */
+            gen_helper_addqh_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDQH_R_PH */
+            gen_helper_addqh_r_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_ADDQH_R_W:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDQH_W */
+            gen_helper_addqh_w(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDQH_R_W */
+            gen_helper_addqh_r_w(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_ADDU_S_QB:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDU_QB */
+            gen_helper_addu_qb(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDU_S_QB */
+            gen_helper_addu_s_qb(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_ADDU_S_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDU_PH */
+            gen_helper_addu_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDU_S_PH */
+            gen_helper_addu_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_ADDUH_R_QB:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDUH_QB */
+            gen_helper_adduh_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDUH_R_QB */
+            gen_helper_adduh_r_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SHRAV_R_PH:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SHRAV_PH */
+            gen_helper_shra_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SHRAV_R_PH */
+            gen_helper_shra_r_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SHRAV_R_QB:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SHRAV_QB */
+            gen_helper_shra_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SHRAV_R_QB */
+            gen_helper_shra_r_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SUBQ_S_PH:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBQ_PH */
+            gen_helper_subq_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBQ_S_PH */
+            gen_helper_subq_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SUBQH_R_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBQH_PH */
+            gen_helper_subqh_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBQH_R_PH */
+            gen_helper_subqh_r_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SUBQH_R_W:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBQH_W */
+            gen_helper_subqh_w(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBQH_R_W */
+            gen_helper_subqh_r_w(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SUBU_S_QB:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBU_QB */
+            gen_helper_subu_qb(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBU_S_QB */
+            gen_helper_subu_s_qb(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SUBU_S_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBU_PH */
+            gen_helper_subu_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBU_S_PH */
+            gen_helper_subu_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SUBUH_R_QB:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBUH_QB */
+            gen_helper_subuh_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBUH_R_QB */
+            gen_helper_subuh_r_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SHLLV_S_PH:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SHLLV_PH */
+            gen_helper_shll_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SHLLV_S_PH */
+            gen_helper_shll_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_PRECR_SRA_R_PH_W:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* PRECR_SRA_PH_W */
+            {
+                TCGv_i32 sa_t =3D tcg_const_i32(rd);
+                gen_helper_precr_sra_ph_w(v1_t, sa_t, v1_t,
+                                          cpu_gpr[rt]);
+                gen_store_gpr(v1_t, rt);
+                tcg_temp_free_i32(sa_t);
+            }
+            break;
+        case 1:
+            /* PRECR_SRA_R_PH_W */
+            {
+                TCGv_i32 sa_t =3D tcg_const_i32(rd);
+                gen_helper_precr_sra_r_ph_w(v1_t, sa_t, v1_t,
+                                            cpu_gpr[rt]);
+                gen_store_gpr(v1_t, rt);
+                tcg_temp_free_i32(sa_t);
+            }
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_MULEU_S_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_muleu_s_ph_qbl(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULEU_S_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_muleu_s_ph_qbr(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULQ_RS_PH:
+        check_dsp(ctx);
+        gen_helper_mulq_rs_ph(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULQ_S_PH:
+        check_dspr2(ctx);
+        gen_helper_mulq_s_ph(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULQ_RS_W:
+        check_dspr2(ctx);
+        gen_helper_mulq_rs_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULQ_S_W:
+        check_dspr2(ctx);
+        gen_helper_mulq_s_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_APPEND:
+        gen_load_gpr(t0, rs);
+
+        if (rd !=3D 0) {
+            tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd);
+        }
+        tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+        break;
+    case NM_MODSUB:
+        check_dsp(ctx);
+        gen_helper_modsub(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHRAV_R_W:
+        check_dsp(ctx);
+        gen_helper_shra_r_w(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHRLV_PH:
+        check_dspr2(ctx);
+        gen_helper_shrl_ph(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHRLV_QB:
+        check_dsp(ctx);
+        gen_helper_shrl_qb(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHLLV_QB:
+        check_dsp(ctx);
+        gen_helper_shll_qb(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHLLV_S_W:
+        check_dsp(ctx);
+        gen_helper_shll_s_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHILO:
+        {
+            TCGv tv0;
+            TCGv tv1;
+            tv0 =3D tcg_temp_new();
+            tv1 =3D tcg_temp_new();
+
+            int16_t imm =3D extract32(ctx->opcode, 16, 7);
+
+            check_dsp(ctx);
+            tcg_gen_movi_tl(tv0, rd >> 3);
+            tcg_gen_movi_tl(tv1, imm);
+
+            gen_helper_shilo(tv0, tv1, cpu_env);
+        }
+        break;
+    case NM_MULEQ_S_W_PHL:
+        check_dsp(ctx);
+        gen_helper_muleq_s_w_phl(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULEQ_S_W_PHR:
+        check_dsp(ctx);
+        gen_helper_muleq_s_w_phr(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MUL_S_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* MUL_PH */
+            gen_helper_mul_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* MUL_S_PH */
+            gen_helper_mul_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_PRECR_QB_PH:
+        check_dspr2(ctx);
+        gen_helper_precr_qb_ph(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PRECRQ_QB_PH:
+        check_dsp(ctx);
+        gen_helper_precrq_qb_ph(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PRECRQ_PH_W:
+        check_dsp(ctx);
+        gen_helper_precrq_ph_w(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PRECRQ_RS_PH_W:
+        check_dsp(ctx);
+        gen_helper_precrq_rs_ph_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PRECRQU_S_QB_PH:
+        check_dsp(ctx);
+        gen_helper_precrqu_s_qb_ph(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHRA_R_W:
+        tcg_gen_movi_tl(t0, rd);
+        check_dsp(ctx);
+        gen_helper_shra_r_w(v1_t, t0, v1_t);
+        gen_store_gpr(v1_t, rt);
+        break;
+    case NM_SHRA_R_PH:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, rd >> 1);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SHRA_PH */
+            gen_helper_shra_ph(v1_t, t0, v1_t);
+            break;
+            gen_store_gpr(v1_t, rt);
+        case 1:
+            /* SHRA_R_PH */
+            gen_helper_shra_r_ph(v1_t, t0, v1_t);
+            gen_store_gpr(v1_t, rt);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SHLL_S_PH:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, rd >> 1);
+        switch (extract32(ctx->opcode, 10, 2)) {
+        case 0:
+            /* SHLL_PH */
+            gen_helper_shll_ph(v1_t, t0, v1_t, cpu_env);
+            gen_store_gpr(v1_t, rt);
+            break;
+        case 2:
+            /* SHLL_S_PH */
+            gen_helper_shll_s_ph(v1_t, t0, v1_t, cpu_env);
+            gen_store_gpr(v1_t, rt);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SHLL_S_W:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, rd);
+        gen_helper_shll_s_w(v1_t, t0, v1_t, cpu_env);
+        gen_store_gpr(v1_t, rt);
+        break;
+    case NM_REPL_PH:
+        check_dsp(ctx);
+        {
+            int16_t imm;
+            imm =3D extract32(ctx->opcode, 11, 11);
+            imm =3D (int16_t)(imm << 6) >> 6;
+            if (rt !=3D 0) {
+                tcg_gen_movi_tl(cpu_gpr[rt], \
+                                (target_long)((int32_t)imm << 16 | \
+                                (uint16_t)imm));
+            }
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint16_t insn;
@@ -17731,6 +18344,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState =
*env, DisasContext *ctx)
         case NM_POOL32A0:
             gen_pool32a0_nanomips_insn(env, ctx);
             break;
+        case NM_POOL32A5:
+            {
+                int32_t op1 =3D extract32(ctx->opcode, 3, 7);
+                gen_pool32a5_nanomips_insn(ctx, op1, rd, rs, rt);
+            }
+            break;
         case NM_POOL32A7:
             switch (extract32(ctx->opcode, 3, 3)) {
             case NM_P_LSX:
--
2.7.4
