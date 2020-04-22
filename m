Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A1C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5044520787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6Fmz4ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5044520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRElN-0008KU-EP
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jREkV-0007cy-8Y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jREkU-0005gS-JS
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:45:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jREkU-0005bH-5o
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:45:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so2164422wmc.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NIX7XE0lwqNmMlxtXwGrInjqZgxxjkJPUEwnhNSZU7s=;
 b=j6Fmz4ESXGI83sTR4431nXjOSLgQDf8QT66FgGnF61tvBBu18xOG6rPvjfkHVPkowo
 1dxOLgZDMNGbO551vwiR2Cwl2rh8MrzqnP5OkRy4YjIOG+wDAg3rd/YM6l1LEO8iD9kq
 kB3nplfIFEz1LX3DjapfLSB0DethJwpk0qVAuu7Tcth8ieSq93G2cJN8UeNC0isOOXi8
 SBmxwmav2AvzhgskhtBjFcPVUDUqSbXSoGyGwkyeDv+u+RmC5FTFVvbzPoP/112dTi23
 +P8hzG9Act582kB4WHBllT19LQJpDj6Uc3xkAvNwmcf/jAuvDXwcQJAyQKEJY1Mmbt2F
 RJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NIX7XE0lwqNmMlxtXwGrInjqZgxxjkJPUEwnhNSZU7s=;
 b=mki4ScSjlpzTdMgzamVK/gfku81MWE6gekiBVZFk+j4jF6prQQGqPR9pYAAwNqM5xV
 1LEoVkcgcV0cPqLv7t36HwW+mmkT3OMVyJE6hYnH/rRJ95fDdvq4PjcxqsqACI61fAft
 cLlqXLhd8Ewj+DtrmKWYhR31GezeQ8SDiPH3beA5hjteNATVgzzdfcgTTiPLEgsFF9XC
 rjKveJ0FFM0ghlgPVb/FUORi4/KXcNlZe6D/dUb8UoEmFW1yJQPDEUMUmNJ8GoOuJUid
 rHZJ4PHhQ8YcL7lXu+cqDJATiPzXoXxisQLIikiv4tiiLIPn+wmkxU5Z0IPGpPy8Z9Gp
 iniQ==
X-Gm-Message-State: AGi0PuZuZx7ALEK9hwHxa8axOdTz/4cJ83CoIROWqXZcL6VfxR0AfNZg
 5gA6y5yahbECCzijF5sKdKrmkw==
X-Google-Smtp-Source: APiQypLAxELcvP2Ph8vbCinX57dFNAA3YsNn0kD9tkkI+Vq/6f5tc72NVuB+7sXlNQq9XVym9LfBng==
X-Received: by 2002:a05:600c:28e:: with SMTP id
 14mr10938313wmk.79.1587559503865; 
 Wed, 22 Apr 2020 05:45:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z16sm8481824wrl.0.2020.04.22.05.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 05:45:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.0?] target/arm: Fix ID_MMFR4 value on AArch64 'max' CPU
Date: Wed, 22 Apr 2020 13:45:01 +0100
Message-Id: <20200422124501.28015-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 41a4bf1feab098da4cd the added code to set the CNP
field in ID_MMFR4 for the AArch64 'max' CPU had a typo
where it used the wrong variable name, resulting in ID_MMFR4
fields AC2, XNX and LSM being wrong. Fix the typo.

Fixes: 41a4bf1feab098da4cd
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
maybe 5.0 just because it's so trivial. I dunno...

There's also an error where we use the uint32_t u variable
to update the 64-bit ID_AA64DFR0 register, but that's harmless
because as it happens the top 32 bits of that register are
all zeroes anyway, so we can just fix that in 5.1.

 target/arm/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 62d36f9e8d3..95d0c8c101a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -705,7 +705,7 @@ static void aarch64_max_initfn(Object *obj)
         u = cpu->isar.id_mmfr4;
         u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
         u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
-        u = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
+        u = FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
         cpu->isar.id_mmfr4 = u;
 
         u = cpu->isar.id_aa64dfr0;
-- 
2.20.1


