Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B455C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D632074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCyEgsUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D632074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02F2-0005jc-KK
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02B0-0007Oc-I6
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ay-0006Ry-Q9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id x5so13423843wmi.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ei48b0uDUhSj4MD+V6eDHkE9M1JkoDFRqMV7PUyL3fQ=;
 b=XCyEgsUVDcvczbvVMmV+bvSMdVel7YOM6/ooWYtSIfe2oyohh8Bk27/JQjv0QCTt3/
 RGj9hDMkjHUPfg/rAod8VN+Sg8EkoPDuodzW2hQ4TXAuuALQRUh/IeohEXUGd1BbNPHF
 ZXMIkYTWg+NdxRmJHl/uKt/10tcKcYed77apVQq2JkxiCxidd/lQ4z34lJW5Vd2jB2Vc
 xkjtN91k0NF21DfKRUqyi45T6TJ7ISkkbjykE5REoXaJ5eJvOXtuhqOB3mNG57ioNy8N
 Jk5B/NPGnNplnLGhXwYwywKglmMM7EZ+HoG1JEltYy5++Rc5wYsO5UTcwQ90jvtjsJrQ
 mhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ei48b0uDUhSj4MD+V6eDHkE9M1JkoDFRqMV7PUyL3fQ=;
 b=gKw0qscBeXcTQHwWYLhd8difeCphkGoqpABieUWsAiID1+IMn7g8ofnJ1Pp2ngvMSH
 g8nzdQaFCIDKMeaItB0ps1W/5OLWC0ZQXloM23/AM7aXvwdNg/lOeGYz0cxaJEIoQlEm
 RlR99eBq1ai45nNT9rZgXE3ztjnj1NcMMt/kILmDgHXoSLbNQSEbMlbAYVgEfvgP8mfX
 ZF6enwuq6Brip6k65pDFhMfB/ef+7Fc/GxxKodRovw5byFTgY4G1Eb9jNmSduwHUw1Nh
 PuIf9QEHNRKtNFV3fWcIhccc0p8h20LzSAelZZwgpZnRI/ptFhDnoYXk2GeF0EwB/Nr8
 cFSw==
X-Gm-Message-State: AOAM532reQlqQOR7wlgnkfqAyKTwp/3VFJtSmg36KEeyIjzXegJ/i9dZ
 R8KidKDslI7BDaNPiTgcQeOXyA==
X-Google-Smtp-Source: ABdhPJxUMzrYyoF90OXICf9y/Cr5eLZFSTczNi1I5v9WXCkcwwLIRbXCbAc62AR7YXVp3/pFho1yRA==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr21829926wme.177.1595852655390; 
 Mon, 27 Jul 2020 05:24:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y203sm9379214wmc.29.2020.07.27.05.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:24:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 556111FF99;
 Mon, 27 Jul 2020 13:23:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/16] tests/docker: fix binfmt_misc image building
Date: Mon, 27 Jul 2020 13:23:51 +0100
Message-Id: <20200727122357.31263-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we updated the arguments for docker.py we missed a bit.

Fixes: dfae628459 ("docker.py/build: support -t and -f arguments")
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200724064509.331-11-alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index a104e9df281..9119dff97de 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -78,7 +78,7 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			DEB_ARCH=$(DEB_ARCH)					\
 			DEB_TYPE=$(DEB_TYPE) 					\
 			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
-			$(DOCKER_SCRIPT) build qemu/debian-$* $< 		\
+			$(DOCKER_SCRIPT) build -t qemu/debian-$* -f $< 		\
 			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
 			$(if $(NOUSER),,--add-current-user) 			\
 			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
-- 
2.20.1


