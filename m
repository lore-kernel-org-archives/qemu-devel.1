Received: from eggs.gnu.org ([2001:4830:134:3::10]:53061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmP-0004ac-In
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmN-0001lf-P5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:45 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:54 +0200
Message-Id: <20180611142611.6609-13-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 12/29] iotests: Repairing error during snapshot
 deletion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This adds a test for an I/O error during snapshot deletion, and maybe
more importantly, for how to repair the resulting image.  If the
snapshot has been deleted before the error occurs, the only negative
result will be leaked clusters -- and those should be repairable with
qemu-img check -r leaks.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509200059.31125-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/217     | 90 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/217.out | 42 ++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 133 insertions(+)
 create mode 100755 tests/qemu-iotests/217
 create mode 100644 tests/qemu-iotests/217.out

diff --git a/tests/qemu-iotests/217 b/tests/qemu-iotests/217
new file mode 100755
index 0000000000..d3ab5d72be
--- /dev/null
+++ b/tests/qemu-iotests/217
@@ -0,0 +1,90 @@
+#!/bin/bash
+#
+# I/O errors when working with internal qcow2 snapshots, and repairing
+# the result
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+seq=$(basename $0)
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_DIR/blkdebug.conf"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+# This test is specific to qcow2
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+# This test needs clusters with at least a refcount of 2 so that
+# OFLAG_COPIED is not set.  refcount_bits=1 is therefore unsupported.
+_unsupported_imgopts 'refcount_bits=1[^0-9]'
+
+echo
+echo '=== Simulating an I/O error during snapshot deletion ==='
+echo
+
+_make_test_img 64M
+$QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
+
+# Create the snapshot
+$QEMU_IMG snapshot -c foo "$TEST_IMG"
+
+# Verify the snapshot is there
+echo
+_img_info | grep 'Snapshot list'
+echo '(Snapshot filtered)'
+echo
+
+# Try to delete the snapshot (with an error happening when freeing the
+# then leaked clusters)
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event = "cluster_free"
+errno = "5"
+EOF
+$QEMU_IMG snapshot -d foo "blkdebug:$TEST_DIR/blkdebug.conf:$TEST_IMG"
+
+# Verify the snapshot is gone
+echo
+_img_info | grep 'Snapshot list'
+
+# Should only show leaks
+echo '--- Checking test image ---'
+_check_test_img
+
+echo
+
+# As there are only leaks, this should be able to fully repair the
+# image
+echo '--- Repairing test image ---'
+_check_test_img -r leaks
+
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/217.out b/tests/qemu-iotests/217.out
new file mode 100644
index 0000000000..e3fc40a8c7
--- /dev/null
+++ b/tests/qemu-iotests/217.out
@@ -0,0 +1,42 @@
+QA output created by 217
+
+=== Simulating an I/O error during snapshot deletion ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Snapshot list:
+(Snapshot filtered)
+
+qcow2_free_clusters failed: Input/output error
+qemu-img: Could not delete snapshot 'foo': Failed to free the cluster and L1 table: Input/output error
+
+--- Checking test image ---
+Leaked cluster 4 refcount=2 reference=1
+Leaked cluster 5 refcount=2 reference=1
+Leaked cluster 6 refcount=1 reference=0
+Leaked cluster 7 refcount=1 reference=0
+
+4 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
+
+--- Repairing test image ---
+Leaked cluster 4 refcount=2 reference=1
+Leaked cluster 5 refcount=2 reference=1
+Leaked cluster 6 refcount=1 reference=0
+Leaked cluster 7 refcount=1 reference=0
+Repairing cluster 4 refcount=2 reference=1
+Repairing cluster 5 refcount=2 reference=1
+Repairing cluster 6 refcount=1 reference=0
+Repairing cluster 7 refcount=1 reference=0
+Repairing OFLAG_COPIED L2 cluster: l1_index=0 l1_entry=40000 refcount=1
+Repairing OFLAG_COPIED data cluster: l2_entry=50000 refcount=1
+The following inconsistencies were found and repaired:
+
+    4 leaked clusters
+    2 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 93f93d71ba..0914c922d7 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -215,5 +215,6 @@
 214 rw auto
 215 rw auto quick
 216 rw auto quick
+217 rw auto quick
 218 rw auto quick
 219 rw auto
-- 
2.17.1
