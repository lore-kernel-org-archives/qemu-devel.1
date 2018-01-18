Received: from eggs.gnu.org ([2001:4830:134:3::10]:57395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecG1m-0004dC-SG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecG1i-0000yo-Qy
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:39:10 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:52960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ecG1i-0000xu-ED
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:39:06 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 18 Jan 2018 20:38:43 +0100
Message-Id: <20180118193846.24953-5-laurent@vivier.eu>
In-Reply-To: <20180118193846.24953-1-laurent@vivier.eu>
References: <20180118193846.24953-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 4/7] target/m68k: add index parameter to
 gen_load()/gen_store() and Co.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <huth@tuxfamily.org>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>

The instruction "moves" can select source and destination
address space (user or kernel). This patch modifies
all the load/store functions to be able to provide
the address space the caller wants to use instead
of using the current one. All the callers are modified
to provide the default address space to these functions.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: fix checkpatch.pl errors/warnings
v2: new patch in the series
    needed by "add moves" to pass the MMU index
    to gen_load()/gen_store().

 target/m68k/translate.c | 125 +++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 59 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index af70825480..00a5bce6a3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -281,10 +281,10 @@ static inline void gen_addr_fault(DisasContext *s)
 
 /* Generate a load from the specified address.  Narrow values are
    sign extended to full register width.  */
-static inline TCGv gen_load(DisasContext * s, int opsize, TCGv addr, int sign)
+static inline TCGv gen_load(DisasContext *s, int opsize, TCGv addr,
+                            int sign, int index)
 {
     TCGv tmp;
-    int index = IS_USER(s);
     tmp = tcg_temp_new_i32();
     switch(opsize) {
     case OS_BYTE:
@@ -309,9 +309,9 @@ static inline TCGv gen_load(DisasContext * s, int opsize, TCGv addr, int sign)
 }
 
 /* Generate a store.  */
-static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val)
+static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val,
+                             int index)
 {
-    int index = IS_USER(s);
     switch(opsize) {
     case OS_BYTE:
         tcg_gen_qemu_st8(val, addr, index);
@@ -336,13 +336,13 @@ typedef enum {
 /* Generate an unsigned load if VAL is 0 a signed load if val is -1,
    otherwise generate a store.  */
 static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
-                     ea_what what)
+                     ea_what what, int index)
 {
     if (what == EA_STORE) {
-        gen_store(s, opsize, addr, val);
+        gen_store(s, opsize, addr, val, index);
         return store_dummy;
     } else {
-        return gen_load(s, opsize, addr, what == EA_LOADS);
+        return gen_load(s, opsize, addr, what == EA_LOADS, index);
     }
 }
 
@@ -464,7 +464,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         }
         if ((ext & 3) != 0) {
             /* memory indirect */
-            base = gen_load(s, OS_LONG, add, 0);
+            base = gen_load(s, OS_LONG, add, 0, IS_USER(s));
             if ((ext & 0x44) == 4) {
                 add = gen_addr_index(s, ext, tmp);
                 tcg_gen_add_i32(tmp, add, base);
@@ -793,7 +793,8 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
    a write otherwise it is a read (0 == sign extend, -1 == zero extend).
    ADDRP is non-null for readwrite operands.  */
 static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
-                        int opsize, TCGv val, TCGv *addrp, ea_what what)
+                        int opsize, TCGv val, TCGv *addrp, ea_what what,
+                        int index)
 {
     TCGv reg, tmp, result;
     int32_t offset;
@@ -817,10 +818,10 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
         }
     case 2: /* Indirect register */
         reg = get_areg(s, reg0);
-        return gen_ldst(s, opsize, reg, val, what);
+        return gen_ldst(s, opsize, reg, val, what, index);
     case 3: /* Indirect postincrement.  */
         reg = get_areg(s, reg0);
-        result = gen_ldst(s, opsize, reg, val, what);
+        result = gen_ldst(s, opsize, reg, val, what, index);
         if (what == EA_STORE || !addrp) {
             TCGv tmp = tcg_temp_new();
             if (reg0 == 7 && opsize == OS_BYTE &&
@@ -844,7 +845,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
                 *addrp = tmp;
             }
         }
-        result = gen_ldst(s, opsize, tmp, val, what);
+        result = gen_ldst(s, opsize, tmp, val, what, index);
         if (what == EA_STORE || !addrp) {
             delay_set_areg(s, reg0, tmp, false);
         }
@@ -863,7 +864,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
                 *addrp = tmp;
             }
         }
-        return gen_ldst(s, opsize, tmp, val, what);
+        return gen_ldst(s, opsize, tmp, val, what, index);
     case 7: /* Other */
         switch (reg0) {
         case 0: /* Absolute short.  */
@@ -904,11 +905,11 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
 }
 
 static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                   int opsize, TCGv val, TCGv *addrp, ea_what what)
+                   int opsize, TCGv val, TCGv *addrp, ea_what what, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what);
+    return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what, index);
 }
 
 static TCGv_ptr gen_fp_ptr(int freg)
@@ -941,11 +942,11 @@ static void gen_fp_move(TCGv_ptr dest, TCGv_ptr src)
     tcg_temp_free_i64(t64);
 }
 
-static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
+static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
+                        int index)
 {
     TCGv tmp;
     TCGv_i64 t64;
-    int index = IS_USER(s);
 
     t64 = tcg_temp_new_i64();
     tmp = tcg_temp_new();
@@ -996,11 +997,11 @@ static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
     tcg_temp_free_i64(t64);
 }
 
-static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
+static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
+                         int index)
 {
     TCGv tmp;
     TCGv_i64 t64;
-    int index = IS_USER(s);
 
     t64 = tcg_temp_new_i64();
     tmp = tcg_temp_new();
@@ -1051,17 +1052,18 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
 }
 
 static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
-                        TCGv_ptr fp, ea_what what)
+                        TCGv_ptr fp, ea_what what, int index)
 {
     if (what == EA_STORE) {
-        gen_store_fp(s, opsize, addr, fp);
+        gen_store_fp(s, opsize, addr, fp, index);
     } else {
-        gen_load_fp(s, opsize, addr, fp);
+        gen_load_fp(s, opsize, addr, fp, index);
     }
 }
 
 static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
-                          int reg0, int opsize, TCGv_ptr fp, ea_what what)
+                          int reg0, int opsize, TCGv_ptr fp, ea_what what,
+                          int index)
 {
     TCGv reg, addr, tmp;
     TCGv_i64 t64;
@@ -1109,11 +1111,11 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
         return -1;
     case 2: /* Indirect register */
         addr = get_areg(s, reg0);
-        gen_ldst_fp(s, opsize, addr, fp, what);
+        gen_ldst_fp(s, opsize, addr, fp, what, index);
         return 0;
     case 3: /* Indirect postincrement.  */
         addr = cpu_aregs[reg0];
-        gen_ldst_fp(s, opsize, addr, fp, what);
+        gen_ldst_fp(s, opsize, addr, fp, what, index);
         tcg_gen_addi_i32(addr, addr, opsize_bytes(opsize));
         return 0;
     case 4: /* Indirect predecrememnt.  */
@@ -1121,7 +1123,7 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
         if (IS_NULL_QREG(addr)) {
             return -1;
         }
-        gen_ldst_fp(s, opsize, addr, fp, what);
+        gen_ldst_fp(s, opsize, addr, fp, what, index);
         tcg_gen_mov_i32(cpu_aregs[reg0], addr);
         return 0;
     case 5: /* Indirect displacement.  */
@@ -1131,7 +1133,7 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
         if (IS_NULL_QREG(addr)) {
             return -1;
         }
-        gen_ldst_fp(s, opsize, addr, fp, what);
+        gen_ldst_fp(s, opsize, addr, fp, what, index);
         return 0;
     case 7: /* Other */
         switch (reg0) {
@@ -1200,11 +1202,11 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
 }
 
 static int gen_ea_fp(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                       int opsize, TCGv_ptr fp, ea_what what)
+                       int opsize, TCGv_ptr fp, ea_what what, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_ea_mode_fp(env, s, mode, reg0, opsize, fp, what);
+    return gen_ea_mode_fp(env, s, mode, reg0, opsize, fp, what, index);
 }
 
 typedef struct {
@@ -1424,7 +1426,7 @@ static void gen_lookup_tb(DisasContext *s)
 
 #define SRC_EA(env, result, opsize, op_sign, addrp) do {                \
         result = gen_ea(env, s, insn, opsize, NULL_QREG, addrp,         \
-                        op_sign ? EA_LOADS : EA_LOADU);                 \
+                        op_sign ? EA_LOADS : EA_LOADU, IS_USER(s));     \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
             return;                                                     \
@@ -1432,7 +1434,8 @@ static void gen_lookup_tb(DisasContext *s)
     } while (0)
 
 #define DEST_EA(env, insn, opsize, val, addrp) do {                     \
-        TCGv ea_result = gen_ea(env, s, insn, opsize, val, addrp, EA_STORE); \
+        TCGv ea_result = gen_ea(env, s, insn, opsize, val, addrp,       \
+                                EA_STORE, IS_USER(s));                  \
         if (IS_NULL_QREG(ea_result)) {                                  \
             gen_addr_fault(s);                                          \
             return;                                                     \
@@ -1769,13 +1772,14 @@ DISAS_INSN(abcd_mem)
     /* Indirect pre-decrement load (mode 4) */
 
     src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                      NULL_QREG, NULL, EA_LOADU);
+                      NULL_QREG, NULL, EA_LOADU, IS_USER(s));
     dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                       NULL_QREG, &addr, EA_LOADU);
+                       NULL_QREG, &addr, EA_LOADU, IS_USER(s));
 
     bcd_add(dest, src);
 
-    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr, EA_STORE);
+    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
+                EA_STORE, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1805,13 +1809,14 @@ DISAS_INSN(sbcd_mem)
     /* Indirect pre-decrement load (mode 4) */
 
     src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                      NULL_QREG, NULL, EA_LOADU);
+                      NULL_QREG, NULL, EA_LOADU, IS_USER(s));
     dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                       NULL_QREG, &addr, EA_LOADU);
+                       NULL_QREG, &addr, EA_LOADU, IS_USER(s));
 
     bcd_sub(dest, src);
 
-    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr, EA_STORE);
+    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
+                EA_STORE, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1948,7 +1953,7 @@ static void gen_push(DisasContext *s, TCGv val)
 
     tmp = tcg_temp_new();
     tcg_gen_subi_i32(tmp, QREG_SP, 4);
-    gen_store(s, OS_LONG, tmp, val);
+    gen_store(s, OS_LONG, tmp, val, IS_USER(s));
     tcg_gen_mov_i32(QREG_SP, tmp);
     tcg_temp_free(tmp);
 }
@@ -2017,7 +2022,7 @@ DISAS_INSN(movem)
         /* memory to register */
         for (i = 0; i < 16; i++) {
             if (mask & (1 << i)) {
-                r[i] = gen_load(s, opsize, addr, 1);
+                r[i] = gen_load(s, opsize, addr, 1, IS_USER(s));
                 tcg_gen_add_i32(addr, addr, incr);
             }
         }
@@ -2049,10 +2054,10 @@ DISAS_INSN(movem)
                          */
                         tmp = tcg_temp_new();
                         tcg_gen_sub_i32(tmp, cpu_aregs[reg0], incr);
-                        gen_store(s, opsize, addr, tmp);
+                        gen_store(s, opsize, addr, tmp, IS_USER(s));
                         tcg_temp_free(tmp);
                     } else {
-                        gen_store(s, opsize, addr, mreg(i));
+                        gen_store(s, opsize, addr, mreg(i), IS_USER(s));
                     }
                 }
             }
@@ -2060,7 +2065,7 @@ DISAS_INSN(movem)
         } else {
             for (i = 0; i < 16; i++) {
                 if (mask & (1 << i)) {
-                    gen_store(s, opsize, addr, mreg(i));
+                    gen_store(s, opsize, addr, mreg(i), IS_USER(s));
                     tcg_gen_add_i32(addr, addr, incr);
                 }
             }
@@ -2780,7 +2785,7 @@ static void gen_link(DisasContext *s, uint16_t insn, int32_t offset)
     reg = AREG(insn, 0);
     tmp = tcg_temp_new();
     tcg_gen_subi_i32(tmp, QREG_SP, 4);
-    gen_store(s, OS_LONG, tmp, reg);
+    gen_store(s, OS_LONG, tmp, reg, IS_USER(s));
     if ((insn & 7) != 7) {
         tcg_gen_mov_i32(reg, tmp);
     }
@@ -2813,7 +2818,7 @@ DISAS_INSN(unlk)
     src = tcg_temp_new();
     reg = AREG(insn, 0);
     tcg_gen_mov_i32(src, reg);
-    tmp = gen_load(s, OS_LONG, src, 0);
+    tmp = gen_load(s, OS_LONG, src, 0, IS_USER(s));
     tcg_gen_mov_i32(reg, tmp);
     tcg_gen_addi_i32(QREG_SP, src, 4);
     tcg_temp_free(src);
@@ -2840,7 +2845,7 @@ DISAS_INSN(rtd)
     TCGv tmp;
     int16_t offset = read_im16(env, s);
 
-    tmp = gen_load(s, OS_LONG, QREG_SP, 0);
+    tmp = gen_load(s, OS_LONG, QREG_SP, 0, IS_USER(s));
     tcg_gen_addi_i32(QREG_SP, QREG_SP, offset + 4);
     gen_jmp(s, tmp);
 }
@@ -2849,7 +2854,7 @@ DISAS_INSN(rts)
 {
     TCGv tmp;
 
-    tmp = gen_load(s, OS_LONG, QREG_SP, 0);
+    tmp = gen_load(s, OS_LONG, QREG_SP, 0, IS_USER(s));
     tcg_gen_addi_i32(QREG_SP, QREG_SP, 4);
     gen_jmp(s, tmp);
 }
@@ -3085,15 +3090,15 @@ DISAS_INSN(subx_mem)
 
     addr_src = AREG(insn, 0);
     tcg_gen_subi_i32(addr_src, addr_src, opsize);
-    src = gen_load(s, opsize, addr_src, 1);
+    src = gen_load(s, opsize, addr_src, 1, IS_USER(s));
 
     addr_dest = AREG(insn, 9);
     tcg_gen_subi_i32(addr_dest, addr_dest, opsize);
-    dest = gen_load(s, opsize, addr_dest, 1);
+    dest = gen_load(s, opsize, addr_dest, 1, IS_USER(s));
 
     gen_subx(s, src, dest, opsize);
 
-    gen_store(s, opsize, addr_dest, QREG_CC_N);
+    gen_store(s, opsize, addr_dest, QREG_CC_N, IS_USER(s));
 }
 
 DISAS_INSN(mov3q)
@@ -3145,10 +3150,10 @@ DISAS_INSN(cmpm)
 
     /* Post-increment load (mode 3) from Ay.  */
     src = gen_ea_mode(env, s, 3, REG(insn, 0), opsize,
-                      NULL_QREG, NULL, EA_LOADS);
+                      NULL_QREG, NULL, EA_LOADS, IS_USER(s));
     /* Post-increment load (mode 3) from Ax.  */
     dst = gen_ea_mode(env, s, 3, REG(insn, 9), opsize,
-                      NULL_QREG, NULL, EA_LOADS);
+                      NULL_QREG, NULL, EA_LOADS, IS_USER(s));
 
     gen_update_cc_cmp(s, dst, src, opsize);
 }
@@ -3291,15 +3296,15 @@ DISAS_INSN(addx_mem)
 
     addr_src = AREG(insn, 0);
     tcg_gen_subi_i32(addr_src, addr_src, opsize_bytes(opsize));
-    src = gen_load(s, opsize, addr_src, 1);
+    src = gen_load(s, opsize, addr_src, 1, IS_USER(s));
 
     addr_dest = AREG(insn, 9);
     tcg_gen_subi_i32(addr_dest, addr_dest, opsize_bytes(opsize));
-    dest = gen_load(s, opsize, addr_dest, 1);
+    dest = gen_load(s, opsize, addr_dest, 1, IS_USER(s));
 
     gen_addx(s, src, dest, opsize);
 
-    gen_store(s, opsize, addr_dest, QREG_CC_N);
+    gen_store(s, opsize, addr_dest, QREG_CC_N, IS_USER(s));
 }
 
 static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
@@ -4329,9 +4334,9 @@ DISAS_INSN(chk2)
     addr2 = tcg_temp_new();
     tcg_gen_addi_i32(addr2, addr1, opsize_bytes(opsize));
 
-    bound1 = gen_load(s, opsize, addr1, 1);
+    bound1 = gen_load(s, opsize, addr1, 1, IS_USER(s));
     tcg_temp_free(addr1);
-    bound2 = gen_load(s, opsize, addr2, 1);
+    bound2 = gen_load(s, opsize, addr2, 1, IS_USER(s));
     tcg_temp_free(addr2);
 
     reg = tcg_temp_new();
@@ -4844,7 +4849,8 @@ DISAS_INSN(fpu)
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        if (gen_ea_fp(env, s, insn, opsize, cpu_src, EA_STORE) == -1) {
+        if (gen_ea_fp(env, s, insn, opsize, cpu_src,
+                      EA_STORE, IS_USER(s)) == -1) {
             gen_addr_fault(s);
         }
         gen_helper_ftst(cpu_env, cpu_src);
@@ -4866,7 +4872,8 @@ DISAS_INSN(fpu)
         /* Source effective address.  */
         opsize = ext_opsize(ext, 10);
         cpu_src = gen_fp_result_ptr();
-        if (gen_ea_fp(env, s, insn, opsize, cpu_src, EA_LOADS) == -1) {
+        if (gen_ea_fp(env, s, insn, opsize, cpu_src,
+                      EA_LOADS, IS_USER(s)) == -1) {
             gen_addr_fault(s);
             return;
         }
@@ -5265,7 +5272,7 @@ DISAS_INSN(mac)
         tcg_gen_and_i32(addr, tmp, QREG_MAC_MASK);
         /* Load the value now to ensure correct exception behavior.
            Perform writeback after reading the MAC inputs.  */
-        loadval = gen_load(s, OS_LONG, addr, 0);
+        loadval = gen_load(s, OS_LONG, addr, 0, IS_USER(s));
 
         acc ^= 1;
         rx = (ext & 0x8000) ? AREG(ext, 12) : DREG(insn, 12);
-- 
2.14.3
