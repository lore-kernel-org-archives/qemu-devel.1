Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF6C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA2420BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MliKbDxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA2420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQ2b-00076Z-2E
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPqr-0001es-3a
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:43:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKPqp-0000Sl-8Q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600710222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=wxo9MPnciL1SFKGNTV67/pwbSzAZrRNqagOyhi6AP2s=;
 b=MliKbDxASWw+xaQjvrT3+nQk3H3dIHUsI+ZPyESbavrPSn32xPAwhVknnhpl1hsFhP5N4Z
 oSKnVZ9HefgSgTAo2UIdbAclko80yUVWIE57v2NmwjQE2OZwLjLfSz+WY+YSme0ARjy+WW
 EfndP1amWb77HFjiAoYjeT4rZiSytP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-VSt6cGbbNC6j5tyjaBnwNA-1; Mon, 21 Sep 2020 13:43:37 -0400
X-MC-Unique: VSt6cGbbNC6j5tyjaBnwNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 446DF1018F64;
 Mon, 21 Sep 2020 17:43:36 +0000 (UTC)
Received: from thuth.com (ovpn-112-14.ams2.redhat.com [10.36.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3D905D9E4;
 Mon, 21 Sep 2020 17:43:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/7] tests/docker: Use Fedora containers for MinGW
 cross-builds in the gitlab-CI
Date: Mon, 21 Sep 2020 19:43:14 +0200
Message-Id: <20200921174320.46062-2-thuth@redhat.com>
In-Reply-To: <20200921174320.46062-1-thuth@redhat.com>
References: <20200921174320.46062-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 11:10:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to our support policy, we do not support Debian 9 in QEMU
anymore, and we only support building the Windows binaries with a
very recent version of the MinGW toolchain. So we should not test
the MinGW cross-compilation with Debian 9 anymore, but switch to
something newer like Fedora. To do this, we need a separate Fedora
container for each build that provides the QEMU_CONFIGURE_OPTS
environment variable.
Unfortunately, the MinGW 64-bit compiler seems to be a little bit
slow, so we also have to disable some features like "capstone" in the
build here to make sure that the CI pipelines still finish within a
reasonable amount of time.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/containers.yml                   | 10 +++++
 .gitlab-ci.d/crossbuilds.yml                  |  4 +-
 .../dockerfiles/fedora-win32-cross.docker     | 42 +++++++++++++++++++
 .../dockerfiles/fedora-win64-cross.docker     | 38 +++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win64-cross.docker

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 8c89efeb6d..15e7b564f9 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -248,6 +248,16 @@ i386-fedora-cross-container:
   variables:
     NAME: fedora-i386-cross
 
+win32-fedora-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora-win32-cross
+
+win64-fedora-cross-container:
+  <<: *container_job_definition
+  variables:
+    NAME: fedora-win64-cross
+
 amd64-ubuntu1804-container:
   <<: *container_job_definition
   variables:
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 4ec7226b5c..510cfec03b 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -105,9 +105,9 @@ cross-s390x-user:
 cross-win32-system:
   <<: *cross_system_build_job_definition
   variables:
-    IMAGE: debian-win32-cross
+    IMAGE: fedora-win32-cross
 
 cross-win64-system:
   <<: *cross_system_build_job_definition
   variables:
-    IMAGE: debian-win64-cross
+    IMAGE: fedora-win64-cross
diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
new file mode 100644
index 0000000000..5903e1b0b4
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
@@ -0,0 +1,42 @@
+FROM fedora:32
+
+# Please keep this list sorted alphabetically
+ENV PACKAGES \
+    bc \
+    bzip2 \
+    diffutils \
+    findutils \
+    gcc \
+    gettext \
+    git \
+    hostname \
+    make \
+    meson \
+    mingw32-bzip2 \
+    mingw32-curl \
+    mingw32-glib2 \
+    mingw32-gmp \
+    mingw32-gnutls \
+    mingw32-gtk3 \
+    mingw32-libjpeg-turbo \
+    mingw32-libpng \
+    mingw32-libtasn1 \
+    mingw32-nettle \
+    mingw32-nsis \
+    mingw32-pixman \
+    mingw32-pkg-config \
+    mingw32-SDL2 \
+    perl \
+    perl-Test-Harness \
+    python3 \
+    python3-PyYAML \
+    python3-setuptools \
+    tar \
+    which
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV FEATURES mingw
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-w64-mingw32-
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
new file mode 100644
index 0000000000..7f03cd8ffc
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -0,0 +1,38 @@
+FROM fedora:32
+
+# Please keep this list sorted alphabetically
+ENV PACKAGES \
+    bc \
+    bzip2 \
+    diffutils \
+    findutils \
+    gcc \
+    gettext \
+    git \
+    hostname \
+    make \
+    meson \
+    mingw64-bzip2 \
+    mingw64-curl \
+    mingw64-glib2 \
+    mingw64-gmp \
+    mingw64-gtk3 \
+    mingw64-libjpeg-turbo \
+    mingw64-libpng \
+    mingw64-libtasn1 \
+    mingw64-pixman \
+    mingw64-pkg-config \
+    perl \
+    perl-Test-Harness \
+    python3 \
+    python3-PyYAML \
+    python3-setuptools \
+    tar \
+    which
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV FEATURES mingw
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32- --disable-capstone
-- 
2.18.2


