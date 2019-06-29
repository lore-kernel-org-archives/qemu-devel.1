Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39332C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09706215EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpPr4+2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09706215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDAo-0000pF-Aq
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyA-0007zC-Bb
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy8-0003bK-3v
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:42 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy7-0003Kf-Pj
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id u18so826831wru.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kxASNpK6khU5CBmt5Hha6PfPwHuw6Z7LJdPifvfm0RI=;
 b=TpPr4+2azS8pxafrr60HLzkuZDDsTBfaIQNqh62qFXWhWRTRcGU0zG3e2gFetLljHC
 xMIEzlVoFp1w4z7q/5hhQcNE+3h2k3L3qepE3g5GoqBMLCPsiLJfEFuO0x+VkJmmJwSK
 XJvJZ57GO9af2y9zx4VUErFGuZxjLu+oUZbwFln/zjkWXGXOI+mgMVVesdDFev792g/B
 5rQvBjespvkK8Oe4jXtlQxOLrRG9irMS+Im8ZTlKHZYwtyL47wRNEFeUlJk/ypnj3fjI
 gqjDVFHT5VPOzhjQsi3z4D03baKnrL20HAkFkRwF76DFlCt4h7y7o72ypsxxZJJ5W2LS
 xQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kxASNpK6khU5CBmt5Hha6PfPwHuw6Z7LJdPifvfm0RI=;
 b=n5Lpr15kXWSa7vXEmzzXdzW6hvzhK3qSi/84+iziLqDXdOCfGWol93YL4kR6DhYKix
 N9fz76tzs78tlUJJyHJ6nJM/gKRAwEBEbJiRirc7wcCD/lr8phaOdVwFx3so+/EQCDKv
 peXe1D2HbBU0bUUZhbXu3I/DrL42Ztx9zQx7daWVPo+0mae82akgthIMuU/sLsMD1Mfj
 9qxJMtcWhKTNdpiJZF+/5IOvjpow3Ctw2Q4mCzSwxW8cKUVPKJpOSHhZc7REoqCYEflm
 /pase73CJUHRlCwiMxV+ZzNUQHDkkdt48GUjpEanVdJGX8xrQ780yBu0qxARCTCUSu8O
 5xNw==
X-Gm-Message-State: APjAAAU+4q1rPmKnWJxKA718QdmzsgP+NFAuqok5hg/AI+Q9jM+ATftp
 gAkhfwgaZbHVDj+kevupAENWHbAE9SZ4kA==
X-Google-Smtp-Source: APXvYqwW7hoTIAs9VhWbx7fIV83n59yBMRsoz1jYl3iDGpemnAws3DL7dEdQ9P7E3evtyZqH31L45Q==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr11665217wrj.298.1561813223034; 
 Sat, 29 Jun 2019 06:00:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:05 +0200
Message-Id: <20190629130017.2973-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PATCH v6 04/16] tcg/ppc: Enable tcg backend vector
 compilation
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce all of the flags required to enable tcg backend vector support,
and a runtime flag to indicate the host supports Altivec instructions.

For now, do not actually set have_isa_altivec to true, because we have not
yet added all of the code to actually generate all of the required insns.
However, we must define these flags in order to disable ifndefs that create
stub versions of the functions added here.

The change to tcg_out_movi works around a buglet in tcg.c wherein if we
do not define tcg_out_dupi_vec we get a declared but not defined Werror,
but if we only declare it we get a defined but not used Werror.  We need
to this change to tcg_out_movi eventually anyway, so it's no biggie.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     | 25 ++++++++++++++++
 tcg/ppc/tcg-target.opc.h |  5 ++++
 tcg/ppc/tcg-target.inc.c | 65 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 tcg/ppc/tcg-target.opc.h

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 690fa744e1..f6283f468b 100644
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
 
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
new file mode 100644
index 0000000000..fa680dd6a0
--- /dev/null
+++ b/tcg/ppc/tcg-target.opc.h
@@ -0,0 +1,5 @@
+/*
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index cfbd7ff12c..b938e9aac5 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -64,6 +64,7 @@
 
 static tcg_insn_unit *tb_ret_addr;
 
+bool have_isa_altivec;
 bool have_isa_2_06;
 bool have_isa_3_00;
 
@@ -717,10 +718,31 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 }
 
-static inline void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
-                                tcg_target_long arg)
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long val)
 {
-    tcg_out_movi_int(s, type, ret, arg, false);
+    g_assert_not_reached();
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
+                         tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < TCG_REG_V0);
+        tcg_out_movi_int(s, type, ret, arg, false);
+        break;
+
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= TCG_REG_V0);
+        tcg_out_dupi_vec(s, type, ret, arg);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool mask_operand(uint32_t c, int *mb, int *me)
@@ -2605,6 +2627,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
     }
 }
 
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg dst, TCGReg src)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg out, TCGReg base, intptr_t offset)
+{
+    g_assert_not_reached();
+}
+
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg *args, const int *const_args)
+{
+    g_assert_not_reached();
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    g_assert_not_reached();
+}
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
@@ -2787,6 +2839,9 @@ static void tcg_target_init(TCGContext *s)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
+    if (hwcap & /* PPC_FEATURE_HAS_ALTIVEC -- NOT YET */ 0) {
+        have_isa_altivec = true;
+    }
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
         have_isa_2_06 = true;
     }
@@ -2798,6 +2853,10 @@ static void tcg_target_init(TCGContext *s)
 
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+    if (have_isa_altivec) {
+        tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
+        tcg_target_available_regs[TCG_TYPE_V128] = 0xffffffff00000000ull;
+    }
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
-- 
2.17.1


