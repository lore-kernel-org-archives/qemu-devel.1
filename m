Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D5CC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E365820658
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ee2CS1UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E365820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyTh-0000U3-2G
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySM-00073W-FQ
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySL-0006Rj-CM
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:26 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:50477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySL-0006RH-6X
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:25 -0500
Received: by mail-pj1-x1041.google.com with SMTP id r67so4474282pjb.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H1scrHoRFHkW8V/qxPSJeuSDB15CpU5xa7Qviebbre4=;
 b=ee2CS1UHNBC+W3OSWJyMlRrSmG/GlP6pp0vgOnBrIFgNFnsZa9GIsRFkPQeZQGGxaM
 /JF3b0YpdViTZ1GZo2nl0NbOq5sfbteu7K2XB55LNYgKdPrKvxx30+/skOkhjw64Ht6H
 Lr/V/qJnqaYK4CVUydfVzpX0E+ju2a4jXLJkHZgtP3P23RsNBC8bwAShZj2iP1+DwxhG
 iRYMPjAWUhunx01lQEOF/tIgtY/3p4iNE6yjr9WJeaRYW897d9VHySMGtU1h1wcaW/G+
 Cje5OJzGY3jSUGy/ef4zdRZDlrVuyleCZm65wNTkESq6OGaKWkF9eiyCHH9HJN01gvMi
 36TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H1scrHoRFHkW8V/qxPSJeuSDB15CpU5xa7Qviebbre4=;
 b=Y0TE7/UrZ5u1fr/xcZWRzeRojg31NE99cnyxeEB7jv7gHaSBTh2Nsr/sg5ZZdRDJ8q
 wfxRDYD+jELtWK+JJReYTUUlw+UjXw6N6PVLYJ2iG4PiFaT8UY3pKUJmd/s+TXxD65kw
 6FmQcq6aONdrRWH8WQkpPbotjaz+rRiJuYSJFEg4JwURfQG8bwPwFB23zmqP+HCCIrt4
 06TIzn7dJidrhtLxk0hcupQgUSpdIfWb2Cvk7g18Sn1zKa59EqOKuBN9/JASfCqbVbJ2
 mnWjvbEQpw3s+KnhBP6iaO+SEUWXl5/kKGuzH0+lx/NoTr2oPLuD0io4loW1NAf8V3E1
 D0MA==
X-Gm-Message-State: APjAAAVo2LTTby/T+krNNoU8lJH/VVabxEs5cNNrJmFEfoqFZKj6teBx
 lEMDEIyzUsKhna0bIOsSp2H4fuXNF6U=
X-Google-Smtp-Source: APXvYqzYpd0NU1Ep7XtXp/s/I69rIXM7/Ws1l/iIdxCo109qvBOWuhcIw/81AWPYMrUdh6lFSD1Q7Q==
X-Received: by 2002:a17:90a:2223:: with SMTP id
 c32mr20883169pje.15.1580585363794; 
 Sat, 01 Feb 2020 11:29:23 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/41] target/arm: Update CNTVCT_EL0 for VHE
Date: Sat,  1 Feb 2020 11:28:40 -0800
Message-Id: <20200201192916.31796-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtual offset may be 0 depending on EL, E2H and TGE.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c7ee0d603f..dbfdf2324b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2515,9 +2515,31 @@ static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gt_get_countervalue(env);
 }
 
+static uint64_t gt_virt_cnt_offset(CPUARMState *env)
+{
+    uint64_t hcr;
+
+    switch (arm_current_el(env)) {
+    case 2:
+        hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_E2H) {
+            return 0;
+        }
+        break;
+    case 0:
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            return 0;
+        }
+        break;
+    }
+
+    return env->cp15.cntvoff_el2;
+}
+
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - env->cp15.cntvoff_el2;
+    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2532,7 +2554,13 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
                       (gt_get_countervalue(env) - offset));
@@ -2542,7 +2570,13 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     trace_arm_gt_tval_write(timeridx, value);
     env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-- 
2.20.1


