Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E7E246A2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YY2Mz0sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E7E246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7qyr-0003Lg-Pj
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvW-0004kZ-67
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvV-00060b-2b
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:22 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qvU-0005z8-SX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:21 -0500
Received: by mail-pl1-x641.google.com with SMTP id d9so1900247plo.11
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QpMHNZIbcT5PzqjajR8IDp8eTMJQTzdyuvxjhrMoYDc=;
 b=YY2Mz0sznUyzLkAu1ttdhi9ccja2VcdZ72zNGleYvo831HwzPkcs197oPmgr6em6O2
 LZJH/O75OrxN2+rDi1nF+8SgvkWTYd5qQpCArvjePBcriTVbzyLidObarP1f4M1+jcn/
 Y6PhNuae4pAmb56QmYcCVgpy7FzESM3dM7H5LCOStgueezcuczF2mTSszdceXTpUlYN1
 LeupHVsARLhHvRKtTZ7P8LZBoszOakQUg1se3av9J4n95a3xHEMB3joKVLtdQuyH8A+G
 3ED8dUat1+2kN1KLcCFtppx8Jf7p7OxzaZqbTqTQWkMOhCRtjuYNG4ZShvVPj+hlc5K0
 EXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QpMHNZIbcT5PzqjajR8IDp8eTMJQTzdyuvxjhrMoYDc=;
 b=ZNG2fZUWQUIwRKUd2HhY9gdr9ZJhfzd+4tEyl6TnK6jt0G1mosDHsi0xQmtIStzGTJ
 C7tdOtsDhy0W5sMvfIdxtUjP4gvqiTgrumNqSuqfP7720TSCuiqnu0Ya2WQpQRhR84KT
 D6TKcytVX1p+/WAaIhQmjbQZLHA9KXcYTR6pwSNEm/mPEJPZP51M1T+Uk9lTWz909JlX
 TInLYOlfaK3q/JRP45gU8VoXffNk9bmTDDiPjDNQPPRRQqcIr5WSa4SdRlPu2K912Ynx
 lVmukTpn8wSxqNSBBAe/ts6AiqMh3UpF10rCBqr80LCbRFkad9rUY/VpyVsAK++7oq7m
 +mCw==
X-Gm-Message-State: APjAAAVrzDhwCKKwm9RT5mNM47xm0eCAZAJfsI3YOFeq7VUINDw+EyGn
 9jZpPchHb1gVHSmR+a7ekBZWKlcy4kU=
X-Google-Smtp-Source: APXvYqwkCjGMdstyhYyogHKj1DoGDKawMt7g65hy7zFiuS6OCr+vn78moluMw3RJ/Ct23OF2b8DJXw==
X-Received: by 2002:a17:90b:243:: with SMTP id
 fz3mr7826522pjb.29.1582939698546; 
 Fri, 28 Feb 2020 17:28:18 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/12] target/arm: Disable has_el2 and has_el3 for user-only
Date: Fri, 28 Feb 2020 17:28:02 -0800
Message-Id: <20200229012811.24129-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In arm_cpu_reset, we configure many system registers so that user-only
behaves as it should with a minimum of ifdefs.  However, we do not set
all of the system registers as required for a cpu with EL2 and EL3.

Disabling EL2 and EL3 mean that we will not look at those registers,
which means that we don't have to worry about configuring them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e6016e33ce..33c28fe868 100644
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


