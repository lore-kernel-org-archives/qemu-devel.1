Received: from eggs.gnu.org ([2001:4830:134:3::10]:45921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePVLc-00031k-JY
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePVLY-00032W-Gu
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:32861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ePVLY-000311-7t
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:52 -0500
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 14 Dec 2017 16:22:46 +0100
Message-Id: <20171214152246.17503-3-hare@suse.de>
In-Reply-To: <20171214152246.17503-1-hare@suse.de>
References: <20171214152246.17503-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 2/2] scsi: Implement multipath support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

Implement simple multipath support based on the shared block device
feature. Whenever a shared device is detected the scsi-disk driver
will report a simple ALUA setup with all paths in active/optimized.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block.c                  | 15 +++++++++++
 hw/scsi/scsi-disk.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h    |  1 +
 include/scsi/constants.h |  5 ++++
 4 files changed, 87 insertions(+)

diff --git a/block.c b/block.c
index cf8b94252c..e0643989e5 100644
--- a/block.c
+++ b/block.c
@@ -3837,6 +3837,21 @@ int bdrv_get_shared(BlockDriverState *bs)
     return bs->shared_no;
 }
 
+void bdrv_shared_mask(BlockDriverState *bs, unsigned long *shared_mask)
+{
+    BlockDriverState *tmp_bs;
+
+    if (!bs->filename || !shared_mask)
+        return;
+    QTAILQ_FOREACH(tmp_bs, &graph_bdrv_states, node_list) {
+        if (!strcmp(bs->filename, tmp_bs->filename)) {
+            if (tmp_bs->shared_no > 0) {
+                set_bit(tmp_bs->shared_no - 1, shared_mask);
+            }
+        }
+    }
+}
+
 /* Put this QMP function here so it can access the static graph_bdrv_states. */
 BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp)
 {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 32c1d656b1..b73fcafc29 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -676,6 +676,13 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
                 buflen += 8;
             }
 
+            if (bdrv_get_shared(blk_bs(s->qdev.conf.blk))) {
+                outbuf[buflen++] = 0x61; // SAS / Binary
+                outbuf[buflen++] = 0x95; // PIV / Target port / target port group
+                outbuf[buflen++] = 0; // reserved
+                outbuf[buflen++] = 4;
+                buflen += 4;
+            }
             if (s->port_index) {
                 outbuf[buflen++] = 0x61; // SAS / Binary
                 outbuf[buflen++] = 0x94; // PIV / Target port / relative target port
@@ -819,6 +826,11 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
         outbuf[4] = 36 - 5;
     }
 
+    /* Enable TGPS bit */
+    if (bdrv_get_shared(blk_bs(s->qdev.conf.blk))) {
+        outbuf[5] = 0x10;
+    }
+
     /* Sync data transfer and TCQ.  */
     outbuf[7] = 0x10 | (req->bus->info->tcq ? 0x02 : 0);
     return buflen;
@@ -1869,6 +1881,47 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
     }
 }
 
+static int scsi_emulate_report_target_port_groups(SCSIDiskState *s,
+                                                  uint8_t *inbuf)
+{
+    uint8_t *p, *pg;
+    int buflen = 0, i, count = 0;
+    unsigned long shared_mask = 0;
+
+    if (!bdrv_get_shared(blk_bs(s->qdev.conf.blk))) {
+        return -1;
+    }
+
+    bdrv_shared_mask(blk_bs(s->qdev.conf.blk), &shared_mask);
+    if (!shared_mask) {
+        return -1;
+    }
+
+    pg = &inbuf[4];
+    pg[0] = 0; /* Active/Optimized */
+    pg[1] = 0x1; /* Only Active/Optimized is supported */
+
+    p = &pg[8];
+    buflen += 8;
+    for (i = 0; i < 32; i++) {
+        if (!test_bit(i, &shared_mask))
+            continue;
+        p[2] = (i + 1) >> 8;
+        p[3] = (i + 1) & 0xFF;
+        p += 4;
+        buflen += 4;
+        count++;
+    }
+    pg[7] = count;
+
+    inbuf[0] = (buflen >> 24) & 0xff;
+    inbuf[1] = (buflen >> 16) & 0xff;
+    inbuf[2] = (buflen >> 8) & 0xff;
+    inbuf[3] = buflen & 0xff;
+
+    return buflen + 4;
+}
+
 static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
@@ -2010,6 +2063,19 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
             goto illegal_request;
         }
         break;
+    case MAINTENANCE_IN:
+        if ((req->cmd.buf[1] & 31) == MI_REPORT_TARGET_PORT_GROUPS) {
+            DPRINTF("MI REPORT TARGET PORT GROUPS\n");
+            memset(outbuf, 0, req->cmd.xfer);
+            buflen = scsi_emulate_report_target_port_groups(s, outbuf);
+            if (buflen < 0) {
+                goto illegal_request;
+            }
+            break;
+        }
+        DPRINTF("Unsupported Maintenance In\n");
+        goto illegal_request;
+        break;
     case MECHANISM_STATUS:
         buflen = scsi_emulate_mechanism_status(s, outbuf);
         if (buflen < 0) {
diff --git a/include/block/block.h b/include/block/block.h
index 5c03c1acfa..b31e033702 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -445,6 +445,7 @@ const char *bdrv_get_format_name(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
 void bdrv_find_shared(BlockDriverState *bs);
 int bdrv_get_shared(BlockDriverState *bs);
+void bdrv_shared_mask(BlockDriverState *bs, unsigned long *shared_mask);
 BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index a141dd71f8..38ed4b35e4 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -156,6 +156,11 @@
 #define SAI_READ_CAPACITY_16  0x10
 
 /*
+ * MAINTENANCE IN subcodes
+ */
+#define MI_REPORT_TARGET_PORT_GROUPS 0xa
+
+/*
  * READ POSITION service action codes
  */
 #define SHORT_FORM_BLOCK_ID  0x00
-- 
2.12.3
