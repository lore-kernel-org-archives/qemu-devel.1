Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB7C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F732083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgi/Ghxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F732083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtcZ-0007xJ-TW
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtUD-000260-LL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtUC-000104-EQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtUB-0000yC-WF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id e9so1477673wme.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pz4+hj7n/yl99ow8yOnM+Gbx/Hl9NI3JBuBBYB7hHVY=;
 b=vgi/GhxxGhhqht1b3r3vnllgAroWumGRu8wiJTJ1h04Wc3eXBd+VdLa4oAc0SP/067
 tQU6PAGk40XkUj+hdbO5cRagP8bPB3ZZtF5rUZgLB/aZEjZH36FqCOcW1G3DK0vIhNR/
 q0z9bxEg0wGnyJkWMlOSH8EuN7ZkhFYAzAhWqUNR9GJLJUgMZZ+ToqszI8ZIOICNhRlY
 lNfMl9Wzg1HB81RHIcGbvtIy83jRsbJ2Tg9x5hKs9hsqFWfAv6weQzaKtfmIkFPuMpvM
 +qjsxqDZryc4jN9oo9sDInYDzfnc38uJMBE0EBBczgyPYc66kTXuTrLBJh5ZoV64aWLj
 2glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pz4+hj7n/yl99ow8yOnM+Gbx/Hl9NI3JBuBBYB7hHVY=;
 b=UrG/JBlKE44vHqpEavUB6d4q1E7Ep3EiFwZ5xWbqpYUc8IJHQ65q/vyhA6OXPRkL6Z
 Uge7CYk1mW8U5cr0vINRTBvgrDNzg7KOt+Jp4JPz6mUwYsUdtV/NgtJn7KTESRmVe1PZ
 qjUVjOW2yKo31THHDVlCNbGXOs6lVAC+jFteSexiJnzWXu5jhYj/vNRy/lpseoMc/GOc
 2EjB97jMtymc73CI/f1VOPHU5/hfj/eIhoYyIWTMRjTX1rT4tujp8OY0yBLnwaIEfsYz
 eW6vAfhjg9fddtj62nDb//eyE2y2rPyOGGODz/NgROWAH1HEAS9r+SL+GCg4JZNAXbtJ
 n9JQ==
X-Gm-Message-State: ANhLgQ0OX6bq4QMAYm2o6C3NB6YSY1MGWoeI7/4KTxCKdT/niV/RJMOD
 WWFXNbfZHG5sxFYPbvmNubun7Q==
X-Google-Smtp-Source: ADFU+vs5PznMquO/UxtuYNDI+AmZKF/Ro4tIfkXH33bRy7TVUX1FZZ0+ofxsG7Zxu3+kJuPiepqpfQ==
X-Received: by 2002:a1c:197:: with SMTP id 145mr2495wmb.42.1585332818945;
 Fri, 27 Mar 2020 11:13:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a71sm8654257wmd.22.2020.03.27.11.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B7C31FF9B;
 Fri, 27 Mar 2020 18:13:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 12/12] .travis.yml: Add a KVM-only s390x job
Date: Fri, 27 Mar 2020 18:13:20 +0000
Message-Id: <20200327181320.23329-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add a job to build QEMU on s390x with TCG disabled, so
this configuration won't bitrot over time.

This job is quick, running check-unit: Ran for 5 min 30 sec
https://travis-ci.org/github/philmd/qemu/jobs/665456423

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200322154015.25358-1-philmd@redhat.com>
Message-Id: <20200323161514.23952-12-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 5672d129ec6..e0c72210b7a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -525,6 +525,48 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
+    - name: "[s390x] GCC check (KVM)"
+      arch: s390x
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
+          # Tests dependencies
+          - genisoimage
+      env:
+        - TEST_CMD="make check-unit"
+        - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools"
+      script:
+        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
+        - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
+        - |
+          if [ "$BUILD_RC" -eq 0 ] ; then
+              mv pc-bios/s390-ccw/*.img pc-bios/ ;
+              ${TEST_CMD} ;
+          else
+              $(exit $BUILD_RC);
+          fi
+
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
     # This is the case when release candidate tags are created.
-- 
2.20.1


