Received: from eggs.gnu.org ([2001:4830:134:3::10]:57098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtoH-0002OX-JJ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtoG-0007T0-8o
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtoG-0007SZ-27
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:08 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:29 +0100
Message-Id: <1484759609-264075-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 13/13] pc: cpu: make sure that cpu.node-id
 matches -numa mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

for PC CPU's node mapping defined statically at startup
and not possible to changle at hotplug time.
So check that user set cpu.node-id matches whatever values
were configured with -numa options (ex|im)plicitly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c      | 11 ++++++++++-
 target/i386/cpu.c |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e2833e0..d828a1a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1967,7 +1967,16 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cs = CPU(cpu);
     cs->cpu_index = idx;
-    cpu->numa_nid = cpu_slot->props.node_id;
+
+    if (cpu->numa_nid == -1) {
+        cpu->numa_nid = cpu_slot->props.node_id;
+    } else if (cpu->numa_nid != cpu_slot->props.node_id) {
+        error_setg(errp, "property node-id: %u doesn't match with -numa"
+            " explictly specified value(s) or implicitly set defaults."
+            " Expected value: %" PRIi64,
+            cpu->numa_nid, cpu_slot->props.node_id);
+        return;
+    }
 }
 
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85c52f1..6375a37 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3649,7 +3649,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
-    DEFINE_PROP_INT32("node-id", X86CPU, numa_nid, 0),
+    DEFINE_PROP_INT32("node-id", X86CPU, numa_nid, -1),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
     { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
     DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
-- 
2.7.4
