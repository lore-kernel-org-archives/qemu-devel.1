Received: from eggs.gnu.org ([2001:4830:134:3::10]:50365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVb-000308-Ot
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVY-0002wT-UX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:42:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Jul 2017 13:41:34 +0200
Message-Id: <1499946095-8224-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
References: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/9] qemu-iotests: Test 'info block'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This test makes sure that all block devices show up on 'info block',
with all of the expected information, in different configurations.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/186     | 147 ++++++++++++++
 tests/qemu-iotests/186.out | 489 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 637 insertions(+)
 create mode 100755 tests/qemu-iotests/186
 create mode 100644 tests/qemu-iotests/186.out

diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
new file mode 100755
index 0000000..ab83ee4
--- /dev/null
+++ b/tests/qemu-iotests/186
@@ -0,0 +1,147 @@
+#!/bin/bash
+#
+# Test 'info block' with all kinds of configurations
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
+owner=kwolf@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
+    _notrun "Requires a PC machine"
+fi
+
+function do_run_qemu()
+{
+    echo Testing: "$@"
+
+    (
+        if ! test -t 0; then
+            while read cmd; do
+                echo $cmd
+            done
+        fi
+        echo quit
+    ) | $QEMU -S -nodefaults -display none -device virtio-scsi-pci -monitor stdio "$@"
+    echo
+}
+
+function check_info_block()
+{
+    echo "info block" |
+    QEMU_OPTIONS="" do_run_qemu "$@" | _filter_win32 | _filter_hmp |
+        _filter_qemu | _filter_generated_node_ids
+}
+
+
+size=64M
+_make_test_img $size
+
+removable="floppy ide-cd scsi-cd"
+fixed="ide-hd scsi-hd virtio-blk-pci"
+
+echo
+echo "=== Empty drives ==="
+echo
+
+for dev in $removable; do
+    check_info_block -device $dev
+    check_info_block -device $dev,id=qdev_id
+done
+
+echo
+echo "=== -blockdev/-device=<node-name> ==="
+echo
+
+for dev in $fixed $removable; do
+    check_info_block -blockdev driver=null-co,node-name=null -device $dev,drive=null
+    check_info_block -blockdev driver=null-co,node-name=null -device $dev,drive=null,id=qdev_id
+done
+
+echo
+echo "=== -drive if=none/-device=<node-name> ==="
+echo
+
+# This creates two BlockBackends that will show up in 'info block'!
+# A monitor-owned one from -drive, and anonymous one from -device
+for dev in $fixed $removable; do
+    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=null,id=qdev_id
+done
+
+echo
+echo "=== -drive if=none/-device=<bb-name> (with medium) ==="
+echo
+
+for dev in $fixed $removable; do
+    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=none0
+    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=none0,id=qdev_id
+done
+
+echo
+echo "=== -drive if=none/-device=<bb-name> (without medium) ==="
+echo
+
+check_info_block -drive if=none
+
+for dev in $removable; do
+    check_info_block -drive if=none -device $dev,drive=none0
+    check_info_block -drive if=none -device $dev,drive=none0,id=qdev_id
+done
+
+echo
+echo "=== -drive if=... ==="
+echo
+
+check_info_block -drive if=floppy
+check_info_block -drive if=floppy,driver=null-co
+
+check_info_block -drive if=ide,driver=null-co
+check_info_block -drive if=ide,media=cdrom
+check_info_block -drive if=ide,driver=null-co,media=cdrom
+
+check_info_block -drive if=scsi,driver=null-co
+check_info_block -drive if=scsi,media=cdrom
+check_info_block -drive if=scsi,driver=null-co,media=cdrom
+
+check_info_block -drive if=virtio,driver=null-co
+
+check_info_block -drive if=pflash,driver=null-co,size=1M
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
new file mode 100644
index 0000000..3cf19be
--- /dev/null
+++ b/tests/qemu-iotests/186.out
@@ -0,0 +1,489 @@
+QA output created by 186
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+
+=== Empty drives ===
+
+Testing: -device floppy
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+/machine/peripheral-anon/device[1]: [not inserted]
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -device floppy,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+qdev_id: [not inserted]
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -device ide-cd
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+/machine/peripheral-anon/device[1]: [not inserted]
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -device ide-cd,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+qdev_id: [not inserted]
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -device scsi-cd
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+/machine/peripheral-anon/device[1]: [not inserted]
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -device scsi-cd,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+qdev_id: [not inserted]
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+(qemu) quit
+
+
+=== -blockdev/-device=<node-name> ===
+
+Testing: -blockdev driver=null-co,node-name=null -device ide-hd,drive=null
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device ide-hd,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device scsi-hd,drive=null
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device scsi-hd,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device virtio-blk-pci,drive=null
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device floppy,drive=null
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device floppy,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device ide-cd,drive=null
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device ide-cd,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device scsi-cd,drive=null
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -blockdev driver=null-co,node-name=null -device scsi-cd,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+
+=== -drive if=none/-device=<node-name> ===
+
+Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+
+null: null-co:// (null-co)
+    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=null,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+
+null: null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+
+=== -drive if=none/-device=<bb-name> (with medium) ===
+
+Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      qdev_id
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      qdev_id
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      /machine/peripheral/qdev_id/virtio-backend
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0 (null): null-co:// (null-co)
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+
+=== -drive if=none/-device=<bb-name> (without medium) ===
+
+Testing: -drive if=none
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0: [not inserted]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -drive if=none -device floppy,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0: [not inserted]
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -drive if=none -device floppy,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0: [not inserted]
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -drive if=none -device ide-cd,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0: [not inserted]
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -drive if=none -device ide-cd,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0: [not inserted]
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -drive if=none -device scsi-cd,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0: [not inserted]
+    Attached to:      /machine/peripheral-anon/device[1]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -drive if=none -device scsi-cd,drive=none0,id=qdev_id
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+none0: [not inserted]
+    Attached to:      qdev_id
+    Removable device: not locked, tray closed
+(qemu) quit
+
+
+=== -drive if=... ===
+
+Testing: -drive if=floppy
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+floppy0: [not inserted]
+    Attached to:      /machine/unattached/device[17]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -drive if=floppy,driver=null-co
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+floppy0 (NODE_NAME): null-co:// (null-co)
+    Attached to:      /machine/unattached/device[17]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=ide,driver=null-co
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+ide0-hd0 (NODE_NAME): null-co:// (null-co)
+    Attached to:      /machine/unattached/device[18]
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=ide,media=cdrom
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+ide0-cd0: [not inserted]
+    Attached to:      /machine/unattached/device[18]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+Testing: -drive if=ide,driver=null-co,media=cdrom
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
+    Attached to:      /machine/unattached/device[18]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+qemu: -drive if=scsi,driver=null-co: warning: bus=0,unit=0 is deprecated with this machine type
+Testing: -drive if=scsi,driver=null-co
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+scsi0-hd0 (NODE_NAME): null-co:// (null-co)
+    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
+    Cache mode:       writeback
+(qemu) quit
+
+qemu: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
+Testing: -drive if=scsi,media=cdrom
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+scsi0-cd0: [not inserted]
+    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
+    Removable device: not locked, tray closed
+(qemu) quit
+
+qemu: -drive if=scsi,driver=null-co,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
+Testing: -drive if=scsi,driver=null-co,media=cdrom
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+scsi0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
+    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=virtio,driver=null-co
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+virtio0 (NODE_NAME): null-co:// (null-co)
+    Attached to:      /machine/peripheral-anon/device[1]/virtio-backend
+    Cache mode:       writeback
+(qemu) quit
+
+Testing: -drive if=pflash,driver=null-co,size=1M
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+pflash0 (NODE_NAME): json:{"driver": "null-co", "size": "1M"} (null-co)
+    Attached to:      /machine/unattached/device[2]
+    Cache mode:       writeback
+(qemu) quit
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 318ae74..a6c7e1f 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -176,3 +176,4 @@
 182 rw auto quick
 183 rw auto migration
 185 rw auto
+186 rw auto
-- 
1.8.3.1
