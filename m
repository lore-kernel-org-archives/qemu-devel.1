Received: from eggs.gnu.org ([2001:4830:134:3::10]:39695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cEtbw-0001tJ-IJ
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cEtbv-0007SC-MC
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:59:24 -0500
Received: from [59.151.112.132] (port=7487 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cEtbv-00074l-1f
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:59:23 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 8 Dec 2016 15:55:15 +0800
Message-ID: <1481183716-7342-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1481183716-7342-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1481183716-7342-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 V2 2/3] Add a new qmp command to
 start/stop replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>

We can call this qmp command to start/stop replication outside of qemu.
Like Xen colo need this function.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 docs/qmp-commands.txt | 17 +++++++++++++++++
 migration/colo.c      | 22 ++++++++++++++++++++++
 qapi-schema.json      | 19 +++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
index abf210a..f7bae0d 100644
--- a/docs/qmp-commands.txt
+++ b/docs/qmp-commands.txt
@@ -432,6 +432,23 @@ Example:
      "arguments": { "enable": true } }
 <- { "return": {} }
 
+xen-set-replication
+-------
+
+Enable or disable replication.
+
+Arguments:
+
+- "enable": Enable it or disable it.
+- "primary": True for primary or false for secondary
+- "failover": Enable to do failover when stoping replcation
+
+Example:
+
+-> { "execute": "xen-set-replicate",
+     "arguments": {"enable": true, "primary": false} }
+<- { "return": {} }
+
 migrate
 -------
 
diff --git a/migration/colo.c b/migration/colo.c
index 93c85c5..007e699 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -19,6 +19,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/failover.h"
+#include "replication.h"
+#include "qmp-commands.h"
 
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
 
@@ -104,6 +106,26 @@ void colo_do_failover(MigrationState *s)
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
index f3e9bfc..f67b0a3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4676,6 +4676,25 @@
 { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
 
 ##
+# @xen-set-replication
+#
+# Enable or disable replication
+#
+# @enable: true to enable, false to disable.
+#
+# @primary: true for primary or false for secondary
+#
+# @failover: #optional true to do failover, false to stop.
+#            default value is false.
+#
+# Returns: nothing
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
