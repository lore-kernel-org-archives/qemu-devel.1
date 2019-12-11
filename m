Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B76C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437C22054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5jEuXbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437C22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5Z8-0006Bn-Rj
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qi-0005EQ-NM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qg-0003Qr-S2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:40 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5Qg-0003Om-F9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id f4so1647778wmj.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YQ48w0pDBwpVmbFzATtm4Ds62QLqzhKfE1NdsRw0nDA=;
 b=o5jEuXbughRSAbKskRVgAT2cK3x7GkHWwHz6982lWgAjGxfjgf5+d80c7VZR648J5H
 Yap9rBqX9jpl7lIljfBuycxaRVCXpSnuiYBB0ykgROotFuip1Hf0C+IkDKxIe9nQ9zOG
 ja8ar3p+29wZeJeO5i+TwsBbEl49zGQMAX30rxp5wqpfE4tbCgI+yMWCTxiF4HdDZNoU
 X+DJubi3RvzKYe8UAGzrbjEf9SEQP36UzoeJZF9eKQ38xtcS+smYtLjXNzeIyY0Ohq3h
 knp/HVJ14cbAKTUiWCLMcRjmI6zrB/Bwqm5P7yJTv8SSQ1DNO8zqp8pEFdf8BEdYCfa+
 hp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YQ48w0pDBwpVmbFzATtm4Ds62QLqzhKfE1NdsRw0nDA=;
 b=etrjjCaAfc1SAUcBOwPdztowoP0X/16SwbhvOGeG0CH/HKtct4FrURqIwOYTXXQ7tr
 IA/gQulJQDufx6JqaG6lWlRdt74nTpGLiijZdLv3w68Ihs1YpM2Kn8QbNBN9AygfSWSQ
 iUgsN1VJ1tNUs26FiL170ZJLyIJM63l5FN66ZtHQzl9O0bKdz2beuFMArUAey9ZRFeKz
 cR8KMTRoJTEw7Il4IZV0rYA7HJXmRBLyB3neIlTaew/qjla1PGYinijI/5pbXTq6trum
 T3fozMgqBd831X7oQWsAB4TWS9ag5RnzGndhWOg+7BHagOLFft+nM5Ke7DG1e6uaL7pl
 K7rQ==
X-Gm-Message-State: APjAAAUt82f4Jap+kvjGGwoOAcSdgxcLwRSuCvR/kkyW4pTDK4Es74Xy
 PFRDSRQ9g32qceBal//zMX+odw==
X-Google-Smtp-Source: APXvYqxPi+vUabDxVUm8ISKpviNv7Uxw/ozr+Mo7j4eHtpsUMVsLHkHA6QzXSZ6ePM6LvoBoTCoazA==
X-Received: by 2002:a1c:1d8c:: with SMTP id d134mr990808wmd.16.1576083937230; 
 Wed, 11 Dec 2019 09:05:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i8sm2971855wro.47.2019.12.11.09.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 92E6D1FF9A;
 Wed, 11 Dec 2019 17:05:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/20] target/arm: default SVE length to 64 bytes for
 linux-user
Date: Wed, 11 Dec 2019 17:05:11 +0000
Message-Id: <20191211170520.7747-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel chooses the default of 64 bytes for SVE registers on
the basis that it is the largest size on known hardware that won't
grow the signal frame. We still honour the sve-max-vq property and
userspace can expand the number of lanes by calling PR_SVE_SET_VL.

This should not make any difference to SVE enabled software as the SVE
is of course vector length agnostic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - tweak zcr_el[1] instead
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a4ac9339bf..d42b88c9b73 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -199,9 +199,9 @@ static void arm_cpu_reset(CPUState *s)
         /* and to the SVE instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
         env->cp15.cptr_el[3] |= CPTR_EZ;
-        /* with maximum vector length */
+        /* with reasonable vector length */
         env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
-                             cpu->sve_max_vq - 1 : 0;
+            MIN(cpu->sve_max_vq - 1, 3) : 0;
         env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
         env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
         /*
-- 
2.20.1


