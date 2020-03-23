Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D6C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B5E20722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ucQMyWeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B5E20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPpM-0001A1-ET
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjj-00016R-5V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjh-0002VR-Q4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPjh-0002Ut-HD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id m3so142358wmi.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RvjIJhPsdKWWNXjYUSDeq/ngJaUqsOKcgImX80kKZUM=;
 b=ucQMyWeFRcD4yd5Vj4eRVneYa750CMSWIRXfWumPLv//Xp2PISDOOEUU2hurpTMmnu
 1zDUt/LCHi668suhM4807Cd0xh9+DFPoWoZdCZny60BB9xxwQTMFE9KCmvUaMIOFrbTJ
 ILmX2NBxFQExlknsFT2dUJ5TlBPq2ZDviVlPbMCotrIBkyJkfwZvuOmXpTHhMm7oJlr9
 Uj3lTKXRm5ivGDHCBfLOQEteRs/tnAznNNgI3GkdH4A80eaDYvZfQFbGtlz8/49jo/xu
 X/5ugeyJlou6FsZBT6GI3Hkw4bQy6WTrbN16LktdrjNUcaz1zfvpY2S8u51sdnff5j+c
 A7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RvjIJhPsdKWWNXjYUSDeq/ngJaUqsOKcgImX80kKZUM=;
 b=g2vWIbLhAR8pRMPCrG+a/KTdvaeA7lXyTJbs6IfzcRxr8tb8u9oHgNrbqtdWIaQhCb
 nV30BTRI3RZ8GcW9+d4ElRRULdy+mqenoMKQc7+XwtY8C9d8M3EGch88l1HT27DL3t17
 2G6O6jgc5MPTIJJOTDfMs6G7Yk+3U5HqanU9ENKzMj6uwfCy4y8L7UsoXWUmVHEWbGeh
 CQmYuXeIc7Zfw6YafGVxiXVF+sQokIdHSBStIcOCVEmyRuei+w2JwuVFWtCcUkSOYj6/
 G9LHJRz18eXL1YdX5AHAK7UvXsVwH5jGA2/4QtRJsY2nO6mQNJrdPp7qHRoNqhNAhPxl
 B9xw==
X-Gm-Message-State: ANhLgQ3AXuUzdwkCVXRuuft1o89wTlAwstT6lc2d9AXSEZQ0IiQzBku5
 etnfXpxcJux4H3ic3LhZJQOjEw==
X-Google-Smtp-Source: ADFU+vvTXPuAW62P0H+70cobdY+W8/40wMhg7xPRQHAFlKfrjvwdr53Llo3qRY5k3SV8oGoLERWpDQ==
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr20546wmf.118.1584980132418; 
 Mon, 23 Mar 2020 09:15:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k84sm101549wmk.2.2020.03.23.09.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1A151FF7E;
 Mon, 23 Mar 2020 16:15:16 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 11/11] .travis.yml: Add a KVM-only s390x job
Date: Mon, 23 Mar 2020 16:15:14 +0000
Message-Id: <20200323161514.23952-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
References: <20200323161514.23952-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Message-Id: <20200322154015.25358-1-philmd@redhat.com>
---
 .travis.yml | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

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


