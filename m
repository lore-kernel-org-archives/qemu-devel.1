Received: from eggs.gnu.org ([2001:4830:134:3::10]:56262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1euIkB-0004SO-FC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1euIk6-0001MD-GN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:11:35 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  9 Mar 2018 16:11:07 +0200
Message-Id: <20180309141107.13964-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] hmp: Allow using a qdev id in
 block_set_io_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The QMP version of this command can take a qdev ID since 7a9877a02635,
but the HMP version is still using the deprecated block device name so
there's no way to refer to a block device added like this:

  -blockdev node-name=disk0,driver=qcow2,file.driver=file,file.filename=hd.qcow2
  -device virtio-blk-pci,id=virtio-blk-pci0,drive=disk0

This patch works around this problem by using the specified name as a
qdev ID if the block device name is not found.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hmp-commands.hx |  3 ++-
 hmp.c           | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 964eb515cf..097ed0909b 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1645,7 +1645,8 @@ ETEXI
 STEXI
 @item block_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
 @findex block_set_io_throttle
-Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}.
+@var{device} can be a block device name, a qdev ID or a QOM path.
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index 016cb5c4f1..8520d86869 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1774,9 +1774,8 @@ void hmp_change(Monitor *mon, const QDict *qdict)
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
@@ -1785,6 +1784,17 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
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
-- 
2.11.0
