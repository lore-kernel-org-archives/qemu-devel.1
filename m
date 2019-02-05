Received: from eggs.gnu.org ([209.51.188.92]:52995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zd-0007sh-Rn
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zb-0004Iq-41
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:49 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gr5zZ-00047p-Nu
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so4897379wrv.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:02:29 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Feb 2019 19:02:24 +0000
Message-Id: <20190205190224.2198-7-alex.bennee@linaro.org>
In-Reply-To: <20190205190224.2198-1-alex.bennee@linaro.org>
References: <20190205190224.2198-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/6] tests/tcg/aarch64: userspace system
 register test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This tests a bunch of registers that the kernel allows userspace to
read including the CPUID registers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - also test for extra bits that shouldn't be exposed
v5
  - work around missing HWCAP_CPUID on older compilers
  - add more registers to test and some aarch32 regs
  - add more details commentary
  - fix up the masks (add a helper to help keep track)
  - add copyright header
---
 tests/tcg/aarch64/Makefile.target |   4 +-
 tests/tcg/aarch64/sysregs.c       | 172 ++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/sysregs.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 08c45b8470..fb40896e7b 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -7,11 +7,13 @@ VPATH 		+= $(AARCH64_SRC)
 
 # we don't build any of the ARM tests
 AARCH64_TESTS=$(filter-out $(ARM_TESTS), $(TESTS))
-AARCH64_TESTS+=fcvt
+AARCH64_TESTS+=fcvt sysregs
 TESTS:=$(AARCH64_TESTS)
 
 fcvt: LDFLAGS+=-lm
 
+sysregs: CFLAGS+=-march=armv8.1-a+sve
+
 run-fcvt: fcvt
 	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
new file mode 100644
index 0000000000..40cf8d2877
--- /dev/null
+++ b/tests/tcg/aarch64/sysregs.c
@@ -0,0 +1,172 @@
+/*
+ * Check emulated system register access for linux-user mode.
+ *
+ * See: https://www.kernel.org/doc/Documentation/arm64/cpu-feature-registers.txt
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/hwcap.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <signal.h>
+#include <string.h>
+#include <stdbool.h>
+
+#ifndef HWCAP_CPUID
+#define HWCAP_CPUID (1 << 11)
+#endif
+
+int failed_bit_count;
+
+/* Read and print system register `id' value */
+#define get_cpu_reg(id) ({                                      \
+            unsigned long __val = 0xdeadbeef;                   \
+            asm("mrs %0, "#id : "=r" (__val));                  \
+            printf("%-20s: 0x%016lx\n", #id, __val);            \
+            __val;                                               \
+        })
+
+/* As above but also check no bits outside of `mask' are set*/
+#define get_cpu_reg_check_mask(id, mask) ({                     \
+            unsigned long __cval = get_cpu_reg(id);             \
+            unsigned long __extra = __cval & ~mask;             \
+            if (__extra) {                                      \
+                printf("%-20s: 0x%016lx\n", "  !!extra bits!!", __extra);   \
+                failed_bit_count++;                            \
+            }                                                   \
+})
+
+/* As above but check RAZ */
+#define get_cpu_reg_check_zero(id) ({                           \
+            unsigned long __val = 0xdeadbeef;                   \
+            asm("mrs %0, "#id : "=r" (__val));                  \
+            if (__val) {                                        \
+                printf("%-20s: 0x%016lx (not RAZ!)\n", #id, __val);        \
+                failed_bit_count++;                            \
+            }                                                   \
+})
+
+/* Chunk up mask into 63:48, 47:32, 31:16, 15:0 to ease counting */
+#define _m(a, b, c, d) (0x ## a ## b ## c ## d ##ULL)
+
+bool should_fail;
+int should_fail_count;
+int should_not_fail_count;
+uintptr_t failed_pc[10];
+
+void sigill_handler(int signo, siginfo_t *si, void *data)
+{
+    ucontext_t *uc = (ucontext_t *)data;
+
+    if (should_fail) {
+        should_fail_count++;
+    } else {
+        uintptr_t pc = (uintptr_t) uc->uc_mcontext.pc;
+        failed_pc[should_not_fail_count++] =  pc;
+    }
+    uc->uc_mcontext.pc += 4;
+}
+
+int main(void)
+{
+    struct sigaction sa;
+
+    /* Hook in a SIGILL handler */
+    memset(&sa, 0, sizeof(struct sigaction));
+    sa.sa_flags = SA_SIGINFO;
+    sa.sa_sigaction = &sigill_handler;
+    sigemptyset(&sa.sa_mask);
+
+    if (sigaction(SIGILL, &sa, 0) != 0) {
+        perror("sigaction");
+        return 1;
+    }
+
+    /* Counter values have been exposed since Linux 4.12 */
+    printf("Checking Counter registers\n");
+
+    get_cpu_reg(ctr_el0);
+    get_cpu_reg(cntvct_el0);
+    get_cpu_reg(cntfrq_el0);
+
+    /* HWCAP_CPUID indicates we can read feature registers, since Linux 4.11 */
+    if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
+        printf("CPUID registers unavailable\n");
+        return 1;
+    } else {
+        printf("Checking CPUID registers\n");
+    }
+
+    /*
+     * Some registers only expose some bits to user-space. Anything
+     * that is IMPDEF is exported as 0 to user-space. The _mask checks
+     * assert no extra bits are set.
+     *
+     * This check is *not* comprehensive as some fields are set to
+     * minimum valid fields - for the purposes of this check allowed
+     * to have non-zero values.
+     */
+    get_cpu_reg_check_mask(id_aa64isar0_el1, _m(00ff,ffff,f0ff,fff0));
+    get_cpu_reg_check_mask(id_aa64isar1_el1, _m(0000,00f0,ffff,ffff));
+    /* TGran4 & TGran64 as pegged to -1 */
+    get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(0000,0000,ff00,0000));
+    get_cpu_reg_check_zero(id_aa64mmfr1_el1);
+    /* EL1/EL0 reported as AA64 only */
+    get_cpu_reg_check_mask(id_aa64pfr0_el1,  _m(000f,000f,00ff,0011));
+    get_cpu_reg_check_mask(id_aa64pfr1_el1,  _m(0000,0000,0000,00f0));
+    /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
+    get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
+    get_cpu_reg_check_zero(id_aa64dfr1_el1);
+    get_cpu_reg_check_zero(id_aa64zfr0_el1);
+
+    get_cpu_reg_check_zero(id_aa64afr0_el1);
+    get_cpu_reg_check_zero(id_aa64afr1_el1);
+
+    get_cpu_reg_check_mask(midr_el1,         _m(0000,0000,ffff,ffff));
+    /* mpidr sets bit 31, everything else hidden */
+    get_cpu_reg_check_mask(mpidr_el1,        _m(0000,0000,8000,0000));
+    /* REVIDR is all IMPDEF so should be all zeros to user-space */
+    get_cpu_reg_check_zero(revidr_el1);
+
+    /*
+     * There are a block of more registers that are RAZ in the rest of
+     * the Op0=3, Op1=0, CRn=0, CRm=0,4,5,6,7 space. However for
+     * brevity we don't check stuff that is currently un-allocated
+     * here. Feel free to add them ;-)
+     */
+
+    printf("Remaining registers should fail\n");
+    should_fail = true;
+
+    /* Unexposed register access causes SIGILL */
+    get_cpu_reg(id_mmfr0_el1);
+    get_cpu_reg(id_mmfr1_el1);
+    get_cpu_reg(id_mmfr2_el1);
+    get_cpu_reg(id_mmfr3_el1);
+
+    get_cpu_reg(mvfr0_el1);
+    get_cpu_reg(mvfr1_el1);
+
+    if (should_not_fail_count > 0) {
+        int i;
+        for (i = 0; i < should_not_fail_count; i++) {
+            uintptr_t pc = failed_pc[i];
+            uint32_t insn = *(uint32_t *) pc;
+            printf("insn %#x @ %#lx unexpected FAIL\n", insn, pc);
+        }
+        return 1;
+    }
+
+    if (failed_bit_count > 0) {
+        printf("Extra information leaked to user-space!\n");
+        return 1;
+    }
+
+    return should_fail_count == 6 ? 0 : 1;
+}
-- 
2.20.1
