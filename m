Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A20C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C21E2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWobYaBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C21E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idG4z-0003NA-FX
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1idF1Y-0003hm-Ea
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1idF1V-00011m-Hf
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:56:03 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1idF1T-0000zK-Jp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:55:59 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so8114424wru.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FD/Gkl8WcCvCcRAxkg2Vj/Km0ssoYdQNd69civUvsNY=;
 b=rWobYaBzJqmLkIkFrA5eMyiDv5QGLzEibM6XsJ01npKypFTPnNbcMitaPvGtmiQogt
 ogK6OwYXXuqsY8NJpqjGpNxGXIPPBiz+iFNNzxYC9EMYuVlLYpBgiLBRU/mLQN+frdBd
 H8Lkkqm8jyNTVbiLcnqLrKaaxx7T0xwr60IcchvJjngjxJ5MjlRGmEvyJBUC8BytOJ3w
 6Hl2sIe3WID49sW4CIKiLeagLJ8K5oo2lap3BMMIv57PqR7CcgJGq0NrcFyauy4Jm8tu
 huQbHIx7VQN8GM73AY9pVjWEHJ6g8tCnTNm8wQPieX1CZUcjId1i7SwEghYFJ7tJ4/7F
 wDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FD/Gkl8WcCvCcRAxkg2Vj/Km0ssoYdQNd69civUvsNY=;
 b=RlpUhdhtGQFqv5bb71y2j7fraSxlYGnwdviP12nGP2VFK+bCEnnbHvB85TK8Xsai1T
 lwAct3SOrWJ5enQtWu3S5H9XPz6GQBLa6yioi4DhoIg6r5fEwQeHuCf5oWm2nvKCA/cf
 6SIXDZjOC9STREI7nCfjRZrdcK7hQyf3ajLmCdnaLoZxztWnG8ZVZmoPqmxiJi+kOvQa
 YlnqpB0bDCv9Mxx6nnya/D1XBdnJs4r2xejhtLTxpdY9sKx4lqv/306zw7ObHW4cPald
 jt/yVhWPfsYkjXa/AMxDrUM9eAWea5OcmWpvr62RS4ttEletrILxWYzB6YS9kyJAzHIS
 KhfA==
X-Gm-Message-State: APjAAAVLEUVx01Mv6SN+vwUp5Ndu5oksm1KtKnBS9pH4xrnFlhwpqVJq
 jnFK34zx+d+MDOuifELNTiKhs0eppRk=
X-Google-Smtp-Source: APXvYqxkx0SwWhQUZQbI5bGBGLowxnE0tSC2lFGY8s6O7J/AuvXKgVTBunS8dXesZwKJCtCxqMcLgQ==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr15105563wra.36.1575634975459; 
 Fri, 06 Dec 2019 04:22:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm16242114wrn.33.2019.12.06.04.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 04:22:54 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 991831FF87;
 Fri,  6 Dec 2019 12:22:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: don't bother with id_aa64pfr0_read for USER_ONLY
Date: Fri,  6 Dec 2019 12:22:47 +0000
Message-Id: <20191206122247.7507-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For system emulation we need to check the state of the GIC before we
report the value. However this isn't relevant to exporting of the
value to linux-user and indeed breaks the exported value as set by
modify_arm_cp_regs.

[AJB: the other option would be just to set reset value anyway and not
ifdef out the readfn as the register will become const anyway]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f78dd3b5fe3..489c31504a6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5867,6 +5867,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -5877,6 +5878,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
  * Secure state has already been delt with.
@@ -6297,16 +6299,22 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * define new registers here.
          */
         ARMCPRegInfo v8_idregs[] = {
-            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we don't
-             * know the right value for the GIC field until after we
-             * define these regs.
+            /*
+             * ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST in system
+             * emulation because we don't know the right value for the
+             * GIC field until after we define these regs.
              */
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_NO_RAW,
               .accessfn = access_aa64_tid3,
+#ifdef CONFIG_USER_ONLY
+              .resetvalue = cpu->isar.id_aa64pfr0
+#else
               .readfn = id_aa64pfr0_read,
-              .writefn = arm_cp_write_ignore },
+              .writefn = arm_cp_write_ignore
+#endif
+            },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.20.1


