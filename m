Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B99C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969A220872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcPNAYMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969A220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDt7A-0005Km-17
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSd-0002Ua-A5
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSb-00089R-EN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrSZ-00087M-Sj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id v8so3153654wrt.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=K5D482SdubcI8oAEapAROne6mJkYVKrkCojoFwsjKIQ=;
 b=GcPNAYMIcc68un/BPgssz275ihFb1S4y3xo6CG+/9b6QwnPnKHG3PnR67AO/cOYw5Z
 jj+IGKcZwkeFPQzY7mCQS+zZowezahb7u9dwFcpAuSAOsrH9zt0xeqMUMsDzF6KcevdN
 VMfnbm7L16srkp+p1sQLXf6fLa8zvInMqe1m/veA+5Ih/4qoINtCNimYDE/BGN1hhJW4
 uv7ClzSEdgClegQMf3u2AgNTymwrrKqHmr0huJpxUcGJ+qpbk0YpOoa/+Yj+okDxLgC9
 ACM6XTH4tRoHDJZKwEinAN6c1cOaXQyyXKuu14VitgH+1c0NTg6aDrNzAfMnJnQVH8l4
 fGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K5D482SdubcI8oAEapAROne6mJkYVKrkCojoFwsjKIQ=;
 b=oEy2oI8vbFrq6lCLAvHsztU+t4vi02ePZWxIBemhB+YEUbywpsJH0rcxNxE8pfBb8I
 jVkgfb0cB+OU81CMcxjGo9lITrejb46uU97xVwEq1JQkHT3BxejJXhqjapi1t910wGv/
 fCYkfQqZNircmaG6HBiLNgWb/i60GGHwuDkyBln3Ba/a3NGbwnL8ELZVpoAc/fBjoNkM
 bYCi0jVyMYsKu2tE4pOtrzEkPwECvayKTUk8B95juFDHCKsqtcY7pyrs2fhokuGrG/D6
 iMZIf2L8IVvoBQ46+kdcq2+qRYgEf5C/dz7PoGmuI1kYarLzH3/ua7RVgNpAlWFQo+Yj
 4Ggw==
X-Gm-Message-State: APjAAAUK/9Uv6zDtcaYCqCGhTiLHgxsDXe2k6pGFDn4lOZptFkJYea2n
 DtKBGAO+vMwrrjXa+gj3NVBl5YKvOWlwEg==
X-Google-Smtp-Source: APXvYqx4MTSQoFQz1dWiSZTkjxA0Xwg9M/MjcY6X6T6v5GGdmHpCmdW0TPpZi5FAqSOnYIt/Vh+a2A==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr7586741wmi.133.1569595377601; 
 Fri, 27 Sep 2019 07:42:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y12sm2874539wrn.74.2019.09.27.07.42.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 07:42:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] target/arm: remove run-time semihosting checks for
 linux-user
Date: Fri, 27 Sep 2019 15:42:46 +0100
Message-Id: <20190927144249.29999-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927144249.29999-1-peter.maydell@linaro.org>
References: <20190927144249.29999-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

From: Alex Bennée <alex.bennee@linaro.org>

Now we do all our checking at translate time we can make cpu_loop a
little bit simpler. We also introduce a simple linux-user semihosting
test case to defend the functionality. The out-of-tree softmmu based
semihosting tests are still more comprehensive.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190913151845.12582-6-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/target_syscall.h | 3 ---
 linux-user/arm/cpu_loop.c       | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index afc0772e194..f85cbdaf56f 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -18,9 +18,6 @@ struct target_pt_regs {
 #define ARM_NR_set_tls	  (ARM_NR_BASE + 5)
 #define ARM_NR_get_tls    (ARM_NR_BASE + 6)
 
-#define ARM_NR_semihosting	  0x123456
-#define ARM_NR_thumb_semihosting  0xAB
-
 #if defined(TARGET_WORDS_BIGENDIAN)
 #define UNAME_MACHINE "armv5teb"
 #else
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 8d65de5b9f4..e28c45cd4ab 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -325,9 +325,6 @@ void cpu_loop(CPUARMState *env)
 
                 if (n == ARM_NR_cacheflush) {
                     /* nop */
-                } else if (n == ARM_NR_semihosting
-                           || n == ARM_NR_thumb_semihosting) {
-                    env->regs[0] = do_arm_semihosting (env);
                 } else if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
                     /* linux syscall */
                     if (env->thumb || n == 0) {
-- 
2.20.1


