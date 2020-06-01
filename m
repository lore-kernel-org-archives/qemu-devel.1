Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E979DC433E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52072077D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="csGvDCFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52072077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfm9V-0003lq-1I
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jfm6Z-0007xC-Pl
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 11:11:59 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18]:42106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jfm6X-0004eI-Ko
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 11:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+2UOkjd4CYCT0BLOA2BBvzwcj+w8vK3L2EhivhzfVUg=; b=csGvDCFOBgXzQ58yxrkKWBu79y
 qJEiXXJlNjQSZNtUcTAjb00PciwGyGN4aidlvE6dnhGFHZN849iDGvXmmQnudocE34UkZzzVyPmUL
 STRKeGwdNbw+hHxgFx9jjNmzi9MlOW6nd3o7XshcxubOR+7SbMsrwYc0y2DhfrtJMv/0=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] target/tricore: Raise EXCP_DEBUG in gen_goto_tb() for
 singlestep
Date: Mon,  1 Jun 2020 17:11:17 +0200
Message-Id: <20200601151119.33196-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601151119.33196-1-kbastian@mail.uni-paderborn.de>
References: <20200601151119.33196-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.1.150018, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.1.5740002
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6661699, da=78633380,
 mc=166, sc=3, hc=163, sp=1, fso=6661699, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this is needed for remote gdb connections.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20200529072148.284037-4-kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 608f72d384..7752630ac1 100644
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
2.26.2


