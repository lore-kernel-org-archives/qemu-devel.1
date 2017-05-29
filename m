Received: from eggs.gnu.org ([2001:4830:134:3::10]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHd-0006U5-FL
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-00074a-C6
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHZ-00072F-Vo
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:23 +0200
Message-Id: <20170529192440.5990-13-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 12/29] target/s390x: implement MOVE WITH
 OFFSET
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  4 ++++
 target/s390x/mem_helper.c  | 31 +++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  8 ++++++++
 4 files changed, 44 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a377997df5..e3a438b845 100644
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
index 6af717648c..47542eeaf3 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -584,6 +584,10 @@
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
index 4fb6ff29c3..f748750a55 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -256,6 +256,37 @@ void HELPER(mvn)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
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
index 4e7211203a..b1877cf27b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2998,6 +2998,14 @@ static ExitStatus op_mvn(DisasContext *s, DisasOps *o)
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
