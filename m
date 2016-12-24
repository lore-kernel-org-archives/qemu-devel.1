Received: from eggs.gnu.org ([2001:4830:134:3::10]:55606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWI-0006uf-Q6
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWH-0005rn-Mj
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:18 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWH-0005rV-Hj
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:17 -0500
Received: by mail-pg0-x242.google.com with SMTP id b1so2475953pgc.1
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:17 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:16 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:16 -0800
Message-Id: <20161224040042.12654-40-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 39/65] target-i386: Use clz and ctz opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/helper.h     |  2 --
 target/i386/int_helper.c | 11 -----------
 target/i386/translate.c  | 31 ++++++++++++++-----------------
 3 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index bd9b2cf..4c1aaff 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -202,8 +202,6 @@ DEF_HELPER_FLAGS_3(xsetbv, TCG_CALL_NO_WG, void, env, i32, i64)
 DEF_HELPER_FLAGS_2(rdpkru, TCG_CALL_NO_WG, i64, env, i32)
 DEF_HELPER_FLAGS_3(wrpkru, TCG_CALL_NO_WG, void, env, i32, i64)
 
-DEF_HELPER_FLAGS_1(clz, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(ctz, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(pdep, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_FLAGS_2(pext, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 
diff --git a/target/i386/int_helper.c b/target/i386/int_helper.c
index 9e873ac..4dc5c65 100644
--- a/target/i386/int_helper.c
+++ b/target/i386/int_helper.c
@@ -417,17 +417,6 @@ void helper_idivq_EAX(CPUX86State *env, target_ulong t0)
 # define clztl  clz64
 #endif
 
-/* bit operations */
-target_ulong helper_ctz(target_ulong t0)
-{
-    return ctztl(t0);
-}
-
-target_ulong helper_clz(target_ulong t0)
-{
-    return clztl(t0);
-}
-
 target_ulong helper_pdep(target_ulong src, target_ulong mask)
 {
     target_ulong dest = 0;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 816d0b1..ce9ccb8 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6807,21 +6807,18 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                 ? s->cpuid_ext3_features & CPUID_EXT3_ABM
                 : s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
             int size = 8 << ot;
+            /* For lzcnt/tzcnt, C bit is defined related to the input. */
             tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
             if (b & 1) {
                 /* For lzcnt, reduce the target_ulong result by the
                    number of zeros that we expect to find at the top.  */
-                gen_helper_clz(cpu_T0, cpu_T0);
+                tcg_gen_clzi_tl(cpu_T0, cpu_T0, TARGET_LONG_BITS);
                 tcg_gen_subi_tl(cpu_T0, cpu_T0, TARGET_LONG_BITS - size);
             } else {
-                /* For tzcnt, a zero input must return the operand size:
-                   force all bits outside the operand size to 1.  */
-                target_ulong mask = (target_ulong)-2 << (size - 1);
-                tcg_gen_ori_tl(cpu_T0, cpu_T0, mask);
-                gen_helper_ctz(cpu_T0, cpu_T0);
-            }
-            /* For lzcnt/tzcnt, C and Z bits are defined and are
-               related to the result.  */
+                /* For tzcnt, a zero input must return the operand size.  */
+                tcg_gen_ctzi_tl(cpu_T0, cpu_T0, size);
+            }
+            /* For lzcnt/tzcnt, Z bit is defined related to the result.  */
             gen_op_update1_cc();
             set_cc_op(s, CC_OP_BMILGB + ot);
         } else {
@@ -6829,20 +6826,20 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                to the input and not the result.  */
             tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
             set_cc_op(s, CC_OP_LOGICB + ot);
+
+            /* ??? The manual says that the output is undefined when the
+               input is zero, but real hardware leaves it unchanged, and
+               real programs appear to depend on that.  Accomplish this
+               by passing the output as the value to return upon zero.  */
             if (b & 1) {
                 /* For bsr, return the bit index of the first 1 bit,
                    not the count of leading zeros.  */
-                gen_helper_clz(cpu_T0, cpu_T0);
+                tcg_gen_xori_tl(cpu_T1, cpu_regs[reg], TARGET_LONG_BITS - 1);
+                tcg_gen_clz_tl(cpu_T0, cpu_T0, cpu_T1);
                 tcg_gen_xori_tl(cpu_T0, cpu_T0, TARGET_LONG_BITS - 1);
             } else {
-                gen_helper_ctz(cpu_T0, cpu_T0);
+                tcg_gen_ctz_tl(cpu_T0, cpu_T0, cpu_regs[reg]);
             }
-            /* ??? The manual says that the output is undefined when the
-               input is zero, but real hardware leaves it unchanged, and
-               real programs appear to depend on that.  */
-            tcg_gen_movi_tl(cpu_tmp0, 0);
-            tcg_gen_movcond_tl(TCG_COND_EQ, cpu_T0, cpu_cc_dst, cpu_tmp0,
-                               cpu_regs[reg], cpu_T0);
         }
         gen_op_mov_reg_v(ot, reg, cpu_T0);
         break;
-- 
2.9.3
