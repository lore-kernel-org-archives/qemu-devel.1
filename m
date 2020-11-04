Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0432080D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC7cpdqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0432080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRZQ-0006b9-3h
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 17:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRXm-0004zv-3h
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRXj-0006un-TS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604529974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsIvdkHwnKN3ES/j+SRDmVheqNblhIaZFAjIMTXNIXk=;
 b=BC7cpdqvDzDi+CKsjfEK0i7j3fwQyYgiLQ+fkDDWLlCrE90wbURWsueKVo27xClApAdW+A
 //3Mi8GJN6uzh3Yx0oFHdQ50DOgLi4Oe8Flfmf74d9jvwAESjkA++vfanKa2aaty1xD+9a
 4X6BSfQllI+Qai6rFs+W65pqaU1lE2Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-nmgzz7oxOGSpHiV1nw2yPA-1; Wed, 04 Nov 2020 17:46:12 -0500
X-MC-Unique: nmgzz7oxOGSpHiV1nw2yPA-1
Received: by mail-wm1-f72.google.com with SMTP id c10so1808348wmh.6
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 14:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vsIvdkHwnKN3ES/j+SRDmVheqNblhIaZFAjIMTXNIXk=;
 b=Ps3lQL0uXbWxsym37rh+sADA5dk53UigzlrjuEg+TL3amxFyLUzX04G2YQIyFmySNt
 XOZhQ/WFqs216YKYnCYz9apccFmmFuaKclirOdH9mWPriNCm/QngzHVVV9tXjDFF51ns
 p9Lr3wqKAvssKw/Q1MQ/ssRqQq7xOOMcmzqgawKffbqLvKbHg4kWSy9ZOmxPl3mp64y8
 NXFTNt31WT0rg3FNCdKZgWOYwpH3ybXKZffOxY+h95O/TiTl0f0vewIxemff+8k2l4PU
 Wr/gyOC5nmd3aUmm0gxfzP4jXWAmgQo3BWM+KkgvlRZxKhJTOpHtng/yjFmIVMX9cGKF
 9rWg==
X-Gm-Message-State: AOAM532NXycaBS4lrQjipt0eQx6zPG1drXtiEY+COIQReGCT+qBJxLxP
 TUADaEn2zCDwxi6Tv9gnSpu4csqQzQxCXw3xWjTT2HDTw9yPuI98PZo0jVQdHDjt+IJLx31Mq23
 okxKeQVO0s9j9DQY=
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr5756194wmf.96.1604529971300; 
 Wed, 04 Nov 2020 14:46:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3sDhuJuuobcSW+Fw6a4iU+c/lDx9jzHthNB2Hi4OpfK0MQKD5Q5ir9eznjmIGZAKG9NlAZA==
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr5756179wmf.96.1604529971141; 
 Wed, 04 Nov 2020 14:46:11 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t74sm3778774wmt.8.2020.11.04.14.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 14:46:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/9] gitlab-ci: Replace YAML anchors by extends
 (native_build_job)
Date: Wed,  4 Nov 2020 23:45:51 +0100
Message-Id: <20201104224558.3384595-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104224558.3384595-1-philmd@redhat.com>
References: <20201104224558.3384595-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index 3b15ae5c302..ff3a8bd58cf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -19,7 +19,7 @@ include:
   - local: '/.gitlab-ci.d/containers.yml'
   - local: '/.gitlab-ci.d/crossbuilds.yml'
 
-.native_build_job_template: &native_build_job_definition
+.native_build_job:
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   before_script:
@@ -74,7 +74,7 @@ include:
     - du -chs ${CI_PROJECT_DIR}/avocado-cache
 
 build-system-ubuntu:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: ubuntu2004
     TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu
@@ -105,7 +105,7 @@ acceptance-system-ubuntu:
   <<: *acceptance_definition
 
 build-system-debian:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: debian-amd64
     TARGETS: arm-softmmu avr-softmmu i386-softmmu mipsel-softmmu
@@ -136,7 +136,7 @@ acceptance-system-debian:
   <<: *acceptance_definition
 
 build-system-fedora:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
@@ -168,7 +168,7 @@ acceptance-system-fedora:
   <<: *acceptance_definition
 
 build-system-centos:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos8
     CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
@@ -200,7 +200,7 @@ acceptance-system-centos:
   <<: *acceptance_definition
 
 build-disabled:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --disable-attr --disable-avx2 --disable-bochs
@@ -225,7 +225,7 @@ build-disabled:
     MAKE_CHECK_ARGS: check-qtest SPEED=slow
 
 build-tcg-disabled:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos8
   script:
@@ -245,7 +245,7 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
 
 build-user:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system
@@ -255,7 +255,7 @@ build-user:
 # we skip sparc64-linux-user until it has been fixed somewhat
 # we skip cris-linux-user as it doesn't use the common run loop
 build-user-plugins:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user
@@ -263,7 +263,7 @@ build-user-plugins:
   timeout: 1h 30m
 
 build-clang:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
     CONFIGURE_ARGS: --cc=clang --cxx=clang++
@@ -273,7 +273,7 @@ build-clang:
 
 # These targets are on the way out
 build-deprecated:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-docs --disable-tools
@@ -298,7 +298,7 @@ check-deprecated:
   allow_failure: true
 
 build-oss-fuzz:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
   script:
@@ -316,7 +316,7 @@ build-oss-fuzz:
     - cd build-oss-fuzz && make check-qtest-i386 check-unit
 
 build-tci:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: fedora
   script:
@@ -341,7 +341,7 @@ build-tci:
 # These jobs test old gcrypt and nettle from RHEL7
 # which had some API differences.
 build-crypto-old-nettle:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos7
     TARGETS: x86_64-softmmu x86_64-linux-user
@@ -362,7 +362,7 @@ check-crypto-old-nettle:
 
 
 build-crypto-old-gcrypt:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos7
     TARGETS: x86_64-softmmu x86_64-linux-user
@@ -383,7 +383,7 @@ check-crypto-old-gcrypt:
 
 
 build-crypto-only-gnutls:
-  <<: *native_build_job_definition
+  extends: .native_build_job
   variables:
     IMAGE: centos7
     TARGETS: x86_64-softmmu x86_64-linux-user
-- 
2.26.2


