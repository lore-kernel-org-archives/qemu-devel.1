Received: from eggs.gnu.org ([2001:4830:134:3::10]:57375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5W-0003VL-EV
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5T-0004o6-P9
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:14 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5T-0004n7-Gw
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:11 -0400
Received: by mail-pf0-x241.google.com with SMTP id h12-v6so8601783pfk.11
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:35 -1000
Message-Id: <20180618184046.6270-12-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/22] target/openrisc: Reduce tlb to a
 single dimension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

While we had defines for *_WAYS, we didn't define more than 1.
Reduce the complexity by eliminating this unused dimension.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h        |  6 ++----
 target/openrisc/machine.c    |  6 ++----
 target/openrisc/mmu.c        | 30 ++++++++++++++++--------------
 target/openrisc/sys_helper.c | 20 ++++++++++----------
 4 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 13107058cb..947ca00d8d 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -222,10 +222,8 @@ enum {
 
 /* TLB size */
 enum {
-    DTLB_WAYS = 1,
     DTLB_SIZE = 64,
     DTLB_MASK = (DTLB_SIZE-1),
-    ITLB_WAYS = 1,
     ITLB_SIZE = 64,
     ITLB_MASK = (ITLB_SIZE-1),
 };
@@ -256,8 +254,8 @@ typedef struct OpenRISCTLBEntry {
 
 #ifndef CONFIG_USER_ONLY
 typedef struct CPUOpenRISCTLBContext {
-    OpenRISCTLBEntry itlb[ITLB_WAYS][ITLB_SIZE];
-    OpenRISCTLBEntry dtlb[DTLB_WAYS][DTLB_SIZE];
+    OpenRISCTLBEntry itlb[ITLB_SIZE];
+    OpenRISCTLBEntry dtlb[DTLB_SIZE];
 
     int (*cpu_openrisc_map_address_code)(struct OpenRISCCPU *cpu,
                                          hwaddr *physical,
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 73e0abcfd7..b795b56dc6 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -42,11 +42,9 @@ static const VMStateDescription vmstate_cpu_tlb = {
     .minimum_version_id = 1,
     .minimum_version_id_old = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_STRUCT_2DARRAY(itlb, CPUOpenRISCTLBContext,
-                             ITLB_WAYS, ITLB_SIZE, 0,
+        VMSTATE_STRUCT_ARRAY(itlb, CPUOpenRISCTLBContext, ITLB_SIZE, 0,
                              vmstate_tlb_entry, OpenRISCTLBEntry),
-        VMSTATE_STRUCT_2DARRAY(dtlb, CPUOpenRISCTLBContext,
-                             DTLB_WAYS, DTLB_SIZE, 0,
+        VMSTATE_STRUCT_ARRAY(dtlb, CPUOpenRISCTLBContext, DTLB_SIZE, 0,
                              vmstate_tlb_entry, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 9b4b5cf04f..856969a7f2 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -43,19 +43,21 @@ static int get_phys_code(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
     int vpn = address >> TARGET_PAGE_BITS;
     int idx = vpn & ITLB_MASK;
     int right = 0;
+    uint32_t mr = cpu->env.tlb.itlb[idx].mr;
+    uint32_t tr = cpu->env.tlb.itlb[idx].tr;
 
-    if ((cpu->env.tlb.itlb[0][idx].mr >> TARGET_PAGE_BITS) != vpn) {
+    if ((mr >> TARGET_PAGE_BITS) != vpn) {
         return TLBRET_NOMATCH;
     }
-    if (!(cpu->env.tlb.itlb[0][idx].mr & 1)) {
+    if (!(mr & 1)) {
         return TLBRET_INVALID;
     }
     if (supervisor) {
-        if (cpu->env.tlb.itlb[0][idx].tr & SXE) {
+        if (tr & SXE) {
             right |= PAGE_EXEC;
         }
     } else {
-        if (cpu->env.tlb.itlb[0][idx].tr & UXE) {
+        if (tr & UXE) {
             right |= PAGE_EXEC;
         }
     }
@@ -63,8 +65,7 @@ static int get_phys_code(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
         return TLBRET_BADADDR;
     }
 
-    *physical = (cpu->env.tlb.itlb[0][idx].tr & TARGET_PAGE_MASK) |
-                (address & (TARGET_PAGE_SIZE-1));
+    *physical = (tr & TARGET_PAGE_MASK) | (address & ~TARGET_PAGE_MASK);
     *prot = right;
     return TLBRET_MATCH;
 }
@@ -75,25 +76,27 @@ static int get_phys_data(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
     int vpn = address >> TARGET_PAGE_BITS;
     int idx = vpn & DTLB_MASK;
     int right = 0;
+    uint32_t mr = cpu->env.tlb.dtlb[idx].mr;
+    uint32_t tr = cpu->env.tlb.dtlb[idx].tr;
 
-    if ((cpu->env.tlb.dtlb[0][idx].mr >> TARGET_PAGE_BITS) != vpn) {
+    if ((mr >> TARGET_PAGE_BITS) != vpn) {
         return TLBRET_NOMATCH;
     }
-    if (!(cpu->env.tlb.dtlb[0][idx].mr & 1)) {
+    if (!(mr & 1)) {
         return TLBRET_INVALID;
     }
     if (supervisor) {
-        if (cpu->env.tlb.dtlb[0][idx].tr & SRE) {
+        if (tr & SRE) {
             right |= PAGE_READ;
         }
-        if (cpu->env.tlb.dtlb[0][idx].tr & SWE) {
+        if (tr & SWE) {
             right |= PAGE_WRITE;
         }
     } else {
-        if (cpu->env.tlb.dtlb[0][idx].tr & URE) {
+        if (tr & URE) {
             right |= PAGE_READ;
         }
-        if (cpu->env.tlb.dtlb[0][idx].tr & UWE) {
+        if (tr & UWE) {
             right |= PAGE_WRITE;
         }
     }
@@ -105,8 +108,7 @@ static int get_phys_data(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
         return TLBRET_BADADDR;
     }
 
-    *physical = (cpu->env.tlb.dtlb[0][idx].tr & TARGET_PAGE_MASK) |
-                (address & (TARGET_PAGE_SIZE-1));
+    *physical = (tr & TARGET_PAGE_MASK) | (address & ~TARGET_PAGE_MASK);
     *prot = right;
     return TLBRET_MATCH;
 }
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index a1285894ad..8ad7a7d898 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -85,14 +85,14 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         if (!(rb & 1)) {
-            tlb_flush_page(cs, env->tlb.dtlb[0][idx].mr & TARGET_PAGE_MASK);
+            tlb_flush_page(cs, env->tlb.dtlb[idx].mr & TARGET_PAGE_MASK);
         }
-        env->tlb.dtlb[0][idx].mr = rb;
+        env->tlb.dtlb[idx].mr = rb;
         break;
 
     case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
         idx = spr - TO_SPR(1, 640);
-        env->tlb.dtlb[0][idx].tr = rb;
+        env->tlb.dtlb[idx].tr = rb;
         break;
     case TO_SPR(1, 768) ... TO_SPR(1, 895):   /* DTLBW1MR 0-127 */
     case TO_SPR(1, 896) ... TO_SPR(1, 1023):  /* DTLBW1TR 0-127 */
@@ -104,14 +104,14 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1):   /* ITLBW0MR 0-127 */
         idx = spr - TO_SPR(2, 512);
         if (!(rb & 1)) {
-            tlb_flush_page(cs, env->tlb.itlb[0][idx].mr & TARGET_PAGE_MASK);
+            tlb_flush_page(cs, env->tlb.itlb[idx].mr & TARGET_PAGE_MASK);
         }
-        env->tlb.itlb[0][idx].mr = rb;
+        env->tlb.itlb[idx].mr = rb;
         break;
 
     case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
         idx = spr - TO_SPR(2, 640);
-        env->tlb.itlb[0][idx].tr = rb;
+        env->tlb.itlb[idx].tr = rb;
         break;
     case TO_SPR(2, 768) ... TO_SPR(2, 895):   /* ITLBW1MR 0-127 */
     case TO_SPR(2, 896) ... TO_SPR(2, 1023):  /* ITLBW1TR 0-127 */
@@ -243,11 +243,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
-        return env->tlb.dtlb[0][idx].mr;
+        return env->tlb.dtlb[idx].mr;
 
     case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
         idx = spr - TO_SPR(1, 640);
-        return env->tlb.dtlb[0][idx].tr;
+        return env->tlb.dtlb[idx].tr;
 
     case TO_SPR(1, 768) ... TO_SPR(1, 895):   /* DTLBW1MR 0-127 */
     case TO_SPR(1, 896) ... TO_SPR(1, 1023):  /* DTLBW1TR 0-127 */
@@ -259,11 +259,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 
     case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1): /* ITLBW0MR 0-127 */
         idx = spr - TO_SPR(2, 512);
-        return env->tlb.itlb[0][idx].mr;
+        return env->tlb.itlb[idx].mr;
 
     case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
         idx = spr - TO_SPR(2, 640);
-        return env->tlb.itlb[0][idx].tr;
+        return env->tlb.itlb[idx].tr;
 
     case TO_SPR(2, 768) ... TO_SPR(2, 895):   /* ITLBW1MR 0-127 */
     case TO_SPR(2, 896) ... TO_SPR(2, 1023):  /* ITLBW1TR 0-127 */
-- 
2.17.1
