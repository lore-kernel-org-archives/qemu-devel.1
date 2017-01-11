Received: from eggs.gnu.org ([2001:4830:134:3::10]:55159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOV-0006uZ-T1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOU-0001I0-DC
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:15 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPOU-0001Gv-4Z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:14 -0500
Received: by mail-wm0-x243.google.com with SMTP id l2so569988wml.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:21:14 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:52 +0100
Message-Id: <0293a0b12e38e253a3590cebeee517ee16cf24d8.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 21/30] target-sparc: simplify
 ultrasparc_tsb_pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/ldst_helper.c | 51 ++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 4b8ca69..0447d4e 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -70,44 +70,35 @@
 #define QT1 (env->qt1)
 
 #if defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
-static uint64_t ultrasparc_tsb_pointer(CPUSPARCState *env, uint64_t tsb,
-                                       uint64_t *tsb_ptr,
-                                       uint64_t tag_access_register,
-                                       int idx, uint64_t *cfg_ptr)
 /* Calculates TSB pointer value for fault page size
  * UltraSPARC IIi has fixed sizes (8k or 64k) for the page pointers
  * UA2005 holds the page size configuration in mmu_ctx registers */
+static uint64_t ultrasparc_tsb_pointer(CPUSPARCState *env,
+                                       const SparcV9MMU *mmu, const int idx)
 {
     uint64_t tsb_register;
     int page_size;
     if (cpu_has_hypervisor(env)) {
         int tsb_index = 0;
-        int ctx = tag_access_register & 0x1fffULL;
-        uint64_t ctx_register = cfg_ptr[ctx ? 1 : 0];
+        int ctx = mmu->tag_access & 0x1fffULL;
+        uint64_t ctx_register = mmu->sun4v_ctx_config[ctx ? 1 : 0];
         tsb_index = idx;
         tsb_index |= ctx ? 2 : 0;
         page_size = idx ? ctx_register >> 8 : ctx_register;
         page_size &= 7;
-        tsb_register = tsb_ptr[tsb_index];
+        tsb_register = mmu->sun4v_tsb_pointers[tsb_index];
     } else {
         page_size = idx;
-        tsb_register = tsb;
+        tsb_register = mmu->tsb;
     }
-    uint64_t tsb_base = tsb_register & ~0x1fffULL;
     int tsb_split = (tsb_register & 0x1000ULL) ? 1 : 0;
     int tsb_size  = tsb_register & 0xf;
 
-    /* discard lower 13 bits which hold tag access context */
-    uint64_t tag_access_va = tag_access_register & ~0x1fffULL;
+    uint64_t tsb_base_mask = (~0x1fffULL) << tsb_size;
 
-    /* now reorder bits */
-    uint64_t tsb_base_mask = ~0x1fffULL;
-    uint64_t va = tag_access_va;
-
-    /* move va bits to correct position */
-    va >>= 3 * page_size + 9;
-
-    tsb_base_mask <<= tsb_size;
+    /* move va bits to correct position,
+     * the context bits will be masked out later */
+    uint64_t va = mmu->tag_access >> (3 * page_size + 9);
 
     /* calculate tsb_base mask and adjust va if split is in use */
     if (tsb_split) {
@@ -119,7 +110,7 @@ static uint64_t ultrasparc_tsb_pointer(CPUSPARCState *env, uint64_t tsb,
         tsb_base_mask <<= 1;
     }
 
-    return ((tsb_base & tsb_base_mask) | (va & ~tsb_base_mask)) & ~0xfULL;
+    return ((tsb_register & tsb_base_mask) | (va & ~tsb_base_mask)) & ~0xfULL;
 }
 
 /* Calculates tag target register value by reordering bits
@@ -1266,20 +1257,14 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         {
             /* env->immuregs[5] holds I-MMU TSB register value
                env->immuregs[6] holds I-MMU Tag Access register value */
-            ret = ultrasparc_tsb_pointer(env, env->immu.tsb,
-                                         env->immu.sun4v_tsb_pointers,
-                                         env->immu.tag_access,
-                                         0, env->immu.sun4v_ctx_config);
+            ret = ultrasparc_tsb_pointer(env, &env->immu, 0);
             break;
         }
     case ASI_IMMU_TSB_64KB_PTR: /* I-MMU 64k TSB pointer */
         {
             /* env->immuregs[5] holds I-MMU TSB register value
                env->immuregs[6] holds I-MMU Tag Access register value */
-            ret = ultrasparc_tsb_pointer(env, env->immu.tsb,
-                                         env->immu.sun4v_tsb_pointers,
-                                         env->immu.tag_access,
-                                         1, env->immu.sun4v_ctx_config);
+            ret = ultrasparc_tsb_pointer(env, &env->immu, 1);
             break;
         }
     case ASI_ITLB_DATA_ACCESS: /* I-MMU data access */
@@ -1338,20 +1323,14 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         {
             /* env->dmmuregs[5] holds D-MMU TSB register value
                env->dmmuregs[6] holds D-MMU Tag Access register value */
-            ret = ultrasparc_tsb_pointer(env, env->dmmu.tsb,
-                                         env->dmmu.sun4v_tsb_pointers,
-                                         env->dmmu.tag_access,
-                                         0, env->dmmu.sun4v_ctx_config);
+            ret = ultrasparc_tsb_pointer(env, &env->dmmu, 0);
             break;
         }
     case ASI_DMMU_TSB_64KB_PTR: /* D-MMU 64k TSB pointer */
         {
             /* env->dmmuregs[5] holds D-MMU TSB register value
                env->dmmuregs[6] holds D-MMU Tag Access register value */
-            ret = ultrasparc_tsb_pointer(env, env->dmmu.tsb,
-                                         env->dmmu.sun4v_tsb_pointers,
-                                         env->dmmu.tag_access,
-                                         1, env->dmmu.sun4v_ctx_config);
+            ret = ultrasparc_tsb_pointer(env, &env->dmmu, 1);
             break;
         }
     case ASI_DTLB_DATA_ACCESS: /* D-MMU data access */
-- 
1.8.3.1
