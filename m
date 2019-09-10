Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C59C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE82D208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgUBdvJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE82D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cDn-00039H-Ss
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7br1-0000uY-FV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7br0-0000gc-DS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7br0-0000gF-7I
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id u16so18455052wrr.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WUvbSCpVrhgaso7nfdw/Ni5/eDIE/oeaqBdvwq1XqL0=;
 b=vgUBdvJ8exFZxHNaJDMng5PKAdnamSm1Jey2SSNpsm+CWr07oXNisAIVCS2YwzOm80
 JjqoH5S9xLJH5uVER98YH+W/1mF5c03mQJ8Q+ulLPpM0EUTj0Fui7b1TpiVlXbFxgx1U
 uzHrqEAKFiRSmGjzSWVTZ4JwELIBmwgrAs7Z6SjsQIoFTZkbTvW8VM6OJIleZKdYJodj
 S4nPtyLvSxZjtR1dbHwVPoYikLp0G9usmW8gIjEPN2XDsObyk0vNQEpkq3a1eMZUIVIA
 HHL8jbu0bDj1HYXY+7765TwbMKZjKjijjeluNOhsO1VMzeleOG6eUOJwzycdeozobLve
 Wrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WUvbSCpVrhgaso7nfdw/Ni5/eDIE/oeaqBdvwq1XqL0=;
 b=nMfJbcNwxGZ/0ScDSkCUXFi6rvLgHKIuJNVMQzIaTCKX6vIhfVcE+EAPiP8S43xseL
 Xk+hJr8HrfYIvLCDKSzbcet6FQNbTaiihUHD+U4V+eYp4roQ5KJuk2c77hzCe+QaFxvv
 Kcw5xGuz6Q1lysU62UE3eXHPDcOl906LxkH6tP2g5kchjFJLb+YMSSgPS51ylZFafD6x
 LlRrU9u/dcCPlI+M2Dw70y6t5Ao1gfBoeJV1LxfFB01n8YGktejKyd9YN2peTXyyfrYU
 y8Q9oZb0yJX7tVJIO2LqMegt5mB6YUZBCndJrlHl4Bkq8smQ2sBlEnrr05rYEX9mzRdJ
 IrSA==
X-Gm-Message-State: APjAAAWv+WP2op4F0S0fTIcc9zC4xKj7UOOLyGrrWyxCHVqFspTt3kzc
 hurGza0Uwup3EfFe5Y5Cxw4twg==
X-Google-Smtp-Source: APXvYqxHdYLKHnYok1O6Mq5tM1k/qtGLykEsTnJFv74kwH9AeR3xdp0wZEtkkOSjzlNiYzInfYh2zA==
X-Received: by 2002:adf:f502:: with SMTP id q2mr19501122wro.186.1568105425223; 
 Tue, 10 Sep 2019 01:50:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g185sm4982521wme.10.2019.09.10.01.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8CFFA1FF9B;
 Tue, 10 Sep 2019 09:43:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:15 +0100
Message-Id: <20190910084349.28817-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 11/45] tests/docker: move DEF_TARGET_LIST
 setting to common.rc
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

We might as well not repeat ourselves. At the same time allow it to be
overridden which we will use later from docker targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 4011561587a..512202b0a19 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -11,6 +11,10 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
 
+# This might be set by ENV of a docker container... it is always
+# overriden by TARGET_LIST if the user sets it.
+DEF_TARGET_LIST=${DEF_TARGET_LIST:-"x86_64-softmmu,aarch64-softmmu"}
+
 requires()
 {
     for c in $@; do
diff --git a/tests/docker/test-build b/tests/docker/test-build
index 22766cfacc0..2b2a7832f15 100755
--- a/tests/docker/test-build
+++ b/tests/docker/test-build
@@ -15,7 +15,6 @@
 
 cd "$BUILD_DIR"
 
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
 install_qemu
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index fdb1c2c879d..c30eb654eb7 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -16,7 +16,6 @@
 requires mingw dtc
 
 cd "$BUILD_DIR"
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 
 for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
     TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
diff --git a/tests/docker/test-quick b/tests/docker/test-quick
index eee59c55fba..feee44b2476 100755
--- a/tests/docker/test-quick
+++ b/tests/docker/test-quick
@@ -15,7 +15,6 @@
 
 cd "$BUILD_DIR"
 
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
 check_qemu
-- 
2.20.1


