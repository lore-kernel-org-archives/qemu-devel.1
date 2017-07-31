Received: from eggs.gnu.org ([2001:4830:134:3::10]:52539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcB34-00018m-Tn
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcB33-0006d9-Od
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:47:54 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 31 Jul 2017 09:47:25 -0400
Message-Id: <ded25c757d9f8854ce47e2e674a44f18132a94ed.1501508049.git.jcody@redhat.com>
In-Reply-To: <cover.1501508049.git.jcody@redhat.com>
References: <cover.1501508049.git.jcody@redhat.com>
In-Reply-To: <cover.1501508049.git.jcody@redhat.com>
References: <cover.1501508049.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.11 3/3] qemu-iotests: add option to
 save temp files on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com

Now that ./check takes care of cleaning up after each tests, it
can also selectively not clean up.  Add option to leave all output from
tests intact if that test encountered an error.

Note: this currently only works for bash tests, as the python tests
still clean up after themselves manually.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/check  | 5 ++++-
 tests/qemu-iotests/common | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 7a21ef6..a3a5ab3 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -381,7 +381,10 @@ do
             fi
         fi
 
-        rm -rf "$TEST_DIR_SEQ"
+        if [ "$save_on_err" != "true" ] || [ "$err" != "true" ]
+        then
+            rm -rf "$TEST_DIR_SEQ"
+        fi
 
     fi
 
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index d34c11c..d08b233 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -42,6 +42,7 @@ expunge=true
 have_test_arg=false
 randomize=false
 cachemode=false
+save_on_err=false
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
 export IMGFMT=raw
@@ -172,6 +173,7 @@ other options
     -T                  output timestamps
     -r                  randomize test order
     -c mode             cache mode
+    -s                  save test scratch directory on test failure
 
 testlist options
     -g group[,group...]        include tests from these groups
@@ -349,6 +351,10 @@ testlist options
             xgroup=true
             xpand=false
             ;;
+        -s)
+            save_on_err=true
+            xpand=false
+            ;;
         '[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]')
             echo "No tests?"
             status=1
-- 
2.9.4
