Received: from eggs.gnu.org ([2001:4830:134:3::10]:47606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLx-0002bY-Ah
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLv-0008Gj-Bg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:53 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:42723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzLv-0008FG-2P
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:51 -0400
Received: by mail-pf0-x229.google.com with SMTP id v9-v6so6438010pff.9
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:58:50 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:57:56 +0900
Message-Id: <20180702135806.7087-16-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL 15/25] target/openrisc: Fix tlb flushing in mtspr
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

The previous code was confused, avoiding the flush of the old entry
if the new entry is invalid.  We need to flush the old page if the
old entry is valid and the new page if the new entry is valid.

This bug was masked by over-flushing elsewhere.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
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
2.17.0
