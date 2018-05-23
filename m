Received: from eggs.gnu.org ([2001:4830:134:3::10]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTb-0000BP-9c
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTZ-00017a-H9
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:59 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTZ-00016u-6O
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:57 -0400
Received: by mail-pl0-x244.google.com with SMTP id ay10-v6so11876625plb.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:57 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:06 +1200
Message-Id: <1527034517-7851-20-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 19/30] RISC-V: Allow interrupt controllers
 to claim interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>

We can't allow the supervisor to control SEIP as this would allow the
supervisor to clear a pending external interrupt which will result in
lost a interrupt in the case a PLIC is attached. The SEIP bit must be
hardware controlled when a PLIC is attached.

This logic was previously hard-coded so SEIP was always masked even
if no PLIC was attached. This patch adds riscv_cpu_claim_interrupts
so that the PLIC can register control of SEIP. In the case of models
without a PLIC (spike), the SEIP bit remains software controlled.

This interface allows for hardware control of supervisor timer and
software interrupts by other interrupt controller models.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_plic.c    | 13 +++++++++++++
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 11 +++++++++++
 target/riscv/csr.c        | 12 ++++--------
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index dc6f4924e282..28e28d932f7c 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
+#include "sysemu/sysemu.h"
 #include "hw/riscv/sifive_plic.h"
 
 #define RISCV_DEBUG_PLIC 0
@@ -447,6 +448,18 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
     for (i = 0; i <= plic->num_sources; i++) {
         plic->irqs[i] = qemu_allocate_irq(sifive_plic_irq_request, plic, i);
     }
+
+    /* We can't allow the supervisor to control SEIP as this would allow the
+     * supervisor to clear a pending external interrupt which will result in
+     * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
+     * hardware controlled when a PLIC is attached. */
+    for (i = 0; i < smp_cpus; i++) {
+        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(i));
+        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
+            error_report("sifive_plic_realize: SEIP already claimed");
+            exit(1);
+        }
+    }
 }
 
 static void sifive_plic_class_init(ObjectClass *klass, void *data)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d6bb3136db18..ae0e3f6a544d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -138,6 +138,7 @@ struct CPURISCVState {
      * mip is 32-bits to allow atomic_read on 32-bit hosts.
      */
     uint32_t mip;
+    uint32_t miclaim;
 
     target_ulong mie;
     target_ulong mideleg;
@@ -262,6 +263,7 @@ void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b4bbf7a9fa0a..7c9f6c46c75a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -72,6 +72,17 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #if !defined(CONFIG_USER_ONLY)
 
+int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
+{
+    CPURISCVState *env = &cpu->env;
+    if (env->miclaim & interrupts) {
+        return -1;
+    } else {
+        env->miclaim |= interrupts;
+        return 0;
+    }
+}
+
 /* iothread_mutex must be held */
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
 {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 45e33d876034..9bbe81a110a5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -502,15 +502,11 @@ static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
     RISCVCPU *cpu = riscv_env_get_cpu(env);
-    target_ulong mask = write_mask & delegable_ints;
-    uint32_t old_mip;
 
-    /* We can't allow the supervisor to control SEIP as this would allow the
-     * supervisor to clear a pending external interrupt which will result in
-     * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
-     * hardware controlled when a PLIC is attached. This should be an option
-     * for CPUs with software-delegated Supervisor External Interrupts. */
-    mask &= ~MIP_SEIP;
+    /* Allow software control of delegable interrupts not claimed by hardware */
+    target_ulong mask = write_mask & delegable_ints & ~env->miclaim;
+
+    uint32_t old_mip;
 
     if (mask) {
         qemu_mutex_lock_iothread();
-- 
2.7.0
