Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C41C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E923E2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoBgeNUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E923E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaivn-00016C-Py
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairX-000490-Ls
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairV-0000Gv-Cx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604596548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmyNUmooLdVHry+yJmzGfzNT00h5DfYz55kuF8g/yME=;
 b=PoBgeNUreV6K3lG4n4rlCEj9wtCZZ0DOwqKTvaL6y1msHkmDL/ZncK9FrCRtrmt8u1pO0L
 Mr/ljNkAykSO0yvVizV43mv+sgkEnWcZiytXa2txWi+/2sdHiH/uwyFFWPkVcorHG0G4DF
 AwHFNq5rAEAV9g5a1DJD0bJDCblNOQw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-PKIK-0MnOpiDQrtaOP7AVg-1; Thu, 05 Nov 2020 12:15:46 -0500
X-MC-Unique: PKIK-0MnOpiDQrtaOP7AVg-1
Received: by mail-wr1-f72.google.com with SMTP id 67so263205wra.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CmyNUmooLdVHry+yJmzGfzNT00h5DfYz55kuF8g/yME=;
 b=M6UeEWFfzb0l4rjs/RH0SH9X2WzmP+tMls+eHl/J6U0uQtnIQUwuXJpp14K50soprN
 u5nUmXsOPMs6QtuE+tduDE3UuOPwwt/wD0JqbQ73KvU7lsoR1jP0BjPqpCJBwzFjld/2
 gwIcXD34bgz9MOXa4YVePjpqJ6Z3YgBY2P0CjeEyAAANaNgCRZ/IywKJcbZDeUCmfIH1
 5qM+wV2iv3FM4fV5KvP9Oy0G0f4YYrRiOSM30cf7MR7GNJTfsKm6+8Io/4wAEjy1FUqE
 21GqNgxrEe7WN9gMBY6S6gOr42zaDC3RZWUGhIroY9juhN03hDfeIs26w4uMhWVgFaUw
 6zbA==
X-Gm-Message-State: AOAM533SZFKEigtxHVYghvJo8anq04AiP3I4t4j4EYpJXUDNywdHNp9M
 PVk8md2uj70J4Z0wNP0Q1MjMXtGEpCkBMlbPyGYdCRYFd3uTS2VFI/tmAx8YAXEIvRhiIbapFrW
 DLfwH887uR7V0+7E=
X-Received: by 2002:a5d:6092:: with SMTP id w18mr4256490wrt.350.1604596545271; 
 Thu, 05 Nov 2020 09:15:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/uq6MnfTfrzacvgPK9uYpil3EQvf5F2HcB1I0xiqt/pDgA1u9QWZNcDVLWPn9iFqaIHmzqQ==
X-Received: by 2002:a5d:6092:: with SMTP id w18mr4256473wrt.350.1604596545112; 
 Thu, 05 Nov 2020 09:15:45 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id p4sm3789551wmc.46.2020.11.05.09.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:15:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 03/11] gitlab-ci: Replace YAML anchors by extends
 (native_build_job)
Date: Thu,  5 Nov 2020 18:15:18 +0100
Message-Id: <20201105171526.3763499-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105171526.3763499-1-philmd@redhat.com>
References: <20201105171526.3763499-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>
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


