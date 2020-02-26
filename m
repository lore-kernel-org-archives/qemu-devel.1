Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA3C4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1BF21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpE5mhEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1BF21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rLB-0005xZ-FI
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIF-0000bY-4w
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rID-0002ck-Vn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rID-0002Zp-O0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:41 -0500
Received: by mail-wr1-x42b.google.com with SMTP id l5so1677806wrx.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Uw4ItqtlnV6J94gWyaqnqPadiBrMi5iC4bbotP9gpw=;
 b=PpE5mhEr+okJGfkCG2V7hEM8z8sSwSNs07720blNDfB2HaoTS4eUsvSkdh3EKSvUEY
 qZ65XNpU+kgEQT03IMzaYZpnt13zS+3nIuqniqLGbgZTZp3btwYbRImtvtXVQn5dqaI1
 F28QupxgttzVP6WaJobqASefhOjwirj5dkjaXm/Xbz0pOr7W4KZTTx3zhHS84bkQa80X
 9Epz0D/AL50quNGRvH6wA+uZf/24AblmEYEWGlVMuslmDS/WlnKAGj0YFv4WPqVg7oZl
 Z8l1ARlM5Gp2l2puZWrDHie5ETh+T37M9agBUR9gCbFCJ1DpZbOtD8J7ZyPbIDKFi033
 9eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Uw4ItqtlnV6J94gWyaqnqPadiBrMi5iC4bbotP9gpw=;
 b=RkxoB3gEVYbgNbKuy8j2264xVDPJUb1/e05sSJdEhHf8nI4NYJcGj09uXrGEHufMib
 d59AFjTL7pBfXULSIxPPtebrvwDU78YCsBNzGoT6jxmUoFM1TyA124mUVew5ykTrcVf1
 ILB7bwwgyKtU+tg4fg61sdkB18gTvMSfCWwwNJXiZ5INoatvo95fg24F4MDKGYhuYRmg
 Ptbv/J6+41vMz+vbJeE7buFmPepBJi9nOULHvFQ0TQTmcquZJ7uMYjX6D0K7JmSR1GDF
 t472os+Yo2MyXi5w21Uf3mMU0C4QdzfHDfrZuIhCQS7QvxGusG61vgUH+mgzItgKC7Pl
 6DgQ==
X-Gm-Message-State: APjAAAWZ/QyPxwjWesEFBwiASOkk3E9A1qSNCLBZpl9GrQVx5Tesr3Ix
 EB6lKDGxuUsjmp7GgH8DFnqXgA==
X-Google-Smtp-Source: APXvYqx7xamWLhxX0YRN+UDDf/1LORmIEWgdfAWgHZc1TANU5j9fC7i/jhhPDGv4hL0J1AR7dtQWgA==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr3726057wrm.159.1582702780667; 
 Tue, 25 Feb 2020 23:39:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r1sm1992149wrx.11.2020.02.25.23.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:36 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C378D1FF93;
 Wed, 26 Feb 2020 07:39:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/19] travis.yml: Fix Travis YAML configuration warnings
Date: Wed, 26 Feb 2020 07:39:16 +0000
Message-Id: <20200226073929.28237-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
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
Message-Id: <20200225124710.14152-7-alex.bennee@linaro.org>

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


