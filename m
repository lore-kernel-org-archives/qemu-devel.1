Received: from eggs.gnu.org ([2001:4830:134:3::10]:34759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFEJo-000376-31
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 01:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFEJl-0002qV-Ua
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 01:06:04 -0500
Received: from [59.151.112.132] (port=42593 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFEJl-0002pw-JC
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 01:06:01 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 9 Dec 2016 14:04:56 +0800
Message-ID: <1481263496-8004-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1481263496-8004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1481263496-8004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 V3 3/3] Add a new qmp command to do
 checkpoint, get replication error
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

We can call this qmp command to do checkpoint outside of qemu.
Like Xen colo need this function.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 docs/qmp-commands.txt | 24 ++++++++++++++++++++++++
 migration/colo.c      | 10 ++++++++++
 qapi-schema.json      | 22 ++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
index a8e9eb6..093b7eb 100644
--- a/docs/qmp-commands.txt
+++ b/docs/qmp-commands.txt
@@ -450,6 +450,30 @@ Example:
      "arguments": {"enable": true, "primary": false} }
 <- { "return": {} }
 
+xen-get-replication-error
+-------------------------
+
+Get replication error that occurs when vm is running.
+
+Arguments: None.
+
+Example:
+
+-> { "execute": "xen-get-replication-error" }
+<- { "return": {} }
+
+xen-do-checkpoint
+-----------------
+
+Do checkpoint.
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
index 6fc2ade..1e962f6 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -127,6 +127,16 @@ void qmp_xen_set_replication(bool enable, bool primary,
     }
 }
 
+void qmp_xen_get_replication_error(Error **errp)
+    {
+        replication_get_error_all(errp);
+    }
+
+void qmp_xen_do_checkpoint(Error **errp)
+    {
+        replication_do_checkpoint_all(errp);
+    }
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi-schema.json b/qapi-schema.json
index 78802f4..79fe4dd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4695,6 +4695,28 @@
   'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
 
 ##
+# @xen-get-replication-error
+#
+# Get replication error that occurs when the vm is running.
+#
+# Returns: nothing.
+#
+# Since: 2.9
+##
+{ 'command': 'xen-get-replication-error' }
+
+##
+# @xen-do-checkpoint
+#
+# Do checkpoint.
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
