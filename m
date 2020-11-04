Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2238F20867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7RRQX2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaIon-0007pu-Hk
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaIhT-0002eh-R2
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:19:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaIhR-0008Od-SQ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604495980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVg4ORMcsdgJBufhD2Y8fk1Fp/517gGMOPrnP3bAkO0=;
 b=V7RRQX2IrObdTFMXL8Qb1DIZAMg1QPokm4gsGaV6tBNheljGaFn3PZmR6KJuEiNi30rQrX
 KRybihl1boycO+5GT3vaw/Gk68F8QfPZ+0Xf1d8h0rH7C94x+u99bwfVGLetjt+0Q27SE6
 JjXljm1CUGdlwBX4knmGJjSFlULV7fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-EDpSiTqKPb6uj0NAwnsa1g-1; Wed, 04 Nov 2020 08:19:36 -0500
X-MC-Unique: EDpSiTqKPb6uj0NAwnsa1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A46D31084D64;
 Wed,  4 Nov 2020 13:19:35 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB6E775128;
 Wed,  4 Nov 2020 13:19:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/usb/ccid: remove references to NSS
Date: Wed,  4 Nov 2020 13:19:22 +0000
Message-Id: <20201104131924.593522-2-berrange@redhat.com>
In-Reply-To: <20201104131924.593522-1-berrange@redhat.com>
References: <20201104131924.593522-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NSS package was previously pre-requisite for building CCID related
features, however, this became obsolete when the libcacard library was
spun off to a separate project:

    commit 7b02f5447c64d1854468f758398c9f6fe9e5721f
    Author: Marc-André Lureau <marcandre.lureau@redhat.com>
    Date:   Sun Aug 30 11:48:40 2015 +0200

        libcacard: use the standalone project

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .travis.yml                                | 14 +++++++-------
 docs/ccid.txt                              | 15 +++++++--------
 scripts/coverity-scan/coverity-scan.docker |  1 -
 tests/docker/dockerfiles/centos7.docker    |  1 +
 tests/docker/dockerfiles/centos8.docker    |  1 +
 tests/docker/dockerfiles/fedora.docker     |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a3d78171ca..2bd2cfd0ba 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -27,6 +27,7 @@ addons:
       - libattr1-dev
       - libbrlapi-dev
       - libcap-ng-dev
+      - libcacard-dev
       - libgcc-7-dev
       - libgnutls28-dev
       - libgtk-3-dev
@@ -34,7 +35,6 @@ addons:
       - liblttng-ust-dev
       - libncurses5-dev
       - libnfs-dev
-      - libnss3-dev
       - libpixman-1-dev
       - libpng-dev
       - librados-dev
@@ -268,6 +268,7 @@ jobs:
             - libaio-dev
             - libattr1-dev
             - libbrlapi-dev
+            - libcacard-dev
             - libcap-ng-dev
             - libgnutls28-dev
             - libgtk-3-dev
@@ -275,7 +276,6 @@ jobs:
             - liblttng-ust-dev
             - libnfs-dev
             - libncurses5-dev
-            - libnss3-dev
             - libpixman-1-dev
             - libpng-dev
             - librados-dev
@@ -335,6 +335,7 @@ jobs:
           - libaio-dev
           - libattr1-dev
           - libbrlapi-dev
+          - libcacard-dev
           - libcap-ng-dev
           - libgcrypt20-dev
           - libgnutls28-dev
@@ -343,7 +344,6 @@ jobs:
           - liblttng-ust-dev
           - libncurses5-dev
           - libnfs-dev
-          - libnss3-dev
           - libpixman-1-dev
           - libpng-dev
           - librados-dev
@@ -369,6 +369,7 @@ jobs:
           - libaio-dev
           - libattr1-dev
           - libbrlapi-dev
+          - libcacard-dev
           - libcap-ng-dev
           - libgcrypt20-dev
           - libgnutls28-dev
@@ -377,7 +378,6 @@ jobs:
           - liblttng-ust-dev
           - libncurses5-dev
           - libnfs-dev
-          - libnss3-dev
           - libpixman-1-dev
           - libpng-dev
           - librados-dev
@@ -402,6 +402,7 @@ jobs:
           - libaio-dev
           - libattr1-dev
           - libbrlapi-dev
+          - libcacard-dev
           - libcap-ng-dev
           - libgcrypt20-dev
           - libgnutls28-dev
@@ -410,7 +411,6 @@ jobs:
           - liblttng-ust-dev
           - libncurses5-dev
           - libnfs-dev
-          - libnss3-dev
           - libpixman-1-dev
           - libpng-dev
           - librados-dev
@@ -444,6 +444,7 @@ jobs:
         apt_packages:
           - libaio-dev
           - libattr1-dev
+          - libcacard-dev
           - libcap-ng-dev
           - libgnutls28-dev
           - libiscsi-dev
@@ -451,7 +452,6 @@ jobs:
           - liblzo2-dev
           - libncurses-dev
           - libnfs-dev
-          - libnss3-dev
           - libpixman-1-dev
           - libsdl2-dev
           - libsdl2-image-dev
@@ -487,6 +487,7 @@ jobs:
           - libaio-dev
           - libattr1-dev
           - libbrlapi-dev
+          - libcacard-dev
           - libcap-ng-dev
           - libgcrypt20-dev
           - libgnutls28-dev
@@ -495,7 +496,6 @@ jobs:
           - liblttng-ust-dev
           - libncurses5-dev
           - libnfs-dev
-          - libnss3-dev
           - libpixman-1-dev
           - libpng-dev
           - librados-dev
diff --git a/docs/ccid.txt b/docs/ccid.txt
index c7fda6d07d..1baf03e29b 100644
--- a/docs/ccid.txt
+++ b/docs/ccid.txt
@@ -34,15 +34,14 @@ reader and smart card (i.e. not backed by a physical device) using this device.
 
 2. Building
 
-The cryptographic functions and access to the physical card is done via NSS.
-
-Installing NSS:
+The cryptographic functions and access to the physical card is done via the
+libcacard library, whose development package must be installed prior to
+building QEMU:
 
 In redhat/fedora:
-    yum install nss-devel
-In ubuntu/debian:
-    apt-get install libnss3-dev
-    (not tested on ubuntu)
+    yum install libcacard-devel
+In ubuntu:
+    apt-get install libcacard-dev
 
 Configuring and building:
     ./configure --enable-smartcard && make
@@ -51,7 +50,7 @@ Configuring and building:
 3. Using ccid-card-emulated with hardware
 
 Assuming you have a working smartcard on the host with the current
-user, using NSS, qemu acts as another NSS client using ccid-card-emulated:
+user, using libcacard, qemu acts as another client using ccid-card-emulated:
 
     qemu -usb -device usb-ccid -device ccid-card-emulated
 
diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index 501ac67233..ecff6ac5b4 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -93,7 +93,6 @@ ENV PACKAGES \
     mingw64-SDL2 \
     ncurses-devel \
     nettle-devel \
-    nss-devel \
     numactl-devel \
     perl \
     perl-Test-Harness \
diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index 6f11af1989..d47c96135c 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -17,6 +17,7 @@ ENV PACKAGES \
     glib2-devel \
     gnutls-devel \
     libaio-devel \
+    libcacard-devel \
     libepoxy-devel \
     libfdt-devel \
     libgcrypt-devel \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index 54bc6d54cd..bbd82421db 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -13,6 +13,7 @@ ENV PACKAGES \
     git \
     glib2-devel \
     libaio-devel \
+    libcacard-devel \
     libepoxy-devel \
     libgcrypt-devel \
     lzo-devel \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 0b5053f2d0..29859beee3 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -28,6 +28,7 @@ ENV PACKAGES \
     libattr-devel \
     libblockdev-mpath-devel \
     libcap-ng-devel \
+    libcacard-devel \
     libcurl-devel \
     libepoxy-devel \
     libfdt-devel \
@@ -77,7 +78,6 @@ ENV PACKAGES \
     ncurses-devel \
     nettle-devel \
     ninja-build \
-    nss-devel \
     numactl-devel \
     perl \
     perl-Test-Harness \
-- 
2.28.0


