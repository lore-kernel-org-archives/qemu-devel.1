Received: from eggs.gnu.org ([2001:4830:134:3::10]:48916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0U7-0004Np-Gn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0U6-0008CR-5n
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:23 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:43654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0U5-0008Bi-Tx
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:22 -0400
Received: by mail-pg0-x229.google.com with SMTP id v13-v6so1650433pgr.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:21 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:15 +0900
Message-Id: <20180702151023.24532-18-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 17/25] target/openrisc: Use identical sizes
 for ITLB and DTLB
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

The sizes are already the same, however, we can improve things
if they are identical by design.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
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
2.17.0
