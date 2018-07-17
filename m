Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4o-00031b-7R
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4n-0004cB-5z
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffW4m-0004be-Vc
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id c13-v6so2397730wrt.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:56:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:41 +0100
Message-Id: <20180717195553.9111-7-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 06/18] docker: move make check into
 check_qemu helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Not all docker images can run the check step. Let's move everything
into a common helper so we don't need to replicate checks in the
future.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2
  - add "move" to Let's everything in commit message
v3
  - avoid confusion using IVOCATION, add comment
---
 tests/docker/common.rc  | 11 +++++++++++
 tests/docker/test-clang |  2 +-
 tests/docker/test-debug |  2 +-
 tests/docker/test-full  |  2 +-
 tests/docker/test-quick |  2 +-
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index ba1f942328..4ff5974016 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -40,6 +40,17 @@ build_qemu()
     make $MAKEFLAGS
 }
 
+check_qemu()
+{
+    # default to make check unless the caller specifies
+    if test -z "$@"; then
+        INVOCATION="check"
+    else
+        INVOCATION="$@"
+    fi
+    make $MAKEFLAGS $INVOCATION
+}
+
 test_fail()
 {
     echo "$@"
diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index e90a793178..324e341cea 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -23,5 +23,5 @@ OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
 #OPTS="$OPTS --extra-cflags=-fsanitize=undefined \
     #--extra-cflags=-fno-sanitize=float-divide-by-zero"
 build_qemu $OPTS
-make $MAKEFLAGS check
+check_qemu
 install_qemu
diff --git a/tests/docker/test-debug b/tests/docker/test-debug
index d3f9f70d01..137f4f2ddc 100755
--- a/tests/docker/test-debug
+++ b/tests/docker/test-debug
@@ -22,5 +22,5 @@ OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
 OPTS="--enable-debug --enable-sanitizers $OPTS"
 
 build_qemu $OPTS
-make $MAKEFLAGS V=1 check
+check_qemu check V=1
 install_qemu
diff --git a/tests/docker/test-full b/tests/docker/test-full
index b4e42d25d7..aadc0f00a2 100755
--- a/tests/docker/test-full
+++ b/tests/docker/test-full
@@ -15,4 +15,4 @@
 
 cd "$BUILD_DIR"
 
-build_qemu && make check $MAKEFLAGS && install_qemu
+build_qemu && check_qemu && install_qemu
diff --git a/tests/docker/test-quick b/tests/docker/test-quick
index 3b7bce6105..eee59c55fb 100755
--- a/tests/docker/test-quick
+++ b/tests/docker/test-quick
@@ -18,5 +18,5 @@ cd "$BUILD_DIR"
 DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
-make check $MAKEFLAGS
+check_qemu
 install_qemu
-- 
2.17.1
