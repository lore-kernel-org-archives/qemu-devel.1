Received: from eggs.gnu.org ([2001:4830:134:3::10]:35359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBJm5-0006Jv-4h
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBJm1-0001DT-6J
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dBJm0-0001DG-TD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:39:17 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 18 May 2017 13:39:09 +0200
Message-Id: <1495107549-6097-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

TEST BLOCK was likely once used to execute basic memory
tests, but nowadays it's just a (slow) way to clear a page.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Use DEF_HELPER_FLAGS_2 instead for DEF_HELPER_2 for returning CC value
 - Convert real to absolute address
 - Added a check for valid RAM page
 - Added low-address protection check

 target/s390x/cpu.h         |  1 +
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 28 ++++++++++++++++++++++++++++
 target/s390x/mmu_helper.c  |  2 +-
 target/s390x/translate.c   | 10 ++++++++++
 6 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 240b8a5..4f38ba0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1082,6 +1082,7 @@ struct sysib_322 {
 #define SIGP_ORDER_MASK 0x000000ff
 
 void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
+target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, bool exc);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 0b70770..1fae191 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -102,6 +102,7 @@ DEF_HELPER_FLAGS_4(lctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(stctg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
+DEF_HELPER_FLAGS_2(testblock, TCG_CALL_NO_WG, i32, env, i64)
 DEF_HELPER_FLAGS_2(tprot, TCG_CALL_NO_RWG, i32, i64, i64)
 DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 55a7c52..cac0f51 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -918,6 +918,8 @@
 /* STORE USING REAL ADDRESS */
     C(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0)
     C(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0)
+/* TEST BLOCK */
+    C(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0)
 /* TEST PROTECTION */
     C(0xe501, TPROT,   SSE,   Z,   la1, a2, 0, 0, tprot, 0)
 
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index f6e5bce..de0ecd4 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
@@ -973,6 +974,33 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 }
 
+uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
+{
+    CPUState *cs = CPU(s390_env_get_cpu(env));
+    uint64_t abs_addr;
+    int i;
+
+    real_addr = fix_address(env, real_addr);
+    abs_addr = mmu_real2abs(env, real_addr) & TARGET_PAGE_MASK;
+    if (!address_space_access_valid(&address_space_memory, abs_addr,
+                                    TARGET_PAGE_SIZE, true)) {
+        program_interrupt(env, PGM_ADDRESSING, 4);
+        return 1;
+    }
+
+    /* Check low-address protection */
+    if ((env->cregs[0] & CR0_LOWPROT) != 0 && real_addr < 0x2000) {
+        program_interrupt(env, PGM_PROTECTION, 4);
+        return 1;
+    }
+
+    for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
+        stq_phys(cs->as, abs_addr + i, 0);
+    }
+
+    return 0;
+}
+
 uint32_t HELPER(tprot)(uint64_t a1, uint64_t a2)
 {
     /* XXX implement */
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b11a027..31eb9ef 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -108,7 +108,7 @@ static void trigger_page_fault(CPUS390XState *env, target_ulong vaddr,
  * Translate real address to absolute (= physical)
  * address by taking care of the prefix mapping.
  */
-static target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr)
+target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr)
 {
     if (raddr < 0x2000) {
         return raddr + env->psa;    /* Map the lowcore. */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4c48c59..61aa2c9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4057,6 +4057,15 @@ static ExitStatus op_tcxb(DisasContext *s, DisasOps *o)
 }
 
 #ifndef CONFIG_USER_ONLY
+
+static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    gen_helper_testblock(cc_op, cpu_env, o->in2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
 {
     potential_page_fault(s);
@@ -4064,6 +4073,7 @@ static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
     set_cc_static(s);
     return NO_EXIT;
 }
+
 #endif
 
 static ExitStatus op_tr(DisasContext *s, DisasOps *o)
-- 
1.8.3.1
