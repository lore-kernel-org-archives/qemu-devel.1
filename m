Received: from eggs.gnu.org ([2001:4830:134:3::10]:38673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4P-0006dl-Ed
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4J-0001LO-BI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:57 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:05 +0200
Message-Id: <20180515154033.19899-10-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/37] hmp: Allow using a qdev id in
 block_set_io_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

The QMP version of this command can take a qdev ID since 7a9877a02635,
but the HMP version is still using the deprecated block device name so
there's no way to refer to a block device added like this:

  -blockdev node-name=disk0,driver=qcow2,file.driver=file,file.filename=hd.qcow2
  -device virtio-blk-pci,id=virtio-blk-pci0,drive=disk0

This patch works around this problem by using the specified name as a
qdev ID if the block device name is not found.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hmp.c           | 14 ++++++++++++--
 hmp-commands.hx |  3 ++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 898e25f3e1..bdb340605c 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1789,9 +1789,8 @@ void hmp_change(Monitor *mon, const QDict *qdict)
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
+    char *device = (char *) qdict_get_str(qdict, "device");
     BlockIOThrottle throttle = {
-        .has_device = true,
-        .device = (char *) qdict_get_str(qdict, "device"),
         .bps = qdict_get_int(qdict, "bps"),
         .bps_rd = qdict_get_int(qdict, "bps_rd"),
         .bps_wr = qdict_get_int(qdict, "bps_wr"),
@@ -1800,6 +1799,17 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
         .iops_wr = qdict_get_int(qdict, "iops_wr"),
     };
 
+    /* qmp_block_set_io_throttle has separate parameters for the
+     * (deprecated) block device name and the qdev ID but the HMP
+     * version has only one, so we must decide which one to pass. */
+    if (blk_by_name(device)) {
+        throttle.has_device = true;
+        throttle.device = device;
+    } else {
+        throttle.has_id = true;
+        throttle.id = device;
+    }
+
     qmp_block_set_io_throttle(&throttle, &err);
     hmp_handle_error(mon, &err);
 }
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 35d862a5d2..227f7eee88 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1647,7 +1647,8 @@ ETEXI
 STEXI
 @item block_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
 @findex block_set_io_throttle
-Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}.
+@var{device} can be a block device name, a qdev ID or a QOM path.
 ETEXI
 
     {
-- 
2.13.6
