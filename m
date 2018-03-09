Received: from eggs.gnu.org ([2001:4830:134:3::10]:59712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmx-0008Tm-By
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmv-00068j-7E
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmu-00064P-VR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmh-00073e-Oc
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:25:58 +0000
Message-Id: <20180309172622.4277-2-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/25] target/arm: Add a core count property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

The cortex A53 TRM specifies that bits 24 and 25 of the L2CTLR register
specify the number of cores in the processor, not the total number of
cores in the system. To report this correctly on machines with multiple
CPU clusters (ARM's big.LITTLE or Xilinx's ZynqMP) we need to allow
the machine to overwrite this value. To do this let's add an optional
property.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: ef01d95c0759e88f47f22d11b14c91512a658b4f.1520018138.git.alistair.francis@xilinx.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h   | 5 +++++
 target/arm/cpu.c   | 6 ++++++
 target/arm/cpu64.c | 6 ++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8dd6b788df..3fa8fdad21 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -745,6 +745,11 @@ struct ARMCPU {
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
+    /* Specify the number of cores in this CPU cluster. Used for the L2CTLR
+     * register.
+     */
+    int32_t core_count;
+
     /* The instance init functions for implementation-specific subclasses
      * set these fields to specify the implementation-dependent values of
      * various constant registers and reset values of non-constant
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6b77aaa445..3e4e9f1873 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -939,6 +939,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cs->num_ases = 1;
     }
     cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
+
+    /* No core_count specified, default to smp_cpus. */
+    if (cpu->core_count == -1) {
+        cpu->core_count = smp_cpus;
+    }
 #endif
 
     qemu_init_vcpu(cs);
@@ -1765,6 +1770,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4228713b19..dd9ba973f7 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -42,8 +42,10 @@ static inline void unset_feature(CPUARMState *env, int feature)
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* Number of processors is in [25:24]; otherwise we RAZ */
-    return (smp_cpus - 1) << 24;
+    ARMCPU *cpu = arm_env_get_cpu(env);
+
+    /* Number of cores is in [25:24]; otherwise we RAZ */
+    return (cpu->core_count - 1) << 24;
 }
 #endif
 
-- 
2.16.2
