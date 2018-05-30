Received: from eggs.gnu.org ([2001:4830:134:3::10]:46255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAAE-0004jh-GD
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAAC-0000Bm-54
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOAAB-0000BT-Uh
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:27 -0300
Message-Id: <20180530230528.30166-12-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/12] qmp: add set-numa-node command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Command is allowed to run only in preconfig stage and
will allow to configure numa mapping for CPUs depending
on possible CPUs layout (query-hotpluggable-cpus) for
given machine instance.

Example of configuration session:
$QEMU -smp 2 --preconfig ...

QMP:
-> {'execute': 'query-hotpluggable-cpus' }
<- {'return': [
       {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 1}, ... },
       {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 0}, ... }
   ]}

-> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 0 } }
<- {'return': {}}
-> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',
       'node-id': 0, 'core-id': 0, 'thread-id': 0, 'socket-id': 1, }
   }
<- {'return': {}}

-> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 1 } }
-> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',
       'node-id': 1, 'core-id': 0, 'thread-id': 0, 'socket-id': 0 }
   }
<- {'return': {}}

-> {'execute': 'query-hotpluggable-cpus' }
<- {'return': [
       {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 0, 'socket-id': 1}, ... },
       {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 1, 'socket-id': 0}, ... }
   ]}

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1525423069-61903-11-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[ehabkost: Changed "since 2.13" to "since 3.0"]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/misc.json | 14 ++++++++++++++
 numa.c         | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index b155db2642..02bb295c13 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3510,3 +3510,17 @@
 ##
 { 'command': 'x-oob-test', 'data' : { 'lock': 'bool' },
   'allow-oob': true }
+
+##
+# @set-numa-node:
+#
+# Runtime equivalent of '-numa' CLI option, available at
+# preconfigure stage to configure numa mapping before initializing
+# machine.
+#
+# Since 3.0
+##
+{ 'command': 'set-numa-node', 'boxed': true,
+  'data': 'NumaOptions',
+  'allow-preconfig': true
+}
diff --git a/numa.c b/numa.c
index 53bd65a05d..33572bfa74 100644
--- a/numa.c
+++ b/numa.c
@@ -444,6 +444,17 @@ void parse_numa_opts(MachineState *ms)
     }
 }
 
+void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
+{
+    if (!runstate_check(RUN_STATE_PRECONFIG)) {
+        error_setg(errp, "The command is permitted only in '%s' state",
+                   RunState_str(RUN_STATE_PRECONFIG));
+         return;
+    }
+
+    set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
+}
+
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
 {
     int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
-- 
2.17.1
