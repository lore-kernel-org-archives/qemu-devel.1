Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A0C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCEB20861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBnMrqiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCEB20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvqV-0001NR-Dv
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvot-0007fM-T0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvos-0000bl-3T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcvoq-0000Zy-E3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id p11so10953438wre.7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZqxuBGrvpyV7bVVdQeK9vpv5xyuxJzmNpj8ibO3gKBw=;
 b=qBnMrqiDAX2devzhltrL3k5LNwxLL0pYFEAXPUwAhF+DEGVY0ImlTww8y8aHtNGju6
 ffUdO85sB3X1bAvFocgGqqG7aHmxzLOmAU0hHzIAdhEJZ4hHseTTUW3Cd+1JfcK6AZuW
 FzniwmN9yUl2wE30w4XYIC9C44X0m8DeS4qawfB4u5ffFYXUTvfinP8QZLVoWbXNnX0V
 qJ/810BkgXp8Ttscsx5OkDZHVvKTN0JTRKJJ1DFtHP9fMRqfzx3vNGudVMnwcfqKGv9A
 svjn5Hqmk+LrJYmciUNKs/TQ02TBaHmj2TcCOoP95IgPGoXjH2gaaVsoEhdkXB6xXfyO
 ++Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZqxuBGrvpyV7bVVdQeK9vpv5xyuxJzmNpj8ibO3gKBw=;
 b=omuTGOJ1P9/0mldiY6oQ9PBVjy7DDycqpsQwD+yvxt6CuXXGq493g0enxeqlkxcdqb
 U5tAJdUTqybhMxnxXm7reEBg7TompaLBaCIfDobPpG/E9X3l+aKYLP9GD7bT9hlH0EXU
 0+M7Vpgkbo25Apzcc2cNJjsr0pG32A+L1556riNGM0UWWlKKlUjYDXVSe+s/CNFDrAyJ
 ZIydeBPgrUpen1qLcj9QjLOP1Oa0K8fSk9Yn94UPwh3iz8okjuFutHoVywd3RkqUgv+a
 oVNwNEAPLjmCHnzwenWJs2AZq2LTOuKQRj1qZEZQhIREMN2SsfuV+MZ4Si+pA+HE3tBh
 2K7Q==
X-Gm-Message-State: APjAAAVcn+0OsJNbjf0fXifTRpMkqK4gEtgh8qdFn5ISxAWQtxUjci/K
 TXGejZVTRk56VmDVmIX0hGUttQ==
X-Google-Smtp-Source: APXvYqxxS4QCSTWgZqAdD7qocatdg0ImvIfuRpBAHWAZaidoPNL4OV75AT2y5QLsDhedXiP9T6olXA==
X-Received: by 2002:adf:afe8:: with SMTP id y40mr22388286wrd.328.1560794002222; 
 Mon, 17 Jun 2019 10:53:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm8713619wrr.33.2019.06.17.10.53.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:53:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 18:53:13 +0100
Message-Id: <20190617175317.27557-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617175317.27557-1-peter.maydell@linaro.org>
References: <20190617175317.27557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 2/6] arm v8M: Forcibly clear negative-priority
 exceptions on deactivate
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

To prevent execution priority remaining negative if the guest
returns from an NMI or HardFault with a corrupted IPSR, the
v8M interrupt deactivation process forces the HardFault and NMI
to inactive based on the current raw execution priority,
even if the interrupt the guest is trying to deactivate
is something else. In the pseudocode this is done in the
Deactivate() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index b8ede30b3cb..330eb728dd5 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -812,15 +812,45 @@ void armv7m_nvic_get_pending_irq_info(void *opaque,
 int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure)
 {
     NVICState *s = (NVICState *)opaque;
-    VecInfo *vec;
+    VecInfo *vec = NULL;
     int ret;
 
     assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
 
-    if (secure && exc_is_banked(irq)) {
-        vec = &s->sec_vectors[irq];
-    } else {
-        vec = &s->vectors[irq];
+    /*
+     * For negative priorities, v8M will forcibly deactivate the appropriate
+     * NMI or HardFault regardless of what interrupt we're being asked to
+     * deactivate (compare the DeActivate() pseudocode). This is a guard
+     * against software returning from NMI or HardFault with a corrupted
+     * IPSR and leaving the CPU in a negative-priority state.
+     * v7M does not do this, but simply deactivates the requested interrupt.
+     */
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_V8)) {
+        switch (armv7m_nvic_raw_execution_priority(s)) {
+        case -1:
+            if (s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
+                vec = &s->vectors[ARMV7M_EXCP_HARD];
+            } else {
+                vec = &s->sec_vectors[ARMV7M_EXCP_HARD];
+            }
+            break;
+        case -2:
+            vec = &s->vectors[ARMV7M_EXCP_NMI];
+            break;
+        case -3:
+            vec = &s->sec_vectors[ARMV7M_EXCP_HARD];
+            break;
+        default:
+            break;
+        }
+    }
+
+    if (!vec) {
+        if (secure && exc_is_banked(irq)) {
+            vec = &s->sec_vectors[irq];
+        } else {
+            vec = &s->vectors[irq];
+        }
     }
 
     trace_nvic_complete_irq(irq, secure);
-- 
2.20.1


