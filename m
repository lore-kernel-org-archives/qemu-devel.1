Received: from eggs.gnu.org ([2001:4830:134:3::10]:55113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwZ-0005d2-Mt
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwY-0001Jk-Le
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:15 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwY-0001Ii-FG
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:14 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:49 +0200
Message-Id: <20170525210508.4910-8-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 07/26] target/s390x: implement STORE PAIR TO
 QUADWORD
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

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/insn-data.def |  2 ++
 target/s390x/translate.c   | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 53c86d5832..751e3164dd 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -770,6 +770,8 @@
 /* STORE ACCESS MULTIPLE */
     C(0x9b00, STAM,    RS_a,  Z,   0, a2, 0, 0, stam, 0)
     C(0xeb9b, STAMY,   RSY_a, LD,  0, a2, 0, 0, stam, 0)
+/* STORE PAIR TO QUADWORD */
+    C(0xe38e, STPQ,    RXY_a, Z,   0, a2, 0, 0, stpq, 0)
 
 /* SUBTRACT */
     C(0x1b00, SR,      RR_a,  Z,   r1, r2, new, r1_32, sub, subs32)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 09052972f1..231b51c313 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4025,6 +4025,24 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_stpq(DisasContext *s, DisasOps *o)
+{
+    int r1 = get_field(s->fields, r1);
+
+    /* In a parallel context, stop the world and single step.  */
+    if (parallel_cpus) {
+        potential_page_fault(s);
+        gen_exception(EXCP_ATOMIC);
+        return EXIT_NORETURN;
+    }
+
+    /* In a serial context, perform the two stores ... */
+    tcg_gen_qemu_st64(regs[r1], o->in2, get_mem_index(s));
+    tcg_gen_addi_i64(o->in2, o->in2, 8);
+    tcg_gen_qemu_st64(regs[r1 + 1], o->in2, get_mem_index(s));
+    return NO_EXIT;
+}
+
 static ExitStatus op_srst(DisasContext *s, DisasOps *o)
 {
     gen_helper_srst(o->in1, cpu_env, regs[0], o->in1, o->in2);
-- 
2.11.0
