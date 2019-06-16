Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C308C31E53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC85B20866
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC85B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcUsy-0005P6-5r
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 09:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47861)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUoz-0003Oj-Gb
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUox-0004Vr-IA
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:03:45 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:46542
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUov-0004UA-KV; Sun, 16 Jun 2019 09:03:42 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUQ5-0001jp-Q9; Sun, 16 Jun 2019 13:38:02 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 rth@twiddle.net, gkurz@kaod.org
Date: Sun, 16 Jun 2019 13:37:49 +0100
Message-Id: <20190616123751.781-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
References: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v3 13/15] target/ppc: decode target register in
 VSX_VECTOR_LOAD_STORE_LENGTH at translation time
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  8 +++----
 target/ppc/mem_helper.c             |  6 ++---
 target/ppc/translate/vsx-impl.inc.c | 47 +++++++++++++++++++------------------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index a5e12a3933..7ed9effff2 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -279,10 +279,10 @@ DEF_HELPER_3(stvebx, void, env, avr, tl)
 DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
 #if defined(TARGET_PPC64)
-DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
-DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
-DEF_HELPER_4(stxvl, void, env, tl, tl, tl)
-DEF_HELPER_4(stxvll, void, env, tl, tl, tl)
+DEF_HELPER_4(lxvl, void, env, tl, vsr, tl)
+DEF_HELPER_4(lxvll, void, env, tl, vsr, tl)
+DEF_HELPER_4(stxvl, void, env, tl, vsr, tl)
+DEF_HELPER_4(stxvll, void, env, tl, vsr, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 87632ccf53..6f4ffa3661 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -415,9 +415,8 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
 
 #define VSX_LXVL(name, lj)                                              \
 void helper_##name(CPUPPCState *env, target_ulong addr,                 \
-                   target_ulong xt_num, target_ulong rb)                \
+                   ppc_vsr_t *xt, target_ulong rb)                      \
 {                                                                       \
-    ppc_vsr_t *xt = &env->vsr[xt_num];                                  \
     ppc_vsr_t t;                                                        \
     uint64_t nb = GET_NB(rb);                                           \
     int i;                                                              \
@@ -446,9 +445,8 @@ VSX_LXVL(lxvll, 1)
 
 #define VSX_STXVL(name, lj)                                       \
 void helper_##name(CPUPPCState *env, target_ulong addr,           \
-                   target_ulong xt_num, target_ulong rb)          \
+                   ppc_vsr_t *xt, target_ulong rb)                \
 {                                                                 \
-    ppc_vsr_t *xt = &env->vsr[xt_num];                            \
     target_ulong nb = GET_NB(rb);                                 \
     int i;                                                        \
                                                                   \
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 5cf053e7f2..e853ee1386 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -344,29 +344,30 @@ VSX_VECTOR_STORE(stxv, st_i64, 0)
 VSX_VECTOR_STORE(stxvx, st_i64, 1)
 
 #ifdef TARGET_PPC64
-#define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
-static void gen_##name(DisasContext *ctx)                       \
-{                                                               \
-    TCGv EA, xt;                                                \
-                                                                \
-    if (xT(ctx->opcode) < 32) {                                 \
-        if (unlikely(!ctx->vsx_enabled)) {                      \
-            gen_exception(ctx, POWERPC_EXCP_VSXU);              \
-            return;                                             \
-        }                                                       \
-    } else {                                                    \
-        if (unlikely(!ctx->altivec_enabled)) {                  \
-            gen_exception(ctx, POWERPC_EXCP_VPU);               \
-            return;                                             \
-        }                                                       \
-    }                                                           \
-    EA = tcg_temp_new();                                        \
-    xt = tcg_const_tl(xT(ctx->opcode));                         \
-    gen_set_access_type(ctx, ACCESS_INT);                       \
-    gen_addr_register(ctx, EA);                                 \
-    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
-    tcg_temp_free(EA);                                          \
-    tcg_temp_free(xt);                                          \
+#define VSX_VECTOR_LOAD_STORE_LENGTH(name)                         \
+static void gen_##name(DisasContext *ctx)                          \
+{                                                                  \
+    TCGv EA;                                                       \
+    TCGv_ptr xt;                                                   \
+                                                                   \
+    if (xT(ctx->opcode) < 32) {                                    \
+        if (unlikely(!ctx->vsx_enabled)) {                         \
+            gen_exception(ctx, POWERPC_EXCP_VSXU);                 \
+            return;                                                \
+        }                                                          \
+    } else {                                                       \
+        if (unlikely(!ctx->altivec_enabled)) {                     \
+            gen_exception(ctx, POWERPC_EXCP_VPU);                  \
+            return;                                                \
+        }                                                          \
+    }                                                              \
+    EA = tcg_temp_new();                                           \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                             \
+    gen_set_access_type(ctx, ACCESS_INT);                          \
+    gen_addr_register(ctx, EA);                                    \
+    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]);  \
+    tcg_temp_free(EA);                                             \
+    tcg_temp_free_ptr(xt);                                         \
 }
 
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
-- 
2.11.0


