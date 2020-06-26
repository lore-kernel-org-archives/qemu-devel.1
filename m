Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0B4207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxWb1ZbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0B4207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqCB-0007fQ-CR
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq41-00029R-6I
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3x-0006Jb-E7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so9087934wmm.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rjuUJVD20e+gziaQHiWZSwoTVScu50+CWJVxi25EUi0=;
 b=hxWb1ZbI7ZjxzlwUEX7AYsgh6PXtnVBPZa+B6C9LsN7/huzG2Gc5/cmHG+55HpHIwW
 /gctvslhWJmMukLwbTgA0zcXgRuYSk6HV+Ls7cvoskNh7HKAeXBSRbta3lwttzVeLG9l
 gnyWBEbUGNMsKBdjNbTvnbzQLw0ccDO/cVIVWflM5xVHbK9cjwCaFVj3i0KXRpgUsYT9
 skxM1b/1hmlmagNNhHjae8RiiIf8TEKtb9Vl6fXdhc7BpvAuAMbvDzXLfFF4kMx/UsCF
 vLtRi3CkNQWfhdyFYqL2di9gmKw6a+GHO4qC0R7VzR/7p2zXXxRl0JZsMC9lJh6qlgsx
 DN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rjuUJVD20e+gziaQHiWZSwoTVScu50+CWJVxi25EUi0=;
 b=CGF9VqnZHWxno71fIZ0beitCpZqTBtdGtfsmiKw7mnUrYwl6ojC9z1cBLWsplSnGy/
 /lsCrkfOOjfTv7ARRE3NoBujAgWHZ4++9RAO9TsXV2W8y5Ab9lktxPQF4OthCaaK0j03
 4QRYrqAP4dZZVpCu9WrKpbYrzwJHtpuMjASBp5jR69VI8no+BuEicZIV1du90iFzy/21
 hIbuM+xdJcCAC9VCq/DAtKbrVydgkBiSlho0HJhsAFor8XhoEQ2MW/BRhflD7oLFnSf4
 dE5GWMyZhI1nYGbLHINaBb4eBtdxiM7NINb+0/qhog6dt6Ni1UG3hqQ7ag1dE8YtVbg9
 zSyQ==
X-Gm-Message-State: AOAM530uEEGPITJuUSBfeoLI/WOcsPSTq6hZT1P8UJcZVoQrz5bwbteG
 PquRDMXQk8WzR4UYQno0W3v8dWPNWYPUnQ==
X-Google-Smtp-Source: ABdhPJzaZ/1zxa6AwmD2hIDklCxxKpTIGVpqazaCIC4JEK4/CSFvK4ActxUvKXcFtlfUckoMc1Wk+w==
X-Received: by 2002:a1c:6354:: with SMTP id x81mr3823816wmb.98.1593184482122; 
 Fri, 26 Jun 2020 08:14:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/57] target/arm: Improve masking of SCR RES0 bits
Date: Fri, 26 Jun 2020 16:13:41 +0100
Message-Id: <20200626151424.30117-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Protect reads of aa64 id registers with ARM_CP_STATE_AA64.
Use this as a simpler test than arm_el_is_aa64, since EL3
cannot change mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 972a7667309..a29f0a28d84 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2011,9 +2011,16 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     uint32_t valid_mask = 0x3fff;
     ARMCPU *cpu = env_archcpu(env);
 
-    if (arm_el_is_aa64(env, 3)) {
+    if (ri->state == ARM_CP_STATE_AA64) {
         value |= SCR_FW | SCR_AW;   /* these two bits are RES1.  */
         valid_mask &= ~SCR_NET;
+
+        if (cpu_isar_feature(aa64_lor, cpu)) {
+            valid_mask |= SCR_TLOR;
+        }
+        if (cpu_isar_feature(aa64_pauth, cpu)) {
+            valid_mask |= SCR_API | SCR_APK;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
     }
@@ -2032,12 +2039,6 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             valid_mask &= ~SCR_SMD;
         }
     }
-    if (cpu_isar_feature(aa64_lor, cpu)) {
-        valid_mask |= SCR_TLOR;
-    }
-    if (cpu_isar_feature(aa64_pauth, cpu)) {
-        valid_mask |= SCR_API | SCR_APK;
-    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
-- 
2.20.1


