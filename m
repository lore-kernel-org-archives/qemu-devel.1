Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABBFC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379A420720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NS0enqB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379A420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04xp-0001Ya-AX
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hy-0000eL-Rh
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hw-00033u-Nl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:13 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hw-00032h-Gg
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:12 -0500
Received: by mail-wr1-x42a.google.com with SMTP id u6so2986431wrt.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=V+BesusINKYFRKNPKbDWdPMHw6E3nkQRWe8lVcNiO3Q=;
 b=NS0enqB6E9uGMp438UOfRLfsS6MpHbJ/c3ud1NqE9auou2dgIxxCjwVLJDv2ezPkpM
 N46Z+30931HxkIBfM4MUqwLFuKyqBa4IZW92OD4TB1Tdm4HMXmRv+w1Em8xk6nrSAQnZ
 VNE5D47lzDuOxlE7zsBWqm94QbpKiB0lyuwpNe2XCpDgwQelNw4bC+HU6maFpwtTCTyy
 2M4cMvKJLzKB89yjXnuKm1AcoqPoSyqsyY5UdHtrrp1HrqaTggKPvt3t4jyGE2sQQtvy
 5SFXTxzUV9R1XDEmg9UNYjQtXUGGzxeJNE51ENwso7EG1tNeRwP6P74s0KIf49cgRtQw
 TAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V+BesusINKYFRKNPKbDWdPMHw6E3nkQRWe8lVcNiO3Q=;
 b=p4R1u+3JeyFsAGwnCqOkCpcTk63aFb8FzZHw5ubusY8zRCVX0pAUkRNCxDpc0yAgvy
 AhVkL2PBMbansYyTigLhbnoH6A/SDvn67ui0GtXXvY9BkVjMhTeSaUv6uuDutP3WZS/D
 AvbKlXmDMMHjy7gHd00lbjBp9FivLaE+QJnftTb+0pUOzkzm3+5P7hJgShu6jx8K4Z2s
 C8kx/Ye2OxNZE6aTF4pu6hvEn2dumT6Ef3nCuOgvz6aeNMpfhDNru976G1jEptmfxLS5
 4EHrwuP5Bkkgo+W2SD/+lMateYl2LVkw6uAiCGdvwmHsVmN9WYC/GrYR7vdlAHq9AkVR
 qGKQ==
X-Gm-Message-State: APjAAAWN6pkEw89gEWb3UgNzXMJ0TpoWPbdycPxOyH3+58zcY0tDpaip
 sjCf+eEQ0H1fVycI8O5FbuR+XFPowzs=
X-Google-Smtp-Source: APXvYqxzaxaDk5A5kUr5wFs2MVmXxaGuJPBR6CSzRFY4lOHigAfBA3sCD/RC60RPORN34A+teruxzA==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr5165431wrp.203.1581086051375; 
 Fri, 07 Feb 2020 06:34:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/48] target/arm: Update aa64_zva_access for EL2
Date: Fri,  7 Feb 2020 14:33:19 +0000
Message-Id: <20200207143343.30322-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

The comment that we don't support EL2 is somewhat out of date.
Update to include checks against HCR_EL2.TDZ.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4f368d96b6..e41bece6b58 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4159,11 +4159,27 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
 {
-    /* We don't implement EL2, so the only control on DC ZVA is the
-     * bit in the SCTLR which can prohibit access for EL0.
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_DZE)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TDZ) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TDZ) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     return CP_ACCESS_OK;
 }
-- 
2.20.1


