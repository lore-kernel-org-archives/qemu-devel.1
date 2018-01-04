Received: from eggs.gnu.org ([2001:4830:134:3::10]:37591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX83O-0007fd-63
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX83K-0003uv-G9
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX83K-0003tt-9L
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:34 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:11 +0100
Message-Id: <20180104160523.22995-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 06/18] tests/docker: add test-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Add a new test with --enable-debug using clang/asan/ubsan, remove
--enable-debug from test-clang & test-mingw.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/docker/test-clang |  2 +-
 tests/docker/test-debug | 26 ++++++++++++++++++++++++++
 tests/docker/test-mingw |  2 --
 3 files changed, 27 insertions(+), 3 deletions(-)
 create mode 100755 tests/docker/test-debug

diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index 1eb61a3af7..e90a793178 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -17,7 +17,7 @@ requires clang
=20
 cd "$BUILD_DIR"
=20
-OPTS=3D"--enable-debug --cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang"
+OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang"
 # -fsanitize=3Dundefined is broken on Fedora 23, skip it for now
 # See also: https://bugzilla.redhat.com/show_bug.cgi?id=3D1263834
 #OPTS=3D"$OPTS --extra-cflags=3D-fsanitize=3Dundefined \
diff --git a/tests/docker/test-debug b/tests/docker/test-debug
new file mode 100755
index 0000000000..d020b06917
--- /dev/null
+++ b/tests/docker/test-debug
@@ -0,0 +1,26 @@
+#!/bin/bash -e
+#
+# Compile and check with clang & --enable-debug.
+#
+# Copyright (c) 2016-2018 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+
+. common.rc
+
+requires clang asan
+
+cd "$BUILD_DIR"
+
+OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang"
+OPTS=3D"--enable-debug $OPTS"
+
+build_qemu $OPTS
+make $MAKEFLAGS check
+install_qemu
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index 39a1da448e..503a6bc6f7 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -22,7 +22,6 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
     TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
         build_qemu --cross-prefix=3D$prefix \
         --enable-trace-backends=3Dsimple \
-        --enable-debug \
         --enable-gnutls \
         --enable-nettle \
         --enable-curl \
@@ -35,4 +34,3 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
     make clean
=20
 done
-
--=20
2.15.1.355.g36791d7216
