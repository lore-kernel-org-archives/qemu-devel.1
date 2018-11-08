Received: from eggs.gnu.org ([2001:4830:134:3::10]:39633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKhR9-0004BF-Pl
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKhOp-00023m-4J
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:18:57 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Thu, 8 Nov 2018 02:15:51 -0800
Message-ID: <1541672153-15529-9-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
References: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v15 08/10] target-arm: kvm64: inject
 synchronous External Abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, mst@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, gengdongjiu@huawei.com

Add synchronous external abort injection logic, setup
exception type and syndrome value. When switch to guest,
guest will jump to the synchronous external abort vector
table entry.

The ESR_ELx.DFSC is set to synchronous external abort(0x10),
and ESR_ELx.FnV is set to not valid(0x1), which will tell
guest that FAR is not valid and holds an UNKNOWN value.
These value will be set to KVM register structures through
KVM_SET_ONE_REG IOCTL.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Marc is against that KVM inject the synchronous external abort(SEA) in [1],
so user space how to inject it. The test result that injection SEA to guest by Qemu
is shown in [2].

[1]: https://lkml.org/lkml/2017/3/2/110
[2]:
Taking exception 4 [Data Abort]
...from EL0 to EL1
...with ESR 0x24/0x92000410
...with FAR 0x0
...with ELR 0x40cf04
...to EL1 PC 0xffffffc000084c00 PSTATE 0x3c5
after kvm_inject_arm_sea
Unhandled fault: synchronous external abort (0x92000410) at 0x0000007fa234c12c
CPU: 0 PID: 536 Comm: devmem Not tainted 4.1.0+ #20
Hardware name: linux,dummy-virt (DT)
task: ffffffc019ab2b00 ti: ffffffc008134000 task.ti: ffffffc008134000
PC is at 0x40cf04
LR is at 0x40cdec
pc : [<000000000040cf04>] lr : [<000000000040cdec>] pstate: 60000000
sp : 0000007ff7b24130
x29: 0000007ff7b24260 x28: 0000000000000000
x27: 00000000000000ad x26: 000000000049c000
x25: 000000000048904b x24: 000000000049c000
x23: 0000000040600000 x22: 0000007ff7b243a0
x21: 0000000000000002 x20: 0000000000000000
x19: 0000000000000020 x18: 0000000000000000
x17: 000000000049c6d0 x16: 0000007fa22c85c0
x15: 0000000000005798 x14: 0000007fa2205f1c
x13: 0000007fa241ccb0 x12: 0000000000000137
x11: 0000000000000000 x10: 0000000000000000
x9 : 0000000000000000 x8 : 00000000000000de
x7 : 0000000000000000 x6 : 0000000000002000
x5 : 0000000040600000 x4 : 0000000000000003
x3 : 0000000000000001 x2 : 0000000000000000
x1 : 0000000000000000 x0 : 0000007fa2418000
---
 target/arm/cpu.h       |  2 ++
 target/arm/helper.c    | 23 +++++++++++++++++++++++
 target/arm/internals.h |  5 +++--
 target/arm/kvm64.c     | 39 +++++++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c |  2 +-
 5 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b5eff79..502507d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2331,6 +2331,8 @@ bool write_list_to_cpustate(ARMCPU *cpu);
  */
 bool write_cpustate_to_list(ARMCPU *cpu);
 
+bool write_part_cpustate_to_list(ARMCPU *cpu, ptrdiff_t fieldoffset);
+
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9630193..df078ff 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -263,6 +263,29 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
     return true;
 }
 
+bool write_part_cpustate_to_list(ARMCPU *cpu, ptrdiff_t fieldoffset)
+{
+    const ARMCPRegInfo *ri;
+    uint32_t regidx, i;
+
+    for (i = 0; i < cpu->cpreg_array_len; i++) {
+        regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
+        ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
+        if (!ri) {
+            continue;
+        }
+
+        if (ri->type & ARM_CP_NO_RAW) {
+            continue;
+        }
+        if (ri->fieldoffset == fieldoffset) {
+            cpu->cpreg_values[i] = read_raw_cp_reg(&cpu->env, ri);
+            return true;
+        }
+    }
+    return false;
+}
+
 bool write_cpustate_to_list(ARMCPU *cpu)
 {
     /* Write the coprocessor state from cpu->env to the (index,value) list. */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6c2bb2d..04ea074 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -415,13 +415,14 @@ static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
         | ARM_EL_IL | (ea << 9) | (s1ptw << 7) | fsc;
 }
 
-static inline uint32_t syn_data_abort_no_iss(int same_el,
+static inline uint32_t syn_data_abort_no_iss(int same_el, int fnv,
                                              int ea, int cm, int s1ptw,
                                              int wnr, int fsc)
 {
     return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
            | ARM_EL_IL
-           | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
+           | (fnv << 10) | (ea << 9) | (cm << 8) | (s1ptw << 7)
+           | (wnr << 6) | fsc;
 }
 
 static inline uint32_t syn_data_abort_with_iss(int same_el,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5de8ff0..0ca2b29 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -594,6 +594,45 @@ int kvm_arm_cpreg_level(uint64_t regidx)
     return KVM_PUT_RUNTIME_STATE;
 }
 
+/* Inject synchronous external abort */
+static void kvm_inject_arm_sea(CPUState *c)
+{
+    ARMCPU *cpu = ARM_CPU(c);
+    CPUARMState *env = &cpu->env;
+    CPUClass *cc = CPU_GET_CLASS(c);
+    uint32_t esr;
+    int ret;
+
+    /* This exception is synchronous data abort */
+    c->exception_index = EXCP_DATA_ABORT;
+    /* Inject the exception to guest EL1 */
+    env->exception.target_el = 1;
+
+    /* Set the DFSC to synchronous external abort and set FnV to not valid,
+     * this will tell guest the FAR_ELx is UNKNOWN for this abort.
+     */
+
+    /* This exception comes from lower or current exception level. */
+    if (arm_current_el(env) == PSTATE_MODE_EL0t) {
+        esr = syn_data_abort_no_iss(0, 1, 0, 0, 0, 0, 0x10);
+    } else {
+        esr = syn_data_abort_no_iss(1, 1, 0, 0, 0, 0, 0x10);
+    }
+
+    env->exception.syndrome = esr;
+
+    cc->do_interrupt(c);
+    if (kvm_enabled()) {
+        /* write ESR_EL1 from cpustate to list*/
+        ret = write_part_cpustate_to_list(cpu,
+                    offsetof(CPUARMState, cp15.esr_el[1]));
+        if (!ret) {
+            fprintf(stderr, "<%s> failed to set esr_el1\n", __func__);
+            abort();
+        }
+    }
+}
+
 #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 90741f6..3f1d656 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -109,7 +109,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
      * ISV field.
      */
     if (!(template_syn & ARM_EL_ISV) || target_el != 2 || s1ptw) {
-        syn = syn_data_abort_no_iss(same_el,
+        syn = syn_data_abort_no_iss(same_el, 0,
                                     ea, 0, s1ptw, is_write, fsc);
     } else {
         /* Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the template
-- 
1.8.3.1
