Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58929C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F3C20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvIw/UB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F3C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYlf-00039p-0k
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeV-000152-2y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeT-0005yT-Sy
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeT-0005tb-LA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:09 -0500
Received: by mail-wm1-x334.google.com with SMTP id p17so3046365wmb.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W7giEOoa1246FG2AY+/m5rvSamIbq8aBUgZlAteletA=;
 b=JvIw/UB5rrqP5gpdPQJD9cx1eRXnvsCaiaVPuqq01tHRrIwAwmW+uw4SNb6vbey5TS
 1eAyNFPcXg0bnen0fVny+36cnKeJCE0vNjRL5yNLgr6TF/wqU4WimLdFYyWejR1hoedQ
 1CviTzVIpC5inmfM4j7rAifkIYJMSojUM14Cdd/PCxecqH1cgB2r4m8nPT8wLZhArE8k
 FZlKqp9Y5D1G/5QNEPRgo/7ww1zoYWGLUr7mzQXDZFTze2lz5nzMBCD1EooHZGq3mEfv
 JxHzRUnNqld6QIa1bLBxK2cHGj4Uvk+oTXcwpMIWh3YRVvLVXEAEKm88xafXOW5OuIWg
 Zxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W7giEOoa1246FG2AY+/m5rvSamIbq8aBUgZlAteletA=;
 b=uOPgXx+Ochul2Gt1VlXW2KEsUIfCau2rcyLVE+Jl3dWNvqEOl+QJ1CovdwWDHTRgHi
 A9MFDUtgMpeFT8RzT2CnIe/z497NHVkzyEc74nJP+LxH6xdnOTboA3x5VkEar4sQEw0S
 sgBSubvVfyo9VfvpYFRFyUccfYRMZNzPvlzpl/Odd/nrZOQwRDUdtFYnUWMoFKdOiQn3
 og4+XTdAfZRzbO40tkCpHeoAtKFnPJj47gbl+7SsxMIRAXYySvvQ/Uqobx5DQz12SRXt
 PPr41YmPL2CsJ5yL6lf3H6mg0N+vkbyAfTaN3RejqQ53Ne/4FmAl4ayfNDz7Ku58tWe/
 mQGw==
X-Gm-Message-State: APjAAAV99TbWw3lN5VdfST1Myaf7kbvaLGJUaLSPOBG55nx4dDt59Slh
 8OIwpCpj/Etzt9v92IU2JVWd6A==
X-Google-Smtp-Source: APXvYqx/fAvOmEhMaTpkwKjSVuMml55nuBai4yMq1pk5M52MmEXyWTWsZfYn4g0otUJVCrz6FsKcZg==
X-Received: by 2002:a05:600c:30a:: with SMTP id
 q10mr5066310wmd.84.1578579548627; 
 Thu, 09 Jan 2020 06:19:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v22sm2953278wml.11.2020.01.09.06.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:19:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6008E1FF92;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 05/14] travis.yml: Detach build and test steps
Date: Thu,  9 Jan 2020 14:18:49 +0000
Message-Id: <20200109141858.14376-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

Currently build and test commands are a single step in a
Travis's `script` block. In order to see the output
of the tests one needs to scroll down the log to find where
the build messages ended and the limit is not clear. If
they were in different steps then Travis would print the
result build command, which can be easily grep'ed.

So this change is made to detach those commands
to ease the visualization of the output.

Note that all steps on the `script` block is executed regardless
if one previous has failed. To overcome it, let's save the
return code of the build then check whether succeed or failed on
the test step.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191230184327.2800-3-wainersm@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index 93838bf0f8b..848a2714efe 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -94,7 +94,8 @@ before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
-  - make -j3 && travis_retry ${TEST_CMD}
+  - BUILD_RC=0 && make -j3 || BUILD_RC=$?
+  - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi
 after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
 
-- 
2.20.1


