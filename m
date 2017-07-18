Received: from eggs.gnu.org ([2001:4830:134:3::10]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7U-0003zV-2U
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7R-0005LV-BL
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:52 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:55325)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7Q-0005Kk-VS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:49 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:57 +0100
Message-ID: <dfa531e1144393813a515e73748321a08e06356c.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 12/14] target/mips: Implement segmentation
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

Implement the optional segmentation control feature in the virtual to
physical address translation code.

The fixed legacy segment and xkphys handling is replaced with a dynamic
layout based on the segmentation control registers (which should be set
up even when the feature is not exposed to the guest).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
Changes in v2:
- Use hwaddr instead of target_ulong for physical addresses in
  get_seg[ctl]_physical_address() (Yongbok).
- Fix xkphys privilege control based on access mode (am) (Yongbok).
- Fix xkphys TLB faults to use XTLB.
---
 target/mips/helper.c | 177 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 142 insertions(+), 35 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index f78d151d2583..5cb3aa0d5395 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -107,15 +107,107 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
     return TLBRET_NOMATCH;
 }
 
+static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
+{
+    /*
+     * Interpret access control mode and mmu_idx.
+     *           AdE?     TLB?
+     *      AM  K S U E  K S U E
+     * UK    0  0 1 1 0  0 - - 0
+     * MK    1  0 1 1 0  1 - - !eu
+     * MSK   2  0 0 1 0  1 1 - !eu
+     * MUSK  3  0 0 0 0  1 1 1 !eu
+     * MUSUK 4  0 0 0 0  0 1 1 0
+     * USK   5  0 0 1 0  0 0 - 0
+     * -     6  - - - -  - - - -
+     * UUSK  7  0 0 0 0  0 0 0 0
+     */
+    int32_t adetlb_mask;
+
+    switch (mmu_idx) {
+    case 3 /* ERL */:
+        /* If EU is set, always unmapped */
+        if (eu) {
+            return 0;
+        }
+        /* fall through */
+    case MIPS_HFLAG_KM:
+        /* Never AdE, TLB mapped if AM={1,2,3} */
+        adetlb_mask = 0x70000000;
+        goto check_tlb;
+
+    case MIPS_HFLAG_SM:
+        /* AdE if AM={0,1}, TLB mapped if AM={2,3,4} */
+        adetlb_mask = 0xc0380000;
+        goto check_ade;
+
+    case MIPS_HFLAG_UM:
+        /* AdE if AM={0,1,2,5}, TLB mapped if AM={3,4} */
+        adetlb_mask = 0xe4180000;
+        /* fall through */
+    check_ade:
+        /* does this AM cause AdE in current execution mode */
+        if ((adetlb_mask << am) < 0) {
+            return TLBRET_BADADDR;
+        }
+        adetlb_mask <<= 8;
+        /* fall through */
+    check_tlb:
+        /* is this AM mapped in current execution mode */
+        return ((adetlb_mask << am) < 0);
+    default:
+        assert(0);
+        return TLBRET_BADADDR;
+    };
+}
+
+static int get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
+                                    int *prot, target_ulong real_address,
+                                    int rw, int access_type, int mmu_idx,
+                                    unsigned int am, bool eu,
+                                    target_ulong segmask,
+                                    hwaddr physical_base)
+{
+    int mapped = is_seg_am_mapped(am, eu, mmu_idx);
+
+    if (mapped < 0) {
+        /* is_seg_am_mapped can report TLBRET_BADADDR */
+        return mapped;
+    } else if (mapped) {
+        /* The segment is TLB mapped */
+        return env->tlb->map_address(env, physical, prot, real_address, rw,
+                                     access_type);
+    } else {
+        /* The segment is unmapped */
+        *physical = physical_base | (real_address & segmask);
+        *prot = PAGE_READ | PAGE_WRITE;
+        return TLBRET_MATCH;
+    }
+}
+
+static int get_segctl_physical_address(CPUMIPSState *env, hwaddr *physical,
+                                       int *prot, target_ulong real_address,
+                                       int rw, int access_type, int mmu_idx,
+                                       uint16_t segctl, target_ulong segmask)
+{
+    unsigned int am = (segctl & CP0SC_AM_MASK) >> CP0SC_AM;
+    bool eu = (segctl >> CP0SC_EU) & 1;
+    hwaddr pa = ((hwaddr)segctl & CP0SC_PA_MASK) << 20;
+
+    return get_seg_physical_address(env, physical, prot, real_address, rw,
+                                    access_type, mmu_idx, am, eu, segmask,
+                                    pa & ~(hwaddr)segmask);
+}
+
 static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
                                 int *prot, target_ulong real_address,
                                 int rw, int access_type, int mmu_idx)
 {
     /* User mode can only access useg/xuseg */
+#if defined(TARGET_MIPS64)
     int user_mode = mmu_idx == MIPS_HFLAG_UM;
     int supervisor_mode = mmu_idx == MIPS_HFLAG_SM;
     int kernel_mode = !user_mode && !supervisor_mode;
-#if defined(TARGET_MIPS64)
     int UX = (env->CP0_Status & (1 << CP0St_UX)) != 0;
     int SX = (env->CP0_Status & (1 << CP0St_SX)) != 0;
     int KX = (env->CP0_Status & (1 << CP0St_KX)) != 0;
@@ -148,12 +240,16 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
 
     if (address <= USEG_LIMIT) {
         /* useg */
-        if (env->CP0_Status & (1 << CP0St_ERL)) {
-            *physical = address & 0xFFFFFFFF;
-            *prot = PAGE_READ | PAGE_WRITE;
+        uint16_t segctl;
+
+        if (address >= 0x40000000UL) {
+            segctl = env->CP0_SegCtl2;
         } else {
-            ret = env->tlb->map_address(env, physical, prot, real_address, rw, access_type);
+            segctl = env->CP0_SegCtl2 >> 16;
         }
+        ret = get_segctl_physical_address(env, physical, prot, real_address, rw,
+                                          access_type, mmu_idx, segctl,
+                                          0x3FFFFFFF);
 #if defined(TARGET_MIPS64)
     } else if (address < 0x4000000000000000ULL) {
         /* xuseg */
@@ -172,10 +268,33 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
         }
     } else if (address < 0xC000000000000000ULL) {
         /* xkphys */
-        if (kernel_mode && KX &&
-            (address & 0x07FFFFFFFFFFFFFFULL) <= env->PAMask) {
-            *physical = address & env->PAMask;
-            *prot = PAGE_READ | PAGE_WRITE;
+        if ((address & 0x07FFFFFFFFFFFFFFULL) <= env->PAMask) {
+            /* KX/SX/UX bit to check for each xkphys EVA access mode */
+            static const uint8_t am_ksux[8] = {
+                [CP0SC_AM_UK]    = (1u << CP0St_KX),
+                [CP0SC_AM_MK]    = (1u << CP0St_KX),
+                [CP0SC_AM_MSK]   = (1u << CP0St_SX),
+                [CP0SC_AM_MUSK]  = (1u << CP0St_UX),
+                [CP0SC_AM_MUSUK] = (1u << CP0St_UX),
+                [CP0SC_AM_USK]   = (1u << CP0St_SX),
+                [6]              = (1u << CP0St_KX),
+                [CP0SC_AM_UUSK]  = (1u << CP0St_UX),
+            };
+            unsigned int am = CP0SC_AM_UK;
+            unsigned int xr = (env->CP0_SegCtl2 & CP0SC2_XR_MASK) >> CP0SC2_XR;
+
+            if (xr & (1 << ((address >> 59) & 0x7))) {
+                am = (env->CP0_SegCtl1 & CP0SC1_XAM_MASK) >> CP0SC1_XAM;
+            }
+            /* Does CP0_Status.KX/SX/UX permit the access mode (am) */
+            if (env->CP0_Status & am_ksux[am]) {
+                ret = get_seg_physical_address(env, physical, prot,
+                                               real_address, rw, access_type,
+                                               mmu_idx, am, false, env->PAMask,
+                                               0);
+            } else {
+                ret = TLBRET_BADADDR;
+            }
         } else {
             ret = TLBRET_BADADDR;
         }
@@ -190,35 +309,25 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
 #endif
     } else if (address < (int32_t)KSEG1_BASE) {
         /* kseg0 */
-        if (kernel_mode) {
-            *physical = address - (int32_t)KSEG0_BASE;
-            *prot = PAGE_READ | PAGE_WRITE;
-        } else {
-            ret = TLBRET_BADADDR;
-        }
+        ret = get_segctl_physical_address(env, physical, prot, real_address, rw,
+                                          access_type, mmu_idx,
+                                          env->CP0_SegCtl1 >> 16, 0x1FFFFFFF);
     } else if (address < (int32_t)KSEG2_BASE) {
         /* kseg1 */
-        if (kernel_mode) {
-            *physical = address - (int32_t)KSEG1_BASE;
-            *prot = PAGE_READ | PAGE_WRITE;
-        } else {
-            ret = TLBRET_BADADDR;
-        }
+        ret = get_segctl_physical_address(env, physical, prot, real_address, rw,
+                                          access_type, mmu_idx,
+                                          env->CP0_SegCtl1, 0x1FFFFFFF);
     } else if (address < (int32_t)KSEG3_BASE) {
         /* sseg (kseg2) */
-        if (supervisor_mode || kernel_mode) {
-            ret = env->tlb->map_address(env, physical, prot, real_address, rw, access_type);
-        } else {
-            ret = TLBRET_BADADDR;
-        }
+        ret = get_segctl_physical_address(env, physical, prot, real_address, rw,
+                                          access_type, mmu_idx,
+                                          env->CP0_SegCtl0 >> 16, 0x1FFFFFFF);
     } else {
         /* kseg3 */
         /* XXX: debug segment is not emulated */
-        if (kernel_mode) {
-            ret = env->tlb->map_address(env, physical, prot, real_address, rw, access_type);
-        } else {
-            ret = TLBRET_BADADDR;
-        }
+        ret = get_segctl_physical_address(env, physical, prot, real_address, rw,
+                                          access_type, mmu_idx,
+                                          env->CP0_SegCtl0, 0x1FFFFFFF);
     }
     return ret;
 }
@@ -720,10 +829,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
 #if defined(TARGET_MIPS64)
             int R = env->CP0_BadVAddr >> 62;
             int UX = (env->CP0_Status & (1 << CP0St_UX)) != 0;
-            int SX = (env->CP0_Status & (1 << CP0St_SX)) != 0;
             int KX = (env->CP0_Status & (1 << CP0St_KX)) != 0;
 
-            if (((R == 0 && UX) || (R == 1 && SX) || (R == 3 && KX)) &&
+            if ((R != 0 || UX) && (R != 3 || KX) &&
                 (!(env->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F))))
                 offset = 0x080;
             else
@@ -739,10 +847,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
 #if defined(TARGET_MIPS64)
             int R = env->CP0_BadVAddr >> 62;
             int UX = (env->CP0_Status & (1 << CP0St_UX)) != 0;
-            int SX = (env->CP0_Status & (1 << CP0St_SX)) != 0;
             int KX = (env->CP0_Status & (1 << CP0St_KX)) != 0;
 
-            if (((R == 0 && UX) || (R == 1 && SX) || (R == 3 && KX)) &&
+            if ((R != 0 || UX) && (R != 3 || KX) &&
                 (!(env->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F))))
                 offset = 0x080;
             else
-- 
git-series 0.8.10
