Received: from eggs.gnu.org ([2001:4830:134:3::10]:55622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZA-0008RJ-QF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ9-0006pv-Nz
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:40 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZ9-0006ph-J8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:39 -0500
Received: by mail-qt0-x244.google.com with SMTP id n13so850225qtc.0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:39 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:56 -0800
Message-Id: <20170112025606.27332-21-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 20/30] target-sparc: implement UA2005 TSB
 Pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <83b315e3527bef56741c84e6d4f98de9bea2c560.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/cpu.h         |   2 +
 target/sparc/ldst_helper.c | 124 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 8ce7197..7b6565d 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -417,6 +417,8 @@ typedef union {
     uint64_t tag_access;
     uint64_t virtual_watchpoint;
     uint64_t physical_watchpoint;
+    uint64_t sun4v_ctx_config[2];
+    uint64_t sun4v_tsb_pointers[4];
    };
 } SparcV9MMU;
 #endif
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 8e01260..4b8ca69 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -70,11 +70,29 @@
 #define QT1 (env->qt1)
 
 #if defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
-/* Calculates TSB pointer value for fault page size 8k or 64k */
-static uint64_t ultrasparc_tsb_pointer(uint64_t tsb_register,
+static uint64_t ultrasparc_tsb_pointer(CPUSPARCState *env, uint64_t tsb,
+                                       uint64_t *tsb_ptr,
                                        uint64_t tag_access_register,
-                                       int page_size)
+                                       int idx, uint64_t *cfg_ptr)
+/* Calculates TSB pointer value for fault page size
+ * UltraSPARC IIi has fixed sizes (8k or 64k) for the page pointers
+ * UA2005 holds the page size configuration in mmu_ctx registers */
 {
+    uint64_t tsb_register;
+    int page_size;
+    if (cpu_has_hypervisor(env)) {
+        int tsb_index = 0;
+        int ctx = tag_access_register & 0x1fffULL;
+        uint64_t ctx_register = cfg_ptr[ctx ? 1 : 0];
+        tsb_index = idx;
+        tsb_index |= ctx ? 2 : 0;
+        page_size = idx ? ctx_register >> 8 : ctx_register;
+        page_size &= 7;
+        tsb_register = tsb_ptr[tsb_index];
+    } else {
+        page_size = idx;
+        tsb_register = tsb;
+    }
     uint64_t tsb_base = tsb_register & ~0x1fffULL;
     int tsb_split = (tsb_register & 0x1000ULL) ? 1 : 0;
     int tsb_size  = tsb_register & 0xf;
@@ -87,21 +105,15 @@ static uint64_t ultrasparc_tsb_pointer(uint64_t tsb_register,
     uint64_t va = tag_access_va;
 
     /* move va bits to correct position */
-    if (page_size == 8*1024) {
-        va >>= 9;
-    } else if (page_size == 64*1024) {
-        va >>= 12;
-    }
+    va >>= 3 * page_size + 9;
 
-    if (tsb_size) {
-        tsb_base_mask <<= tsb_size;
-    }
+    tsb_base_mask <<= tsb_size;
 
     /* calculate tsb_base mask and adjust va if split is in use */
     if (tsb_split) {
-        if (page_size == 8*1024) {
+        if (idx == 0) {
             va &= ~(1ULL << (13 + tsb_size));
-        } else if (page_size == 64*1024) {
+        } else {
             va |= (1ULL << (13 + tsb_size));
         }
         tsb_base_mask <<= 1;
@@ -1254,16 +1266,20 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         {
             /* env->immuregs[5] holds I-MMU TSB register value
                env->immuregs[6] holds I-MMU Tag Access register value */
-            ret = ultrasparc_tsb_pointer(env->immu.tsb, env->immu.tag_access,
-                                         8*1024);
+            ret = ultrasparc_tsb_pointer(env, env->immu.tsb,
+                                         env->immu.sun4v_tsb_pointers,
+                                         env->immu.tag_access,
+                                         0, env->immu.sun4v_ctx_config);
             break;
         }
     case ASI_IMMU_TSB_64KB_PTR: /* I-MMU 64k TSB pointer */
         {
             /* env->immuregs[5] holds I-MMU TSB register value
                env->immuregs[6] holds I-MMU Tag Access register value */
-            ret = ultrasparc_tsb_pointer(env->immu.tsb, env->immu.tag_access,
-                                         64*1024);
+            ret = ultrasparc_tsb_pointer(env, env->immu.tsb,
+                                         env->immu.sun4v_tsb_pointers,
+                                         env->immu.tag_access,
+                                         1, env->immu.sun4v_ctx_config);
             break;
         }
     case ASI_ITLB_DATA_ACCESS: /* I-MMU data access */
@@ -1322,16 +1338,20 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         {
             /* env->dmmuregs[5] holds D-MMU TSB register value
                env->dmmuregs[6] holds D-MMU Tag Access register value */
-            ret = ultrasparc_tsb_pointer(env->dmmu.tsb, env->dmmu.tag_access,
-                                         8*1024);
+            ret = ultrasparc_tsb_pointer(env, env->dmmu.tsb,
+                                         env->dmmu.sun4v_tsb_pointers,
+                                         env->dmmu.tag_access,
+                                         0, env->dmmu.sun4v_ctx_config);
             break;
         }
     case ASI_DMMU_TSB_64KB_PTR: /* D-MMU 64k TSB pointer */
         {
             /* env->dmmuregs[5] holds D-MMU TSB register value
                env->dmmuregs[6] holds D-MMU Tag Access register value */
-            ret = ultrasparc_tsb_pointer(env->dmmu.tsb, env->dmmu.tag_access,
-                                         64*1024);
+            ret = ultrasparc_tsb_pointer(env, env->dmmu.tsb,
+                                         env->dmmu.sun4v_tsb_pointers,
+                                         env->dmmu.tag_access,
+                                         1, env->dmmu.sun4v_ctx_config);
             break;
         }
     case ASI_DTLB_DATA_ACCESS: /* D-MMU data access */
@@ -1469,7 +1489,67 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
     case ASI_TWINX_SL: /* Secondary, twinx, LE */
         /* These are always handled inline.  */
         g_assert_not_reached();
-
+    /* these ASIs have different functions on UltraSPARC-IIIi
+     * and UA2005 CPUs. Use the explicit numbers to avoid confusion
+     */
+    case 0x31:
+    case 0x32:
+    case 0x39:
+    case 0x3a:
+        if (cpu_has_hypervisor(env)) {
+            /* UA2005
+             * ASI_DMMU_CTX_ZERO_TSB_BASE_PS0
+             * ASI_DMMU_CTX_ZERO_TSB_BASE_PS1
+             * ASI_DMMU_CTX_NONZERO_TSB_BASE_PS0
+             * ASI_DMMU_CTX_NONZERO_TSB_BASE_PS1
+             */
+            int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
+            env->dmmu.sun4v_tsb_pointers[idx] = val;
+        } else {
+            helper_raise_exception(env, TT_ILL_INSN);
+        }
+        break;
+    case 0x33:
+    case 0x3b:
+        if (cpu_has_hypervisor(env)) {
+            /* UA2005
+             * ASI_DMMU_CTX_ZERO_CONFIG
+             * ASI_DMMU_CTX_NONZERO_CONFIG
+             */
+            env->dmmu.sun4v_ctx_config[(asi & 8) >> 3] = val;
+        } else {
+            helper_raise_exception(env, TT_ILL_INSN);
+        }
+        break;
+    case 0x35:
+    case 0x36:
+    case 0x3d:
+    case 0x3e:
+        if (cpu_has_hypervisor(env)) {
+            /* UA2005
+             * ASI_IMMU_CTX_ZERO_TSB_BASE_PS0
+             * ASI_IMMU_CTX_ZERO_TSB_BASE_PS1
+             * ASI_IMMU_CTX_NONZERO_TSB_BASE_PS0
+             * ASI_IMMU_CTX_NONZERO_TSB_BASE_PS1
+             */
+            int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
+            env->immu.sun4v_tsb_pointers[idx] = val;
+        } else {
+            helper_raise_exception(env, TT_ILL_INSN);
+        }
+      break;
+    case 0x37:
+    case 0x3f:
+        if (cpu_has_hypervisor(env)) {
+            /* UA2005
+             * ASI_IMMU_CTX_ZERO_CONFIG
+             * ASI_IMMU_CTX_NONZERO_CONFIG
+             */
+            env->immu.sun4v_ctx_config[(asi & 8) >> 3] = val;
+        } else {
+          helper_raise_exception(env, TT_ILL_INSN);
+        }
+        break;
     case ASI_UPA_CONFIG: /* UPA config */
         /* XXX */
         return;
-- 
2.9.3
