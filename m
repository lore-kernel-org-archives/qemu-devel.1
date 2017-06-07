Received: from eggs.gnu.org ([2001:4830:134:3::10]:34206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtd-0003Gv-25
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtb-0002Al-Sa
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:25 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtb-0002AU-Ns
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:23 -0400
Received: by mail-qk0-x242.google.com with SMTP id u129so439671qka.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:54 -0700
Message-Id: <20170607003119.14778-46-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 45/70] target/s390x: implement PACK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-7-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  5 +++++
 target/s390x/mem_helper.c  | 37 +++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  8 ++++++++
 4 files changed, 51 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 3f5a05d..c6fbc3b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -75,6 +75,7 @@ DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(sqxb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
+DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 170b50e..f92bfde 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -639,6 +639,11 @@
     C(0x9600, OI,      SI,    Z,   m1_8u, i2_8u, new, m1_8, or, nz64)
     C(0xeb56, OIY,     SIY,   LD,  m1_8u, i2_8u, new, m1_8, or, nz64)
 
+/* PACK */
+    /* Really format SS_b, but we pack both lengths into one argument
+       for the helper call, so we might as well leave one 8-bit field.  */
+    C(0xf200, PACK,    SS_a,  Z,   la1, a2, 0, 0, pack, 0)
+
 /* PREFETCH */
     /* Implemented as nops of course.  */
     C(0xe336, PFD,     RXY_b, GIE, 0, 0, 0, 0, 0, 0)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index ddbebcd..850472e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -644,6 +644,43 @@ uint64_t HELPER(cksm)(CPUS390XState *env, uint64_t r1,
     return len;
 }
 
+void HELPER(pack)(CPUS390XState *env, uint32_t len, uint64_t dest, uint64_t src)
+{
+    uintptr_t ra = GETPC();
+    int len_dest = len >> 4;
+    int len_src = len & 0xf;
+    uint8_t b;
+
+    dest += len_dest;
+    src += len_src;
+
+    /* last byte is special, it only flips the nibbles */
+    b = cpu_ldub_data_ra(env, src, ra);
+    cpu_stb_data_ra(env, dest, (b << 4) | (b >> 4), ra);
+    src--;
+    len_src--;
+
+    /* now pack every value */
+    while (len_dest >= 0) {
+        b = 0;
+
+        if (len_src > 0) {
+            b = cpu_ldub_data_ra(env, src, ra) & 0x0f;
+            src--;
+            len_src--;
+        }
+        if (len_src > 0) {
+            b |= cpu_ldub_data_ra(env, src, ra) << 4;
+            src--;
+            len_src--;
+        }
+
+        len_dest--;
+        dest--;
+        cpu_stb_data_ra(env, dest, b, ra);
+    }
+}
+
 void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
                   uint64_t src)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 854a66a..b3cc349 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3144,6 +3144,14 @@ static ExitStatus op_ori(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_pack(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
+    gen_helper_pack(cpu_env, l, o->addr1, o->in2);
+    tcg_temp_free_i32(l);
+    return NO_EXIT;
+}
+
 static ExitStatus op_popcnt(DisasContext *s, DisasOps *o)
 {
     gen_helper_popcnt(o->out, o->in2);
-- 
2.9.4
