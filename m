Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188EDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D711C227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLB1pR0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D711C227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtOx-0000d3-IW
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNO-0006ko-88
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNM-0000PX-QU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:49 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNM-0000IW-GU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:48 -0500
Received: by mail-wr1-x429.google.com with SMTP id d16so5456741wre.10
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a5LpjEJFSdAakd089VcyJTqDappqhvSCYXY3Tn+aHt4=;
 b=JLB1pR0z6pXa9MsWupB8kxMxDQ7WAB2749fb4KrRY7OSNW+LPkJr6484vIouretpX+
 qPFA6XimSYGz4tuC7nEaSM6k2DG4pLG2s1cZb3vpAfkHeTghVeGEEJY1pvLx5gAsBEK0
 bm/23ynRGfjPGrKUeFkbkEs3pzZ9iEpig2KSugVvq09dO2XxCm1orwO/oUJnxmELhb+I
 ioMPrcDC/NvdqjJXWERhbtplmpb2El+8s4jFtKCmjgUN3PEzzxQVJZNQu1+HOOBBUuLq
 M78m2RaqYAI/LWdB69VmEt4Sujc9MVgYcWQ2RqsiCjSnXZCwduZDMTG4WZhI0vVd3/CY
 4JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a5LpjEJFSdAakd089VcyJTqDappqhvSCYXY3Tn+aHt4=;
 b=iqys0xv71qBRvb635VJEmcuH8GcaBOiBiyrGVAS+0EtMtXbwHQ1ZDKusaL4IKrzHzl
 vNxCIu7nuB69PSTI55ZhALIXfT/dC1TPiuNu7PyoamvM8qTr10jXZiNANvRnJCeUCSX3
 DyUwhlAEVEs9J3up/mNM4PTqm8550cmRCU8D6VqCj+cAS3KHOIs939p4ihXNhkdvOIdw
 Fw7CnWg8ZltrrTyjyXZXfSIFmC3EWoq7K5Wm+lkifxZIKe8XOABUCq0xbB0rzZTDUVi+
 ZFQsw+LBlWPAHAmThCuUSpFRhNwbTocgVVFqel126FMrZSPAj1AQDTbJBvLJ2uOjQCO0
 qXnA==
X-Gm-Message-State: APjAAAVr2ZKHMon5tKf8tQlRyaRxwhlObZD7hkJ7pADXqTDM0gmc/eK6
 P0qWU5gkbSmpzEUoubQwmZVx6A==
X-Google-Smtp-Source: APXvYqzMGzsGwiYfeCsSR22ou7EQybdC9h84mbhWHRZxIXuRgGYY/9gGy+imJ7dUkoHGfbdFBCTqyA==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr8253423wrw.373.1576752587305; 
 Thu, 19 Dec 2019 02:49:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q68sm6750163wme.14.2019.12.19.02.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 427E81FF99;
 Thu, 19 Dec 2019 10:49:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/25] travis.yml: Enable builds on arm64, ppc64le and s390x
Date: Thu, 19 Dec 2019 10:49:18 +0000
Message-Id: <20191219104934.866-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Travis recently added the possibility to test on these architectures,
too, so let's enable them in our travis.yml file to extend our test
coverage.

Unfortunately, the libssh in this Ubuntu version (bionic) is in a pretty
unusable Frankenstein state and libspice-server-dev is not available here,
so we can not use the global list of packages to install, but have to
provide individual package lists instead.

Also, some of the iotests crash when using "dist: bionic" on arm64
and ppc64le, thus these two builders have to use "dist: xenial" until
the problem is understood / fixed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20191204154618.23560-8-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 15946293ff3..b68566b1fe9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -354,6 +354,92 @@ matrix:
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
+    - arch: arm64
+      dist: xenial
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libbrlapi-dev
+          - libcap-ng-dev
+          - libgcrypt20-dev
+          - libgnutls28-dev
+          - libgtk-3-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - libncurses5-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libpng-dev
+          - librados-dev
+          - libsdl2-dev
+          - libseccomp-dev
+          - liburcu-dev
+          - libusb-1.0-0-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+      env:
+        - TEST_CMD="make check check-tcg V=1"
+        - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
+
+    - arch: ppc64le
+      dist: xenial
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libbrlapi-dev
+          - libcap-ng-dev
+          - libgcrypt20-dev
+          - libgnutls28-dev
+          - libgtk-3-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - libncurses5-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libpng-dev
+          - librados-dev
+          - libsdl2-dev
+          - libseccomp-dev
+          - liburcu-dev
+          - libusb-1.0-0-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+      env:
+        - TEST_CMD="make check check-tcg V=1"
+        - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
+
+    - arch: s390x
+      dist: bionic
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libbrlapi-dev
+          - libcap-ng-dev
+          - libgcrypt20-dev
+          - libgnutls28-dev
+          - libgtk-3-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - libncurses5-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libpng-dev
+          - librados-dev
+          - libsdl2-dev
+          - libseccomp-dev
+          - liburcu-dev
+          - libusb-1.0-0-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+      env:
+        - TEST_CMD="make check check-tcg V=1"
+        - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
 
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
-- 
2.20.1


