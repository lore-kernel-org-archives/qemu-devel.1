Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F18CC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0872168B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yjlgCfy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0872168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hQP-0007Qx-5X
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNi-0005Kt-Bo
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNh-0004xX-9k
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNh-0004x4-3S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id d17so8066013wrq.13
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+93zhnxV6y7awAg0ASSqV7pmnPcURr2F+yzvl9fZsA4=;
 b=yjlgCfy9He+gTLDKlS4tw4uJ09J7Z4UDlHWsRjtbB+txmHoBkLZCVFMrmmsmTuh2NW
 rlmUYDsPDLwT6abct4DmFK3w9vnVVOmqK7dNdwZzduuRc7ceYZpHMpN6mYv2VPje1hX8
 LUv8zHDO6H0C7IbQZ7lKKSWPisdiX9jbI1gx7JtgLDtDYbepW6gzfg8yifKqH7TlyaQn
 IDFNKgXt9L4uYdzZT3sBGEgSaoH91SkjAjOkSdzm7hUUnSw3fAQcW3V+xj4SBCvTBeaD
 uwFB2vzUsONxWrPeppaFOLM9bnBAhkckPPCYVh2W1XHxvqGJkv4It126hXq3BPWXRltt
 rSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+93zhnxV6y7awAg0ASSqV7pmnPcURr2F+yzvl9fZsA4=;
 b=Um12oqQjEQuMMkNDLp34unzia1b5GtXgntf6MpBuG5KGHTvuiT4zH8IUs+Hj9McvXB
 Np/c4g+G6yJse547yl+JPL716KkJhixtzHDsUE9FOBGdf7UmG5FOxvYWxF4Be0HxtC3O
 UbwkYm8rWlxLfYDK8687zTTeoP/0/GuibqoDmUjC/wBrmD0Lu7hjF4mJRZFS0w4OQq5R
 4AcBKeuf2lO2mpcBTikKn8X0MyF1lx/9wGWwMBWDDUGNc+ngsaTvuJVgvbJjLYZTndX9
 Vabg8Yfjr/kKLoE+U9PisRt+spEnZBLdTRwbJZNSop9OW3Adi7IRGQSOwNaXnXJM1xFx
 MwtQ==
X-Gm-Message-State: APjAAAWPlmpa5ztykVlOH5hCK13fr8daJ9fo3DygD8V1UJNSA60TrI0y
 nb/CBBoPOKIGheqZDaSHbv/oJQ==
X-Google-Smtp-Source: APXvYqwDfJZDye6s/cJJl7O5fXxwtEpFQGB8eA317h5hQBd/3WFc+te2o/WxQ0Vm18OMGxwwdbe2sg==
X-Received: by 2002:adf:f110:: with SMTP id r16mr4111003wro.152.1568126672093; 
 Tue, 10 Sep 2019 07:44:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:16 +0100
Message-Id: <20190910144428.32597-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 01/13] target/arm/arm-semi: Capture errno in
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


