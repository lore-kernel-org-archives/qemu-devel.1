Received: from eggs.gnu.org ([209.51.188.92]:54231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3At-0001jG-QZ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Ao-0008VX-Dg
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:25:11 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 14 Jan 2019 16:23:59 +0200
Message-Id: <5086004667e4a962e10e29ccb402705d0962dbcf.1547475602.git.berto@igalia.com>
In-Reply-To: <cover.1547475602.git.berto@igalia.com>
References: <cover.1547475602.git.berto@igalia.com>
In-Reply-To: <cover.1547475602.git.berto@igalia.com>
References: <cover.1547475602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 1/6] block: Acquire the AioContext in
 virtio_blk_device_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>

This fixes a crash when adding a virtio-blk device with a drive that
is using an iothread. Test case included.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/block/virtio-blk.c      | 22 ++++++++-----
 tests/qemu-iotests/236     | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/236.out | 16 ++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 110 insertions(+), 7 deletions(-)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f208c6ddb9..5357da82af 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -912,6 +912,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
+    AioContext *ctx;
     Error *err = NULL;
     unsigned i;
 
@@ -919,30 +920,34 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "drive property not set");
         return;
     }
+
+    ctx = blk_get_aio_context(conf->conf.blk);
+    aio_context_acquire(ctx);
+
     if (!blk_is_inserted(conf->conf.blk)) {
         error_setg(errp, "Device needs media, but drive is empty");
-        return;
+        goto out;
     }
     if (!conf->num_queues) {
         error_setg(errp, "num-queues property must be larger than 0");
-        return;
+        goto out;
     }
     if (!is_power_of_2(conf->queue_size) ||
         conf->queue_size > VIRTQUEUE_MAX_SIZE) {
         error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
                    "must be a power of 2 (max %d)",
                    conf->queue_size, VIRTQUEUE_MAX_SIZE);
-        return;
+        goto out;
     }
 
     if (!blkconf_apply_backend_options(&conf->conf,
                                        blk_is_read_only(conf->conf.blk), true,
                                        errp)) {
-        return;
+        goto out;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
     if (!blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, errp)) {
-        return;
+        goto out;
     }
 
     blkconf_blocksizes(&conf->conf);
@@ -951,7 +956,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         conf->conf.physical_block_size) {
         error_setg(errp,
                    "logical_block_size > physical_block_size not supported");
-        return;
+        goto out;
     }
 
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
@@ -968,7 +973,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     if (err != NULL) {
         error_propagate(errp, err);
         virtio_cleanup(vdev);
-        return;
+        goto out;
     }
 
     s->change = qemu_add_vm_change_state_handler(virtio_blk_dma_restart_cb, s);
@@ -976,6 +981,9 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);
 
     blk_iostatus_enable(s->blk);
+
+out:
+    aio_context_release(ctx);
 }
 
 static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
new file mode 100755
index 0000000000..c6a3415ffe
--- /dev/null
+++ b/tests/qemu-iotests/236
@@ -0,0 +1,78 @@
+#!/bin/bash
+#
+# Test deletion of devices that are using iothreads
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
+echo
+echo === Try adding and removing a virtio-blk device ===
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0"}}
+{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
+{ "execute": "x-blockdev-set-iothread", "arguments": {"node-name": "hd0", "iothread": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "virtio-blk0", "driver": "virtio-blk", "drive": "hd0"}}
+{ "execute": "device_del", "arguments": {"id": "virtio-blk0"}}
+{ "execute": "system_reset"}
+{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
+{ "execute": "quit"}}
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
new file mode 100644
index 0000000000..01ee7b0b0d
--- /dev/null
+++ b/tests/qemu-iotests/236.out
@@ -0,0 +1,16 @@
+QA output created by 236
+
+=== Try adding and removing a virtio-blk device ===
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
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 61a6d98ebd..f6b245917a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+236 auto quick
-- 
2.11.0
