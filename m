Received: from eggs.gnu.org ([2001:4830:134:3::10]:48217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa9P-00080Z-J4
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa9K-00032q-Sf
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:51:27 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:46080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTa9K-00031k-K4
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:51:22 -0400
Received: from player738.ha.ovh.net (unknown [10.109.105.58])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id E00F2CDA36
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 23:51:20 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Jun 2018 23:51:11 +0200
Message-ID: <152901307192.252222.7502403316148525219.stgit@bahia.lan>
In-Reply-To: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 5/5] spapr_cpu_core: simplify
 spapr_cpu_core_realize()
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

There's no real reason to create all CPUs in a first pass and to realize
them in a second pass. Merging these two loops makes the code simpler.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 0ebaf804a9bc..f52af20e0096 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -172,7 +172,8 @@ error:
     error_propagate(errp, local_err);
 }
 
-static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
+static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i,
+                                     sPAPRMachineState *spapr, Error **errp)
 {
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(sc);
     CPUCore *cc = CPU_CORE(sc);
@@ -201,9 +202,16 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
         goto err;
     }
 
+    spapr_realize_vcpu(cpu, spapr, &local_err);
+    if (local_err) {
+        goto err_unparent;
+    }
+
     object_unref(obj);
     return cpu;
 
+err_unparent:
+    object_unparent(obj);
 err:
     object_unref(obj);
     error_propagate(errp, local_err);
@@ -212,6 +220,7 @@ err:
 
 static void spapr_delete_vcpu(PowerPCCPU *cpu)
 {
+    spapr_unrealize_vcpu(cpu);
     object_unparent(OBJECT(cpu));
 }
 
@@ -226,7 +235,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
     Error *local_err = NULL;
-    int i, j;
+    int i;
 
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine");
@@ -235,24 +244,14 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        sc->threads[i] = spapr_create_vcpu(sc, i, &local_err);
+        sc->threads[i] = spapr_create_vcpu(sc, i, spapr, &local_err);
         if (local_err) {
             goto err;
         }
     }
 
-    for (j = 0; j < cc->nr_threads; j++) {
-        spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
-        if (local_err) {
-            goto err_unrealize;
-        }
-    }
     return;
 
-err_unrealize:
-    while (--j >= 0) {
-        spapr_unrealize_vcpu(sc->threads[i]);
-    }
 err:
     while (--i >= 0) {
         spapr_delete_vcpu(sc->threads[i]);
