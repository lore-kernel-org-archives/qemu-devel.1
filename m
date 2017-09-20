Received: from eggs.gnu.org ([2001:4830:134:3::10]:40090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duf8a-0000Sj-DQ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duf8Z-0008Oo-Dn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:34:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Sep 2017 14:15:15 +0200
Message-Id: <20170920121515.1311-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests/195: Change multiple nodes in one
 run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This additional check for change-backing-file makes sure that actions on
one part of the graph don't interfere with later actions elsewhere.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/195     | 17 ++++++++++++++++
 tests/qemu-iotests/195.out | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 05a239cbf5..eb2861380d 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -86,6 +86,23 @@ EOF
 
 _img_info
 
+echo
+echo "Change backing file of multiple nodes in a single run"
+echo
+
+_make_test_img -b "$TEST_IMG.mid"
+
+run_qemu -drive if=none,file="$TEST_IMG",node-name=top,backing.node-name=mid <<EOF
+{"execute":"qmp_capabilities"}
+{"execute":"change-backing-file", "arguments":{"device":"none0","image-node-name":"mid","backing-file":"/dev/null"}}
+{"execute":"change-backing-file", "arguments":{"device":"none0","image-node-name":"top","backing-file":"/dev/null"}}
+{"execute":"change-backing-file", "arguments":{"device":"none0","image-node-name":"mid","backing-file":"/dev/null"}}
+{"execute":"quit"}
+EOF
+
+TEST_IMG="$TEST_IMG.mid" _img_info
+_img_info
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index 7613575c64..d210c04895 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -75,4 +75,55 @@ virtual size: 64M (67108864 bytes)
 cluster_size: 65536
 backing file: /dev/null
 backing file format: IMGFMT
+
+Change backing file of multiple nodes in a single run
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,node-name=top,backing.node-name=mid
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+image: TEST_DIR/t.IMGFMT.mid
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+backing file: /dev/null
+backing file format: IMGFMT
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+backing file: /dev/null
+backing file format: IMGFMT
 *** done
-- 
2.13.5
