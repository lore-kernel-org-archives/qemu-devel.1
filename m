Received: from eggs.gnu.org ([2001:4830:134:3::10]:45923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePVLc-00031n-Ji
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePVLY-00032R-GZ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ePVLY-000310-7o
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:52 -0500
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 14 Dec 2017 16:22:45 +0100
Message-Id: <20171214152246.17503-2-hare@suse.de>
In-Reply-To: <20171214152246.17503-1-hare@suse.de>
References: <20171214152246.17503-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 1/2] block: implement shared block device count
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

By setting 'locking=off' when creating a 'file' format drive one
can simulate a multipath setup. This patch adds infrastructure
for tracking shared block devices.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block.c                   | 36 ++++++++++++++++++++++++++++++++++++
 hw/scsi/scsi-disk.c       |  6 ++++++
 include/block/block.h     |  2 ++
 include/block/block_int.h |  2 ++
 4 files changed, 46 insertions(+)

diff --git a/block.c b/block.c
index 9a1a0d1e73..cf8b94252c 100644
--- a/block.c
+++ b/block.c
@@ -3801,6 +3801,42 @@ BlockDriverState *bdrv_find_node(const char *node_name)
     return NULL;
 }
 
+void bdrv_find_shared(BlockDriverState *bs)
+{
+    BlockDriverState *tmp_bs;
+    int max_shared_no = 0;
+    unsigned long shared_bits = 0;
+
+    if (!bs->filename)
+        return;
+    QTAILQ_FOREACH(tmp_bs, &graph_bdrv_states, node_list) {
+        if (tmp_bs == bs)
+            continue;
+        if (!strcmp(bs->filename, tmp_bs->filename)) {
+            if (tmp_bs->shared_no > 0) {
+                set_bit(tmp_bs->shared_no - 1, &shared_bits);
+            }
+            max_shared_no++;
+        }
+    }
+    if (max_shared_no > 0) {
+        int bit;
+
+        QTAILQ_FOREACH(tmp_bs, &graph_bdrv_states, node_list) {
+            if (!strcmp(bs->filename, tmp_bs->filename) && !tmp_bs->shared_no) {
+                bit = find_first_zero_bit(&shared_bits, sizeof(unsigned long));
+                tmp_bs->shared_no = bit + 1;
+                set_bit(bit, &shared_bits);
+            }
+        }
+    }
+}
+
+int bdrv_get_shared(BlockDriverState *bs)
+{
+    return bs->shared_no;
+}
+
 /* Put this QMP function here so it can access the static graph_bdrv_states. */
 BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp)
 {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 12431177a7..32c1d656b1 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2333,6 +2333,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
     Error *err = NULL;
+    int port_no;
 
     if (!s->qdev.conf.blk) {
         error_setg(errp, "drive property not set");
@@ -2396,6 +2397,11 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     blk_set_guest_block_size(s->qdev.conf.blk, s->qdev.blocksize);
 
     blk_iostatus_enable(s->qdev.conf.blk);
+    bdrv_find_shared(blk_bs(s->qdev.conf.blk));
+    port_no = bdrv_get_shared(blk_bs(s->qdev.conf.blk));
+    if (port_no && !s->port_index) {
+        s->port_index = port_no;
+    }
 }
 
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
diff --git a/include/block/block.h b/include/block/block.h
index c05cac57e5..5c03c1acfa 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -443,6 +443,8 @@ void bdrv_lock_medium(BlockDriverState *bs, bool locked);
 void bdrv_eject(BlockDriverState *bs, bool eject_flag);
 const char *bdrv_get_format_name(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
+void bdrv_find_shared(BlockDriverState *bs);
+int bdrv_get_shared(BlockDriverState *bs);
 BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a5482775ec..79c9c3a3aa 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -634,6 +634,8 @@ struct BlockDriverState {
     /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
      * BDRV_REQ_MAY_UNMAP) */
     unsigned int supported_zero_flags;
+    /* Shared instance count */
+    unsigned int shared_no;
 
     /* the following member gives a name to every node on the bs graph. */
     char node_name[32];
-- 
2.12.3
