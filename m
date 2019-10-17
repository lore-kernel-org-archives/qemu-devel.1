Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651FECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7845C21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eomd+q7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7845C21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLBCr-0000ux-Ii
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs8-0001JS-P6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs6-0000wn-GP
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:40 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLAs6-0000vY-5a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id b128so2231681pfa.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iym+ywFHjEBpwuu12wdHsU0gouX4jDUf3/+DDNH9pyk=;
 b=eomd+q7FBtX57jhaP+godJma/1o5Zf+oYg3UXznfKR4wPos0bFbOWEftx1M4k/jng9
 OCuj3KKdkctf4snN8cQYDZ8ywrDSgde+8yPLdhi1plV4Wp7h69ws3ws3ptAfD3M9gZbF
 RovGtP40Tr2tRKNZ3MuJ8YfqNaHirYSrM1A/xOBwIBGGkfwxHfYTtc+52+22Dy5+c4lC
 ivlBD5pQnLUfC2zH9Dl29Z4HJO1RIhKs0l4C/ei5FGgNBm12OAAhK2J6a6JGfU6FK8U8
 rF8ISlV+ouGyA0DHwzlyC1b+Vc862MaRASAbBNlkfXCcoqfvbnEiCsbAbCx8yS1rFEG7
 LADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iym+ywFHjEBpwuu12wdHsU0gouX4jDUf3/+DDNH9pyk=;
 b=l5xFd2AuVELp/e+2Sl/V/BQqisQtBPeP/NcPNKODKcB4VEJrOh/qj+iMCPoj7mPD/X
 s8bBj64F215PWUq6XYisDcd/aCCDJxMYzLCqARB4fMkrqGqE1f0VkS4OEVZvzjgSlmhB
 aD5fAe7qxZwYvUkWcxe6MwXKCklcLVcpVApYqN98YBcP9y39ROhrtOsYnATwqcbcHX1A
 v9SgPj6bfUWQF4TYOdHV2KhaAeKsPhG40zj04XMgEuj5RUTwoo0csjr8rG+TADEqyW7h
 s/yq6aRuQkfnGLE4M5Ff2nEFESkmwaMMqKTQi9ma8nQ0+RQt1ea/o3a0xOZ14BbPUMe/
 o4yg==
X-Gm-Message-State: APjAAAXCbDat04Af5Rs/gBUo0WSeuTRSLYpQDPz8HsnjIPSXKW2JoTT3
 hUxlfc7X/oomjAtjU4qEijhlURU2PPs=
X-Google-Smtp-Source: APXvYqxXZYh0hjnughDBUmKyp6TKtCHXBrnj8rJNbsCDJLW/jP7c5OwKb1zJBMuvY6wTLw5/iBbyXQ==
X-Received: by 2002:a65:6898:: with SMTP id e24mr4081018pgt.358.1571338296203; 
 Thu, 17 Oct 2019 11:51:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 18/20] target/arm: Rebuild hflags at CPSR writes
Date: Thu, 17 Oct 2019 11:51:08 -0700
Message-Id: <20191017185110.539-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ccc2cecb46..b529d6c1bf 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -224,6 +224,7 @@ uint32_t HELPER(usat16)(CPUARMState *env, uint32_t x, uint32_t shift)
 void HELPER(setend)(CPUARMState *env)
 {
     env->uncached_cpsr ^= CPSR_E;
+    arm_rebuild_hflags(env);
 }
 
 /* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
@@ -387,6 +388,8 @@ uint32_t HELPER(cpsr_read)(CPUARMState *env)
 void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     cpsr_write(env, val, mask, CPSRWriteByInstr);
+    /* TODO: Not all cpsr bits are relevant to hflags.  */
+    arm_rebuild_hflags(env);
 }
 
 /* Write the CPSR for a 32-bit exception return */
-- 
2.17.1


