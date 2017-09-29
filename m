Received: from eggs.gnu.org ([2001:4830:134:3::10]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp1-0007d4-IU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxloz-0002WV-CE
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxloz-0002W1-3C
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Sep 2017 11:18:27 +0800
Message-Id: <20170929031831.10179-2-famz@redhat.com>
In-Reply-To: <20170929031831.10179-1-famz@redhat.com>
References: <20170929031831.10179-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] docker: add installation to build tests
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
List-ID: <qemu-devel.nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Basic test that "make install" works; this requires msgfmt so add
gettext to the packages.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1506095371-23160-1-git-send-email-pbonzini@redhat.com>
[Rebase to master. - Fam]
Signed-off-by: Fam Zheng <famz@redhat.com>
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
 tests/docker/test-full                       | 2 +-
 tests/docker/test-mingw                      | 1 +
 tests/docker/test-quick                      | 1 +
 14 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 87f5263757..7951555e3f 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -44,3 +44,11 @@ prep_fail()
     echo "$@"
     exit 2
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
index f6aae13f29..ad24319582 100644
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
index 0b59aa2f26..575de29a0a 100644
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
index fba224f760..e05a9a9802 100644
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
index 3d09b4b462..1bcf2e3d2f 100644
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
index a4509950e6..154ae2a455 100644
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
index 27e8201c54..4b26c3aded 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,6 +1,6 @@
 FROM fedora:latest
 ENV PACKAGES \
-    ccache git tar PyYAML sparse flex bison python2 bzip2 hostname \
+    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ clang make perl which bc findutils libaio-devel \
     nettle-devel \
diff --git a/tests/docker/dockerfiles/min-glib.docker b/tests/docker/dockerfiles/min-glib.docker
index 9f542d5e9c..f2eed97d35 100644
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
index d73ce02246..dabbf2a8a4 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -12,7 +12,7 @@ ENV PACKAGES flex bison \
     libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev \
     libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
     texinfo \
-    git make ccache python-yaml gcc clang sparse
+    gettext git make ccache python-yaml gcc clang sparse
 RUN apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml
diff --git a/tests/docker/test-build b/tests/docker/test-build
index 031a7d9d30..22766cfacc 100755
--- a/tests/docker/test-build
+++ b/tests/docker/test-build
@@ -18,3 +18,4 @@ cd "$BUILD_DIR"
 DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
+install_qemu
diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index 16485e6b7e..1eb61a3af7 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -24,3 +24,4 @@ OPTS="--enable-debug --cxx=clang++ --cc=clang --host-cc=clang"
     #--extra-cflags=-fno-sanitize=float-divide-by-zero"
 build_qemu $OPTS
 make $MAKEFLAGS check
+install_qemu
diff --git a/tests/docker/test-full b/tests/docker/test-full
index d71bf9d275..816d5a3eec 100755
--- a/tests/docker/test-full
+++ b/tests/docker/test-full
@@ -86,4 +86,4 @@ build_qemu \
     --enable-xen-pci-passthrough \
     --enable-xen-pv-domain-build \
     --enable-xfsctl \
-&& make check $MAKEFLAGS
+&& make check $MAKEFLAGS && install_qemu
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index 2adadcb58d..39a1da448e 100755
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
index c465dc06d8..3b7bce6105 100755
--- a/tests/docker/test-quick
+++ b/tests/docker/test-quick
@@ -19,3 +19,4 @@ DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
 make check $MAKEFLAGS
+install_qemu
-- 
2.13.5
