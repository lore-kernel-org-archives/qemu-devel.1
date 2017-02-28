Received: from eggs.gnu.org ([2001:4830:134:3::10]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cinFu-0001Wa-IS
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cinFq-0001yz-JA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:16:14 -0500
Received: from mail.kernel.org ([198.145.29.136]:38504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cinFq-0001yL-2V
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:16:10 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 28 Feb 2017 11:16:03 -0800
Message-Id: <1488309364-3252-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1702281106420.5551@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1702281106420.5551@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 1/2] Add a new qmp command to start/stop
 replication
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

We can call this qmp command to start/stop replication outside of qemu.
Like Xen colo need this function.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Wen Congyang <wencongyang@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 migration/colo.c | 26 ++++++++++++++++++++++++++
 qapi-schema.json | 25 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 712308e..46bc84d 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -19,6 +19,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/failover.h"
+#include "replication.h"
+#include "qmp-commands.h"
 
 static bool vmstate_loading;
 
@@ -147,6 +149,30 @@ void colo_do_failover(MigrationState *s)
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
+        if (!has_failover) {
+            failover = NULL;
+        }
+        replication_stop_all(failover, failover ? NULL : errp);
+    }
+}
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi-schema.json b/qapi-schema.json
index 150ee98..dbc1ebc 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5990,6 +5990,31 @@
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
1.9.1
