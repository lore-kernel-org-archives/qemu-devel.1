Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B588C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1861120674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eG87WYHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1861120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGZi-0002GF-5k
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUQ-0005S8-2Q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUN-0008JA-Aa
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:40285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUL-0008Ca-Jf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id z12so254032wmf.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z2YdO0eBBHYBuVAaMP2mXqLSUKwI7KCxJYvCQtmd2VM=;
 b=eG87WYHXKlRUlu9pUbxueBEqwocJOn6lcQTvIf9lZdlcXHSAtYbrNk+X7NPsADue+/
 AiJN+HhqoXheS95WS/Z+wdGUJYt7YdSlOFQm9nM2Hdw835iNvZxF8y6G9gc66UWhWgwy
 ZUcR0vdlRpIR7gXfurBjI58VbP27SoELi3tPA0AIl6v2RVJhXInip+PJ6azayduVQBeb
 /Is80Qe5MbtfldSlrgCWGeetq1WOVt0vGTHaq/3pMYuNFsF4KOCnyM/56oqwwKg1hvyh
 6iRgUmmXh06GJJHrvFB/1VxjON+3RUwnpt+wIt2A9l1nff5HcNZn0QCIUDg1vUwuzvRS
 nL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z2YdO0eBBHYBuVAaMP2mXqLSUKwI7KCxJYvCQtmd2VM=;
 b=kXJ2lDd4NicCVrEjg99dsmyWaeaj/fl8Vl8W8sfVRG3Z97cu5DjPgPxVM8LqFfpHxM
 yqX4+//rJzsAtMlMAWck/VIrLHe+oQucPxsqVWYgRxwFX02YecjIrTn/Nr9ek8DhVTeW
 8Gs4XRKjGvF62gstXQ+JnyTBu+mFHySMJkGtGNOEVekgPzoIYRUyUuOqvCGn7RQWu+ov
 qw+To7T7fpj48T70H4c7RcIyvevbm7Rgv35qU3YxuUo+EeZP4padnpe9LFJLqvAYqeTD
 JYXH/q+NJyavDQhLgVmGGZB3B01WqgemrXX9RzoPef4lIZk2fc1DnKgR4WNPuYo9JDaW
 ZtKw==
X-Gm-Message-State: ANhLgQ3tA4dzAyVRiO+MaIe39uvunmdeihw/fhPK4OljI/Q3cJFqwy4D
 Fh3bDyy99+pV7gsP90CUWOkVVA==
X-Google-Smtp-Source: ADFU+vvrD3qzINKATncKNGPLpYtiR6P4viJ37S1hu1nm1BSvyoZ32IpDgkY8kn2fHh5HHUbrJlx0PA==
X-Received: by 2002:a1c:5443:: with SMTP id p3mr169796wmi.149.1584467927282;
 Tue, 17 Mar 2020 10:58:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c23sm215647wme.39.2020.03.17.10.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5009E1FFA9;
 Tue, 17 Mar 2020 17:50:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 19/28] target/arm: don't bother with id_aa64pfr0_read for
 USER_ONLY
Date: Tue, 17 Mar 2020 17:50:44 +0000
Message-Id: <20200317175053.5278-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For system emulation we need to check the state of the GIC before we
report the value. However this isn't relevant to exporting of the
value to linux-user and indeed breaks the exported value as set by
modify_arm_cp_regs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200316172155.971-20-alex.bennee@linaro.org>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e560ea7db6..d2ec2c53510 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6697,6 +6697,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -6707,6 +6708,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
  * Secure state has already been delt with.
@@ -7280,16 +7282,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


