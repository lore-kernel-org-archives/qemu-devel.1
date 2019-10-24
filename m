Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBCFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971E32084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wx9z8z2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971E32084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaXG-0002Bt-8k
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGd-0002Ms-6V
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGc-00048Y-2D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGb-00048B-Ra
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id c22so2033864wmd.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8nl0ae5rsoRao3+wpmvjS76Ap5om+CAEINsLMlT9o4k=;
 b=Wx9z8z2QgR6aZ+SdFUK3zJnOeF1azB18WC7vYhzIOGwRunRo0FKEAHaYkdZO2Xe45h
 F3xKzd/Z6q5bVDzKSTGyqfsh7aOk7UtDXn6VgrOWL/rkNkElDwd8LZME0zlUYGS3h6jq
 TnJUJkfV9tOW1/ulQoS0zDxZUbpD0WKz1XU7jlzerTKpSIJsFZKnXkPZBbebrhXdxVHA
 Bohr8O2VOC0crXIxdi0d7lzBP0cb68UQaP14JZnTJce4NfoCyHGknL9+kV6HkC/D/9Fi
 6sd1KE81hJ0G6ukSHvsmNPuqqhp+aE14QTaoVduRhogMvnz4sEoRKWp70JRXjEVGPFcX
 X9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8nl0ae5rsoRao3+wpmvjS76Ap5om+CAEINsLMlT9o4k=;
 b=L17k570J2242KNjtqwtPcwTGdWA1NXpXEGfON1R44dDXJyRzgiWVpilbbkg5PGkHKf
 ft4TfjKFRUcvC+rcSXQFq3YTL/Kvh8pKwN4J3SJMqwCNmi8DfvTtMuX2a1Mh4umvr4am
 bA2qDIPVNtE582NEfmCCIk+JaSXzMW8uNxHKwu5jbJPndH+b6jd6J6KflyGnwEkgCX2A
 Kjvr4B5zFfmVLtaRobz9c4dL5an8iVtCtyLRA4eGDLWb2i1ZtZPXplhudhSUAjbjpovk
 BHJV9DQLzsFCCAgQbhBqCVHKPf5O8Wk1bMdkA4pUesLIRoRTPYkfE4ERV9dCPxUI3mML
 swgg==
X-Gm-Message-State: APjAAAXFYoDtzH6lH0AORee/vNqF62B12rlKJtVMRafSxcFtDIn2tc2j
 lWHsxXEhUHSCo2vtm2GrYfsOxQ==
X-Google-Smtp-Source: APXvYqxVEV1i47P2pFr9Zs1Sm8uaxtOa11JJ3X9/urdagtmdRVK5uCECQchaTrBHrxRxOSYeuFYSHA==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr3951979wme.4.1571912572726;
 Thu, 24 Oct 2019 03:22:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l14sm9798657wrr.37.2019.10.24.03.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 987981FF9E;
 Thu, 24 Oct 2019 11:22:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/17] gitlab-ci.yml: Use libvdeplug-dev to compile-test
 the VDE network backend
Date: Thu, 24 Oct 2019 11:22:37 +0100
Message-Id: <20191024102240.2778-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The libvdeplug-dev package is required to compile-test net/vde.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191016131002.29663-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


