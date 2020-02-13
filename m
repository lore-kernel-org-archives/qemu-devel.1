Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D8C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB74206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEGgLIzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB74206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Lz5-0006O2-Vr
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 16:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2Lrt-0005qp-9a
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2Lrr-0005JA-BZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32605
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2Lrr-00057z-0k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581628663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJ/eSWjGNhISR5g6kmChiKPuaISz4a9Rb5fPQgWh9vg=;
 b=LEGgLIzzbNf29WjKyTH+pKgxNPsDlmA30TkGydg+UtD5wU2BpyDTg9vwY+QFrvEB6EKKPn
 Ss8q4g1hPsHbFGMYfQyKgmchlwudz2fTHZIBvLXhxDnTtnRIZTmbpZ759FQ51rwoRkODR8
 N+dgWAjeeVBoHfK1MpxUUjIwn3zyR7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-CpL_zaxbOfCgDNuzQzgrwQ-1; Thu, 13 Feb 2020 16:17:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 572A18010E0;
 Thu, 13 Feb 2020 21:17:40 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47C1E19C7F;
 Thu, 13 Feb 2020 21:17:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 6/8] configure: Enable test and libs for zstd
Date: Thu, 13 Feb 2020 22:17:07 +0100
Message-Id: <20200213211709.59065-7-quintela@redhat.com>
In-Reply-To: <20200213211709.59065-1-quintela@redhat.com>
References: <20200213211709.59065-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CpL_zaxbOfCgDNuzQzgrwQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add it to several build systems to make testing good.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 .gitlab-ci.yml                                |  1 +
 .travis.yml                                   |  1 +
 configure                                     | 30 +++++++++++++++++++
 tests/docker/dockerfiles/centos7.docker       |  3 +-
 .../dockerfiles/fedora-i386-cross.docker      |  3 +-
 tests/docker/dockerfiles/fedora.docker        |  3 +-
 tests/docker/dockerfiles/ubuntu.docker        |  1 +
 tests/docker/dockerfiles/ubuntu1804.docker    |  1 +
 tests/vm/fedora                               |  5 +++-
 tests/vm/freebsd                              |  3 ++
 tests/vm/netbsd                               |  3 ++
 tests/vm/openbsd                              |  3 ++
 12 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c15e394f09..72f8b8aa51 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -21,6 +21,7 @@ build-system2:
  script:
  - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-d=
ev
       libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
+      libzstd-dev
  - mkdir build
  - cd build
  - ../configure --enable-werror --target-list=3D"tricore-softmmu unicore32=
-softmmu
diff --git a/.travis.yml b/.travis.yml
index 5887055951..dd17301f3b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -48,6 +48,7 @@ addons:
       - libusb-1.0-0-dev
       - libvdeplug-dev
       - libvte-2.91-dev
+      - libzstd-dev
       - sparse
       - uuid-dev
       - gcovr
diff --git a/configure b/configure
index 16f94cd96b..e6c12faef4 100755
--- a/configure
+++ b/configure
@@ -449,6 +449,7 @@ lzo=3D""
 snappy=3D""
 bzip2=3D""
 lzfse=3D""
+zstd=3D""
 guest_agent=3D""
 guest_agent_with_vss=3D"no"
 guest_agent_ntddscsi=3D"no"
@@ -1348,6 +1349,10 @@ for opt do
   ;;
   --disable-lzfse) lzfse=3D"no"
   ;;
+  --disable-zstd) zstd=3D"no"
+  ;;
+  --enable-zstd) zstd=3D"yes"
+  ;;
   --enable-guest-agent) guest_agent=3D"yes"
   ;;
   --disable-guest-agent) guest_agent=3D"no"
@@ -1801,6 +1806,8 @@ disabled with --disable-FEATURE, default is enabled i=
f available:
                   (for reading bzip2-compressed dmg images)
   lzfse           support of lzfse compression library
                   (for reading lzfse-compressed dmg images)
+  zstd            support for zstd compression library
+                  (for migration compression)
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
@@ -2415,6 +2422,24 @@ EOF
     fi
 fi
=20
+##########################################
+# zstd check
+
+if test "$zstd" !=3D "no" ; then
+    if $pkg_config --exist libzstd ; then
+        zstd_cflags=3D"$($pkg_config --cflags libzstd)"
+        zstd_libs=3D"$($pkg_config --libs libzstd)"
+        LIBS=3D"$zstd_libs $LIBS"
+        QEMU_CFLAGS=3D"$QEMU_CFLAGS $zstd_cflags"
+        zstd=3D"yes"
+    else
+        if test "$zstd" =3D "yes" ; then
+            feature_not_found "libzstd" "Install libzstd devel"
+        fi
+        zstd=3D"no"
+    fi
+fi
+
 ##########################################
 # libseccomp check
=20
@@ -6600,6 +6625,7 @@ echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
 echo "lzfse support     $lzfse"
+echo "zstd support      $zstd"
 echo "NUMA host support $numa"
 echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
@@ -7173,6 +7199,10 @@ if test "$lzfse" =3D "yes" ; then
   echo "LZFSE_LIBS=3D-llzfse" >> $config_host_mak
 fi
=20
+if test "$zstd" =3D "yes" ; then
+  echo "CONFIG_ZSTD=3Dy" >> $config_host_mak
+fi
+
 if test "$libiscsi" =3D "yes" ; then
   echo "CONFIG_LIBISCSI=3Dm" >> $config_host_mak
   echo "LIBISCSI_CFLAGS=3D$libiscsi_cflags" >> $config_host_mak
diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerf=
iles/centos7.docker
index 562d65be9e..cdd72de7eb 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -33,6 +33,7 @@ ENV PACKAGES \
     tar \
     vte-devel \
     xen-devel \
-    zlib-devel
+    zlib-devel \
+    libzstd-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/dock=
er/dockerfiles/fedora-i386-cross.docker
index 9106cf9ebe..cd16cd1bfa 100644
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -7,7 +7,8 @@ ENV PACKAGES \
     gnutls-devel.i686 \
     nettle-devel.i686 \
     pixman-devel.i686 \
-    zlib-devel.i686
+    zlib-devel.i686 \
+    libzstd-devel.i686
=20
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index 987a3c170a..a6522228c0 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -92,7 +92,8 @@ ENV PACKAGES \
     vte291-devel \
     which \
     xen-devel \
-    zlib-devel
+    zlib-devel \
+    libzstd-devel
 ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
=20
 RUN dnf install -y $PACKAGES
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfi=
les/ubuntu.docker
index 4177f33691..b6c7b41ddd 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -58,6 +58,7 @@ ENV PACKAGES flex bison \
     libvdeplug-dev \
     libvte-2.91-dev \
     libxen-dev \
+    libzstd-dev \
     make \
     python3-yaml \
     python3-sphinx \
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dock=
erfiles/ubuntu1804.docker
index 0766f94cf4..1efedeef99 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -44,6 +44,7 @@ ENV PACKAGES flex bison \
     libvdeplug-dev \
     libvte-2.91-dev \
     libxen-dev \
+    libzstd-dev \
     make \
     python3-yaml \
     python3-sphinx \
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 4d7d6049f4..4843b4175e 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -53,7 +53,10 @@ class FedoraVM(basevm.BaseVM):
         # libs: audio
         '"pkgconfig(libpulse)"',
         '"pkgconfig(alsa)"',
-    ]
+
+        # libs: migration
+        '"pkgconfig(libzstd)"',
+]
=20
     BUILD_SCRIPT =3D """
         set -e;
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index fb54334696..86770878b6 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -55,6 +55,9 @@ class FreeBSDVM(basevm.BaseVM):
         # libs: opengl
         "libepoxy",
         "mesa-libs",
+
+        # libs: migration
+        "zstd",
     ]
=20
     BUILD_SCRIPT =3D """
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index c5069a45f4..55590f4601 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -49,6 +49,9 @@ class NetBSDVM(basevm.BaseVM):
         "SDL2",
         "gtk3+",
         "libxkbcommon",
+
+        # libs: migration
+        "zstd",
     ]
=20
     BUILD_SCRIPT =3D """
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 22cd9513dd..ab6abbedab 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -51,6 +51,9 @@ class OpenBSDVM(basevm.BaseVM):
         "sdl2",
         "gtk+3",
         "libxkbcommon",
+
+        # libs: migration
+        "zstd",
     ]
=20
     BUILD_SCRIPT =3D """
--=20
2.24.1


