Received: from eggs.gnu.org ([2001:4830:134:3::10]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cZbTJ-0003EH-3X
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cZbTG-0003ub-36
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:52:05 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri,  3 Feb 2017 11:51:57 +0100
Message-Id: <1486119117-113707-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20170203070446.GB12744@in.ibm.com>
References: <20170203070446.GB12744@in.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/3] spapr: cpu core: separate child threads
 destruction from machine state operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org

Split off destroying VCPU threads from drc callback
spapr_core_release() into new spapr_cpu_core_unrealizefn()
which takes care of internal cpu core state cleanup (i.e.
VCPU threads) and is called when object_unparent(core)
is called.

That leaves spapr_core_release() only with board mgmt
code, which will be moved to board related file in
follow up patch along with the rest on hotplug callbacks.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr_cpu_core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9dddaeb..b9e5f80 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -111,11 +111,19 @@ char *spapr_get_cpu_core_type(const char *model)
 
 static void spapr_core_release(DeviceState *dev, void *opaque)
 {
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    CPUCore *cc = CPU_CORE(dev);
+
+    spapr->cores[cc->core_id / smp_threads] = NULL;
+    object_unparent(OBJECT(dev));
+}
+
+static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
+{
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     const char *typename = object_class_get_name(scc->cpu_class);
     size_t size = object_type_get_instance_size(typename);
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUCore *cc = CPU_CORE(dev);
     int i;
 
@@ -129,11 +137,7 @@ static void spapr_core_release(DeviceState *dev, void *opaque)
         cpu_remove_sync(cs);
         object_unparent(obj);
     }
-
-    spapr->cores[cc->core_id / smp_threads] = NULL;
-
     g_free(sc->threads);
-    object_unparent(OBJECT(dev));
 }
 
 void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -368,6 +372,7 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
 
     dc->realize = spapr_cpu_core_realize;
+    dc->unrealize = spapr_cpu_core_unrealizefn;
     scc->cpu_class = cpu_class_by_name(TYPE_POWERPC_CPU, data);
     g_assert(scc->cpu_class);
 }
-- 
2.7.4
