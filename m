Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65BC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DCC2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="HGhM/Vv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DCC2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEv85-0003se-BC
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 08:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv54-0002Ne-37
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv4y-00026I-ES
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:07 -0400
Received: from shirlock.uni-paderborn.de ([131.234.189.15]:41592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1iEv4v-00023Q-Ii
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DoC4yC3pCfWSy/5/JOXogILAP/aItpTjEcvfcPqShOo=; b=HGhM/Vv8ZychWydBfuo2XJLOiG
 UvUFcD/wSppBlDf/ipoWUcLz/zlsfqRHWMZoQF5ovgQ68RYqvixiPGFMi+J1cQZ6aw1o5MEJw2J/x
 8vHSIIl2zyPAi9uYXBQllswTZgawD04MDy0mDsqNTNtkjoeO43boeKrb9kUAjISWWgBE=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/tricore: Raise EXCP_DEBUG in gen_goto_tb() for
 singlestep
Date: Mon, 30 Sep 2019 14:46:41 +0200
Message-Id: <20190930124643.179695-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
References: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.9.30.124217, AntiVirus-Engine: 5.65.0,
 AntiVirus-Data: 2019.9.27.5650000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 131.234.189.15
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this is needed for remote gdb connections.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 832ff6328d..6c6303795d 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3238,6 +3238,14 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 #endif
 }
 
+static void generate_qemu_excp(DisasContext *ctx, int excp)
+{
+    TCGv_i32 tmp = tcg_const_i32(excp);
+    gen_helper_qemu_excp(cpu_env, tmp);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    tcg_temp_free(tmp);
+}
+
 static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 {
     if (use_goto_tb(ctx, dest)) {
@@ -3247,7 +3255,7 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     } else {
         gen_save_pc(dest);
         if (ctx->base.singlestep_enabled) {
-            /* raise exception debug */
+            generate_qemu_excp(ctx, EXCP_DEBUG);
         }
         tcg_gen_exit_tb(NULL, 0);
     }
@@ -3266,14 +3274,6 @@ static void generate_trap(DisasContext *ctx, int class, int tin)
     tcg_temp_free(tintemp);
 }
 
-static void generate_qemu_excp(DisasContext *ctx, int excp)
-{
-    TCGv_i32 tmp = tcg_const_i32(excp);
-    gen_helper_qemu_excp(cpu_env, tmp);
-    ctx->base.is_jmp = DISAS_NORETURN;
-    tcg_temp_free(tmp);
-}
-
 static inline void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
                                    TCGv r2, int16_t address)
 {
-- 
2.23.0


