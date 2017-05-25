Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwd-0005gO-Ps
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwb-0001NV-Pn
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:19 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwb-0001Mf-GV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:17 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:05:04 +0200
Message-Id: <20170525210508.4910-23-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 22/26] target/s390x: implement UNPACK ASCII
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
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 17 ++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 1011df122d..ffc0588e83 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -86,6 +86,7 @@ DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
+DEF_HELPER_FLAGS_4(unpka, TCG_CALL_NO_WG, i32, env, i64, i32, i64)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
 DEF_HELPER_4(trt, i32, env, i32, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 3335270182..b0c0ea6687 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -869,6 +869,8 @@
     /* Really format SS_b, but we pack both lengths into one argument
        for the helper call, so we might as well leave one 8-bit field.  */
     C(0xf300, UNPK,    SS_a,  Z,   la1, a2, 0, 0, unpk, 0)
+/* UNPACK ASCII */
+    C(0xea00, UNPKA,   SS_a,  E2,  la1, a2, 0, 0, unpka, 0)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index ab34a309ce..aaabc63000 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1053,6 +1053,57 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
     }
 }
 
+uint32_t HELPER(unpka)(CPUS390XState *env, uint64_t dest, uint32_t destlen,
+                       uint64_t src)
+{
+    uintptr_t ra = GETPC();
+    int i;
+    uint32_t cc;
+    uint8_t b;
+    /* The source operand is always 16 bytes long.  */
+    const int srclen = 16;
+
+    /* The operands are processed from right to left.  */
+    src += srclen - 1;
+    dest += destlen - 1;
+
+    /* Check for the sign.  */
+    b = cpu_ldub_data_ra(env, src, ra);
+    src--;
+    switch (b & 0xf) {
+    case 0xa:
+    case 0xc:
+    case 0xe ... 0xf:
+        cc = 0;  /* plus */
+        break;
+    case 0xb:
+    case 0xd:
+        cc = 1;  /* minus */
+        break;
+    default:
+    case 0x0 ... 0x9:
+        cc = 3;  /* invalid */
+        break;
+    }
+
+    /* Now pad every nibble with 0x30, advancing one nibble at a time. */
+    for (i = 0; i < destlen; i++) {
+        if (i == 31) {
+            /* If length is 32 bytes, the leftmost byte is 0. */
+            b = 0;
+        } else if (i % 2) {
+            b = cpu_ldub_data_ra(env, src, ra);
+            src--;
+        } else {
+            b >>= 4;
+        }
+        cpu_stb_data_ra(env, dest, 0x30 + (b & 0xf), ra);
+        dest--;
+    }
+
+    return cc;
+}
+
 static void do_helper_tr(CPUS390XState *env, uint32_t len, uint64_t array,
                          uint64_t trans, uintptr_t ra)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a2a27c86ea..590ff96301 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4295,6 +4295,23 @@ static ExitStatus op_unpk(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_unpka(DisasContext *s, DisasOps *o)
+{
+    int l1 = get_field(s->fields, l1) + 1;
+    TCGv_i32 l;
+
+    /* The length must not exceed 32 bytes.  */
+    if (l1 > 32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+    l = tcg_const_i32(l1);
+    gen_helper_unpka(cc_op, cpu_env, o->addr1, l, o->in2);
+    tcg_temp_free_i32(l);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_xc(DisasContext *s, DisasOps *o)
 {
     int d1 = get_field(s->fields, d1);
-- 
2.11.0
