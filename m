Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDECC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D062082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWYuM7YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D062082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Nbb-0004av-OG
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTW-0002Rr-LU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTU-0002UX-S0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NTU-0002SN-JA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:48 -0500
Received: by mail-wm1-x343.google.com with SMTP id c84so8644677wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eMpV6oHUHsBouYuIbNXi5ILIhk0UHtJDCsWgmHAo3NA=;
 b=yWYuM7YLKyGrZb4442dJsx+3FP9M68tyeTgoIjDsy/KBHCLHqV5KYl2OB82ZG8T2z3
 0irZnQLeJS0D71zNnIvuzHviUrfkUqRX538O+rbr6YTDR6XuoCGeBkNYmLc3WoOyshrp
 ydVvsSCAQyTSe3g0/skIhHY9ydPWVmFTlTGXutOFH+uo2ukrrP6z2EvWcOZawJd9ZAiL
 GhM3O62anngurZ8Fnea3fLmm1CRTyj/boxu5G3bjwogyTKh8CTOgryh3ApMOwg72jdbG
 HKy/bomz7fWgvyVK6bDmhG0lq1mSc7kwjYvaJUeToNAX+WiabNf9Z4r+rJ3SvHCQ+9D1
 /V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eMpV6oHUHsBouYuIbNXi5ILIhk0UHtJDCsWgmHAo3NA=;
 b=BEfLq2wBIc6LNvr10Z+JJUHkpo8TizEpLQx6Mmj5XZ3YXaQm7wjNXU7Ay2OGFmALMg
 XBUYOJjhtXqoSBb49ILygaVTEF7BUJ05Wzr8YWDvBEvQvYek3Hcoq2tsK4K8HE1W+T1I
 V1c1Uyb2IeMMe3nx9mprvqfDk3IrRDJDMD/3VoC1gVQk5vckeCu++QmyZvfEVli/sNZr
 epJnBAW0g4aAP+Zi3VJ0yc7KYgnN6Ug12gZA84/nJyNDrlIQC110JXGFResMCCFo16nE
 bjaTl6sgbDmQ3O5TxGyHjQyGLWPHHkpS0UKFWO/EUKLHlGF4MXjJK/FABByWR37ffC4m
 IExg==
X-Gm-Message-State: APjAAAUA4zs67DTaQMjqNbJmTU+BYHM0NawON0NPwTVJ6ywLn3/ycbz6
 EBW+yRMWTa4Fad7QNEDkFzhLVA==
X-Google-Smtp-Source: APXvYqxFAebULEpqCErB+HkrKEnxog72/GKAQavzWaKmoa154Lgl0JBqMji0ONGsAf1ar5TMlUqbsg==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr322801wmf.75.1581634847347;
 Thu, 13 Feb 2020 15:00:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a8sm4904539wmc.20.2020.02.13.15.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:00:45 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D7EF01FF9E;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/19] target/riscv: progressively load the instruction
 during decode
Date: Thu, 13 Feb 2020 22:51:04 +0000
Message-Id: <20200213225109.13120-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: fam@euphon.net, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 stefanb@linux.vnet.ibm.com, aaron@os.amperecomputing.com, cota@braap.org,
 marcandre.lureau@redhat.com, robert.foley@linaro.org,
 richard.henderson@linaro.org, stefanha@redhat.com, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, berrange@redhat.com,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, f4bug@amsat.org,
 robhenry@microsoft.com, Palmer Dabbelt <palmer@dabbelt.com>,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The plugin system would throw up a harmless warning when it detected
that a disassembly of an instruction didn't use all it's bytes. Fix
the riscv decoder to only load the instruction bytes it needs as it
needs them.

This drops opcode from the ctx in favour if passing the appropriately
sized opcode down a few levels of the decode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - use extract16 for uint16_t opcodes

squash! target/riscv: progressively load the instruction during decode
---
 target/riscv/instmap.h   |  8 ++++----
 target/riscv/translate.c | 40 +++++++++++++++++++++-------------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
index f8ad7d60fd5..40b6d2b64de 100644
--- a/target/riscv/instmap.h
+++ b/target/riscv/instmap.h
@@ -344,8 +344,8 @@ enum {
 #define GET_C_LW_IMM(inst)          ((extract32(inst, 6, 1) << 2) \
                                     | (extract32(inst, 10, 3) << 3) \
                                     | (extract32(inst, 5, 1) << 6))
-#define GET_C_LD_IMM(inst)          ((extract32(inst, 10, 3) << 3) \
-                                    | (extract32(inst, 5, 2) << 6))
+#define GET_C_LD_IMM(inst)          ((extract16(inst, 10, 3) << 3) \
+                                    | (extract16(inst, 5, 2) << 6))
 #define GET_C_J_IMM(inst)           ((extract32(inst, 3, 3) << 1) \
                                     | (extract32(inst, 11, 1) << 4) \
                                     | (extract32(inst, 2, 1) << 5) \
@@ -363,7 +363,7 @@ enum {
 #define GET_C_RD(inst)              GET_RD(inst)
 #define GET_C_RS1(inst)             GET_RD(inst)
 #define GET_C_RS2(inst)             extract32(inst, 2, 5)
-#define GET_C_RS1S(inst)            (8 + extract32(inst, 7, 3))
-#define GET_C_RS2S(inst)            (8 + extract32(inst, 2, 3))
+#define GET_C_RS1S(inst)            (8 + extract16(inst, 7, 3))
+#define GET_C_RS2S(inst)            (8 + extract16(inst, 2, 3))
 
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 14dc71156be..d5de7f468a7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,7 +44,6 @@ typedef struct DisasContext {
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
     target_ulong priv_ver;
-    uint32_t opcode;
     uint32_t mstatus_fs;
     uint32_t misa;
     uint32_t mem_idx;
@@ -492,45 +491,45 @@ static void gen_set_rm(DisasContext *ctx, int rm)
     tcg_temp_free_i32(t0);
 }
 
-static void decode_RV32_64C0(DisasContext *ctx)
+static void decode_RV32_64C0(DisasContext *ctx, uint16_t opcode)
 {
-    uint8_t funct3 = extract32(ctx->opcode, 13, 3);
-    uint8_t rd_rs2 = GET_C_RS2S(ctx->opcode);
-    uint8_t rs1s = GET_C_RS1S(ctx->opcode);
+    uint8_t funct3 = extract16(opcode, 13, 3);
+    uint8_t rd_rs2 = GET_C_RS2S(opcode);
+    uint8_t rs1s = GET_C_RS1S(opcode);
 
     switch (funct3) {
     case 3:
 #if defined(TARGET_RISCV64)
         /* C.LD(RV64/128) -> ld rd', offset[7:3](rs1')*/
         gen_load_c(ctx, OPC_RISC_LD, rd_rs2, rs1s,
-                 GET_C_LD_IMM(ctx->opcode));
+                 GET_C_LD_IMM(opcode));
 #else
         /* C.FLW (RV32) -> flw rd', offset[6:2](rs1')*/
         gen_fp_load(ctx, OPC_RISC_FLW, rd_rs2, rs1s,
-                    GET_C_LW_IMM(ctx->opcode));
+                    GET_C_LW_IMM(opcode));
 #endif
         break;
     case 7:
 #if defined(TARGET_RISCV64)
         /* C.SD (RV64/128) -> sd rs2', offset[7:3](rs1')*/
         gen_store_c(ctx, OPC_RISC_SD, rs1s, rd_rs2,
-                  GET_C_LD_IMM(ctx->opcode));
+                  GET_C_LD_IMM(opcode));
 #else
         /* C.FSW (RV32) -> fsw rs2', offset[6:2](rs1')*/
         gen_fp_store(ctx, OPC_RISC_FSW, rs1s, rd_rs2,
-                     GET_C_LW_IMM(ctx->opcode));
+                     GET_C_LW_IMM(opcode));
 #endif
         break;
     }
 }
 
-static void decode_RV32_64C(DisasContext *ctx)
+static void decode_RV32_64C(DisasContext *ctx, uint16_t opcode)
 {
-    uint8_t op = extract32(ctx->opcode, 0, 2);
+    uint8_t op = extract16(opcode, 0, 2);
 
     switch (op) {
     case 0:
-        decode_RV32_64C0(ctx);
+        decode_RV32_64C0(ctx, opcode);
         break;
     }
 }
@@ -709,22 +708,25 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode_insn16.inc.c"
 
-static void decode_opc(DisasContext *ctx)
+static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
 {
     /* check for compressed insn */
-    if (extract32(ctx->opcode, 0, 2) != 3) {
+    if (extract16(opcode, 0, 2) != 3) {
         if (!has_ext(ctx, RVC)) {
             gen_exception_illegal(ctx);
         } else {
             ctx->pc_succ_insn = ctx->base.pc_next + 2;
-            if (!decode_insn16(ctx, ctx->opcode)) {
+            if (!decode_insn16(ctx, opcode)) {
                 /* fall back to old decoder */
-                decode_RV32_64C(ctx);
+                decode_RV32_64C(ctx, opcode);
             }
         }
     } else {
+        uint32_t opcode32 = opcode;
+        opcode32 = deposit32(opcode32, 16, 16,
+                             translator_lduw(env, ctx->base.pc_next + 2));
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
-        if (!decode_insn32(ctx, ctx->opcode)) {
+        if (!decode_insn32(ctx, opcode32)) {
             gen_exception_illegal(ctx);
         }
     }
@@ -776,9 +778,9 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu->env_ptr;
+    uint16_t opcode16 = translator_lduw(env, ctx->base.pc_next);
 
-    ctx->opcode = translator_ldl(env, ctx->base.pc_next);
-    decode_opc(ctx);
+    decode_opc(env, ctx, opcode16);
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
-- 
2.20.1


