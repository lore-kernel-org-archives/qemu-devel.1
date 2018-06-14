Received: from eggs.gnu.org ([2001:4830:134:3::10]:48032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa9B-0007qZ-Dq
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa96-0002mq-Lu
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:51:13 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:54540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTa96-0002k6-Do
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:51:08 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.43])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id E77671A262
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 23:51:06 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Jun 2018 23:50:57 +0200
Message-ID: <152901305726.252222.7317082325256499414.stgit@bahia.lan>
In-Reply-To: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 4/5] spapr_cpu_core: introduce
 spapr_create_vcpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

This moves some code out from spapr_cpu_core_realize() for clarity. No
functional change.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |   73 +++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 04c818a6ecac..0ebaf804a9bc 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -172,6 +172,49 @@ error:
     error_propagate(errp, local_err);
 }
 
+static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
+{
+    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(sc);
+    CPUCore *cc = CPU_CORE(sc);
+    Object *obj;
+    char *id;
+    CPUState *cs;
+    PowerPCCPU *cpu;
+    Error *local_err = NULL;
+
+    obj = object_new(scc->cpu_type);
+
+    cs = CPU(obj);
+    cpu = POWERPC_CPU(obj);
+    cs->cpu_index = cc->core_id + i;
+    spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
+    if (local_err) {
+        goto err;
+    }
+
+    cpu->node_id = sc->node_id;
+
+    id = g_strdup_printf("thread[%d]", i);
+    object_property_add_child(OBJECT(sc), id, obj, &local_err);
+    g_free(id);
+    if (local_err) {
+        goto err;
+    }
+
+    object_unref(obj);
+    return cpu;
+
+err:
+    object_unref(obj);
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+static void spapr_delete_vcpu(PowerPCCPU *cpu)
+{
+    object_unparent(OBJECT(cpu));
+}
+
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
@@ -181,10 +224,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
     Error *local_err = NULL;
-    Object *obj;
     int i, j;
 
     if (!spapr) {
@@ -194,33 +235,10 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        char *id;
-        CPUState *cs;
-        PowerPCCPU *cpu;
-
-        obj = object_new(scc->cpu_type);
-
-        cs = CPU(obj);
-        cpu = sc->threads[i] = POWERPC_CPU(obj);
-        cs->cpu_index = cc->core_id + i;
-        spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
-        if (local_err) {
-            object_unref(obj);
-            goto err;
-        }
-
-
-        /* Set NUMA node for the threads belonged to core  */
-        cpu->node_id = sc->node_id;
-
-        id = g_strdup_printf("thread[%d]", i);
-        object_property_add_child(OBJECT(sc), id, obj, &local_err);
-        g_free(id);
+        sc->threads[i] = spapr_create_vcpu(sc, i, &local_err);
         if (local_err) {
-            object_unref(obj);
             goto err;
         }
-        object_unref(obj);
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
@@ -237,8 +255,7 @@ err_unrealize:
     }
 err:
     while (--i >= 0) {
-        obj = OBJECT(sc->threads[i]);
-        object_unparent(obj);
+        spapr_delete_vcpu(sc->threads[i]);
     }
     g_free(sc->threads);
     error_propagate(errp, local_err);
