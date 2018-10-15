Received: from eggs.gnu.org ([2001:4830:134:3::10]:45563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXA-0004Ms-3z
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX7-0004Ha-W6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByX7-000499-Ce
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:25 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:16 +0800
Message-Id: <1539593186-32183-17-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 16/26] filter-rewriter: handle checkpoint and
 failover event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangckid@gmail.com>

After one round of checkpoint, the states between PVM and SVM
become consistent, so it is unnecessary to adjust the sequence
of net packets for old connections, besides, while failover
happens, filter-rewriter will into failover mode that needn't
handle the new TCP connection.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c    | 12 +++++------
 net/colo.c            |  8 ++++++++
 net/colo.h            |  2 ++
 net/filter-rewriter.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 3f7e240..a39191d 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -116,6 +116,12 @@ enum {
     SECONDARY_IN,
 };
 
+static void colo_compare_inconsistency_notify(void)
+{
+    notifier_list_notify(&colo_compare_notifiers,
+                migrate_get_current());
+}
+
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size,
@@ -330,12 +336,6 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spkt,
     return false;
 }
 
-static void colo_compare_inconsistency_notify(void)
-{
-    notifier_list_notify(&colo_compare_notifiers,
-                migrate_get_current());
-}
-
 static void colo_compare_tcp(CompareState *s, Connection *conn)
 {
     Packet *ppkt = NULL, *spkt = NULL;
diff --git a/net/colo.c b/net/colo.c
index 97c8fc9..49176bf 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -221,3 +221,11 @@ Connection *connection_get(GHashTable *connection_track_table,
 
     return conn;
 }
+
+bool connection_has_tracked(GHashTable *connection_track_table,
+                            ConnectionKey *key)
+{
+    Connection *conn = g_hash_table_lookup(connection_track_table, key);
+
+    return conn ? true : false;
+}
diff --git a/net/colo.h b/net/colo.h
index 0277e0e..11c5226 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -98,6 +98,8 @@ void connection_destroy(void *opaque);
 Connection *connection_get(GHashTable *connection_track_table,
                            ConnectionKey *key,
                            GQueue *conn_list);
+bool connection_has_tracked(GHashTable *connection_track_table,
+                            ConnectionKey *key);
 void connection_hashtable_reset(GHashTable *connection_track_table);
 Packet *packet_new(const void *data, int size, int vnet_hdr_len);
 void packet_destroy(void *opaque, void *user_data);
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index dd323fa..bb8f4d9 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -20,11 +20,15 @@
 #include "qemu/main-loop.h"
 #include "qemu/iov.h"
 #include "net/checksum.h"
+#include "net/colo.h"
+#include "migration/colo.h"
 
 #define FILTER_COLO_REWRITER(obj) \
     OBJECT_CHECK(RewriterState, (obj), TYPE_FILTER_REWRITER)
 
 #define TYPE_FILTER_REWRITER "filter-rewriter"
+#define FAILOVER_MODE_ON  true
+#define FAILOVER_MODE_OFF false
 
 typedef struct RewriterState {
     NetFilterState parent_obj;
@@ -32,8 +36,14 @@ typedef struct RewriterState {
     /* hashtable to save connection */
     GHashTable *connection_track_table;
     bool vnet_hdr;
+    bool failover_mode;
 } RewriterState;
 
+static void filter_rewriter_failover_mode(RewriterState *s)
+{
+    s->failover_mode = FAILOVER_MODE_ON;
+}
+
 static void filter_rewriter_flush(NetFilterState *nf)
 {
     RewriterState *s = FILTER_COLO_REWRITER(nf);
@@ -273,6 +283,13 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
              */
             reverse_connection_key(&key);
         }
+
+        /* After failover we needn't change new TCP packet */
+        if (s->failover_mode &&
+            !connection_has_tracked(s->connection_track_table, &key)) {
+            goto out;
+        }
+
         conn = connection_get(s->connection_track_table,
                               &key,
                               NULL);
@@ -306,11 +323,49 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
         }
     }
 
+out:
     packet_destroy(pkt, NULL);
     pkt = NULL;
     return 0;
 }
 
+static void reset_seq_offset(gpointer key, gpointer value, gpointer user_data)
+{
+    Connection *conn = (Connection *)value;
+
+    conn->offset = 0;
+}
+
+static gboolean offset_is_nonzero(gpointer key,
+                                  gpointer value,
+                                  gpointer user_data)
+{
+    Connection *conn = (Connection *)value;
+
+    return conn->offset ? true : false;
+}
+
+static void colo_rewriter_handle_event(NetFilterState *nf, int event,
+                                       Error **errp)
+{
+    RewriterState *rs = FILTER_COLO_REWRITER(nf);
+
+    switch (event) {
+    case COLO_EVENT_CHECKPOINT:
+        g_hash_table_foreach(rs->connection_track_table,
+                            reset_seq_offset, NULL);
+        break;
+    case COLO_EVENT_FAILOVER:
+        if (!g_hash_table_find(rs->connection_track_table,
+                              offset_is_nonzero, NULL)) {
+            filter_rewriter_failover_mode(rs);
+        }
+        break;
+    default:
+        break;
+    }
+}
+
 static void colo_rewriter_cleanup(NetFilterState *nf)
 {
     RewriterState *s = FILTER_COLO_REWRITER(nf);
@@ -354,6 +409,7 @@ static void filter_rewriter_init(Object *obj)
     RewriterState *s = FILTER_COLO_REWRITER(obj);
 
     s->vnet_hdr = false;
+    s->failover_mode = FAILOVER_MODE_OFF;
     object_property_add_bool(obj, "vnet_hdr_support",
                              filter_rewriter_get_vnet_hdr,
                              filter_rewriter_set_vnet_hdr, NULL);
@@ -366,6 +422,7 @@ static void colo_rewriter_class_init(ObjectClass *oc, void *data)
     nfc->setup = colo_rewriter_setup;
     nfc->cleanup = colo_rewriter_cleanup;
     nfc->receive_iov = colo_rewriter_receive_iov;
+    nfc->handle_event = colo_rewriter_handle_event;
 }
 
 static const TypeInfo colo_rewriter_info = {
-- 
2.5.0
