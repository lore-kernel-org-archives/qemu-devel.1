Received: from eggs.gnu.org ([2001:4830:134:3::10]:44719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtw-0006qc-RO
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtv-0006WG-Ve
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUbtv-0006Uk-IH
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:27 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 28 Dec 2017 18:22:58 +0100
Message-Id: <1514481779-184817-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
References: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 3/4] QMP: add set-numa-node command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/machine.c |  1 +
 numa.c            |  5 +++++
 qapi-schema.json  | 13 +++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c857f3f..212dfec 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "sysemu/qtest.h"
+#include "qmp-commands.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
 {
diff --git a/numa.c b/numa.c
index d157961..fd2bf1c 100644
--- a/numa.c
+++ b/numa.c
@@ -442,6 +442,11 @@ void parse_numa_opts(MachineState *ms)
     }
 }
 
+void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
+{
+    parse_NumaOptions(MACHINE(qdev_get_machine()), cmd, errp);
+}
+
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
 {
     int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
diff --git a/qapi-schema.json b/qapi-schema.json
index 5c06745..94ef197 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3189,3 +3189,16 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @set-numa-node:
+#
+# Runtime equivalent of '-numa' CLI option, available at
+# preconfigure stage to configure numa mapping before initializing
+# machine.
+#
+# Since 2.10
+##
+{ 'command': 'set-numa-node', 'boxed': true,
+  'data': 'NumaOptions'
+}
-- 
2.7.4
