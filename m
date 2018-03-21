Received: from eggs.gnu.org ([2001:4830:134:3::10]:59768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhg8-00053w-Eo
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyhg7-0001k3-Ht
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:37:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Mar 2018 18:37:08 +0100
Message-Id: <20180321173714.14741-7-kwolf@redhat.com>
In-Reply-To: <20180321173714.14741-1-kwolf@redhat.com>
References: <20180321173714.14741-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 v2 06/12] qemu-iotests: Test invalid
 resize on luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

This tests that the .bdrv_truncate implementation for luks doesn't crash
for invalid image sizes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/210     | 37 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/210.out | 16 ++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index 96a5213e77..e607c0d296 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -204,6 +204,43 @@ run_qemu -blockdev driver=file,filename="$TEST_IMG_FILE",node-name=node0 \
 { "execute": "quit" }
 EOF
 
+echo
+echo "=== Resize image with invalid sizes ==="
+echo
+
+run_qemu -blockdev driver=file,filename="$TEST_IMG_FILE",node-name=node0 \
+         -blockdev driver=luks,file=node0,key-secret=keysec0,node-name=node1 \
+         -object secret,id=keysec0,data="foo" <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "block_resize",
+  "arguments": {
+      "node-name": "node1",
+      "size": 9223372036854775296
+  }
+}
+{ "execute": "block_resize",
+  "arguments": {
+      "node-name": "node1",
+      "size": 9223372036854775808
+  }
+}
+{ "execute": "block_resize",
+  "arguments": {
+      "node-name": "node1",
+      "size": 18446744073709551104
+  }
+}
+{ "execute": "block_resize",
+  "arguments": {
+      "node-name": "node1",
+      "size": -9223372036854775808
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index 8fcab65909..8198f8c829 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -133,4 +133,20 @@ QMP_VERSION
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 
+
+=== Resize image with invalid sizes ===
+
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0 -blockdev driver=IMGFMT,file=node0,key-secret=keysec0,node-name=node1 -object secret,id=keysec0,data=foo
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "The requested file size is too large"}}
+{"error": {"class": "GenericError", "desc": "Invalid parameter type for 'size', expected: integer"}}
+{"error": {"class": "GenericError", "desc": "Invalid parameter type for 'size', expected: integer"}}
+{"error": {"class": "GenericError", "desc": "Parameter 'size' expects a >0 size"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "key-secret": "keysec0"}
+file format: IMGFMT
+virtual size: 0 (0 bytes)
 *** done
-- 
2.13.6
