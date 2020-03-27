Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794EC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27C2206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CT2ZEuo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27C2206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlgC-0001u6-Vg
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcg-0003VH-W6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcf-0003td-Vl
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHlcf-0003sL-Pj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id g62so11620034wme.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jNCqItbHzWYtJLgrz36pXVxvUTrH1kU9rm8Huuj6L8g=;
 b=CT2ZEuo6RoEOFsURF2XHIcP10MRlgxHe3GY3DaMvXth+dL1nI7B5O0AdnuFaAORhOB
 77QULAsvYHNMd3IJDbLiXBdBRS/wzC0c5BDcpv0hz1zi6/u904+WGvdXvJpj50njI4Yr
 mfuIqR4WyR7zbvlv+kbIaKVhVKtCjxOZdbsWShGX9DjFEuTqgA5gQ0k19m9Z31xAw0A7
 AqgWrPREKdy0bYkPK7ti4F+y4lAOYuwVeBLFoNF8VZUU6rT5CQLpkkzfON66g32nGfk/
 tbyPgUa4evBMbRz37K6OSu2ilcykE1VzFHC3XKREB+8bFkgS/rCfqGRHqxmhNWuq3hbl
 hq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jNCqItbHzWYtJLgrz36pXVxvUTrH1kU9rm8Huuj6L8g=;
 b=Yfu9jaP3souiCHQHwJr80eHlqV6gErjdrxdh2lO+AzJ3RlUXOO2ulXofDNqVnb6Gis
 865FIRNFYalwiNevT9FwXQCuBJqlJ+s3lpDVS74AnKR1H0YwuQ0yotmr4hTVkTaHqWVQ
 xz29uew+Vmrlb45lTC81Lj1msIceb0yH7JTadhDAtwaPjrpfp4gt5MpaB0YWlJBRj9go
 4bXhvIt4ANX2HdYWX4t7V6araAWzN1A016FnwxnA0wNpeE+KpBqhq+J/QOGLnD2d6zDc
 fkOSxRLGAkEMLC8vgAJTHZY2QB/+E8Rkegov0+Y4tfczgeHplFO/EYPlpO46M2CaAEyB
 v/9A==
X-Gm-Message-State: ANhLgQ0SfC8NBSw2+NutIvKGlz3p2CP8uEgu6I6WT93/9a+Foj6iPLPh
 x+0AWRlk5II3mhzQbZq1/rxJzQ==
X-Google-Smtp-Source: ADFU+vvNdptGq47nMPKAeN7VzRsBQKLQtWPs0X4zMPlwb/olrz2xi92ITDE4zPJv7QZFMt6RxsOqJQ==
X-Received: by 2002:a1c:9693:: with SMTP id y141mr4361799wmd.23.1585302592871; 
 Fri, 27 Mar 2020 02:49:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l12sm7561737wrt.73.2020.03.27.02.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:49:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D2D8D1FF91;
 Fri, 27 Mar 2020 09:49:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/7] fpu/softfloat: avoid undefined behaviour when
 normalising empty sigs
Date: Fri, 27 Mar 2020 09:49:43 +0000
Message-Id: <20200327094945.23768-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327094945.23768-1-alex.bennee@linaro.org>
References: <20200327094945.23768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The undefined behaviour checker pointed out that a shift of 64 would
lead to undefined behaviour.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 301ce3b537b..444d35920dd 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3834,9 +3834,14 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
 {
     int8_t shiftCount;
 
-    shiftCount = clz64(aSig);
-    *zSigPtr = aSig<<shiftCount;
-    *zExpPtr = 1 - shiftCount;
+    if (aSig) {
+        shiftCount = clz64(aSig);
+        *zSigPtr = aSig << shiftCount;
+        *zExpPtr = 1 - shiftCount;
+    } else {
+        *zSigPtr = 0;
+        *zExpPtr = 1 - 64;
+    }
 }
 
 /*----------------------------------------------------------------------------
-- 
2.20.1


