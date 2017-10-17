Received: from eggs.gnu.org ([2001:4830:134:3::10]:41568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4Un2-0006lg-8X
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4Un1-0006HK-GD
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:32:24 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 12:31:47 -0400
Message-Id: <a664aec5e058c71ae51e3eadd0defe7066d79f16.1508257445.git.jcody@redhat.com>
In-Reply-To: <cover.1508257445.git.jcody@redhat.com>
References: <cover.1508257445.git.jcody@redhat.com>
In-Reply-To: <cover.1508257445.git.jcody@redhat.com>
References: <cover.1508257445.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v5 02/10] qemu-iotests: set TEST_DIR to a
 unique dir for each test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

Right now, all qemu-iotests output data into the same scratch directory,
and so each test needs to be responsible for cleaning up its own files.

Have each test use 'scratch/$seq' as its temp directory, so the check
script can do simple cleanup of removing the whole temporary directory.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/check | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e2163cc..5ae34bf 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -713,6 +713,7 @@ seq="check"
 
 for seq in $list
 do
+    TEST_DIR_SEQ=$TEST_DIR/$seq
     err=false
     printf %s "$seq"
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
@@ -756,13 +757,23 @@ do
         fi
         export OUTPUT_DIR=$PWD
         if $debug; then
-            (cd "$source_iotests";
+            (
+            export TEST_DIR=$TEST_DIR_SEQ
+            cd "$source_iotests";
+            . ./common.config
+            . ./common.rc
             MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
-                    $run_command -d 2>&1 | tee $tmp.out)
+                    $run_command -d 2>&1 | tee $tmp.out
+            )
         else
-            (cd "$source_iotests";
+            (
+            export TEST_DIR=$TEST_DIR_SEQ
+            cd "$source_iotests";
+            . ./common.config
+            . ./common.rc
             MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1))} \
-                    $run_command >$tmp.out 2>&1)
+                    $run_command >$tmp.out 2>&1
+            )
         fi
         sts=$?
         $timestamp && _timestamp
@@ -826,6 +837,8 @@ do
             fi
         fi
 
+        rm -rf "$TEST_DIR_SEQ"
+
     fi
 
     # come here for each test, except when $showme is true
-- 
2.9.5
