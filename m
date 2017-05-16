Received: from eggs.gnu.org ([2001:4830:134:3::10]:47050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAYmB-0006P0-Mv
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAYm8-0004VC-JI
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:28:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dAYm8-0004Ux-AE
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:28:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 16 May 2017 11:28:04 +0200
Message-Id: <1494926884-10118-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v1] target/s390x: Add support for the TEST
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
Cc: David Hildenbrand <david@redhat.com>, mmarek@suse.com, mbenes@suse.cz

TEST BLOCK was likely once used to execute basic memory
tests, but nowadays it's just a (slow) way to clear a page.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 12 ++++++++++++
 target/s390x/translate.c   | 10 ++++++++++
 4 files changed, 25 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 9102071..a5a3705 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -99,6 +99,7 @@ DEF_HELPER_FLAGS_4(lctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(stctg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
+DEF_HELPER_2(testblock, void, env, i64)
 DEF_HELPER_FLAGS_2(tprot, TCG_CALL_NO_RWG, i32, i64, i64)
 DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 075ff59..a6aba54 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -912,6 +912,8 @@
 /* STORE USING REAL ADDRESS */
     C(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0)
     C(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0)
+/* TEST BLOCK */
+    C(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0)
 /* TEST PROTECTION */
     C(0xe501, TPROT,   SSE,   Z,   la1, a2, 0, 0, tprot, 0)
 
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 675aba2..0349c10 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -933,6 +933,18 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 }
 
+void HELPER(testblock)(CPUS390XState *env, uint64_t addr)
+{
+    CPUState *cs = CPU(s390_env_get_cpu(env));
+    int i;
+
+    addr = get_address(env, 0, 0, addr) & ~0xfffULL;
+    for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
+        stq_phys(cs->as, addr + i, 0);
+    }
+    env->cc_op = 0;
+}
+
 uint32_t HELPER(tprot)(uint64_t a1, uint64_t a2)
 {
     /* XXX implement */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 01c6217..f48c899 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4016,6 +4016,15 @@ static ExitStatus op_tcxb(DisasContext *s, DisasOps *o)
 }
 
 #ifndef CONFIG_USER_ONLY
+
+static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    gen_helper_testblock(cpu_env, o->in2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
 {
     potential_page_fault(s);
@@ -4023,6 +4032,7 @@ static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
     set_cc_static(s);
     return NO_EXIT;
 }
+
 #endif
 
 static ExitStatus op_tr(DisasContext *s, DisasOps *o)
-- 
1.8.3.1
