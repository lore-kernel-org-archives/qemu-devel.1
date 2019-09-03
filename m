Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19EAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3631622CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXIPoG0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3631622CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BBm-0007R1-TG
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Ara-00036B-Ub
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArZ-00063k-Pt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:54268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArZ-00063K-K6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id q19so9924431wmc.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z9w7+yVYK+vUYEeI79kZLw/4Cla+l5PNTmy1ZJYBMMA=;
 b=JXIPoG0ztOAyyVCXOkH1k9TmrFV1fc1o9g9pid8S+bobWHyJ3C0up0zmxUsm+xmXck
 vbW0UuiHkst2tb1+mGcPRVxTNTbBjbQMCAuX+VMAwpYGifF7yEu5KC/9bHBTmDfQyNe6
 L2Q0Q+GYy0ShOewkM5GcQ2Ira14a2HnrA1esMCbp5ZHq5h+N3IUbgo5ovoWXRN783p6x
 IzlqvbxNxIDjpdrVYNArycbJIRFXT3ZuNoHGM319s/u3Qc4iRf3TTAe/TyJPYQeNK/vY
 bChAI2H2Hg3tZpC7+FSDuAr6bBQ9B5bcn1cwQr4jbW0NIcxd6G9i1gNt5jJjOJLoqHJR
 gUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z9w7+yVYK+vUYEeI79kZLw/4Cla+l5PNTmy1ZJYBMMA=;
 b=S5Cm1YBtlwpib6pJOGigqeQY8dVekcyV6e+A0IyD6iStL/3F7c21zks+rKArypoCx6
 VNZqceejhL8fTRZ3TeeWXxHMXr6Wpiyn7vA33NuCmd7rrjptoAY5sWzbY8zWKVMAPmm5
 ZdrPAqfrLOBKgqRjbIywvKq69cg4DbReCz9DyQICHUeDwqjt6e3eW1CSyJIgMHyzEk6Y
 iNG96pTWJ3TezOh3wkinytLKfEDaVR4YbiUs76cghjDtJDOBeAEpzdbPQEKVgeqfX3ZH
 hq7js+Ng+gTnZhN7wI70/YSDE1q42LDqHskewwN6ZtGf1mSUcLQKQOVl7B4hd1XCldiD
 oU2A==
X-Gm-Message-State: APjAAAU06LHNo32UJrTXEvz97Kc0hxOY4HRPT7iDz1T8WO3Z++3ita1e
 Za2ecNUhpuZAR1Jlx6NCE6HLqcv23DQMGg==
X-Google-Smtp-Source: APXvYqyExymr1LHgPMJ2y/Q4Del2oj0x5FSUanj9s6UsBBduzxaDKzAJ8pdL8A222a9QZnvPjnyOfA==
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr818258wme.22.1567525016566; 
 Tue, 03 Sep 2019 08:36:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:30 +0100
Message-Id: <20190903153633.6651-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 18/21] atomic_template: fix indentation in
 GEN_ATOMIC_HELPER
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

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190828165307.18321-8-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/atomic_template.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 5aaf1862539..df9c8388178 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -284,7 +284,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 
 #define GEN_ATOMIC_HELPER(X)                                        \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
-                 ABI_TYPE val EXTRA_ARGS)                           \
+                        ABI_TYPE val EXTRA_ARGS)                    \
 {                                                                   \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
-- 
2.20.1


