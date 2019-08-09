Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A510CC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751892171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgHYLKRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751892171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw15b-0001yy-Pj
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13r-0005xe-1Z
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13q-0007cm-2X
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw13p-0007aY-Sq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id r3so3826497wrt.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xDB7zhPlulJY0AZfd2YO/hnOBkqPwNAEQbIkpxXlrNI=;
 b=PgHYLKRd3nAf1LBHchr63z30M9y4JzRXgcaggAR1vJ+ykYgUNY6kl95pvYeT0xYZvu
 qqwmbzsyU62rfy5SNDgrthNKYZSb549XcEQ8OW7IVhjKEPYjnYQ34JV+9m8RhEcEAbOp
 qe2VDi+MLKePWJUYHJd0gzTo/ovSE2hZQNup0ZZ/3xZ9y3C/xPaD306EX/3lA0iuTENs
 +dk2juSyx2JEvA8OUBpkRo+dgqeZOsXLD9oU3S3zYdz8M2yCqMn+oqPF/2nms/NMNvXa
 URnCSBBYK35JXFm1aKN+MyYCXcQXYU3Q/aIBI/C9vZHiGz5RvjkzTN21W1o4R7EeVvl0
 AkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xDB7zhPlulJY0AZfd2YO/hnOBkqPwNAEQbIkpxXlrNI=;
 b=ejSgwWCFMwv0YtWVI9gq9EGmZR2FG9oz6mLACDstJwZczOZmc7xWs7LFb4sAPwgTes
 9ZFGygs8Ay06z1KdPQX4kvUJCCg9EEb69nGwsWLTOqYuCUEZtq44InNR+Ig9ev/1JV9C
 dLPqeTBinkdKGwtmgxM1iS2Q1EsdpUGMDOTZ2bmpTncuOYmYNFwJOCdEusWfJSO7vJq7
 fxoPIOk6Oh9zNxZXq5WZjsgJkxS7Z5k4+H8THxWxbXgd16eMmRXEgE/5fDilwx8KhJf3
 7FR2lP8avubMP1iCghBrjqIDYARgu28DkWpgIngzyEjwe6IlVsiNzUuI24CQ8G+jnN2E
 KHWw==
X-Gm-Message-State: APjAAAXzzSgY1/0lbQKc/7c81LFBsaEBfnYoIQiXxULhlcSIzGgYMIEY
 WLhqwkeUkGrhW4pfIyI1xoirkw==
X-Google-Smtp-Source: APXvYqwcZCq5atKMtmSg8VgHiLr803Gu11CfRsdc9RHFn19NEGrgzTU2S9DRyocND4G+WpH5LEFs0g==
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr2599543wrt.57.1565342384773; 
 Fri, 09 Aug 2019 02:19:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o4sm3846959wmh.35.2019.08.09.02.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:19:42 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3F8271FF91;
 Fri,  9 Aug 2019 10:19:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 10:19:37 +0100
Message-Id: <20190809091940.1223-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809091940.1223-1-alex.bennee@linaro.org>
References: <20190809091940.1223-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 4/7] fpu: rename softfloat-specialize.h ->
 .inc.c
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is not a normal header and should only be included in the main
softfloat.c file to bring in the various target specific
specialisations. Indeed as it contains non-inlined C functions it is
not even a legal header. Rename it to match our included C convention.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/{softfloat-specialize.h => softfloat-specialize.inc.c} | 0
 fpu/softfloat.c                                            | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename fpu/{softfloat-specialize.h => softfloat-specialize.inc.c} (100%)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.inc.c
similarity index 100%
rename from fpu/softfloat-specialize.h
rename to fpu/softfloat-specialize.inc.c
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2ba36ec3703..80a16458304 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -652,7 +652,7 @@ static inline float64 float64_pack_raw(FloatParts p)
 | are propagated from function inputs to output.  These details are target-
 | specific.
 *----------------------------------------------------------------------------*/
-#include "softfloat-specialize.h"
+#include "softfloat-specialize.inc.c"
 
 /* Canonicalize EXP and FRAC, setting CLS.  */
 static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
-- 
2.20.1


