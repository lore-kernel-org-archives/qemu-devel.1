Received: from eggs.gnu.org ([2001:4830:134:3::10]:54088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=658a259a8=Alistair.Francis@wdc.com>)
	id 1fFmRz-0001UC-Tb
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=658a259a8=Alistair.Francis@wdc.com>)
	id 1fFmRv-0008PB-OW
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:09:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=658a259a8=Alistair.Francis@wdc.com>)
	id 1fFmRv-0008M4-7z
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:09:31 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon,  7 May 2018 13:09:16 -0700
Message-Id: <90990df8024b287004e771ebd2370cc390e49106.1525723355.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] tests/docker: Add a Avocado Docker test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, famz@redhat.com, f4bug@amsat.org, alistair23@gmail.com, alistair.francis@wdc.com

Avocado is not trivial to setup on non-Fedora systems. To simplfying
future testing add a docker test image that runs Avocado tests.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/docker/dockerfiles/fedora.docker | 12 +++++++++--
 tests/docker/test-avocado              | 28 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100755 tests/docker/test-avocado

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index b706f42405..5c23f6e459 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -18,9 +18,17 @@ ENV PACKAGES \
     mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
     mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
     mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
-    mingw64-bzip2
+    mingw64-bzip2 \
+    xz tcpdump nc \
+    python2-devel python3-devel python-avocado \
+    libvirt-devel qemu-kvm
 ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
+ENV PIP_PACKAGES \
+    avocado-framework avocado-qemu \
+    avocado-framework-plugin-vt avocado-framework-plugin-runner-vm \
+    avocado-framework-plugin-runner-remote avocado-framework-plugin-result-html
 
 RUN dnf install -y $PACKAGES
+RUN pip install $PIP_PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-ENV FEATURES mingw clang pyyaml asan
+ENV FEATURES mingw clang pyyaml asan avocado
diff --git a/tests/docker/test-avocado b/tests/docker/test-avocado
new file mode 100755
index 0000000000..8da7bc10a2
--- /dev/null
+++ b/tests/docker/test-avocado
@@ -0,0 +1,28 @@
+#!/bin/bash -e
+#
+# Avocado tests on Fedora, as these are a real pain on Debian systems
+#
+# Copyright (c) 2018 Western Digital.
+#
+# Authors:
+#  Alistair Francis <alistair.francis@wdc.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+#
+# Run this test: NETWORK=1 make docker-test-avocado@fedora
+
+. common.rc
+
+requires avocado
+
+cd "$BUILD_DIR"
+
+DEF_TARGET_LIST="x86_64-softmmu"
+TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
+build_qemu
+install_qemu
+export PATH="${PATH}:$(pwd)"
+avocado vt-bootstrap --yes-to-all --vt-type qemu
+avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
-- 
2.17.0
