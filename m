Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34700C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05AE2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcYPXjRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05AE2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorBC-0004e5-Nl
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioqq6-0002cE-No
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioqq5-0005HE-Ag
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioqq5-0005Gj-6U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578411132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/c7sqHaYnfE1/rw6Ylzvk0Swj+SrRlKq+fOPflDkso=;
 b=CcYPXjRWH6msHs/UdH+LQjRw4uFYE82xmU4rAUbNietI5G3WOpzvCvCwXxzNOtaOtiUZfN
 JEWyAV3E7tcIcNnHg5YKquD7g5R2PlHSkN7YDefSrCxmqRuQPY3CLzpyrZwg9HYySw/0JV
 8IpTfHNFH0nuDmVHm53ZgnCAfqd4Bwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-uYnGxzVvOaixxYXA18jX1A-1; Tue, 07 Jan 2020 10:32:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D68A1005502;
 Tue,  7 Jan 2020 15:32:08 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-222.brq.redhat.com [10.40.204.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B9E15D9CA;
 Tue,  7 Jan 2020 15:32:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH v2 3/3] gitlab-ci-edk2.yml: Use ccache
Date: Tue,  7 Jan 2020 16:31:54 +0100
Message-Id: <20200107153154.21401-4-philmd@redhat.com>
In-Reply-To: <20200107153154.21401-1-philmd@redhat.com>
References: <20200107153154.21401-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: uYnGxzVvOaixxYXA18jX1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using ccache we reduce the job duration from
  36 minutes 28 seconds: https://gitlab.com/philmd/qemu/-/jobs/395823729
to
  29 minutes 15 seconds: https://gitlab.com/philmd/qemu/-/jobs/395840851

  Running after script...
  $ ccache --show-stats
  cache hit (direct)                  6604
  files in cache                     12090
  cache size                         335.5 MB

For now downloading this cache takes 16 seconds, archiving
it 44 seconds.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
We prefer to not use ccache to build the EDK2 firmware binaries, see:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg668616.html

 .gitlab-ci-edk2.yml          | 13 +++++++++++--
 .gitlab-ci.d/edk2/Dockerfile |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
index 088ba4b43a..50b8aee6b7 100644
--- a/.gitlab-ci-edk2.yml
+++ b/.gitlab-ci-edk2.yml
@@ -10,7 +10,7 @@ docker-edk2:
  - docker:19.03.1-dind
  variables:
   GIT_DEPTH: 3
-  IMAGE_TAG: $CI_REGISTRY_IMAGE:edk2-cross-build
+  IMAGE_TAG: $CI_REGISTRY_IMAGE:edk2-cross-build-ccache
   # We don't use TLS
   DOCKER_HOST: tcp://docker:2375
   DOCKER_TLS_CERTDIR: ""
@@ -38,12 +38,21 @@ build-edk2:
    - pc-bios/edk2-licenses.txt
    - edk2-stdout.log
    - edk2-stderr.log
- image: $CI_REGISTRY_IMAGE:edk2-cross-build
+ image: $CI_REGISTRY_IMAGE:edk2-cross-build-ccache
  variables:
    GIT_DEPTH: 3
+   CCACHE_DIR: ${CI_PROJECT_DIR}/.ccache
+ cache: # Use the same cache for all EDK2 jobs
+   key: edk2-cross-build-ccache
+   paths:
+   - ${CCACHE_DIR}
+ before_script:
+ - ccache --zero-stats
  script: # Clone the required submodules and build EDK2
  - git submodule update --init roms/edk2
  - git -C roms/edk2 submodule update --init
  - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
  - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
  - make -j${JOBS} -C roms efi 2>&1 1>edk2-stdout.log | tee -a edk2-stderr.=
log >&2
+ after_script:
+ - ccache --show-stats
diff --git a/.gitlab-ci.d/edk2/Dockerfile b/.gitlab-ci.d/edk2/Dockerfile
index b4584d1cf6..350b4df240 100644
--- a/.gitlab-ci.d/edk2/Dockerfile
+++ b/.gitlab-ci.d/edk2/Dockerfile
@@ -13,6 +13,7 @@ RUN apt update \
     apt install --assume-yes --no-install-recommends \
         build-essential \
         ca-certificates \
+        ccache \
         dos2unix \
         gcc-aarch64-linux-gnu \
         gcc-arm-linux-gnueabi \
@@ -25,3 +26,5 @@ RUN apt update \
     && \
     \
     rm -rf /var/lib/apt/lists/*
+
+ENV PATH /usr/lib/ccache:$PATH
--=20
2.21.1


