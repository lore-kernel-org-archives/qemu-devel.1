Received: from eggs.gnu.org ([2001:4830:134:3::10]:33338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gD49c-00010r-0p
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gD49Y-0008DQ-Es
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:59:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 18 Oct 2018 11:59:04 +0300
Message-Id: <b5ca9aac2a1ed2cd054b6ceaa821533904cbce68.1539852875.git.berto@igalia.com>
In-Reply-To: <cover.1539852875.git.berto@igalia.com>
References: <cover.1539852875.git.berto@igalia.com>
In-Reply-To: <cover.1539852875.git.berto@igalia.com>
References: <cover.1539852875.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/2] iotest: Test x-blockdev-change on a Quorum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch tests that you can add and remove drives from a Quorum
using the x-blockdev-change command.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/081     | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/081.out | 54 +++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index 0ea010afbf..7a441f9300 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -198,6 +198,92 @@ quorum="$quorum,file.children.2.driver=raw"
 
 $QEMU_IO -c "open -o $quorum" | _filter_qemu_io
 
+echo
+echo "== dinamically adding a child to a quorum =="
+
+for verify in false true; do
+    run_qemu <<EOF
+    { "execute": "qmp_capabilities" }
+    { "execute": "blockdev-add",
+        "arguments": {
+            "driver": "quorum",
+            "node-name": "drive0-quorum",
+            "vote-threshold": 2,
+            "blkverify": ${verify},
+            "children": [
+                {
+                    "driver": "$IMGFMT",
+                    "file": {
+                        "driver": "file",
+                        "filename": "$TEST_DIR/1.raw"
+                    }
+                },
+                {
+                    "driver": "$IMGFMT",
+                    "file": {
+                        "driver": "file",
+                        "filename": "$TEST_DIR/2.raw"
+                    }
+                }
+            ]
+        }
+    }
+    { "execute": "blockdev-add",
+        "arguments": {
+            "node-name": "drive3",
+            "driver": "$IMGFMT",
+            "file": {
+                "driver": "file",
+                "filename": "$TEST_DIR/2.raw"
+            }
+        }
+    }
+    { "execute": "x-blockdev-change",
+      "arguments": { "parent": "drive0-quorum",
+                     "node": "drive3" } }
+    { "execute": "quit" }
+EOF
+done
+
+echo
+echo "== dinamically removing a child from a quorum =="
+
+for verify in false true; do
+    for vote_threshold in 1 2; do
+        run_qemu <<EOF
+        { "execute": "qmp_capabilities" }
+        { "execute": "blockdev-add",
+            "arguments": {
+                "driver": "quorum",
+                "node-name": "drive0-quorum",
+                "vote-threshold": ${vote_threshold},
+                "blkverify": ${verify},
+                "children": [
+                    {
+                        "driver": "$IMGFMT",
+                        "file": {
+                            "driver": "file",
+                            "filename": "$TEST_DIR/1.raw"
+                        }
+                    },
+                    {
+                        "driver": "$IMGFMT",
+                        "file": {
+                            "driver": "file",
+                            "filename": "$TEST_DIR/2.raw"
+                        }
+                    }
+                ]
+            }
+        }
+        { "execute": "x-blockdev-change",
+          "arguments": { "parent": "drive0-quorum",
+                         "child": "children.1" } }
+        { "execute": "quit" }
+EOF
+    done
+done
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 2f12c890e9..909f3fba3b 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -71,4 +71,58 @@ read 10485760/10485760 bytes at offset 0
 
 == checking the blkverify mode with invalid settings ==
 can't open: blkverify=on can only be set if there are exactly two files and vote-threshold is 2
+
+== dinamically adding a child to a quorum ==
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot add a child to a quorum in blkverify mode"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+
+== dinamically removing a child from a quorum ==
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "The number of children cannot be lower than the vote threshold 2"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "blkverify=on can only be set if there are exactly two files and vote-threshold is 2"}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=drive0-quorum nor node_name=drive0-quorum"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "The number of children cannot be lower than the vote threshold 2"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
 *** done
-- 
2.11.0
