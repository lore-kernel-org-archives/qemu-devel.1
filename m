Received: from eggs.gnu.org ([2001:4830:134:3::10]:38041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgif-0002Dx-3K
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgia-0007kk-A6
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:32 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgiZ-0007kg-VO
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:28 -0500
Received: by mail-pg0-x244.google.com with SMTP id 204so16792765pge.2
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:52:27 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:40 -0800
Message-Id: <20170209045154.16868-9-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 08/22] target/openrisc: Streamline arithmetic
 and OVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Fix incorrect overflow calculation.  Move overflow exception check
to a helper function, to eliminate inline branches.  Remove some
incorrect special casing of R0.  Implement multiply inline.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/Makefile.objs      |   2 +-
 target/openrisc/exception_helper.c |  12 ++
 target/openrisc/helper.h           |   4 +-
 target/openrisc/int_helper.c       |  61 ------
 target/openrisc/translate.c        | 426 +++++++++++++++----------------------
 5 files changed, 191 insertions(+), 314 deletions(-)
 delete mode 100644 target/openrisc/int_helper.c

diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
index 397d016..918b1c6 100644
--- a/target/openrisc/Makefile.objs
+++ b/target/openrisc/Makefile.objs
@@ -1,5 +1,5 @@
 obj-$(CONFIG_SOFTMMU) += machine.o
 obj-y += cpu.o exception.o interrupt.o mmu.o translate.o
-obj-y += exception_helper.o fpu_helper.o int_helper.o \
+obj-y += exception_helper.o fpu_helper.o \
          interrupt_helper.o mmu_helper.o sys_helper.o
 obj-y += gdbstub.o
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index 329a9e4..7e54c97 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "exec/exec-all.h"
 #include "exception.h"
 
 void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
@@ -28,3 +29,14 @@ void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
 
     raise_exception(cpu, excp);
 }
+
+void HELPER(ove)(CPUOpenRISCState *env, target_ulong test)
+{
+    if (unlikely(test) && (env->sr & SR_OVE)) {
+        OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
+        CPUState *cs = CPU(cpu);
+
+        cs->exception_index = EXCP_RANGE;
+        cpu_loop_exit_restore(cs, GETPC());
+    }
+}
diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index bcc7245..c2c8098 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -19,6 +19,7 @@
 
 /* exception */
 DEF_HELPER_FLAGS_2(exception, 0, void, env, i32)
+DEF_HELPER_FLAGS_2(ove, TCG_CALL_NO_WG, void, env, tl)
 
 /* float */
 DEF_HELPER_FLAGS_2(itofd, 0, i64, env, i64)
@@ -53,9 +54,6 @@ FOP_CMP(gt)
 FOP_CMP(ge)
 #undef FOP_CMP
 
-/* int */
-DEF_HELPER_FLAGS_3(mul32, 0, i32, env, i32, i32)
-
 /* interrupt */
 DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 
diff --git a/target/openrisc/int_helper.c b/target/openrisc/int_helper.c
deleted file mode 100644
index ba0fd27..0000000
--- a/target/openrisc/int_helper.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * OpenRISC int helper routines
- *
- * Copyright (c) 2011-2012 Jia Liu <proljc@gmail.com>
- *                         Feng Gao <gf91597@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "exec/helper-proto.h"
-#include "exception.h"
-#include "qemu/host-utils.h"
-
-uint32_t HELPER(mul32)(CPUOpenRISCState *env,
-                       uint32_t ra, uint32_t rb)
-{
-    uint64_t result;
-    uint32_t high, cy;
-
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-
-    result = (uint64_t)ra * rb;
-    /* regisiers in or32 is 32bit, so 32 is NOT a magic number.
-       or64 is not handled in this function, and not implement yet,
-       TARGET_LONG_BITS for or64 is 64, it will break this function,
-       so, we didn't use TARGET_LONG_BITS here.  */
-    high = result >> 32;
-    cy = result >> (32 - 1);
-
-    if ((cy & 0x1) == 0x0) {
-        if (high == 0x0) {
-            return result;
-        }
-    }
-
-    if ((cy & 0x1) == 0x1) {
-        if (high == 0xffffffff) {
-            return result;
-        }
-    }
-
-    cpu->env.sr |= (SR_OV | SR_CY);
-    if (cpu->env.sr & SR_OVE) {
-        raise_exception(cpu, EXCP_RANGE);
-    }
-
-    return result;
-}
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index d999d2f..7c6cd1c 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -247,6 +247,166 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
     gen_sync_flags(dc);
 }
 
+static void gen_ove_cy(DisasContext *dc, TCGv cy)
+{
+    gen_helper_ove(cpu_env, cy);
+}
+
+static void gen_ove_ov(DisasContext *dc, TCGv ov)
+{
+    gen_helper_ove(cpu_env, ov);
+}
+
+static void gen_ove_cyov(DisasContext *dc, TCGv cy, TCGv ov)
+{
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_or_tl(t0, cy, ov);
+    gen_helper_ove(cpu_env, t0);
+    tcg_temp_free(t0);
+}
+
+static void gen_add(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+{
+    TCGv t0 = tcg_const_tl(0);
+    TCGv res = tcg_temp_new();
+    TCGv sr_cy = tcg_temp_new();
+    TCGv sr_ov = tcg_temp_new();
+
+    tcg_gen_add2_tl(res, sr_cy, srca, t0, srcb, t0);
+    tcg_gen_xor_tl(sr_ov, srca, srcb);
+    tcg_gen_xor_tl(t0, res, srcb);
+    tcg_gen_andc_tl(sr_ov, t0, sr_ov);
+    tcg_temp_free(t0);
+
+    tcg_gen_mov_tl(dest, res);
+    tcg_temp_free(res);
+
+    tcg_gen_shri_tl(sr_ov, sr_ov, TARGET_LONG_BITS - 1);
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
+
+    gen_ove_cyov(dc, sr_ov, sr_cy);
+    tcg_temp_free(sr_ov);
+    tcg_temp_free(sr_cy);
+}
+
+static void gen_addc(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+{
+    TCGv t0 = tcg_const_tl(0);
+    TCGv res = tcg_temp_new();
+    TCGv sr_cy = tcg_temp_new();
+    TCGv sr_ov = tcg_temp_new();
+
+    tcg_gen_shri_tl(sr_cy, cpu_sr, ctz32(SR_CY));
+    tcg_gen_andi_tl(sr_cy, sr_cy, 1);
+
+    tcg_gen_add2_tl(res, sr_cy, srca, t0, sr_cy, t0);
+    tcg_gen_add2_tl(res, sr_cy, res, sr_cy, srcb, t0);
+    tcg_gen_xor_tl(sr_ov, srca, srcb);
+    tcg_gen_xor_tl(t0, res, srcb);
+    tcg_gen_andc_tl(sr_ov, t0, sr_ov);
+    tcg_temp_free(t0);
+
+    tcg_gen_mov_tl(dest, res);
+    tcg_temp_free(res);
+
+    tcg_gen_shri_tl(sr_ov, sr_ov, TARGET_LONG_BITS - 1);
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
+
+    gen_ove_cyov(dc, sr_ov, sr_cy);
+    tcg_temp_free(sr_ov);
+    tcg_temp_free(sr_cy);
+}
+
+static void gen_sub(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+{
+    TCGv res = tcg_temp_new();
+    TCGv sr_cy = tcg_temp_new();
+    TCGv sr_ov = tcg_temp_new();
+
+    tcg_gen_sub_tl(res, srca, srcb);
+    tcg_gen_xor_tl(sr_cy, srca, srcb);
+    tcg_gen_xor_tl(sr_ov, res, srcb);
+    tcg_gen_and_tl(sr_ov, sr_ov, sr_cy);
+    tcg_gen_setcond_tl(TCG_COND_LTU, sr_cy, srca, srcb);
+
+    tcg_gen_mov_tl(dest, res);
+    tcg_temp_free(res);
+
+    tcg_gen_shri_tl(sr_ov, sr_ov, TARGET_LONG_BITS - 1);
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
+
+    gen_ove_cyov(dc, sr_ov, sr_cy);
+    tcg_temp_free(sr_ov);
+    tcg_temp_free(sr_cy);
+}
+
+static void gen_mul(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+{
+    TCGv sr_ov = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+
+    tcg_gen_muls2_tl(dest, sr_ov, srca, srcb);
+    tcg_gen_sari_tl(t0, dest, TARGET_LONG_BITS - 1);
+    tcg_gen_setcond_tl(TCG_COND_NE, sr_ov, sr_ov, t0);
+    tcg_temp_free(t0);
+
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
+
+    gen_ove_ov(dc, sr_ov);
+    tcg_temp_free(sr_ov);
+}
+
+static void gen_mulu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+{
+    TCGv sr_cy = tcg_temp_new();
+
+    tcg_gen_muls2_tl(dest, sr_cy, srca, srcb);
+    tcg_gen_setcondi_tl(TCG_COND_NE, sr_cy, sr_cy, 0);
+
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
+
+    gen_ove_cy(dc, sr_cy);
+    tcg_temp_free(sr_cy);
+}
+
+static void gen_div(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+{
+    TCGv sr_ov = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+
+    tcg_gen_setcondi_tl(TCG_COND_EQ, sr_ov, srcb, 0);
+    /* The result of divide-by-zero is undefined.
+       Supress the host-side exception by dividing by 1.  */
+    tcg_gen_or_tl(t0, srcb, sr_ov);
+    tcg_gen_div_tl(dest, srca, t0);
+    tcg_temp_free(t0);
+
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_ov, ctz32(SR_OV), 1);
+
+    gen_ove_ov(dc, sr_ov);
+    tcg_temp_free(sr_ov);
+}
+
+static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+{
+    TCGv sr_cy = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+
+    tcg_gen_setcondi_tl(TCG_COND_EQ, sr_cy, srcb, 0);
+    /* The result of divide-by-zero is undefined.
+       Supress the host-side exception by dividing by 1.  */
+    tcg_gen_or_tl(t0, srcb, sr_cy);
+    tcg_gen_divu_tl(dest, srca, t0);
+    tcg_temp_free(t0);
+
+    tcg_gen_deposit_tl(cpu_sr, cpu_sr, sr_cy, ctz32(SR_CY), 1);
+
+    gen_ove_cy(dc, sr_cy);
+    tcg_temp_free(sr_cy);
+}
 
 static void gen_lwa(DisasContext *dc, TCGv rd, TCGv ra, int32_t ofs)
 {
@@ -304,34 +464,7 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x00:    /* l.add */
             LOG_DIS("l.add r%d, r%d, r%d\n", rd, ra, rb);
-            {
-                TCGLabel *lab = gen_new_label();
-                TCGv_i64 ta = tcg_temp_new_i64();
-                TCGv_i64 tb = tcg_temp_new_i64();
-                TCGv_i64 td = tcg_temp_local_new_i64();
-                TCGv_i32 res = tcg_temp_local_new_i32();
-                TCGv_i32 sr_ove = tcg_temp_local_new_i32();
-                tcg_gen_extu_i32_i64(ta, cpu_R[ra]);
-                tcg_gen_extu_i32_i64(tb, cpu_R[rb]);
-                tcg_gen_add_i64(td, ta, tb);
-                tcg_gen_extrl_i64_i32(res, td);
-                tcg_gen_shri_i64(td, td, 31);
-                tcg_gen_andi_i64(td, td, 0x3);
-                /* Jump to lab when no overflow.  */
-                tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x0, lab);
-                tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x3, lab);
-                tcg_gen_ori_i32(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                tcg_gen_andi_i32(sr_ove, cpu_sr, SR_OVE);
-                tcg_gen_brcondi_i32(TCG_COND_NE, sr_ove, SR_OVE, lab);
-                gen_exception(dc, EXCP_RANGE);
-                gen_set_label(lab);
-                tcg_gen_mov_i32(cpu_R[rd], res);
-                tcg_temp_free_i64(ta);
-                tcg_temp_free_i64(tb);
-                tcg_temp_free_i64(td);
-                tcg_temp_free_i32(res);
-                tcg_temp_free_i32(sr_ove);
-            }
+            gen_add(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             break;
         default:
             gen_illegal_exception(dc);
@@ -343,42 +476,7 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x00:
             LOG_DIS("l.addc r%d, r%d, r%d\n", rd, ra, rb);
-            {
-                TCGLabel *lab = gen_new_label();
-                TCGv_i64 ta = tcg_temp_new_i64();
-                TCGv_i64 tb = tcg_temp_new_i64();
-                TCGv_i64 tcy = tcg_temp_local_new_i64();
-                TCGv_i64 td = tcg_temp_local_new_i64();
-                TCGv_i32 res = tcg_temp_local_new_i32();
-                TCGv_i32 sr_cy = tcg_temp_local_new_i32();
-                TCGv_i32 sr_ove = tcg_temp_local_new_i32();
-                tcg_gen_extu_i32_i64(ta, cpu_R[ra]);
-                tcg_gen_extu_i32_i64(tb, cpu_R[rb]);
-                tcg_gen_andi_i32(sr_cy, cpu_sr, SR_CY);
-                tcg_gen_extu_i32_i64(tcy, sr_cy);
-                tcg_gen_shri_i64(tcy, tcy, 10);
-                tcg_gen_add_i64(td, ta, tb);
-                tcg_gen_add_i64(td, td, tcy);
-                tcg_gen_extrl_i64_i32(res, td);
-                tcg_gen_shri_i64(td, td, 32);
-                tcg_gen_andi_i64(td, td, 0x3);
-                /* Jump to lab when no overflow.  */
-                tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x0, lab);
-                tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x3, lab);
-                tcg_gen_ori_i32(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                tcg_gen_andi_i32(sr_ove, cpu_sr, SR_OVE);
-                tcg_gen_brcondi_i32(TCG_COND_NE, sr_ove, SR_OVE, lab);
-                gen_exception(dc, EXCP_RANGE);
-                gen_set_label(lab);
-                tcg_gen_mov_i32(cpu_R[rd], res);
-                tcg_temp_free_i64(ta);
-                tcg_temp_free_i64(tb);
-                tcg_temp_free_i64(tcy);
-                tcg_temp_free_i64(td);
-                tcg_temp_free_i32(res);
-                tcg_temp_free_i32(sr_cy);
-                tcg_temp_free_i32(sr_ove);
-            }
+            gen_addc(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             break;
         default:
             gen_illegal_exception(dc);
@@ -390,35 +488,7 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x00:
             LOG_DIS("l.sub r%d, r%d, r%d\n", rd, ra, rb);
-            {
-                TCGLabel *lab = gen_new_label();
-                TCGv_i64 ta = tcg_temp_new_i64();
-                TCGv_i64 tb = tcg_temp_new_i64();
-                TCGv_i64 td = tcg_temp_local_new_i64();
-                TCGv_i32 res = tcg_temp_local_new_i32();
-                TCGv_i32 sr_ove = tcg_temp_local_new_i32();
-
-                tcg_gen_extu_i32_i64(ta, cpu_R[ra]);
-                tcg_gen_extu_i32_i64(tb, cpu_R[rb]);
-                tcg_gen_sub_i64(td, ta, tb);
-                tcg_gen_extrl_i64_i32(res, td);
-                tcg_gen_shri_i64(td, td, 31);
-                tcg_gen_andi_i64(td, td, 0x3);
-                /* Jump to lab when no overflow.  */
-                tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x0, lab);
-                tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x3, lab);
-                tcg_gen_ori_i32(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                tcg_gen_andi_i32(sr_ove, cpu_sr, SR_OVE);
-                tcg_gen_brcondi_i32(TCG_COND_NE, sr_ove, SR_OVE, lab);
-                gen_exception(dc, EXCP_RANGE);
-                gen_set_label(lab);
-                tcg_gen_mov_i32(cpu_R[rd], res);
-                tcg_temp_free_i64(ta);
-                tcg_temp_free_i64(tb);
-                tcg_temp_free_i64(td);
-                tcg_temp_free_i32(res);
-                tcg_temp_free_i32(sr_ove);
-            }
+            gen_sub(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             break;
         default:
             gen_illegal_exception(dc);
@@ -466,11 +536,7 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x03:    /* l.mul */
             LOG_DIS("l.mul r%d, r%d, r%d\n", rd, ra, rb);
-            if (ra != 0 && rb != 0) {
-                gen_helper_mul32(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
-            } else {
-                tcg_gen_movi_tl(cpu_R[rd], 0x0);
-            }
+            gen_mul(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             break;
         default:
             gen_illegal_exception(dc);
@@ -482,36 +548,7 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x03:    /* l.div */
             LOG_DIS("l.div r%d, r%d, r%d\n", rd, ra, rb);
-            {
-                TCGLabel *lab0 = gen_new_label();
-                TCGLabel *lab1 = gen_new_label();
-                TCGLabel *lab2 = gen_new_label();
-                TCGLabel *lab3 = gen_new_label();
-                TCGv_i32 sr_ove = tcg_temp_local_new_i32();
-                if (rb == 0) {
-                    tcg_gen_ori_tl(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                    tcg_gen_andi_tl(sr_ove, cpu_sr, SR_OVE);
-                    tcg_gen_brcondi_tl(TCG_COND_NE, sr_ove, SR_OVE, lab0);
-                    gen_exception(dc, EXCP_RANGE);
-                    gen_set_label(lab0);
-                } else {
-                    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_R[rb],
-                                       0x00000000, lab1);
-                    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_R[ra],
-                                       0x80000000, lab2);
-                    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_R[rb],
-                                       0xffffffff, lab2);
-                    gen_set_label(lab1);
-                    tcg_gen_ori_tl(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                    tcg_gen_andi_tl(sr_ove, cpu_sr, SR_OVE);
-                    tcg_gen_brcondi_tl(TCG_COND_NE, sr_ove, SR_OVE, lab3);
-                    gen_exception(dc, EXCP_RANGE);
-                    gen_set_label(lab2);
-                    tcg_gen_div_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                    gen_set_label(lab3);
-                }
-                tcg_temp_free_i32(sr_ove);
-            }
+            gen_div(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             break;
 
         default:
@@ -524,30 +561,7 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x03:    /* l.divu */
             LOG_DIS("l.divu r%d, r%d, r%d\n", rd, ra, rb);
-            {
-                TCGLabel *lab0 = gen_new_label();
-                TCGLabel *lab1 = gen_new_label();
-                TCGLabel *lab2 = gen_new_label();
-                TCGv_i32 sr_ove = tcg_temp_local_new_i32();
-                if (rb == 0) {
-                    tcg_gen_ori_tl(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                    tcg_gen_andi_tl(sr_ove, cpu_sr, SR_OVE);
-                    tcg_gen_brcondi_tl(TCG_COND_NE, sr_ove, SR_OVE, lab0);
-                    gen_exception(dc, EXCP_RANGE);
-                    gen_set_label(lab0);
-                } else {
-                    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_R[rb],
-                                       0x00000000, lab1);
-                    tcg_gen_ori_tl(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                    tcg_gen_andi_tl(sr_ove, cpu_sr, SR_OVE);
-                    tcg_gen_brcondi_tl(TCG_COND_NE, sr_ove, SR_OVE, lab2);
-                    gen_exception(dc, EXCP_RANGE);
-                    gen_set_label(lab1);
-                    tcg_gen_divu_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                    gen_set_label(lab2);
-                }
-                tcg_temp_free_i32(sr_ove);
-            }
+            gen_divu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             break;
 
         default:
@@ -560,34 +574,7 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x03:    /* l.mulu */
             LOG_DIS("l.mulu r%d, r%d, r%d\n", rd, ra, rb);
-            if (rb != 0 && ra != 0) {
-                TCGv_i64 result = tcg_temp_local_new_i64();
-                TCGv_i64 tra = tcg_temp_local_new_i64();
-                TCGv_i64 trb = tcg_temp_local_new_i64();
-                TCGv_i64 high = tcg_temp_new_i64();
-                TCGv_i32 sr_ove = tcg_temp_local_new_i32();
-                TCGLabel *lab = gen_new_label();
-                /* Calculate each result. */
-                tcg_gen_extu_i32_i64(tra, cpu_R[ra]);
-                tcg_gen_extu_i32_i64(trb, cpu_R[rb]);
-                tcg_gen_mul_i64(result, tra, trb);
-                tcg_temp_free_i64(tra);
-                tcg_temp_free_i64(trb);
-                tcg_gen_shri_i64(high, result, TARGET_LONG_BITS);
-                /* Overflow or not. */
-                tcg_gen_brcondi_i64(TCG_COND_EQ, high, 0x00000000, lab);
-                tcg_gen_ori_tl(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                tcg_gen_andi_tl(sr_ove, cpu_sr, SR_OVE);
-                tcg_gen_brcondi_tl(TCG_COND_NE, sr_ove, SR_OVE, lab);
-                gen_exception(dc, EXCP_RANGE);
-                gen_set_label(lab);
-                tcg_temp_free_i64(high);
-                tcg_gen_trunc_i64_tl(cpu_R[rd], result);
-                tcg_temp_free_i64(result);
-                tcg_temp_free_i32(sr_ove);
-            } else {
-                tcg_gen_movi_tl(cpu_R[rd], 0);
-            }
+            gen_mulu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             break;
 
         default:
@@ -744,6 +731,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
     uint32_t L6, K5, K16, K5_11;
     int32_t I16, I5_11, N26;
     TCGMemOp mop;
+    TCGv t0;
 
     op0 = extract32(insn, 26, 6);
     op1 = extract32(insn, 24, 2);
@@ -925,72 +913,16 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 
     case 0x27:    /* l.addi */
         LOG_DIS("l.addi r%d, r%d, %d\n", rd, ra, I16);
-        {
-            if (I16 == 0) {
-                tcg_gen_mov_tl(cpu_R[rd], cpu_R[ra]);
-            } else {
-                TCGLabel *lab = gen_new_label();
-                TCGv_i64 ta = tcg_temp_new_i64();
-                TCGv_i64 td = tcg_temp_local_new_i64();
-                TCGv_i32 res = tcg_temp_local_new_i32();
-                TCGv_i32 sr_ove = tcg_temp_local_new_i32();
-                tcg_gen_extu_i32_i64(ta, cpu_R[ra]);
-                tcg_gen_addi_i64(td, ta, I16);
-                tcg_gen_extrl_i64_i32(res, td);
-                tcg_gen_shri_i64(td, td, 32);
-                tcg_gen_andi_i64(td, td, 0x3);
-                /* Jump to lab when no overflow.  */
-                tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x0, lab);
-                tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x3, lab);
-                tcg_gen_ori_i32(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-                tcg_gen_andi_i32(sr_ove, cpu_sr, SR_OVE);
-                tcg_gen_brcondi_i32(TCG_COND_NE, sr_ove, SR_OVE, lab);
-                gen_exception(dc, EXCP_RANGE);
-                gen_set_label(lab);
-                tcg_gen_mov_i32(cpu_R[rd], res);
-                tcg_temp_free_i64(ta);
-                tcg_temp_free_i64(td);
-                tcg_temp_free_i32(res);
-                tcg_temp_free_i32(sr_ove);
-            }
-        }
+        t0 = tcg_const_tl(I16);
+        gen_add(dc, cpu_R[rd], cpu_R[ra], t0);
+        tcg_temp_free(t0);
         break;
 
     case 0x28:    /* l.addic */
         LOG_DIS("l.addic r%d, r%d, %d\n", rd, ra, I16);
-        {
-            TCGLabel *lab = gen_new_label();
-            TCGv_i64 ta = tcg_temp_new_i64();
-            TCGv_i64 td = tcg_temp_local_new_i64();
-            TCGv_i64 tcy = tcg_temp_local_new_i64();
-            TCGv_i32 res = tcg_temp_local_new_i32();
-            TCGv_i32 sr_cy = tcg_temp_local_new_i32();
-            TCGv_i32 sr_ove = tcg_temp_local_new_i32();
-            tcg_gen_extu_i32_i64(ta, cpu_R[ra]);
-            tcg_gen_andi_i32(sr_cy, cpu_sr, SR_CY);
-            tcg_gen_shri_i32(sr_cy, sr_cy, 10);
-            tcg_gen_extu_i32_i64(tcy, sr_cy);
-            tcg_gen_addi_i64(td, ta, I16);
-            tcg_gen_add_i64(td, td, tcy);
-            tcg_gen_extrl_i64_i32(res, td);
-            tcg_gen_shri_i64(td, td, 32);
-            tcg_gen_andi_i64(td, td, 0x3);
-            /* Jump to lab when no overflow.  */
-            tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x0, lab);
-            tcg_gen_brcondi_i64(TCG_COND_EQ, td, 0x3, lab);
-            tcg_gen_ori_i32(cpu_sr, cpu_sr, (SR_OV | SR_CY));
-            tcg_gen_andi_i32(sr_ove, cpu_sr, SR_OVE);
-            tcg_gen_brcondi_i32(TCG_COND_NE, sr_ove, SR_OVE, lab);
-            gen_exception(dc, EXCP_RANGE);
-            gen_set_label(lab);
-            tcg_gen_mov_i32(cpu_R[rd], res);
-            tcg_temp_free_i64(ta);
-            tcg_temp_free_i64(td);
-            tcg_temp_free_i64(tcy);
-            tcg_temp_free_i32(res);
-            tcg_temp_free_i32(sr_cy);
-            tcg_temp_free_i32(sr_ove);
-        }
+        t0 = tcg_const_tl(I16);
+        gen_addc(dc, cpu_R[rd], cpu_R[ra], t0);
+        tcg_temp_free(t0);
         break;
 
     case 0x29:    /* l.andi */
@@ -1010,13 +942,9 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 
     case 0x2c:    /* l.muli */
         LOG_DIS("l.muli r%d, r%d, %d\n", rd, ra, I16);
-        if (ra != 0 && I16 != 0) {
-            TCGv_i32 im = tcg_const_i32(I16);
-            gen_helper_mul32(cpu_R[rd], cpu_env, cpu_R[ra], im);
-            tcg_temp_free_i32(im);
-        } else {
-            tcg_gen_movi_tl(cpu_R[rd], 0x0);
-        }
+        t0 = tcg_const_tl(I16);
+        gen_mul(dc, cpu_R[rd], cpu_R[ra], t0);
+        tcg_temp_free(t0);
         break;
 
     case 0x2d:    /* l.mfspr */
-- 
2.9.3
