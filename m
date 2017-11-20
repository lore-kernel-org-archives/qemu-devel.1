Received: from eggs.gnu.org ([2001:4830:134:3::10]:57065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc7G-00012d-L2
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc7F-0008Sc-Em
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:22 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Sun, 19 Nov 2017 21:46:46 -0500
Message-Id: <3ac8694cb03843a9c1231dd9c7a858458986d807.1511145863.git.jcody@redhat.com>
In-Reply-To: <cover.1511145863.git.jcody@redhat.com>
References: <cover.1511145863.git.jcody@redhat.com>
In-Reply-To: <cover.1511145863.git.jcody@redhat.com>
References: <cover.1511145863.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] qemu-iotest: add test for blockjob
 coroutine race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/200     | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/200.out | 14 +++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 114 insertions(+)
 create mode 100755 tests/qemu-iotests/200
 create mode 100644 tests/qemu-iotests/200.out

diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
new file mode 100755
index 0000000..32fdec8
--- /dev/null
+++ b/tests/qemu-iotests/200
@@ -0,0 +1,99 @@
+#!/bin/bash
+#
+# Block job co-routine race condition test.
+#
+# See: https://bugzilla.redhat.com/show_bug.cgi?id=1508708
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+owner=jcody@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_qemu
+    rm -f "${TEST_IMG}" "${BACKING_IMG}"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2 qed qcow
+_supported_proto file
+_supported_os Linux
+
+BACKING_IMG="${TEST_DIR}/backing.img"
+TEST_IMG="${TEST_DIR}/test.img"
+
+${QEMU_IMG} create -f $IMGFMT "${BACKING_IMG}" 512M | _filter_img_create
+${QEMU_IMG} create -f $IMGFMT -F $IMGFMT "${TEST_IMG}" -b "${BACKING_IMG}" 512M | _filter_img_create
+
+${QEMU_IO} -c "write -P 0xa5 512 300M" "${BACKING_IMG}" | _filter_qemu_io
+
+echo
+echo === Starting QEMU VM ===
+echo
+qemu_comm_method="qmp"
+_launch_qemu -device pci-bridge,id=bridge1,chassis_nr=1,bus=pci.0 \
+             -object iothread,id=iothread0 \
+             -device virtio-scsi-pci,bus=bridge1,addr=0x1f,id=scsi0,iothread=iothread0 \
+             -drive file="${TEST_IMG}",media=disk,if=none,cache=none,id=drive_sysdisk,aio=native,format=$IMGFMT \
+             -device scsi-hd,drive=drive_sysdisk,bus=scsi0.0,id=sysdisk,bootindex=0
+h1=$QEMU_HANDLE
+
+_send_qemu_cmd $h1 "{ 'execute': 'qmp_capabilities' }" 'return'
+
+echo
+echo === Sending stream/cancel, checking for SIGSEGV only  ===
+echo
+for (( i=1;i<500;i++ ))
+do
+    mismatch_only='y' qemu_error_no_exit='n' _send_qemu_cmd $h1 \
+                       "{
+                            'execute': 'block-stream',
+                            'arguments': {
+                                'device': 'drive_sysdisk',
+                                'speed': 10000000,
+                                'on-error': 'report',
+                                'job-id': 'job-$i'
+                             }
+                        }
+                        {
+                            'execute': 'block-job-cancel',
+                            'arguments': {
+                                'device': 'job-$i'
+                             }
+                        }" \
+                       "{.*{.*}.*}"  # should match all well-formed QMP responses
+done
+
+silent='y' _send_qemu_cmd $h1  "{ 'execute': 'quit' }" 'return'
+
+echo "$i iterations performed"
+
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/200.out b/tests/qemu-iotests/200.out
new file mode 100644
index 0000000..af6a809
--- /dev/null
+++ b/tests/qemu-iotests/200.out
@@ -0,0 +1,14 @@
+QA output created by 200
+Formatting 'TEST_DIR/backing.img', fmt=IMGFMT size=536870912
+Formatting 'TEST_DIR/test.img', fmt=IMGFMT size=536870912 backing_file=TEST_DIR/backing.img backing_fmt=IMGFMT
+wrote 314572800/314572800 bytes at offset 512
+300 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Starting QEMU VM ===
+
+{"return": {}}
+
+=== Sending stream/cancel, checking for SIGSEGV only ===
+
+500 iterations performed
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 24e5ad1..25d9adf 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -194,3 +194,4 @@
 194 rw auto migration quick
 195 rw auto quick
 197 rw auto quick
+200 rw auto
-- 
2.9.5
