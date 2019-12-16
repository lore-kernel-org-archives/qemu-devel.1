Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A270C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3846C206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQmfUJ18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3846C206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoLF-00062n-QC
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoED-0005VF-CQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoEC-0003so-2t
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:53 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoEB-0003q0-Sp
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:52 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so6725596wrh.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GrCJ79KHRD7xwW0klJRYdHcFwv9zhD+Xk92UyYa9i8U=;
 b=LQmfUJ18URAGbCcXYCFtS/u44W9r75W7rFn4HJd3llxfmVupYvG/5cbKnCE0QxeW3p
 CC3L0lSn0YihZHVrs7dgC96577ptJWvH/X3ZCLo7qB/hpl6T5Ls6l8wUD2bk/quC9Pzd
 4QrgryvkwmCOtd7YFbcO0Qn5wDH6sJae9gwurPpq32o9EwCvfamsTirOnTkXpWudyqj7
 vJL6sx7v2e8NUNeyV4MDBAAkHwqWMnCfajk4Dk3WQmXHTkz2ZIb9goWvAUPHnJrLaNjm
 nnkqqVDzxRUwzPla/mgwzgamU6lERBrPUnwkp5RtrxV957rS2LkNOsCYAo/Jl4fP/5v+
 5vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GrCJ79KHRD7xwW0klJRYdHcFwv9zhD+Xk92UyYa9i8U=;
 b=M0t8oyjb5FC7fcjqb1YY34nqMRA0rJlKR5EMDmKTMKoyJCZaHPBUZXBrkzdEz0LSXN
 mXnWn/9G7Q3+fcQwWwglJzecIO8Snqnxwip7hSm62NMDdYHBKTynDiwPcMsLF1/om7JB
 yK0lmqUdG9z+Rhk25Frf2aBvlpiTNUhEy+mHVL3CHOT+jaZNggRS+/sJsF87Prg0CI6+
 pCiutNc7oAAxlKIlkO50Urjb2iQwm9Ly68Bc/cAJ3w5SXqx8fMHwHkaFAxt24aw7AdYb
 fZTaSQoj906DmVwMUiSobfE/iEz5i/COg27RqjxCdCmRP/D7Rj4UGyzBSPT7HCi5sIRT
 KJQA==
X-Gm-Message-State: APjAAAXwpSdXboUOSjGX+vaqnjgUEuRYBYbBg0Ffm/WGjxeukkbwceW3
 kSsa2IpI4tqqQ7CUqGxPHKTmwA==
X-Google-Smtp-Source: APXvYqwLMnYO1anV2+EYAFyYXU9dmfcSZtYGN9rdECj9g5biTchNJIxikcXEK75m+rgfnUFCQ7/Ulw==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr31213226wrr.265.1576494470787; 
 Mon, 16 Dec 2019 03:07:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b10sm21446089wrt.90.2019.12.16.03.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:43 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE8F41FF99;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 09/16] travis.yml: Enable builds on arm64,
 ppc64le and s390x
Date: Mon, 16 Dec 2019 11:07:25 +0000
Message-Id: <20191216110732.24027-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net, David Gibson <david@gibson.dropbear.id.au>
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
---
 .travis.yml | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

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


