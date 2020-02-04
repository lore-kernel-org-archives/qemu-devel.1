Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C68FC3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596192166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlqRYHxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596192166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36083 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz38s-00044B-Ex
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37l-000280-Fp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37k-0002lS-DN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:37 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37k-0002hz-5q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:36 -0500
Received: by mail-wr1-x42a.google.com with SMTP id y17so24423967wrh.5
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=estnIhq8TRY8F3NiEtejikn6q73HGRAUwgi56gyOW/4=;
 b=rlqRYHxScAGaIcbp/SXoGD7e3FboDOgJkuX8+yXDIm/4mXgVIpL3ibK4ezsuCOT997
 lWlYNeQNTyIuBK9fnx3mp8cwrHPAqWOpEz109STjxEr1X6cv980kcV3ZPvDCL/WuFd9e
 ZOEShVvqWw3x/1PDyqEtAWQN7qnCoUZpkUAWiKt2kwERveX35Rr2QGXpccWiujeUlL1h
 MGn/zWwAntbiSOJCnWtDAE5v6yjQlwTZq5lMSq0iVuquSqCxl2yI7Zm/haSLec0ygoAS
 QoaoW+IXoep/lmy53kljxZ8cFonqwikWhb8Uk7XBtER6fgTUR9KBiLiuV63Q7xPZdAdB
 9ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=estnIhq8TRY8F3NiEtejikn6q73HGRAUwgi56gyOW/4=;
 b=VuCLtypX0P2xbPMITqSTohTteZoH3p9X3oBjcNTcAbwt3k8Eg5V9amJbN2fNEqFo5K
 cYkUPgWjaL5/1U3L53W9v5xhG8hwrPwrTYnMR+rDn69L4Q56ASPQMlyvpCxUWWpKp+aV
 T/uE0KZ9hk79aNUmSK8N4V25Ri21CC+S8J5RjSTQRGAHHZBPHm4wPntJK6UwsqHAJBKw
 VhCwCDraqj0/NoTjycByyouK6WtMCBSD5KUZqW1q83jbEcHddCZXcCeClGNUV5FpGFzC
 E9QgESQgjR7Oi4E9W9RiTr7WqZQNVGY+2UCmeYcBT6kq194rEPNnyLWfSMS8GVcpHhCj
 osrg==
X-Gm-Message-State: APjAAAWtbgdZ1bqjjlK+wuUN/yr7WLNhFsOYzVWZaIeccaAA/FaSGrS+
 2sLgNgSccc2Z4aoppZ5K+RMdzg==
X-Google-Smtp-Source: APXvYqzz63TOAgei7hj3xt/wj2WQafpRXy5lXnWfKHpppjgj6qqFLEEXTGoOq0zpXoA9UNvShHCf9A==
X-Received: by 2002:a05:6000:10d1:: with SMTP id
 b17mr20774408wrx.298.1580841635181; 
 Tue, 04 Feb 2020 10:40:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v22sm4698930wml.11.2020.02.04.10.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:31 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADE961FF90;
 Tue,  4 Feb 2020 18:40:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/16] travis.yml: Install genisoimage package
Date: Tue,  4 Feb 2020 18:40:15 +0000
Message-Id: <20200204184028.13708-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The genisoimage program is required for tests/cdrom-test
tests, otherwise they are skipped. The current Travis
environments do not provide it by default, so let's
explicitly require the genisoimage package.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200110191254.11303-2-wainersm@redhat.com>
Message-Id: <20200203090932.19147-5-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 1ae645e9fce..e75c979b6c5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -51,6 +51,8 @@ addons:
       - sparse
       - uuid-dev
       - gcovr
+      # Tests dependencies
+      - genisoimage
 
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
@@ -383,6 +385,8 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
@@ -412,6 +416,8 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
@@ -441,6 +447,8 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
-- 
2.20.1


