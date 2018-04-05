Received: from eggs.gnu.org ([2001:4830:134:3::10]:59183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qt-0000sE-3a
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qn-0006YE-BE
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f40qn-0006Xh-5f
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8B7A4023150
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 09:06:32 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Apr 2018 11:05:12 +0200
Message-Id: <1522919113-158775-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
References: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v5 10/11] qmp: add set-numa-node
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com

Command is allowed to run only in preconfig stage and
will allow to configure numa mapping for CPUs depending
on possible CPUs layout (query-hotpluggable-cpus) for
given machine instance.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c         |  5 +++++
 qapi/misc.json | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/numa.c b/numa.c
index 11cae25..e6d4363 100644
--- a/numa.c
+++ b/numa.c
@@ -444,6 +444,11 @@ void parse_numa_opts(MachineState *ms)
     }
 }
 
+void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
+{
+    set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
+}
+
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
 {
     int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
diff --git a/qapi/misc.json b/qapi/misc.json
index 65cb56b..72f57d6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3453,3 +3453,17 @@
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
+  'allowed-in-preconfig': true
+}
-- 
2.7.4
