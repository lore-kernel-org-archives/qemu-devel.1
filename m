Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQCF-0005Sq-9q
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQCB-0006gI-Bo
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:49:03 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Fri, 20 Jan 2017 11:47:56 +0800
Message-ID: <1484884080-28836-3-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/6] replication: add shared-disk and
 shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric
	Blake <eblake@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>

We use these two options to identify which disk is
shared

Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
v3:
- Move g_free(s->shared_disk_id) to the common fail process place (Stefan)
- Fix comments for these two options
---
 block/replication.c  | 37 +++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 10 +++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/block/replication.c b/block/replication.c
index 729dd12..b96a3e5 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -25,9 +25,12 @@
 typedef struct BDRVReplicationState {
     ReplicationMode mode;
     int replication_state;
+    bool is_shared_disk;
+    char *shared_disk_id;
     BdrvChild *active_disk;
     BdrvChild *hidden_disk;
     BdrvChild *secondary_disk;
+    BdrvChild *primary_disk;
     char *top_id;
     ReplicationState *rs;
     Error *blocker;
@@ -53,6 +56,9 @@ static void replication_stop(ReplicationState *rs, bool failover,
 
 #define REPLICATION_MODE        "mode"
 #define REPLICATION_TOP_ID      "top-id"
+#define REPLICATION_SHARED_DISK "shared-disk"
+#define REPLICATION_SHARED_DISK_ID "shared-disk-id"
+
 static QemuOptsList replication_runtime_opts = {
     .name = "replication",
     .head = QTAILQ_HEAD_INITIALIZER(replication_runtime_opts.head),
@@ -65,6 +71,14 @@ static QemuOptsList replication_runtime_opts = {
             .name = REPLICATION_TOP_ID,
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = REPLICATION_SHARED_DISK_ID,
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = REPLICATION_SHARED_DISK,
+            .type = QEMU_OPT_BOOL,
+        },
         { /* end of list */ }
     },
 };
@@ -85,6 +99,9 @@ static int replication_open(BlockDriverState *bs, QDict *options,
     QemuOpts *opts = NULL;
     const char *mode;
     const char *top_id;
+    const char *shared_disk_id;
+    BlockBackend *blk;
+    BlockDriverState *tmp_bs;
 
     ret = -EINVAL;
     opts = qemu_opts_create(&replication_runtime_opts, NULL, 0, &error_abort);
@@ -119,12 +136,31 @@ static int replication_open(BlockDriverState *bs, QDict *options,
                    "The option mode's value should be primary or secondary");
         goto fail;
     }
+    s->is_shared_disk = qemu_opt_get_bool(opts, REPLICATION_SHARED_DISK,
+                                          false);
+    if (s->is_shared_disk && (s->mode == REPLICATION_MODE_PRIMARY)) {
+        shared_disk_id = qemu_opt_get(opts, REPLICATION_SHARED_DISK_ID);
+        if (!shared_disk_id) {
+            error_setg(&local_err, "Missing shared disk blk option");
+            goto fail;
+        }
+        s->shared_disk_id = g_strdup(shared_disk_id);
+        blk = blk_by_name(s->shared_disk_id);
+        if (!blk) {
+            error_setg(&local_err, "There is no %s block", s->shared_disk_id);
+            goto fail;
+        }
+        /* We can't access root member of BlockBackend directly */
+        tmp_bs = blk_bs(blk);
+        s->primary_disk = QLIST_FIRST(&tmp_bs->parents);
+    }
 
     s->rs = replication_new(bs, &replication_ops);
 
     ret = 0;
 
 fail:
+    g_free(s->shared_disk_id);
     qemu_opts_del(opts);
     error_propagate(errp, local_err);
 
@@ -135,6 +171,7 @@ static void replication_close(BlockDriverState *bs)
 {
     BDRVReplicationState *s = bs->opaque;
 
+    g_free(s->shared_disk_id);
     if (s->replication_state == BLOCK_REPLICATION_RUNNING) {
         replication_stop(s->rs, false, NULL);
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1b3e6eb..e9fecda 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2624,12 +2624,20 @@
 #          node who owns the replication node chain. Must not be given in
 #          primary mode.
 #
+# @shared-disk-id: #optional id of shared disk while is replication mode,
+#                  if @shared-disk is true, this option is required (Since: 2.9)
+#
+# @shared-disk: #optional (The default is false) to indicate whether or not
+#               a disk is shared by primary VM and secondary VM. (Since: 2.9)
+#
 # Since: 2.8
 ##
 { 'struct': 'BlockdevOptionsReplication',
   'base': 'BlockdevOptionsGenericFormat',
   'data': { 'mode': 'ReplicationMode',
-            '*top-id': 'str' } }
+            '*top-id': 'str',
+            '*shared-disk-id': 'str',
+            '*shared-disk': 'bool' } }
 
 ##
 # @NFSTransport:
-- 
1.8.3.1
