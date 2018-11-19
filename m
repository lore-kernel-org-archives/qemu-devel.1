Received: from eggs.gnu.org ([2001:4830:134:3::10]:51288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnkw-0008UC-Bf
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnkv-0002Tm-5E
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:42 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:17 -0600
Message-Id: <20181119175427.2298497-3-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] qemu-iotests: convert `pwd` and $(pwd) to
 $PWD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

POSIX requires $PWD to be reliable, and we expect all
shells used by qemu scripts to be relatively close to
POSIX.  Thus, it is smarter to avoid forking the pwd
executable for something that is already available in
the environment.

So replace it with the following:

sed -i 's/\(`pwd`\|\$(pwd)\)/$PWD/g' $(git grep -l pwd)

Then delete a pointless line assigning PWD to itself.

Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: eblake@redhat.com
Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Message-Id: <20181024094051.4470-2-maozhongyi@cmss.chinamobile.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: touch up commit message, reorder series, tweak a couple more files]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 configure                                | 2 +-
 tests/qemu-iotests/common.config         | 2 --
 tests/qemu-iotests/common.rc             | 2 +-
 scripts/coccinelle/tcg_gen_extract.cocci | 2 +-
 tests/check-block.sh                     | 6 +++---
 tests/qemu-iotests/check                 | 2 +-
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index 5b1d83ea262..0a3c6a72c3b 100755
--- a/configure
+++ b/configure
@@ -878,7 +878,7 @@ Linux)
   vhost_crypto="yes"
   vhost_scsi="yes"
   vhost_vsock="yes"
-  QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
+  QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
   libudev="yes"
 ;;
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 102aa6878a9..3cda0fe5696 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -25,8 +25,6 @@ HOSTOS=`uname -s`
 arch=`uname -m`
 [[ "$arch" =~ "ppc64" ]] && qemu_arch=ppc64 || qemu_arch="$arch"

-export PWD=`pwd`
-
 # make sure we have a standard umask
 umask 022

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 70ca65b49b3..e15e7a7c8e6 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -160,7 +160,7 @@ fi
 ORIG_TEST_IMG="$TEST_IMG"

 if [ -z "$TEST_DIR" ]; then
-        TEST_DIR=`pwd`/scratch
+        TEST_DIR=$PWD/scratch
 fi

 QEMU_TEST_DIR="${TEST_DIR}"
diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
index 81e66a35ae1..c10c8634827 100644
--- a/scripts/coccinelle/tcg_gen_extract.cocci
+++ b/scripts/coccinelle/tcg_gen_extract.cocci
@@ -17,7 +17,7 @@
 //     --keep-comments --in-place \
 //     --use-gitgrep --dir target
 //
-// $ docker run --rm -v `pwd`:`pwd` -w `pwd` philmd/coccinelle \
+// $ docker run --rm -v $PWD:$PWD -w $PWD philmd/coccinelle \
 //     --macro-file scripts/cocci-macro-file.h \
 //     --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
 //     --keep-comments --in-place \
diff --git a/tests/check-block.sh b/tests/check-block.sh
index c3de3789c48..f3d12fd602d 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -5,9 +5,9 @@ if [ "$#" -ne 0 ]; then
     FORMAT_LIST="$@"
 fi

-export QEMU_PROG="$(pwd)/x86_64-softmmu/qemu-system-x86_64"
-export QEMU_IMG_PROG="$(pwd)/qemu-img"
-export QEMU_IO_PROG="$(pwd)/qemu-io"
+export QEMU_PROG="$PWD/x86_64-softmmu/qemu-system-x86_64"
+export QEMU_IMG_PROG="$PWD/qemu-img"
+export QEMU_IO_PROG="$PWD/qemu-io"

 if [ ! -x $QEMU_PROG ]; then
     echo "'make check-block' requires qemu-system-x86_64"
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index aa94c6c7ea9..b37713277d1 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -99,7 +99,7 @@ set_prog_path()
 }

 if [ -z "$TEST_DIR" ]; then
-        TEST_DIR=`pwd`/scratch
+        TEST_DIR=$PWD/scratch
 fi

 if [ ! -e "$TEST_DIR" ]; then
-- 
2.17.2
