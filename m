Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB83C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB8420776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3KjoArD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB8420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhqr-0008LF-K3
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoi-0003Zz-RO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:32 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:40574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoh-00030S-0t
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:32 -0400
Received: by mail-pj1-x1029.google.com with SMTP id kx11so20027pjb.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G4aBqze3dMxYJ4S0H3/4ztu6UBprrxcKGaJBxwSWoZI=;
 b=I3KjoArDaN3KKaUhyem6JJl7pG2J3QaSVS4XAkvDmxudW1TjtVLlFZ445IxB/dLKjv
 aHkgtjtXLClIzESQ5AwiXcoBtzjH3rSQrSlGhRvR6/aQnq9GLR0IC98HwFEet/NctH94
 gLfMA56fKrh0B9b2gGnvI2A53ZgKpOHppIcAIBnGE5UektY0mPCBAVW6XrAVVBfFIfXx
 saloL5z3/66JpEE4XYtkv9xjjwd7zoMiihqe7Ai/ynhrIrLjxqK0YI5yicemGWc8SWGa
 ceCc9bZFtW2FEec9BNdbOqIlfrK7mbajqwxSmtiUm/wZHHv2ySIUGbjdXdHasSFmRaXJ
 /QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G4aBqze3dMxYJ4S0H3/4ztu6UBprrxcKGaJBxwSWoZI=;
 b=B31xlrrqz7v8LfhFSGzvAjQXSrBIfi49ERHEiMnqZegw5LOeG12uJg+xIJmsWhqNoY
 poaRTXrn6seV4COYN8BwyfoxWVu/INz6lOVK5Of6gVS8luELrTKuAGNejzQYj2MsHPW/
 tO6I4P3Yzt2KoTQ5VCx0i+GvNHbxX2BIzNKK/cBgZjRIagGXE7W0hnheUIwFXHvxJpd9
 rK3H6ak9iM+xbgtbA9Tcw+FqYYKavi9/EihSg1LTXWSVK7ArQeZgrQahjaYbEVLTuEMR
 qpSAz4pgsyYIa+8KMGF6FD/orwoXBPOj2uLaWdP6WNfkqrLT1n+mFrk8ntAQR+5CN/P5
 oC7g==
X-Gm-Message-State: AOAM531mfaH+AelyBhaUTgi1oWLxQET1/UTJG7PRD4McJ+1X0Sv/N4iK
 CnvuGb14mbQ6A41HPP2drycjFTXTbpnAGA==
X-Google-Smtp-Source: ABdhPJx8YHgFGbq7vU2AsduGaSbrItSojIllFiyEAtxF2M9Lgzb/zqj8VaUmr4aA2aULa9WrgkDKTA==
X-Received: by 2002:a17:90a:19d1:: with SMTP id 17mr59873pjj.93.1598634329101; 
 Fri, 28 Aug 2020 10:05:29 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/16] crypto: Remove redundant includes
Date: Fri, 28 Aug 2020 10:05:10 -0700
Message-Id: <20200828170523.418603-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both qemu/osdep.h and cipherpriv.h have already been
included by the parent cipher.c.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.c.inc | 2 --
 crypto/cipher-gcrypt.c.inc  | 2 --
 crypto/cipher-nettle.c.inc  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
index 6eafd39da0..56d45b0227 100644
--- a/crypto/cipher-builtin.c.inc
+++ b/crypto/cipher-builtin.c.inc
@@ -18,11 +18,9 @@
  *
  */
 
-#include "qemu/osdep.h"
 #include "crypto/aes.h"
 #include "crypto/desrfb.h"
 #include "crypto/xts.h"
-#include "cipherpriv.h"
 
 typedef struct QCryptoCipherBuiltinAESContext QCryptoCipherBuiltinAESContext;
 struct QCryptoCipherBuiltinAESContext {
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index 81e4745bff..a62839914b 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -18,11 +18,9 @@
  *
  */
 
-#include "qemu/osdep.h"
 #ifdef CONFIG_QEMU_PRIVATE_XTS
 #include "crypto/xts.h"
 #endif
-#include "cipherpriv.h"
 
 #include <gcrypt.h>
 
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 0677fdfd33..256931a823 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -18,11 +18,9 @@
  *
  */
 
-#include "qemu/osdep.h"
 #ifdef CONFIG_QEMU_PRIVATE_XTS
 #include "crypto/xts.h"
 #endif
-#include "cipherpriv.h"
 
 #include <nettle/nettle-types.h>
 #include <nettle/aes.h>
-- 
2.25.1


