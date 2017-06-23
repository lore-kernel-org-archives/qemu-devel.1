Received: from eggs.gnu.org ([2001:4830:134:3::10]:59363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLj-0000o8-Sd
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLi-0007YJ-Vb
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:11 +0200
Message-Id: <1498234919-27316-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/61] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Avoid duplicating the QEMU command-line.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/068 | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 9c1687d..61936d5 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -59,14 +59,17 @@ case "$QEMU_DEFAULT_MACHINE" in
       ;;
 esac
 
-# Give qemu some time to boot before saving the VM state
-bash -c 'sleep 1; echo -e "savevm 0\nquit"' |\
-    $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" |\
+_qemu()
+{
+    $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" \
+          "$@" |\
     _filter_qemu | _filter_hmp
+}
+
+# Give qemu some time to boot before saving the VM state
+bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
 # Now try to continue from that VM state (this should just work)
-echo quit |\
-    $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" -loadvm 0 |\
-    _filter_qemu | _filter_hmp
+echo quit | _qemu -loadvm 0
 
 # success, all done
 echo "*** done"
-- 
1.8.3.1
