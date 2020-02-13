Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD52C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75E920873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eH7t+n1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75E920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NLV-0006Ra-VK
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKJ-0004hB-P8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKI-0003kT-Mv
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:19 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35387)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKI-0003im-G2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:18 -0500
Received: by mail-wr1-x42a.google.com with SMTP id w12so8750696wrt.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xk2650h3wDm/dF48W9ZCLpoRo1e5nZQvUV6vRqejydc=;
 b=eH7t+n1eFb0+y+a7SHsE01/f2K8cdBjpxqOAV8O18/rfxRHFc2hVVQwM8dWQHElvxI
 qJ2FDoaS73kF2LYsN7H+2UTd1mW4d4grXgzW1LEHDjk2tHIqT7wj96sOba+7Cg/ai02m
 Wf9+SDglzqXlq6NcCpMaAOFTIlfPjEZX7IgKgfUGv/x5jjSH+7wZ7iHesMXrZ9vRLk87
 GxpjvmFVImdeEDFVdu3umK/uerXmQzQqhcz9y6JXnBzP1UchnOI37AOuMC7RNL98Tn1T
 tBGovp1ov4a+qS65LPs9IWvav/+MHaCxQ769HPauefcwtdij6PARjMTqHohM+imu+CUU
 CaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xk2650h3wDm/dF48W9ZCLpoRo1e5nZQvUV6vRqejydc=;
 b=a3XUALx268dR6M1O/aFxAiWh/rMUJtJI/OBAXZPOX8rYQNCY8DlQQImFnw3c1oS0g8
 BKXzrzcUwD37DjaUeRKx9KwlVab9BxAaTC4HrSAQ1GxCRQYErSBbhRK7MEIsmp08N3Aw
 P3wQq2mf5+AT8Ipah98e3rPIEO9dGT9RI2uc+ZAwAJFAAhXuVaGQ29aDgx3FnCTQ69c8
 AQCyf2Jpm+L4vKQMK4R47VBtvYjiskMH9rwGxJS6ZMJ6siVwRWEvlFY5z0mao4WruQ+J
 96eAyCPniQEAN7/wyFbuEO/5gkZgjmt4TuxVm+1uCv/m81pYtDrIx0Uq65w/CfYgKse1
 iZvw==
X-Gm-Message-State: APjAAAXQRyaMdeV8X16m6uEk9Nb64S5uKAV2nW1Ksw3h/3witfJoCt3U
 hvAtCcLDlr2EZK7GazSli6SIOg==
X-Google-Smtp-Source: APXvYqzJOe77pFpjrlEz89yVOZGhXXfIH84ndzVvrVax18jPyP6IqgKZAeGS6Ml8/v+lF+VWsmcTmQ==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr25132679wru.170.1581634277331; 
 Thu, 13 Feb 2020 14:51:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a22sm4940111wmd.20.2020.02.13.14.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 293031FF93;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 06/19] travis.yml: Fix Travis YAML configuration warnings
Date: Thu, 13 Feb 2020 22:50:56 +0000
Message-Id: <20200213225109.13120-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

This fixes the following warnings Travis has detected on the
YAML configuration:

- 'on root: missing os, using the default "linux"'
- 'on root: the key matrix is an alias for jobs, using jobs'
- 'on jobs.include.python: unexpected sequence, using the first value (3.5)'
- 'on jobs.include.python: unexpected sequence, using the first value (3.6)'

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200207210124.141119-2-wainersm@redhat.com>
---
 .travis.yml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index ea13e071795..0612998958b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,6 +1,7 @@
 # The current Travis default is a VM based 16.04 Xenial on GCE
 # Additional builds with specific requirements for a full VM need to
 # be added as additional matrix: entries later on
+os: linux
 dist: xenial
 language: c
 compiler:
@@ -113,7 +114,7 @@ after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
 
 
-matrix:
+jobs:
   include:
     - name: "GCC static (user)"
       env:
@@ -297,8 +298,7 @@ matrix:
         - CONFIG="--target-list=x86_64-softmmu"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
-      python:
-        - "3.5"
+      python: 3.5
 
 
     - name: "GCC Python 3.6 (x86_64-softmmu)"
@@ -306,8 +306,7 @@ matrix:
         - CONFIG="--target-list=x86_64-softmmu"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
-      python:
-        - "3.6"
+      python: 3.6
 
 
     # Acceptance (Functional) tests
-- 
2.20.1


