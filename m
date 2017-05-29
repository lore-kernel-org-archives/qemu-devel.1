Received: from eggs.gnu.org ([2001:4830:134:3::10]:38824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHc-0006Tx-FK
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-00073o-8O
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:52 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHZ-00072Z-Uy
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:14 +0200
Message-Id: <20170529192440.5990-4-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 03/29] target/s390x: implement
 local-TLB-clearing in IPTE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

And at the same time make IPTE SMP aware.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h     |  2 +-
 target/s390x/mem_helper.c | 19 ++++++++++++-------
 target/s390x/translate.c  |  6 +++++-
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index cc451c70a6..3f5a05d43b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -111,7 +111,7 @@ DEF_HELPER_4(mvcs, i32, env, i64, i64, i64)
 DEF_HELPER_4(mvcp, i32, env, i64, i64, i64)
 DEF_HELPER_4(sigp, i32, env, i64, i32, i64)
 DEF_HELPER_FLAGS_2(sacf, TCG_CALL_NO_WG, void, env, i64)
-DEF_HELPER_FLAGS_3(ipte, TCG_CALL_NO_RWG, void, env, i64, i64)
+DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(lra, i64, env, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 0ebd65d9ab..9fbe7c9ef9 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1073,14 +1073,13 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
 }
 
 /* invalidate pte */
-void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr)
+void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
+                  uint32_t m4)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
     uint64_t page = vaddr & TARGET_PAGE_MASK;
     uint64_t pte_addr, pte;
 
-    /* XXX broadcast to other CPUs */
-
     /* Compute the page table entry address */
     pte_addr = (pto & _SEGMENT_ENTRY_ORIGIN);
     pte_addr += (vaddr & _VADDR_PX) >> 9;
@@ -1092,13 +1091,19 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr)
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
-    tlb_flush_page(cs, page);
+    /* XXX: the LC bit should be considered as 0 if the local-TLB-clearing
+       facility is not installed.  */
+    if (m4 & 1) {
+        tlb_flush_page(cs, page);
+    } else {
+        tlb_flush_page_all_cpus_synced(cs, page);
+    }
 
     /* XXX 31-bit hack */
-    if (page & 0x80000000) {
-        tlb_flush_page(cs, page & ~0x80000000);
+    if (m4 & 1) {
+        tlb_flush_page(cs, page ^ 0x80000000);
     } else {
-        tlb_flush_page(cs, page | 0x80000000);
+        tlb_flush_page_all_cpus_synced(cs, page ^ 0x80000000);
     }
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f7598184a6..f160b62c19 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2352,8 +2352,12 @@ static ExitStatus op_ipm(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_ipte(DisasContext *s, DisasOps *o)
 {
+    TCGv_i32 m4;
+
     check_privileged(s);
-    gen_helper_ipte(cpu_env, o->in1, o->in2);
+    m4 = tcg_const_i32(get_field(s->fields, m4));
+    gen_helper_ipte(cpu_env, o->in1, o->in2, m4);
+    tcg_temp_free_i32(m4);
     return NO_EXIT;
 }
 
-- 
2.11.0
