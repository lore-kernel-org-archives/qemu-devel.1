Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA8C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DDD208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cusWhEk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DDD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZB5G-0008Bt-FI
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39333)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAoz-00047N-RE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAox-0004IL-S6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAox-00045z-77
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id c66so1224020wmf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HdpVihLUIZVvKpgG2IEu5C8IS7kClin1bLgeQxnhXsA=;
 b=cusWhEk/JWErEovXuSD115Z7CQzBd2TT8ChezGFYSnZTBpAUKPAIHYO8GR5ReYBc4B
 rAck8troJ7G3+PM8mENsgH16jXhHMdeFQDP0blm/mfUcbKMpbUcZn8U0qzXXC6vKQvyb
 biN0yoGNj/0KIZXlGMxSHlLmFgOa6orbv075sVmYY5iZejWe2ODuUDnVEngKCBUUxLb/
 /wDeseLRvvsKSK0i/1Wwf7D1hrlurY78SsW0FdSPOHQKMn3otCJW+WGpzO18wy3kTGjw
 R6gAdCFZbA+enBBGLH2Evj2eFbEY/ALNg7pINgcg9Tw2nA5SZm0/SUzZbTtA13ug+pdo
 YVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HdpVihLUIZVvKpgG2IEu5C8IS7kClin1bLgeQxnhXsA=;
 b=hXfB3K/t5VadABYZytvE2FyjoxPr9Mbxf1YaHOG4VIzlfoie9ck/cz4xqkqjA+dzVW
 sS0FkUs7TwpbI37ool6JSfr0y9WRMUoJJkqSuhn+YcZCMAcFv2jOQ7HFO6YVmDzZhWz0
 Q/0bGV9xLDPsZAHPV4q7qIGwTuT2hmfQQV7oLvKLCMhWltOfaSh5luR03qPTFI9hhtZf
 /pyVQh0XK9po4FBN1+XkLI39i5azXA7m1WQWUcpjVorysFSdNELj91yuy5vTJ7lYRQDv
 FIsoEPSLZgxrIYCTXqcIqRw4fZdTwciZ0iI4EoYfnPg7lCG/ZuXFBpS3UcIP+/oLbSKW
 yoDw==
X-Gm-Message-State: APjAAAXRdwlz3xH8r0phlsff/jmTR5ZbL8thSuEmTNESVdibWjT6DTxJ
 Og6AmNrczT6y3eTKsJfwoZhacA==
X-Google-Smtp-Source: APXvYqwrIxzQN9tEErYgAPs3VKnrzUNFjRxRUv0fuhGaErKQSDg/x2da/UL3aQX7z0mAj3oXg6lwzA==
X-Received: by 2002:a1c:2bc7:: with SMTP id r190mr2776726wmr.174.1559898357213; 
 Fri, 07 Jun 2019 02:05:57 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p16sm2135625wrg.49.2019.06.07.02.05.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7DA8D1FF93;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:05 +0100
Message-Id: <20190607090552.12434-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 06/52] .travis.yml: bump gcc sanitiser job to
 gcc-9
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

The toolchain PPA has it so we might as well use it. We currently have
to add:

  -Wno-error=stringop-truncation

as there are still strncpy operations in the tree operating on things
that haven't been annotated with QEMU_NONSTRING.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index b053a836a3..f0aa37f2d1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -240,8 +240,8 @@ matrix:
             - ubuntu-toolchain-r-test
           packages:
             # Extra toolchains
-            - gcc-7
-            - g++-7
+            - gcc-9
+            - g++-9
             # Build dependencies
             - libaio-dev
             - libattr1-dev
@@ -270,11 +270,11 @@ matrix:
       language: generic
       compiler: none
       env:
-        - COMPILER_NAME=gcc CXX=g++-7 CC=gcc-7
-        - CONFIG="--cc=gcc-7 --cxx=g++-7 --disable-pie --disable-linux-user"
+        - COMPILER_NAME=gcc CXX=g++-9 CC=gcc-9
+        - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
-        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
+        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
 
 
     # Run check-tcg against linux-user
-- 
2.20.1


