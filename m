Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36193CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF45721D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xlg4bHZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF45721D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO60x-0003zj-KR
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Xl-0002FU-Oa
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Xk-0000nR-Gk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:46:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Xk-0000mv-AA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:46:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id g24so3395494wmh.5
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KBMNgmBi7/k8LJ63MGoqOawSxFhttAR/bJdyMWQnEAU=;
 b=Xlg4bHZE5mRgiBAbCk2n29eocBKhzSvFB8l2fHZczn+Ext9G254ihnnb1ztcCMxE56
 bSBhtZ09sTYDlqe+0ySi4zuPihMgVMlOyE/4KVDLf819epGk+zN9VUSN0VAEu7cmD0JP
 E4YIXTKtHVb4wxl1xV4gJl/AenAsNZdXkuEw+hc4gAnYJtE3z6EPJDorRLsu60gpFQRZ
 wGG7k+BW6HIZsvh3hooZme7IZKu2/B+0bupYSiCK1rqSrt2dPl1otCJm7zJpPFA1x92T
 qBXE/jYNRhbxSVk5gfqIYRpaj4JhCKwR2Ienidhh2Y6OIa68y2m2FABxxzLyVlmfLr45
 QUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KBMNgmBi7/k8LJ63MGoqOawSxFhttAR/bJdyMWQnEAU=;
 b=DSxo+pX2hChX6fZuPCNtQvjmt8SIkHMer+y7cph4FBL+DO80aOaUHSCp1Iyjov+w/y
 0B2MW1tYwPiunCA+espordxRldkzw59pItL0mbhjtIfk3deU1cASQkC4U9tywJyMh3At
 EXjv0sMaJ7H/DIQCBh3hoM1FOZAiTAHjiKxKNfMcxSvcKvMAGKzWNKarULUjGy/xlbnS
 W3/0qH2VaHjRrckcq7EFoS7x+5HPi97U9vRcfiOftcKoJpYczof7fwrQbPgxb3L05ErD
 hGkMukZTAEOQUHkeYe9ToCcoOi3rTQxgPw49F4zoHnv6I7vGvNQkibmRraavNIOvGAQT
 vLzw==
X-Gm-Message-State: APjAAAXHOUbkFQUnBtfR2smLjPnYUhWngsjeSXLQu77TKMfhbYLTjge0
 QAH3G4QDXkcsTRzF4kcO39pWlg==
X-Google-Smtp-Source: APXvYqwpmkBhWDuXLeN8EhHUllm+7qQylSqcRAisQ+EA1R3ZlRyeeQE9SK7xAW/lOuiGh52HsO378w==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr5070254wmc.29.1572032798967; 
 Fri, 25 Oct 2019 12:46:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t185sm2588072wmf.45.2019.10.25.12.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:46:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 801991FF9C;
 Fri, 25 Oct 2019 20:37:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 12/15] gitlab-ci.yml: Use libvdeplug-dev to compile-test the
 VDE network backend
Date: Fri, 25 Oct 2019 20:37:06 +0100
Message-Id: <20191025193709.28783-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The libvdeplug-dev package is required to compile-test net/vde.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191016131002.29663-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ed8067f5cf9..be57c6a454a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,7 +5,7 @@ before_script:
 build-system1:
  script:
  - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
-      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
+      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
  - ./configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
       cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
       mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
-- 
2.20.1


