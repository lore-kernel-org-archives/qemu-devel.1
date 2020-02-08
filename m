Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C2BC3F68F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA252217BA
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wW4/AfO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA252217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PoT-0007jq-3K
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgt-0000gh-RU
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgs-0004zd-UE
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:31 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgs-0004wH-Nr
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:30 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so5596560wmi.5
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8y0KNL/AFSS9j7gNmLDE5wRNKMVyyA8vBmve9VVvdXg=;
 b=wW4/AfO4fxkE82GLltPce2B5qr9vNeQ1eorHc95qNkTgs1YiTdlIrWpSD+u4KSXeSM
 AYzO6Wx3uYsFcgBiv05o3beK1GlbD/FiWe9Z0zyLAS5quQStgUk40nuhEIMEVfZisZzl
 xMcY/6jxMdvmHhgYczlM8hN3UfQB9owqmLoW5UHH5n+3JipV0Kmy18d5H3I8Hw06XzwC
 A0VI3PZKbyUg04rGromLt7Mmj2Vb0urwosVnpAyt6ibw9vAZdyUEzhAAD0crbJC/kaoN
 LWHQl6+40+DUlXQb11l93oaTE/ZhhUrg2izyBRfZ0ohRxIP4O7sAY18yLOX97dqUWU0B
 4Pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8y0KNL/AFSS9j7gNmLDE5wRNKMVyyA8vBmve9VVvdXg=;
 b=BPKT2gDIyLnIZC9YAdb34avQNjkhNI1IxLMQPP8oRU17kXGY0rJVjRSDNc2gQrSGdu
 +CNLFLXmAMaxp7+Ukd8lX029s3lLNVAxyLrexb6/vBYTWYU9hXK1q2pX1XcE/KFAOveW
 u42uxCVSrDP4hLS/zqEIh7ZDIuvlxl6UdRcRTBRitO/cLVHfPmWK8EECdeZP32/TarLs
 MFNWngf4njRGyQa1H7mvXNpIQf/mJPyF8fQ1bk+EgGhr36cotsXoTLGWMgzI8zko4qxE
 wGnol9Q45yhU1ORE8LBToDlwBkVdrezbjASE+vOKzqEbN5JVXEhGJJGKR1xtuqcPtVgC
 Zg+A==
X-Gm-Message-State: APjAAAUdR3vPv8vIfMkJ1YUhJ/3zY6LFOEZX//kovZYneb96PC8dNa8Q
 cfg0CKKQhBsuEq9z5zHKg1OhY/0pujqTkA==
X-Google-Smtp-Source: APXvYqxhTRgz0wCWE/imbKXCG4/QQElRp/vQRRC/N00yFWZ+ulwR1WIUVHbsTh2qzT9ZMfO+wqeCFQ==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr4396895wmk.160.1581166709590; 
 Sat, 08 Feb 2020 04:58:29 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/20] target/arm: Update arm_mmu_idx_el for PAN
Date: Sat,  8 Feb 2020 12:58:08 +0000
Message-Id: <20200208125816.14954-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Examine the PAN bit for EL1, EL2, and Secure EL1 to
determine if it applies.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 058fb23959..f6a600aa00 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11895,13 +11895,22 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         return ARMMMUIdx_E10_0;
     case 1:
         if (arm_is_secure_below_el3(env)) {
+            if (env->pstate & PSTATE_PAN) {
+                return ARMMMUIdx_SE10_1_PAN;
+            }
             return ARMMMUIdx_SE10_1;
         }
+        if (env->pstate & PSTATE_PAN) {
+            return ARMMMUIdx_E10_1_PAN;
+        }
         return ARMMMUIdx_E10_1;
     case 2:
         /* TODO: ARMv8.4-SecEL2 */
         /* Note that TGE does not apply at EL2.  */
         if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+            if (env->pstate & PSTATE_PAN) {
+                return ARMMMUIdx_E20_2_PAN;
+            }
             return ARMMMUIdx_E20_2;
         }
         return ARMMMUIdx_E2;
-- 
2.20.1


