Received: from eggs.gnu.org ([2001:4830:134:3::10]:41626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0a-0007lX-Hf
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0T-0004Ny-1T
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG0S-0004ND-Rg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:54:35 +0800
Message-Id: <20170908095506.13594-8-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 07/38] tests/docker: Clean up paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The 'run' script already creats src, build and install directories under
$TEST_DIR, use it in common.rc.

Also the tests always run from $QEMU_SRC/tests/docker, so use a relative
$CMD string.

Message-Id: <20170817035721.11064-1-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/common.rc | 5 +----
 tests/docker/run       | 4 +++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 6865689bb5..64b36ba2d0 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -11,9 +11,6 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
 
-BUILD_DIR=/var/tmp/qemu-build
-mkdir $BUILD_DIR
-
 requires()
 {
     for c in $@; do
@@ -28,7 +25,7 @@ build_qemu()
 {
     config_opts="--enable-werror \
                  ${TARGET_LIST:+--target-list=${TARGET_LIST}} \
-                 --prefix=$PWD/install \
+                 --prefix=$INSTALL_DIR \
                  $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
                  $@"
     echo "Configure options:"
diff --git a/tests/docker/run b/tests/docker/run
index c1e4513bce..ec2541cbd9 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -52,10 +52,12 @@ if test -n "$SHOW_ENV"; then
 fi
 
 export QEMU_SRC="$TEST_DIR/src"
+export BUILD_DIR="$TEST_DIR/build"
+export INSTALL_DIR="$TEST_DIR/install"
 
 cd "$QEMU_SRC/tests/docker"
 
-CMD="$QEMU_SRC/tests/docker/$@"
+CMD="./$@"
 
 if test -z "$DEBUG"; then
     exec $CMD
-- 
2.13.5
