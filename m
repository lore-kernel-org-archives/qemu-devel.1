Received: from eggs.gnu.org ([2001:4830:134:3::10]:58847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1eBpgg-0003vl-Ez
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 17:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1eBpgf-0001NX-Gl
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 17:16:10 -0500
Date: Mon, 6 Nov 2017 14:16:02 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1711061412330.30448@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH v2] aarch64: advertise the GIC system register
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, xen-devel@lists.xen.org, qemu-arm@nongnu.org, julien.grall@arm.com

When QEMU emulates a GICv3, it needs to advertise the presence of the
system register interface, which is done via id_aa64pfr0.

To do that, and at the same time to avoid advertising the presence of
the system register interface when it is actually not available, set a
boolean property in machvirt_init. Check on the boolean property from
register_cp_regs_for_features and set id_aa64pfr0 accordingly.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9e18b41..369d36b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1401,6 +1401,9 @@ static void machvirt_init(MachineState *machine)
             object_property_set_link(cpuobj, OBJECT(secure_sysmem),
                                      "secure-memory", &error_abort);
         }
+        if (vms->gic_version == 3) {
+            object_property_set_bool(cpuobj, true, "gicv3-sysregs", NULL);
+        }
 
         object_property_set_bool(cpuobj, true, "realized", NULL);
         object_unref(cpuobj);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 88578f3..259cad1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1690,6 +1690,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_BOOL("gicv3-sysregs", ARMCPU, gicv3_sysregs, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 89d49cd..0015b37 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -657,6 +657,9 @@ struct ARMCPU {
     /* Should CPU start in PSCI powered-off state? */
     bool start_powered_off;
 
+    /* GICv3 sysregs present */
+    bool gicv3_sysregs;
+
     /* Current power state, access guarded by BQL */
     ARMPSCIState power_state;
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37af750..6f21900 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4687,7 +4687,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_aa64pfr0 },
+              .resetvalue = cpu->gicv3_sysregs ? (cpu->id_aa64pfr0|0x01000000) :
+                  cpu->id_aa64pfr0 },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
