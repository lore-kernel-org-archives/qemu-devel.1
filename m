Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C75C8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38E5207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNlLLcRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38E5207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7yp-0007pA-Oz
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jl-0003Pk-2b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jh-0000Rc-F9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jg-0000RF-Vu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id x18so6530523wrq.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6V9ucxOOBLKRqrUEKQVPivd5c5ZGx+aM8Gyykmmx1TE=;
 b=dNlLLcRP/mtF7S5cyXVnI4YAf0kKkiuNP0G/aSll3+bs5npRAHE1yJMjyH5EAVZo2k
 ezED8ODNbIpnQ+NCvyZFI1NRc0mMMnbfwO/yCKYOJfNX3UA7NJ0KwEbygqXAd3iltH52
 YeqZf72SOJ5OBtBYKLDHpdnZkay2XLFkIrkJeQAlQuJlSbnOipIPweYQUmP6nTQ1Y7tA
 pLv/Uc4LFsPiHZUQm8b2ITTrsBOaz0wVxvyKzRZqqleR2aH75kRxIFJXtx5PqgbgGpjY
 m1yCAp3VWdQkETPFf9e9Miutm+N/laoOSDYmKTQemT6Jn/zLDse69cuh70dxEGle0W3z
 5fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6V9ucxOOBLKRqrUEKQVPivd5c5ZGx+aM8Gyykmmx1TE=;
 b=KKWtCubp6vG7dkJo2p+GKGyWkqvOdC4JWjLflO7sPSa4z+RixkTFA1OfT+Fb/whrpW
 PjjyhpjEuA/1bYKNtlPpTlOFA+hXRfLLEcqzoqvCMG/FHzLtRkGGNZwdQVyhcQa9wW1g
 D0KBpSThjTFS214wIIm1gUOebot3PRVJMohyH4vTuFLmvVV9jX87tMqv4KyeeYr8nTXh
 mRaCcUPz1BWLKxIINalP15GFyylWuGGmfkRlcMYlR6vpPUoNZ/gQFi00ZUPyNqCn1kA5
 MFkr1JbgYPBP1vh6osZLpEW8m8WuDTtZCZVUz8z8MXGMKbaY4TuEhpbgTwD6qWxMUOPc
 T5ng==
X-Gm-Message-State: AGi0PuZ58ScI6zS4hYkTzrPIL6TvtF+0X/1UxTwV2Y4cgeFPaKOTEq/A
 lY7ie4cJefSPj4u8xxkNUT0c+c5f8VEduA==
X-Google-Smtp-Source: APiQypLIB2A3x7BGl3ZHmFwQ2a7NcQozUBcTEJg1JMDNsO0gtuOqFBZ5JnZl857PZ10DE6sWyFhDRA==
X-Received: by 2002:adf:d088:: with SMTP id y8mr580739wrh.23.1588247531305;
 Thu, 30 Apr 2020 04:52:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/31] target/arm: Restrict the Address Translate write
 operation to TCG accel
Date: Thu, 30 Apr 2020 12:51:35 +0100
Message-Id: <20200430115142.13430-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::436
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Under KVM these registers are written by the hardware.
Restrict the writefn handlers to TCG to avoid when building
without TCG:

      LINK    aarch64-softmmu/qemu-system-aarch64
    target/arm/helper.o: In function `do_ats_write':
    target/arm/helper.c:3524: undefined reference to `raise_exception'

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200423073358.27155-2-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e9ea5d20fa..dfefb9b3d9b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3442,6 +3442,7 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+#ifdef CONFIG_TCG
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx)
 {
@@ -3602,9 +3603,11 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     }
     return par64;
 }
+#endif /* CONFIG_TCG */
 
 static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
+#ifdef CONFIG_TCG
     MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t par64;
     ARMMMUIdx mmu_idx;
@@ -3664,17 +3667,26 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     par64 = do_ats_write(env, value, access_type, mmu_idx);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
 }
 
 static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
+#ifdef CONFIG_TCG
     MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t par64;
 
     par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
 }
 
 static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3689,6 +3701,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
+#ifdef CONFIG_TCG
     MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     ARMMMUIdx mmu_idx;
     int secure = arm_is_secure_below_el3(env);
@@ -3728,6 +3741,10 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx);
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
 }
 #endif
 
-- 
2.20.1


