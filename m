Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD77BC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A908B20640
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3D16d5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A908B20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvVd-0004eo-7x
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJH-0005xi-P2
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJG-00044O-E3
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:23 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJG-00043t-A2
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:22 -0400
Received: by mail-yb1-xb42.google.com with SMTP id m1so3125220ybm.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FHNQuXQMvSWOnALEsyFOBKvFsuWLGIwZ/NlmLTA2nkE=;
 b=l3D16d5tliriTIa1Q1asTnjvJbPd48z6gi0A2GZ0Xyllj9fruO/FYkwEtpLbVLOXRf
 O128mNJzgxDZXJmrJRLZmypU0hiKnTPCYGjIwJ006uTcm+kyN2JIX8r50uNI4Suei0Xh
 6kO3utwb4N0GY3V8DdD99vKVzcNuvEjX2onthlL8HaqHO3+ZCPVh9ZgEdDqU+up4ylQj
 Pu48uzhRcGdqrgCFmpe2z/zjHkJXaiMqKbNADGPEmYh57JOyU0ZqxJW0Z5m9Xz+suMIY
 bXdopySRoedwvcFZVa1IqTaN3bRJm0YcElPk15W15XAeiMEmCyXy2wc6V1xlP9b1sX2j
 VINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FHNQuXQMvSWOnALEsyFOBKvFsuWLGIwZ/NlmLTA2nkE=;
 b=DBnMmt01iSVbJVDZcehMuEZEbVuoiKQY0rkr6w0Im0rtmwP32Mqh4hrQo+VuBd2Y2i
 Eo8xJ4/eY9n+L0PvgabVBz9IBD0PjiMX99bD1DOsChI+ngYO1DnuJvMC1Km7IBZgZPww
 iD01KtKf1LaiLQJ2hmBI6MToUyC7HjWkXBScSy+skgRca6OlGsdmGKMZukvEmzZG/XWi
 2UREh++YzDk+B5+fj2Lx+3ElslZX6lYe/gNOvVYbV6ilB48ZEFDxShdM4PPRX+H4wNYC
 PmPzI2KwonDcIfDqOao3IlQoIX2f4nOgbmKvXGaezNX+2ZZF1TB5K1sQtCbsl2N8bFjf
 rocw==
X-Gm-Message-State: APjAAAUzCBKWJP6KyW8cAO8tDqtVYK8edpKS8Bv3VaclQyvHRmTYdtui
 Eau9ONGdiyN1d6Ct6u8bH/GjrwGWWFc=
X-Google-Smtp-Source: APXvYqzgrzehQXu9st/iurPlafmwcE9xXyR0LK/oSjAjVbQ5hyHDgDXM/a0haKapXWMfM0ubi/1k3g==
X-Received: by 2002:a25:a091:: with SMTP id y17mr10050872ybh.193.1570801821364; 
 Fri, 11 Oct 2019 06:50:21 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/22] target/arm: Implement the access tag cache flushes
Date: Fri, 11 Oct 2019 09:47:36 -0400
Message-Id: <20191011134744.2477-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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

Like the regular data cache flushes, these are nops within qemu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f435a8d8bd..33bc176e1c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5978,6 +5978,54 @@ static const ARMCPRegInfo mte_reginfo[] = {
     { .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
       .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = GMID_EL1_BS },
+    { .name = "IGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "IGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "IGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "IGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CIGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CIGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CGVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CGDVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CGVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CGDVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CIGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "CIGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL1_W },
     REGINFO_SENTINEL
 };
 
-- 
2.17.1


