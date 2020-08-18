Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D81C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3900206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VqbgvlW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3900206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tHm-0003TG-0j
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6D-0007aR-Mt; Tue, 18 Aug 2020 00:19:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43185 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6B-0006Mr-2U; Tue, 18 Aug 2020 00:19:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNb3pwKz9sVM; Tue, 18 Aug 2020 14:19:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724367;
 bh=p5k/N3bAXkiI8BCnZaFK1edTmmELskToQBlH18YDB1g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VqbgvlW2nz0yJEP34SYIca1YEfoONGnei9+Wj+IJoCB+TYx11gcGxViuNki3X86v0
 Ol40UBei0lHNnoK9dGdnRAMbyQ1CnLl6E/RfubTONaQGEZlQGghhjW4gfvTRUFdfuV
 w41lf8VsyJR6On2G3RaSm3N6LDsNs8y07D3iD4t8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 15/40] target/ppc: Fix SPE unavailable exception triggering
Date: Tue, 18 Aug 2020 14:18:57 +1000
Message-Id: <20200818041922.251708-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 00:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>

When emulating certain floating point instructions or vector instructions on
PowerPC machines, QEMU did not properly generate the SPE/Embedded Floating-
Point Unavailable interrupt. See the buglink further below for references to
the relevant NXP documentation.

This patch fixes the behavior of some evfs* instructions that were
incorrectly emitting the interrupt.

More importantly, this patch fixes the behavior of several efd* and ev*
instructions that were not generating the interrupt. Triggering the
interrupt for these instructions fixes lazy FPU/vector context switching on
some operating systems like Linux.

Without this patch, the result of some double-precision arithmetic could be
corrupted due to the lack of proper saving and restoring of the upper
32-bit part of the general-purpose registers.

Buglink: https://bugs.launchpad.net/qemu/+bug/1888918
Buglink: https://bugs.launchpad.net/qemu/+bug/1611394
Signed-off-by: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
Message-Id: <20200727175553.32276-1-matthieu.bucchianeri@leostella.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/spe-impl.inc.c | 97 +++++++++++++++++++----------
 1 file changed, 64 insertions(+), 33 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe-impl.inc.c
index 42a0d1cffb..2e6e799a25 100644
--- a/target/ppc/translate/spe-impl.inc.c
+++ b/target/ppc/translate/spe-impl.inc.c
@@ -349,14 +349,24 @@ static inline void gen_evmergelohi(DisasContext *ctx)
 }
 static inline void gen_evsplati(DisasContext *ctx)
 {
-    uint64_t imm = ((int32_t)(rA(ctx->opcode) << 27)) >> 27;
+    uint64_t imm;
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
+    imm = ((int32_t)(rA(ctx->opcode) << 27)) >> 27;
 
     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], imm);
     tcg_gen_movi_tl(cpu_gprh[rD(ctx->opcode)], imm);
 }
 static inline void gen_evsplatfi(DisasContext *ctx)
 {
-    uint64_t imm = rA(ctx->opcode) << 27;
+    uint64_t imm;
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
+    imm = rA(ctx->opcode) << 27;
 
     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], imm);
     tcg_gen_movi_tl(cpu_gprh[rD(ctx->opcode)], imm);
@@ -389,21 +399,37 @@ static inline void gen_evsel(DisasContext *ctx)
 
 static void gen_evsel0(DisasContext *ctx)
 {
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
     gen_evsel(ctx);
 }
 
 static void gen_evsel1(DisasContext *ctx)
 {
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
     gen_evsel(ctx);
 }
 
 static void gen_evsel2(DisasContext *ctx)
 {
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
     gen_evsel(ctx);
 }
 
 static void gen_evsel3(DisasContext *ctx)
 {
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
     gen_evsel(ctx);
 }
 
@@ -518,6 +544,11 @@ static inline void gen_evmwsmia(DisasContext *ctx)
 {
     TCGv_i64 tmp;
 
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
+
     gen_evmwsmi(ctx);            /* rD := rA * rB */
 
     tmp = tcg_temp_new_i64();
@@ -534,6 +565,11 @@ static inline void gen_evmwsmiaa(DisasContext *ctx)
     TCGv_i64 acc;
     TCGv_i64 tmp;
 
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
+
     gen_evmwsmi(ctx);           /* rD := rA * rB */
 
     acc = tcg_temp_new_i64();
@@ -892,8 +928,14 @@ static inline void gen_##name(DisasContext *ctx)                              \
 #define GEN_SPEFPUOP_CONV_32_64(name)                                         \
 static inline void gen_##name(DisasContext *ctx)                              \
 {                                                                             \
-    TCGv_i64 t0 = tcg_temp_new_i64();                                         \
-    TCGv_i32 t1 = tcg_temp_new_i32();                                         \
+    TCGv_i64 t0;                                                              \
+    TCGv_i32 t1;                                                              \
+    if (unlikely(!ctx->spe_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
+        return;                                                               \
+    }                                                                         \
+    t0 = tcg_temp_new_i64();                                                  \
+    t1 = tcg_temp_new_i32();                                                  \
     gen_load_gpr64(t0, rB(ctx->opcode));                                      \
     gen_helper_##name(t1, cpu_env, t0);                                       \
     tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);                        \
@@ -903,8 +945,14 @@ static inline void gen_##name(DisasContext *ctx)                              \
 #define GEN_SPEFPUOP_CONV_64_32(name)                                         \
 static inline void gen_##name(DisasContext *ctx)                              \
 {                                                                             \
-    TCGv_i64 t0 = tcg_temp_new_i64();                                         \
-    TCGv_i32 t1 = tcg_temp_new_i32();                                         \
+    TCGv_i64 t0;                                                              \
+    TCGv_i32 t1;                                                              \
+    if (unlikely(!ctx->spe_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
+        return;                                                               \
+    }                                                                         \
+    t0 = tcg_temp_new_i64();                                                  \
+    t1 = tcg_temp_new_i32();                                                  \
     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                       \
     gen_helper_##name(t0, cpu_env, t1);                                       \
     gen_store_gpr64(rD(ctx->opcode), t0);                                     \
@@ -914,7 +962,12 @@ static inline void gen_##name(DisasContext *ctx)                              \
 #define GEN_SPEFPUOP_CONV_64_64(name)                                         \
 static inline void gen_##name(DisasContext *ctx)                              \
 {                                                                             \
-    TCGv_i64 t0 = tcg_temp_new_i64();                                         \
+    TCGv_i64 t0;                                                              \
+    if (unlikely(!ctx->spe_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
+        return;                                                               \
+    }                                                                         \
+    t0 = tcg_temp_new_i64();                                                  \
     gen_load_gpr64(t0, rB(ctx->opcode));                                      \
     gen_helper_##name(t0, cpu_env, t0);                                       \
     gen_store_gpr64(rD(ctx->opcode), t0);                                     \
@@ -923,13 +976,8 @@ static inline void gen_##name(DisasContext *ctx)                              \
 #define GEN_SPEFPUOP_ARITH2_32_32(name)                                       \
 static inline void gen_##name(DisasContext *ctx)                              \
 {                                                                             \
-    TCGv_i32 t0, t1;                                                          \
-    if (unlikely(!ctx->spe_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
-        return;                                                               \
-    }                                                                         \
-    t0 = tcg_temp_new_i32();                                                  \
-    t1 = tcg_temp_new_i32();                                                  \
+    TCGv_i32 t0 = tcg_temp_new_i32();                                         \
+    TCGv_i32 t1 = tcg_temp_new_i32();                                         \
     tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                       \
     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                       \
     gen_helper_##name(t0, cpu_env, t0, t1);                                   \
@@ -958,13 +1006,8 @@ static inline void gen_##name(DisasContext *ctx)                              \
 #define GEN_SPEFPUOP_COMP_32(name)                                            \
 static inline void gen_##name(DisasContext *ctx)                              \
 {                                                                             \
-    TCGv_i32 t0, t1;                                                          \
-    if (unlikely(!ctx->spe_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_SPEU);                                \
-        return;                                                               \
-    }                                                                         \
-    t0 = tcg_temp_new_i32();                                                  \
-    t1 = tcg_temp_new_i32();                                                  \
+    TCGv_i32 t0 = tcg_temp_new_i32();                                         \
+    TCGv_i32 t1 = tcg_temp_new_i32();                                         \
                                                                               \
     tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                       \
     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                       \
@@ -1074,28 +1117,16 @@ GEN_SPEFPUOP_ARITH2_32_32(efsmul);
 GEN_SPEFPUOP_ARITH2_32_32(efsdiv);
 static inline void gen_efsabs(DisasContext *ctx)
 {
-    if (unlikely(!ctx->spe_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_SPEU);
-        return;
-    }
     tcg_gen_andi_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
                     (target_long)~0x80000000LL);
 }
 static inline void gen_efsnabs(DisasContext *ctx)
 {
-    if (unlikely(!ctx->spe_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_SPEU);
-        return;
-    }
     tcg_gen_ori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
                    0x80000000);
 }
 static inline void gen_efsneg(DisasContext *ctx)
 {
-    if (unlikely(!ctx->spe_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_SPEU);
-        return;
-    }
     tcg_gen_xori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
                     0x80000000);
 }
-- 
2.26.2


