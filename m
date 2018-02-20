Received: from eggs.gnu.org ([2001:4830:134:3::10]:54003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eoCGb-0008GL-Fn
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eoCGZ-0001k1-Jh
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:03:49 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 18:03:12 +0000
Message-Id: <20180220180325.29818-7-peter.maydell@linaro.org>
In-Reply-To: <20180220180325.29818-1-peter.maydell@linaro.org>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/19] target/arm: Define init-svtor property
 for the reset secure VTOR value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The Cortex-M33 allows the system to specify the reset value of the
secure Vector Table Offset Register (VTOR) by asserting config
signals. In particular, guest images for the MPS2 AN505 board rely
on the MPS2's initial VTOR being correct for that board.
Implement a QEMU property so board and SoC code can set the reset
value to the correct value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 * This patch doesn't try to change the handling of the load itself;
   strictly speaking for real hardware the load of initial PC and
   SP should honour the secure/nonsecure attributes and check
   SAU settings and bus fault responses, as with other vector
   table loads. That is a change for a different patch, if ever.
 * The M33 and MPS2 are actually more flexible than "constant value
   set when the board is created" -- the MPS2 has a register in
   the FPGA which can be used to define the VTOR to use on the
   next (soft) reset, since the M33 samples its config signals
   on every reset. That would be pretty fiddly to implement in
   QEMU (which doesn't even really have a well-defined concept
   of reset which is not a powercycle) so I'm not going to
   implement it unless we run into guest code that needs it.
---
 target/arm/cpu.h |  3 +++
 target/arm/cpu.c | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dc45b740c5..c286169630 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -722,6 +722,9 @@ struct ARMCPU {
      */
     uint32_t psci_conduit;
 
+    /* For v8M, initial value of the Secure VTOR */
+    uint32_t init_svtor;
+
     /* [QEMU_]KVM_ARM_TARGET_* constant for this CPU, or
      * QEMU_KVM_ARM_TARGET_NONE if the kernel doesn't support this CPU type.
      */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 99d00c3ac9..34b5a4a00b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -186,6 +186,7 @@ static void arm_cpu_reset(CPUState *s)
         uint32_t initial_msp; /* Loaded from 0x0 */
         uint32_t initial_pc; /* Loaded from 0x4 */
         uint8_t *rom;
+        uint32_t vecbase;
 
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             env->v7m.secure = true;
@@ -213,8 +214,11 @@ static void arm_cpu_reset(CPUState *s)
         /* Unlike A/R profile, M profile defines the reset LR value */
         env->regs[14] = 0xffffffff;
 
-        /* Load the initial SP and PC from the vector table at address 0 */
-        rom = rom_ptr(0);
+        env->v7m.vecbase[M_REG_S] = cpu->init_svtor;
+
+        /* Load the initial SP and PC from offset 0 and 4 in the vector table */
+        vecbase = env->v7m.vecbase[env->v7m.secure];
+        rom = rom_ptr(vecbase);
         if (rom) {
             /* Address zero is covered by ROM which hasn't yet been
              * copied into physical memory.
@@ -227,8 +231,8 @@ static void arm_cpu_reset(CPUState *s)
              * it got copied into memory. In the latter case, rom_ptr
              * will return a NULL pointer and we should use ldl_phys instead.
              */
-            initial_msp = ldl_phys(s->as, 0);
-            initial_pc = ldl_phys(s->as, 4);
+            initial_msp = ldl_phys(s->as, vecbase);
+            initial_pc = ldl_phys(s->as, vecbase + 4);
         }
 
         env->regs[13] = initial_msp & 0xFFFFFFFC;
@@ -623,6 +627,10 @@ static Property arm_cpu_pmsav7_dregion_property =
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
 
+/* M profile: initial value of the Secure VTOR */
+static Property arm_cpu_initsvtor_property =
+            DEFINE_PROP_UINT32("init-svtor", ARMCPU, init_svtor, 0);
+
 static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -693,6 +701,8 @@ static void arm_cpu_post_init(Object *obj)
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_UNREF_ON_RELEASE,
                                  &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_initsvtor_property,
+                                 &error_abort);
     }
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
-- 
2.16.1
