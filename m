Received: from eggs.gnu.org ([2001:4830:134:3::10]:40035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDz-00057j-8e
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDx-00086n-Us
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:59 -0400
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:33655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDx-000852-Lj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:57 -0400
Received: by mail-pl0-x234.google.com with SMTP id 6-v6so2017963plb.0
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:24 -0700
Message-Id: <20180628030330.15615-18-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 17/23] target/openrisc: Use identical sizes
 for ITLB and DTLB
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

The sizes are already the same, however, we can improve things
if they are identical by design.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h        | 10 ++++------
 target/openrisc/machine.c    |  4 ++--
 target/openrisc/mmu.c        |  4 ++--
 target/openrisc/sys_helper.c | 16 ++++++++--------
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index c3a968ec4d..47e94659e1 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -222,10 +222,8 @@ enum {
 
 /* TLB size */
 enum {
-    DTLB_SIZE = 64,
-    DTLB_MASK = (DTLB_SIZE-1),
-    ITLB_SIZE = 64,
-    ITLB_MASK = (ITLB_SIZE-1),
+    TLB_SIZE = 64,
+    TLB_MASK = TLB_SIZE - 1,
 };
 
 /* TLB prot */
@@ -254,8 +252,8 @@ typedef struct OpenRISCTLBEntry {
 
 #ifndef CONFIG_USER_ONLY
 typedef struct CPUOpenRISCTLBContext {
-    OpenRISCTLBEntry itlb[ITLB_SIZE];
-    OpenRISCTLBEntry dtlb[DTLB_SIZE];
+    OpenRISCTLBEntry itlb[TLB_SIZE];
+    OpenRISCTLBEntry dtlb[TLB_SIZE];
 
     int (*cpu_openrisc_map_address_code)(struct OpenRISCCPU *cpu,
                                          hwaddr *physical,
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index b795b56dc6..3fc837b925 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -42,9 +42,9 @@ static const VMStateDescription vmstate_cpu_tlb = {
     .minimum_version_id = 1,
     .minimum_version_id_old = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_STRUCT_ARRAY(itlb, CPUOpenRISCTLBContext, ITLB_SIZE, 0,
+        VMSTATE_STRUCT_ARRAY(itlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
                              vmstate_tlb_entry, OpenRISCTLBEntry),
-        VMSTATE_STRUCT_ARRAY(dtlb, CPUOpenRISCTLBContext, DTLB_SIZE, 0,
+        VMSTATE_STRUCT_ARRAY(dtlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
                              vmstate_tlb_entry, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index b293b64e98..a4613e9ae4 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -41,7 +41,7 @@ static int get_phys_code(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
                          target_ulong address, int rw, bool supervisor)
 {
     int vpn = address >> TARGET_PAGE_BITS;
-    int idx = vpn & ITLB_MASK;
+    int idx = vpn & TLB_MASK;
     int right = 0;
     uint32_t mr = cpu->env.tlb.itlb[idx].mr;
     uint32_t tr = cpu->env.tlb.itlb[idx].tr;
@@ -74,7 +74,7 @@ static int get_phys_data(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
                          target_ulong address, int rw, bool supervisor)
 {
     int vpn = address >> TARGET_PAGE_BITS;
-    int idx = vpn & DTLB_MASK;
+    int idx = vpn & TLB_MASK;
     int right = 0;
     uint32_t mr = cpu->env.tlb.dtlb[idx].mr;
     uint32_t tr = cpu->env.tlb.dtlb[idx].tr;
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 852b219f9b..541615bfb3 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -80,7 +80,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         env->shadow_gpr[idx / 32][idx % 32] = rb;
         break;
 
-    case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
+    case TO_SPR(1, 512) ... TO_SPR(1, 512 + TLB_SIZE - 1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         mr = env->tlb.dtlb[idx].mr;
         if (mr & 1) {
@@ -91,7 +91,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         }
         env->tlb.dtlb[idx].mr = rb;
         break;
-    case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
+    case TO_SPR(1, 640) ... TO_SPR(1, 640 + TLB_SIZE - 1): /* DTLBW0TR 0-127 */
         idx = spr - TO_SPR(1, 640);
         env->tlb.dtlb[idx].tr = rb;
         break;
@@ -103,7 +103,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     case TO_SPR(1, 1408) ... TO_SPR(1, 1535): /* DTLBW3TR 0-127 */
         break;
 
-    case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1):   /* ITLBW0MR 0-127 */
+    case TO_SPR(2, 512) ... TO_SPR(2, 512 + TLB_SIZE - 1): /* ITLBW0MR 0-127 */
         idx = spr - TO_SPR(2, 512);
         mr = env->tlb.itlb[idx].mr;
         if (mr & 1) {
@@ -114,7 +114,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         }
         env->tlb.itlb[idx].mr = rb;
         break;
-    case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
+    case TO_SPR(2, 640) ... TO_SPR(2, 640 + TLB_SIZE - 1): /* ITLBW0TR 0-127 */
         idx = spr - TO_SPR(2, 640);
         env->tlb.itlb[idx].tr = rb;
         break;
@@ -247,11 +247,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
         idx = (spr - 1024);
         return env->shadow_gpr[idx / 32][idx % 32];
 
-    case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
+    case TO_SPR(1, 512) ... TO_SPR(1, 512 + TLB_SIZE - 1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         return env->tlb.dtlb[idx].mr;
 
-    case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
+    case TO_SPR(1, 640) ... TO_SPR(1, 640 + TLB_SIZE - 1): /* DTLBW0TR 0-127 */
         idx = spr - TO_SPR(1, 640);
         return env->tlb.dtlb[idx].tr;
 
@@ -263,11 +263,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
     case TO_SPR(1, 1408) ... TO_SPR(1, 1535): /* DTLBW3TR 0-127 */
         break;
 
-    case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1): /* ITLBW0MR 0-127 */
+    case TO_SPR(2, 512) ... TO_SPR(2, 512 + TLB_SIZE - 1): /* ITLBW0MR 0-127 */
         idx = spr - TO_SPR(2, 512);
         return env->tlb.itlb[idx].mr;
 
-    case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
+    case TO_SPR(2, 640) ... TO_SPR(2, 640 + TLB_SIZE - 1): /* ITLBW0TR 0-127 */
         idx = spr - TO_SPR(2, 640);
         return env->tlb.itlb[idx].tr;
 
-- 
2.17.1
