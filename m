Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B4DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784E320637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTSvjoyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784E320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ted-0004B2-EQ
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPS-0003vY-49
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPQ-0002t4-TV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:42 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPQ-0002sW-Lg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id i9so7050169wml.4
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pEDdmn2Qq48osMBcaNiYHbcE7nHfPyLhG+0XvX+TSYQ=;
 b=NTSvjoyN+5ZnlpaZvXZRHXXcMArsjBoDse2c9zEL7eNCM0OYeQL+lTaNK3M4l2LYSi
 WYN8BAP6SB0t43FaCBX/9s5qtDdRC535ZtGgGEZhxCMEwS/OdZomPcBLofeVZRQykHPr
 FliEgH30MsEUK9QpGflAbD/4A4B4bYYrsr3nlOS5uZR73G5ih/d23nGQ98HEJtuCnxer
 u0DUkyG4yR1/eYDR1jYs2fp7sRt+RSQdrr/SuU8GY5U5ZKnzE+5u5pBhifcd0lBQjVJ2
 Mxkb0BmHz6Wd/TddzV+dcFXHpZSoVrft8q6C+qBAJ1dTqD6TANx0nLo1/YfJwV3FK5yg
 8XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pEDdmn2Qq48osMBcaNiYHbcE7nHfPyLhG+0XvX+TSYQ=;
 b=pnbHx0Es/zA+3C7lo7Hn1vlSXo3rlIlo1OrWxFWJ7BtIGAXwhnMo9fwxJaKaZtwDHu
 JKWPG4BFxG8qnUgm71iKalpAmi1a/uppo/El7unjMtIsB7VGxY/x9KM5IpOCCKOh0AxK
 1jEfHdi5z//1sx8xgLbd+Z0EPf3wR2KWJZFm90NkDaEmDNteFNwYQNTgy58m49DCRBeX
 BsSUjIjttQiCz5qvFOnnWvXJwer101ZCJA5Ok5jmqZdG4ySu+DOxqTYqfF2KGpbt1FbV
 XoJp3IHYa1dLdAjFH2gOJ4f9RrOuuv3LBX5RXugw/j5Lygn01QsWBxRRYOnABEUe/L2D
 CpXQ==
X-Gm-Message-State: ANhLgQ1p71KcMaziZLfiS5+ecAojy3Xxh502uyuR9svY8eS9u+F+j7q+
 0JqzUolzJpfL5quvtNuDGUiNGJkn0vSdCQ==
X-Google-Smtp-Source: ADFU+vuPgYRJYdkfz+6KBPtjt8Ke7+1XtVxlSZSi6wqgyR9c+itHkBg/3UvhFVuBQ402nkopLPs1nA==
X-Received: by 2002:a1c:804a:: with SMTP id b71mr10012755wmd.132.1583425899358; 
 Thu, 05 Mar 2020 08:31:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/37] target/arm: Apply TBI to ESR_ELx in
 helper_exception_return
Date: Thu,  5 Mar 2020 16:30:57 +0000
Message-Id: <20200305163100.22912-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

We missed this case within AArch64.ExceptionReturn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200302175829.2183-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 509ae930698..123ce50e7a8 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1031,6 +1031,8 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
                       cur_el, new_el, env->regs[15]);
     } else {
+        int tbii;
+
         env->aarch64 = 1;
         spsr &= aarch64_pstate_valid_mask(&env_archcpu(env)->isar);
         pstate_write(env, spsr);
@@ -1038,8 +1040,27 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
             env->pstate &= ~PSTATE_SS;
         }
         aarch64_restore_sp(env, new_el);
-        env->pc = new_pc;
         helper_rebuild_hflags_a64(env, new_el);
+
+        /*
+         * Apply TBI to the exception return address.  We had to delay this
+         * until after we selected the new EL, so that we could select the
+         * correct TBI+TBID bits.  This is made easier by waiting until after
+         * the hflags rebuild, since we can pull the composite TBII field
+         * from there.
+         */
+        tbii = FIELD_EX32(env->hflags, TBFLAG_A64, TBII);
+        if ((tbii >> extract64(new_pc, 55, 1)) & 1) {
+            /* TBI is enabled. */
+            int core_mmu_idx = cpu_mmu_index(env, false);
+            if (regime_has_2_ranges(core_to_aa64_mmu_idx(core_mmu_idx))) {
+                new_pc = sextract64(new_pc, 0, 56);
+            } else {
+                new_pc = extract64(new_pc, 0, 56);
+            }
+        }
+        env->pc = new_pc;
+
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch64 EL%d PC 0x%" PRIx64 "\n",
                       cur_el, new_el, env->pc);
-- 
2.20.1


