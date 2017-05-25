Received: from eggs.gnu.org ([2001:4830:134:3::10]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwb-0005dK-63
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwZ-0001Ky-Qr
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:17 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwZ-0001JJ-JR
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:15 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:52 +0200
Message-Id: <20170525210508.4910-11-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 10/26] target/s390x: implement MOVE WITH OFFSET
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
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  4 ++++
 target/s390x/mem_helper.c  | 31 +++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  8 ++++++++
 4 files changed, 44 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 0558d6dc21..fe73d71b49 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -14,6 +14,7 @@ DEF_HELPER_FLAGS_4(divu64, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_4(srst, i64, env, i64, i64, i64)
 DEF_HELPER_4(clst, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32, i64, i64)
+DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvpg, TCG_CALL_NO_WG, i32, env, i64, i64, i64)
 DEF_HELPER_4(mvst, i64, env, i64, i64, i64)
 DEF_HELPER_4(ex, void, env, i32, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 518b87b160..be8b7af211 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -578,6 +578,10 @@
     C(0xb254, MVPG,    RRE,   Z,   r1_o, r2_o, 0, 0, mvpg, 0)
 /* MOVE STRING */
     C(0xb255, MVST,    RRE,   Z,   r1_o, r2_o, 0, 0, mvst, 0)
+/* MOVE WITH OFFSET */
+    /* Really format SS_b, but we pack both lengths into one argument
+       for the helper call, so we might as well leave one 8-bit field.  */
+    C(0xf100, MVO,     SS_a,  Z,   la1, a2, 0, 0, mvo, 0)
 
 /* MULTIPLY */
     C(0x1c00, MR,      RR_a,  Z,   r1p1_32s, r2_32s, new, r1_D32, mul, 0)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 88be30555d..4f523a8a8c 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -257,6 +257,37 @@ void HELPER(mvn)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
     }
 }
 
+/* move with offset  */
+void HELPER(mvo)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
+{
+    uintptr_t ra = GETPC();
+    int len_dest = l >> 4;
+    int len_src = l & 0xf;
+    uint8_t byte_dest, byte_src;
+    int i;
+
+    src += len_src;
+    dest += len_dest;
+
+    /* Handle rightmost byte */
+    byte_src = cpu_ldub_data_ra(env, src, ra);
+    byte_dest = cpu_ldub_data_ra(env, dest, ra);
+    byte_dest = (byte_dest & 0x0f) | (byte_src << 4);
+    cpu_stb_data_ra(env, dest, byte_dest, ra);
+
+    /* Process remaining bytes from right to left */
+    for (i = 1; i <= len_dest; i++) {
+        byte_dest = byte_src >> 4;
+        if (len_src - i >= 0) {
+            byte_src = cpu_ldub_data_ra(env, src - i, ra);
+        } else {
+            byte_src = 0;
+        }
+        byte_dest |= byte_src << 4;
+        cpu_stb_data_ra(env, dest - i, byte_dest, ra);
+    }
+}
+
 /* compare unsigned byte arrays */
 static uint32_t do_helper_clc(CPUS390XState *env, uint32_t l, uint64_t s1,
                               uint64_t s2, uintptr_t ra)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ec6b85c2d0..6d2a1dfe1c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2983,6 +2983,14 @@ static ExitStatus op_mvn(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_mvo(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
+    gen_helper_mvo(cpu_env, l, o->addr1, o->in2);
+    tcg_temp_free_i32(l);
+    return NO_EXIT;
+}
+
 static ExitStatus op_mvpg(DisasContext *s, DisasOps *o)
 {
     gen_helper_mvpg(cc_op, cpu_env, regs[0], o->in1, o->in2);
-- 
2.11.0
