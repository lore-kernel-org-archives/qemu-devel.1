Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB89EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F7120637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2Nq4rUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F7120637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tpX-0007nQ-P4
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP9-0003YY-Iu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP8-0002M7-DF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tP8-0002LA-6i
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id t11so7800096wrw.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Jjemy7ru1k2oXG98tCmpSClPpvqk/pa1WkziMWFO4pU=;
 b=l2Nq4rUag5eksIE9FNjjNSH0/zgz19Yps3MckrIF0WOYepXzSXYpsVzRL1ECt7Uia1
 S1K7FvYW1RyTZ4UCzBf1sO0/u2twcOH7x53gGp3b5pmrT8bpf5+OljKSq7I0Z2bBlgn5
 lbHwCcP6u7Y1hT7ZIB96lpSzUOvVnJE4qssD7hIa4JsKXEleTbvOmhJg6c3xYFn2J07d
 1JXh+liXTyN3net1z8AY+JFPV0Hmqm96of+7GJptyHvTMfM5NtlXkY5CPLRJ48f0trSU
 VZ1P1JOIpdol+7Nzj8dfZRfVhWL8dFvQMENMLAN7UyLhdtLyuM5r0L5NYwUaKP0YZQdU
 cgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jjemy7ru1k2oXG98tCmpSClPpvqk/pa1WkziMWFO4pU=;
 b=lkfbp0s4UfPQ52wyYqHJymezno34saHjCJ+o1FY1wFXDs2lZITmqEz/Wh2q2NxS1aG
 XMmGrPR/C0wlmIMYVhUeMMiV0H72n4Dw1SydgI7TE6u2YkdRqc6Xo9o7gJlRFH6Aho3U
 A7gn5h6/fp6UN6jOehkYbl5ah2MYHu33arORaMOxlQB2gaUxJ1mn3zKof8sTu/jLlsO3
 apnEXroWnd6+KmjhM/13wsTizF+8Eq1gTRHIQb5O5XO55jPA6ju0dt/9AeBSwWg3hkc7
 k/OCrwroZOLId8IF0xBvBvhspVKgE57iwNE5Emqhb1r8XDN/A0hZvvhP1Oqg7+h2X6uk
 ayfA==
X-Gm-Message-State: ANhLgQ25EODcPNLB21HhRMk8rvS38m7LeFvsfSE5cH7U5bFb50mAj3YS
 wUHZ1osbXx99pAXngm6NGCcXuGi90rtaWg==
X-Google-Smtp-Source: ADFU+vtU2tNg7s2yWk4TaimOcYSVNl5gbit1/HW083kNmwiXoQe/enQVBUqrhrqOzfXToyyAQV4qWw==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr11935691wrq.153.1583425880918; 
 Thu, 05 Mar 2020 08:31:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/37] target/arm: Disable has_el2 and has_el3 for user-only
Date: Thu,  5 Mar 2020 16:30:40 +0000
Message-Id: <20200305163100.22912-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

In arm_cpu_reset, we configure many system registers so that user-only
behaves as it should with a minimum of ifdefs.  However, we do not set
all of the system registers as required for a cpu with EL2 and EL3.

Disabling EL2 and EL3 mean that we will not look at those registers,
which means that we don't have to worry about configuring them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index de00a45e903..185a46f5abd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1103,11 +1103,13 @@ static Property arm_cpu_reset_hivecs_property =
 static Property arm_cpu_rvbar_property =
             DEFINE_PROP_UINT64("rvbar", ARMCPU, rvbar, 0);
 
+#ifndef CONFIG_USER_ONLY
 static Property arm_cpu_has_el2_property =
             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
 
 static Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
+#endif
 
 static Property arm_cpu_cfgend_property =
             DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
@@ -1222,25 +1224,25 @@ void arm_cpu_post_init(Object *obj)
         qdev_property_add_static(DEVICE(obj), &arm_cpu_rvbar_property);
     }
 
+#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         /* Add the has_el3 state CPU property only if EL3 is allowed.  This will
          * prevent "has_el3" from existing on CPUs which cannot support EL3.
          */
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el3_property);
 
-#ifndef CONFIG_USER_ONLY
         object_property_add_link(obj, "secure-memory",
                                  TYPE_MEMORY_REGION,
                                  (Object **)&cpu->secure_memory,
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG,
                                  &error_abort);
-#endif
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
     }
+#endif
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
-- 
2.20.1


