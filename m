Received: from eggs.gnu.org ([2001:4830:134:3::10]:41607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJD-0002Ns-GU
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJC-0003yg-C8
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:55 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:49 -0500
Message-Id: <20180723201748.25573-41-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 40/99] iotests: Add case for a corrupted
 inactive image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
Tested-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180606193702.7113-4-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit c50abd175a88cd41c2c08339de91f6f6e4a7b162)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/060     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/060.out | 14 ++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 6c7407f499..7bdf609f3f 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -440,6 +440,36 @@ echo "{'execute': 'qmp_capabilities'}
             -drive if=none,node-name=drive,file="$TEST_IMG",driver=qcow2 \
     | _filter_qmp | _filter_qemu_io
 
+echo
+echo "=== Testing incoming inactive corrupted image ==="
+echo
+
+_make_test_img 64M
+# Create an unaligned L1 entry, so qemu will signal a corruption when
+# reading from the covered area
+poke_file "$TEST_IMG" "$l1_offset" "\x00\x00\x00\x00\x2a\x2a\x2a\x2a"
+
+# Inactive images are effectively read-only images, so this should be a
+# non-fatal corruption (which does not modify the image)
+echo "{'execute': 'qmp_capabilities'}
+      {'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io drive \"read 0 512\"'}}
+      {'execute': 'quit'}" \
+    | $QEMU -qmp stdio -nographic -nodefaults \
+            -blockdev "{'node-name': 'drive',
+                        'driver': 'qcow2',
+                        'file': {
+                            'driver': 'file',
+                            'filename': '$TEST_IMG'
+                        }}" \
+            -incoming exec:'cat /dev/null' \
+            2>&1 \
+    | _filter_qmp | _filter_qemu_io
+
+echo
+# Image should not have been marked corrupt
+_img_info --format-specific | grep 'corrupt:'
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 25d5c3938b..99234fbfc2 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -420,4 +420,18 @@ write failed: Input/output error
 {"return": ""}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+=== Testing incoming inactive corrupted image ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+QMP_VERSION
+{"return": {}}
+qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); further non-fatal corruption events will be suppressed
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
+read failed: Input/output error
+{"return": ""}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+    corrupt: false
 *** done
-- 
2.17.1
