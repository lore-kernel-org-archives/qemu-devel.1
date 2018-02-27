Received: from eggs.gnu.org ([2001:4830:134:3::10]:40415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eqh5v-000818-94
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eqh5s-0000UD-KD
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:23:07 -0500
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:34869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eqh5s-0000TP-CS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:23:04 -0500
Received: from player729.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id C74ACA57D6
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 16:23:02 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Feb 2018 16:22:58 +0100
Message-ID: <151974497827.17040.998847751580090128.stgit@bahia.lan>
In-Reply-To: <151974496089.17040.8929640429507724311.stgit@bahia.lan>
References: <151974496089.17040.8929640429507724311.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/2] spapr: register dummy ICPs later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>

Some older machine types create more ICPs than needed. We hence
need to register up to xics_max_server_number() dummy ICPs to
accomodate the migration of these machine types.

Recent VSMT rework changed xics_max_server_number() to return

    DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads)

instead of

    DIV_ROUND_UP(max_cpus * kvmppc_smt_threads(), smp_threads);

The change is okay but it requires spapr->vsmt to be set, which
isn't the case with the current code. This causes the formula to
return zero and we don't create dummy ICPs. This breaks migration
of older guests as reported here:

    https://bugzilla.redhat.com/show_bug.cgi?id=1549087

The dummy ICP workaround doesn't really have a dependency on XICS
itself. But it does depend on proper VCPU id numbering and it must
be applied before creating vCPUs (ie, creating real ICPs). So this
patch moves the workaround to spapr_init_cpus(), which already
assumes VSMT to be set.

Fixes: 72194664c8a1 ("spapr: use spapr->vsmt to compute VCPU ids")
Reported-by: Lukas Doktor <ldoktor@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 83c9d66dd56f..ae411057272f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -183,7 +183,6 @@ static int xics_max_server_number(sPAPRMachineState *spapr)
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
 
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
@@ -205,17 +204,6 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
             return;
         }
     }
-
-    if (smc->pre_2_10_has_unused_icps) {
-        int i;
-
-        for (i = 0; i < xics_max_server_number(spapr); i++) {
-            /* Dummy entries get deregistered when real ICPState objects
-             * are registered during CPU core hotplug.
-             */
-            pre_2_10_vmstate_register_dummy_icp(i);
-        }
-    }
 }
 
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
@@ -2236,6 +2224,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     const char *type = spapr_get_cpu_core_type(machine->cpu_type);
     const CPUArchIdList *possible_cpus;
     int boot_cores_nr = smp_cpus / smp_threads;
@@ -2261,6 +2250,17 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
         boot_cores_nr = possible_cpus->len;
     }
 
+    if (smc->pre_2_10_has_unused_icps) {
+        int i;
+
+        for (i = 0; i < xics_max_server_number(spapr); i++) {
+            /* Dummy entries get deregistered when real ICPState objects
+             * are registered during CPU core hotplug.
+             */
+            pre_2_10_vmstate_register_dummy_icp(i);
+        }
+    }
+
     for (i = 0; i < possible_cpus->len; i++) {
         int core_id = i * smp_threads;
 
