Received: from eggs.gnu.org ([2001:4830:134:3::10]:48360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dd9cm-00059I-49
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dd9cj-0007D6-4e
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54841
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dd9ci-0007CV-VA
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v736SfY0122247
	for <qemu-devel@nongnu.org>; Thu, 3 Aug 2017 02:28:44 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c3q2em672-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 02:28:43 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 3 Aug 2017 16:28:41 +1000
Date: Thu, 3 Aug 2017 16:28:36 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
Message-Id: <31205fa54bd9761aee5fb3a6724c98f7e9e86240.1501740002.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 2/4] e500: Use cpu_index instead of vcpu_dt_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de

The e500 platform code uses the function ppc_get_vcpu_dt_id() but that
function is actually specific to SPAPR machines, not PPC CPUs, and
will always return the cpu_index in this context.

Simply use the cpu_index instead (which is 'i' in this context
because qemu_get_cpu(i) returns the cpu with cpu_index == i).

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/e500.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 62f1857206..2a6d34ceb1 100644
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
2.12.1.382.gc0f9c7058
