Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4865BC7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185EA22400
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bp2lZ3QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185EA22400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsAm-0002Fh-Sa
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37810)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9c-0005pU-V8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9b-0007OT-TH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9b-0007No-Lk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id p74so37967408wme.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ALSbVid/YImih3quDD8Ltva4On5nsOSWCb8GPnKkNx8=;
 b=Bp2lZ3QEylLuPS79oERMDMmKYweAHtC5n/6v1KieqcOgCnnnJtb5wR11gQtky5dahh
 BvhBLjjWWPosNRI8TJ7PlUWDfTRy4MCFxSVrk3SWSUMlw03olEgSZzVYhq5DP8iZNTRx
 CneHzlXl7rcOjLh/AoOU5Qyjh1xbFGmXSt05kSciVwIlPAeU9oiIPCGSqGJmoHhdNmuR
 j5N2YZFsfGGWeSkVHWRvUfuYAUXzMHoI5cHO2iDNEm6pQNBeU99aJRsaWxlmO3o7X3Ss
 +U2cQQ0/Nk2HwC3DTezs+nt0ljM7sgxtFwt1RBtqk7PLfViRZ9jtksK0rAU9pFjy1mpC
 N39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ALSbVid/YImih3quDD8Ltva4On5nsOSWCb8GPnKkNx8=;
 b=shk6+3Ayp0sHCvQOmnvjqeur8ojPYI+UQdaJJ96x8NUbgD37jhPjYJAyGn0J3NMw/s
 0gGk5N90J61nh7L4VbEapiwK3tzj5ogdjCMJCTvPnjnleQWkoYdsZXER0mWQotfcn76V
 ViBV45w4P0KWWcrfwsX4qaZABv9uotnk4Xa2w0JOMj+gXGJA2EASXo+8q0e+zjvx+YmV
 JozXMXMmjPWra8Nlie3wP4Ko4wVCh6zsAazY81r16jGrXM1dqNv/9Ex82n1eD03W/pvm
 A+vFNsWW+G7gIlmOf7CmuUjnb6LgFjF+JEytc5Wqhtp5H5CTljCGgcuZVsvd1cFdnqQz
 JvQQ==
X-Gm-Message-State: APjAAAVI+g4v39Gj40nC4fIx2Sgx1cwLyqRjrNO5EecuSWzgHmFP8j2J
 gQAuJJgL9Ze/AmeI2mne2I1biQ==
X-Google-Smtp-Source: APXvYqyKFepiaZDAR5tt/OPiAybI1iONVvteFnXrWhrWS6N66cLrPgCUqbOGUSu8gJwKsatXcc0TiA==
X-Received: by 2002:a7b:cb94:: with SMTP id m20mr65920742wmi.144.1563878178507; 
 Tue, 23 Jul 2019 03:36:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 2sm54860322wrn.29.2019.07.23.03.36.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 18E891FF98;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:57 +0100
Message-Id: <20190723103612.5600-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 08/23] shippable: re-enable the windows cross
 builds
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pkg.mxe.cc repo has been restored.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.shippable.yml b/.shippable.yml
index f2ffef21d11..f74a3de3ffd 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -7,11 +7,10 @@ env:
   matrix:
     - IMAGE=debian-amd64
       TARGET_LIST=x86_64-softmmu,x86_64-linux-user
-    # currently disabled as the mxe.cc repos are down
-    # - IMAGE=debian-win32-cross
-    #   TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
-    # - IMAGE=debian-win64-cross
-    #   TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
+    - IMAGE=debian-win32-cross
+      TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
+    - IMAGE=debian-win64-cross
+      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.20.1


