Received: from eggs.gnu.org ([2001:4830:134:3::10]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFjwX-00063c-Ph
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFjwW-0005AL-S2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:24:25 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 30 May 2017 18:24:01 +0200
Message-Id: <1496161442-96665-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/7] spapr: cleanup
 spapr_fixup_cpu_numa_dt() usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

even though spapr_fixup_cpu_numa_dt() has no effect on FDT
if numa is disabled, don't call it uselessly. It makes it
obvious at call sites that function is need only when numa
is enabled.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/spapr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 34bb03d..96a2a74 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -178,10 +178,8 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     return ret;
 }
 
-static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
+static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 {
-    int ret = 0;
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
     int index = ppc_get_vcpu_dt_id(cpu);
     uint32_t associativity[] = {cpu_to_be32(0x5),
                                 cpu_to_be32(0x0),
@@ -191,12 +189,8 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
                                 cpu_to_be32(index)};
 
     /* Advertise NUMA via ibm,associativity */
-    if (nb_numa_nodes > 1) {
-        ret = fdt_setprop(fdt, offset, "ibm,associativity", associativity,
+    return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
                           sizeof(associativity));
-    }
-
-    return ret;
 }
 
 /* Populate the "ibm,pa-features" property */
@@ -321,9 +315,11 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
             return ret;
         }
 
-        ret = spapr_fixup_cpu_numa_dt(fdt, offset, cs);
-        if (ret < 0) {
-            return ret;
+        if (nb_numa_nodes > 1) {
+            ret = spapr_fixup_cpu_numa_dt(fdt, offset, cpu);
+            if (ret < 0) {
+                return ret;
+            }
         }
 
         ret = spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt);
@@ -538,7 +534,9 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
                       pft_size_prop, sizeof(pft_size_prop))));
 
-    _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cs));
+    if (nb_numa_nodes > 1) {
+        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
+    }
 
     _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
 
-- 
2.7.4
