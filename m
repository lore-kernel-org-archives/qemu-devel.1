Received: from eggs.gnu.org ([2001:4830:134:3::10]:55736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZL-0000Vs-48
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZJ-0006sf-US
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:51 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZJ-0006sW-PU
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:49 -0500
Received: by mail-qk0-x243.google.com with SMTP id e1so952907qkh.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:49 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:56:02 -0800
Message-Id: <20170112025606.27332-27-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 26/30] target-sparc: store the UA2005 entries in
 sun4u format
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

According to chapter 13.3 of the
UltraSPARC T1 Supplement to the UltraSPARC Architecture 2005,
only the sun4u format is available for data-access loads.

Store UA2005 entries in the sun4u format to simplify processing.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <7ba71816ff6ec9c5af75e9a7430a1d9128efa786.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/cpu.h         |  3 +++
 target/sparc/ldst_helper.c | 52 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 7b6565d..acea350 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -384,6 +384,9 @@ enum {
 #define CACHE_CTRL_FD (1 << 22)  /* Flush Data cache (Write only) */
 #define CACHE_CTRL_DS (1 << 23)  /* Data cache snoop enable */
 
+#define CONVERT_BIT(X, SRC, DST) \
+         (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
+
 typedef struct SparcTLBEntry {
     uint64_t tag;
     uint64_t tte;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index d34795a..c8a819d 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -204,12 +204,34 @@ static void demap_tlb(SparcTLBEntry *tlb, target_ulong demap_addr,
     }
 }
 
+static uint64_t sun4v_tte_to_sun4u(CPUSPARCState *env, uint64_t tag,
+                                   uint64_t sun4v_tte)
+{
+    uint64_t sun4u_tte;
+    if (!(cpu_has_hypervisor(env) && (tag & TLB_UST1_IS_SUN4V_BIT))) {
+        /* is already in the sun4u format */
+        return sun4v_tte;
+    }
+    sun4u_tte = TTE_PA(sun4v_tte) | (sun4v_tte & TTE_VALID_BIT);
+    sun4u_tte |= (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
+    sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_NFO_BIT_UA2005, TTE_NFO_BIT);
+    sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_USED_BIT_UA2005, TTE_USED_BIT);
+    sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_W_OK_BIT_UA2005, TTE_W_OK_BIT);
+    sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_SIDEEFFECT_BIT_UA2005,
+                             TTE_SIDEEFFECT_BIT);
+    sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_PRIV_BIT_UA2005, TTE_PRIV_BIT);
+    sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_LOCKED_BIT_UA2005, TTE_LOCKED_BIT);
+    return sun4u_tte;
+}
+
 static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
                                  uint64_t tlb_tag, uint64_t tlb_tte,
-                                 const char *strmmu, CPUSPARCState *env1)
+                                 const char *strmmu, CPUSPARCState *env1,
+                                 uint64_t addr)
 {
     unsigned int i, replace_used;
 
+    tlb_tte = sun4v_tte_to_sun4u(env1, addr, tlb_tte);
     if (cpu_has_hypervisor(env1)) {
         uint64_t new_vaddr = tlb_tag & ~0x1fffULL;
         uint64_t new_size = 8192ULL << 3 * TTE_PGSIZE(tlb_tte);
@@ -1615,7 +1637,11 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             return;
         }
     case ASI_ITLB_DATA_IN: /* I-MMU data in */
-        replace_tlb_1bit_lru(env->itlb, env->immu.tag_access, val, "immu", env);
+        /* ignore real translation entries */
+        if (!(addr & TLB_UST1_IS_REAL_BIT)) {
+            replace_tlb_1bit_lru(env->itlb, env->immu.tag_access,
+                                 val, "immu", env, addr);
+        }
         return;
     case ASI_ITLB_DATA_ACCESS: /* I-MMU data access */
         {
@@ -1623,8 +1649,11 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 
             unsigned int i = (addr >> 3) & 0x3f;
 
-            replace_tlb_entry(&env->itlb[i], env->immu.tag_access, val, env);
-
+            /* ignore real translation entries */
+            if (!(addr & TLB_UST1_IS_REAL_BIT)) {
+                replace_tlb_entry(&env->itlb[i], env->immu.tag_access,
+                                  sun4v_tte_to_sun4u(env, addr, val), env);
+            }
 #ifdef DEBUG_MMU
             DPRINTF_MMU("immu data access replaced entry [%i]\n", i);
             dump_mmu(stdout, fprintf, env);
@@ -1692,14 +1721,21 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             return;
         }
     case ASI_DTLB_DATA_IN: /* D-MMU data in */
-        replace_tlb_1bit_lru(env->dtlb, env->dmmu.tag_access, val, "dmmu", env);
-        return;
+      /* ignore real translation entries */
+      if (!(addr & TLB_UST1_IS_REAL_BIT)) {
+          replace_tlb_1bit_lru(env->dtlb, env->dmmu.tag_access,
+                               val, "dmmu", env, addr);
+      }
+      return;
     case ASI_DTLB_DATA_ACCESS: /* D-MMU data access */
         {
             unsigned int i = (addr >> 3) & 0x3f;
 
-            replace_tlb_entry(&env->dtlb[i], env->dmmu.tag_access, val, env);
-
+            /* ignore real translation entries */
+            if (!(addr & TLB_UST1_IS_REAL_BIT)) {
+                replace_tlb_entry(&env->dtlb[i], env->dmmu.tag_access,
+                                  sun4v_tte_to_sun4u(env, addr, val), env);
+            }
 #ifdef DEBUG_MMU
             DPRINTF_MMU("dmmu data access replaced entry [%i]\n", i);
             dump_mmu(stdout, fprintf, env);
-- 
2.9.3
