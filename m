Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB4EC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6AD21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojWFOtkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6AD21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOHn-0005hv-C1
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCT-0005DQ-Cr
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCR-0005xD-HU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:53 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOCR-0005sj-91
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:51 -0500
Received: by mail-wm1-x342.google.com with SMTP id t23so3330174wmi.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8h7oBVip4xCS8Ml7altm+vync/6iKNuvypVZ5rPnaaA=;
 b=ojWFOtkj1suvrD3XByh5WdmOAOoRGaRQckbwSSuySvTBt9BvE+nT5sqNMjYCL0tTuK
 vw5JooGc7JSSGSQ0mRGrq2uFbodekuXAhwkMzc52s2sflilfSH0i3EFG31w3hMLCW1L5
 ynckh8n5weNo5Ixi5o4EJcj3lVYoWwpkOcJvk8MyqIdRDLK9Q/bLurselkfVtHvU2PFl
 ip8t8dGnqVIsmCuo1ILeN2hiXzu3ufthMPB5b3VpLTWYi25TDkbSz0V9/DX+doEQkg7F
 6LKd9O/REBuQNEHtvPd89Q9lemFiMUrarM5OdLkNQ8bTsPxhcN6zdTE1cfXEC4f6RDoX
 +YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8h7oBVip4xCS8Ml7altm+vync/6iKNuvypVZ5rPnaaA=;
 b=uQSdzfpMDFvcVSWXUFy6u+KattYHo0QprLejSTTDHjj+XByYZ7TYH8TkqVqsMtPwBp
 pys6hfYC39IfQ6P5NnlushhH5+p0YJGEyypesGzHKWmWpqT/fQlVzlCzzuw8P/LT77Cf
 opEIqM+vIQhxQxiqnLnCphJihVNZiwTkUzVJQYtWThD32vOjcFWqRapPQMLYovzu0fDM
 w+8B3lWtYU8VeDfnknkpnoTMDsBih/YckDg9hTuJFFI8R9eA5N5CkdZ8Zi0vc++FBqkq
 NDhNLPhLLDvfFUUkSXHGbzLOlfrrN34/aO/8SMAJtovFxBxAlcFrFQSxhxYeqLBIZgax
 vEGQ==
X-Gm-Message-State: APjAAAUM7G2Q2aSq2lPTGzwLV/seUX59UMdvNzIllCfmM3sg9XnnyB98
 ajU5O1D0g8wEHgzZIBBNrswiPQ==
X-Google-Smtp-Source: APXvYqyoGOvrKB7SUuhmXTz+JFFr9gn/RFJk8bFWugj52FFyCD8E133nyZP0FF1dUQY5WQq39A+JUA==
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr6459819wme.23.1580922650176; 
 Wed, 05 Feb 2020 09:10:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm523734wrw.70.2020.02.05.09.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:10:40 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1E3E91FF9E;
 Wed,  5 Feb 2020 17:10:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/22] target/arm: don't bother with id_aa64pfr0_read for
 USER_ONLY
Date: Wed,  5 Feb 2020 17:10:23 +0000
Message-Id: <20200205171031.22582-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For system emulation we need to check the state of the GIC before we
report the value. However this isn't relevant to exporting of the
value to linux-user and indeed breaks the exported value as set by
modify_arm_cp_regs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - extend the ifdef and make type CONST with no accessfn
---
 target/arm/helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 12e6284563a..17b06396ab3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5930,6 +5930,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -5940,6 +5941,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
  * Secure state has already been delt with.
@@ -6432,16 +6434,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
-              .access = PL1_R, .type = ARM_CP_NO_RAW,
+              .access = PL1_R,
+#ifdef CONFIG_USER_ONLY
+              .type = ARM_CP_CONST,
+              .resetvalue = cpu->isar.id_aa64pfr0
+#else
+              .type = ARM_CP_NO_RAW,
               .accessfn = access_aa64_tid3,
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


