Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B6C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9DA208C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHfEjxGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9DA208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nSe-0006Xu-3h
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLY-0007hq-Uw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLX-0000Li-Rg
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8nLX-0000Ky-J1
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id g207so3186399wmg.5
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JGS4cd+3+YzNw9t73UEu5DEiXh2KRBor/rrPcaum5qs=;
 b=BHfEjxGIgmrPJQeBKR7yfHNuP7KYIDnq29twlVQf3EjHhlqMuXHIwn4G0ng1svRtDN
 Lw15xPcURZ6r6eyKjlmNvvDDDdhCO2rvqkaYNiGnB1gC93dz3x7fU01IHRLwXIUWzeS6
 /ECgj/PRTuYHZHZgziKyS3lPXpMGZFQR72fYgjlzpsF4LXuEu9s9hil5D0UrRq+2LYzp
 C+hydzJwGF1O3q3Cil9n19KUQEMKuYBDYM6CCeQ3Gc5W5tHwOxKGMjgDzYUdp1ku8rSw
 velnJpgRrnIRcmQCt31L3pVES/7bcHZH3u/foQHgWgeCeJwPZKhKjxVF9I0I1giF3WaI
 FfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JGS4cd+3+YzNw9t73UEu5DEiXh2KRBor/rrPcaum5qs=;
 b=cBNXFEAUcNvLSFdbxsZf0I3+xabKstK+9Cjwu1Xg0a/bYOgeH1pN4m1eJNZ5o2M/l8
 CXNWFVqPFn4+rszpl9463ptI9EQ1b3XplSLNChuRc3zbXz0DXQ9wrXx62iz2H/gZxSHX
 BZOhhPXf7JzvCmBqmJrY9LFWgZLfTiX3x98jH1aROHP3HJop7mQRI5weWWhHCv5bkdbR
 H4U3iuCaTqQgQxqaWAWK7clVSfSOsl5VW/ojKYmGSW3GZbzFqleFMn56LFQAdSNXC5xs
 nkntl4yZHp8GiEJZTmUCRspVs6mVCgUAehs3NUzmdVg0NhvyANmR5uc0XriwvqcZbRP+
 MOsw==
X-Gm-Message-State: APjAAAVhKJ6rUrVtm5rGqtMTE9VJxABYxmOn77aTNNe8bqSV3lpd02+3
 wbr8GrOfT1IpT8ZW356lafPwYA==
X-Google-Smtp-Source: APXvYqyitFLFFjPuQ+R9jOHkv6y3gV39j/Qji3vOZ/sopWGB+rkrP+qLim9LUVJgqliI21M4somGCA==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr4104310wmo.114.1568387930536; 
 Fri, 13 Sep 2019 08:18:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v4sm44135003wrg.56.2019.09.13.08.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:18:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD40C1FF92;
 Fri, 13 Sep 2019 16:18:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 16:18:44 +0100
Message-Id: <20190913151845.12582-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913151845.12582-1-alex.bennee@linaro.org>
References: <20190913151845.12582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v6 5/6] target/arm: remove run-time semihosting
 checks for linux-user
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we do all our checking at translate time we can make cpu_loop a
little bit simpler. We also introduce a simple linux-user semihosting
test case to defend the functionality. The out-of-tree softmmu based
semihosting tests are still more comprehensive.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/arm/cpu_loop.c       | 3 ---
 linux-user/arm/target_syscall.h | 3 ---
 2 files changed, 6 deletions(-)

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
-- 
2.20.1


