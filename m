Received: from eggs.gnu.org ([209.51.188.92]:50923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gm1wQ-0008TX-0y
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gm1wN-0001UH-W7
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:42:33 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 22 Jan 2019 17:53:21 +0200
Message-Id: <98776952d40d436b2741f6c141ae618bdf6f83a5.1548171741.git.berto@igalia.com>
In-Reply-To: <cover.1548171741.git.berto@igalia.com>
References: <cover.1548171741.git.berto@igalia.com>
In-Reply-To: <cover.1548171741.git.berto@igalia.com>
References: <cover.1548171741.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/3] virtio-scsi: Move BlockBackend back to the
 main AioContext on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This fixes a crash when attaching a disk to a SCSI device using
iothreads, then detaching it and reattaching it again. Test case
included.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/virtio-scsi.c      |  6 ++++
 tests/qemu-iotests/240     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/240.out | 18 ++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 114 insertions(+)
 create mode 100755 tests/qemu-iotests/240
 create mode 100644 tests/qemu-iotests/240.out

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa99717e2..e1f7b208c7 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -824,6 +824,12 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         virtio_scsi_release(s);
     }
 
+    if (s->ctx) {
+        virtio_scsi_acquire(s);
+        blk_set_aio_context(sd->conf.blk, qemu_get_aio_context());
+        virtio_scsi_release(s);
+    }
+
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
 }
 
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
new file mode 100755
index 0000000000..ead7ee08eb
--- /dev/null
+++ b/tests/qemu-iotests/240
@@ -0,0 +1,89 @@
+#!/bin/bash
+#
+# Test hot plugging and unplugging with iothreads
+#
+# Copyright (C) 2019 Igalia, S.L.
+# Author: Alberto Garcia <berto@igalia.com>
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
+owner=berto@igalia.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt generic
+_supported_proto generic
+_supported_os Linux
+
+do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp stdio -serial none "$@"
+    echo
+}
+
+# Remove QMP events from (pretty-printed) output. Doesn't handle
+# nested dicts correctly, but we don't get any of those in this test.
+_filter_qmp_events()
+{
+    tr '\n' '\t' | sed -e \
+	's/{\s*"timestamp":\s*{[^}]*},\s*"event":[^,}]*\(,\s*"data":\s*{[^}]*}\)\?\s*}\s*//g' \
+	| tr '\t' '\n'
+}
+
+run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_qmp | _filter_qmp_events
+}
+
+case "$QEMU_DEFAULT_MACHINE" in
+  s390-ccw-virtio)
+      virtio_scsi=virtio-scsi-ccw
+      ;;
+  *)
+      virtio_scsi=virtio-scsi-pci
+      ;;
+esac
+
+echo
+echo === Unplug a SCSI disk and then plug it again ===
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0"}}
+{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi0"}}
+{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
+{ "execute": "quit"}
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
new file mode 100644
index 0000000000..432d98111c
--- /dev/null
+++ b/tests/qemu-iotests/240.out
@@ -0,0 +1,18 @@
+QA output created by 240
+
+=== Unplug a SCSI disk and then plug it again ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f6b245917a..4671d7a733 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -234,3 +234,4 @@
 234 auto quick migration
 235 auto quick
 236 auto quick
+240 auto quick
-- 
2.11.0
