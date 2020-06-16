Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED508C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB4720776
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Ku3VvJZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB4720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl67d-0004dw-VV
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jl66q-0003N4-0D
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 03:34:16 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:57344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jl66m-0004og-NJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 03:34:15 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
 by vultr.net.flygoat.com (Postfix) with ESMTPSA id 9ADF820E89;
 Tue, 16 Jun 2020 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
 t=1592292851; bh=wbsL2Lhtc0wZY6sgNdGk4p6q2LxtQmY2wMqM8+O5C08=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ku3VvJZaBBNvqy3myplyjqLTSgVXcg15kMu1uQqo0aSbJm4Fc741/p9H05laMCUyO
 aFYxMFijbJa5mOzp9AZW5EnfsUtmj7MyTWVS49OAQUBBVcmO8vctr9yl+28bE7RwFB
 7KkJkp04aeavVNp1zs2DRL+UH7rn4EEIe7ScIjMZuVLzoUoUZVeBDscLdjRj4MkV4V
 eK0q7vJY+AlaK6poW4G1Qm1n7GjKjTpiLbRqTFFXpDSIuUvbjE9BKDnMLY89GEkkZ9
 Inn1oGVCxUTY0ZUQTtUGOO0Oyx3i1tNcbVv/8BwubFukgaDeJ/N9hP15cuogzjSjdH
 FPz3lWQdNqKjQ==
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] target/mips: Add loongson-ext lswc2 group of
 instrustions
Date: Tue, 16 Jun 2020 15:33:59 +0800
Message-Id: <20200616073359.2999656-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200616073359.2999656-1-jiaxun.yang@flygoat.com>
References: <20200616073359.2999656-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=149.28.68.211;
 envelope-from=jiaxun.yang@flygoat.com; helo=vultr.net.flygoat.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 03:30:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LWC2 & SWC2 have been rewritten by Loongson EXT vendor ASE
as "load/store quad word" and "shifted load/store" groups of
instructions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/translate.c | 258 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 258 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5d2accf3e4..12349a1593 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -460,6 +460,30 @@ enum {
     R6_OPC_SCD         = 0x27 | OPC_SPECIAL3,
 };
 
+/* Loongson EXT load/store quad word opcodes */
+#define MASK_LOONGSON_GSLSQ(op)           (MASK_OP_MAJOR(op) | (op & 0x8020))
+enum {
+    OPC_GSLQ        = 0x0020 | OPC_LWC2,
+    OPC_GSLQC1      = 0x8020 | OPC_LWC2,
+    OPC_GSSHFL      = OPC_LWC2,
+    OPC_GSSQ        = 0x0020 | OPC_SWC2,
+    OPC_GSSQC1      = 0x8020 | OPC_SWC2,
+    OPC_GSSHFS      = OPC_SWC2,
+};
+
+/* Loongson EXT shifted load/store opcodes */
+#define MASK_LOONGSON_GSSHFLS(op)         (MASK_OP_MAJOR(op) | (op & 0xc03f))
+enum {
+    OPC_GSLWLC1     = 0x4 | OPC_GSSHFL,
+    OPC_GSLWRC1     = 0x5 | OPC_GSSHFL,
+    OPC_GSLDLC1     = 0x6 | OPC_GSSHFL,
+    OPC_GSLDRC1     = 0x7 | OPC_GSSHFL,
+    OPC_GSSWLC1     = 0x4 | OPC_GSSHFS,
+    OPC_GSSWRC1     = 0x5 | OPC_GSSHFS,
+    OPC_GSSDLC1     = 0x6 | OPC_GSSHFS,
+    OPC_GSSDRC1     = 0x7 | OPC_GSSHFS,
+};
+
 /* Loongson EXT LDC2/SDC2 opcodes */
 #define MASK_LOONGSON_LSDC2(op)           (MASK_OP_MAJOR(op) | (op & 0x7))
 
@@ -5928,6 +5952,238 @@ no_rd:
     tcg_temp_free_i64(t1);
 }
 
+static void gen_loongson_lswc2(DisasContext *ctx, int rt,
+                                int rs, int rd)
+{
+    TCGv t0, t1, t2;
+    TCGv_i32 fp0;
+    int lsq_offset = ((int)((ctx->opcode >> 6) & 0x1ff) << 23) >> 19;
+    int lsq_rt1 = ctx->opcode & 0x1f;
+    int shf_offset = (int8_t)(ctx->opcode >> 6);
+
+    t0 = tcg_temp_new();
+
+    switch (MASK_LOONGSON_GSLSQ(ctx->opcode)) {
+#if defined(TARGET_MIPS64)
+    case OPC_GSLQ:
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t0, rt);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t0, lsq_rt1);
+        break;
+    case OPC_GSLQC1:
+        check_cp1_enabled(ctx);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_fpr64(ctx, t0, rt);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_fpr64(ctx, t0, lsq_rt1);
+        break;
+    case OPC_GSSQ:
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_load_gpr(t1, lsq_rt1);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSQC1:
+        check_cp1_enabled(ctx);
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_load_fpr64(ctx, t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_load_fpr64(ctx, t1, lsq_rt1);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+#endif
+    case OPC_GSSHFL:
+        switch (MASK_LOONGSON_GSSHFLS(ctx->opcode)) {
+        case OPC_GSLWLC1:
+            check_cp1_enabled(ctx);
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            t1 = tcg_temp_new();
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_andi_tl(t1, t0, 3);
+#ifndef TARGET_WORDS_BIGENDIAN
+            tcg_gen_xori_tl(t1, t1, 3);
+#endif
+            tcg_gen_shli_tl(t1, t1, 3);
+            tcg_gen_andi_tl(t0, t0, ~3);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUL);
+            tcg_gen_shl_tl(t0, t0, t1);
+            t2 = tcg_const_tl(-1);
+            tcg_gen_shl_tl(t2, t2, t1);
+            fp0 = tcg_temp_new_i32();
+            gen_load_fpr32(ctx, fp0, rt);
+            tcg_gen_ext_i32_tl(t1, fp0);
+            tcg_gen_andc_tl(t1, t1, t2);
+            tcg_temp_free(t2);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t1);
+#if defined(TARGET_MIPS64)
+            tcg_gen_extrl_i64_i32(fp0, t0);
+#else
+            tcg_gen_ext32s_tl(fp0, t0);
+#endif
+            gen_store_fpr32(ctx, fp0, rt);
+            tcg_temp_free_i32(fp0);
+            break;
+        case OPC_GSLWRC1:
+            check_cp1_enabled(ctx);
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            t1 = tcg_temp_new();
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_andi_tl(t1, t0, 3);
+#ifdef TARGET_WORDS_BIGENDIAN
+            tcg_gen_xori_tl(t1, t1, 3);
+#endif
+            tcg_gen_shli_tl(t1, t1, 3);
+            tcg_gen_andi_tl(t0, t0, ~3);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUL);
+            tcg_gen_shr_tl(t0, t0, t1);
+            tcg_gen_xori_tl(t1, t1, 31);
+            t2 = tcg_const_tl(0xfffffffeull);
+            tcg_gen_shl_tl(t2, t2, t1);
+            fp0 = tcg_temp_new_i32();
+            gen_load_fpr32(ctx, fp0, rt);
+            tcg_gen_ext_i32_tl(t1, fp0);
+            tcg_gen_and_tl(t1, t1, t2);
+            tcg_temp_free(t2);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t1);
+#if defined(TARGET_MIPS64)
+            tcg_gen_extrl_i64_i32(fp0, t0);
+#else
+            tcg_gen_ext32s_tl(fp0, t0);
+#endif
+            gen_store_fpr32(ctx, fp0, rt);
+            tcg_temp_free_i32(fp0);
+            break;
+#if defined(TARGET_MIPS64)
+        case OPC_GSLDLC1:
+            check_cp1_enabled(ctx);
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            t1 = tcg_temp_new();
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_andi_tl(t1, t0, 7);
+#ifndef TARGET_WORDS_BIGENDIAN
+            tcg_gen_xori_tl(t1, t1, 7);
+#endif
+            tcg_gen_shli_tl(t1, t1, 3);
+            tcg_gen_andi_tl(t0, t0, ~7);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ);
+            tcg_gen_shl_tl(t0, t0, t1);
+            t2 = tcg_const_tl(-1);
+            tcg_gen_shl_tl(t2, t2, t1);
+            gen_load_fpr64(ctx, t1, rt);
+            tcg_gen_andc_tl(t1, t1, t2);
+            tcg_temp_free(t2);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t1);
+            gen_store_fpr64(ctx, t0, rt);
+            break;
+        case OPC_GSLDRC1:
+            check_cp1_enabled(ctx);
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            t1 = tcg_temp_new();
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_andi_tl(t1, t0, 7);
+#ifdef TARGET_WORDS_BIGENDIAN
+            tcg_gen_xori_tl(t1, t1, 7);
+#endif
+            tcg_gen_shli_tl(t1, t1, 3);
+            tcg_gen_andi_tl(t0, t0, ~7);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ);
+            tcg_gen_shr_tl(t0, t0, t1);
+            tcg_gen_xori_tl(t1, t1, 63);
+            t2 = tcg_const_tl(0xfffffffffffffffeull);
+            tcg_gen_shl_tl(t2, t2, t1);
+            gen_load_fpr64(ctx, t1, rt);
+            tcg_gen_and_tl(t1, t1, t2);
+            tcg_temp_free(t2);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t1);
+            gen_store_fpr64(ctx, t0, rt);
+            break;
+#endif
+        default:
+            MIPS_INVAL("loongson_gsshfl");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case OPC_GSSHFS:
+        switch (MASK_LOONGSON_GSSHFLS(ctx->opcode)) {
+        case OPC_GSSWLC1:
+            check_cp1_enabled(ctx);
+            t1 = tcg_temp_new();
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            fp0 = tcg_temp_new_i32();
+            gen_load_fpr32(ctx, fp0, rt);
+            tcg_gen_ext_i32_tl(t1, fp0);
+            gen_helper_0e2i(swl, t1, t0, ctx->mem_idx);
+            tcg_temp_free_i32(fp0);
+            tcg_temp_free(t1);
+            break;
+        case OPC_GSSWRC1:
+            check_cp1_enabled(ctx);
+            t1 = tcg_temp_new();
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            fp0 = tcg_temp_new_i32();
+            gen_load_fpr32(ctx, fp0, rt);
+            tcg_gen_ext_i32_tl(t1, fp0);
+            gen_helper_0e2i(swr, t1, t0, ctx->mem_idx);
+            tcg_temp_free_i32(fp0);
+            tcg_temp_free(t1);
+            break;
+#if defined(TARGET_MIPS64)
+        case OPC_GSSDLC1:
+            check_cp1_enabled(ctx);
+            t1 = tcg_temp_new();
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_load_fpr64(ctx, t1, rt);
+            gen_helper_0e2i(sdl, t1, t0, ctx->mem_idx);
+            tcg_temp_free(t1);
+            break;
+        case OPC_GSSDRC1:
+            check_cp1_enabled(ctx);
+            t1 = tcg_temp_new();
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_load_fpr64(ctx, t1, rt);
+            gen_helper_0e2i(sdr, t1, t0, ctx->mem_idx);
+            tcg_temp_free(t1);
+            break;
+#endif
+        default:
+            MIPS_INVAL("loongson_gsshfs");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    default:
+        MIPS_INVAL("loongson_gslsq");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+    tcg_temp_free(t0);
+}
+
 /* Loongson EXT LDC2/SDC2 */
 static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
                                 int rs, int rd)
@@ -30959,6 +31215,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
             /* OPC_BC, OPC_BALC */
             gen_compute_compact_branch(ctx, op, 0, 0,
                                        sextract32(ctx->opcode << 2, 0, 28));
+        } else if (ctx->insn_flags & ASE_LEXT) {
+            gen_loongson_lswc2(ctx, rt, rs, rd);
         } else {
             /* OPC_LWC2, OPC_SWC2 */
             /* COP2: Not implemented. */
-- 
2.27.0.rc2


