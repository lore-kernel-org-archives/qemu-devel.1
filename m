Received: from eggs.gnu.org ([2001:4830:134:3::10]:60896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1evMGq-00036o-5T
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1evMGm-0004JG-Vh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:09:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1evMGm-0004FP-Qt
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:09:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 12 Mar 2018 13:08:48 +0100
Message-Id: <20180312120849.20073-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: make docker-test-debug@fedora run
 sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Since --enable-debug no longer enable sanitizers, we need explicit
--enable-sanitizers.

llvm package is required for llvm-symbolizer, to get symbols in
backtraces.

Add make V=3D1 to get details about failing tests.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 tests/docker/test-debug                | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
index 994a35a332..a00004319e 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -2,7 +2,7 @@ FROM fedora:27
 ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostna=
me \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
-    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
+    gcc gcc-c++ llvm clang make perl which bc findutils libaio-devel \
     nettle-devel libasan libubsan \
     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-con=
fig \
     mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libt=
asn1 \
diff --git a/tests/docker/test-debug b/tests/docker/test-debug
index d020b06917..d3f9f70d01 100755
--- a/tests/docker/test-debug
+++ b/tests/docker/test-debug
@@ -1,6 +1,6 @@
 #!/bin/bash -e
 #
-# Compile and check with clang & --enable-debug.
+# Compile and check with clang & --enable-debug --enable-sanitizers.
 #
 # Copyright (c) 2016-2018 Red Hat Inc.
 #
@@ -19,8 +19,8 @@ requires clang asan
 cd "$BUILD_DIR"
=20
 OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang"
-OPTS=3D"--enable-debug $OPTS"
+OPTS=3D"--enable-debug --enable-sanitizers $OPTS"
=20
 build_qemu $OPTS
-make $MAKEFLAGS check
+make $MAKEFLAGS V=3D1 check
 install_qemu
--=20
2.16.2.346.g9779355e34
