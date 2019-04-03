Received: from eggs.gnu.org ([209.51.188.92]:48886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpb-0003J6-W6
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpa-0000U3-VM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:55 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpa-0000TF-MM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:54 -0400
Received: by mail-pl1-x641.google.com with SMTP id g37so7315057plb.5
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:54 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:57 +0700
Message-Id: <20190403034358.21999-26-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 25/26] tcg: Remove CPUClass::handle_mmu_fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This hook is now completely replaced by tlb_fill.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h     |  3 ---
 accel/tcg/user-exec.c | 13 +++----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 7e96a0aed3..8afcf0c427 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -118,7 +118,6 @@ struct TranslationBlock;
  *       This always includes at least the program counter; some targets
  *       will need to do more. If this hook is not implemented then the
  *       default is to call @set_pc(tb->pc).
- * @handle_mmu_fault: Callback for handling an MMU fault.
  * @tlb_fill: Callback for handling a softmmu tlb miss or user-only
  *       address fault.  For system mode, if the access is valid, call
  *       tlb_set_page and return true; if the access is invalid, and
@@ -198,8 +197,6 @@ typedef struct CPUClass {
                                Error **errp);
     void (*set_pc)(CPUState *cpu, vaddr value);
     void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *tb);
-    int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int size, int rw,
-                            int mmu_index);
     bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f13c0b2b67..d79bed0266 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -63,7 +63,6 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
 {
     CPUState *cpu = current_cpu;
     CPUClass *cc;
-    int ret;
     unsigned long address = (unsigned long)info->si_addr;
     MMUAccessType access_type;
 
@@ -162,15 +161,9 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     helper_retaddr = 0;
 
     cc = CPU_GET_CLASS(cpu);
-    if (cc->tlb_fill) {
-        access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
-        cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
-        g_assert_not_reached();
-    } else {
-        ret = cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER_IDX);
-        g_assert(ret > 0);
-        cpu_loop_exit_restore(cpu, pc);
-    }
+    access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
+    g_assert_not_reached();
 }
 
 #if defined(__i386__)
-- 
2.17.1
