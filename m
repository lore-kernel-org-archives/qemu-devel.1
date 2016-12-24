Received: from eggs.gnu.org ([2001:4830:134:3::10]:45447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh9-0007TQ-Kb
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh6-00084V-DD
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:59 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:52487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkh6-00083o-1f
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:56 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:29 +0100
Message-Id: <1482579633-3393-9-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 08/12] target-m68k: Implement 680x0 movem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>

680x0 movem can load/store words and long words and can use more
addressing modes.  Coldfire can only use long words with (Ax) and
(d16,Ax) addressing modes.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1478699171-10637-2-git-send-email-rth@twiddle.net>
---
 target/m68k/translate.c | 130 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 107 insertions(+), 23 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0124820..acc8182 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1645,40 +1645,122 @@ static void gen_push(DisasContext *s, TCGv val)
     tcg_gen_mov_i32(QREG_SP, tmp);
 }
 
+static TCGv mreg(int reg)
+{
+    if (reg < 8) {
+        /* Dx */
+        return cpu_dregs[reg];
+    }
+    /* Ax */
+    return cpu_aregs[reg & 7];
+}
+
 DISAS_INSN(movem)
 {
-    TCGv addr;
+    TCGv addr, incr, tmp, r[16];
+    int is_load = (insn & 0x0400) != 0;
+    int opsize = (insn & 0x40) != 0 ? OS_LONG : OS_WORD;
+    uint16_t mask = read_im16(env, s);
+    int mode = extract32(insn, 3, 3);
+    int reg0 = REG(insn, 0);
     int i;
-    uint16_t mask;
-    TCGv reg;
-    TCGv tmp;
-    int is_load;
 
-    mask = read_im16(env, s);
-    tmp = gen_lea(env, s, insn, OS_LONG);
-    if (IS_NULL_QREG(tmp)) {
+    tmp = cpu_aregs[reg0];
+
+    switch (mode) {
+    case 0: /* data register direct */
+    case 1: /* addr register direct */
+    do_addr_fault:
         gen_addr_fault(s);
         return;
+
+    case 2: /* indirect */
+        break;
+
+    case 3: /* indirect post-increment */
+        if (!is_load) {
+            /* post-increment is not allowed */
+            goto do_addr_fault;
+        }
+        break;
+
+    case 4: /* indirect pre-decrement */
+        if (is_load) {
+            /* pre-decrement is not allowed */
+            goto do_addr_fault;
+        }
+        /* We want a bare copy of the address reg, without any pre-decrement
+           adjustment, as gen_lea would provide.  */
+        break;
+
+    default:
+        tmp = gen_lea_mode(env, s, mode, reg0, opsize);
+        if (IS_NULL_QREG(tmp)) {
+            goto do_addr_fault;
+        }
+        break;
     }
+
     addr = tcg_temp_new();
     tcg_gen_mov_i32(addr, tmp);
-    is_load = ((insn & 0x0400) != 0);
-    for (i = 0; i < 16; i++, mask >>= 1) {
-        if (mask & 1) {
-            if (i < 8)
-                reg = DREG(i, 0);
-            else
-                reg = AREG(i, 0);
-            if (is_load) {
-                tmp = gen_load(s, OS_LONG, addr, 0);
-                tcg_gen_mov_i32(reg, tmp);
-            } else {
-                gen_store(s, OS_LONG, addr, reg);
+    incr = tcg_const_i32(opsize_bytes(opsize));
+
+    if (is_load) {
+        /* memory to register */
+        for (i = 0; i < 16; i++) {
+            if (mask & (1 << i)) {
+                r[i] = gen_load(s, opsize, addr, 1);
+                tcg_gen_add_i32(addr, addr, incr);
+            }
+        }
+        for (i = 0; i < 16; i++) {
+            if (mask & (1 << i)) {
+                tcg_gen_mov_i32(mreg(i), r[i]);
+                tcg_temp_free(r[i]);
+            }
+        }
+        if (mode == 3) {
+            /* post-increment: movem (An)+,X */
+            tcg_gen_mov_i32(cpu_aregs[reg0], addr);
+        }
+    } else {
+        /* register to memory */
+        if (mode == 4) {
+            /* pre-decrement: movem X,-(An) */
+            for (i = 15; i >= 0; i--) {
+                if ((mask << i) & 0x8000) {
+                    tcg_gen_sub_i32(addr, addr, incr);
+                    if (reg0 + 8 == i &&
+                        m68k_feature(s->env, M68K_FEATURE_EXT_FULL)) {
+                        /* M68020+: if the addressing register is the
+                         * register moved to memory, the value written
+                         * is the initial value decremented by the size of
+                         * the operation, regardless of how many actual
+                         * stores have been performed until this point.
+                         * M68000/M68010: the value is the initial value.
+                         */
+                        tmp = tcg_temp_new();
+                        tcg_gen_sub_i32(tmp, cpu_aregs[reg0], incr);
+                        gen_store(s, opsize, addr, tmp);
+                        tcg_temp_free(tmp);
+                    } else {
+                        gen_store(s, opsize, addr, mreg(i));
+                    }
+                }
+            }
+            tcg_gen_mov_i32(cpu_aregs[reg0], addr);
+        } else {
+            for (i = 0; i < 16; i++) {
+                if (mask & (1 << i)) {
+                    gen_store(s, opsize, addr, mreg(i));
+                    tcg_gen_add_i32(addr, addr, incr);
+                }
             }
-            if (mask != 1)
-                tcg_gen_addi_i32(addr, addr, 4);
         }
     }
+
+    tcg_temp_free(incr);
+    tcg_temp_free(addr);
 }
 
 DISAS_INSN(bitop_im)
@@ -3822,7 +3904,9 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(pea,       4840, ffc0);
     BASE(swap,      4840, fff8);
     INSN(bkpt,      4848, fff8, BKPT);
-    BASE(movem,     48c0, fbc0);
+    INSN(movem,     48d0, fbf8, CF_ISA_A);
+    INSN(movem,     48e8, fbf8, CF_ISA_A);
+    INSN(movem,     4880, fb80, M68000);
     BASE(ext,       4880, fff8);
     BASE(ext,       48c0, fff8);
     BASE(ext,       49c0, fff8);
-- 
2.7.4
