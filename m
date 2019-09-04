Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087D6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C627520449
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9PHPaoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C627520449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5clD-0005cr-GL
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3x-0000xo-5k
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3v-0003WT-L4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3v-0003Ue-Cu
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id t9so220402wmi.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IYl8oq3wgcFADu2TXzuhJPsVZA2wiZ1eKvheGFBu/QU=;
 b=E9PHPaoFW4ANjCOcJIxMFuDNhV5Db+UjQcGlh+cj//DTtHBLdjUxkYXlcJY9fNO7zm
 vUXWZv1x7YSfmftO5oLbBxHITCocA26g0qFAaX75WHdOB85zFO7v/pIA5BeWXOH05KMl
 kPjx/1nVSHb8+SaRa907bRjNX7dGhCXy0OcZ7UM+CDnQH2OPe9N3Jp1JvO2czS+Fm8BX
 ojttsb8EpYpWSLzFVa1Tiwz1fNZygOeAn7lGFr1+xBKxTRSq7ixhNWpw8ReUB+mNyS07
 wwLZ5gWADK8ZoGo2zzj2rDQnqIkP2oaFocRombh8KaNc0+GdS5NJ38kLwtggf1Z2jcMg
 Bg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IYl8oq3wgcFADu2TXzuhJPsVZA2wiZ1eKvheGFBu/QU=;
 b=CGdbTRa+HG/WM47/kIepOlV6VH3F2DRpLgOPwflhVBdRPQ2hKTotfutNcM4+ckerMk
 wlVtwSmH0n1QalJvXUOve13CXNYh1CwNDMVcJ5Jx3jxBVub3CLnYunb+2QpaFDQm74yz
 eOqq46xBCGxjNk+0fVEF0UFFL0X0FWcBJfWpu147QedHRkMRdGOuNheB25WKaI1idLgP
 vEVJxCaAcgaxA/8Bp13g2DGpKP2Gi/u5R0pzhOc9dNlrqlc2mdew2jy0RQqxftTzXsPG
 52vGFj16hHbVkwiPF+mixy4dOV1xIEiYJQ0T2qZvl62urNEqHgCgwNQ3uwS11CEFrimv
 G0Ug==
X-Gm-Message-State: APjAAAVkMeEhQt7dpaJxVWqe0z14qmPGlFXjU4mbdba1UZsXPDKGD2k1
 mvS81MGX8kkITaEG4UUyERlsRw==
X-Google-Smtp-Source: APXvYqwhtj7F9kaG713vGL/IbhPi1cJkZZMOQWmRR+9JEMBB/tC0McoWw9aF6m/vIH1QKq4gJ+dVjQ==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr99904wme.103.1567629570219; 
 Wed, 04 Sep 2019 13:39:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f6sm39064109wrh.30.2019.09.04.13.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 085D21FFB3;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:59 +0100
Message-Id: <20190904203013.9028-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PATCH v1 28/42] tests/docker: add more images to
 PARTIAL_IMAGES when not on x86_64
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This prevents us trying to do builds which we can't complete.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index cb0961a69e4..46f95320e54 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -104,6 +104,15 @@ docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
+# For non-x86 hosts not all cross-compilers have been packaged
+ifneq ($(ARCH),x86_64)
+DOCKER_PARTIAL_IMAGES += debian-mips-cross debian-mipsel-cross debian-mips64el-cross
+DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
+DOCKER_PARTIAL_IMAGES += debian-s390x-cross
+DOCKER_PARTIAL_IMAGES += debian-win32-cross debian-win64-cross
+DOCKER_PARTIAL_IMAGES += fedora travis
+endif
+
 docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
-- 
2.20.1


