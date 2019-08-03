Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F0BC31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8859E2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xyjg5s19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzG7-0008Cw-T1
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 15:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz52-0006ng-De
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz51-0007NR-BK
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:36 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz51-0007My-2X
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:35 -0400
Received: by mail-pg1-x542.google.com with SMTP id n190so2542703pgn.0
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+czGE1389+p9Ry0JcTeQCKYKOo7/YkTFZC4yltahS2c=;
 b=Xyjg5s19r/WRWUfR6xaWgAyr8CsYpH1Dr1oYlq23QP+aj6s+bmdUNjI9ShzPR/5bnD
 8MtEvO474wOlswxFWfcG976klTMfYNrp2yo7J5Mj5ul/UI5FsIpB1iNE2+6AVR9CjG/q
 AayUcEl14Gm7TZL84nQm+/2sVXDCVtdUoLRPJoLyuxCe78jcvMfCya7ikbRPUnpg29y+
 MGss9X0u+c9rabYdQZX7JAGTwIb3FNrEn2HiYEqMRIDE798KSq2aJMY/ykeQlm5vxoib
 Tm7V6QmSqeXMlMBhQFeo04Qrdfr9jYnyjyR1JSGmWLeD/g9KQGISk4DjevZtQOx1+gGz
 KUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+czGE1389+p9Ry0JcTeQCKYKOo7/YkTFZC4yltahS2c=;
 b=pHu5ks8KiF+G/ZU080eNpWvGQS1DvPgaVNHJ9Bpmqz4kp4oTUBhsxM+7KWRm0ZgqlV
 XISJbK3JrMQvkQ/4zTAHl38aSFZLi3dXLM0I/gq/1rkAgniHshZX5uTjlc6WEzg1g8w2
 6PMvmm632dvu9va4+0NQQKprITkg/sri9+4skFF9VgE5EDUWLfM0khFVNJRkFPWZ0GR6
 tecrNNzMcgvWOcSeNo4IrhTGsXtAbjtTVod/6Sr4rU0Er2jiTMIJFcRhF4EqyI2TaDOt
 xj0YggKKveTQ0p3ZPkdOhfnPIKfkmp9pNW7c9kNYalJWQb8Y/xeVY2OWDS/HAf2G+B1z
 mJtQ==
X-Gm-Message-State: APjAAAVu8Rcn0nLwvM6FB5WyJF/aiwjHoQOp2YK1TRYaD1fems3fgds4
 uexalbECHmqM6/atLK98WuJbh3puwrc=
X-Google-Smtp-Source: APXvYqxd5/9+viNsBVQVD55FqfdoyCeNMDAhjpNUvd3wgZV9Jk4QnMFb+7iGOnZQIhlJa1MG8uCZzQ==
X-Received: by 2002:a63:784c:: with SMTP id
 t73mr133510686pgc.268.1564858113670; 
 Sat, 03 Aug 2019 11:48:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:52 -0700
Message-Id: <20190803184800.8221-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 26/34] target/arm: Update ctr_el0_access for
 EL2
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to include checks against HCR_EL2.TID2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37c881baab..b8c45eb484 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5361,11 +5361,27 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
-    /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
-     * but the AArch32 CTR has its own reginfo struct)
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TID2) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TID2) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     return CP_ACCESS_OK;
 }
-- 
2.17.1


