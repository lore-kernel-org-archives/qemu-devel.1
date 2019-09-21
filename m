Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A3C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCC920C01
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMJ54MLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCC920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBXBd-0000xc-LI
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5J-0003QK-BL
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5F-0006Yp-U8
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:25 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBX5F-0006RU-3f
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:21 -0400
Received: by mail-pl1-x642.google.com with SMTP id q24so4117830plr.13
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 21:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=j5P0Q5UZ/JVwqVpHHBVM78hUGXGLlaTuJMYDTaeD+qA=;
 b=BMJ54MLxkX1dTZRUonVXJWKeestfVpBv5/kMqOEKO6alJkvUfBi4rLy5dJwdB2eIzh
 r3xZYISy2d0PwZHooSga2tEUh4uzjOGA76zjqF9EsJS18zp0vnwU1sRyCN/b9OX2sZ9P
 ifTUjfuTTNjoHexZxcQ0r5L72DfW2tJpzUA18mM2VmE61zohNFrDA3hQNmwkRbfSNt8Y
 wn0KKuwU/cVgpYYqL2gRXMCgRQ3DtaCnHq0z7CQu7fhvUCj45OyJVklVNd9+ncBqia9L
 tnFY/QWDFCtbWwgEABHh6ovSf3wSQ1ON+G80cp6iqvt4Vxsaj9jSQN7qCIsU5R4uz63J
 8Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=j5P0Q5UZ/JVwqVpHHBVM78hUGXGLlaTuJMYDTaeD+qA=;
 b=Mvxk5NQdMiC02kXC5a7peBdp8ptKZoAIsfCnTjsCubN0laFKRY5zNhpwmI4KNSSvqC
 HaGFIe6Q63ANmuvo0+/8tEQ69KVPYZQOakePeEaDqZXS17rYf+gY8lXRnVpA7P89xcyU
 3HumoLgNbxnqcf8CC0/KUDMRp3srlGpvJkoF1v0Yr2U3IyRaaKtK9Oax0X0DY3A1++BZ
 4TduE4lVNABRmuhUgAgoptYbibjxe1f542epGfEyPwPsYBoegbvgouAl81BxDsiLS5Qw
 NvviuDE5UAWGHuI+1AKxpf0hDL3mr80ODk28Dv3QOCU8dI0BxZ4Q2dHCvtvMBAwDs3eY
 r3BA==
X-Gm-Message-State: APjAAAWs9zPN5Tqm46sgfGvuvwIO5uKkOJyampwVTh/md6je5ZR/KOsp
 8KB1Rz2nSZXb2nCg3D8y0W9tzDAjrpY=
X-Google-Smtp-Source: APXvYqzgtYrUhzQTpuT03c420mhfffIZKji6KTfbD4EMeaOwbFn85Ipc0tFnItlRkpWt84Ru/ZRteg==
X-Received: by 2002:a17:902:ff02:: with SMTP id
 f2mr20289697plj.126.1569040389790; 
 Fri, 20 Sep 2019 21:33:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 193sm4179986pfc.59.2019.09.20.21.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 21:33:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/alpha: Tidy helper_fp_exc_raise_s
Date: Fri, 20 Sep 2019 21:32:56 -0700
Message-Id: <20190921043256.4575-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921043256.4575-1-richard.henderson@linaro.org>
References: <20190921043256.4575-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove a redundant masking of ignore.  Once that's gone it is
obvious that the system-mode inner test is redundant with the
outer test.  Move the fpcr_exc_enable masking up and tidy.

No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/fpu_helper.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 62a066d902..df8b58963b 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -90,25 +90,18 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
     uint32_t exc = env->error_code & ~ignore;
     if (exc) {
         env->fpcr |= exc;
-        exc &= ~ignore;
-#ifdef CONFIG_USER_ONLY
-        /*
-         * In user mode, the kernel's software handler only
-         * delivers a signal if the exception is enabled.
-         */
-        if (!(exc & env->fpcr_exc_enable)) {
-            return;
-        }
-#else
+        exc &= env->fpcr_exc_enable;
         /*
          * In system mode, the software handler gets invoked
          * for any non-ignored exception.
+         * In user mode, the kernel's software handler only
+         * delivers a signal if the exception is enabled.
          */
+#ifdef CONFIG_USER_ONLY
         if (!exc) {
             return;
         }
 #endif
-        exc &= env->fpcr_exc_enable;
         fp_exc_raise1(env, GETPC(), exc, regno, EXC_M_SWC);
     }
 }
-- 
2.17.1


