Received: from eggs.gnu.org ([2001:4830:134:3::10]:47572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY64-0001af-ED
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY63-0002Is-Fk
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:00 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY63-00020Y-7l
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:59 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5s-0006ht-8X
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:48 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:01 +0100
Message-Id: <20181019165735.22511-12-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/45] target/arm: Improve debug logging of
 AArch32 exception return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For AArch32, exception return happens through certain kinds
of CPSR write. We don't currently have any CPU_LOG_INT logging
of these events (unlike AArch64, where we log in the ERET
instruction). Add some suitable logging.

This will log exception returns like this:
Exception return from AArch32 hyp to usr PC 0x80100374

paralleling the existing logging in the exception_return
helper for AArch64 exception returns:
Exception return from AArch64 EL2 to AArch64 EL0 PC 0x8003045c
Exception return from AArch64 EL2 to AArch32 EL0 PC 0x8003045c

(Note that an AArch32 exception return can only be
AArch32->AArch32, never to AArch64.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181012144235.19646-2-peter.maydell@linaro.org
---
 target/arm/internals.h | 18 ++++++++++++++++++
 target/arm/helper.c    | 10 ++++++++++
 target/arm/translate.c |  7 +------
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a4fc709bcc7..276f2d8a8df 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -840,4 +840,22 @@ static inline uint32_t v7m_sp_limit(CPUARMState *env)
     }
 }
 
+/**
+ * aarch32_mode_name(): Return name of the AArch32 CPU mode
+ * @psr: Program Status Register indicating CPU mode
+ *
+ * Returns, for debug logging purposes, a printable representation
+ * of the AArch32 CPU mode ("svc", "usr", etc) as indicated by
+ * the low bits of the specified PSR.
+ */
+static inline const char *aarch32_mode_name(uint32_t psr)
+{
+    static const char cpu_mode_names[16][4] = {
+        "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
+        "???", "???", "hyp", "und", "???", "???", "???", "sys"
+    };
+
+    return cpu_mode_names[psr & 0xf];
+}
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9a0e92f286c..09c31c47418 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6208,7 +6208,17 @@ void cpsr_write(CPUARMState *env, uint32_t val, uint32_t mask,
                 mask |= CPSR_IL;
                 val |= CPSR_IL;
             }
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Illegal AArch32 mode switch attempt from %s to %s\n",
+                          aarch32_mode_name(env->uncached_cpsr),
+                          aarch32_mode_name(val));
         } else {
+            qemu_log_mask(CPU_LOG_INT, "%s %s to %s PC 0x%" PRIx32 "\n",
+                          write_type == CPSRWriteExceptionReturn ?
+                          "Exception return from AArch32" :
+                          "AArch32 mode switch from",
+                          aarch32_mode_name(env->uncached_cpsr),
+                          aarch32_mode_name(val), env->regs[15]);
             switch_mode(env, val & CPSR_M);
         }
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 42dec1f7358..46c4b86bf52 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -13090,11 +13090,6 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
     translator_loop(ops, &dc.base, cpu, tb);
 }
 
-static const char *cpu_mode_names[16] = {
-  "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
-  "???", "???", "hyp", "und", "???", "???", "???", "sys"
-};
-
 void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                         int flags)
 {
@@ -13160,7 +13155,7 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                     psr & CPSR_V ? 'V' : '-',
                     psr & CPSR_T ? 'T' : 'A',
                     ns_status,
-                    cpu_mode_names[psr & 0xf], (psr & 0x10) ? 32 : 26);
+                    aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
     }
 
     if (flags & CPU_DUMP_FPU) {
-- 
2.19.1
