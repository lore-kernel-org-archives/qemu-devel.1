Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C68CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203522070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOFeiEMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203522070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtKB-0000LD-O3
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDs-0002yE-OP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDr-0008Mb-MD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDr-0008MA-Fb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z11so890796wro.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4cAF+jXyqILcdqYr8jn1OJvirZtMtT4XAzWjgRvCIE8=;
 b=kOFeiEMXDYOHwQPfl0kHuMvl4tKU5HFm844orqsJ85Zo6fWzxr46OCGfsNoVngzo4y
 8h3drd0lpCuucb8IGu2DyMElEplMsID+fKGbOit0eRkRECyAqAF5EbscrRtlGVYxemEr
 vdF8azx19nNZPbAMT4G52qtbPpaj/81W3pkGPW4fiOcnXaxnDbSJ1L21sepoyWVS2PyJ
 wHD+J51Dfs/1txCW2+M0wC9HraRf1DBx/aUTMEbT8eQSa066FrggZxcOzE0SuHWLijzS
 TMdBdWLRsHN9yAAXEI6Ek+wwlqbGFWE/0KvQ5l2jjYl1aK9SkgaeybQsc1fD6MDnmDyJ
 m4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4cAF+jXyqILcdqYr8jn1OJvirZtMtT4XAzWjgRvCIE8=;
 b=HMyo99cl2w26utt4hjAhZe36/SSCOpqyXbT1Zfpq4zXpHtwPL+rhlkG6q9Nu3sfVVA
 UOYMZNrIO/C4EznhS0M4ySU3q4v5T3K3ffMmawBnRYcXUHi9OJxnhTnWL7B56lbEQTRm
 ai4IiD7rjKgze3LQmXnzdTW37vptmgrf9dmo2QzHHSMqi0D4Mekrd6fTdIQNB8KAGbS9
 DttOOVatkwMdQksqgxfc55/vfWAgXJUcwptw+I7aZURskAqCAY7XxTMz+v+8PY91fxg7
 fwpJmQvUJAHnqlll9RxM9IojPIsEFaXeFXtgvTEZ5t2Tj5MjFk7VPUsk2f/kBMu320tm
 jiVw==
X-Gm-Message-State: APjAAAUNXHzueYQeRSv3aXZQ7ugjrbLWVthyUbGRwFmDpiODK0trUqHn
 5t+xUGE7shlMQ3e6iha4q7cM7w==
X-Google-Smtp-Source: APXvYqyvAqltYfLboJGIPsf9eNECANJpqFlJk/wyTQjw/+4Fh8HPP83EkiigbafZrqJ2S/pxGjywww==
X-Received: by 2002:adf:e886:: with SMTP id d6mr1329495wrm.188.1571985438400; 
 Thu, 24 Oct 2019 23:37:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a186sm1326161wmd.3.2019.10.24.23.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 041B71FF90;
 Fri, 25 Oct 2019 07:37:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 03/73] travis.yml: Use libsdl2 instead of libsdl1.2,
 and install libsdl2-image
Date: Fri, 25 Oct 2019 07:36:03 +0100
Message-Id: <20191025063713.23374-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We've removed support for SDL 1.2 quite a while ago already, so let's
use SDL 2 now in Travis to get test coverage for SDL again.
And while we're at it, also add libsdl2-image-dev which can be used
by QEMU nowadays, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 7be2a9949f5..b446e04e8ae 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,7 +39,8 @@ addons:
       - libpixman-1-dev
       - libpng12-dev
       - librados-dev
-      - libsdl1.2-dev
+      - libsdl2-dev
+      - libsdl2-image-dev
       - libseccomp-dev
       - libspice-protocol-dev
       - libspice-server-dev
@@ -309,7 +310,8 @@ matrix:
             - libpixman-1-dev
             - libpng12-dev
             - librados-dev
-            - libsdl1.2-dev
+            - libsdl2-dev
+            - libsdl2-image-dev
             - libseccomp-dev
             - libspice-protocol-dev
             - libspice-server-dev
-- 
2.20.1


