Received: from eggs.gnu.org ([2001:4830:134:3::10]:56143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAEs-0004qp-Rq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAEr-0005Bu-Rl
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:24:26 -0500
Received: from [59.151.112.132] (port=5135 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chAEr-0005Be-FH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:24:25 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 24 Feb 2017 15:22:51 +0800
Message-ID: <1487920971-16519-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V9 2/2] Add a new qmp command to do checkpoint,
 query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

We can call this qmp command to do checkpoint outside of qemu.
Xen colo will need this function.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Wen Congyang <wencongyang@gmail.com>
---
 migration/colo.c | 23 +++++++++++++++++++++++
 qapi-schema.json | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 0114899..2b241b4 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -130,6 +130,29 @@ void qmp_xen_set_replication(bool enable, bool primary,
     }
 }
 
+ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
+{
+    Error *err = NULL;
+    ReplicationStatus *s = g_new0(ReplicationStatus, 1);
+
+    replication_get_error_all(&err);
+    if (err) {
+        s->error = true;
+        s->has_desc = true;
+        s->desc = g_strdup(error_get_pretty(err));
+    } else {
+        s->error = false;
+    }
+
+    error_free(err);
+    return s;
+}
+
+void qmp_xen_colo_do_checkpoint(Error **errp)
+{
+    replication_do_checkpoint_all(errp);
+}
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi-schema.json b/qapi-schema.json
index 9445b93..1310f61 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5931,6 +5931,55 @@
   'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
 
 ##
+# @ReplicationStatus:
+#
+# The result format for 'query-xen-replication-status'.
+#
+# @error: true to error, false to normal.
+#
+# @desc: #optional the human readable error description string, when
+#        @error is 'true'.
+#
+# Since: 2.9
+##
+{ 'struct': 'ReplicationStatus',
+  'data': { 'error': 'bool', '*desc': 'str' } }
+
+##
+# @query-xen-replication-status:
+#
+# Query replication status while the vm is running.
+#
+# Returns: A @ReplicationResult object showing the status.
+#
+# Example:
+#
+# -> { "execute": "query-xen-replication-status" }
+# <- { "return": [ { "error": false },
+#                  { "error": true } ] }
+#
+# Since: 2.9
+##
+{ 'command': 'query-xen-replication-status',
+  'returns': 'ReplicationStatus' }
+
+##
+# @xen-colo-do-checkpoint:
+#
+# Xen uses this command to notify replication to trigger a checkpoint.
+#
+# Returns: nothing.
+#
+# Example:
+#
+# -> { "execute": "xen-colo-do-checkpoint" }
+# <- { "return": {} }
+#
+# Since: 2.9
+##
+{ 'command': 'xen-colo-do-checkpoint' }
+
+##
 # @GICCapability:
 #
 # The struct describes capability for a specific GIC (Generic
-- 
2.7.4
