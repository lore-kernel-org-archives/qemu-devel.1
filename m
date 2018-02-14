Received: from eggs.gnu.org ([2001:4830:134:3::10]:52285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1em2vQ-0003Wt-DV
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1em2vL-00033Z-Us
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:41:04 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:37798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1em2vL-00032g-Ne
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:40:59 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 33249A3A06
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:40:58 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 14 Feb 2018 20:40:53 +0100
Message-ID: <151863725388.3003.620735626834741475.stgit@bahia.lan>
In-Reply-To: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 4/5] spapr: consolidate the VCPU id numbering
 logic in a single place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Laurent Vivier <lvivier@redhat.com>

Several places in the code need to calculate a VCPU id:

    (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads
    (core_id / smp_threads) * spapr->vsmt (1 user)
    index * spapr->vsmt (2 users)

or guess that the VCPU id of a given VCPU is the first thread of a virtual
core:

    index % spapr->vsmt != 0

Even if the numbering logic isn't that complex, it is rather fragile to
have these assumptions open-coded in several places. FWIW this was
proved with recent issues related to VSMT.

This patch moves the VCPU id formula to a single function to be called
everywhere the code needs to compute one. It also adds an helper to
guess if a VCPU is the first thread of a VCORE.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 18ebc058acdd..800d3f001253 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -99,6 +99,20 @@
 
 #define PHANDLE_XICP            0x00001111
 
+/* These two functions implement the VCPU id numbering: one to compute them
+ * all and one to identify thread 0 of a VCORE. Any change to the first one
+ * is likely to have an impact on the second one, so let's keep them close.
+ */
+static int spapr_vcpu_id(sPAPRMachineState *spapr, int cpu_index)
+{
+    return
+        (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads;
+}
+static bool spapr_is_vcore(sPAPRMachineState *spapr, PowerPCCPU *cpu)
+{
+    return spapr_get_vcpu_id(cpu) % spapr->vsmt == 0;
+}
+
 static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
                                   const char *type_ics,
                                   int nr_irqs, Error **errp)
@@ -345,7 +359,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         int index = spapr_get_vcpu_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
 
-        if (index % spapr->vsmt != 0) {
+        if (!spapr_is_vcore(spapr, cpu)) {
             continue;
         }
 
@@ -630,7 +644,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int offset;
 
-        if (index % spapr->vsmt != 0) {
+        if (!spapr_is_vcore(spapr, cpu)) {
             continue;
         }
 
@@ -2251,7 +2265,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
 
         if (mc->has_hotpluggable_cpus) {
             spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
-                                   (core_id / smp_threads) * spapr->vsmt);
+                                   spapr_vcpu_id(spapr, core_id));
         }
 
         if (i < boot_cores_nr) {
@@ -3293,7 +3307,8 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * spapr->vsmt);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
+                          spapr_vcpu_id(spapr, cc->core_id));
     g_assert(drc);
 
     spapr_drc_detach(drc);
@@ -3322,7 +3337,8 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                    cc->core_id);
         return;
     }
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * spapr->vsmt);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
+                          spapr_vcpu_id(spapr, cc->core_id));
 
     g_assert(drc || !mc->has_hotpluggable_cpus);
 
@@ -3807,8 +3823,7 @@ void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     int vcpu_id;
 
-    vcpu_id =
-        (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads;
+    vcpu_id = spapr_vcpu_id(spapr, cpu_index);
 
     if (kvm_enabled() && !kvm_vcpu_id_is_valid(vcpu_id)) {
         error_setg(errp, "Can't create CPU with id %d in KVM", vcpu_id);
