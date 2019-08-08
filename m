Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0592C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBA0217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A25eAQcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBA0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvlUx-0006AW-NN
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 12:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTe-0004Sn-Ba
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTd-0007SO-1t
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvlTc-0007RQ-SQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id r1so95538927wrl.7
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hDv32oe4BfXiw2BHcRVZz1ojHlvhasaJvI/EtnY/8lY=;
 b=A25eAQcwD93kvb2oHHXf0hTq1oWW0jP1Ts28fDn+SwSx54U0fr9H58IoQm/mSz0uON
 eqA2Aq59bqLEvg4Ixu/ukqSeFDbb7dWfOm8TGHy+BvS3/TQgdQoT/G07S5YsH4Szsaim
 5OL55EkUCspbfQyagEUI/mmM9SA5qYm1Hs8+FlqpZNV+ScLPmDSae2pc0IND2SxUFIQI
 v3/9KXjOhCTtdiWSjAaFYqgxJzF/tkpn2p+Q6+ut1DOLoCMCcPxEwExWEk7GJqBEaEeS
 9kD+ErwWvTJfU3JGVcbflR3Tp5WJ37R0eIklTccNasDYDEU2t1jPF0XtA6YS/1tR9Dit
 dqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hDv32oe4BfXiw2BHcRVZz1ojHlvhasaJvI/EtnY/8lY=;
 b=UbGSCcbKUEqKDN/2NlUTk/IQejpG2rKXA9gTQLXePBQr+bizRezroEAUE3xGdCdSxx
 lK3jUGczXu2rcJ0hZrSRGiQ1yyGhvQmabmf5vWX7kJeQFX+x9ZFrarMjUA28qmERR+Ed
 Of7acr4gAUzQiNvG4VC4jQCqZglG77vg5ceJ9GTyV5LQvrNFZI7vk6Lyl5BHRBe8Xv9w
 tQOTPYtPLynuQPEUSLWRfwV3BXgHocNb8svl0qBd/KbZQQGcn27h3LctniW0jGEpoOpn
 A32KcxLbPeJgSsC9c+WQu7JwtlE3cdYrUOXKhiO7IFwi5oXQZtT24j1dKROqOh8z/goJ
 uEQg==
X-Gm-Message-State: APjAAAXFsYBIiq7AwI1a5U2K2Tz7988ODrm4tw3IGHg+B507QiiDI5q+
 bcTn3v8cMWYtHlicrSzMB7TeEw==
X-Google-Smtp-Source: APXvYqyMa8Z5kosYpaSVA4ES1ZE8YS7c/OKzdbPlBltz0QP/n4rsV1Hble/27wiIwWtheRDf+MS5Ug==
X-Received: by 2002:adf:f591:: with SMTP id f17mr18650558wro.119.1565282479691; 
 Thu, 08 Aug 2019 09:41:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a6sm2729198wmj.15.2019.08.08.09.41.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 09:41:19 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 406841FF8C;
 Thu,  8 Aug 2019 17:41:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 17:41:11 +0100
Message-Id: <20190808164117.23348-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808164117.23348-1-alex.bennee@linaro.org>
References: <20190808164117.23348-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 1/7] fpu: move LIT64 helper to
 softfloat-types
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This simple pasting helper can be used by those who don't need the
entire softfloat api. Move it to the smaller types header.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat-types.h | 2 ++
 include/fpu/softfloat.h       | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 2aae6a89b19..7e88152dfc4 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -80,6 +80,8 @@ this code that are retained.
 #ifndef SOFTFLOAT_TYPES_H
 #define SOFTFLOAT_TYPES_H
 
+#define LIT64( a ) a##LL
+
 /* This 'flag' type must be able to hold at least 0 and 1. It should
  * probably be replaced with 'bool' but the uses would need to be audited
  * to check that they weren't accidentally relying on it being a larger type.
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3ff3fa52245..d9333eb65b8 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -82,8 +82,6 @@ this code that are retained.
 #ifndef SOFTFLOAT_H
 #define SOFTFLOAT_H
 
-#define LIT64( a ) a##LL
-
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE floating-point ordering relations
 *----------------------------------------------------------------------------*/
-- 
2.20.1


