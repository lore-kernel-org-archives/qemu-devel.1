Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eroD4-00046a-04
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eroCz-0007LY-Vb
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:11:05 -0500
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com
	([104.47.38.47]:33616
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eroCz-0007LR-Lv
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:11:01 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 2 Mar 2018 09:06:12 -0800
Message-ID: <94eef4a24e618d73f9f23a88dd270123d48954d4.1520010339.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1520010339.git.alistair.francis@xilinx.com>
References: <cover.1520010339.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/2] target/arm: Add a cluster size property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

The cortex A53 TRM specifices that bits 24 and 25 of the L2CTLR register
specify the number of cores present and not the number of processors. To
report this correctly on machines with multiple CPU clusters (ARM's
big.LITTLE or Xilinx's ZynqMP) we need to allow the machine to overwrite
this value. To do this let's add an optional property.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 target/arm/cpu.h   |  5 +++++
 target/arm/cpu.c   |  1 +
 target/arm/cpu64.c | 11 +++++++++--
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
index 6b77aaa445..7a17ba1418 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1765,6 +1765,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4228713b19..5e5ae44aeb 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -42,8 +42,15 @@ static inline void unset_feature(CPUARMState *env, int feature)
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* Number of processors is in [25:24]; otherwise we RAZ */
-    return (smp_cpus - 1) << 24;
+    ARMCPU *cpu = arm_env_get_cpu(env);
+
+    /* Number of cores is in [25:24]; otherwise we RAZ */
+    if (cpu->core_count == -1) {
+        /* No core_count specified, default to smp_cpus. */
+        return (smp_cpus - 1) << 24;
+    } else {
+        return (cpu->core_count - 1) << 24;
+    }
 }
 #endif
 
-- 
2.14.1
