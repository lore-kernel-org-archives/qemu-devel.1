Received: from eggs.gnu.org ([209.51.188.92]:36443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJZ0-0001QO-CW
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYz-00040R-5Q
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:18 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYy-0003zL-Ud
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:17 -0500
Received: by mail-wm1-x344.google.com with SMTP id e74so8740026wmg.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.09.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:09:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:30 +0000
Message-Id: <20190228110835.16159-12-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/16] Revert "arm: Allow system registers for
 KVM guests to be changed by QEMU code"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This reverts commit 823e1b3818f9b10b824ddcd756983b6e2fa68730,
which introduces a regression running EDK2 guest firmware
under KVM:

error: kvm run failed Function not implemented
 PC=000000013f5a6208 X00=00000000404003c4 X01=000000000000003a
X02=0000000000000000 X03=00000000404003c4 X04=0000000000000000
X05=0000000096000046 X06=000000013d2ef270 X07=000000013e3d1710
X08=09010755ffaf8ba8 X09=ffaf8b9cfeeb5468 X10=feeb546409010756
X11=09010757ffaf8b90 X12=feeb50680903068b X13=090306a1ffaf8bc0
X14=0000000000000000 X15=0000000000000000 X16=000000013f872da0
X17=00000000ffffa6ab X18=0000000000000000 X19=000000013f5a92d0
X20=000000013f5a7a78 X21=000000000000003a X22=000000013f5a7ab2
X23=000000013f5a92e8 X24=000000013f631090 X25=0000000000000010
X26=0000000000000100 X27=000000013f89501b X28=000000013e3d14e0
X29=000000013e3d12a0 X30=000000013f5a2518  SP=000000013b7be0b0
PSTATE=404003c4 -Z-- EL1t

with
[ 3507.926571] kvm [35042]: load/store instruction decoding not implemented
in the host dmesg.

Revert the change for the moment until we can investigate the
cause of the regression.

Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  9 +--------
 target/arm/helper.c  | 27 ++-------------------------
 target/arm/kvm32.c   | 20 ++++++++++++++++++--
 target/arm/kvm64.c   |  2 --
 target/arm/machine.c |  2 +-
 5 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ff9ba387b42..3e545a2b146 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2558,25 +2558,18 @@ bool write_list_to_cpustate(ARMCPU *cpu);
 /**
  * write_cpustate_to_list:
  * @cpu: ARMCPU
- * @kvm_sync: true if this is for syncing back to KVM
  *
  * For each register listed in the ARMCPU cpreg_indexes list, write
  * its value from the ARMCPUState structure into the cpreg_values list.
  * This is used to copy info from TCG's working data structures into
  * KVM or for outbound migration.
  *
- * @kvm_sync is true if we are doing this in order to sync the
- * register state back to KVM. In this case we will only update
- * values in the list if the previous list->cpustate sync actually
- * successfully wrote the CPU state. Otherwise we will keep the value
- * that is in the list.
- *
  * Returns: true if all register values were read correctly,
  * false if some register was unknown or could not be read.
  * Note that we do not stop early on failure -- we will attempt
  * reading all registers in the list.
  */
-bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
+bool write_cpustate_to_list(ARMCPU *cpu);
 
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fbaa801ceaa..1fa282a7fc1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -265,7 +265,7 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
     return true;
 }
 
-bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
+bool write_cpustate_to_list(ARMCPU *cpu)
 {
     /* Write the coprocessor state from cpu->env to the (index,value) list. */
     int i;
@@ -274,7 +274,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
     for (i = 0; i < cpu->cpreg_array_len; i++) {
         uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
         const ARMCPRegInfo *ri;
-        uint64_t newval;
 
         ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
         if (!ri) {
@@ -284,29 +283,7 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
         if (ri->type & ARM_CP_NO_RAW) {
             continue;
         }
-
-        newval = read_raw_cp_reg(&cpu->env, ri);
-        if (kvm_sync) {
-            /*
-             * Only sync if the previous list->cpustate sync succeeded.
-             * Rather than tracking the success/failure state for every
-             * item in the list, we just recheck "does the raw write we must
-             * have made in write_list_to_cpustate() read back OK" here.
-             */
-            uint64_t oldval = cpu->cpreg_values[i];
-
-            if (oldval == newval) {
-                continue;
-            }
-
-            write_raw_cp_reg(&cpu->env, ri, oldval);
-            if (read_raw_cp_reg(&cpu->env, ri) != oldval) {
-                continue;
-            }
-
-            write_raw_cp_reg(&cpu->env, ri, newval);
-        }
-        cpu->cpreg_values[i] = newval;
+        cpu->cpreg_values[i] = read_raw_cp_reg(&cpu->env, ri);
     }
     return ok;
 }
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 327375f6252..50327989dcc 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -384,8 +384,24 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    write_cpustate_to_list(cpu, true);
-
+    /* Note that we do not call write_cpustate_to_list()
+     * here, so we are only writing the tuple list back to
+     * KVM. This is safe because nothing can change the
+     * CPUARMState cp15 fields (in particular gdb accesses cannot)
+     * and so there are no changes to sync. In fact syncing would
+     * be wrong at this point: for a constant register where TCG and
+     * KVM disagree about its value, the preceding write_list_to_cpustate()
+     * would not have had any effect on the CPUARMState value (since the
+     * register is read-only), and a write_cpustate_to_list() here would
+     * then try to write the TCG value back into KVM -- this would either
+     * fail or incorrectly change the value the guest sees.
+     *
+     * If we ever want to allow the user to modify cp15 registers via
+     * the gdb stub, we would need to be more clever here (for instance
+     * tracking the set of registers kvm_arch_get_registers() successfully
+     * managed to update the CPUARMState with, and only allowing those
+     * to be written back up into the kernel).
+     */
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e3ba1492482..089af9c5f02 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -838,8 +838,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    write_cpustate_to_list(cpu, true);
-
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 124192bfc26..b2925496148 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -630,7 +630,7 @@ static int cpu_pre_save(void *opaque)
             abort();
         }
     } else {
-        if (!write_cpustate_to_list(cpu, false)) {
+        if (!write_cpustate_to_list(cpu)) {
             /* This should never fail. */
             abort();
         }
-- 
2.20.1
