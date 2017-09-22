Received: from eggs.gnu.org ([2001:4830:134:3::10]:41792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvMM8-00073H-6I
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvMM4-0007oG-Vx
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:42:52 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:32836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvMM4-0007nt-Ml
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:42:48 -0400
Received: by mail-wr0-x242.google.com with SMTP id b9so513580wra.0
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 04:42:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 13:42:43 +0200
Message-Id: <1506080563-41084-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: add installation to build tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, famz@redhat.com

Basic test that "make install" works; this requires msgfmt so add
gettext to the packages.

Drop ccache on Fedora, because it fails on RHEL 7.4, it is not used
by any other distro and it is not particularly useful on throwaway
containers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/common.rc                       | 8 ++++++++
 tests/docker/dockerfiles/centos6.docker      | 1 +
 tests/docker/dockerfiles/centos7.docker      | 1 +
 tests/docker/dockerfiles/debian-ports.docker | 1 +
 tests/docker/dockerfiles/debian8.docker      | 1 +
 tests/docker/dockerfiles/debian9.docker      | 1 +
 tests/docker/dockerfiles/fedora.docker       | 2 +-
 tests/docker/dockerfiles/min-glib.docker     | 2 +-
 tests/docker/dockerfiles/ubuntu.docker       | 2 +-
 tests/docker/test-build                      | 1 +
 tests/docker/test-clang                      | 1 +
 tests/docker/test-full                       | 1 +
 tests/docker/test-mingw                      | 1 +
 tests/docker/test-quick                      | 1 +
 14 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 6865689..1522aab 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -36,3 +36,11 @@ build_qemu()
     $QEMU_SRC/configure $config_opts
     make $MAKEFLAGS
 }
+
+install_qemu()
+{
+    make install $MAKEFLAGS DESTDIR=$PWD/=destdir
+    ret=$?
+    rm -rf $PWD/=destdir
+    return $ret
+}
diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/dockerfiles/centos6.docker
index f6aae13..ad24319 100644
--- a/tests/docker/dockerfiles/centos6.docker
+++ b/tests/docker/dockerfiles/centos6.docker
@@ -8,6 +8,7 @@ ENV PACKAGES \
     flex \
     g++ \
     gcc \
+    gettext \
     git \
     glib2-devel \
     libepoxy-devel \
diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index 0b59aa2..575de29 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -9,6 +9,7 @@ ENV PACKAGES \
     flex \
     g++ \
     gcc \
+    gettext \
     git \
     glib2-devel \
     libepoxy-devel \
diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/dockerfiles/debian-ports.docker
index fba224f..e05a9a9 100644
--- a/tests/docker/dockerfiles/debian-ports.docker
+++ b/tests/docker/dockerfiles/debian-ports.docker
@@ -27,6 +27,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         clang \
         debian-ports-archive-keyring \
         flex \
+        gettext \
         git \
         pkg-config \
         psmisc \
diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
index 3d09b4b..1bcf2e3 100644
--- a/tests/docker/dockerfiles/debian8.docker
+++ b/tests/docker/dockerfiles/debian8.docker
@@ -26,6 +26,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         clang \
         curl \
         flex \
+        gettext \
         git \
         gnupg \
         pkg-config \
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index a450995..154ae2a 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -22,6 +22,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         ca-certificates \
         clang \
         flex \
+        gettext \
         git \
         pkg-config \
         psmisc \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 4eaa8ed..dec6b1a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,6 +1,6 @@
 FROM fedora:latest
 ENV PACKAGES \
-    ccache git tar PyYAML sparse flex bison python2 bzip2 hostname \
+    gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ clang make perl which bc findutils libaio-devel \
     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
diff --git a/tests/docker/dockerfiles/min-glib.docker b/tests/docker/dockerfiles/min-glib.docker
index 9f542d5..f2eed97 100644
--- a/tests/docker/dockerfiles/min-glib.docker
+++ b/tests/docker/dockerfiles/min-glib.docker
@@ -1,6 +1,6 @@
 FROM centos:6
 RUN yum install -y \
-    tar git make gcc g++ \
+    tar gettext git make gcc g++ \
     zlib-devel SDL-devel pixman-devel \
     epel-release
 RUN yum install -y libfdt-devel ccache
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index a360a05..131668c 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -7,7 +7,7 @@ ENV PACKAGES flex bison \
     libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
     libspice-protocol-dev libnss3-dev libfdt-dev \
     libgtk-3-dev libvte-2.90-dev libsdl1.2-dev libpng12-dev libpixman-1-dev \
-    git make ccache python-yaml gcc clang sparse
+    gettext git make ccache python-yaml gcc clang sparse
 RUN apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml
diff --git a/tests/docker/test-build b/tests/docker/test-build
index 031a7d9..22766cf 100755
--- a/tests/docker/test-build
+++ b/tests/docker/test-build
@@ -18,3 +18,4 @@ cd "$BUILD_DIR"
 DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
+install_qemu
diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index 16485e6..1eb61a3 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -24,3 +24,4 @@ OPTS="--enable-debug --cxx=clang++ --cc=clang --host-cc=clang"
     #--extra-cflags=-fno-sanitize=float-divide-by-zero"
 build_qemu $OPTS
 make $MAKEFLAGS check
+install_qemu
diff --git a/tests/docker/test-full b/tests/docker/test-full
index 05f0d49..a0ba90e 100755
--- a/tests/docker/test-full
+++ b/tests/docker/test-full
@@ -17,3 +17,4 @@ cd "$BUILD_DIR"
 
 build_qemu
 make check $MAKEFLAGS
+install_qemu
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index 2adadcb..39a1da4 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -31,6 +31,7 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
         --enable-guest-agent \
         --with-sdlabi=1.2 \
         --with-gtkabi=2.0
+    install_qemu
     make clean
 
 done
diff --git a/tests/docker/test-quick b/tests/docker/test-quick
index c465dc0..3b7bce6 100755
--- a/tests/docker/test-quick
+++ b/tests/docker/test-quick
@@ -19,3 +19,4 @@ DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
 make check $MAKEFLAGS
+install_qemu
-- 
1.8.3.1
