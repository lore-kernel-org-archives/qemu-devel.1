Received: from eggs.gnu.org ([2001:4830:134:3::10]:41746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4UnN-00075A-9o
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4UnM-0006lq-He
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:32:45 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 12:31:54 -0400
Message-Id: <b5a8ed05e7dab4d1400b12cf746cc6ef7243f870.1508257445.git.jcody@redhat.com>
In-Reply-To: <cover.1508257445.git.jcody@redhat.com>
References: <cover.1508257445.git.jcody@redhat.com>
In-Reply-To: <cover.1508257445.git.jcody@redhat.com>
References: <cover.1508257445.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v5 09/10] qemu-iotests: add option to save temp
 files on error
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

Now that ./check takes care of cleaning up after each tests, it
can also selectively not clean up.  Add option to leave all output from
tests intact if that test encountered an error.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/check | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 057ea39..a66f7b0 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -125,6 +125,7 @@ sortme=false
 expunge=true
 have_test_arg=false
 cachemode=false
+save_on_err=false
 
 tmp="${TEST_DIR}"/$$
 rm -f $tmp.list $tmp.tmp $tmp.sed
@@ -263,6 +264,8 @@ other options
     -o options          -o options to pass to qemu-img create/convert
     -T                  output timestamps
     -c mode             cache mode
+    -s                  save test scratch directory on test failure
+
 
 testlist options
     -g group[,group...]        include tests from these groups
@@ -435,6 +438,10 @@ testlist options
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
@@ -853,7 +860,11 @@ do
         _cleanup_protocols
         _cleanup_qemu
         )
-        rm -rf "$TEST_DIR_SEQ"
+
+        if [ "$save_on_err" != "true" ] || [ "$err" != "true" ]
+        then
+            rm -rf "$TEST_DIR_SEQ"
+        fi
 
     fi
 
-- 
2.9.5
