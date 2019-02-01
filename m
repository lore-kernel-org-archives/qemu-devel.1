Received: from eggs.gnu.org ([209.51.188.92]:39552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboO-00085D-5m
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboL-0000Is-LN
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:03 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:10 +0100
Message-Id: <20190201163518.31157-20-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/27] virtio-scsi: Move BlockBackend back to
 the main AioContext on unplug
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

This fixes a crash when attaching a disk to a SCSI device using
iothreads, then detaching it and reattaching it again. Test case
included.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/virtio-scsi.c      |  6 +++
 tests/qemu-iotests/240     | 89 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/240.out | 18 ++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 114 insertions(+)
 create mode 100755 tests/qemu-iotests/240
 create mode 100644 tests/qemu-iotests/240.out

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa99717e2..e1f7b208c7 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -824,6 +824,12 @@ static void virtio_scsi_hotunplug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
         virtio_scsi_release(s);
     }
=20
+    if (s->ctx) {
+        virtio_scsi_acquire(s);
+        blk_set_aio_context(sd->conf.blk, qemu_get_aio_context());
+        virtio_scsi_release(s);
+    }
+
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
 }
=20
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
+owner=3Dberto@igalia.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
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
+	's/{\s*"timestamp":\s*{[^}]*},\s*"event":[^,}]*\(,\s*"data":\s*{[^}]*}\=
)\?\s*}\s*//g' \
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
+      virtio_scsi=3Dvirtio-scsi-ccw
+      ;;
+  *)
+      virtio_scsi=3Dvirtio-scsi-pci
+      ;;
+esac
+
+echo
+echo =3D=3D=3D Unplug a SCSI disk and then plug it again =3D=3D=3D
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-na=
me": "hd0"}}
+{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${vir=
tio_scsi}", "iothread": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "sc=
si-hd", "drive": "hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "sc=
si-hd", "drive": "hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi0"}}
+{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
+{ "execute": "quit"}
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
new file mode 100644
index 0000000000..432d98111c
--- /dev/null
+++ b/tests/qemu-iotests/240.out
@@ -0,0 +1,18 @@
+QA output created by 240
+
+=3D=3D=3D Unplug a SCSI disk and then plug it again =3D=3D=3D
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
index c87400f497..959ffe85fc 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -237,3 +237,4 @@
 237 rw auto quick
 238 auto quick
 239 rw auto quick
+240 auto quick
--=20
2.20.1
