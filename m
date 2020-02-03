Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42783C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D18D2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="unf8cXmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D18D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd7h-0004RV-7O
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0d-0006yK-JR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0c-0003Hg-Kk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:31 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0c-0003Gy-DX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:30 -0500
Received: by mail-wr1-x441.google.com with SMTP id j104so18529846wrj.7
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6oZGlz7Genf3xLLU7zOHALEHpqBlGtMbmuDPmda8R6w=;
 b=unf8cXmi/oAz6FJzFInSy8M6FDjUrrLW1BkuSpjab1Aq0p6WHQtLXcY4gJbrz4Tlh3
 /HtsQgo7shBWyV7ZMvdBIuFCJo+Tnu643yZo8FG1J0vl32r3uyaP9T0YdOOZdR7hqIqk
 t1uvkvzauouUF6/MPux3czRMFNiEqNqPb6KoL08QQ8GB0bLC1dQJPDnbPdpnTvCHTrF/
 vE6HTIjTfnrT9RsC9lYZgXbN4Po4FMzYwMcxZSbNBrarnNwaq5bR5DeJLwq12jJJn8W1
 Ci5G6lWZIlrYKHJ0z4uFf5HyC5xetr6HbMTpIRNzLuco3xo3IEELh6Nv2Vi1Fmx2maO/
 4RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6oZGlz7Genf3xLLU7zOHALEHpqBlGtMbmuDPmda8R6w=;
 b=Zy7STHRkIweBlV9YLsNlBHVglEP7rAJd/BnN4nMulYzP1uk7E5gaMDx9GAGKdT9vUE
 nhyedI0RhDW/0GoWFM1Ow8rGFKYDCnmD6Qa01xiz6VdkBDQxV0O5hiQ8gkZO8Cu2ZS7l
 NEU32b06u9I26/lRLtxPNNUpERYSroxjg/eXxC9OXuTZeCDKzCT0UboKIHMsw4WxhJLS
 JRFGdvPdhA+p2muSwQbZHKQFEvG+shd7mlgQyWQbWfdeJAhNStcOhXp0dHTGU447AeWg
 L1GTTOlTCWNdT4WWqgmn3C4AHOinFjCXkqj56sCAeZCRK9erqLZo+f9D2JIyvrwT1Gc9
 XxgQ==
X-Gm-Message-State: APjAAAUVr0jhfTnkDC/xQ93BF82sn+bmNYzlqfkX1G+auDLJRL9aUh06
 16gCzuh8VirdqGOgAyrYmLZtRaGBh1df/g==
X-Google-Smtp-Source: APXvYqx03SR44SPyD0TjGphSPo8KlYPLoADcfL7zaXPTE5QRlQ5paayknTkm5BB1XrvEr+UQE+FChQ==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr15846902wrr.354.1580741249231; 
 Mon, 03 Feb 2020 06:47:29 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/20] target/arm: Update arm_mmu_idx_el for PAN
Date: Mon,  3 Feb 2020 14:47:08 +0000
Message-Id: <20200203144716.32204-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
index 90a22921dc..638abe6af0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11904,13 +11904,22 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
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


