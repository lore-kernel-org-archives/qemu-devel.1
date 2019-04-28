Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A7C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 15:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFD0206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 15:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFD0206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKlNw-0002J8-Cz
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 11:06:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlM7-00010P-Dh
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlM5-0008BJ-G2
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:04:39 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:53040
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKlM5-00086O-Aa; Sun, 28 Apr 2019 11:04:37 -0400
Received: from host86-175-31-255.range86-175.btcentralplus.com
	([86.175.31.255] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKkxK-0005tp-Rc; Sun, 28 Apr 2019 15:39:03 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun, 28 Apr 2019 15:38:42 +0100
Message-Id: <20190428143845.11810-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 86.175.31.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 11/14] target/ppc: decode target register in
 VSX_VECTOR_LOAD_STORE_LENGTH at translation time
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
Message-ID: <20190428143842.d64m5IFxeR5Zdgn99lJ5sE4DyabXb9nwLpfZh2qpTqY@z>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/helper.h                 | 8 ++++----
 target/ppc/mem_helper.c             | 6 ++----
 target/ppc/translate/vsx-impl.inc.c | 7 ++++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 167d6e45fd..5f844cc968 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -291,10 +291,10 @@ DEF_HELPER_3(stvebx, void, env, avr, tl)
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
index 4dfa7ee23f..f3426315d2 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -415,9 +415,8 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
 
 #define VSX_LXVL(name, lj)                                              \
 void helper_##name(CPUPPCState *env, target_ulong addr,                 \
-                   target_ulong xt, target_ulong rb)                    \
+                   ppc_vsr_t *r, target_ulong rb)                       \
 {                                                                       \
-    ppc_vsr_t *r = &env->vsr[xt];                                       \
     int nb = GET_NB(env->gpr[rb]);                                      \
     int i;                                                              \
                                                                         \
@@ -444,9 +443,8 @@ VSX_LXVL(lxvll, 1)
 
 #define VSX_STXVL(name, lj)                                       \
 void helper_##name(CPUPPCState *env, target_ulong addr,           \
-                   target_ulong xt, target_ulong rb)              \
+                   ppc_vsr_t *r, target_ulong rb)                 \
 {                                                                 \
-    ppc_vsr_t *r = &env->vsr[xt];                                 \
     int nb = GET_NB(env->gpr[rb]);                                \
     int i;                                                        \
                                                                   \
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 51d4e0cdd6..7c79ec22dd 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -297,7 +297,8 @@ VSX_VECTOR_LOAD_STORE(stxvx, st_i64, 1)
 #define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
-    TCGv EA, xt, rb;                                            \
+    TCGv EA, rb;                                                \
+    TCGv_ptr xt;                                                \
                                                                 \
     if (xT(ctx->opcode) < 32) {                                 \
         if (unlikely(!ctx->vsx_enabled)) {                      \
@@ -313,12 +314,12 @@ static void gen_##name(DisasContext *ctx)                       \
     EA = tcg_temp_new();                                        \
     gen_set_access_type(ctx, ACCESS_INT);                       \
     gen_addr_register(ctx, EA);                                 \
-    xt = tcg_const_tl(xT(ctx->opcode));                         \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                          \
     rb = tcg_const_tl(rB(ctx->opcode));                         \
     gen_helper_##name(cpu_env, EA, xt, rb);                     \
     tcg_temp_free(EA);                                          \
-    tcg_temp_free(xt);                                          \
     tcg_temp_free(rb);                                          \
+    tcg_temp_free_ptr(xt);                                      \
 }
 
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
-- 
2.11.0


