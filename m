Received: from eggs.gnu.org ([2001:4830:134:3::10]:41425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVdni-0004fR-Nu
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVdnh-0006Aq-Qw
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:32:46 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon, 23 Jan 2017 20:30:49 +0800
Message-Id: <20170123123056.30383-10-famz@redhat.com>
In-Reply-To: <20170123123056.30383-1-famz@redhat.com>
References: <20170123123056.30383-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v12 09/16] iotests: 085: Avoid image locking
 conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>

In the case where we test the expected error when a blockdev-snapshot
target already has a backing image, backing chain is opened multiple
times. This will be a problem when we use image locking, so use a
different backing file that is not already open.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/085     | 32 +++++++++++++++++++-------------
 tests/qemu-iotests/085.out |  3 ++-
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index c53e97f..c91d78d 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -87,24 +87,26 @@ function create_group_snapshot()
 }
 
 # ${1}: unique identifier for the snapshot filename
-# ${2}: true: open backing images; false: don't open them (default)
+# ${2}: extra_params to the blockdev-add command
+# ${3}: filename
+function do_blockdev_add()
+{
+    cmd="{ 'execute': 'blockdev-add', 'arguments':
+           { 'driver': 'qcow2', 'node-name': 'snap_${1}', ${2}
+             'file':
+             { 'driver': 'file', 'filename': '${3}',
+               'node-name': 'file_${1}' } } }"
+    _send_qemu_cmd $h "${cmd}" "return"
+}
+
+# ${1}: unique identifier for the snapshot filename
 function add_snapshot_image()
 {
-    if [ "${2}" = "true" ]; then
-        extra_params=""
-    else
-        extra_params="'backing': '', "
-    fi
     base_image="${TEST_DIR}/$((${1}-1))-${snapshot_virt0}"
     snapshot_file="${TEST_DIR}/${1}-${snapshot_virt0}"
     _make_test_img -b "${base_image}" "$size"
     mv "${TEST_IMG}" "${snapshot_file}"
-    cmd="{ 'execute': 'blockdev-add', 'arguments':
-           { 'driver': 'qcow2', 'node-name': 'snap_${1}', ${extra_params}
-             'file':
-             { 'driver': 'file', 'filename': '${snapshot_file}',
-               'node-name': 'file_${1}' } } }"
-    _send_qemu_cmd $h "${cmd}" "return"
+    do_blockdev_add "$1" "'backing': '', " "${snapshot_file}"
 }
 
 # ${1}: unique identifier for the snapshot filename
@@ -222,7 +224,11 @@ echo === Invalid command - snapshot node has a backing image ===
 echo
 
 SNAPSHOTS=$((${SNAPSHOTS}+1))
-add_snapshot_image ${SNAPSHOTS} true
+
+_make_test_img "$size"
+mv "${TEST_IMG}" "${TEST_IMG}.base"
+_make_test_img -b "${TEST_IMG}.base" "$size"
+do_blockdev_add ${SNAPSHOTS} "" "${TEST_IMG}"
 blockdev_snapshot ${SNAPSHOTS} error
 
 echo
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index 08e4bb7..7bbf84d 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -78,7 +78,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/
 
 === Invalid command - snapshot node has a backing image ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/12-snapshot-v0.IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "The snapshot already has a backing image"}}
 
-- 
2.9.3
