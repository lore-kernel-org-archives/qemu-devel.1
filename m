Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5135BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BF922CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BF922CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lsP-0007sc-65
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 08:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lPO-0005FE-Fw
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lPJ-00087d-QK
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:38 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49986 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i0lPI-0007sS-K3
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 5882D1A2077;
 Thu, 22 Aug 2019 13:35:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1C9A31A20CC;
 Thu, 22 Aug 2019 13:35:59 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 13:35:47 +0200
Message-Id: <1566473750-17743-24-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 23/26] target/mips: Clean up handling of CP0
 register 28
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

Clean up handling of CP0 register 28.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 24 +++++++++++--------
 target/mips/translate.c | 64 ++++++++++++++++++++++++-------------------------
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 80c896b..55ada8c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -235,12 +235,12 @@ typedef struct mips_def_t mips_def_t;
  *
  * 0   DataLo            DataHi            ErrorEPC          DESAVE
  * 1   TagLo             TagHi
- * 2   DataLo            DataHi                              KScratch<n>
- * 3   TagLo             TagHi                               KScratch<n>
- * 4   DataLo            DataHi                              KScratch<n>
- * 5   TagLo             TagHi                               KScratch<n>
- * 6   DataLo            DataHi                              KScratch<n>
- * 7   TagLo             TagHi                               KScratch<n>
+ * 2   DataLo1           DataHi                              KScratch<n>
+ * 3   TagLo1            TagHi                               KScratch<n>
+ * 4   DataLo2           DataHi                              KScratch<n>
+ * 5   TagLo2            TagHi                               KScratch<n>
+ * 6   DataLo3           DataHi                              KScratch<n>
+ * 7   TagLo3            TagHi                               KScratch<n>
  *
  */
 #define CP0_REGISTER_00     0
@@ -423,10 +423,14 @@ typedef struct mips_def_t mips_def_t;
 /* CP0 Register 27 */
 #define CP0_REG27__CACHERR         0
 /* CP0 Register 28 */
-#define CP0_REG28__ITAGLO          0
-#define CP0_REG28__IDATALO         1
-#define CP0_REG28__DTAGLO          2
-#define CP0_REG28__DDATALO         3
+#define CP0_REG28__TAGLO           0
+#define CP0_REG28__DATALO          1
+#define CP0_REG28__TAGLO1          2
+#define CP0_REG28__DATALO1         3
+#define CP0_REG28__TAGLO2          4
+#define CP0_REG28__DATALO2         5
+#define CP0_REG28__TAGLO3          6
+#define CP0_REG28__DATALO3         7
 /* CP0 Register 29 */
 #define CP0_REG29__IDATAHI         1
 #define CP0_REG29__DDATAHI         3
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 936c51c..6f5eed7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7523,10 +7523,10 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_28:
         switch (sel) {
-        case 0:
-        case 2:
-        case 4:
-        case 6:
+        case CP0_REG28__TAGLO:
+        case CP0_REG28__TAGLO1:
+        case CP0_REG28__TAGLO2:
+        case CP0_REG28__TAGLO3:
             {
                 TCGv_i64 tmp = tcg_temp_new_i64();
                 tcg_gen_ld_i64(tmp, cpu_env, offsetof(CPUMIPSState, CP0_TagLo));
@@ -7535,10 +7535,10 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             }
             register_name = "TagLo";
             break;
-        case 1:
-        case 3:
-        case 5:
-        case 7:
+        case CP0_REG28__DATALO:
+        case CP0_REG28__DATALO1:
+        case CP0_REG28__DATALO2:
+        case CP0_REG28__DATALO3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DataLo));
             register_name = "DataLo";
             break;
@@ -8282,17 +8282,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
        break;
     case CP0_REGISTER_28:
         switch (sel) {
-        case 0:
-        case 2:
-        case 4:
-        case 6:
+        case CP0_REG28__TAGLO:
+        case CP0_REG28__TAGLO1:
+        case CP0_REG28__TAGLO2:
+        case CP0_REG28__TAGLO3:
             gen_helper_mtc0_taglo(cpu_env, arg);
             register_name = "TagLo";
             break;
-        case 1:
-        case 3:
-        case 5:
-        case 7:
+        case CP0_REG28__DATALO:
+        case CP0_REG28__DATALO1:
+        case CP0_REG28__DATALO2:
+        case CP0_REG28__DATALO3:
             gen_helper_mtc0_datalo(cpu_env, arg);
             register_name = "DataLo";
             break;
@@ -9018,17 +9018,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_28:
         switch (sel) {
-        case 0:
-        case 2:
-        case 4:
-        case 6:
+        case CP0_REG28__TAGLO:
+        case CP0_REG28__TAGLO1:
+        case CP0_REG28__TAGLO2:
+        case CP0_REG28__TAGLO3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_TagLo));
             register_name = "TagLo";
             break;
-        case 1:
-        case 3:
-        case 5:
-        case 7:
+        case CP0_REG28__DATALO:
+        case CP0_REG28__DATALO1:
+        case CP0_REG28__DATALO2:
+        case CP0_REG28__DATALO3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DataLo));
             register_name = "DataLo";
             break;
@@ -9758,17 +9758,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_28:
         switch (sel) {
-        case 0:
-        case 2:
-        case 4:
-        case 6:
+        case CP0_REG28__TAGLO:
+        case CP0_REG28__TAGLO1:
+        case CP0_REG28__TAGLO2:
+        case CP0_REG28__TAGLO3:
             gen_helper_mtc0_taglo(cpu_env, arg);
             register_name = "TagLo";
             break;
-        case 1:
-        case 3:
-        case 5:
-        case 7:
+        case CP0_REG28__DATALO:
+        case CP0_REG28__DATALO1:
+        case CP0_REG28__DATALO2:
+        case CP0_REG28__DATALO3:
             gen_helper_mtc0_datalo(cpu_env, arg);
             register_name = "DataLo";
             break;
-- 
2.7.4


