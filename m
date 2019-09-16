Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699C6C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FF220830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/3gfIPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FF220830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ruV-0002Yb-5K
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnC-0004J0-SK
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnB-0006s5-Ap
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnB-0006rf-3R
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id r195so10615284wme.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+93zhnxV6y7awAg0ASSqV7pmnPcURr2F+yzvl9fZsA4=;
 b=i/3gfIPtv+A1F40fA1vF7JhDCKPvqU19HuYbWuNBIq3rsJkVqGKmG4pBVer/iaH57j
 jHccakeMDBkHC23mM6t3xT2eEPloplRUXzLFCAPsoA1HEaydbmROJ1VCBQ3byxpEFkk9
 7t8I1asM58+Bmb3gKSH5bG0xY2NCmowbCIqCdetFDbStt+8a69mLik+lD6vAd65axGoV
 8WExTs3XNS3KnyZSUNUzxzts3O32SN/rXk7GkyAnW6VbT3vFWoYWI14/q+1VLIvNMV2/
 9DvFxU34JTRnYpcvR0OrsGE1E7z9tLIX0gjOztThsH06y8bzGA1OR1wOUiIkpnsT6wud
 +fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+93zhnxV6y7awAg0ASSqV7pmnPcURr2F+yzvl9fZsA4=;
 b=AGDy2iOTUWRc593iy2PG0eKGhpT7EKaGzyiJpx3pUfBRyhEAyS28XOOtdq+C5swR3F
 K/QX6ul63r9VNzjLlurUai/meQ5A2hPs61rHfu2aLuNKWI604uzIif08gJ1NCbsdeYvR
 Wicx71L9QsHcNDvMcjAWRky/QVCrlAvgcJcKN/yRv2ri+cSW+w0ZemjBq5y9l8jN8eiQ
 ThU6nLLkp647t66D6i6uKnxsCnlaWX0YbJu1tuGf6+BCltdM13sN8EQc2p9MtPRugiqP
 YVwDVZegRUlxVpjIqo2loDTX4+42BdUYgSYy9USh2m4lKf3mD7TAmJ6xqCUiA7ViYL5n
 4xfw==
X-Gm-Message-State: APjAAAUYwsuU3doANn0qcPsFGkCwtkA4I0pW5a/lISH+HNZLmwJpfEXk
 JdFIUo0XweY2MRbw8o1N2w2Bgw==
X-Google-Smtp-Source: APXvYqz6WZG8Uy1Q5GZEl16gZ7AQ138w+KdgGuAFTrtt92KeTjrl70jDCH01ooeHtXppfk2KCQUmWA==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr15179087wmd.14.1568643348049; 
 Mon, 16 Sep 2019 07:15:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:30 +0100
Message-Id: <20190916141544.17540-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 01/15] target/arm/arm-semi: Capture errno in
 softmmu version of set_swi_errno()
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The set_swi_errno() function is called to capture the errno
from a host system call, so that we can return -1 from the
semihosting function and later allow the guest to get a more
specific error code with the SYS_ERRNO function. It comes in
two versions, one for user-only and one for softmmu. We forgot
to capture the errno in the softmmu version; fix the error.

(Semihosting calls directed to gdb are unaffected because
they go through a different code path that captures the
error return from the gdbstub call in arm_semi_cb() or
arm_semi_flen_cb().)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB that a later commit will put in some cleanup of TaskState
that will let us reduce the duplication between the two
implementations of this function.
---
 target/arm/arm-semi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 90423a35deb..03e60105c05 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -114,8 +114,13 @@ static inline uint32_t set_swi_errno(TaskState *ts, uint32_t code)
     return code;
 }
 #else
+static target_ulong syscall_err;
+
 static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
 {
+    if (code == (uint32_t)-1) {
+        syscall_err = errno;
+    }
     return code;
 }
 
@@ -124,10 +129,6 @@ static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
 
 static target_ulong arm_semi_syscall_len;
 
-#if !defined(CONFIG_USER_ONLY)
-static target_ulong syscall_err;
-#endif
-
 static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.20.1


