Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48786C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BA220732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG7uL1K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BA220732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOT2-00057B-CP
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnORv-0004A5-8a
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:33:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnORt-000281-5d
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+C3phPrrj7sLxFUe/oknyaioR8bFPciwI/iQ7dAlpo8=;
 b=SG7uL1K0oGqL+PgZQ+R06VZWhSqQ5OBemInlMWy1ClmzcGhaAs5AvOag2w6PPAKEESrZ3N
 XyG1ySH2j59q4in+bPVd1rGhCgBcmxuO0PBGX1il72UBirY9buRiiTHEWhOMVvB6uvSMF3
 I3qXjjSKM8y93mdqpn2Pg4e+zJrnins=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-QyGARkk-MfiMZsIc9NQhTg-1; Mon, 22 Jun 2020 11:33:26 -0400
X-MC-Unique: QyGARkk-MfiMZsIc9NQhTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A14218585A2;
 Mon, 22 Jun 2020 15:33:25 +0000 (UTC)
Received: from domokun.gsslab.fab.redhat.com (unknown [10.33.8.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22D4460BEC;
 Mon, 22 Jun 2020 15:33:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 1/3] gitlab: introduce explicit "container" and "build"
 stages
Date: Mon, 22 Jun 2020 16:33:16 +0100
Message-Id: <20200622153318.751107-2-berrange@redhat.com>
In-Reply-To: <20200622153318.751107-1-berrange@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If no stage is listed, jobs get put in an implicit "test" stage.
Some jobs which create container images to be used by later stages
are currently listed as in a "build" stages.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/edk2.yml    |  3 ++-
 .gitlab-ci.d/opensbi.yml |  3 ++-
 .gitlab-ci.yml           | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
index 088ba4b43a..d4e7dfcba6 100644
--- a/.gitlab-ci.d/edk2.yml
+++ b/.gitlab-ci.d/edk2.yml
@@ -1,5 +1,5 @@
 docker-edk2:
- stage: build
+ stage: containers
  rules: # Only run this job when the Dockerfile is modified
  - changes:
    - .gitlab-ci-edk2.yml
@@ -24,6 +24,7 @@ docker-edk2:
  - docker push $IMAGE_TAG
 
 build-edk2:
+ stage: build
  rules: # Only run this job when ...
  - changes: # ... roms/edk2/ is modified (submodule updated)
    - roms/edk2/*
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index dd051c0124..ec1c1f4cab 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -1,5 +1,5 @@
 docker-opensbi:
- stage: build
+ stage: containers
  rules: # Only run this job when the Dockerfile is modified
  - changes:
    - .gitlab-ci-opensbi.yml
@@ -24,6 +24,7 @@ docker-opensbi:
  - docker push $IMAGE_TAG
 
 build-opensbi:
+ stage: build
  rules: # Only run this job when ...
  - changes: # ... roms/opensbi/ is modified (submodule updated)
    - roms/opensbi/*
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 349c77aa58..9fdc752ea6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,3 +1,7 @@
+stages:
+  - containers
+  - build
+
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
@@ -17,6 +21,7 @@ include:
   - JOBS=$(expr $(nproc) + 1)
 
 build-system1:
+ stage: build
  image: ubuntu:19.10
  <<: *before_script_apt
  script:
@@ -31,6 +36,7 @@ build-system1:
  - make -j"$JOBS" check
 
 build-system2:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -46,6 +52,7 @@ build-system2:
  - make -j"$JOBS" check
 
 build-disabled:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -62,6 +69,7 @@ build-disabled:
  - make -j"$JOBS" check-qtest SPEED=slow
 
 build-tcg-disabled:
+ stage: build
  image: centos:8
  <<: *before_script_dnf
  script:
@@ -82,6 +90,7 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
 
 build-user:
+ stage: build
  <<: *before_script_apt
  script:
  - mkdir build
@@ -92,6 +101,7 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
 
 build-clang:
+ stage: build
  image: fedora:latest
  <<: *before_script_dnf
  script:
@@ -106,6 +116,7 @@ build-clang:
  - make -j"$JOBS" check
 
 build-tci:
+ stage: build
  image: centos:8
  <<: *before_script_dnf
  script:
-- 
2.24.1


