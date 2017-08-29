Received: from eggs.gnu.org ([2001:4830:134:3::10]:48506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCg-0001Xu-Mf
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCe-0005pK-8t
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCd-0005mu-W7
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0ECuc042865
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:23 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmr8nf0bu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:22 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:21 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:29 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-55-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 54/79] spapr: add pre_plug function for memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

This allows to manage errors before the memory
has started to be hotplugged. We already have
the function for the CPU cores.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
[dwg: Fixed a couple of style nits]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

(cherry picked from commit c871bc70bb22d1d70451bc813ecb008fe98cc92b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 35db949..5564f78 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2508,20 +2508,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     uint64_t align = memory_region_get_alignment(mr);
     uint64_t size = memory_region_size(mr);
     uint64_t addr;
-    char *mem_dev;
-
-    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
-        error_setg(&local_err, "Hotplugged memory size must be a multiple of "
-                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE/M_BYTE);
-        goto out;
-    }
-
-    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
-    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
-        error_setg(&local_err, "Memory backend has bad page size. "
-                   "Use 'memory-backend-file' with correct mem-path.");
-        goto out;
-    }
 
     pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
     if (local_err) {
@@ -2542,6 +2528,29 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                  Error **errp)
+{
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    uint64_t size = memory_region_size(mr);
+    char *mem_dev;
+
+    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+        error_setg(errp, "Hotplugged memory size must be a multiple of "
+                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+        return;
+    }
+
+    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
+    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
+        error_setg(errp, "Memory backend has bad page size. "
+                   "Use 'memory-backend-file' with correct mem-path.");
+        return;
+    }
+}
+
 typedef struct sPAPRDIMMState {
     uint32_t nr_lmbs;
 } sPAPRDIMMState;
@@ -2912,7 +2921,9 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        spapr_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_pre_plug(hotplug_dev, dev, errp);
     }
 }
-- 
2.7.4
