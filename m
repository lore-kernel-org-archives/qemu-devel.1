Received: from eggs.gnu.org ([2001:4830:134:3::10]:41623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYh-0007KO-CB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYf-0004mT-BC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:39 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYf-0004lI-4L
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:37 -0500
Received: by mail-wr0-x243.google.com with SMTP id 100so5028046wrb.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:38 +0100
Message-Id: <1515756676-3860-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/52] tests/docker: add test-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a new test with --enable-debug using clang/asan/ubsan, remove
--enable-debug from test-clang & test-mingw.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180104160523.22995-7-marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/test-clang |  2 +-
 tests/docker/test-debug | 26 ++++++++++++++++++++++++++
 tests/docker/test-mingw |  2 --
 3 files changed, 27 insertions(+), 3 deletions(-)
 create mode 100755 tests/docker/test-debug

diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index 1eb61a3..e90a793 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -17,7 +17,7 @@ requires clang
 
 cd "$BUILD_DIR"
 
-OPTS="--enable-debug --cxx=clang++ --cc=clang --host-cc=clang"
+OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
 # -fsanitize=undefined is broken on Fedora 23, skip it for now
 # See also: https://bugzilla.redhat.com/show_bug.cgi?id=1263834
 #OPTS="$OPTS --extra-cflags=-fsanitize=undefined \
diff --git a/tests/docker/test-debug b/tests/docker/test-debug
new file mode 100755
index 0000000..d020b06
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
+#  Marc-André Lureau <marcandre.lureau@redhat.com>
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
+OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
+OPTS="--enable-debug $OPTS"
+
+build_qemu $OPTS
+make $MAKEFLAGS check
+install_qemu
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index 39a1da4..503a6bc 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -22,7 +22,6 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
     TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
         build_qemu --cross-prefix=$prefix \
         --enable-trace-backends=simple \
-        --enable-debug \
         --enable-gnutls \
         --enable-nettle \
         --enable-curl \
@@ -35,4 +34,3 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
     make clean
 
 done
-
-- 
1.8.3.1
