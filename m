Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F94C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E9620674
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lN8TfJdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E9620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxiz-0005o1-0Y
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iZxJB-0001qS-3B
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iZxJ9-0006QL-VF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:24:40 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iZxJ9-0006PZ-OS
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:24:39 -0500
Received: by mail-wm1-x342.google.com with SMTP id u18so7076166wmc.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HtcJiwwW+gyhZRJF5+tizSVlncEnC6PNe62jtdYK+WA=;
 b=lN8TfJdiFtY3TKhxaHZ6i5hKR8kLd+P7x2p2hdls/bJ09Z6wGHTURyb05C9pc6FQr+
 H+w7UWFb+bj3iIiGvO0iwPRJqFIJtOiaIOpsC2Ev1N2+2qHqiTKFAW5Ux7f6D0MDbiZ5
 weqrAVa0eh5KYGa6AbTiKOS6tVrDYBS4OD0XILw1SfgMH8Nywru1fzyH4qNFVbdEuC9K
 zxbHcr/o0YVxULqlwam47PmZjTaAPZUNL41YvqnC6HYU17Esf7RCAuSYPtO8+/Vd2bH3
 +YAkmWgyua0XvbCEBUwLi+6s5YcF5YXNu73PT5UTYXU2fyDGDLyLoWG8PniBjV7ylMrb
 sijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HtcJiwwW+gyhZRJF5+tizSVlncEnC6PNe62jtdYK+WA=;
 b=W0FdNIgIdRSWJfv1Zf3Y/L/0N0mCguwway4mKWWYJ782rS1ck6RC/CxwQ4m+d7j1Y3
 sRf6lCFky6qemRXrOKDQyDKajxnJgUJ3rRu1Zilma+820B2ccEta1hylvOOGwb4T7H4T
 LYrXz0nA50MCSuu9p2yyivMZUPTL0CWM26qkkf1SyQBu6/5w0u0z3lIwZsL3/6fOXg8L
 BhKaQosHM70pEkHhmS1B+qBqL9jUHZEWNIP4Ko98hf94xquuV8kVgqXrc/+/oDmu02zr
 fMjwebLydT6euYVY4cI56zZ0NSC/O9nG29EP2sIFQfMDDR0Wa6q5vShTitXFHI2qcyri
 WgTQ==
X-Gm-Message-State: APjAAAVwqN9rGoHydy772WBaaN2DwHC6Zc8pUuSU4KDHQ1NBW+z3qI6i
 TvniF2K/mVGcvQMp83EKmgYGgQ==
X-Google-Smtp-Source: APXvYqw7qXbIb0qW4TOra4rmZgfkHU5kz43UVbrwYAPSRzY2aeEtvfvzGY25RATbEeXehyScbI4zWg==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr4519118wmc.164.1574861077304; 
 Wed, 27 Nov 2019 05:24:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b63sm6310729wmb.40.2019.11.27.05.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 05:24:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B3ED1FF87;
 Wed, 27 Nov 2019 13:24:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2?] .travis.yml: drop xcode9.4 from build matrix
Date: Wed, 27 Nov 2019 13:24:30 +0000
Message-Id: <20191127132430.3681-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's broken so it's no longer helping. The latest Xcode is covered by
Cirrus.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c09b6a00143..445b0646c18 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -237,13 +237,7 @@ matrix:
         - TEST_CMD=""
 
 
-    # MacOSX builds
-    - env:
-        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS}"
-      os: osx
-      osx_image: xcode9.4
-      compiler: clang
-
+    # MacOSX builds - cirrus.yml also tests some MacOS builds including latest Xcode
 
     - env:
         - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
-- 
2.20.1


