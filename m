Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4933AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AA92072E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAjdLk1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AA92072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33087 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYjb-0000UK-VG
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeW-00018M-Se
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeV-000680-Mo
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:12 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeV-00063U-Fn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:11 -0500
Received: by mail-wr1-x431.google.com with SMTP id y11so7574412wrt.6
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rUK03t1XFv22ufStO/dbfaGDMm7dWTj6sKWGcp9q33c=;
 b=iAjdLk1+jQdrkeu1sNjJgWl4SBhbKtwMeQyJRh3nB2TfErQAUKlAZlOjbcEtEzkZ0q
 4Tl3nHRlnmhf1bM6pCV4rlUOPF+aAvQXhOT65XXSOyjj+2O4rhs/CsBGuI4OMejIBExK
 xtNKXNF+pMKpAVR2hDYbbv8OP1hvuRZbaIoLCCRM97D/r0tw7hTsfoooK8pUZRQxZSYd
 VmBs0H0lQjBZJC1Biw00L9VLbv8FeZQclwFuZLHrvy1OR3NFICQ+yNiqu9kfjBHmRYlk
 /Bqt+H3udvPgO1FNl6cZnd9uFd1mus8bPQjFdekfX4woo7+vd+z2VxE4hOzJnnHclAd+
 n2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rUK03t1XFv22ufStO/dbfaGDMm7dWTj6sKWGcp9q33c=;
 b=iRJWofah2CCeDx4I0M0tUKqbRtZy+xU3CgnjucJNfINbs9tgUeLNBCjTrj9IM6fB6N
 h7OvbBMQdYda6tVfoTVDbMEeK2zN3m23CuCeMF9EDAMaf55awpJGdSVFXnpN/gvAx05A
 X5ehdphyxW+l/O00HDKL1V13BA6LwU7Iy93n6RfZRyydMtvT3QK8d0slHbb1hblC36PK
 M8vi0cIGFGWsgLvNLsnGiMlb/xeNrGrdWgjhF595ox3VbEMAUjep7OeIRsP29jx0WMTi
 PQeUAhBHF8nf7SzzfTb4lvsQeKpzCB+GQ1OSCpKXX6cMVNvCqu/RsW9MOI+CB5Mus+os
 bu1g==
X-Gm-Message-State: APjAAAW5eMpkp/g0oiN3pldcu2xQ5O1VTUh3MVxsbeTrr3MgQkHoXx9r
 d/eO0cVVeDm8yyKZve0m7xiWCg==
X-Google-Smtp-Source: APXvYqzQabvzs2CYgVZ3W4ETYquc5UROS0AlWPyF+Y45wRO4zJQKHnoVB6yFgiqWS2H7C8cTUJQ3kg==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr10614556wrv.55.1578579550470; 
 Thu, 09 Jan 2020 06:19:10 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g18sm2894190wmh.48.2020.01.09.06.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:19:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BBCE1FF96;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 07/14] travis.yml: install homebrew python for OS X
Date: Thu,  9 Jan 2020 14:18:51 +0000
Message-Id: <20200109141858.14376-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

Our python3 requirements now outstrip those of the build. While we are
at it we can move more of the special casing for Mac into the one
build we have.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 6826618ea81..6c1038a0f1a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -51,13 +51,6 @@ addons:
       - sparse
       - uuid-dev
       - gcovr
-  homebrew:
-    packages:
-      - ccache
-      - glib
-      - pixman
-      - gnu-sed
-    update: true
 
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
@@ -239,7 +232,17 @@ matrix:
       os: osx
       osx_image: xcode10.3
       compiler: clang
+      addons:
+        homebrew:
+          packages:
+            - ccache
+            - glib
+            - pixman
+            - gnu-sed
+            - python
+          update: true
       before_script:
+        - brew link --overwrite python
         - export PATH="/usr/local/opt/ccache/libexec:$PATH"
         - if command -v ccache ; then ccache --zero-stats ; fi
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-- 
2.20.1


