Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288ABC31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88B720866
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 13:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88B720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcUts-0006Qq-1F
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 09:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48108)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUqH-0004CX-9B
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUqG-0005QY-0L
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 09:05:05 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:46554
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUqA-0005Fb-6l; Sun, 16 Jun 2019 09:05:00 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUQ6-0001jp-DE; Sun, 16 Jun 2019 13:38:02 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 rth@twiddle.net, gkurz@kaod.org
Date: Sun, 16 Jun 2019 13:37:50 +0100
Message-Id: <20190616123751.781-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
References: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v3 14/15] target/ppc: decode target register in
 VSX_EXTRACT_INSERT at translation time
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
 target/ppc/helper.h                 |  4 ++--
 target/ppc/int_helper.c             | 12 ++++--------
 target/ppc/translate/vsx-impl.inc.c | 10 +++++-----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 7ed9effff2..3d5150a524 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -534,8 +534,8 @@ DEF_HELPER_3(xvrspip, void, env, vsr, vsr)
 DEF_HELPER_3(xvrspiz, void, env, vsr, vsr)
 DEF_HELPER_4(xxperm, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xxpermr, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
-DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
+DEF_HELPER_4(xxextractuw, void, env, vsr, vsr, i32)
+DEF_HELPER_4(xxinsertw, void, env, vsr, vsr, i32)
 DEF_HELPER_3(xvxsigsp, void, env, vsr, vsr)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 3b8939edcc..5c07ef3e4d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1899,11 +1899,9 @@ VEXTRACT(uw, u32)
 VEXTRACT(d, u64)
 #undef VEXTRACT
 
-void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
-                        target_ulong xbn, uint32_t index)
+void helper_xxextractuw(CPUPPCState *env, ppc_vsr_t *xt,
+                        ppc_vsr_t *xb, uint32_t index)
 {
-    ppc_vsr_t *xt = &env->vsr[xtn];
-    ppc_vsr_t *xb = &env->vsr[xbn];
     ppc_vsr_t t = { };
     size_t es = sizeof(uint32_t);
     uint32_t ext_index;
@@ -1917,11 +1915,9 @@ void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
     *xt = t;
 }
 
-void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
-                      target_ulong xbn, uint32_t index)
+void helper_xxinsertw(CPUPPCState *env, ppc_vsr_t *xt,
+                      ppc_vsr_t *xb, uint32_t index)
 {
-    ppc_vsr_t *xt = &env->vsr[xtn];
-    ppc_vsr_t *xb = &env->vsr[xbn];
     ppc_vsr_t t = *xt;
     size_t es = sizeof(uint32_t);
     int ins_index, i = 0;
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index e853ee1386..7a4b7cb8f9 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1632,7 +1632,7 @@ static void gen_xxsldwi(DisasContext *ctx)
 #define VSX_EXTRACT_INSERT(name)                                \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
-    TCGv xt, xb;                                                \
+    TCGv_ptr xt, xb;                                            \
     TCGv_i32 t0;                                                \
     TCGv_i64 t1;                                                \
     uint8_t uimm = UIMM4(ctx->opcode);                          \
@@ -1641,8 +1641,8 @@ static void gen_##name(DisasContext *ctx)                       \
         gen_exception(ctx, POWERPC_EXCP_VSXU);                  \
         return;                                                 \
     }                                                           \
-    xt = tcg_const_tl(xT(ctx->opcode));                         \
-    xb = tcg_const_tl(xB(ctx->opcode));                         \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                          \
+    xb = gen_vsr_ptr(xB(ctx->opcode));                          \
     t0 = tcg_temp_new_i32();                                    \
     t1 = tcg_temp_new_i64();                                    \
     /*                                                          \
@@ -1657,8 +1657,8 @@ static void gen_##name(DisasContext *ctx)                       \
     }                                                           \
     tcg_gen_movi_i32(t0, uimm);                                 \
     gen_helper_##name(cpu_env, xt, xb, t0);                     \
-    tcg_temp_free(xb);                                          \
-    tcg_temp_free(xt);                                          \
+    tcg_temp_free_ptr(xb);                                      \
+    tcg_temp_free_ptr(xt);                                      \
     tcg_temp_free_i32(t0);                                      \
     tcg_temp_free_i64(t1);                                      \
 }
-- 
2.11.0


