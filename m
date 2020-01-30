Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2567CC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B3E206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOILMGur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8FR-0001U0-3F
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89r-0001JS-8x
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89q-0008VZ-Bx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:51 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix89q-0008Tl-5F
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:50 -0500
Received: by mail-wm1-x342.google.com with SMTP id m10so6257800wmc.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QzX8e4lRq+MMc5UdLojQ3gOqvxJ4OMli7ZaMN9+c80c=;
 b=DOILMGurmctWTp+Hl44HSCgZGA303gqAm0kzl+b51CXNQwyKgXCNAdFOzM+QsAKQt5
 6/xEZgjI427NPo8313eyRMNUFPJZwe9G4buUfQsqwL6VB3UdsIkcOVXwqqBikWeP+ChT
 VqzqXZglMniUeGahJskiz1FXblGpd52yZLD00Pnc84T6LDdHXWfPHgW/edOVOt0kcBCE
 JXE/JCRgR9b3vVPjiII7gnQ9fvMjOufmPP/VqJ0IgGLwUSdeYw8wmgItCnB8vCKSZ+gs
 PAq8V+iv+iEJ6ByolRcCd5ZWu4XXpkmqPKZz1vy+mTt2LRmvZmTVM8yPIVpxQekQphyS
 4rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QzX8e4lRq+MMc5UdLojQ3gOqvxJ4OMli7ZaMN9+c80c=;
 b=b6QRxsq9M8rrARuDsWmP2GukJtQrFT4l/dxYUfiPF+mZ9sT2ZPJht7f+izPFBqsLKz
 ssLj/0Sg9+SRd8LtHedvBf0/BELF6LwwDeRVaMeFz1njMB8uPR1MgYdvf76zqv3NwiRQ
 ZdOtn4SIjUskF6PLBmQz1BYOqRlUAIVapA1uIM+JSRwuMaOO8oyTlesQ+39TaOFFcnCv
 k23UN1dlIi7gLuRqPX66JEKBxL7jLHU50m4r2UflIygBY5vHnX89iKHHLs97TdK1Nc+o
 ad4KEDKbKkwH4cfyiEhRNlwM9U2SnwNV/p6tJfOp37xA7bWbIAHho0DDcK+qkPfA8uXU
 fYjQ==
X-Gm-Message-State: APjAAAVFTomjshD7qXo88eOGVKGfHJDrCVrEP1U9KKIE/izGg5MxkAQl
 eDpKNSZUybJX9hJQuuDLZKIFcQ==
X-Google-Smtp-Source: APXvYqzzz+4OBFdiwmbM259Ay96Y6AMQg1VqkdF51d2z5n6JWnjvwFW/rU0Di1zq4Agj3d5/7qov5g==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr5177835wmj.170.1580384329133; 
 Thu, 30 Jan 2020 03:38:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm6815643wrw.97.2020.01.30.03.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:43 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3DF0C1FF9C;
 Thu, 30 Jan 2020 11:32:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 12/12] .travis.yml: limit the arm64 target list
Date: Thu, 30 Jan 2020 11:32:23 +0000
Message-Id: <20200130113223.31046-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130113223.31046-1-alex.bennee@linaro.org>
References: <20200130113223.31046-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Even though we can do a good multi-threaded build we are still
exceeding the 50 minute build time while running the tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index a600f508b0..71bf650b1d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -426,7 +426,7 @@ matrix:
           - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
-        - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - CONFIG="--disable-containers --target-list=aarch64-softmmu,aarch64-linux-user,arm-softmmu,arm-linux-user"
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
-- 
2.20.1


