Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB9AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF8C24697
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1j5jm4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF8C24697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ipQ-0001nU-UB
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifW-0008Ep-5R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifV-00026D-5R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:18 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifU-00025d-VL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:17 -0500
Received: by mail-wr1-x42e.google.com with SMTP id x7so3711614wrr.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hNvRKTnbKU1Ze0BRTs7wvEYB7FrEi57d2LPXeti1ezI=;
 b=l1j5jm4B4rdnikvoqsu8rgIZkESfAb7vg30sd777MvPd+qWdq3qRun3ZH6RJQX0EEH
 gd+jRGMNzbzvRVpRSpv8rHCJL76pA7nz6V7laEBIkyGNvBPoFglBCNOZjYvZNghuW/G8
 Xx106gkDWsO67sI1W+6m3biDOeH0oHwKs1H0tgn/kuewqoCiZQryP75sezvVpxHMIfHx
 ARm2ZCSiYb7qmXculNt1t5+s26RFENZ6Y9jDXdrtk3ch6hJrlgnNp4+Uwp1I22qLJiFH
 C58EFGuSVwuYHMKyg49puqzu7rt+wbjzXLGcMIhE1whzaiknOr12MP57V7qWGb6Rk/Hr
 U2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hNvRKTnbKU1Ze0BRTs7wvEYB7FrEi57d2LPXeti1ezI=;
 b=E7pdIMf1m01DI7bx4wn8cyi7wNgUlsbR+cMUidIGX+IE+auK3PM0J9Lk8ka32ogvdu
 uPAKUcR1OQfpkFWJzTgDSlMw1pJxKjjL5Ur3sKlIt5dCo0C54pM4A5lhlDZDUGBBd6er
 dNJXhKGSAtK0C5K+0kkaDmQoSrMTJNZskGJVVwi2BeYqzZALVZL+PJzjr3BWr0UCHu49
 bDw1Mp0svjlUc1lz2hMUa2heVDtWnfK0w6plh0hUUICLPrdCQfcAhDapCHS+hxT/MKBc
 bQNUHsCICNTZGII8F7pVofeWSFqY+G5xdyr5H5PluN1jH0BuJkUMhynj+NFr7DT9Prhe
 KhPQ==
X-Gm-Message-State: APjAAAVpPfcq14PI7XM9O7vWb59vKMUciP6+QisZ2dDVwkBOWcfsPLdT
 TJSh+zKuznZfn8O8LEM1m5/dcvgwuekM0g==
X-Google-Smtp-Source: APXvYqxfQDxZ0gWENdOjOrb2n3Xf9SXGemyJNJRbrxAo+7rn4aeYkeNTpKKD2TU1ZFqXgKMzK56UYw==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr5708897wru.338.1582907955755; 
 Fri, 28 Feb 2020 08:39:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/33] target/arm: Fix wrong use of FIELD_EX32 on ID_AA64DFR0
Date: Fri, 28 Feb 2020 16:38:36 +0000
Message-Id: <20200228163840.23585-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

We missed an instance of using FIELD_EX32 on a 64-bit ID
register, in isar_feature_aa64_pmu_8_4(). Fix it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224172846.13053-2-peter.maydell@linaro.org
---
 target/arm/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 05aa9711cd8..6013287f623 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3770,8 +3770,8 @@ static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
 
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


