Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA8C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7146920706
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eum+PiPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7146920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRZk5-0006em-Ez
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRZjM-00067I-GM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRZjM-0007pC-0R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:09:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRZjL-0007nH-Is
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:09:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id g13so6340995wrb.8
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VlGWIXhjhVMOKcrHBCT24bZUCyJntPMX9y4VK0odchk=;
 b=Eum+PiPOayqHCiEa/E6PHYxAv7LxkfmO5dNWLfbFQs1Iv7vhwkMWHEZDSL/OhVG6+6
 hKnN/msgEjrRzV15B5RqlSeOxY35THIC+Qhrrisa+SmeyXcKbfwykFN6f3vUoHdo6ZzP
 Cp+KZ0AREbCg/CyMLvZEoQXmrhiMVGMSSiZB1jq0WJUYAVJRy2WgmrTm3ZYWmZIwvdLL
 EYRSGDEv6fCYX5upHAT7z2v0a3fxLsoGf2IyQ5t3VlDciwa+5usMM5UJXCINvtsZtSy5
 JHdJo07u4scwPA1Ol2EblcK1DHlojgK0JS1PT5NLYNxgq4987Niw2I3qgN5HG8b5jkHJ
 SbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VlGWIXhjhVMOKcrHBCT24bZUCyJntPMX9y4VK0odchk=;
 b=rgL4OdctBahTvcEfUB2h8fXKWnZEgzJpl8jKuwzSRL+aPV2lu6KIkw6+rttCmNNm4k
 +dZFVv28zzH/cBO2NrXOz9mMxWckY8du3wjWtnlPJ0K4KP4+GvVGubyq+TxZUQpV30a1
 WqzPp5imZUiLBOsUj8zh17bhGTJjM3Ozq8AN4r2grwBETtD0+8AbGONqnBLmpIBolSJd
 llDHt4RGM4H9UsKT25ixHSnydenILAGVv+ScQqsKR1AWuZpuvNoe68c3DsStScGZBnc4
 qOSPb4sVyMBRIQCMkW6RSVegw0TJHyUEnf5llleAxl9nD1/5HgCfgYNYwumtNFHHJA6R
 xTjg==
X-Gm-Message-State: AGi0PuYoSrohUHjPJlw9m718rEWv9RXsnKw+jBf1jhZgflZFBmrRufo4
 /MSbEJMxnPGARSQK1oh4yya4og==
X-Google-Smtp-Source: APiQypLrY2akUba3hEKAHoZM0FA33vCDrAdaKDOOJB/zGMVacJpyrEBTsHxQxjTuh5aALDz+ZaexQw==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr4198349wrn.209.1587640157758; 
 Thu, 23 Apr 2020 04:09:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l5sm3222495wrm.66.2020.04.23.04.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 04:09:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 ID_AA64DFR0
Date: Thu, 23 Apr 2020 12:09:15 +0100
Message-Id: <20200423110915.10527-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In aarch64_max_initfn() we update both 32-bit and 64-bit ID
registers.  The intended pattern is that for 64-bit ID registers we
use FIELD_DP64 and the uint64_t 't' register, while 32-bit ID
registers use FIELD_DP32 and the uint32_t 'u' register.  For
ID_AA64DFR0 we accidentally used 'u', meaning that the top 32 bits of
this 64-bit ID register would end up always zero.  Luckily at the
moment that's what they should be anyway, so this bug has no visible
effects.

Use the right-sized variable.

Fixes: 3bec78447a958d481991
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 95d0c8c101a..4c7105ea1a1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -708,9 +708,9 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
         cpu->isar.id_mmfr4 = u;
 
-        u = cpu->isar.id_aa64dfr0;
-        u = FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
-        cpu->isar.id_aa64dfr0 = u;
+        t = cpu->isar.id_aa64dfr0;
+        t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
+        cpu->isar.id_aa64dfr0 = t;
 
         u = cpu->isar.id_dfr0;
         u = FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
-- 
2.20.1


