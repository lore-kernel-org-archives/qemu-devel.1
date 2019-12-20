Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC45C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F5424680
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7fqNRwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F5424680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHJS-00046V-Qd
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiHAr-0000dv-VU
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiHAq-0001FF-9b
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiHAp-00019u-Uj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so9163500wrl.13
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KRu49EbgGVQ7V2rxhXNHs855imxrN5MTwZSo9giC7oo=;
 b=H7fqNRwdjB5hRPbOqjSzn3+92GkPWo2OL6At9HiFJ849JvF6TXaExMH38Jhn65KSh1
 qoPED6b3NLZASeBJKKMcPoWXptmNZglhfPOaQxVR6gLA6Ao5So503ISzRoJZxqKm4PVX
 X1Qgk/bP5I2fSIFfCxTWiKGLvuYlkan7LYKxQDYCVj+hibAwZ6oThn5C9j5xoh9Wjvl0
 3Y60fPxB28nL2F0HMdn1xQgKBOy1ofEXAuapr+thnXdzyMidic8Y125WGysvN1pAD57m
 PGNArncAjLnLlNYOD2qlV7DZcPbfZHvlNNQGfjXfAqHmBS/35mG2COdGwcLe3XzjFhP9
 D1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KRu49EbgGVQ7V2rxhXNHs855imxrN5MTwZSo9giC7oo=;
 b=J74Qu25/7jnSjsjQK0SLThR53zaEekvqv1Q6NjXmgMt+3sLVjeM/622eWWQ2ZrZgUv
 QIvK/17m9qoLLnqeSrugxU24Ot1xPGHSdBy06HuHEgg/GRrhxhEdzADprYP7v+tprFGE
 O2kpBXubVHVjjEAimpd9JZ/2VJXDebmxzH5zanNDwIMhcJDl4RdMh1SYHPa66juhfwld
 s19iJzypHqgwRuaz7AL7X0k6xA4cOOgTUDfHLcgXKIeDsHTJAEv6npwHEPtXNxI8KQ4b
 SgAx5AWUnzMxgPyEkVUD8XJwgs4qiJ53jNSsme2g/tE8bAaLyYxFFZBT6hlosIRt2tJH
 mbbA==
X-Gm-Message-State: APjAAAVlDOGmmH/Mh03qwFpmq7Haj7SHgeVzzOnYkPU0LOV1ZZetbYpZ
 RmI0DoThcwu2/iDLk0weY6Mwsg==
X-Google-Smtp-Source: APXvYqwG1E79S18wR/U2W5oNawtlyC/jVDVN0LjN5nXvRKi5Yb44+oYVxdxib3HrqULreqS1hJ/W0A==
X-Received: by 2002:adf:93c5:: with SMTP id 63mr15130458wrp.236.1576844066353; 
 Fri, 20 Dec 2019 04:14:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f207sm10901781wme.9.2019.12.20.04.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:14:25 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6CBB11FF9E;
 Fri, 20 Dec 2019 12:04:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/21] target/arm: don't bother with id_aa64pfr0_read for
 USER_ONLY
Date: Fri, 20 Dec 2019 12:04:31 +0000
Message-Id: <20191220120438.16114-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 luis.machado@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
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
index 857581feba4..23de21f8820 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5912,6 +5912,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -5922,6 +5923,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
  * Secure state has already been delt with.
@@ -6414,16 +6416,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


