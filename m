Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AADC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8A120732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsiggA9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8A120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HYG-0008O5-3T
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6HXH-00075X-Mv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6HXG-0001T5-RD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:51 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6HXG-0001S7-L0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:50 -0500
Received: by mail-wr1-x436.google.com with SMTP id g4so5020754wro.13
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 09:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xt89LcM9ze1qIRUu4N9M7G6GazhAHzUjaeGNd8hA1Qw=;
 b=CsiggA9y1aMksChk9cGaaPM3PIN6a+nQmBT0VBtbes4aKoRlUdrVO48kbysSyhlY1D
 QEhA6nf0tJmmr0E+fENB2YPSYx9R3gNeupdlIqh6FSRY2Hc/TGuktSoQuZmdEXc63PJa
 vbpaaPqy390mRPs7rutiU/tRVRmX7NsftJaZon2vUR+cbzyQ5W9eebFILM0nF1ZrLPlq
 TR2T7X+XnyDiCCanMApIrhau7GAMS8ou5MhH1dF8iSLtosUhCsmtf43CK58sxUs62/fR
 uXVrVdOsg7UbZeIO6QEEwI0sL1dkQtLC/lz3RR8YcF2LZreMrFNdEOYcSUM6BGsTG27X
 +1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xt89LcM9ze1qIRUu4N9M7G6GazhAHzUjaeGNd8hA1Qw=;
 b=IdPAqP8SkN/yzj4hcDIsO6+K1zAPcFbusrDWeSbUofWa90lxFzkI8+vk4CriSGgqte
 NJqSi2tsYCBBjN5rLAC91JQhFSAxZc+VPeDysPda0co61SgGdmwmEf7mIY6JDbot+eDB
 ZliU7nl9w5xc2wg2YDqLYNVQesCwKBAE146ZhcQ4nh/F3KCOqhibrNo5PoiQiy0dODzn
 J44bDCes9RdlVlBmkzMBI4wmEnk48NWXpIXZG9pgtA65xTojGMJY/GE2/3dgmr1OfIee
 qMXH5BsMZdHywBqbqzlTR+KsOvVwo8EPllKlhIsld7UzmD3VK7IjkxHSf02ghSjvMNVS
 Wf7Q==
X-Gm-Message-State: APjAAAXsKs5hELoQHyiFq7X65yLyQ5T5bP9T048wKX3XyrhJPRoTVNpM
 wBbBv2zT7+MW7ngHHVZORYVCkA==
X-Google-Smtp-Source: APXvYqyIdItPwoz5nhQt3qI4qaJp3/NEC6S4Y8nIFq6+XvibBELOynudPQCRMkwZSRugB8nnJoPNUQ==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr66106225wro.209.1582565329629; 
 Mon, 24 Feb 2020 09:28:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b10sm60652wmj.48.2020.02.24.09.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 09:28:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/arm: Fix wrong use of FIELD_EX32 on ID_AA64DFR0
Date: Mon, 24 Feb 2020 17:28:44 +0000
Message-Id: <20200224172846.13053-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224172846.13053-1-peter.maydell@linaro.org>
References: <20200224172846.13053-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

We missed an instance of using FIELD_EX32 on a 64-bit ID
register, in isar_feature_aa64_pmu_8_4(). Fix it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65171cb30ee..b647d8df916 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3723,8 +3723,8 @@ static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_pmu_8_4(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 5 &&
-        FIELD_EX32(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 5 &&
+        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 /*
-- 
2.20.1


