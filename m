Received: from eggs.gnu.org ([2001:4830:134:3::10]:58651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe4-000280-JX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdz-0003De-SI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:20 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:32 +1000
Message-Id: <20170908103558.31632-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/40] e500: Use cpu_index instead of vcpu_dt_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

The e500 platform code uses the function ppc_get_vcpu_dt_id() to get
an id to put in its device tree.  Which seems like it makes sense, but
ppc_get_vcpu_dt_id() is actually badly named - it only differs from
cpu_index in cases where you're running on KVM HV and the host's
number of threads differs from the guests.  Since KVM HV only supports
PAPR, not e500, it doesn't make sense to use it here.

Simply use the cpu_index instead (which is 'i' in this context
because qemu_get_cpu(i) returns the cpu with cpu_index == i).

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
[dwg: Rewrote commit message]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index f0596f34ff..55cad780f4 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -382,7 +382,6 @@ static int ppce500_load_device_tree(MachineState *machine,
        the first node as boot node and be happy */
     for (i = smp_cpus - 1; i >= 0; i--) {
         CPUState *cpu;
-        PowerPCCPU *pcpu;
         char cpu_name[128];
         uint64_t cpu_release_addr = params->spin_base + (i * 0x20);
 
@@ -391,16 +390,13 @@ static int ppce500_load_device_tree(MachineState *machine,
             continue;
         }
         env = cpu->env_ptr;
-        pcpu = POWERPC_CPU(cpu);
 
-        snprintf(cpu_name, sizeof(cpu_name), "/cpus/PowerPC,8544@%x",
-                 ppc_get_vcpu_dt_id(pcpu));
+        snprintf(cpu_name, sizeof(cpu_name), "/cpus/PowerPC,8544@%x", i);
         qemu_fdt_add_subnode(fdt, cpu_name);
         qemu_fdt_setprop_cell(fdt, cpu_name, "clock-frequency", clock_freq);
         qemu_fdt_setprop_cell(fdt, cpu_name, "timebase-frequency", tb_freq);
         qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
-        qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
-                              ppc_get_vcpu_dt_id(pcpu));
+        qemu_fdt_setprop_cell(fdt, cpu_name, "reg", i);
         qemu_fdt_setprop_cell(fdt, cpu_name, "d-cache-line-size",
                               env->dcache_line_size);
         qemu_fdt_setprop_cell(fdt, cpu_name, "i-cache-line-size",
-- 
2.13.5
