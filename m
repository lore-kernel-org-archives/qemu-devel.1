Received: from eggs.gnu.org ([2001:4830:134:3::10]:52710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flW9s-0001OF-HY
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flW9q-0001FV-Ox
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:04 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1flW9q-0001Do-H6
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:02 -0400
Received: by mail-pg1-x542.google.com with SMTP id y5-v6so2578927pgv.1
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 02:14:02 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Fri,  3 Aug 2018 17:13:40 +0800
Message-Id: <1533287630-4221-3-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
References: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v6 02/12] migration: create a dedicated
 connection for rdma return path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

If start a RDMA migration with postcopy enabled, the source qemu
establish a dedicated connection for return path.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76424a5..57af5ed 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -387,6 +387,10 @@ typedef struct RDMAContext {
     uint64_t unregistrations[RDMA_SIGNALED_SEND_MAX];
 
     GHashTable *blockmap;
+
+    /* the RDMAContext for return path */
+    struct RDMAContext *return_path;
+    bool is_return_path;
 } RDMAContext;
 
 #define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
@@ -2323,10 +2327,22 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
         rdma_destroy_id(rdma->cm_id);
         rdma->cm_id = NULL;
     }
+
+    /* the destination side, listen_id and channel is shared */
     if (rdma->listen_id) {
-        rdma_destroy_id(rdma->listen_id);
+        if (!rdma->is_return_path) {
+            rdma_destroy_id(rdma->listen_id);
+        }
         rdma->listen_id = NULL;
+
+        if (rdma->channel) {
+            if (!rdma->is_return_path) {
+                rdma_destroy_event_channel(rdma->channel);
+            }
+            rdma->channel = NULL;
+        }
     }
+
     if (rdma->channel) {
         rdma_destroy_event_channel(rdma->channel);
         rdma->channel = NULL;
@@ -2555,6 +2571,25 @@ err_dest_init_create_listen_id:
 
 }
 
+static void qemu_rdma_return_path_dest_init(RDMAContext *rdma_return_path,
+                                            RDMAContext *rdma)
+{
+    int idx;
+
+    for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
+        rdma_return_path->wr_data[idx].control_len = 0;
+        rdma_return_path->wr_data[idx].control_curr = NULL;
+    }
+
+    /*the CM channel and CM id is shared*/
+    rdma_return_path->channel = rdma->channel;
+    rdma_return_path->listen_id = rdma->listen_id;
+
+    rdma->return_path = rdma_return_path;
+    rdma_return_path->return_path = rdma;
+    rdma_return_path->is_return_path = true;
+}
+
 static void *qemu_rdma_data_init(const char *host_port, Error **errp)
 {
     RDMAContext *rdma = NULL;
@@ -3012,6 +3047,8 @@ err:
     return ret;
 }
 
+static void rdma_accept_incoming_migration(void *opaque);
+
 static int qemu_rdma_accept(RDMAContext *rdma)
 {
     RDMACapabilities cap;
@@ -3106,7 +3143,14 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         }
     }
 
-    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
+    /* Accept the second connection request for return path */
+    if (migrate_postcopy() && !rdma->is_return_path) {
+        qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
+                            NULL,
+                            (void *)(intptr_t)rdma->return_path);
+    } else {
+        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
+    }
 
     ret = rdma_accept(rdma->cm_id, &conn_param);
     if (ret) {
@@ -3691,6 +3735,10 @@ static void rdma_accept_incoming_migration(void *opaque)
 
     trace_qemu_rdma_accept_incoming_migration_accepted();
 
+    if (rdma->is_return_path) {
+        return;
+    }
+
     f = qemu_fopen_rdma(rdma, "rb");
     if (f == NULL) {
         ERROR(errp, "could not qemu_fopen_rdma!");
@@ -3705,7 +3753,7 @@ static void rdma_accept_incoming_migration(void *opaque)
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
 {
     int ret;
-    RDMAContext *rdma;
+    RDMAContext *rdma, *rdma_return_path;
     Error *local_err = NULL;
 
     trace_rdma_start_incoming_migration();
@@ -3732,12 +3780,24 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
 
     trace_rdma_start_incoming_migration_after_rdma_listen();
 
+    /* initialize the RDMAContext for return path */
+    if (migrate_postcopy()) {
+        rdma_return_path = qemu_rdma_data_init(host_port, &local_err);
+
+        if (rdma_return_path == NULL) {
+            goto err;
+        }
+
+        qemu_rdma_return_path_dest_init(rdma_return_path, rdma);
+    }
+
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
                         NULL, (void *)(intptr_t)rdma);
     return;
 err:
     error_propagate(errp, local_err);
     g_free(rdma);
+    g_free(rdma_return_path);
 }
 
 void rdma_start_outgoing_migration(void *opaque,
@@ -3745,6 +3805,7 @@ void rdma_start_outgoing_migration(void *opaque,
 {
     MigrationState *s = opaque;
     RDMAContext *rdma = qemu_rdma_data_init(host_port, errp);
+    RDMAContext *rdma_return_path = NULL;
     int ret = 0;
 
     if (rdma == NULL) {
@@ -3765,6 +3826,32 @@ void rdma_start_outgoing_migration(void *opaque,
         goto err;
     }
 
+    /* RDMA postcopy need a seprate queue pair for return path */
+    if (migrate_postcopy()) {
+        rdma_return_path = qemu_rdma_data_init(host_port, errp);
+
+        if (rdma_return_path == NULL) {
+            goto err;
+        }
+
+        ret = qemu_rdma_source_init(rdma_return_path,
+            s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL], errp);
+
+        if (ret) {
+            goto err;
+        }
+
+        ret = qemu_rdma_connect(rdma_return_path, errp);
+
+        if (ret) {
+            goto err;
+        }
+
+        rdma->return_path = rdma_return_path;
+        rdma_return_path->return_path = rdma;
+        rdma_return_path->is_return_path = true;
+    }
+
     trace_rdma_start_outgoing_migration_after_rdma_connect();
 
     s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
@@ -3772,4 +3859,5 @@ void rdma_start_outgoing_migration(void *opaque,
     return;
 err:
     g_free(rdma);
+    g_free(rdma_return_path);
 }
-- 
1.8.3.1
