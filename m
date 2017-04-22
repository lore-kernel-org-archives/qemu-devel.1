Received: from eggs.gnu.org ([2001:4830:134:3::10]:34354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXe-0001W4-RB
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXe-00049Z-4M
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3852
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXd-00046e-HJ
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:18 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:27 +0800
Message-ID: <1492850128-17472-18-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 17/18] filter-rewriter: handle
 checkpoint and failover event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

After one round of checkpoint, the states between PVM and SVM
become consistent, so it is unnecessary to adjust the sequence
of net packets for old connections, besides, while failover
happens, filter-rewriter needs to check if it still needs to
adjust sequence of net packets.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/filter-rewriter.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index c9a6d43..0a90b11 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -22,6 +22,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/iov.h"
 #include "net/checksum.h"
+#include "net/colo.h"
 
 #define FILTER_COLO_REWRITER(obj) \
     OBJECT_CHECK(RewriterState, (obj), TYPE_FILTER_REWRITER)
@@ -270,6 +271,43 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
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
+    case COLO_CHECKPOINT:
+        g_hash_table_foreach(rs->connection_track_table,
+                            reset_seq_offset, NULL);
+        break;
+    case COLO_FAILOVER:
+        if (!g_hash_table_find(rs->connection_track_table,
+                              offset_is_nonzero, NULL)) {
+            object_property_set_str(OBJECT(nf), "off", "status", errp);
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
@@ -299,6 +337,7 @@ static void colo_rewriter_class_init(ObjectClass *oc, void *data)
     nfc->setup = colo_rewriter_setup;
     nfc->cleanup = colo_rewriter_cleanup;
     nfc->receive_iov = colo_rewriter_receive_iov;
+    nfc->handle_event = colo_rewriter_handle_event;
 }
 
 static const TypeInfo colo_rewriter_info = {
-- 
1.8.3.1
