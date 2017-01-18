Received: from eggs.gnu.org ([2001:4830:134:3::10]:37108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytN-0006m8-Ql
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytM-0002uj-M9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:45 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytM-0002tr-Cx
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:44 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so7540432wmr.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:44 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:33 +0100
Message-Id: <1484779123-18968-21-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h         |   2 +
 target/sparc/ldst_helper.c | 124 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index c92bd25..9e9b22a 100644
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
index a96b031..aa6f77d 100644
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
@@ -1256,16 +1268,20 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
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
@@ -1324,16 +1340,20 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
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
@@ -1471,7 +1491,67 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
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
2.7.2
