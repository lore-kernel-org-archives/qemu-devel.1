Received: from eggs.gnu.org ([2001:4830:134:3::10]:43357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWY-0002on-Ur
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWX-0004rB-SY
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:50 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWX-0004oB-Kx
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:49 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWW-0001Km-CV
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:11 +0000
Message-Id: <20180302110640.28004-11-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/39] target/arm: Define init-svtor property
 for the reset secure VTOR value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The Cortex-M33 allows the system to specify the reset value of the
secure Vector Table Offset Register (VTOR) by asserting config
signals. In particular, guest images for the MPS2 AN505 board rely
on the MPS2's initial VTOR being correct for that board.
Implement a QEMU property so board and SoC code can set the reset
value to the correct value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-7-peter.maydell@linaro.org
---
 target/arm/cpu.h |  3 +++
 target/arm/cpu.c | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4710a43110..72b5668377 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -731,6 +731,9 @@ struct ARMCPU {
      */
     uint32_t psci_conduit;
 
+    /* For v8M, initial value of the Secure VTOR */
+    uint32_t init_svtor;
+
     /* [QEMU_]KVM_ARM_TARGET_* constant for this CPU, or
      * QEMU_KVM_ARM_TARGET_NONE if the kernel doesn't support this CPU type.
      */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 291ff0b1db..27d9e90308 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -187,6 +187,7 @@ static void arm_cpu_reset(CPUState *s)
         uint32_t initial_msp; /* Loaded from 0x0 */
         uint32_t initial_pc; /* Loaded from 0x4 */
         uint8_t *rom;
+        uint32_t vecbase;
 
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             env->v7m.secure = true;
@@ -214,8 +215,11 @@ static void arm_cpu_reset(CPUState *s)
         /* Unlike A/R profile, M profile defines the reset LR value */
         env->regs[14] = 0xffffffff;
 
-        /* Load the initial SP and PC from the vector table at address 0 */
-        rom = rom_ptr(0);
+        env->v7m.vecbase[M_REG_S] = cpu->init_svtor & 0xffffff80;
+
+        /* Load the initial SP and PC from offset 0 and 4 in the vector table */
+        vecbase = env->v7m.vecbase[env->v7m.secure];
+        rom = rom_ptr(vecbase);
         if (rom) {
             /* Address zero is covered by ROM which hasn't yet been
              * copied into physical memory.
@@ -228,8 +232,8 @@ static void arm_cpu_reset(CPUState *s)
              * it got copied into memory. In the latter case, rom_ptr
              * will return a NULL pointer and we should use ldl_phys instead.
              */
-            initial_msp = ldl_phys(s->as, 0);
-            initial_pc = ldl_phys(s->as, 4);
+            initial_msp = ldl_phys(s->as, vecbase);
+            initial_pc = ldl_phys(s->as, vecbase + 4);
         }
 
         env->regs[13] = initial_msp & 0xFFFFFFFC;
@@ -624,6 +628,10 @@ static Property arm_cpu_pmsav7_dregion_property =
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
 
+/* M profile: initial value of the Secure VTOR */
+static Property arm_cpu_initsvtor_property =
+            DEFINE_PROP_UINT32("init-svtor", ARMCPU, init_svtor, 0);
+
 static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -694,6 +702,8 @@ static void arm_cpu_post_init(Object *obj)
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_UNREF_ON_RELEASE,
                                  &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_initsvtor_property,
+                                 &error_abort);
     }
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
-- 
2.16.2
