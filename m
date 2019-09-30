Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B7BC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12D722501
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJQs8GvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12D722501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Cv-0006FY-Ah
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Al-0004Sh-8G
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Aj-0005W2-Ut
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2Aj-0005UU-PH
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id e1so2467543pgj.6
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fFksXPcg68larzzGnM7YN3sIm2Zb50QlLmNUoBTpHpM=;
 b=EJQs8GvHZeXOa7fKejsFy8q3k8WVUUi7ShXqpg69P0+4Wl0ap/0wMkBcUIt8T/KiKH
 cVUqCytYqLBiyVm4S034txVSitzaF/2xkp+vuKgC2olbmexcm5J1HA5Dw8zpFutMl462
 XNl97eF6Lg0eGoUXFzS2oNJI8xZX5aA+Ec8ScBJOWOgWIyu/TJN2shQtDeSeSCtmFuVT
 DfX6RQdo4EFtzVEm8tqOPQgQEDtQF6xSLFxiOQ/fhMzHXTxJiQmOZOlVFbMsar6nPp0G
 /wpnyL0bLFRQm/wnk/4BHCq407cHh5DVDaMv2XLg9A8gLznEF/hNHlZJIhZH5ZGFP1Ej
 seIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fFksXPcg68larzzGnM7YN3sIm2Zb50QlLmNUoBTpHpM=;
 b=VsKvM3NHrC/JopzMRTFbUsEsb8BoDLFS88I4ZageDnUp08BcF6awBdKDKgsetg1Ziu
 ASecYZX88klyw+Cuxl0rNhkpkKSNmV34YEn4gqZRdcJBn8Nlg/sEalsPzWB2eUO2tO/H
 oHZuKhuHIhPNNUTkMDfnouXrdZexTuf/ZhSOYg+zBg52t6u5KnlK0L/XFY5H+f6IiBn8
 1n42iyGZ8tWwqLObtFnfiopMzzc0r9Lp5kv7zIr5R4mpD9PEVYE72vBFw6oPV+X+JwMy
 DtUiJK8wjutZht1YD6iwyfPchxG6AspzJg3KWYz/I86l3nMYe7IJEHti0tCrTgkp/9oq
 F4DA==
X-Gm-Message-State: APjAAAW2TFO7ax/zfFWz1KZZJ7pCzFa30g99T03afZcvHzdY/Wlojp2G
 pUSFwDdEbUjtRmjxbIbtho8jV+A73Tk=
X-Google-Smtp-Source: APXvYqxDlwQK7J7t8S4Hzj5XgrkSVxRD5sUwnmpdOiCwX48vCT0VOz5XJ6K1hKmXzwfZJBVZjsbssg==
X-Received: by 2002:a17:90a:8087:: with SMTP id
 c7mr1203547pjn.56.1569874888258; 
 Mon, 30 Sep 2019 13:21:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/22] tcg/ppc: Introduce Altivec registers
Date: Mon, 30 Sep 2019 13:21:04 -0700
Message-Id: <20190930202125.21064-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Altivec supports 32 128-bit vector registers, whose names are
by convention v0 through v31.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     | 11 ++++-
 tcg/ppc/tcg-target.inc.c | 88 +++++++++++++++++++++++++---------------
 2 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 7627fb62d3..690fa744e1 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -31,7 +31,7 @@
 # define TCG_TARGET_REG_BITS  32
 #endif
 
-#define TCG_TARGET_NB_REGS 32
+#define TCG_TARGET_NB_REGS 64
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 
@@ -45,6 +45,15 @@ typedef enum {
     TCG_REG_R24, TCG_REG_R25, TCG_REG_R26, TCG_REG_R27,
     TCG_REG_R28, TCG_REG_R29, TCG_REG_R30, TCG_REG_R31,
 
+    TCG_REG_V0,  TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,
+    TCG_REG_V4,  TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,
+    TCG_REG_V8,  TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+
     TCG_REG_CALL_STACK = TCG_REG_R1,
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 815edac077..9d678c3bf1 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -42,6 +42,9 @@
 # define TCG_REG_TMP1   TCG_REG_R12
 #endif
 
+#define TCG_VEC_TMP1    TCG_REG_V0
+#define TCG_VEC_TMP2    TCG_REG_V1
+
 #define TCG_REG_TB     TCG_REG_R31
 #define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
 
@@ -72,39 +75,15 @@ bool have_isa_3_00;
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
-static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-    "r0",
-    "r1",
-    "r2",
-    "r3",
-    "r4",
-    "r5",
-    "r6",
-    "r7",
-    "r8",
-    "r9",
-    "r10",
-    "r11",
-    "r12",
-    "r13",
-    "r14",
-    "r15",
-    "r16",
-    "r17",
-    "r18",
-    "r19",
-    "r20",
-    "r21",
-    "r22",
-    "r23",
-    "r24",
-    "r25",
-    "r26",
-    "r27",
-    "r28",
-    "r29",
-    "r30",
-    "r31"
+static const char tcg_target_reg_names[TCG_TARGET_NB_REGS][4] = {
+    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
+    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+    "v0",  "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
+    "v8",  "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
+    "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+    "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31",
 };
 #endif
 
@@ -139,6 +118,26 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R5,
     TCG_REG_R4,
     TCG_REG_R3,
+
+    /* V0 and V1 reserved as temporaries; V20 - V31 are call-saved */
+    TCG_REG_V2,   /* call clobbered, vectors */
+    TCG_REG_V3,
+    TCG_REG_V4,
+    TCG_REG_V5,
+    TCG_REG_V6,
+    TCG_REG_V7,
+    TCG_REG_V8,
+    TCG_REG_V9,
+    TCG_REG_V10,
+    TCG_REG_V11,
+    TCG_REG_V12,
+    TCG_REG_V13,
+    TCG_REG_V14,
+    TCG_REG_V15,
+    TCG_REG_V16,
+    TCG_REG_V17,
+    TCG_REG_V18,
+    TCG_REG_V19,
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -2808,6 +2807,27 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R11);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R12);
 
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V7);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V8);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V9);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V10);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V11);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V12);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V13);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V14);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V15);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V16);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V17);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V18);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V19);
+
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0); /* tcg temp */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R1); /* stack pointer */
@@ -2818,6 +2838,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R13); /* thread pointer */
 #endif
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1); /* mem temp */
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP1);
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP2);
     if (USE_REG_TB) {
         tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);  /* tb->tc_ptr */
     }
-- 
2.17.1


