Received: from eggs.gnu.org ([2001:4830:134:3::10]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWF0-0006yh-Sj
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWEy-0002bp-Tk
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fEWEy-0002b2-Ok
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57B608163AD4
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:38:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri,  4 May 2018 10:37:48 +0200
Message-Id: <1525423069-61903-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v7 10/11] qmp: add set-numa-node command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

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
---
v7:
 * s/allowed-in-preconfig/allow-preconfig/
v6:
 * limit command to preconfig state only
 * add example QMP command sequence
---
 numa.c         | 11 +++++++++++
 qapi/misc.json | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/numa.c b/numa.c
index 63e3989..760aef0 100644
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 12ae310..79dfd39 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3476,3 +3476,17 @@
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
+# Since 2.13
+##
+{ 'command': 'set-numa-node', 'boxed': true,
+  'data': 'NumaOptions',
+  'allow-preconfig': true
+}
-- 
2.7.4
