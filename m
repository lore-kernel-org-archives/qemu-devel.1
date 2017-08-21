Received: from eggs.gnu.org ([2001:4830:134:3::10]:38540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1djkbq-0002Ew-FN
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1djkbp-0004Up-8M
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:11:06 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:56714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1djkbo-0004P9-92
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:11:05 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Mon, 21 Aug 2017 16:40:38 +0530
Message-Id: <1503313839-10258-3-git-send-email-chugh.ishani@research.iiit.ac.in>
In-Reply-To: <1503313839-10258-1-git-send-email-chugh.ishani@research.iiit.ac.in>
References: <1503313839-10258-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH 2/3] Test for full Backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jsnow@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

This patch is the test for full backup implementation in Backup tool.
The test employs two basic substests:
1) Backing up an empty guest and comparing it with base image.
2) Writing a pattern to the guest, creating backup and comparing
   with the base image.

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 tests/qemu-iotests/191     | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/191.out | 33 ++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 112 insertions(+)
 create mode 100755 tests/qemu-iotests/191
 create mode 100644 tests/qemu-iotests/191.out

diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
new file mode 100755
index 0000000..14cd094
--- /dev/null
+++ b/tests/qemu-iotests/191
@@ -0,0 +1,78 @@
+#!/bin/bash
+#
+# Test full backup functionality of qemu-backup tool
+#
+# Copyright (C) 2009 Red Hat, Inc.
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
+#
+
+# creator
+owner=chugh.ishani@research.iiit.ac.in
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt generic
+_supported_proto generic
+_supported_os Linux
+
+
+CONFIG_FILE=$TEST_DIR/backup-config
+SOCKET=unix:$TEST_DIR/backup_socket
+size=128M
+
+_make_test_img $size
+export QEMU_BACKUP_CONFIG=$CONFIG_FILE
+qemu_comm_method="monitor"
+echo
+_launch_qemu -nographic -drive if=virtio,file=$TEST_IMG -qmp $SOCKET,server,nowait
+$PYTHON ../../contrib/backup/qemu-backup.py guest add --guest adad --qmp $SOCKET
+$PYTHON ../../contrib/backup/qemu-backup.py drive add --id virtio0 --guest adad --target $TEST_DIR/virtio0
+echo
+echo "== Creating backup =="
+$PYTHON ../../contrib/backup/qemu-backup.py backup --guest adad
+_send_qemu_cmd $QEMU_HANDLE 'quit' ''
+wait=1 _cleanup_qemu
+echo
+echo "== Comparing images =="
+$QEMU_IMG compare $TEST_DIR/virtio0 $TEST_IMG
+rm $TEST_DIR/virtio0
+
+_launch_qemu -nographic -drive if=virtio,id=virtio0,file=$TEST_IMG -qmp $SOCKET,server,nowait
+echo
+echo "== Writing Pattern =="
+_send_qemu_cmd $QEMU_HANDLE 'qemu-io virtio0 "write -P 0x22 0 1M"' "(qemu)" | _filter_qemu_io
+echo
+echo "== Creating backup =="
+$PYTHON ../../contrib/backup/qemu-backup.py backup --guest adad
+_send_qemu_cmd $QEMU_HANDLE 'quit' ''
+wait=1 _cleanup_qemu
+echo
+echo "== Comparing images =="
+$QEMU_IMG compare $TEST_DIR/virtio0 $TEST_IMG
+rm $TEST_DIR/virtio0
+rm $CONFIG_FILE
+
+echo "*** done"
+status=0
\ No newline at end of file
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
new file mode 100644
index 0000000..a8b0dbb
--- /dev/null
+++ b/tests/qemu-iotests/191.out
@@ -0,0 +1,33 @@
+QA output created by 191
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+
+Successfully Added Guest
+Successfully Added Drive
+
+== Creating backup ==
+Backup Started
+*virtio0
+Backup Complete
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) Formatting 'TEST_DIR/virtio0', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+quit
+
+== Comparing images ==
+Images are identical.
+
+== Writing Pattern ==
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io virtio0 "write -P 0x22 0 1M"
+
+== Creating backup ==
+Backup Started
+*virtio0
+Backup Complete
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) Formatting 'TEST_DIR/virtio0', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+quit
+
+== Comparing images ==
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index afbdc42..bfff383 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -187,3 +187,4 @@
 189 rw auto
 190 rw auto quick
 192 rw auto quick
+193 rw auto
-- 
2.7.4
