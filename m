Received: from eggs.gnu.org ([2001:4830:134:3::10]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cLoDg-00068j-HS
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 04:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cLoDf-0000Mf-H6
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 04:38:56 -0500
Received: from [59.151.112.132] (port=37877 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cLoDe-0000L5-Qp
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 04:38:55 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 27 Dec 2016 17:38:36 +0800
Message-ID: <1482831516-21862-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1482831516-21862-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1482831516-21862-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V5 2/2] Add a new qmp command to do checkpoint,
 query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

We can call this qmp command to do checkpoint outside of qemu.
Like Xen colo need this function.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Wen Congyang <wencongyang@gmail.com>
---
 docs/qmp-commands.txt | 24 ++++++++++++++++++++++++
 migration/colo.c      | 17 +++++++++++++++++
 qapi-schema.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
index d182147..a146745 100644
--- a/docs/qmp-commands.txt
+++ b/docs/qmp-commands.txt
@@ -450,6 +450,30 @@ Example:
      "arguments": {"enable": true, "primary": false} }
 <- { "return": {} }
 
+query-xen-replication-status
+----------------------------
+
+Query replication status when vm is running.
+
+Arguments: None.
+
+Example:
+
+-> { "execute": "query-xen-replication-status" }
+<- { "return": { "status": "normal" } }
+
+xen-do-checkpoint
+-----------------
+
+Xen use this command to notify replication to do checkpoint.
+
+Arguments: None.
+
+Example:
+
+-> { "execute": "xen-do-checkpoint" }
+<- { "return": {} }
+
 migrate
 -------
 
diff --git a/migration/colo.c b/migration/colo.c
index 6fc2ade..7fc9f8a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -127,6 +127,23 @@ void qmp_xen_set_replication(bool enable, bool primary,
     }
 }
 
+ReplicationErrorResult *qmp_query_xen_replication_status(Error **errp)
+{
+    Error *err = NULL;
+    ReplicationErrorResult *result = g_new0(ReplicationErrorResult, 1);
+    replication_get_error_all(&err);
+    result->status = err ?
+                     REPLICATION_ERROR_STATUS_ERROR :
+                     REPLICATION_ERROR_STATUS_NORMAL;
+    error_free(err);
+    return result;
+}
+
+void qmp_xen_do_checkpoint(Error **errp)
+{
+    replication_do_checkpoint_all(errp);
+}
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi-schema.json b/qapi-schema.json
index 78802f4..6c162a5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4695,6 +4695,56 @@
   'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
 
 ##
+# @ReplicationErrorStatus
+#
+# Describe the status of replication error.
+#
+# @error: Replication have a error.
+#
+# @normal:  Replication running normal.
+#
+# Since 2.9
+##
+{ 'enum': 'ReplicationErrorStatus',
+  'data': [ 'error', 'normal' ] }
+
+##
+# @ReplicationErrorResult
+#
+# The result format for 'xen-get-replication-error'.
+#
+# @status: enum of @ReplicationErrorStatus, which shows current
+#          replication error status
+#
+# Since 2.9
+##
+{ 'struct': 'ReplicationErrorResult',
+  'data': { 'status': 'ReplicationErrorStatus'} }
+
+##
+# @query-xen-replication-status
+#
+# Query replication error that occurs when the vm is running.
+#
+# Returns: A @ReplicationErrorResult objects showing the status.
+#
+# Since: 2.9
+##
+{ 'command': 'query-xen-replication-status',
+  'returns': 'ReplicationErrorResult' }
+
+##
+# @xen-do-checkpoint
+#
+# Xen use this command to notify replication to do checkpoint.
+#
+# Returns: nothing.
+#
+# Since: 2.9
+##
+{ 'command': 'xen-do-checkpoint' }
+
+##
 # @GICCapability:
 #
 # The struct describes capability for a specific GIC (Generic
-- 
2.7.4
