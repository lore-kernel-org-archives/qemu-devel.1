Received: from eggs.gnu.org ([2001:4830:134:3::10]:32867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxEG-0001vX-SQ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxEF-00084y-VR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHxEF-00084C-NH
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Jun 2017 15:59:24 -0300
Message-Id: <20170605185927.12111-8-ehabkost@redhat.com>
In-Reply-To: <20170605185927.12111-1-ehabkost@redhat.com>
References: <20170605185927.12111-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] spapr: cleanup spapr_fixup_cpu_numa_dt()
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

even though spapr_fixup_cpu_numa_dt() has no effect on FDT
if numa is disabled, don't call it uselessly. It makes it
obvious at call sites that function is needed only when numa
is enabled.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1496161442-96665-7-git-send-email-imammedo@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/spapr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 96471a5d89..70eb60efed 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -182,10 +182,8 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
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
@@ -195,12 +193,8 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
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
@@ -325,9 +319,11 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
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
@@ -542,7 +538,9 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
                       pft_size_prop, sizeof(pft_size_prop))));
 
-    _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cs));
+    if (nb_numa_nodes > 1) {
+        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
+    }
 
     _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
 
-- 
2.11.0.259.g40922b1
