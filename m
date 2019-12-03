Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C16C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D89C20656
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xS7z3I3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D89C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icH8x-0006Rw-Qz
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 17:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH39-0002aQ-G3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH38-0006Ro-7a
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:43 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH37-0006Nw-Kr
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:42 -0500
Received: by mail-pf1-x442.google.com with SMTP id y14so2106035pfm.13
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cInc5a19jU6WxGPEpK5KzVQbF4VsjSynVXIzjEULPhE=;
 b=xS7z3I3aUvdGgcrTGD4qP+BY8TO1wrSKD/eSM1S3Kt34LxYnokHUQaT/dO4ycglfdE
 cjZfPTqgnEZY7YWCIbYeC88KESjVbg8JAYMvifnOgkZOptcBZIubkKQF6sZ1nUlP1Dih
 CHFNYSwOx5X5aI7I5xEP9tdTZjr7QADRaqDlTUXn3N8p8IGSBxCzZstGC1uxhZ1Kedxd
 qoWxBZ0uFbwuJ+ni0kyWTCV22bgfdpBuMGAZjutRO+gHzHfi/DuiGDXGbKUQIyAmnnUS
 D6YQlc2K32zTQNc/qMIBBXOZwYaoYL7v0wLFceXneT5+HCdsWYcDL09CAhySZYftAADz
 026w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cInc5a19jU6WxGPEpK5KzVQbF4VsjSynVXIzjEULPhE=;
 b=R7mgLxV3qjJLrIV263iJ3xXTZ+ARNpqehZ/MteGu8TOz8JaKO/FpbCn+7ngBNBrp+D
 fg2pPZ870jqE9IHhzBGRr5zYx8ADhAmnXUoOBBrIMlmxnUO4ddkH4jTTLiUuW3YRNxwu
 iC9eQb97l3VPqA1Af+vG2xLjDWMK6XbGuxX7X2oEp8v0C4JaF6bvd97VeDeAQ0A1P8oC
 U7lO/G1yApiEJULaWBxwGzxB+0+7MLciWqx+jFlW6Q9v+VDNhoPGYNrCi6TCtIfMEzR6
 unQLWbJGmyCzeBxpyz0RZU99Ct5tmxPDwjMHqqLljBHVwzm9TcT13KtREU073bu9CtYB
 yOkA==
X-Gm-Message-State: APjAAAX1D8wkP8lG3l/SsGkdYREQfcE9ZAEMlTst1m9jHcDigD2HBgYK
 zZTUnQL8+EU7PxzALjhLy61hDxZq934=
X-Google-Smtp-Source: APXvYqztNttbmbt/BiahwMrxyBDKq86VegofgBGvLajYVB8hUwSEvdsPiBw31jgePM7ueLOxAAhyQw==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr320615pfo.82.1575413620282;
 Tue, 03 Dec 2019 14:53:40 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/11] target/arm: Reduce CPSR_RESERVED
Date: Tue,  3 Dec 2019 14:53:26 -0800
Message-Id: <20191203225333.17055-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v8.0, the CPSR_RESERVED bits have been allocated.
We are not yet implementing ARMv8.4-DIT; retain CPSR_RESERVED,
since that overlaps with our current hack for AA32 single step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 22c5706835..49dc436e5e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1149,12 +1149,16 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_IT_2_7 (0xfc00U)
 #define CPSR_GE (0xfU << 16)
 #define CPSR_IL (1U << 20)
-/* Note that the RESERVED bits include bit 21, which is PSTATE_SS in
+/*
+ * Note that the RESERVED bits include bit 21, which is PSTATE_SS in
  * an AArch64 SPSR but RES0 in AArch32 SPSR and CPSR. In QEMU we use
  * env->uncached_cpsr bit 21 to store PSTATE.SS when executing in AArch32,
  * where it is live state but not accessible to the AArch32 code.
+ *
+ * TODO: With ARMv8.4-DIT, bit 21 is DIT in AArch32 (bit 24 for AArch64).
+ * We will need to move AArch32 SS somewhere else at that point.
  */
-#define CPSR_RESERVED (0x7U << 21)
+#define CPSR_RESERVED (1U << 21)
 #define CPSR_J (1U << 24)
 #define CPSR_IT_0_1 (3U << 25)
 #define CPSR_Q (1U << 27)
-- 
2.17.1


