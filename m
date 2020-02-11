Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A1FC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C814920661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdxnJb19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C814920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Zbx-0002Lw-VE
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTo-0005uJ-2t
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTm-0004Kl-H8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:47 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTm-0004IL-6x
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:46 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so13513559wrr.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e9WDJDdjLb6cBOzgUb2FHyNTKjKf7aBhEJaTRctl1CQ=;
 b=JdxnJb19Yx+ytvD5ScJML7HO1/01cTmA2Y+T1l7Y85KZ1ebi7R2Z4Vuux3PMFCXfew
 RP16qgznOUeFfmbLZ+o8JcEyd10U1Jl8Mzgp24R5UBlFV5gJnPzU6+Y5iTV2pBDcpHhK
 wfqOEdNcJCInSpuZhT05TOZvlLC9P9dlYNoBTmQ/ZWAQyTeknVIZYrhnxF9Jg1GDX0XA
 EivwAUzjJ2g5+QhW7AwX5p2aRRJSvSm6MXf84d1ANT1aCctRvFVkt/6LgtdPtMMGi5Vn
 Dtj1xMmLWb8a5vQRk8+kcuaBZ7W8E+dUXtvXhFNWoyPIo+D+GQ1eZXkNiOz/DQqos7H4
 5/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e9WDJDdjLb6cBOzgUb2FHyNTKjKf7aBhEJaTRctl1CQ=;
 b=hYcxw/Lz+GZGMe/OnZtwxxSzA8X6PWjWcvK82CdvayYrEhrYk7drRv+2AfLCIvQxDs
 AXujmKWS6KKy9roX294ylzi87Z3Kb3v0lgCWNXKcBN/JrjZxxIJ+pAmgxuT7iHmZKKUf
 oABIMagm/GpLuQM9G2R/5DuaBmV0Frae8ZgyTDZfhG3imsw/T3ivT7E8IyvPSGSRV16q
 xgMgbKgqeh86MP0hG9pK3L8jk3JmxlYsFApQZH/P2mgcdQoCSJAXHPirT5w+0mhubQgx
 JO3SudjQOeccApRd2rwPEJxiQBruPqi7HukHowc3ZQX7p9avMrBuO2jmvnsDF2NSjnPh
 vBiw==
X-Gm-Message-State: APjAAAXlzUKDOAXLtlkKJgkpcZKs022P65EWuf64mAqTH++LxzFVA/AX
 7BtQR0r4zp8O7eej8kyTaffCoQ==
X-Google-Smtp-Source: APXvYqydVgqRLSiJdWgZ1rUN4Vsi0RcTQL8uJcHQatlwVPdqu6EihuWAQ0cHLvz6bCXuloLUochxgg==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr9482945wrv.250.1581442665222; 
 Tue, 11 Feb 2020 09:37:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/13] target/arm: Correct handling of PMCR_EL0.LC bit
Date: Tue, 11 Feb 2020 17:37:26 +0000
Message-Id: <20200211173726.22541-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The LC bit in the PMCR_EL0 register is supposed to be:
 * read/write
 * RES1 on an AArch64-only implementation
 * an architecturally UNKNOWN value on reset
(and use of LC==0 by software is deprecated).

We were implementing it incorrectly as read-only always zero,
though we do have all the code needed to test it and behave
accordingly.

Instead make it a read-write bit which resets to 1 always, which
satisfies all the architectural requirements above.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c6758bfbeb5..1d8eafceda8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1023,6 +1023,11 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMCRC   0x4
 #define PMCRP   0x2
 #define PMCRE   0x1
+/*
+ * Mask of PMCR bits writeable by guest (not including WO bits like C, P,
+ * which can be written as 1 to trigger behaviour but which stay RAZ).
+ */
+#define PMCR_WRITEABLE_MASK (PMCRLC | PMCRDP | PMCRX | PMCRD | PMCRE)
 
 #define PMXEVTYPER_P          0x80000000
 #define PMXEVTYPER_U          0x40000000
@@ -1577,9 +1582,8 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         }
     }
 
-    /* only the DP, X, D and E bits are writable */
-    env->cp15.c9_pmcr &= ~0x39;
-    env->cp15.c9_pmcr |= (value & 0x39);
+    env->cp15.c9_pmcr &= ~PMCR_WRITEABLE_MASK;
+    env->cp15.c9_pmcr |= (value & PMCR_WRITEABLE_MASK);
 
     pmu_op_finish(env);
 }
@@ -5886,7 +5890,8 @@ static void define_pmu_regs(ARMCPU *cpu)
         .access = PL0_RW, .accessfn = pmreg_access,
         .type = ARM_CP_IO,
         .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-        .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
+        .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT) |
+                      PMCRLC,
         .writefn = pmcr_write, .raw_writefn = raw_write,
     };
     define_one_arm_cp_reg(cpu, &pmcr);
-- 
2.20.1


