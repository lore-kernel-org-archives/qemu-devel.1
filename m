Received: from eggs.gnu.org ([2001:4830:134:3::10]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cinFu-0001WY-I9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cinFr-0001zM-K7
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:16:14 -0500
Received: from mail.kernel.org ([198.145.29.136]:38542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cinFr-0001yr-81
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:16:11 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 28 Feb 2017 11:16:04 -0800
Message-Id: <1488309364-3252-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1488309364-3252-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1702281106420.5551@sstabellini-ThinkPad-X260>
	<1488309364-3252-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 2/2] Add a new qmp command to do checkpoint,
 query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

We can call this qmp command to do checkpoint outside of qemu.
Xen colo will need this function.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Wen Congyang <wencongyang@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 migration/colo.c | 23 +++++++++++++++++++++++
 qapi-schema.json | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 46bc84d..c19eb3f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -173,6 +173,29 @@ void qmp_xen_set_replication(bool enable, bool primary,
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
index dbc1ebc..d6186d4 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6015,6 +6015,54 @@
   'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
 
 ##
+# @ReplicationStatus:
+#
+# The result format for 'query-xen-replication-status'.
+#
+# @error: true if an error happened, false if replication is normal.
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
+# <- { "return": { "error": false } }
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
1.9.1
