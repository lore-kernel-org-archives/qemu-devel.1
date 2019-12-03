Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF3BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5262064B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQqCE+sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5262064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHPQ-00074c-Rv
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3e-0002wn-TS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3Z-0006um-7C
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:11 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH3X-0006cn-6X
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:09 -0500
Received: by mail-pf1-x441.google.com with SMTP id x28so2571052pfo.6
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KQ4nnssDdUX84cYwpBX+qRuZqhWJTbkOPZT8YrFeOhs=;
 b=eQqCE+shHPKIcO9Tsszm6MGoIgkVazn2NdvmjidCvDhFFv8TMKl5srUULllLUwbs9D
 ZsE7wD18a6tMOt+SZPxGrNyHDWqcuT0KLg26eGWYd+FL5+RnVV396rmD1txesA4Gqq8U
 PWsyacEjJD05oj+VqZFbx8uygjCS0/TSrTz35T9NBuWExQiYemzKe185UokdsqoILDxi
 bgjltdW8Qw73KKdVTL6MkHDQVF/83NykJy5TwjPeP+6DbuVMexjORfGFyoEORY2qR5ge
 MyWmzZdscFwnIqvmNHokbdwvLxU6c1n7HnVe3glHaGWLypsFKmHNZVq/HehUU8KxvW14
 30xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KQ4nnssDdUX84cYwpBX+qRuZqhWJTbkOPZT8YrFeOhs=;
 b=XcnIpQgD6U5br/29QuPCsdDH1RJsDZ4+wWezWRBkkKZPpC1K28fL24Yyizxg/2mWef
 NBJ+RvxTKYxDX4h6P8BZtHiv2tQneCLrjFfcgo2k+FY3ffZpo09aw7dALOCrurNUTXVE
 Kc0ATDORaJr64f08mkmXgYrthFX0QUe7w0IQrXZxbB7HhqfegLEJpLSKSmBws6uNHUui
 U0NTOmIO5xkmiKslQD3EQA9RcStjKCe3+ZRgQhOZLynjDMcLmMGdEx3Dvf0q4CQGHUNm
 FjFr+yq7vikWCKemcLv2b2NKeZLeLCffrF3oe4vWpv0zLwHRfY1dDy/lwiYKNOIGaesy
 GfSw==
X-Gm-Message-State: APjAAAUQQ9GHFJtyHEbhyX5JOfLw39WwbVTMBp5tKXC3rSFUME7grors
 HEj2UJYM97vyM+EJDo7/8X2CbRCzWyY=
X-Google-Smtp-Source: APXvYqw2S+J4qUvWrWi2iqNjRCGoF8tWPoQg8HZ/UNWBWkEU6DRENLmBJs+BlsOPWIHlE3RKWQZtDA==
X-Received: by 2002:a62:fb0e:: with SMTP id x14mr308844pfm.194.1575413629919; 
 Tue, 03 Dec 2019 14:53:49 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] target/arm: Enable ARMv8.2-ATS1E1 in -cpu max
Date: Tue,  3 Dec 2019 14:53:33 -0800
Message-Id: <20191203225333.17055-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

This includes enablement of ARMv8.1-PAN.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 4 ++++
 target/arm/cpu64.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f3360dbb98..3b0c466137 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2640,6 +2640,10 @@ static void arm_max_initfn(Object *obj)
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
index 009411813f..9399253b4c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -671,6 +671,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
@@ -691,6 +692,10 @@ static void aarch64_max_initfn(Object *obj)
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
2.17.1


