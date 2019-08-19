Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B12C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C3020843
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C3020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgrz-0001YJ-62
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTo-00029F-AX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTm-0002kC-Cl
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57999 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzgTl-0002ak-UN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0196C1A21BB;
 Mon, 19 Aug 2019 14:08:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 80B971A2136;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:07:56 +0200
Message-Id: <1566216496-17375-18-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 17/37] target/mips: Clean up handling of CP0
 register 0
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 0.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  3 +++
 target/mips/translate.c | 40 ++++++++++++++++++++--------------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index eda8350..e2f6844 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -279,6 +279,9 @@ typedef struct mips_def_t mips_def_t;
 
 /* CP0 Register 00 */
 #define CP0_REG00__INDEX           0
+#define CP0_REG00__MVPCONTROL      1
+#define CP0_REG00__MVPCONF0        2
+#define CP0_REG00__MVPCONF1        3
 #define CP0_REG00__VPCONTROL       4
 /* CP0 Register 01 */
 /* CP0 Register 02 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index fe4a05c..06a1646 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6853,26 +6853,26 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     switch (reg) {
     case CP0_REGISTER_00:
         switch (sel) {
-        case 0:
+        case CP0_REG00__INDEX:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
             register_name = "Index";
             break;
-        case 1:
+        case CP0_REG00__MVPCONTROL:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpcontrol(arg, cpu_env);
             register_name = "MVPControl";
             break;
-        case 2:
+        case CP0_REG00__MVPCONF0:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpconf0(arg, cpu_env);
             register_name = "MVPConf0";
             break;
-        case 3:
+        case CP0_REG00__MVPCONF1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpconf1(arg, cpu_env);
             register_name = "MVPConf1";
             break;
-        case 4:
+        case CP0_REG00__VPCONTROL:
             CP0_CHECK(ctx->vp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPControl));
             register_name = "VPControl";
@@ -7621,26 +7621,26 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     switch (reg) {
     case CP0_REGISTER_00:
         switch (sel) {
-        case 0:
+        case CP0_REG00__INDEX:
             gen_helper_mtc0_index(cpu_env, arg);
             register_name = "Index";
             break;
-        case 1:
+        case CP0_REG00__MVPCONTROL:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_mvpcontrol(cpu_env, arg);
             register_name = "MVPControl";
             break;
-        case 2:
+        case CP0_REG00__MVPCONF0:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             /* ignored */
             register_name = "MVPConf0";
             break;
-        case 3:
+        case CP0_REG00__MVPCONF1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             /* ignored */
             register_name = "MVPConf1";
             break;
-        case 4:
+        case CP0_REG00__VPCONTROL:
             CP0_CHECK(ctx->vp);
             /* ignored */
             register_name = "VPControl";
@@ -8373,26 +8373,26 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     switch (reg) {
     case CP0_REGISTER_00:
         switch (sel) {
-        case 0:
+        case CP0_REG00__INDEX:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
             register_name = "Index";
             break;
-        case 1:
+        case CP0_REG00__MVPCONTROL:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpcontrol(arg, cpu_env);
             register_name = "MVPControl";
             break;
-        case 2:
+        case CP0_REG00__MVPCONF0:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpconf0(arg, cpu_env);
             register_name = "MVPConf0";
             break;
-        case 3:
+        case CP0_REG00__MVPCONF1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpconf1(arg, cpu_env);
             register_name = "MVPConf1";
             break;
-        case 4:
+        case CP0_REG00__VPCONTROL:
             CP0_CHECK(ctx->vp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPControl));
             register_name = "VPControl";
@@ -9095,26 +9095,26 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     switch (reg) {
     case CP0_REGISTER_00:
         switch (sel) {
-        case 0:
+        case CP0_REG00__INDEX:
             gen_helper_mtc0_index(cpu_env, arg);
             register_name = "Index";
             break;
-        case 1:
+        case CP0_REG00__MVPCONTROL:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_mvpcontrol(cpu_env, arg);
             register_name = "MVPControl";
             break;
-        case 2:
+        case CP0_REG00__MVPCONF0:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             /* ignored */
             register_name = "MVPConf0";
             break;
-        case 3:
+        case CP0_REG00__MVPCONF1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             /* ignored */
             register_name = "MVPConf1";
             break;
-        case 4:
+        case CP0_REG00__VPCONTROL:
             CP0_CHECK(ctx->vp);
             /* ignored */
             register_name = "VPControl";
-- 
2.7.4


