Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850072082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RD6BpbR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850072082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fs6-0001ea-BQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh6-0004Zp-Vd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh4-00026B-TF
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:19 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fh4-000243-M0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:18 -0500
Received: by mail-wr1-x441.google.com with SMTP id n10so5044148wrm.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lZumiqpfQ/6unRtDCeBn/aqRrn/borXiuGtgBm5/gN4=;
 b=RD6BpbR95xY5cf3mlw/dpC4fXTm783NH1DIl3KLBQ/rFzstVt+DsogWxfp8jsPASCS
 kB+YnB/uR42eNsiJm1uj3/IeAZ5/d0rTAcPdjlG9/ASQEZg7RG2Ob6qxRiW6PGQ8FEqO
 FPtf0hhBKumvK0NoKycSNGVScQfZmQGni1Pl4SCoEyie2/JEl2PQUXv+ZDo3ik1bzsxX
 KrDt67tWHVRujiTvw4gus7qICOiATZ3GGvXbnueDKC9d7r4A9Ya3tWgJKHuyd1CysGvd
 8vD1g1RgWlfaAwcHXLSdyczkpqwwe0I4tTMwI3TRxBTS3mX6GOVO5eZcyc6bOFUs0e69
 PGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lZumiqpfQ/6unRtDCeBn/aqRrn/borXiuGtgBm5/gN4=;
 b=DvGGYZ2qVcFY0aWG4VGohZkq6b15qTEQO95syqbyxeBdcjLmN564bNf4ABzFhThcVV
 EM2+entrXFao3pTb8AEJJUOGbmFCtKTB7cwBUyWsRJzkCUkhGVRQxk3ZgPJEAXC1ufsH
 Ae1In+ptgTCABiHjUwyCg/naTCOAHo9EetHrCqBzFArPPIAnEu9/J0ITtLBJYwQGGaOS
 wKr5v/GATTADgOuD2ftz+2XKFeMV1J4ov2lMCimu5ixGNmK6WhJvX6FrYRZ9lZJmJaQb
 kLrIc71ZGNRFXOFerE4ODvw97gYWj0VK/+uD4XQrqclZ1rx3KWGDrD3CRwCY7Cb47eQb
 ljWw==
X-Gm-Message-State: APjAAAUGyetutK2KIs0MyhkdTeneFxGlcSImtva6zvMjF46/S4vbxXb7
 c0J7EUi1MYk4pPS9tmIK9RogYJYYpo4=
X-Google-Smtp-Source: APXvYqwHH1mGXTJNY8AH9z5BMKj6sTjRNBh4MSzc8RGgzg7cKCqsD/GV1uM5z8j+AlU12u6N9w1RWQ==
X-Received: by 2002:adf:f986:: with SMTP id f6mr23126883wrr.182.1581604936955; 
 Thu, 13 Feb 2020 06:42:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/46] target/arm: Enable ARMv8.2-ATS1E1 in -cpu max
Date: Thu, 13 Feb 2020 14:41:24 +0000
Message-Id: <20200213144145.818-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

This includes enablement of ARMv8.1-PAN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c   | 4 ++++
 target/arm/cpu64.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b0762a76c4b..de733aceeb8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2709,6 +2709,10 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
             cpu->isar.mvfr2 = t;
 
+            t = cpu->id_mmfr3;
+            t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
+            cpu->id_mmfr3 = t;
+
             t = cpu->id_mmfr4;
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
             cpu->id_mmfr4 = t;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c80fb5fd438..57fbc5eade7 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -673,6 +673,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
@@ -693,6 +694,10 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
+        u = cpu->id_mmfr3;
+        u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
+        cpu->id_mmfr3 = u;
+
         /*
          * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
          * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
-- 
2.20.1


