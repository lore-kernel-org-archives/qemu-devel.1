Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2325C3A5A6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDA5208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDA5208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i30wU-0007hs-EK
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30n1-0007Aa-Ff
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30my-00082v-WA
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:19 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55631 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i30my-0007oj-GM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:16 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id AE7DC1A22A5;
 Wed, 28 Aug 2019 18:27:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4F0711A22BE;
 Wed, 28 Aug 2019 18:27:00 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 18:26:43 +0200
Message-Id: <1567009614-12438-20-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 19/30] target/mips: Clean up handling of CP0
 register 18
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 18.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 20 +++++++++-------
 target/mips/translate.c | 64 ++++++++++++++++++++++++-------------------------
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7855de8..6881e96 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -194,14 +194,14 @@ typedef struct mips_def_t mips_def_t;
  *     Register 16       Register 17       Register 18       Register 19
  *     -----------       -----------       -----------       -----------
  *
- * 0   Config            LLAddr            WatchLo           WatchHi
- * 1   Config1           MAAR              WatchLo           WatchHi
- * 2   Config2           MAARI             WatchLo           WatchHi
- * 3   Config3                             WatchLo           WatchHi
- * 4   Config4                             WatchLo           WatchHi
- * 5   Config5                             WatchLo           WatchHi
- * 6                                       WatchLo           WatchHi
- * 7                                       WatchLo           WatchHi
+ * 0   Config            LLAddr            WatchLo0          WatchHi
+ * 1   Config1           MAAR              WatchLo1          WatchHi
+ * 2   Config2           MAARI             WatchLo2          WatchHi
+ * 3   Config3                             WatchLo3          WatchHi
+ * 4   Config4                             WatchLo4          WatchHi
+ * 5   Config5                             WatchLo5          WatchHi
+ * 6                                       WatchLo6          WatchHi
+ * 7                                       WatchLo7          WatchHi
  *
  *
  *     Register 20       Register 21       Register 22       Register 23
@@ -388,6 +388,10 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG18__WATCHLO1        1
 #define CP0_REG18__WATCHLO2        2
 #define CP0_REG18__WATCHLO3        3
+#define CP0_REG18__WATCHLO4        4
+#define CP0_REG18__WATCHLO5        5
+#define CP0_REG18__WATCHLO6        6
+#define CP0_REG18__WATCHLO7        7
 /* CP0 Register 19 */
 #define CP0_REG19__WATCHHI0        0
 #define CP0_REG19__WATCHHI1        1
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6842531..adc1049 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7353,14 +7353,14 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_18:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG18__WATCHLO0:
+        case CP0_REG18__WATCHLO1:
+        case CP0_REG18__WATCHLO2:
+        case CP0_REG18__WATCHLO3:
+        case CP0_REG18__WATCHLO4:
+        case CP0_REG18__WATCHLO5:
+        case CP0_REG18__WATCHLO6:
+        case CP0_REG18__WATCHLO7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchlo, arg, sel);
             register_name = "WatchLo";
@@ -8093,14 +8093,14 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_18:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG18__WATCHLO0:
+        case CP0_REG18__WATCHLO1:
+        case CP0_REG18__WATCHLO2:
+        case CP0_REG18__WATCHLO3:
+        case CP0_REG18__WATCHLO4:
+        case CP0_REG18__WATCHLO5:
+        case CP0_REG18__WATCHLO6:
+        case CP0_REG18__WATCHLO7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             register_name = "WatchLo";
@@ -8839,14 +8839,14 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_18:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG18__WATCHLO0:
+        case CP0_REG18__WATCHLO1:
+        case CP0_REG18__WATCHLO2:
+        case CP0_REG18__WATCHLO3:
+        case CP0_REG18__WATCHLO4:
+        case CP0_REG18__WATCHLO5:
+        case CP0_REG18__WATCHLO6:
+        case CP0_REG18__WATCHLO7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(dmfc0_watchlo, arg, sel);
             register_name = "WatchLo";
@@ -9561,14 +9561,14 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_18:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG18__WATCHLO0:
+        case CP0_REG18__WATCHLO1:
+        case CP0_REG18__WATCHLO2:
+        case CP0_REG18__WATCHLO3:
+        case CP0_REG18__WATCHLO4:
+        case CP0_REG18__WATCHLO5:
+        case CP0_REG18__WATCHLO6:
+        case CP0_REG18__WATCHLO7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             register_name = "WatchLo";
-- 
2.7.4


