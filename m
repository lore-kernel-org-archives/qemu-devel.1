Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36BAC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B911208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B911208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i30wU-0007hU-2Z
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30mp-0006u2-IZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30mm-0007np-Sj
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55247 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i30mm-0007lm-DX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0BD7F1A22BD;
 Wed, 28 Aug 2019 18:27:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id C6E791A22A6;
 Wed, 28 Aug 2019 18:26:59 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 18:26:29 +0200
Message-Id: <1567009614-12438-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 05/30] target/mips: Clean up handling of CP0
 register 4
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

Clean up handling of CP0 register 4.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  2 ++
 target/mips/translate.c | 44 ++++++++++++++++++++++++--------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index c2ef942..04d4b09 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -307,7 +307,9 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG03__TCOPT           7
 /* CP0 Register 04 */
 #define CP0_REG04__CONTEXT         0
+#define CP0_REG04__CONTEXTCONFIG   1
 #define CP0_REG04__USERLOCAL       2
+#define CP0_REG04__XCONTEXTCONFIG  3
 #define CP0_REG04__DBGCONTEXTID    4
 #define CP0_REG04__MEMORYMAPID     5
 /* CP0 Register 05 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 013dd53..677a2d0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7015,23 +7015,24 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_04:
         switch (sel) {
-        case 0:
+        case CP0_REG04__CONTEXT:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
             tcg_gen_ext32s_tl(arg, arg);
             register_name = "Context";
             break;
-        case 1:
-            /* gen_helper_mfc0_contextconfig(arg); - SmartMIPS ASE */
+        case CP0_REG04__CONTEXTCONFIG:
+            /* SmartMIPS ASE */
+            /* gen_helper_mfc0_contextconfig(arg); */
             register_name = "ContextConfig";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG04__USERLOCAL:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             tcg_gen_ext32s_tl(arg, arg);
             register_name = "UserLocal";
             break;
-        case 5:
+        case CP0_REG04__MEMORYMAPID:
             CP0_CHECK(ctx->mi);
             gen_helper_mtc0_memorymapid(cpu_env, arg);
             register_name = "MemoryMapID";
@@ -7758,21 +7759,22 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_04:
         switch (sel) {
-        case 0:
+        case CP0_REG04__CONTEXT:
             gen_helper_mtc0_context(cpu_env, arg);
             register_name = "Context";
             break;
-        case 1:
-//            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
+        case CP0_REG04__CONTEXTCONFIG:
+            /* SmartMIPS ASE */
+            /* gen_helper_mtc0_contextconfig(cpu_env, arg); */
             register_name = "ContextConfig";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG04__USERLOCAL:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
-        case 5:
+        case CP0_REG04__MEMORYMAPID:
             CP0_CHECK(ctx->mi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MemoryMapID));
             register_name = "MemoryMapID";
@@ -8509,21 +8511,22 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_04:
         switch (sel) {
-        case 0:
+        case CP0_REG04__CONTEXT:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
             register_name = "Context";
             break;
-        case 1:
-//            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
+        case CP0_REG04__CONTEXTCONFIG:
+            /* SmartMIPS ASE */
+            /* gen_helper_dmfc0_contextconfig(arg); */
             register_name = "ContextConfig";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG04__USERLOCAL:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
-        case 5:
+        case CP0_REG04__MEMORYMAPID:
             CP0_CHECK(ctx->mi);
             gen_helper_mtc0_memorymapid(cpu_env, arg);
             register_name = "MemoryMapID";
@@ -9230,21 +9233,22 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_04:
         switch (sel) {
-        case 0:
+        case CP0_REG04__CONTEXT:
             gen_helper_mtc0_context(cpu_env, arg);
             register_name = "Context";
             break;
-        case 1:
-//           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
+        case CP0_REG04__CONTEXTCONFIG:
+            /* SmartMIPS ASE */
+            /* gen_helper_mtc0_contextconfig(cpu_env, arg); */
             register_name = "ContextConfig";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG04__USERLOCAL:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             register_name = "UserLocal";
             break;
-        case 5:
+        case CP0_REG04__MEMORYMAPID:
             CP0_CHECK(ctx->mi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MemoryMapID));
             register_name = "MemoryMapID";
-- 
2.7.4


