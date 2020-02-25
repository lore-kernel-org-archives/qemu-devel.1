Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D12C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A055121744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCZomt62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A055121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a2m-0007Lq-P9
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcR-0005TH-S5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcQ-0007Et-Vf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:23 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcQ-0007E9-Nc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:22 -0500
Received: by mail-wr1-x442.google.com with SMTP id r11so14578166wrq.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tZ+q8+KjTsBsafkEv1L9oog5zVBd33ptYwGvTAYVmPc=;
 b=uCZomt62GTRNms/KFdYdUa9expV/lcusEpBK2bfj1LVOCRKElT2TzJ6BRtB3LFl5ZY
 DrUOc3ORBts+RiGmsdJ0PZaNt8zyRI1yuw0diQ0tF5sygAHW9WgNBVm5Y1IOwLDIh66Z
 mIAJ3ymrQqKQ6TDybDSsl7GP7joKU+NxILEqr8JQaBr9QQv6r0/r5w0insB9jm5URM4o
 gGFm6faDFBjWMSIZsuOoyoMcPD1QSAzXhHlENa1vRZVODKCWczYn8JL+TCLSNt+voqZb
 U3gxD6OJMfkHHFGuMN1VGViV7qZafyjMOZQXDS70LvlNox8UqZZOTiZ2JXJpTyCXb9Xh
 lOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tZ+q8+KjTsBsafkEv1L9oog5zVBd33ptYwGvTAYVmPc=;
 b=BooUwj6iIszZ5cbgesRF1xjxMJ3XJL75yPyOvxCuOrqbTl7pxUObeKsQPsQZY55Qvr
 sbT+0n/F04spDsvW8y19KZGLfny/2hDC07WNfRBva5Zczh79qY2yYllkn1/dHyU6cGv9
 lIT/6hPa9EqeTJuYsORLRH44pzKI64MaPu5MFCBNLSApJqQGNUoF5bW7gjiMa9sUmN14
 VMlQMKu73NF0pP5cuUaXuDfS9H98DTkZ1E31yrFDuf4SiauKTbWS4Lna2cDHIXi7ZpqG
 5R6370ToqZfS1eb54ah7G4RxSzMm/QzTDT7Z9PAdSd2HafX4d6xqaHqWpPbLbSe/ibIk
 b7Nw==
X-Gm-Message-State: APjAAAUJkSwUms+rRyU1FMLBvFnr40SHuPyJDM+a3Br4LxJM9bPuPD4Y
 TrFXjWMaFGsvuEQPaoG9hCqel8H/Kbg=
X-Google-Smtp-Source: APXvYqzN5E1Uu9yjg885wODL/JepL8jrTLGzP2uEBsI6zN3ZzUOEcIHHTPZaHGG5ItzHoNwYBU6Xlg==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr11142662wrw.115.1582634841265; 
 Tue, 25 Feb 2020 04:47:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm3552540wrs.1.2020.02.25.04.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:15 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E1DCF1FF96;
 Tue, 25 Feb 2020 12:47:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 07/19] travis.yml: single-thread build-tcg stages
Date: Tue, 25 Feb 2020 12:46:58 +0000
Message-Id: <20200225124710.14152-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This still seems to be a problem for Travis.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 0612998958b..f4020dcc6c8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -400,7 +400,7 @@ jobs:
     - name: "GCC check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
@@ -409,7 +409,7 @@ jobs:
     - name: "GCC plugins check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-plugins --enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
-- 
2.20.1


