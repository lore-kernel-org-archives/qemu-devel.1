Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190CDC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AA2222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LErcatDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AA2222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYvO-0004He-Jf
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm8-0002Id-O0
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm2-0004xD-Vx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYlz-0004ul-BL
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id b24so3644433wmj.5
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4TiCgB0ny2tvUza4VqSs1EmP1vi1ohKKYJOKu/Jm1To=;
 b=LErcatDQLe1YmhUNHkOSP/3osHQiTLZSji3cjmWeIOMLBOyc5fnbax4sOFsQrX98q0
 jE/YrTm99RmAfH1HmmEm4KQ/RehNVFX2RsrGtvKaVdFbramc7ue0Dnodk8D8K7msbb3W
 2omDW3Og8qLnpckkCbnAx2z38cm8NEzSYVytuZGCqeqyPX16Qe+o0Bw9qiKaa6C+Z9Ki
 fN7JYbmbAOs1qE04od+s0EG24OS+PIMEbiF03X71qXnag0R3tiI5LGLb8XeLPoShLBZ3
 1IRmJEGqWN+veatLU05l1Ldm2RjzGPaPcW0pGtzvuEMGil3cnBAzyKBC+qtyICB6cfyl
 a/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4TiCgB0ny2tvUza4VqSs1EmP1vi1ohKKYJOKu/Jm1To=;
 b=PjLTzhRGUAcPM+wzLl/mEuNPLxN2XE0tpTe1PXY7uIAOj6OflV6ri/AjPxep8/JeQN
 isNh0J3mB1WM0mTabAk9pb6Ht0PsYhMh8jvAEugsjuUcIyZbMS3CQhKXcdiKGMJiDbh0
 2A6ics/XWMVBnkvZmFScf0R8T5y94DGS63ZRH+9fzO+g3hbetXkR/xwa0wu9gaSt8I9/
 UIsEvnzeUEp7thHuSl9sLFJ8PW+jPPYIxanpwteR/O3yo1bkZZOSQBXZobobifteF2EJ
 Ftfoqk6bGkmhD19qnj94twwig0fbrKQBwP0mEJNkL6D/d5Y2Dt04TrTncvYicuJfU43r
 lJUg==
X-Gm-Message-State: APjAAAVmnSQcjLhZGbCAX6G9iwI7VOPK7aq9NlMrwi8FcOAak+bV+EY8
 Q9zWhrzbxtp2QcwLalzPx5bKpQ==
X-Google-Smtp-Source: APXvYqx/5IAksBiIR+o8ceO+IHVkSXjxq+tpEMooro4ygKZp3hF/nOZ1L+tMI03gRuzpcdVaGuu/tA==
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr4304693wme.96.1569523549925; 
 Thu, 26 Sep 2019 11:45:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t4sm67341wrm.13.2019.09.26.11.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 018371FFA6;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 19/28] configure: preserve PKG_CONFIG for subdir builds
Date: Thu, 26 Sep 2019 19:35:44 +0100
Message-Id: <20190926183553.13895-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The slirp sub-module complains about not being able to find the glib
library on cross-compiles because it is using the default pkg-config
tool (which isn't installed in our cross-build docker images).
Preserve PKG_CONFIG in our host config and pass it down to slirp.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/Makefile b/Makefile
index a0c1430b40..8da33595ed 100644
--- a/Makefile
+++ b/Makefile
@@ -510,7 +510,11 @@ capstone/all: .git-submodule-status
 
 .PHONY: slirp/all
 slirp/all: .git-submodule-status
-	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
+	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp		\
+		BUILD_DIR="$(BUILD_DIR)/slirp" 			\
+		PKG_CONFIG="$(PKG_CONFIG)" 				\
+		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
+		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
 # Compatibility gunk to keep make working across the rename of targets
 # for recursion, to be removed some time after 4.1.
diff --git a/configure b/configure
index 397bb476e1..542f6aea3f 100755
--- a/configure
+++ b/configure
@@ -7302,6 +7302,7 @@ echo "OBJCOPY=$objcopy" >> $config_host_mak
 echo "LD=$ld" >> $config_host_mak
 echo "RANLIB=$ranlib" >> $config_host_mak
 echo "NM=$nm" >> $config_host_mak
+echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
-- 
2.20.1


