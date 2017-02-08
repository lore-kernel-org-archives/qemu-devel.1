Received: from eggs.gnu.org ([2001:4830:134:3::10]:48954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbKkt-0007vz-56
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbKks-0000Vf-0y
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:25:23 -0500
Received: from [59.151.112.132] (port=30583 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbKkr-0000VQ-In
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:25:21 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 8 Feb 2017 13:24:21 +0800
Message-ID: <1486531462-13882-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 1/2] Add a new qmp command to start/stop
 replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

We can call this qmp command to start/stop replication outside of qemu.
Like Xen colo need this function.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Wen Congyang <wencongyang@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

---
 migration/colo.c | 23 +++++++++++++++++++++++
 qapi-schema.json | 25 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 93c85c5..6fc2ade 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -19,6 +19,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/failover.h"
+#include "replication.h"
+#include "qmp-commands.h"
 
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
 
@@ -104,6 +106,27 @@ void colo_do_failover(MigrationState *s)
     }
 }
 
+void qmp_xen_set_replication(bool enable, bool primary,
+                             bool has_failover, bool failover,
+                             Error **errp)
+{
+    ReplicationMode mode = primary ?
+                           REPLICATION_MODE_PRIMARY :
+                           REPLICATION_MODE_SECONDARY;
+
+    if (has_failover && enable) {
+        error_setg(errp, "Parameter 'failover' is only for"
+                   " stopping replication");
+        return;
+    }
+
+    if (enable) {
+        replication_start_all(mode, errp);
+    } else {
+        replication_stop_all(failover, failover ? NULL : errp);
+    }
+}
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi-schema.json b/qapi-schema.json
index cbdffdd..9445b93 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5906,6 +5906,31 @@
 { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
 
 ##
+# @xen-set-replication:
+#
+# Enable or disable replication.
+#
+# @enable: true to enable, false to disable.
+#
+# @primary: true for primary or false for secondary.
+#
+# @failover: #optional true to do failover, false to stop. but cannot be
+#            specified if 'enable' is true. default value is false.
+#
+# Returns: nothing.
+#
+# Example:
+#
+# -> { "execute": "xen-set-replication",
+#      "arguments": {"enable": true, "primary": false} }
+# <- { "return": {} }
+#
+# Since: 2.9
+##
+{ 'command': 'xen-set-replication',
+  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
+
+##
 # @GICCapability:
 #
 # The struct describes capability for a specific GIC (Generic
-- 
2.7.4
