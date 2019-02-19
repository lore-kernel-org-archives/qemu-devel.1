Received: from eggs.gnu.org ([209.51.188.92]:33450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw926-0002IN-4u
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw922-0007Je-S5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw921-00070r-3Z
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:10 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEGlo070189
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:57 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrn88avcr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:56 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:17:53 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:17:48 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059666839.1466090.3833376527523126752.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 03/17] spapr: Generate FDT fragment for CPUs
 at configure connector time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |   52 +++++++++++++++++++++---------------------------
 hw/ppc/spapr_drc.c     |    1 +
 include/hw/ppc/spapr.h |    2 ++
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b92deee771b9..6cf7a9f5c1f2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3636,27 +3636,6 @@ out:
     error_propagate(errp, local_err);
 }
 
-static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
-                                           sPAPRMachineState *spapr)
-{
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    int id = spapr_get_vcpu_id(cpu);
-    void *fdt;
-    int offset, fdt_size;
-    char *nodename;
-
-    fdt = create_device_tree(&fdt_size);
-    nodename = g_strdup_printf("%s@%x", dc->fw_name, id);
-    offset = fdt_add_subnode(fdt, 0, nodename);
-
-    spapr_populate_cpu_dt(cs, fdt, offset, spapr);
-    g_free(nodename);
-
-    *fdt_offset = offset;
-    return fdt;
-}
-
 /* Callback to be called during DRC release. */
 void spapr_core_release(DeviceState *dev)
 {
@@ -3717,6 +3696,27 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
     spapr_hotplug_req_remove_by_index(drc);
 }
 
+int spapr_core_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **errp)
+{
+    sPAPRCPUCore *core = SPAPR_CPU_CORE(drc->dev);
+    CPUState *cs = CPU(core->threads[0]);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    DeviceClass *dc = DEVICE_GET_CLASS(cs);
+    int id = spapr_get_vcpu_id(cpu);
+    char *nodename;
+    int offset;
+
+    nodename = g_strdup_printf("%s@%x", dc->fw_name, id);
+    offset = fdt_add_subnode(fdt, 0, nodename);
+    g_free(nodename);
+
+    spapr_populate_cpu_dt(cs, fdt, offset, spapr);
+
+    *fdt_start_offset = offset;
+    return 0;
+}
+
 static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp)
 {
@@ -3725,7 +3725,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
-    CPUState *cs = CPU(core->threads[0]);
+    CPUState *cs;
     sPAPRDRConnector *drc;
     Error *local_err = NULL;
     CPUArchId *core_slot;
@@ -3744,14 +3744,8 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     g_assert(drc || !mc->has_hotpluggable_cpus);
 
     if (drc) {
-        void *fdt;
-        int fdt_offset;
-
-        fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
-
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
+        spapr_drc_attach(drc, dev, NULL, 0, &local_err);
         if (local_err) {
-            g_free(fdt);
             error_propagate(errp, local_err);
             return;
         }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 634c28695a1c..aa26aa40be39 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -680,6 +680,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
     drck->typename = "CPU";
     drck->drc_name_prefix = "CPU ";
     drck->release = spapr_core_release;
+    drck->dt_populate = spapr_core_dt_populate;
 }
 
 static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0ec309da497e..5e3c76072505 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -766,6 +766,8 @@ int spapr_max_server_number(sPAPRMachineState *spapr);
 
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
+int spapr_core_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **errp);
 void spapr_lmb_release(DeviceState *dev);
 int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
