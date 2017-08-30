Received: from eggs.gnu.org ([2001:4830:134:3::10]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Nd-0001wo-3y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Nc-0000SM-6g
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:02:17 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 13:01:42 -0400
Message-Id: <8a9d17a953caedcb66655d945181457eccde9acd.1504112256.git.jcody@redhat.com>
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] hmp: Optionally disable live block
 operations in HMP monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, dgilbert@redhat.com, mrezanin@redhat.com, ehabkost@redhat.com, peterx@redhat.com, jsnow@redhat.com

From: Jeffrey Cody <jcody@redhat.com>

If live block operations are disabled, disable the corresponding
HMP commands.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 hmp-commands-info.hx |  4 ++++
 hmp-commands.hx      | 12 ++++++++++++
 hmp.c                | 12 ++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d9df238..0967e41 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -84,6 +84,8 @@ STEXI
 Show block device statistics.
 ETEXI
 
+#ifdef CONFIG_LIVE_BLOCK_OPS
+
     {
         .name       = "block-jobs",
         .args_type  = "",
@@ -98,6 +100,8 @@ STEXI
 Show progress of ongoing block device operations.
 ETEXI
 
+#endif /* CONFIG_LIVE_BLOCK_OPS */
+
     {
         .name       = "registers",
         .args_type  = "cpustate_all:-a",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19..2d137a1 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -73,6 +73,8 @@ but should be used with extreme caution.  Note that this command only
 resizes image files, it can not resize block devices like LVM volumes.
 ETEXI
 
+#ifdef CONFIG_LIVE_BLOCK_OPS
+
     {
         .name       = "block_stream",
         .args_type  = "device:B,speed:o?,base:s?",
@@ -159,6 +161,8 @@ STEXI
 Resume a paused block streaming operation.
 ETEXI
 
+#endif /* CONFIG_LIVE_BLOCK_OPS */
+
     {
         .name       = "eject",
         .args_type  = "force:-f,device:B",
@@ -1169,6 +1173,8 @@ STEXI
 Enables or disables migration mode.
 ETEXI
 
+#ifdef CONFIG_LIVE_BLOCK_OPS
+
     {
         .name       = "snapshot_blkdev",
         .args_type  = "reuse:-n,device:B,snapshot-file:s?,format:s?",
@@ -1190,6 +1196,8 @@ STEXI
 Snapshot device, using snapshot file as target if provided
 ETEXI
 
+#endif /* CONFIG_LIVE_BLOCK_OPS */
+
     {
         .name       = "snapshot_blkdev_internal",
         .args_type  = "device:B,name:s",
@@ -1224,6 +1232,8 @@ STEXI
 Delete an internal snapshot on device if it support
 ETEXI
 
+#ifdef CONFIG_LIVE_BLOCK_OPS
+
     {
         .name       = "drive_mirror",
         .args_type  = "reuse:-n,full:-f,device:B,target:s,format:s?",
@@ -1267,6 +1277,8 @@ STEXI
 Start a point-in-time copy of a block device to a specificed target.
 ETEXI
 
+#endif /* CONFIG_LIVE_BLOCK_OPS */
+
     {
         .name       = "drive_add",
         .args_type  = "node:-n,pci_addr:s,opts:s",
diff --git a/hmp.c b/hmp.c
index fd80dce..ab985c6 100644
--- a/hmp.c
+++ b/hmp.c
@@ -951,6 +951,8 @@ void hmp_info_pci(Monitor *mon, const QDict *qdict)
     qapi_free_PciInfoList(info_list);
 }
 
+#ifdef CONFIG_LIVE_BLOCK_OPS
+
 void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
 {
     BlockJobInfoList *list;
@@ -989,6 +991,8 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
     qapi_free_BlockJobInfoList(list);
 }
 
+#endif /* CONFIG_LIVE_BLOCK_OPS */
+
 void hmp_info_tpm(Monitor *mon, const QDict *qdict)
 {
     TPMInfoList *info_list, *info;
@@ -1197,6 +1201,8 @@ void hmp_block_resize(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+#ifdef CONFIG_LIVE_BLOCK_OPS
+
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
 {
     const char *filename = qdict_get_str(qdict, "target");
@@ -1280,6 +1286,8 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+#endif /* CONFIG_LIVE_BLOCK_OPS */
+
 void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_str(qdict, "device");
@@ -1776,6 +1784,8 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+#ifdef CONFIG_LIVE_BLOCK_OPS
+
 void hmp_block_stream(Monitor *mon, const QDict *qdict)
 {
     Error *error = NULL;
@@ -1842,6 +1852,8 @@ void hmp_block_job_complete(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &error);
 }
 
+#endif /* CONFIG_LIVE_BLOCK_OPS */
+
 typedef struct HMPMigrationStatus
 {
     QEMUTimer *timer;
-- 
2.9.5
