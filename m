Received: from eggs.gnu.org ([2001:4830:134:3::10]:57176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmS-0002NA-8p
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmP-0000dR-KD
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 19 Aug 2018 05:13:34 -0400
Message-Id: <20180819091335.22863-11-cota@braap.org>
In-Reply-To: <20180819091335.22863-1-cota@braap.org>
References: <20180819091335.22863-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 10/11] spapr: do not use CPU_FOREACH_REVERSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

This paves the way for implementing the CPU list with an RCU list,
which cannot be traversed in reverse order.

Note that this is the only caller of CPU_FOREACH_REVERSE.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/ppc/spapr.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 421b2dd09b..2ef5be2790 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -622,9 +622,12 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
 
 static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
 {
+    CPUState **rev;
     CPUState *cs;
+    int n_cpus;
     int cpus_offset;
     char *nodename;
+    int i;
 
     cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
     _FDT(cpus_offset);
@@ -635,8 +638,19 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
      * We walk the CPUs in reverse order to ensure that CPU DT nodes
      * created by fdt_add_subnode() end up in the right order in FDT
      * for the guest kernel the enumerate the CPUs correctly.
+     *
+     * The CPU list cannot be traversed in reverse order, so we need
+     * to do extra work.
      */
-    CPU_FOREACH_REVERSE(cs) {
+    n_cpus = 0;
+    rev = NULL;
+    CPU_FOREACH(cs) {
+        rev = g_renew(CPUState *, rev, n_cpus + 1);
+        rev[n_cpus++] = cs;
+    }
+
+    for (i = n_cpus - 1; i >= 0; i--) {
+        CPUState *cs = rev[i];
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         int index = spapr_get_vcpu_id(cpu);
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
-- 
2.17.1
