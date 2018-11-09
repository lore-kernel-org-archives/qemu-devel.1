Received: from eggs.gnu.org ([2001:4830:134:3::10]:59531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gLAhh-00045v-KX
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gLAhg-0001Ht-9M
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:36:21 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Nov 2018 17:35:52 +0000
Message-Id: <20181109173553.22341-2-peter.maydell@linaro.org>
In-Reply-To: <20181109173553.22341-1-peter.maydell@linaro.org>
References: <20181109173553.22341-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Hyp mode R14 is shared with
 User and System
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Adam Lackorzynski <adam.lackorzynski@kernkonzept.com>

Hyp mode is an exception to the general rule that each AArch32
mode has its own r13, r14 and SPSR -- it has a banked r13 and
SPSR but shares its r14 with User and System mode. We were
incorrectly implementing it as banked, which meant that on
entry to Hyp mode r14 was 0 rather than the USR/SYS r14.

We provide a new function r14_bank_number() which is like
the existing bank_number() but provides the index into
env->banked_r14[]; bank_number() provides the index to use
for env->banked_r13[] and env->banked_cpsr[].

All the points in the code that were using bank_number()
to index into env->banked_r14[] are updated for consintency:
 * switch_mode() -- this is the only place where we fix
   an actual bug
 * aarch64_sync_32_to_64() and aarch64_sync_64_to_32():
   no behavioural change as we already special-cased Hyp R14
 * kvm32.c: no behavioural change since the guest can't ever
   be in Hyp mode, but conceptually the right thing to do
 * msr_banked()/mrs_banked(): we can never get to the case
   that accesses banked_r14[] with tgtmode == ARM_CPU_MODE_HYP,
   so no behavioural change

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 16 ++++++++++++++++
 target/arm/helper.c    | 29 +++++++++++++++--------------
 target/arm/kvm32.c     |  4 ++--
 target/arm/op_helper.c |  2 +-
 4 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6c2bb2deebd..e5341f21f6f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -145,6 +145,22 @@ static inline int bank_number(int mode)
     g_assert_not_reached();
 }
 
+/**
+ * r14_bank_number: Map CPU mode onto register bank for r14
+ *
+ * Given an AArch32 CPU mode, return the index into the saved register
+ * banks to use for the R14 (LR) in that mode. This is the same as
+ * bank_number(), except for the special case of Hyp mode, where
+ * R14 is shared with USR and SYS, unlike its R13 and SPSR.
+ * This should be used as the index into env->banked_r14[], and
+ * bank_number() used for the index into env->banked_r13[] and
+ * env->banked_spsr[].
+ */
+static inline int r14_bank_number(int mode)
+{
+    return (mode == ARM_CPU_MODE_HYP) ? BANK_USRSYS : bank_number(mode);
+}
+
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 96301930cc8..6fb1ddc5506 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6455,13 +6455,14 @@ static void switch_mode(CPUARMState *env, int mode)
 
     i = bank_number(old_mode);
     env->banked_r13[i] = env->regs[13];
-    env->banked_r14[i] = env->regs[14];
     env->banked_spsr[i] = env->spsr;
 
     i = bank_number(mode);
     env->regs[13] = env->banked_r13[i];
-    env->regs[14] = env->banked_r14[i];
     env->spsr = env->banked_spsr[i];
+
+    env->banked_r14[r14_bank_number(old_mode)] = env->regs[14];
+    env->regs[14] = env->banked_r14[r14_bank_number(mode)];
 }
 
 /* Physical Interrupt Target EL Lookup Table
@@ -8040,7 +8041,7 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         if (mode == ARM_CPU_MODE_HYP) {
             env->xregs[14] = env->regs[14];
         } else {
-            env->xregs[14] = env->banked_r14[bank_number(ARM_CPU_MODE_USR)];
+            env->xregs[14] = env->banked_r14[r14_bank_number(ARM_CPU_MODE_USR)];
         }
     }
 
@@ -8054,7 +8055,7 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         env->xregs[16] = env->regs[14];
         env->xregs[17] = env->regs[13];
     } else {
-        env->xregs[16] = env->banked_r14[bank_number(ARM_CPU_MODE_IRQ)];
+        env->xregs[16] = env->banked_r14[r14_bank_number(ARM_CPU_MODE_IRQ)];
         env->xregs[17] = env->banked_r13[bank_number(ARM_CPU_MODE_IRQ)];
     }
 
@@ -8062,7 +8063,7 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         env->xregs[18] = env->regs[14];
         env->xregs[19] = env->regs[13];
     } else {
-        env->xregs[18] = env->banked_r14[bank_number(ARM_CPU_MODE_SVC)];
+        env->xregs[18] = env->banked_r14[r14_bank_number(ARM_CPU_MODE_SVC)];
         env->xregs[19] = env->banked_r13[bank_number(ARM_CPU_MODE_SVC)];
     }
 
@@ -8070,7 +8071,7 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         env->xregs[20] = env->regs[14];
         env->xregs[21] = env->regs[13];
     } else {
-        env->xregs[20] = env->banked_r14[bank_number(ARM_CPU_MODE_ABT)];
+        env->xregs[20] = env->banked_r14[r14_bank_number(ARM_CPU_MODE_ABT)];
         env->xregs[21] = env->banked_r13[bank_number(ARM_CPU_MODE_ABT)];
     }
 
@@ -8078,7 +8079,7 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         env->xregs[22] = env->regs[14];
         env->xregs[23] = env->regs[13];
     } else {
-        env->xregs[22] = env->banked_r14[bank_number(ARM_CPU_MODE_UND)];
+        env->xregs[22] = env->banked_r14[r14_bank_number(ARM_CPU_MODE_UND)];
         env->xregs[23] = env->banked_r13[bank_number(ARM_CPU_MODE_UND)];
     }
 
@@ -8095,7 +8096,7 @@ void aarch64_sync_32_to_64(CPUARMState *env)
             env->xregs[i] = env->fiq_regs[i - 24];
         }
         env->xregs[29] = env->banked_r13[bank_number(ARM_CPU_MODE_FIQ)];
-        env->xregs[30] = env->banked_r14[bank_number(ARM_CPU_MODE_FIQ)];
+        env->xregs[30] = env->banked_r14[r14_bank_number(ARM_CPU_MODE_FIQ)];
     }
 
     env->pc = env->regs[15];
@@ -8145,7 +8146,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         if (mode == ARM_CPU_MODE_HYP) {
             env->regs[14] = env->xregs[14];
         } else {
-            env->banked_r14[bank_number(ARM_CPU_MODE_USR)] = env->xregs[14];
+            env->banked_r14[r14_bank_number(ARM_CPU_MODE_USR)] = env->xregs[14];
         }
     }
 
@@ -8159,7 +8160,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         env->regs[14] = env->xregs[16];
         env->regs[13] = env->xregs[17];
     } else {
-        env->banked_r14[bank_number(ARM_CPU_MODE_IRQ)] = env->xregs[16];
+        env->banked_r14[r14_bank_number(ARM_CPU_MODE_IRQ)] = env->xregs[16];
         env->banked_r13[bank_number(ARM_CPU_MODE_IRQ)] = env->xregs[17];
     }
 
@@ -8167,7 +8168,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         env->regs[14] = env->xregs[18];
         env->regs[13] = env->xregs[19];
     } else {
-        env->banked_r14[bank_number(ARM_CPU_MODE_SVC)] = env->xregs[18];
+        env->banked_r14[r14_bank_number(ARM_CPU_MODE_SVC)] = env->xregs[18];
         env->banked_r13[bank_number(ARM_CPU_MODE_SVC)] = env->xregs[19];
     }
 
@@ -8175,7 +8176,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         env->regs[14] = env->xregs[20];
         env->regs[13] = env->xregs[21];
     } else {
-        env->banked_r14[bank_number(ARM_CPU_MODE_ABT)] = env->xregs[20];
+        env->banked_r14[r14_bank_number(ARM_CPU_MODE_ABT)] = env->xregs[20];
         env->banked_r13[bank_number(ARM_CPU_MODE_ABT)] = env->xregs[21];
     }
 
@@ -8183,7 +8184,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         env->regs[14] = env->xregs[22];
         env->regs[13] = env->xregs[23];
     } else {
-        env->banked_r14[bank_number(ARM_CPU_MODE_UND)] = env->xregs[22];
+        env->banked_r14[r14_bank_number(ARM_CPU_MODE_UND)] = env->xregs[22];
         env->banked_r13[bank_number(ARM_CPU_MODE_UND)] = env->xregs[23];
     }
 
@@ -8200,7 +8201,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
             env->fiq_regs[i - 24] = env->xregs[i];
         }
         env->banked_r13[bank_number(ARM_CPU_MODE_FIQ)] = env->xregs[29];
-        env->banked_r14[bank_number(ARM_CPU_MODE_FIQ)] = env->xregs[30];
+        env->banked_r14[r14_bank_number(ARM_CPU_MODE_FIQ)] = env->xregs[30];
     }
 
     env->regs[15] = env->pc;
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 0f1e94c7b5e..cb3fb73a961 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -318,8 +318,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         memcpy(env->usr_regs, env->regs + 8, 5 * sizeof(uint32_t));
     }
     env->banked_r13[bn] = env->regs[13];
-    env->banked_r14[bn] = env->regs[14];
     env->banked_spsr[bn] = env->spsr;
+    env->banked_r14[r14_bank_number(mode)] = env->regs[14];
 
     /* Now we can safely copy stuff down to the kernel */
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
@@ -430,8 +430,8 @@ int kvm_arch_get_registers(CPUState *cs)
         memcpy(env->regs + 8, env->usr_regs, 5 * sizeof(uint32_t));
     }
     env->regs[13] = env->banked_r13[bn];
-    env->regs[14] = env->banked_r14[bn];
     env->spsr = env->banked_spsr[bn];
+    env->regs[14] = env->banked_r14[r14_bank_number(mode)];
 
     /* VFP registers */
     r.id = KVM_REG_ARM | KVM_REG_SIZE_U64 | KVM_REG_ARM_VFP;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 90741f6331d..2b62c53f5b5 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -694,7 +694,7 @@ void HELPER(msr_banked)(CPUARMState *env, uint32_t value, uint32_t tgtmode,
         env->banked_r13[bank_number(tgtmode)] = value;
         break;
     case 14:
-        env->banked_r14[bank_number(tgtmode)] = value;
+        env->banked_r14[r14_bank_number(tgtmode)] = value;
         break;
     case 8 ... 12:
         switch (tgtmode) {
-- 
2.19.1
