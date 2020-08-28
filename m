Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F6A2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZ7kZl4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F6A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBamv-0000VH-6e
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacm-0004ok-3S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:44 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBack-0004LK-9p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id e16so636303wrm.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jLZaHIWVvnIo+jmYcXDVXAU5eo/5cO4+cRjdxj8CGfQ=;
 b=XZ7kZl4JBL2a//GaYJlu89WSVgkoDiJOevy3w9ZUSUJ5ebjdJrnFRMf96UPNOHWk+0
 b96ddCvG6xl0wRxJE+LQUnn7IYWeUfNw0+xFcIR7GEUW1Mx6z86OA8NjNTrA2r+3af+b
 uS0FitTbkIxfP6Bl5vKLZ88hIwHQC8VJnjl83jbbYAwGiAmsg+0VNn9rBr66hfbxL7Sx
 TuxIyXsPziLgPOyLwuIxqgNKcDE0oejj43uuMgnCIbZ4visAR3cmXVruMrKlmN8BFvwm
 Wb7+30DA8uN6LP5WMiz6o3o3Qd+fp/FLZsidJAVKo0/pRmPpiYuDts/tQ5PmwJOCyX6f
 ag2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jLZaHIWVvnIo+jmYcXDVXAU5eo/5cO4+cRjdxj8CGfQ=;
 b=MCYfA9/kM7gMJbAEpgQ17wgipHyellBD2e93QAAgqkKHCFa/e2otOiLlno84U8ySn/
 7gTzSdVNwZgR3RhO/hmMRgWsRQJW//trzIj71swB/1DEGxP6XnzM9uvI5VRbNi1SZrbH
 A9Yqnji2GUjNYbZVPyFlMU8+y98G+zIMv1LRkWSXZMuuLcArUEqBwQwj/fTu1Hbj1DTl
 DC+8KPM91qyqPjdTvNoZJKKBcw+5uIXpDCeBvndlk1EwNDMX0RY697aygVcE5jWUJuCp
 6B/8I1zimQmuqWTwI9Cec7yiWUNzBntGdKWL5inb0E6t64YpcMex8EVY9IlkykG5JYY/
 7eHQ==
X-Gm-Message-State: AOAM533T+ntV5Vp3PWycXntfKg4KK2svOm7IB08sZYCvoCU5hQ9IVnx5
 gnTNeTkuMSOG8D1yNKWlN9vARUJvRfD/YtW6
X-Google-Smtp-Source: ABdhPJwpbQ2J7FZxgkbbqYULApANym7FrerJ2x344Pwqe8ea13BuPmf6/8r8yECxK07GTZPuhU4gdA==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr631131wrs.28.1598606680582;
 Fri, 28 Aug 2020 02:24:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/35] target/arm: Rearrange {sve,fp}_check_access assert
Date: Fri, 28 Aug 2020 10:24:00 +0100
Message-Id: <20200828092413.22206-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We want to ensure that access is checked by the time we ask
for a specific fp/vector register.  We want to ensure that
we do not emit two lots of code to raise an exception.

But sometimes it's difficult to cleanly organize the code
such that we never pass through sve_check_access exactly once.
Allow multiple calls so long as the result is true, that is,
no exception to be raised.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h     |  1 +
 target/arm/translate-a64.c | 27 ++++++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 6d6d4c0f425..423b0e08df0 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -64,6 +64,7 @@ typedef struct DisasContext {
      * that it is set at the point where we actually touch the FP regs.
      */
     bool fp_access_checked;
+    bool sve_access_checked;
     /* ARMv8 single-step state (this is distinct from the QEMU gdbstub
      * single-step support).
      */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0fc5e12fab4..115dc946e75 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1156,18 +1156,18 @@ static void do_vec_ld(DisasContext *s, int destidx, int element,
  * unallocated-encoding checks (otherwise the syndrome information
  * for the resulting exception will be incorrect).
  */
-static inline bool fp_access_check(DisasContext *s)
+static bool fp_access_check(DisasContext *s)
 {
-    assert(!s->fp_access_checked);
-    s->fp_access_checked = true;
+    if (s->fp_excp_el) {
+        assert(!s->fp_access_checked);
+        s->fp_access_checked = true;
 
-    if (!s->fp_excp_el) {
-        return true;
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+        return false;
     }
-
-    gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
-                       syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
-    return false;
+    s->fp_access_checked = true;
+    return true;
 }
 
 /* Check that SVE access is enabled.  If it is, return true.
@@ -1176,10 +1176,14 @@ static inline bool fp_access_check(DisasContext *s)
 bool sve_access_check(DisasContext *s)
 {
     if (s->sve_excp_el) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_sve_access_trap(),
-                           s->sve_excp_el);
+        assert(!s->sve_access_checked);
+        s->sve_access_checked = true;
+
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                           syn_sve_access_trap(), s->sve_excp_el);
         return false;
     }
+    s->sve_access_checked = true;
     return fp_access_check(s);
 }
 
@@ -14529,6 +14533,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     s->base.pc_next += 4;
 
     s->fp_access_checked = false;
+    s->sve_access_checked = false;
 
     if (dc_isar_feature(aa64_bti, s)) {
         if (s->base.num_insns == 1) {
-- 
2.20.1


