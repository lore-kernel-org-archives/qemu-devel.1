Received: from eggs.gnu.org ([2001:4830:134:3::10]:55130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwa-0005d4-7T
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwY-0001Jo-LT
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwY-0001Ih-GD
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:14 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:48 +0200
Message-Id: <20170525210508.4910-7-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 06/26] target/s390x: implement LOAD PAIR FROM
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
 target/s390x/translate.c   | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f92bfde4f8..53c86d5832 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -507,6 +507,8 @@
 /* LOAD PAIR DISJOINT */
     D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)
     D(0xc805, LPDG,    SSF,   ILA, 0, 0, new_P, r3_P64, lpd, 0, MO_TEQ)
+/* LOAD PAIR FROM QUADWORD */
+    C(0xe38f, LPQ,     RXY_a, Z,   0, a2, r1_P, 0, lpq, 0)
 /* LOAD POSITIVE */
     C(0x1000, LPR,     RR_a,  Z,   0, r2_32s, new, r1_32, abs, abs32)
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 624e8667d7..09052972f1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2827,6 +2827,22 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_lpq(DisasContext *s, DisasOps *o)
+{
+    /* In a parallel context, stop the world and single step.  */
+    if (parallel_cpus) {
+        potential_page_fault(s);
+        gen_exception(EXCP_ATOMIC);
+        return EXIT_NORETURN;
+    }
+
+    /* In a serial context, perform the two loads ... */
+    tcg_gen_qemu_ld64(o->out, o->in2, get_mem_index(s));
+    tcg_gen_addi_i64(o->in2, o->in2, 8);
+    tcg_gen_qemu_ld64(o->out2, o->in2, get_mem_index(s));
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_lura(DisasContext *s, DisasOps *o)
 {
-- 
2.11.0
