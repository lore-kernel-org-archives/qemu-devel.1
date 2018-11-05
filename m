Received: from eggs.gnu.org ([2001:4830:134:3::10]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhva-0001KP-46
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhvR-0000af-Ux
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:40:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:26 +0100
Message-Id: <20181105163744.25139-19-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/36] iotest: Test x-blockdev-change on a Quorum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This patch tests that you can add and remove drives from a Quorum
using the x-blockdev-change command.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/081     | 86 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/081.out | 54 ++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index 0ea010afbf..9f1dece271 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -198,6 +198,92 @@ quorum=3D"$quorum,file.children.2.driver=3Draw"
=20
 $QEMU_IO -c "open -o $quorum" | _filter_qemu_io
=20
+echo
+echo "=3D=3D dynamically adding a child to a quorum =3D=3D"
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
+echo "=3D=3D dynamically removing a child from a quorum =3D=3D"
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
index 2f12c890e9..8d81736336 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -71,4 +71,58 @@ read 10485760/10485760 bytes at offset 0
=20
 =3D=3D checking the blkverify mode with invalid settings =3D=3D
 can't open: blkverify=3Don can only be set if there are exactly two file=
s and vote-threshold is 2
+
+=3D=3D dynamically adding a child to a quorum =3D=3D
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot add a child to a quo=
rum in blkverify mode"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+
+=3D=3D dynamically removing a child from a quorum =3D=3D
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "The number of children cann=
ot be lower than the vote threshold 2"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "blkverify=3Don can only be =
set if there are exactly two files and vote-threshold is 2"}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=3Ddrive0=
-quorum nor node_name=3Ddrive0-quorum"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "The number of children cann=
ot be lower than the vote threshold 2"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
+
 *** done
--=20
2.19.1
