Received: from eggs.gnu.org ([2001:4830:134:3::10]:35829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VO-0006m4-44
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VM-0003cn-Sa
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:14 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VM-0003cO-KR
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:12 -0500
Received: by mail-pf0-x243.google.com with SMTP id 127so31459819pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:12 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:15 -0800
Message-Id: <20170111021820.24416-61-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 60/65] target-i386: Use ctpop helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/cc_helper.c      |  3 +++
 target/i386/cpu.h            |  1 +
 target/i386/ops_sse.h        | 26 --------------------------
 target/i386/ops_sse_header.h |  1 -
 target/i386/translate.c      | 13 +++++++++++--
 5 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/target/i386/cc_helper.c b/target/i386/cc_helper.c
index 83af223..c9c90e1 100644
--- a/target/i386/cc_helper.c
+++ b/target/i386/cc_helper.c
@@ -105,6 +105,8 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
         return src1;
     case CC_OP_CLR:
         return CC_Z | CC_P;
+    case CC_OP_POPCNT:
+        return src1 ? 0 : CC_Z;
 
     case CC_OP_MULB:
         return compute_all_mulb(dst, src1);
@@ -232,6 +234,7 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
     case CC_OP_LOGICL:
     case CC_OP_LOGICQ:
     case CC_OP_CLR:
+    case CC_OP_POPCNT:
         return 0;
 
     case CC_OP_EFLAGS:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a7f2f60..a04e46b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -777,6 +777,7 @@ typedef enum {
     CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
 
     CC_OP_CLR, /* Z set, all other flags clear.  */
+    CC_OP_POPCNT, /* Z via CC_SRC, all other flags clear.  */
 
     CC_OP_NB,
 } CCOp;
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 7a98f53..16509d0 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2157,32 +2157,6 @@ target_ulong helper_crc32(uint32_t crc1, target_ulong msg, uint32_t len)
     return crc;
 }
 
-#define POPMASK(i)     ((target_ulong) -1 / ((1LL << (1 << i)) + 1))
-#define POPCOUNT(n, i) ((n & POPMASK(i)) + ((n >> (1 << i)) & POPMASK(i)))
-target_ulong helper_popcnt(CPUX86State *env, target_ulong n, uint32_t type)
-{
-    CC_SRC = n ? 0 : CC_Z;
-
-    n = POPCOUNT(n, 0);
-    n = POPCOUNT(n, 1);
-    n = POPCOUNT(n, 2);
-    n = POPCOUNT(n, 3);
-    if (type == 1) {
-        return n & 0xff;
-    }
-
-    n = POPCOUNT(n, 4);
-#ifndef TARGET_X86_64
-    return n;
-#else
-    if (type == 2) {
-        return n & 0xff;
-    }
-
-    return POPCOUNT(n, 5);
-#endif
-}
-
 void glue(helper_pclmulqdq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                     uint32_t ctrl)
 {
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 64c5857..094aafc 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -333,7 +333,6 @@ DEF_HELPER_4(glue(pcmpestrm, SUFFIX), void, env, Reg, Reg, i32)
 DEF_HELPER_4(glue(pcmpistri, SUFFIX), void, env, Reg, Reg, i32)
 DEF_HELPER_4(glue(pcmpistrm, SUFFIX), void, env, Reg, Reg, i32)
 DEF_HELPER_3(crc32, tl, i32, tl, i32)
-DEF_HELPER_3(popcnt, tl, env, tl, i32)
 #endif
 
 /* AES-NI op helpers */
diff --git a/target/i386/translate.c b/target/i386/translate.c
index ce9ccb8..5f5e60d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -222,6 +222,7 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_CLR] = 0,
+    [CC_OP_POPCNT] = USES_CC_SRC,
 };
 
 static void set_cc_op(DisasContext *s, CCOp op)
@@ -757,6 +758,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_CLR:
+    case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
 
     case CC_OP_INCB ... CC_OP_INCQ:
@@ -824,6 +826,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
                              .mask = CC_S };
     case CC_OP_CLR:
+    case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
     default:
         {
@@ -843,6 +846,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src2,
                              .mask = -1, .no_setcond = true };
     case CC_OP_CLR:
+    case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
     default:
         gen_compute_eflags(s);
@@ -866,6 +870,9 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
                              .mask = CC_Z };
     case CC_OP_CLR:
         return (CCPrepare) { .cond = TCG_COND_ALWAYS, .mask = -1 };
+    case CC_OP_POPCNT:
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src,
+                             .mask = -1 };
     default:
         {
             TCGMemOp size = (s->cc_op - CC_OP_ADDB) & 3;
@@ -8205,10 +8212,12 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         }
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-        gen_helper_popcnt(cpu_T0, cpu_env, cpu_T0, tcg_const_i32(ot));
+        gen_extu(ot, cpu_T0);
+        tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
+        tcg_gen_ctpop_tl(cpu_T0, cpu_T0);
         gen_op_mov_reg_v(ot, reg, cpu_T0);
 
-        set_cc_op(s, CC_OP_EFLAGS);
+        set_cc_op(s, CC_OP_POPCNT);
         break;
     case 0x10e ... 0x10f:
         /* 3DNow! instructions, ignore prefixes */
-- 
2.9.3
