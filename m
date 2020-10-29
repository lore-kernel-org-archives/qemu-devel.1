Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FD0C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185FF206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk91z50Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185FF206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBgM-00025w-Us
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYBdK-0007Tv-Dg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYBdF-00041J-FB
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603992155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yEQmrcoPaA4DuV7GoNCOQ39IGV8Y9vh7fXcDavXe2UE=;
 b=fk91z50ZI3BmOsAonKSqEZECXfPytI7MIWsNRb0KQUIMOyAqDCCIMdrEodpgKA7bgDQDlB
 7r0kl4c+Dfycq305inElT8DjiPQP5lzfR6gRJ1K0g8QRgdv+HYoLZupWAzzMdEcstHx9+1
 jT0RmCEG+FcogYGbBXVpR0aF/N/cAKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-gNkUz3_VPNa-oxLEykC5Pw-1; Thu, 29 Oct 2020 13:22:32 -0400
X-MC-Unique: gNkUz3_VPNa-oxLEykC5Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DAF310309B5;
 Thu, 29 Oct 2020 17:22:23 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E8825D98C;
 Thu, 29 Oct 2020 17:22:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docker, coverity_scan: unify Fedora dockerfiles
Date: Thu, 29 Oct 2020 13:22:22 -0400
Message-Id: <20201029172222.3940324-2-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Fedora CI and coverity runs are using a slightly different set of
packages Unfortunately we need to keep coverity on Fedora 30 because
it doesn't know about GCC 10 and fails, but we can at least base the
coverity dockerfile on one from tests/docker; this way the coverity run
is less likely to be forgotten when doing changes to the set of packages
in the containers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/coverity-scan.docker    | 109 +-----------------
 tests/docker/dockerfiles/fedora.docker        |   5 +
 .../{fedora.docker => fedora30.docker}        |   7 +-
 3 files changed, 13 insertions(+), 108 deletions(-)
 copy tests/docker/dockerfiles/{fedora.docker => fedora30.docker} (94%)

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index 501ac67233..1bfb856765 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -15,114 +15,9 @@
 # The work of actually doing the build is handled by the
 # run-coverity-scan script.
 
-FROM fedora:30
-ENV PACKAGES \
-    alsa-lib-devel \
-    bc \
-    brlapi-devel \
-    bzip2 \
-    bzip2-devel \
-    ccache \
-    clang \
-    curl \
-    cyrus-sasl-devel \
-    dbus-daemon \
-    device-mapper-multipath-devel \
-    findutils \
-    gcc \
-    gcc-c++ \
-    gettext \
-    git \
-    glib2-devel \
-    glusterfs-api-devel \
-    gnutls-devel \
-    gtk3-devel \
-    hostname \
-    libaio-devel \
-    libasan \
-    libattr-devel \
-    libblockdev-mpath-devel \
-    libcap-devel \
-    libcap-ng-devel \
-    libcurl-devel \
-    libepoxy-devel \
-    libfdt-devel \
-    libgbm-devel \
-    libiscsi-devel \
-    libjpeg-devel \
-    libpmem-devel \
-    libnfs-devel \
-    libpng-devel \
-    librbd-devel \
-    libseccomp-devel \
-    libssh-devel \
-    libubsan \
-    libudev-devel \
-    libusbx-devel \
-    libxml2-devel \
-    libzstd-devel \
-    llvm \
-    lzo-devel \
-    make \
-    mingw32-bzip2 \
-    mingw32-curl \
-    mingw32-glib2 \
-    mingw32-gmp \
-    mingw32-gnutls \
-    mingw32-gtk3 \
-    mingw32-libjpeg-turbo \
-    mingw32-libpng \
-    mingw32-libtasn1 \
-    mingw32-nettle \
-    mingw32-nsis \
-    mingw32-pixman \
-    mingw32-pkg-config \
-    mingw32-SDL2 \
-    mingw64-bzip2 \
-    mingw64-curl \
-    mingw64-glib2 \
-    mingw64-gmp \
-    mingw64-gnutls \
-    mingw64-gtk3 \
-    mingw64-libjpeg-turbo \
-    mingw64-libpng \
-    mingw64-libtasn1 \
-    mingw64-nettle \
-    mingw64-pixman \
-    mingw64-pkg-config \
-    mingw64-SDL2 \
-    ncurses-devel \
-    nettle-devel \
-    nss-devel \
-    numactl-devel \
-    perl \
-    perl-Test-Harness \
-    pixman-devel \
-    pulseaudio-libs-devel \
-    python3 \
-    python3-sphinx \
-    PyYAML \
-    rdma-core-devel \
-    SDL2-devel \
-    snappy-devel \
-    sparse \
-    spice-server-devel \
-    systemd-devel \
-    systemtap-sdt-devel \
-    tar \
-    usbredir-devel \
-    virglrenderer-devel \
-    vte291-devel \
-    wget \
-    which \
-    xen-devel \
-    xfsprogs-devel \
-    zlib-devel
-ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
+FROM qemu:fedora
 
-RUN dnf install -y $PACKAGES
-RUN rpm -q $PACKAGES | sort > /packages.txt
-ENV PATH $PATH:/usr/libexec/python3-sphinx/
+RUN dnf install -y curl wget
 ENV COVERITY_TOOL_BASE=/coverity-tools
 COPY coverity_tool.tgz coverity_tool.tgz
 RUN mkdir -p /coverity-tools/coverity_tool && cd /coverity-tools/coverity_tool && tar xf /coverity_tool.tgz
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 0b5053f2d0..54f3e10991 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -2,6 +2,7 @@ FROM fedora:32
 
 # Please keep this list sorted alphabetically
 ENV PACKAGES \
+    alsa-lib-devel \
     bc \
     brlapi-devel \
     bzip2 \
@@ -31,8 +32,10 @@ ENV PACKAGES \
     libcurl-devel \
     libepoxy-devel \
     libfdt-devel \
+    libgbm-devel \
     libiscsi-devel \
     libjpeg-devel \
+    libnfs-devel \
     libpmem-devel \
     libpng-devel \
     librbd-devel \
@@ -82,6 +85,7 @@ ENV PACKAGES \
     perl \
     perl-Test-Harness \
     pixman-devel \
+    pulseaudio-libs-devel \
     python3 \
     python3-PyYAML \
     python3-numpy \
@@ -105,6 +109,7 @@ ENV PACKAGES \
     vte291-devel \
     which \
     xen-devel \
+    xfsprogs-devel \
     zlib-devel
 ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora30.docker
similarity index 94%
copy from tests/docker/dockerfiles/fedora.docker
copy to tests/docker/dockerfiles/fedora30.docker
index 0b5053f2d0..7295b74d2a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora30.docker
@@ -1,7 +1,8 @@
-FROM fedora:32
+FROM fedora:30
 
 # Please keep this list sorted alphabetically
 ENV PACKAGES \
+    alsa-lib-devel \
     bc \
     brlapi-devel \
     bzip2 \
@@ -31,8 +32,10 @@ ENV PACKAGES \
     libcurl-devel \
     libepoxy-devel \
     libfdt-devel \
+    libgbm-devel \
     libiscsi-devel \
     libjpeg-devel \
+    libnfs-devel \
     libpmem-devel \
     libpng-devel \
     librbd-devel \
@@ -82,6 +85,7 @@ ENV PACKAGES \
     perl \
     perl-Test-Harness \
     pixman-devel \
+    pulseaudio-libs-devel \
     python3 \
     python3-PyYAML \
     python3-numpy \
@@ -105,6 +109,7 @@ ENV PACKAGES \
     vte291-devel \
     which \
     xen-devel \
+    xfsprogs-devel \
     zlib-devel
 ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
-- 
2.26.2


