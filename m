Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1F4C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE02206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAPOYfeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE02206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbt6Y-0002C0-Hj
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2J-00062N-VO
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2I-00026j-1v
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604873985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmyNUmooLdVHry+yJmzGfzNT00h5DfYz55kuF8g/yME=;
 b=FAPOYfeULjodTSIkVzms+cywRYtDj1H2AxF6fYnHgleFWSIWNdvC5NlpwUdnrA4YAjigk0
 Xd25TG/YwAtib86m1HExCQ6yT309jV+spdKWt4OBL1vBSIOLMLTKqHjB0Ygnig4q1Cg/qe
 Ft+RWaJhmZF+KOdR1v8Ay3J6iG1xz4A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-plahqUebP1qA93M9FehATg-1; Sun, 08 Nov 2020 17:19:44 -0500
X-MC-Unique: plahqUebP1qA93M9FehATg-1
Received: by mail-wr1-f72.google.com with SMTP id e11so3478454wrw.14
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CmyNUmooLdVHry+yJmzGfzNT00h5DfYz55kuF8g/yME=;
 b=gdYespyv2pU7t1mCKTfsVWRzdEqM4tAijCvMG18jbUq5WOX4vBYlJoxe7XHkngsuTG
 iZc2ZiNKUByU5GjHH59JJkrHbiEgCYy0qykLXCyS6j+48XD46LXcuanDvgNZWWksi0fU
 Prw1ZWNyHXPts++PYPsh2AF4Swwgbkhiu3B27h083+Kq56iUmzqKf5Q7ozxNu24HlsUj
 +kqB9y9uazuGm1yKTsLpoti+tuSAXvGGiozyDdPg1OYihErXQ9pmMHfQj4z3ACCFuS6P
 Q44XyugMBC3RXL7CsTfKo/W9afLLrLJu2T2vq5iIdAA71A5ejyZS7w8k6WLYGOGnfkZr
 /IOg==
X-Gm-Message-State: AOAM531tJoqI4xRPCZdtTSebguQ2n9EyPaWX3/ZE0hi+/HH124LGqVHB
 aFc04QdDeL0W1TKmGyv3ErvxwLuiLq5sRawy5I6f/AxW9cA5luUcSK7z9G67GKKAqkuPWsdM9zi
 F5HYuMZ3GSvg9jrQ=
X-Received: by 2002:a1c:9dcc:: with SMTP id
 g195mr11040686wme.113.1604873982715; 
 Sun, 08 Nov 2020 14:19:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8rbSR+GAEiCWBZ80Rwovk7pIKZSNYDTFyW3j6X3abJ5ASKZlFvvvDT2ACOZ/VU/1nDSh7qg==
X-Received: by 2002:a1c:9dcc:: with SMTP id
 g195mr11040664wme.113.1604873982495; 
 Sun, 08 Nov 2020 14:19:42 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l16sm10878402wrx.5.2020.11.08.14.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:19:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/11] gitlab-ci: Replace YAML anchors by extends
 (native_build_job)
Date: Sun,  8 Nov 2020 23:19:17 +0100
Message-Id: <20201108221925.2344515-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108221925.2344515-1-philmd@redhat.com>
References: <20201108221925.2344515-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 15:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'extends' is an alternative to using YAML anchors
and is a little more flexible and readable. See:
https://docs.gitlab.com/ee/ci/yaml/#extends

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5763318d375..a96e7dd23e5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -13,7 +13,7 @@ include:
   - local: '/.gitlab-ci.d/containers.yml'
   - local: '/.gitlab-ci.d/crossbuilds.yml'
 
-.native_build_job_template: &native_build_job_definition
+.native_build_job:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   before_script:
@@ -68,7 +68,7 @@ include:
     - du -chs ${CI_PROJECT_DIR}/avocado-cache
 
 build-system-ubuntu:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: ubuntu2004
     TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu
@@ -99,7 +99,7 @@ acceptance-system-ubuntu:
   <<: *acceptance_definition
 
 build-system-debian:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: debian-amd64
     TARGETS: arm-softmmu avr-softmmu i386-softmmu mipsel-softmmu
@@ -130,7 +130,7 @@ acceptance-system-debian:
   <<: *acceptance_definition
 
 build-system-fedora:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
@@ -162,7 +162,7 @@ acceptance-system-fedora:
   <<: *acceptance_definition
 
 build-system-centos:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos8
     CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
@@ -194,7 +194,7 @@ acceptance-system-centos:
   <<: *acceptance_definition
 
 build-disabled:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-attr --disable-avx2 --disable-bochs
@@ -219,7 +219,7 @@ build-disabled:
     MAKE_CHECK_ARGS: check-qtest SPEED=slow
 
 build-tcg-disabled:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos8
   script:
@@ -239,7 +239,7 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
 
 build-user:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system
@@ -249,7 +249,7 @@ build-user:
 # we skip sparc64-linux-user until it has been fixed somewhat
 # we skip cris-linux-user as it doesn't use the common run loop
 build-user-plugins:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user
@@ -257,7 +257,7 @@ build-user-plugins:
   timeout: 1h 30m
 
 build-clang:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --cc=clang --cxx=clang++
@@ -267,7 +267,7 @@ build-clang:
 
 # These targets are on the way out
 build-deprecated:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-docs --disable-tools
@@ -292,7 +292,7 @@ check-deprecated:
   allow_failure: true
 
 build-oss-fuzz:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
   script:
@@ -310,7 +310,7 @@ build-oss-fuzz:
     - cd build-oss-fuzz && make check-qtest-i386 check-unit
 
 build-tci:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
   script:
@@ -335,7 +335,7 @@ build-tci:
 # These jobs test old gcrypt and nettle from RHEL7
 # which had some API differences.
 build-crypto-old-nettle:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos7
     TARGETS: x86_64-softmmu x86_64-linux-user
@@ -356,7 +356,7 @@ check-crypto-old-nettle:
 
 
 build-crypto-old-gcrypt:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos7
     TARGETS: x86_64-softmmu x86_64-linux-user
@@ -377,7 +377,7 @@ check-crypto-old-gcrypt:
 
 
 build-crypto-only-gnutls:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos7
     TARGETS: x86_64-softmmu x86_64-linux-user
-- 
2.26.2


