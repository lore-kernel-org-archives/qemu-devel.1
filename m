Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F1AC43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 15:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA32A2067C
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 15:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA32A2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKlQk-0004Rn-1L
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 11:09:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlMQ-0001GW-Mr
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlMP-0008Lc-K3
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:04:58 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:53060
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKlMP-0008LI-EY; Sun, 28 Apr 2019 11:04:57 -0400
Received: from host86-175-31-255.range86-175.btcentralplus.com
	([86.175.31.255] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKkxL-0005tp-99; Sun, 28 Apr 2019 15:39:03 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun, 28 Apr 2019 15:38:43 +0100
Message-Id: <20190428143845.11810-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.175.31.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 12/14] target/ppc: decode target register in
 VSX_EXTRACT_INSERT at translation time
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190428143843.-juMo4FY4cXprYRA29YPWxaMFFJlqk_GqCT55mO1EIU@z>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/helper.h                 |  4 ++--
 target/ppc/int_helper.c             | 12 ++++--------
 target/ppc/translate/vsx-impl.inc.c | 10 +++++-----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5f844cc968..81630a5f23 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -546,8 +546,8 @@ DEF_HELPER_4(xvrspip, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrspiz, void, env, i32, vsr, vsr)
 DEF_HELPER_5(xxperm, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xxpermr, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
-DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
+DEF_HELPER_4(xxextractuw, void, env, vsr, vsr, i32)
+DEF_HELPER_4(xxinsertw, void, env, vsr, vsr, i32)
 DEF_HELPER_4(xvxsigsp, void, env, i32, vsr, vsr)
 
 DEF_HELPER_2(efscfsi, i32, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f616fb249d..10e7ee5943 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1901,11 +1901,9 @@ VEXTRACT(uw, u32)
 VEXTRACT(d, u64)
 #undef VEXTRACT
 
-void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
-                        target_ulong xbn, uint32_t index)
+void helper_xxextractuw(CPUPPCState *env, ppc_vsr_t *xt,
+                        ppc_vsr_t *xb, uint32_t index)
 {
-    ppc_vsr_t *xt = &env->vsr[xtn];
-    ppc_vsr_t *xb = &env->vsr[xbn];
     size_t es = sizeof(uint32_t);
     uint32_t ext_index;
     int i;
@@ -1918,11 +1916,9 @@ void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
     }
 }
 
-void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
-                      target_ulong xbn, uint32_t index)
+void helper_xxinsertw(CPUPPCState *env, ppc_vsr_t *xt,
+                      ppc_vsr_t *xb, uint32_t index)
 {
-    ppc_vsr_t *xt = &env->vsr[xtn];
-    ppc_vsr_t *xb = &env->vsr[xbn];
     size_t es = sizeof(uint32_t);
     int ins_index, i = 0;
 
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 7c79ec22dd..b8f24b7462 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1569,7 +1569,7 @@ static void gen_xxsldwi(DisasContext *ctx)
 #define VSX_EXTRACT_INSERT(name)                                \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
-    TCGv xt, xb;                                                \
+    TCGv_ptr xt, xb;                                            \
     TCGv_i32 t0;                                                \
     TCGv_i64 t1;                                                \
     uint8_t uimm = UIMM4(ctx->opcode);                          \
@@ -1578,8 +1578,8 @@ static void gen_##name(DisasContext *ctx)                       \
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
@@ -1594,8 +1594,8 @@ static void gen_##name(DisasContext *ctx)                       \
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


