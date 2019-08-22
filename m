Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01313C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFC02339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFC02339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lbV-00032A-9q
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lP7-0004jk-RT
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lP3-0007sD-JY
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48246 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i0lOw-0007k3-C2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0966D1A20E1;
 Thu, 22 Aug 2019 13:35:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id C81B71A2077;
 Thu, 22 Aug 2019 13:35:58 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 13:35:40 +0200
Message-Id: <1566473750-17743-17-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 16/26] target/mips: Clean up handling of CP0
 register 19
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
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 19.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  4 ++++
 target/mips/translate.c | 64 ++++++++++++++++++++++++-------------------------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b18c87b..811986b 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -391,6 +391,10 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG19__WATCHHI1        1
 #define CP0_REG19__WATCHHI2        2
 #define CP0_REG19__WATCHHI3        3
+#define CP0_REG19__WATCHHI4        4
+#define CP0_REG19__WATCHHI5        5
+#define CP0_REG19__WATCHHI6        6
+#define CP0_REG19__WATCHHI7        7
 /* CP0 Register 20 */
 #define CP0_REG20__XCONTEXT        0
 /* CP0 Register 21 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8c66db4..40df031 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7370,14 +7370,14 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_19:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG19__WATCHHI0:
+        case CP0_REG19__WATCHHI1:
+        case CP0_REG19__WATCHHI2:
+        case CP0_REG19__WATCHHI3:
+        case CP0_REG19__WATCHHI4:
+        case CP0_REG19__WATCHHI5:
+        case CP0_REG19__WATCHHI6:
+        case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             register_name = "WatchHi";
@@ -8109,14 +8109,14 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_19:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG19__WATCHHI0:
+        case CP0_REG19__WATCHHI1:
+        case CP0_REG19__WATCHHI2:
+        case CP0_REG19__WATCHHI3:
+        case CP0_REG19__WATCHHI4:
+        case CP0_REG19__WATCHHI5:
+        case CP0_REG19__WATCHHI6:
+        case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             register_name = "WatchHi";
@@ -8854,14 +8854,14 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_19:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG19__WATCHHI0:
+        case CP0_REG19__WATCHHI1:
+        case CP0_REG19__WATCHHI2:
+        case CP0_REG19__WATCHHI3:
+        case CP0_REG19__WATCHHI4:
+        case CP0_REG19__WATCHHI5:
+        case CP0_REG19__WATCHHI6:
+        case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(dmfc0_watchhi, arg, sel);
             register_name = "WatchHi";
@@ -9575,14 +9575,14 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_19:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG19__WATCHHI0:
+        case CP0_REG19__WATCHHI1:
+        case CP0_REG19__WATCHHI2:
+        case CP0_REG19__WATCHHI3:
+        case CP0_REG19__WATCHHI4:
+        case CP0_REG19__WATCHHI5:
+        case CP0_REG19__WATCHHI6:
+        case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             register_name = "WatchHi";
-- 
2.7.4


