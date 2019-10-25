Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F6CA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558C721655
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8VpqLuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558C721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6AO-0001VM-6n
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Ok-0008Kp-F4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oi-0003A7-U6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oi-00039U-O2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id p21so3378541wmg.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yaLEb0Rvga8cR2LHsL8/9HPdNDQgpcbnXqsduwaSFKE=;
 b=z8VpqLukQT1F29bptzXJlV/hRc+Bbne/mj4dMpLLKByqB+YF+TL7agF3rtGcw68arZ
 /vd2yhSQNtzYCsZ/GSLvPSABoYkIkVmw7TSUTXo3WB2J7kbfiYOORX1xk2banOiLKJ3n
 uaR4NruZkY+jmXjxCETf5H0Sb0VfGYznBn6jPeWT9yQUEEiO3IFkO6idF9vCf0gTCjEX
 ERg+iG8oPNulaJI2dxG13AhMHcSCdh7BOm5c/iMcXWzUJvTauy1UrPjUiGcYC4LmTWsH
 VOnQ3vYRl1thvkaGHezqX48Llm6jWmeQa8+KWmdYR7L7dlPMS42CfXVVx/g413AycA80
 SnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yaLEb0Rvga8cR2LHsL8/9HPdNDQgpcbnXqsduwaSFKE=;
 b=RV8eetTb8KDmX4N7qfm0hQuHqPltLCxvt3S3Bki1oRjjhY3/5vMFJQNGeHn4yZpCL3
 Rqe9d5PZMW7PSUgIRDnDDsh3s98GffDFp0ii2vnaAAoCWvMl1810cRwxotAp0EuYrn6A
 qAv3gKjx6SzbODcphY8IkMCdUOW6ez0IKy0EoZ0Fqs90Td/AsF+LHWetpEEAWdNKToQO
 YPXxRDRNBOngkT68Z2pQtESJDe3WqE82kAm3P9s7JEZvXOAtN6QU25nioTLLRxoJcVDz
 VTuovoDOuSuUlMHJO5bTS3ltl1U1WNjftLNfeJ0jJZ4KSIDzs7FMkXSY42oxlWBfJ/i1
 3DTw==
X-Gm-Message-State: APjAAAXTt9TrlcJgwooSgcoULcH7lKPgNzFE1nemgyGy0Wj+uDSY+7OY
 ZbNRHyFTzyP8/XYWTR5xQTY3Lw==
X-Google-Smtp-Source: APXvYqyGiEAL0QdjNgYd9X1yXSVbFore6maxVvzIU9Z0CDg+3mhgVkau7lsqoJg/gD6gI+LGiI1iPA==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr5219691wmc.34.1572032239588; 
 Fri, 25 Oct 2019 12:37:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j19sm4479657wre.0.2019.10.25.12.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 960C31FF9D;
 Fri, 25 Oct 2019 20:37:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 13/15] travis.yml: --enable-debug-tcg to check-tcg
Date: Fri, 25 Oct 2019 20:37:07 +0100
Message-Id: <20191025193709.28783-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

This adds a whole bunch of asserts which will catch bugs you might
introduce into the TCG code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index c43597f1331..ba3a8d4cfc9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -334,14 +334,14 @@ matrix:
 
     # Run check-tcg against linux-user
     - env:
-        - CONFIG="--disable-system"
+        - CONFIG="--disable-system --enable-debug-tcg"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # Run check-tcg against softmmu targets
     - env:
-        - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
+        - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
-- 
2.20.1


