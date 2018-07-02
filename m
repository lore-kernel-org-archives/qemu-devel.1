Received: from eggs.gnu.org ([2001:4830:134:3::10]:48798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tt-0004B9-EF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tr-0007xH-7W
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:09 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:43777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0Tq-0007wo-Ui
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:07 -0400
Received: by mail-pf0-x235.google.com with SMTP id y8-v6so7653415pfm.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:06 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:09 +0900
Message-Id: <20180702151023.24532-12-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 11/25] target/openrisc: Merge tlb allocation
 into CPUOpenRISCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

There is no reason to allocate this separately.  This was probably
copied from target/mips which makes the same mistake.

While doing so, move tlb into the clear-on-reset range.  While not
all of the TLB bits are guaranteed zero on reset, all of the valid
bits are cleared, and the rest of the bits are unspecified.
Therefore clearing the whole of the TLB is correct.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.h              |  6 ++++--
 target/openrisc/interrupt.c        |  4 ++--
 target/openrisc/interrupt_helper.c |  8 +++----
 target/openrisc/machine.c          | 15 ++++++-------
 target/openrisc/mmu.c              | 34 ++++++++++++++----------------
 target/openrisc/sys_helper.c       | 28 ++++++++++++------------
 6 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index c871d6bfe1..96b7f58659 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -301,6 +301,10 @@ typedef struct CPUOpenRISCState {
 
     uint32_t dflag;           /* In delay slot (boolean) */
 
+#ifndef CONFIG_USER_ONLY
+    CPUOpenRISCTLBContext tlb;
+#endif
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
@@ -310,8 +314,6 @@ typedef struct CPUOpenRISCState {
     uint32_t cpucfgr;         /* CPU configure register */
 
 #ifndef CONFIG_USER_ONLY
-    CPUOpenRISCTLBContext * tlb;
-
     QEMUTimer *timer;
     uint32_t ttmr;          /* Timer tick mode register */
     int is_counting;
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 25351d5de3..2d0b55afa9 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -63,8 +63,8 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->sr &= ~SR_TEE;
     env->pmr &= ~PMR_DME;
     env->pmr &= ~PMR_SME;
-    env->tlb->cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
-    env->tlb->cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
+    env->tlb.cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
+    env->tlb.cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
     env->lock_addr = -1;
 
     if (exception > 0 && exception < EXCP_NR) {
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index b865738f8b..dc97b38704 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -36,18 +36,18 @@ void HELPER(rfe)(CPUOpenRISCState *env)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->env.sr & SR_DME) {
-        cpu->env.tlb->cpu_openrisc_map_address_data =
+        cpu->env.tlb.cpu_openrisc_map_address_data =
             &cpu_openrisc_get_phys_data;
     } else {
-        cpu->env.tlb->cpu_openrisc_map_address_data =
+        cpu->env.tlb.cpu_openrisc_map_address_data =
             &cpu_openrisc_get_phys_nommu;
     }
 
     if (cpu->env.sr & SR_IME) {
-        cpu->env.tlb->cpu_openrisc_map_address_code =
+        cpu->env.tlb.cpu_openrisc_map_address_code =
             &cpu_openrisc_get_phys_code;
     } else {
-        cpu->env.tlb->cpu_openrisc_map_address_code =
+        cpu->env.tlb.cpu_openrisc_map_address_code =
             &cpu_openrisc_get_phys_nommu;
     }
 
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 0a793eb14d..c10d28b055 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -30,18 +30,18 @@ static int env_post_load(void *opaque, int version_id)
 
     /* Restore MMU handlers */
     if (env->sr & SR_DME) {
-        env->tlb->cpu_openrisc_map_address_data =
+        env->tlb.cpu_openrisc_map_address_data =
             &cpu_openrisc_get_phys_data;
     } else {
-        env->tlb->cpu_openrisc_map_address_data =
+        env->tlb.cpu_openrisc_map_address_data =
             &cpu_openrisc_get_phys_nommu;
     }
 
     if (env->sr & SR_IME) {
-        env->tlb->cpu_openrisc_map_address_code =
+        env->tlb.cpu_openrisc_map_address_code =
             &cpu_openrisc_get_phys_code;
     } else {
-        env->tlb->cpu_openrisc_map_address_code =
+        env->tlb.cpu_openrisc_map_address_code =
             &cpu_openrisc_get_phys_nommu;
     }
 
@@ -77,10 +77,6 @@ static const VMStateDescription vmstate_cpu_tlb = {
     }
 };
 
-#define VMSTATE_CPU_TLB(_f, _s)                             \
-    VMSTATE_STRUCT_POINTER(_f, _s, vmstate_cpu_tlb, CPUOpenRISCTLBContext)
-
-
 static int get_sr(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
 {
     CPUOpenRISCState *env = opaque;
@@ -143,7 +139,8 @@ static const VMStateDescription vmstate_env = {
         VMSTATE_UINT32(fpcsr, CPUOpenRISCState),
         VMSTATE_UINT64(mac, CPUOpenRISCState),
 
-        VMSTATE_CPU_TLB(tlb, CPUOpenRISCState),
+        VMSTATE_STRUCT(tlb, CPUOpenRISCState, 1,
+                       vmstate_cpu_tlb, CPUOpenRISCTLBContext),
 
         VMSTATE_TIMER_PTR(timer, CPUOpenRISCState),
         VMSTATE_UINT32(ttmr, CPUOpenRISCState),
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 2bd782f89b..5665bb7cc9 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -46,19 +46,19 @@ int cpu_openrisc_get_phys_code(OpenRISCCPU *cpu,
     int idx = vpn & ITLB_MASK;
     int right = 0;
 
-    if ((cpu->env.tlb->itlb[0][idx].mr >> TARGET_PAGE_BITS) != vpn) {
+    if ((cpu->env.tlb.itlb[0][idx].mr >> TARGET_PAGE_BITS) != vpn) {
         return TLBRET_NOMATCH;
     }
-    if (!(cpu->env.tlb->itlb[0][idx].mr & 1)) {
+    if (!(cpu->env.tlb.itlb[0][idx].mr & 1)) {
         return TLBRET_INVALID;
     }
 
     if (cpu->env.sr & SR_SM) { /* supervisor mode */
-        if (cpu->env.tlb->itlb[0][idx].tr & SXE) {
+        if (cpu->env.tlb.itlb[0][idx].tr & SXE) {
             right |= PAGE_EXEC;
         }
     } else {
-        if (cpu->env.tlb->itlb[0][idx].tr & UXE) {
+        if (cpu->env.tlb.itlb[0][idx].tr & UXE) {
             right |= PAGE_EXEC;
         }
     }
@@ -67,7 +67,7 @@ int cpu_openrisc_get_phys_code(OpenRISCCPU *cpu,
         return TLBRET_BADADDR;
     }
 
-    *physical = (cpu->env.tlb->itlb[0][idx].tr & TARGET_PAGE_MASK) |
+    *physical = (cpu->env.tlb.itlb[0][idx].tr & TARGET_PAGE_MASK) |
                 (address & (TARGET_PAGE_SIZE-1));
     *prot = right;
     return TLBRET_MATCH;
@@ -81,25 +81,25 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
     int idx = vpn & DTLB_MASK;
     int right = 0;
 
-    if ((cpu->env.tlb->dtlb[0][idx].mr >> TARGET_PAGE_BITS) != vpn) {
+    if ((cpu->env.tlb.dtlb[0][idx].mr >> TARGET_PAGE_BITS) != vpn) {
         return TLBRET_NOMATCH;
     }
-    if (!(cpu->env.tlb->dtlb[0][idx].mr & 1)) {
+    if (!(cpu->env.tlb.dtlb[0][idx].mr & 1)) {
         return TLBRET_INVALID;
     }
 
     if (cpu->env.sr & SR_SM) { /* supervisor mode */
-        if (cpu->env.tlb->dtlb[0][idx].tr & SRE) {
+        if (cpu->env.tlb.dtlb[0][idx].tr & SRE) {
             right |= PAGE_READ;
         }
-        if (cpu->env.tlb->dtlb[0][idx].tr & SWE) {
+        if (cpu->env.tlb.dtlb[0][idx].tr & SWE) {
             right |= PAGE_WRITE;
         }
     } else {
-        if (cpu->env.tlb->dtlb[0][idx].tr & URE) {
+        if (cpu->env.tlb.dtlb[0][idx].tr & URE) {
             right |= PAGE_READ;
         }
-        if (cpu->env.tlb->dtlb[0][idx].tr & UWE) {
+        if (cpu->env.tlb.dtlb[0][idx].tr & UWE) {
             right |= PAGE_WRITE;
         }
     }
@@ -111,7 +111,7 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
         return TLBRET_BADADDR;
     }
 
-    *physical = (cpu->env.tlb->dtlb[0][idx].tr & TARGET_PAGE_MASK) |
+    *physical = (cpu->env.tlb.dtlb[0][idx].tr & TARGET_PAGE_MASK) |
                 (address & (TARGET_PAGE_SIZE-1));
     *prot = right;
     return TLBRET_MATCH;
@@ -126,10 +126,10 @@ static int cpu_openrisc_get_phys_addr(OpenRISCCPU *cpu,
 
     if (rw == MMU_INST_FETCH) {    /* ITLB */
        *physical = 0;
-        ret = cpu->env.tlb->cpu_openrisc_map_address_code(cpu, physical,
+        ret = cpu->env.tlb.cpu_openrisc_map_address_code(cpu, physical,
                                                           prot, address, rw);
     } else {          /* DTLB */
-        ret = cpu->env.tlb->cpu_openrisc_map_address_data(cpu, physical,
+        ret = cpu->env.tlb.cpu_openrisc_map_address_data(cpu, physical,
                                                           prot, address, rw);
     }
 
@@ -247,9 +247,7 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
 void cpu_openrisc_mmu_init(OpenRISCCPU *cpu)
 {
-    cpu->env.tlb = g_malloc0(sizeof(CPUOpenRISCTLBContext));
-
-    cpu->env.tlb->cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
-    cpu->env.tlb->cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
+    cpu->env.tlb.cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
+    cpu->env.tlb.cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
 }
 #endif
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 2c959f63f4..ff315f6f1a 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -61,18 +61,18 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         }
         cpu_set_sr(env, rb);
         if (env->sr & SR_DME) {
-            env->tlb->cpu_openrisc_map_address_data =
+            env->tlb.cpu_openrisc_map_address_data =
                 &cpu_openrisc_get_phys_data;
         } else {
-            env->tlb->cpu_openrisc_map_address_data =
+            env->tlb.cpu_openrisc_map_address_data =
                 &cpu_openrisc_get_phys_nommu;
         }
 
         if (env->sr & SR_IME) {
-            env->tlb->cpu_openrisc_map_address_code =
+            env->tlb.cpu_openrisc_map_address_code =
                 &cpu_openrisc_get_phys_code;
         } else {
-            env->tlb->cpu_openrisc_map_address_code =
+            env->tlb.cpu_openrisc_map_address_code =
                 &cpu_openrisc_get_phys_nommu;
         }
         break;
@@ -101,14 +101,14 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         if (!(rb & 1)) {
-            tlb_flush_page(cs, env->tlb->dtlb[0][idx].mr & TARGET_PAGE_MASK);
+            tlb_flush_page(cs, env->tlb.dtlb[0][idx].mr & TARGET_PAGE_MASK);
         }
-        env->tlb->dtlb[0][idx].mr = rb;
+        env->tlb.dtlb[0][idx].mr = rb;
         break;
 
     case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
         idx = spr - TO_SPR(1, 640);
-        env->tlb->dtlb[0][idx].tr = rb;
+        env->tlb.dtlb[0][idx].tr = rb;
         break;
     case TO_SPR(1, 768) ... TO_SPR(1, 895):   /* DTLBW1MR 0-127 */
     case TO_SPR(1, 896) ... TO_SPR(1, 1023):  /* DTLBW1TR 0-127 */
@@ -120,14 +120,14 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1):   /* ITLBW0MR 0-127 */
         idx = spr - TO_SPR(2, 512);
         if (!(rb & 1)) {
-            tlb_flush_page(cs, env->tlb->itlb[0][idx].mr & TARGET_PAGE_MASK);
+            tlb_flush_page(cs, env->tlb.itlb[0][idx].mr & TARGET_PAGE_MASK);
         }
-        env->tlb->itlb[0][idx].mr = rb;
+        env->tlb.itlb[0][idx].mr = rb;
         break;
 
     case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
         idx = spr - TO_SPR(2, 640);
-        env->tlb->itlb[0][idx].tr = rb;
+        env->tlb.itlb[0][idx].tr = rb;
         break;
     case TO_SPR(2, 768) ... TO_SPR(2, 895):   /* ITLBW1MR 0-127 */
     case TO_SPR(2, 896) ... TO_SPR(2, 1023):  /* ITLBW1TR 0-127 */
@@ -259,11 +259,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
-        return env->tlb->dtlb[0][idx].mr;
+        return env->tlb.dtlb[0][idx].mr;
 
     case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
         idx = spr - TO_SPR(1, 640);
-        return env->tlb->dtlb[0][idx].tr;
+        return env->tlb.dtlb[0][idx].tr;
 
     case TO_SPR(1, 768) ... TO_SPR(1, 895):   /* DTLBW1MR 0-127 */
     case TO_SPR(1, 896) ... TO_SPR(1, 1023):  /* DTLBW1TR 0-127 */
@@ -275,11 +275,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 
     case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1): /* ITLBW0MR 0-127 */
         idx = spr - TO_SPR(2, 512);
-        return env->tlb->itlb[0][idx].mr;
+        return env->tlb.itlb[0][idx].mr;
 
     case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
         idx = spr - TO_SPR(2, 640);
-        return env->tlb->itlb[0][idx].tr;
+        return env->tlb.itlb[0][idx].tr;
 
     case TO_SPR(2, 768) ... TO_SPR(2, 895):   /* ITLBW1MR 0-127 */
     case TO_SPR(2, 896) ... TO_SPR(2, 1023):  /* ITLBW1TR 0-127 */
-- 
2.17.0
