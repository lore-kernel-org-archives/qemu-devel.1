Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1392073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKEKXxOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1392073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fya-0002p0-Dl
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgx-0004MY-5R
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgs-0001oW-Ql
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:11 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgs-0001lt-JY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:06 -0500
Received: by mail-wm1-x32e.google.com with SMTP id q9so6527353wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=61vVlMzzHiCFs/xussXaIHw4eQnhk5SVWAOHn9JeXe0=;
 b=bKEKXxOwXTmrLsZBKZzmVTCFPJVs3XNHE4i3w97ZS18Fj3JYX8Tf6HsPnC+LGDaTt0
 0DJGTuxVNrPKj3d2zBBDq6KlfInfrGeBcg7PORYTplY6KVGtnpUydISTLO1/JBYijzqd
 X7pqPn+h8XEKRmfUPr6T6TogpF3y4oSDPwz1fHDGBgDymu4jp2o/hYTyw6mThXVykpen
 0FY2leaAwuZ+dK7eilANtH8z4LkW/5DKfZS3amBi6Z0KNfFqPP3wsxPR8BmyQMg6cdrx
 fhNUmwB7GB8Xf3qK5RuZICBgjtIPeiS8YMQuoHQgkQygG5iF1lkrg192rLeSREssfYLO
 U8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=61vVlMzzHiCFs/xussXaIHw4eQnhk5SVWAOHn9JeXe0=;
 b=LhkBTZkR23wSRgx0BhLZKEYGKCScOlsntW39lbRg0N9j3pWceH7I0g3zLaHdpQEzdp
 /7rET0pH/vU59wFwGYdsLLrmMOo7tAv1O80BeWg1rMIPLE9lsmMcb3Q2pC/4eGiAt792
 iZBmmo8zEesx520LhADQreCHSeSqVRTrJvxMvvwj2J35MAm3qtETIc89RkfZwmvhX582
 KjjXhQjmYffppWwx2Wxqr/wW84SHglqOvF3uI7Yw6d7JDRqfcSe8u7i+1f7arkqHh+cJ
 3J4IcPFn4MZsyk17vF0v12lYeaAwFkMqLbmQpKR4kHwXhk+wkLWk6PB72VceBBFrviJ5
 zDkA==
X-Gm-Message-State: APjAAAXqj4XiiXUKCXHiMUuSiqahK67o/9cammmu+JCvk+T9W2gsTMQG
 3IWMhLqX4BqyPjH5C6p89tRaT9an+lI=
X-Google-Smtp-Source: APXvYqzg07PAtyg1ndDgl0yjBgsb3CKNuIKzwjMfkZTLRjdgeuJGoWsr89wQhSrTVKAm7p1FEt99pg==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr6622499wmc.168.1581604924417; 
 Thu, 13 Feb 2020 06:42:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/46] target/arm: Move LOR regdefs to file scope
Date: Thu, 13 Feb 2020 14:41:12 +0000
Message-Id: <20200213144145.818-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For static const regdefs, file scope is preferred.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 57 +++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bfd6c0d04bd..e4f17c7e839 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6334,6 +6334,35 @@ static CPAccessResult access_lor_other(CPUARMState *env,
     return access_lor_ns(env);
 }
 
+/*
+ * A trivial implementation of ARMv8.1-LOR leaves all of these
+ * registers fixed at 0, which indicates that there are zero
+ * supported Limited Ordering regions.
+ */
+static const ARMCPRegInfo lor_reginfo[] = {
+    { .name = "LORSA_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
+      .access = PL1_R, .accessfn = access_lorid,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    REGINFO_SENTINEL
+};
+
 #ifdef TARGET_AARCH64
 static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
@@ -7568,34 +7597,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
     if (cpu_isar_feature(aa64_lor, cpu)) {
-        /*
-         * A trivial implementation of ARMv8.1-LOR leaves all of these
-         * registers fixed at 0, which indicates that there are zero
-         * supported Limited Ordering regions.
-         */
-        static const ARMCPRegInfo lor_reginfo[] = {
-            { .name = "LORSA_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 0,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
-              .access = PL1_R, .accessfn = access_lorid,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            REGINFO_SENTINEL
-        };
         define_arm_cp_regs(cpu, lor_reginfo);
     }
 
-- 
2.20.1


