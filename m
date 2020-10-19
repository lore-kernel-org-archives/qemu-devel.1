Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC92C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288D92231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dV3shNVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288D92231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWwC-00058z-5J
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqW-0006p9-1H
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqS-0002jp-9s
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id k18so185505wmj.5
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=73sxXQONcqBgzHuOsaIz5hu+3BY6+pw52N6WyKkQfZo=;
 b=dV3shNVINT2JmGcZ1DoEKBgo9PJ/JaVd55gCmwwFC+lFWWGb5+ZfGSXWV1xK7BZ51u
 L0Ex2krQo7iSxfdR3rQXSxjyDOTNeUkbNLl9pG1q9dFLZfq0pjkp72KhS6jz9iSPcEBb
 0b6nmnkTpBcHB8J88cjm9Wkyd3nCWJVsx6lNXwIquyKQBmPABGm3G6TFmI/QGcDR1MtC
 7pnu2LFP0/EM5TXjMbC8VwUsGN2M/UppNjSZjA3dKTfKfb8ygrHZRm0NiaMmXtZLxZsg
 woeGbEsar7EW9nfvQbZOjMVW3v7f13CXcjkQ9W197stScAkYeju/zHkd7jbsKkGYguSq
 DIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=73sxXQONcqBgzHuOsaIz5hu+3BY6+pw52N6WyKkQfZo=;
 b=ZtrFdIGM4RC12jrefq2+8h2ylJ/AXFwut/RsgKlSrAcSFKCWy4DJY5/oWmxWNR1Vsy
 bv2+kOh6Vq5jZcnJUlHedVCPe+SQ1hrUOFuxfAOVPa5Mwr4ifyw4UBwfj1Z/Rba+dqj+
 MGe0VgFiyE+bBZcMACCddM6UKHtE605jvR15SCZGkZNgKjqOMVtYsYoTxL2f5jYoauN7
 foYv0nv1ji0KePAMxGmrWYtnGX96BuM6uw/1c4k4jMBCTicGmdsAkLTAXy0mY9BEcRcF
 ESsWUv7LDg3P0/Vqf4SusIHGaeQlUNa8EWxO8VjAnWdNwlwaoxuVt+SqskJgHgsayqw/
 rqxQ==
X-Gm-Message-State: AOAM532CTjDvTTonW+65KDfaEtgzBng9q32dbkkJEmNemGFEXIxB/d2i
 7ISTi0WYA9ClnawOHNOitJy+IQ==
X-Google-Smtp-Source: ABdhPJznDz8+FedrzMjkeEfryTakU/AHDCY074XsNveDtAwczKWinYFPt7nJmtFpebo5nskeNeIwwQ==
X-Received: by 2002:a1c:3c4:: with SMTP id 187mr44004wmd.14.1603120386263;
 Mon, 19 Oct 2020 08:13:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y14sm309918wma.48.2020.10.19.08.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:13:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/10] target/arm: Implement v8.1M NOCP handling
Date: Mon, 19 Oct 2020 16:12:53 +0100
Message-Id: <20201019151301.2046-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019151301.2046-1-peter.maydell@linaro.org>
References: <20201019151301.2046-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From v8.1M, disabled-coprocessor handling changes slightly:
 * coprocessors 8, 9, 14 and 15 are also governed by the
   cp10 enable bit, like cp11
 * an extra range of instruction patterns is considered
   to be inside the coprocessor space

We previously marked these up with TODO comments; implement the
correct behaviour.

Unfortunately there is no ID register field which indicates this
behaviour.  We could in theory test an unrelated ID register which
indicates guaranteed-to-be-in-v8.1M behaviour like ID_ISAR0.CmpBranch
>= 3 (low-overhead-loops), but it seems better to simply define a new
ARM_FEATURE_V8_1M feature flag and use it for this and other
new-in-v8.1M behaviour that isn't identifiable from the ID registers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  1 +
 target/arm/m-nocp.decode       | 10 ++++++----
 target/arm/translate-vfp.c.inc | 17 +++++++++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cfff1b5c8fe..74392fa0295 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1985,6 +1985,7 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
+    ARM_FEATURE_V8_1M, /* M profile extras only in v8.1M and later */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/m-nocp.decode b/target/arm/m-nocp.decode
index 7182d7d1217..28c8ac6b94c 100644
--- a/target/arm/m-nocp.decode
+++ b/target/arm/m-nocp.decode
@@ -29,14 +29,16 @@
 # If the coprocessor is not present or disabled then we will generate
 # the NOCP exception; otherwise we let the insn through to the main decode.
 
+&nocp cp
+
 {
   # Special cases which do not take an early NOCP: VLLDM and VLSTM
   VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
   # TODO: VSCCLRM (new in v8.1M) is similar:
   #VSCCLRM      1110 1100 1-01 1111 ---- 1011 ---- ---0
 
-  NOCP         111- 1110 ---- ---- ---- cp:4 ---- ----
-  NOCP         111- 110- ---- ---- ---- cp:4 ---- ----
-  # TODO: From v8.1M onwards we will also want this range to NOCP
-  #NOCP_8_1     111- 1111 ---- ---- ---- ---- ---- ---- cp=10
+  NOCP         111- 1110 ---- ---- ---- cp:4 ---- ---- &nocp
+  NOCP         111- 110- ---- ---- ---- cp:4 ---- ---- &nocp
+  # From v8.1M onwards this range will also NOCP:
+  NOCP_8_1     111- 1111 ---- ---- ---- ---- ---- ---- &nocp cp=10
 }
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 28e0dba5f14..cc9ffb95887 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -3459,7 +3459,7 @@ static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
     return true;
 }
 
-static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
+static bool trans_NOCP(DisasContext *s, arg_nocp *a)
 {
     /*
      * Handle M-profile early check for disabled coprocessor:
@@ -3472,7 +3472,11 @@ static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
     if (a->cp == 11) {
         a->cp = 10;
     }
-    /* TODO: in v8.1M cp 8, 9, 14, 15 also are governed by the cp10 enable */
+    if (arm_dc_feature(s, ARM_FEATURE_V8_1M) &&
+        (a->cp == 8 || a->cp == 9 || a->cp == 14 || a->cp == 15)) {
+        /* in v8.1M cp 8, 9, 14, 15 also are governed by the cp10 enable */
+        a->cp = 10;
+    }
 
     if (a->cp != 10) {
         gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
@@ -3489,6 +3493,15 @@ static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
     return false;
 }
 
+static bool trans_NOCP_8_1(DisasContext *s, arg_nocp *a)
+{
+    /* This range needs a coprocessor check for v8.1M and later only */
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+    return trans_NOCP(s, a);
+}
+
 static bool trans_VINS(DisasContext *s, arg_VINS *a)
 {
     TCGv_i32 rd, rm;
-- 
2.20.1


