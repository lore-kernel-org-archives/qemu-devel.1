Received: from eggs.gnu.org ([209.51.188.92]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLD-0007zY-O0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guML4-0004mh-U3
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:30 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKz-0004j4-QY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:23 -0500
Received: by mail-wm1-x330.google.com with SMTP id v26so7193031wmh.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:47 +0000
Message-Id: <20190214190603.25030-12-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

At the moment the Arm implementations of kvm_arch_{get,put}_registers()
don't support having QEMU change the values of system registers
(aka coprocessor registers for AArch32). This is because although
kvm_arch_get_registers() calls write_list_to_cpustate() to
update the CPU state struct fields (so QEMU code can read the
values in the usual way), kvm_arch_put_registers() does not
call write_cpustate_to_list(), meaning that any changes to
the CPU state struct fields will not be passed back to KVM.

The rationale for this design is documented in a comment in the
AArch32 kvm_arch_put_registers() -- writing the values in the
cpregs list into the CPU state struct is "lossy" because the
write of a register might not succeed, and so if we blindly
copy the CPU state values back again we will incorrectly
change register values for the guest. The assumption was that
no QEMU code would need to write to the registers.

However, when we implemented debug support for KVM guests, we
broke that assumption: the code to handle "set the guest up
to take a breakpoint exception" does so by updating various
guest registers including ESR_EL1.

Support this by making kvm_arch_put_registers() synchronize
CPU state back into the list. We sync only those registers
where the initial write succeeds, which should be sufficient.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 target/arm/cpu.h     |  9 ++++++++-
 target/arm/helper.c  | 27 +++++++++++++++++++++++++--
 target/arm/kvm32.c   | 20 ++------------------
 target/arm/kvm64.c   |  2 ++
 target/arm/machine.c |  2 +-
 5 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f0334413ece..bfc05c796a5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2535,18 +2535,25 @@ bool write_list_to_cpustate(ARMCPU *cpu);
 /**
  * write_cpustate_to_list:
  * @cpu: ARMCPU
+ * @kvm_sync: true if this is for syncing back to KVM
  *
  * For each register listed in the ARMCPU cpreg_indexes list, write
  * its value from the ARMCPUState structure into the cpreg_values list.
  * This is used to copy info from TCG's working data structures into
  * KVM or for outbound migration.
  *
+ * @kvm_sync is true if we are doing this in order to sync the
+ * register state back to KVM. In this case we will only update
+ * values in the list if the previous list->cpustate sync actually
+ * successfully wrote the CPU state. Otherwise we will keep the value
+ * that is in the list.
+ *
  * Returns: true if all register values were read correctly,
  * false if some register was unknown or could not be read.
  * Note that we do not stop early on failure -- we will attempt
  * reading all registers in the list.
  */
-bool write_cpustate_to_list(ARMCPU *cpu);
+bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5ac335f598c..7653aa6a50a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -264,7 +264,7 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
     return true;
 }
 
-bool write_cpustate_to_list(ARMCPU *cpu)
+bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
 {
     /* Write the coprocessor state from cpu->env to the (index,value) list. */
     int i;
@@ -273,6 +273,7 @@ bool write_cpustate_to_list(ARMCPU *cpu)
     for (i = 0; i < cpu->cpreg_array_len; i++) {
         uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
         const ARMCPRegInfo *ri;
+        uint64_t newval;
 
         ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
         if (!ri) {
@@ -282,7 +283,29 @@ bool write_cpustate_to_list(ARMCPU *cpu)
         if (ri->type & ARM_CP_NO_RAW) {
             continue;
         }
-        cpu->cpreg_values[i] = read_raw_cp_reg(&cpu->env, ri);
+
+        newval = read_raw_cp_reg(&cpu->env, ri);
+        if (kvm_sync) {
+            /*
+             * Only sync if the previous list->cpustate sync succeeded.
+             * Rather than tracking the success/failure state for every
+             * item in the list, we just recheck "does the raw write we must
+             * have made in write_list_to_cpustate() read back OK" here.
+             */
+            uint64_t oldval = cpu->cpreg_values[i];
+
+            if (oldval == newval) {
+                continue;
+            }
+
+            write_raw_cp_reg(&cpu->env, ri, oldval);
+            if (read_raw_cp_reg(&cpu->env, ri) != oldval) {
+                continue;
+            }
+
+            write_raw_cp_reg(&cpu->env, ri, newval);
+        }
+        cpu->cpreg_values[i] = newval;
     }
     return ok;
 }
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index bd51eb43c86..a75e04cc8f3 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -387,24 +387,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    /* Note that we do not call write_cpustate_to_list()
-     * here, so we are only writing the tuple list back to
-     * KVM. This is safe because nothing can change the
-     * CPUARMState cp15 fields (in particular gdb accesses cannot)
-     * and so there are no changes to sync. In fact syncing would
-     * be wrong at this point: for a constant register where TCG and
-     * KVM disagree about its value, the preceding write_list_to_cpustate()
-     * would not have had any effect on the CPUARMState value (since the
-     * register is read-only), and a write_cpustate_to_list() here would
-     * then try to write the TCG value back into KVM -- this would either
-     * fail or incorrectly change the value the guest sees.
-     *
-     * If we ever want to allow the user to modify cp15 registers via
-     * the gdb stub, we would need to be more clever here (for instance
-     * tracking the set of registers kvm_arch_get_registers() successfully
-     * managed to update the CPUARMState with, and only allowing those
-     * to be written back up into the kernel).
-     */
+    write_cpustate_to_list(cpu, true);
+
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 089af9c5f02..e3ba1492482 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -838,6 +838,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    write_cpustate_to_list(cpu, true);
+
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b2925496148..124192bfc26 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -630,7 +630,7 @@ static int cpu_pre_save(void *opaque)
             abort();
         }
     } else {
-        if (!write_cpustate_to_list(cpu)) {
+        if (!write_cpustate_to_list(cpu, false)) {
             /* This should never fail. */
             abort();
         }
-- 
2.20.1
