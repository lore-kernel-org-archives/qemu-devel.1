Received: from eggs.gnu.org ([2001:4830:134:3::10]:52851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTub-0004yp-NM
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTua-00055E-Gg
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXTua-000548-A2
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:16 -0400
Received: by mail-wm0-x241.google.com with SMTP id 69-v6so10601310wmf.3
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:00:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 17:00:09 +0100
Message-Id: <20180625160009.17437-6-alex.bennee@linaro.org>
In-Reply-To: <20180625160009.17437-1-alex.bennee@linaro.org>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 5/5] tests/tcg/aarch64: userspace system
 register test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This tests a bunch of registers that the kernel allows userspace to
read including the CPUID registers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/sysregs.c       | 99 +++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/sysregs.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 08c45b8470..cc1a7eb486 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -7,7 +7,7 @@ VPATH 		+= $(AARCH64_SRC)
 
 # we don't build any of the ARM tests
 AARCH64_TESTS=$(filter-out $(ARM_TESTS), $(TESTS))
-AARCH64_TESTS+=fcvt
+AARCH64_TESTS+=fcvt sysregs
 TESTS:=$(AARCH64_TESTS)
 
 fcvt: LDFLAGS+=-lm
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
new file mode 100644
index 0000000000..177d1fe33b
--- /dev/null
+++ b/tests/tcg/aarch64/sysregs.c
@@ -0,0 +1,99 @@
+/*
+ * Check emulated system register access for linux-user mode.
+ *
+ * See: https://www.kernel.org/doc/Documentation/arm64/cpu-feature-registers.txt
+ */
+
+#include <asm/hwcap.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <signal.h>
+#include <string.h>
+#include <stdbool.h>
+
+#define get_cpu_reg(id) ({                                      \
+            unsigned long __val = 0xdeadbeef;                   \
+            asm("mrs %0, "#id : "=r" (__val));                  \
+            printf("%-20s: 0x%016lx\n", #id, __val);            \
+        })
+
+bool should_fail;
+
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
+    /* since 4.12 */
+    printf("Checking CNT registers\n");
+
+    get_cpu_reg(ctr_el0);
+    get_cpu_reg(cntvct_el0);
+    get_cpu_reg(cntfrq_el0);
+
+    /* when (getauxval(AT_HWCAP) & HWCAP_CPUID), since 4.11*/
+    if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
+        printf("CPUID registers unavailable\n");
+        return 1;
+    } else {
+        printf("Checking CPUID registers\n");
+    }
+
+    get_cpu_reg(id_aa64isar0_el1);
+    get_cpu_reg(id_aa64isar1_el1);
+    get_cpu_reg(id_aa64mmfr0_el1);
+    get_cpu_reg(id_aa64mmfr1_el1);
+    get_cpu_reg(id_aa64pfr0_el1);
+    get_cpu_reg(id_aa64pfr1_el1);
+    get_cpu_reg(id_aa64dfr0_el1);
+    get_cpu_reg(id_aa64dfr1_el1);
+
+    get_cpu_reg(midr_el1);
+    get_cpu_reg(mpidr_el1);
+    get_cpu_reg(revidr_el1);
+
+    printf("Remaining registers should fail\n");
+    should_fail = true;
+
+    /* Unexposed register access causes SIGILL */
+    get_cpu_reg(id_mmfr0_el1);
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
+    return should_fail_count == 1 ? 0 : 1;
+}
-- 
2.17.1
