Received: from eggs.gnu.org ([2001:4830:134:3::10]:48224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fob0A-0005Hp-8G
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fob07-0001So-2W
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:00:46 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fob06-0001SP-TJ
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:00:43 -0400
Received: by mail-pl0-x241.google.com with SMTP id g6-v6so5380157plq.9
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 14:00:42 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 12 Aug 2018 04:59:16 +0800
Message-Id: <20180811205924.4113-13-zhangckid@gmail.com>
In-Reply-To: <20180811205924.4113-1-zhangckid@gmail.com>
References: <20180811205924.4113-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V11 12/20] qapi: Add new command to query colo
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

Libvirt or other high level software can use this command query colo status.
You can test this command like that:
{'execute':'query-colo-status'}

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 migration/colo.c    | 21 +++++++++++++++++++++
 qapi/migration.json | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 8fdb79ac73..b355de3f01 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -29,6 +29,7 @@
 #include "net/colo.h"
 #include "block/block.h"
 #include "qapi/qapi-events-migration.h"
+#include "qapi/qmp/qerror.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -237,6 +238,26 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
 #endif
 }
 
+COLOStatus *qmp_query_colo_status(Error **errp)
+{
+    COLOStatus *s = g_new0(COLOStatus, 1);
+
+    s->mode = get_colo_mode();
+
+    switch (failover_get_state()) {
+    case FAILOVER_STATUS_NONE:
+        s->reason = COLO_EXIT_REASON_NONE;
+        break;
+    case FAILOVER_STATUS_REQUIRE:
+        s->reason = COLO_EXIT_REASON_REQUEST;
+        break;
+    default:
+        s->reason = COLO_EXIT_REASON_ERROR;
+    }
+
+    return s;
+}
+
 static void colo_send_message(QEMUFile *f, COLOMessage msg,
                               Error **errp)
 {
diff --git a/qapi/migration.json b/qapi/migration.json
index 78932206dd..87312dd093 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1251,6 +1251,38 @@
 ##
 { 'command': 'xen-colo-do-checkpoint' }
 
+##
+# @COLOStatus:
+#
+# The result format for 'query-colo-status'.
+#
+# @mode: COLO running mode. If COLO is running, this field will return
+#        'primary' or 'secondary'.
+#
+# @reason: describes the reason for the COLO exit.
+#
+# Since: 3.0
+##
+{ 'struct': 'COLOStatus',
+  'data': { 'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
+
+##
+# @query-colo-status:
+#
+# Query COLO status while the vm is running.
+#
+# Returns: A @COLOStatus object showing the status.
+#
+# Example:
+#
+# -> { "execute": "query-colo-status" }
+# <- { "return": { "mode": "primary", "active": true, "reason": "request" } }
+#
+# Since: 3.0
+##
+{ 'command': 'query-colo-status',
+  'returns': 'COLOStatus' }
+
 ##
 # @migrate-recover:
 #
-- 
2.17.GIT
