Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E225C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A68B2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvazD4rQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A68B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aSn-0005T1-Gh
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcQ-0005Rz-5F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcP-0007Dt-78
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcN-0007DI-FI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:19 -0500
Received: by mail-wm1-x330.google.com with SMTP id p9so2867185wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xk2650h3wDm/dF48W9ZCLpoRo1e5nZQvUV6vRqejydc=;
 b=BvazD4rQiFWfFCDxTfrXAHYChj5fheyaui8xXIyDSlNBhelM35UVRAa5WxzVb9i+VG
 OpPM31Lh9TY2J/8VHTaC0sSJc7fyTof1M38K4jDThh0i8u1y/1eA3eOYygAH1q7ahBTW
 RNrhyDlJyZk2Km+dlYBR5f+fmTq1qP6aWBcHcRQk5SBChthfXHqLtZu9Ci7G7LoWwaW7
 hQOc7v39+gBE/2BhMHx54r/1md5XbcvZSBzeVhwfjGkB9PhzVqHGXSGfEzuaqKWm1gbJ
 Dd9LRXEtO4PSqvRMPKkq7TYpGR0vbBLxIh9e+utGhdyWdMnD4m2VY2VIdzhXYb6YlXUq
 OKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xk2650h3wDm/dF48W9ZCLpoRo1e5nZQvUV6vRqejydc=;
 b=Vd4b6jHtAeHAKon+hTWJpiD26PgTTPCy/IEPxVAcY75WV7t9s152nNvv4y6ySWKyTa
 XCMqXrmIpDQWwFa3uEno22n1gl0Md9l7A2i90iAdP4L5BGVK3VAkLKc111UePmlduhrP
 m6krOFu6ARV2rVkHP7iIA6PlSHrDDeOZCk/ukCcKjxhntSZoEQXy96wgP12j5z5REAx2
 iLhN0LdwduS2ez1s+gK5CVa9hNKr9FRYc8nhf1Gbf1ggV0WD5OjE9ESqKnpRV/dG5B2E
 zPc2m9zaQ8y1XZyC1rrF0zwuldZhGMTnNkKufLHIWynVcHS+YsFSxmE0Rv4Qjj1QKnHh
 Au+Q==
X-Gm-Message-State: APjAAAUWR4WZd2CwzkMfX66l4xvrDj+NHjRvZjRgrh4XMcYYGniehqlL
 hjP0hyuDx/P6xId7eFAPfHR0oA==
X-Google-Smtp-Source: APXvYqz4oSGS0GogNw9c4Z9Cl1KjlE20fvp+pXUj2suEoXl33YXt6WDFz9sTpQetc0Qml7tUnotjWA==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr5224749wmg.103.1582634838345; 
 Tue, 25 Feb 2020 04:47:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 133sm4459335wmd.5.2020.02.25.04.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:14 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB8E61FF93;
 Tue, 25 Feb 2020 12:47:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 06/19] travis.yml: Fix Travis YAML configuration warnings
Date: Tue, 25 Feb 2020 12:46:57 +0000
Message-Id: <20200225124710.14152-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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


