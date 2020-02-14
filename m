Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C1C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639D820848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKoc/y89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639D820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fLH-0005Xd-Ks
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7z-0006Bg-Om
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7x-00018n-KP
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:46 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7x-00016E-Dt
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id a6so11579423wme.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I7VGzJKa0emO5iag6GpwHNYHbTYM9xvXNaLqgVHooL4=;
 b=mKoc/y89McFeR3+YyDh2nlQqYLnNRHzAyph+9ZMPYXnpyCs23OVW2JrjyDK/6bqERB
 FD9eXNOnHA9s7hz0LWQKGo+eWKMgJqT3f5gzjWNwJtcBF612R69bfky9l9M+IMgUDzbS
 cKBJR1woYwsVVNLsDL6gxs8usCzeo2ajQzjGuU0OuBV2a1sqjO8YJhsFJVojkA1/vUKd
 LMwNvTUNz2MJbdrffZQVBVHwV9kvMSn0eJM4y9oLCMkSpT9TOkXSrJ8FQ4FHkFxZzB9J
 u/eiVSmK8pOLwGaIjffPIQ/F0t8HPfwK94n50GJDJ2HNcLysTEnsJIiyp/mZXOGpwYB9
 aoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I7VGzJKa0emO5iag6GpwHNYHbTYM9xvXNaLqgVHooL4=;
 b=Wejjd00TiOpW94H/EVZMSpcV8OnsZdGoQiNRDc4XOlE7ofq6Nn3weLGDHyuO6FPCjQ
 BXHbzxj8MycIxLDU5TKFHRDwIJDHblSdUsO9whroXh3m29y1/j+VtJaUBH1yAqKTjAl+
 B17NTWfUvOycS+OGOlsX/QZWN8RNQTgncsQzCeKsnOS+8dM1h5z9FZbfL0rYso5+e3PL
 KrQ2cncEGESz+bxf+XZtTX9PU8boTGO0pnaA8jWnka93ozXeXpZVdChu7tWVHYZJ2eAl
 yu5slaG5Tpki+TUgp3rBMllSk7XB5cnsrfKXBxbJt8rkgGNeLMuibdr8NmFmb3KSmYjL
 IHwA==
X-Gm-Message-State: APjAAAUq+JNT8Y5Pl10PoiKsit28AM6S7Zliis6YOrfH/OTx5Og9t+vw
 Q/P5iHiP1wGzzmu7+m+AJDSP4w==
X-Google-Smtp-Source: APXvYqwRJD9PQmGiAa66bf7koHyx8+0nw8fZzOIRho0EOnbMYHPsVmNwOqtKsVMZTSPkC61jEjFhig==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr6110868wmf.56.1581702704511; 
 Fri, 14 Feb 2020 09:51:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 19/21] target/arm: Use isar_feature function for testing
 AA32HPD feature
Date: Fri, 14 Feb 2020 17:51:14 +0000
Message-Id: <20200214175116.9164-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have moved ID_MMFR4 into the ARMISARegisters struct, we
can define and use an isar_feature for the presence of the
ARMv8.2-AA32HPD feature, rather than open-coding the test.

While we're here, correct a comment typo which missed an 'A'
from the feature name.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 5 +++++
 target/arm/helper.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ba97fc75c1d..276030a5cf3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3526,6 +3526,11 @@ static inline bool isar_feature_aa32_pmu_8_4(const ARMISARegisters *id)
         FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
 }
 
+static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, HPDS) != 0;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 492741a2b0b..56b1c08f027 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7408,8 +7408,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     } else {
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
-        /* TTCBR2 is introduced with ARMv8.2-A32HPD.  */
-        if (FIELD_EX32(cpu->isar.id_mmfr4, ID_MMFR4, HPDS) != 0) {
+        /* TTCBR2 is introduced with ARMv8.2-AA32HPD.  */
+        if (cpu_isar_feature(aa32_hpd, cpu)) {
             define_one_arm_cp_reg(cpu, &ttbcr2_reginfo);
         }
     }
-- 
2.20.1


