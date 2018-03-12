Received: from eggs.gnu.org ([2001:4830:134:3::10]:48288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFu-0007KD-96
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFt-0005Y8-6Z
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1evNFt-0005XS-2W
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:45 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 12 Mar 2018 14:11:14 +0100
Message-Id: <1520860275-101576-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 8/9] qmp: add set-numa-node command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

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
index 2b1d292..02e2631 100644
--- a/numa.c
+++ b/numa.c
@@ -446,6 +446,11 @@ void parse_numa_opts(MachineState *ms)
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 691c980..d023ac7 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3218,3 +3218,17 @@
 # Since: 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
+##
+# @set-numa-node:
+#
+# Runtime equivalent of '-numa' CLI option, available at
+# preconfigure stage to configure numa mapping before initializing
+# machine.
+#
+# Since 2.12
+##
+{ 'command': 'set-numa-node', 'boxed': true,
+  'data': 'NumaOptions',
+  'allowed-in-preconfig': true
+}
-- 
2.7.4
