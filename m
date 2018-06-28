Received: from eggs.gnu.org ([2001:4830:134:3::10]:40022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDy-000573-Ez
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDu-00080z-Hk
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:58 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:42720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDu-000800-Ck
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:54 -0400
Received: by mail-pg0-x236.google.com with SMTP id c10-v6so1794446pgu.9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:22 -0700
Message-Id: <20180628030330.15615-16-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 15/23] target/openrisc: Fix tlb flushing in
 mtspr
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

The previous code was confused, avoiding the flush of the old entry
if the new entry is invalid.  We need to flush the old page if the
old entry is valid and the new page if the new entry is valid.

This bug was masked by over-flushing elsewhere.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/sys_helper.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 7f458b0d17..c9702cd26c 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -32,6 +32,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 #ifndef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
+    target_ulong mr;
     int idx;
 
     switch (spr) {
@@ -85,12 +86,15 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
-        if (!(rb & 1)) {
-            tlb_flush_page(cs, env->tlb.dtlb[idx].mr & TARGET_PAGE_MASK);
+        mr = env->tlb.dtlb[idx].mr;
+        if (mr & 1) {
+            tlb_flush_page(cs, mr & TARGET_PAGE_MASK);
+        }
+        if (rb & 1) {
+            tlb_flush_page(cs, rb & TARGET_PAGE_MASK);
         }
         env->tlb.dtlb[idx].mr = rb;
         break;
-
     case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
         idx = spr - TO_SPR(1, 640);
         env->tlb.dtlb[idx].tr = rb;
@@ -102,14 +106,18 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     case TO_SPR(1, 1280) ... TO_SPR(1, 1407): /* DTLBW3MR 0-127 */
     case TO_SPR(1, 1408) ... TO_SPR(1, 1535): /* DTLBW3TR 0-127 */
         break;
+
     case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1):   /* ITLBW0MR 0-127 */
         idx = spr - TO_SPR(2, 512);
-        if (!(rb & 1)) {
-            tlb_flush_page(cs, env->tlb.itlb[idx].mr & TARGET_PAGE_MASK);
+        mr = env->tlb.itlb[idx].mr;
+        if (mr & 1) {
+            tlb_flush_page(cs, mr & TARGET_PAGE_MASK);
+        }
+        if (rb & 1) {
+            tlb_flush_page(cs, rb & TARGET_PAGE_MASK);
         }
         env->tlb.itlb[idx].mr = rb;
         break;
-
     case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
         idx = spr - TO_SPR(2, 640);
         env->tlb.itlb[idx].tr = rb;
@@ -121,6 +129,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     case TO_SPR(2, 1280) ... TO_SPR(2, 1407): /* ITLBW3MR 0-127 */
     case TO_SPR(2, 1408) ... TO_SPR(2, 1535): /* ITLBW3TR 0-127 */
         break;
+
     case TO_SPR(5, 1):  /* MACLO */
         env->mac = deposit64(env->mac, 0, 32, rb);
         break;
-- 
2.17.1
