Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAE5C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA4F20726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDrjfa2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA4F20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PnX-0005ZG-Cx
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgr-0000as-W0
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgq-0004s1-To
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:29 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgq-0004ni-NT
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:28 -0500
Received: by mail-wm1-x341.google.com with SMTP id g1so5183231wmh.4
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wslv7CYEufFwFJCvr0YawYhKrjC9XNcJ2ZwEcRCjRWY=;
 b=pDrjfa2N7354imQpFehVJRZrkGS7Ke2bk8VJBnXpuBMGsWBXiJSu0l6SbGH9VZED/v
 hHwMZAY8Oe9GqVEUOal6hvSgc7E/lHQ0wQkfC/eJhNU3mjsn+VU8CT49t7EiQvqXDOV4
 pc7BfbpdZar3nwFiVn38fIfZLvNPZ8d/RFnoGLuu44+oDXN3u0eSGqrmP0KrkDDRt63W
 QSiykQFzqpqxFsWR6sBt8OFyeQqxT6pyE+19JISgJS7l7jwFJKR0vvEk3QMi/vMNk+xK
 Wefq3spBy10J+teZwFPNQvt5mJI02Mj6MX0qI96y4+rhfAMoXSSHd2f+esqRgxma+kRN
 4YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wslv7CYEufFwFJCvr0YawYhKrjC9XNcJ2ZwEcRCjRWY=;
 b=OPh1l6nXNHWNGfI4I9xHDvma6Yoq+GimHHJDC6/9jD5p1w8HUreJuLOMo4a3mO+lVB
 8/ZC4rf9NCXI0Gt01cB6I4ki23B+tQ5E+MjdHmQ7RKL7TRqehC2+VJSP2rplRbxuI7Cu
 BaqbD43pGK7Bl2MYfR8OsxXuwBg8bzAAlkyuuiUaoOTgwWljVupI0iRt45cMF33H3zCC
 nC+8RV1KjRloHEIcliUGxDUVV27bu/4fXqXhKCnKQahCJDLYSgBDMrNJSU9LEmyUdl+C
 9La14hDfgnO95BFG9+ZavIFfVafWhU6D4BaxC43Zzt+xkLD96iYniZzXsAB4cU8Sxnfr
 cNtg==
X-Gm-Message-State: APjAAAXYckTSPaiihjr4u1cKHV0X6dYyR3fO1Kd8+RwIn4rF8Oiaw9Qw
 JnBjSfCAYev+XMPbRcGn1LsVN5/6jcd66A==
X-Google-Smtp-Source: APXvYqwt/S3bCk7MAnqEAWcbVco77/ja8ShLnJUJ4gigeDUwsj8c6Sso+eX5dKoyGHyLlquj57pAOQ==
X-Received: by 2002:a05:600c:2301:: with SMTP id
 1mr4433546wmo.147.1581166707530; 
 Sat, 08 Feb 2020 04:58:27 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/20] target/arm: Introduce aarch64_pstate_valid_mask
Date: Sat,  8 Feb 2020 12:58:06 +0000
Message-Id: <20200208125816.14954-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Use this along the exception return path, where we previously
accepted any values.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h  | 12 ++++++++++++
 target/arm/helper-a64.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0569c96fd9..034d98ad53 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1085,6 +1085,18 @@ static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
     return valid;
 }
 
+static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
+{
+    uint32_t valid;
+
+    valid = PSTATE_M | PSTATE_DAIF | PSTATE_IL | PSTATE_SS | PSTATE_NZCV;
+    if (isar_feature_aa64_bti(id)) {
+        valid |= PSTATE_BTYPE;
+    }
+
+    return valid;
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 0c9feba392..509ae93069 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1032,6 +1032,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
                       cur_el, new_el, env->regs[15]);
     } else {
         env->aarch64 = 1;
+        spsr &= aarch64_pstate_valid_mask(&env_archcpu(env)->isar);
         pstate_write(env, spsr);
         if (!arm_singlestep_active(env)) {
             env->pstate &= ~PSTATE_SS;
-- 
2.20.1


