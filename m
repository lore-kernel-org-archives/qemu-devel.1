Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFC0C43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEF32073F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEF32073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf6FU-0001ng-Rk
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 13:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34290)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wg-0001kq-Vb
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wc-0004jb-3b
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39474 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hf5wV-0003MV-Am
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:17 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 59A6C1A1D2D;
 Sun, 23 Jun 2019 19:05:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 3D9F61A1D2A;
 Sun, 23 Jun 2019 19:05:11 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sun, 23 Jun 2019 19:04:35 +0200
Message-Id: <1561309489-16146-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 02/16] tcg/ppc: Introduce flag
 have_isa_altivec
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
Cc: richard.henderson@linaro.org,
 "David Gibson --cc=amarkovic @ wavecomp . com"
 <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Detect during initialization if the emulated CPU supports Altivec,
and store the result in the flag have_isa_altivec. The definition
of Altivec SIMD instructions set evolved over time. Different
generations of Altivec will be distinguished by other flags in TCG,
and they are currently have_isa_2_06 and have_isa_3_00.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     | 25 +++++++++++++++++++++++++
 tcg/ppc/tcg-target.inc.c |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 690fa74..f6283f4 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -58,6 +58,7 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
+extern bool have_isa_altivec;
 extern bool have_isa_2_06;
 extern bool have_isa_3_00;
 
@@ -135,6 +136,30 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
+/*
+ * While technically Altivec could support V64, it has no 64-bit store
+ * instruction and substituting two 32-bit stores makes the generated
+ * code quite large.
+ */
+#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v128             have_isa_altivec
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_cmp_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+
 void flush_icache_range(uintptr_t start, uintptr_t stop);
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 8e1bba7..26892de 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -64,6 +64,7 @@
 
 static tcg_insn_unit *tb_ret_addr;
 
+bool have_isa_altivec;
 bool have_isa_2_06;
 bool have_isa_3_00;
 
@@ -2781,6 +2782,9 @@ static void tcg_target_init(TCGContext *s)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
+    if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
+        have_isa_altivec = true;
+    }
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
         have_isa_2_06 = true;
     }
@@ -2792,6 +2796,10 @@ static void tcg_target_init(TCGContext *s)
 
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+    if (have_isa_altivec) {
+        tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
+        tcg_target_available_regs[TCG_TYPE_V128] = 0xffffffff00000000ull;
+    }
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
-- 
2.7.4


