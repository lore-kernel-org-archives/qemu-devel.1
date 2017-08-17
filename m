Received: from eggs.gnu.org ([2001:4830:134:3::10]:51710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diBw8-0002s5-Fn
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diBw2-0004xK-Ed
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1diBw2-0004x1-8d
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:57:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 17 Aug 2017 11:57:21 +0800
Message-Id: <20170817035721.11064-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/docker: Clean up paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The 'run' script already creats src, build and install directories under
$TEST_DIR, use it in common.rc.

Also the tests always run from $QEMU_SRC/tests/docker, so use a relative
$CMD string.

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
2.13.4
