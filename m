Received: from eggs.gnu.org ([2001:4830:134:3::10]:45859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX5-0007YP-4V
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX3-0004GH-Df
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:03 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5JX3-0004Br-66
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:01 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  2 May 2017 00:10:46 +0200
Message-Id: <20170501221046.9369-15-aurelien@aurel32.net>
In-Reply-To: <20170501221046.9369-1-aurelien@aurel32.net>
References: <20170501221046.9369-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 14/14] target/sh4: trap unaligned accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

SH4 requires that memory accesses are naturally aligned, except for the
SH4-A movua.l instructions which can do unaligned loads.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.c       |  1 +
 target/sh4/cpu.h       |  4 ++++
 target/sh4/op_helper.c | 19 +++++++++++++++++++
 target/sh4/translate.c |  6 ++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 9a481c35dc..9da7e1ed38 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -301,6 +301,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = superh_cpu_handle_mmu_fault;
 #else
+    cc->do_unaligned_access = superh_cpu_do_unaligned_access;
     cc->get_phys_page_debug = superh_cpu_get_phys_page_debug;
 #endif
     cc->disas_set_info = superh_cpu_disas_set_info;
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index faab3012f9..6c07c6b24b 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 
 #define TARGET_LONG_BITS 32
+#define ALIGNED_ONLY
 
 /* CPU Subtypes */
 #define SH_CPU_SH7750  (1 << 0)
@@ -215,6 +216,9 @@ void superh_cpu_dump_state(CPUState *cpu, FILE *f,
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int superh_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
+                                    MMUAccessType access_type,
+                                    int mmu_idx, uintptr_t retaddr);
 
 void sh4_translate_init(void);
 SuperHCPU *cpu_sh4_init(const char *cpu_model);
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 684d3f3758..4abd05667c 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -24,6 +24,25 @@
 
 #ifndef CONFIG_USER_ONLY
 
+void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                    MMUAccessType access_type,
+                                    int mmu_idx, uintptr_t retaddr)
+{
+    if (retaddr) {
+        cpu_restore_state(cs, retaddr);
+    }
+    switch (access_type) {
+    case MMU_INST_FETCH:
+    case MMU_DATA_LOAD:
+        cs->exception_index = 0x0e0;
+        break;
+    case MMU_DATA_STORE:
+        cs->exception_index = 0x100;
+        break;
+    }
+    cpu_loop_exit(cs);
+}
+
 void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
               int mmu_idx, uintptr_t retaddr)
 {
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bc70166602..fe3f73b7c0 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1505,14 +1505,16 @@ static void _decode_opc(DisasContext * ctx)
     case 0x40a9:                /* movua.l @Rm,R0 */
         /* Load non-boundary-aligned data */
         if (ctx->features & SH_FEATURE_SH4A) {
-            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
+                                MO_TEUL | MO_UNALN);
             return;
         }
         break;
     case 0x40e9:                /* movua.l @Rm+,R0 */
         /* Load non-boundary-aligned data */
         if (ctx->features & SH_FEATURE_SH4A) {
-            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
+                                MO_TEUL | MO_UNALN);
             tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
             return;
         }
-- 
2.11.0
