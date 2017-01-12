Received: from eggs.gnu.org ([2001:4830:134:3::10]:44426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRjnn-0000lN-4h
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRjnj-0005OY-3E
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:43 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:62121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cRjni-0005OD-MO
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:39 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 12 Jan 2017 19:08:19 +0100
Message-Id: <1484244501-20283-3-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484244501-20283-1-git-send-email-laurent@vivier.eu>
References: <1484244501-20283-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 2/4] target-m68k: Implement bitfield ops for
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1478699171-10637-6-git-send-email-rth@twiddle.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h       |   1 +
 target/m68k/helper.h    |   7 ++
 target/m68k/op_helper.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/translate.c | 142 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 333 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 0b4ed7b..fc1f16f 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -37,6 +37,7 @@
 #define OS_DOUBLE   4
 #define OS_EXTENDED 5
 #define OS_PACKED   6
+#define OS_UNSIZED  7
 
 #define MAX_QREGS 32
 
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 17ec342..eb11945 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -50,3 +50,10 @@ DEF_HELPER_2(flush_flags, void, env, i32)
 DEF_HELPER_2(set_ccr, void, env, i32)
 DEF_HELPER_FLAGS_1(get_ccr, TCG_CALL_NO_WG_SE, i32, env)
 DEF_HELPER_2(raise_exception, void, env, i32)
+
+DEF_HELPER_FLAGS_4(bfexts_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
+DEF_HELPER_FLAGS_4(bfextu_mem, TCG_CALL_NO_WG, i64, env, i32, s32, i32)
+DEF_HELPER_FLAGS_5(bfins_mem, TCG_CALL_NO_WG, i32, env, i32, i32, s32, i32)
+DEF_HELPER_FLAGS_4(bfchg_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
+DEF_HELPER_FLAGS_4(bfclr_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
+DEF_HELPER_FLAGS_4(bfset_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index e56b815..51b9e00 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -469,3 +469,188 @@ void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
     env->dregs[Dc1] = l1;
     env->dregs[Dc2] = l2;
 }
+
+struct bf_data {
+    uint32_t addr;
+    uint32_t bofs;
+    uint32_t blen;
+    uint32_t len;
+};
+
+static struct bf_data bf_prep(uint32_t addr, int32_t ofs, uint32_t len)
+{
+    int bofs, blen;
+
+    /* Bound length; map 0 to 32.  */
+    len = ((len - 1) & 31) + 1;
+
+    /* Note that ofs is signed.  */
+    addr += ofs / 8;
+    bofs = ofs % 8;
+    if (bofs < 0) {
+        bofs += 8;
+        addr -= 1;
+    }
+
+    /* Compute the number of bytes required (minus one) to
+       satisfy the bitfield.  */
+    blen = (bofs + len - 1) / 8;
+
+    /* Canonicalize the bit offset for data loaded into a 64-bit big-endian
+       word.  For the cases where BLEN is not a power of 2, adjust ADDR so
+       that we can use the next power of two sized load without crossing a
+       page boundary, unless the field itself crosses the boundary.  */
+    switch (blen) {
+    case 0:
+        bofs += 56;
+        break;
+    case 1:
+        bofs += 48;
+        break;
+    case 2:
+        if (addr & 1) {
+            bofs += 8;
+            addr -= 1;
+        }
+        /* fallthru */
+    case 3:
+        bofs += 32;
+        break;
+    case 4:
+        if (addr & 3) {
+            bofs += 8 * (addr & 3);
+            addr &= -4;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return (struct bf_data){
+        .addr = addr,
+        .bofs = bofs,
+        .blen = blen,
+        .len = len,
+    };
+}
+
+static uint64_t bf_load(CPUM68KState *env, uint32_t addr, int blen,
+                        uintptr_t ra)
+{
+    switch (blen) {
+    case 0:
+        return cpu_ldub_data_ra(env, addr, ra);
+    case 1:
+        return cpu_lduw_data_ra(env, addr, ra);
+    case 2:
+    case 3:
+        return cpu_ldl_data_ra(env, addr, ra);
+    case 4:
+        return cpu_ldq_data_ra(env, addr, ra);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void bf_store(CPUM68KState *env, uint32_t addr, int blen,
+                     uint64_t data, uintptr_t ra)
+{
+    switch (blen) {
+    case 0:
+        cpu_stb_data_ra(env, addr, data, ra);
+        break;
+    case 1:
+        cpu_stw_data_ra(env, addr, data, ra);
+        break;
+    case 2:
+    case 3:
+        cpu_stl_data_ra(env, addr, data, ra);
+        break;
+    case 4:
+        cpu_stq_data_ra(env, addr, data, ra);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+uint32_t HELPER(bfexts_mem)(CPUM68KState *env, uint32_t addr,
+                            int32_t ofs, uint32_t len)
+{
+    uintptr_t ra = GETPC();
+    struct bf_data d = bf_prep(addr, ofs, len);
+    uint64_t data = bf_load(env, d.addr, d.blen, ra);
+
+    return (int64_t)(data << d.bofs) >> (64 - d.len);
+}
+
+uint64_t HELPER(bfextu_mem)(CPUM68KState *env, uint32_t addr,
+                            int32_t ofs, uint32_t len)
+{
+    uintptr_t ra = GETPC();
+    struct bf_data d = bf_prep(addr, ofs, len);
+    uint64_t data = bf_load(env, d.addr, d.blen, ra);
+
+    /* Put CC_N at the top of the high word; put the zero-extended value
+       at the bottom of the low word.  */
+    data <<= d.bofs;
+    data >>= 64 - d.len;
+    data |= data << (64 - d.len);
+
+    return data;
+}
+
+uint32_t HELPER(bfins_mem)(CPUM68KState *env, uint32_t addr, uint32_t val,
+                           int32_t ofs, uint32_t len)
+{
+    uintptr_t ra = GETPC();
+    struct bf_data d = bf_prep(addr, ofs, len);
+    uint64_t data = bf_load(env, d.addr, d.blen, ra);
+    uint64_t mask = -1ull << (64 - d.len) >> d.bofs;
+
+    data = (data & ~mask) | (((uint64_t)val << (64 - d.len)) >> d.bofs);
+
+    bf_store(env, d.addr, d.blen, data, ra);
+
+    /* The field at the top of the word is also CC_N for CC_OP_LOGIC.  */
+    return val << (32 - d.len);
+}
+
+uint32_t HELPER(bfchg_mem)(CPUM68KState *env, uint32_t addr,
+                           int32_t ofs, uint32_t len)
+{
+    uintptr_t ra = GETPC();
+    struct bf_data d = bf_prep(addr, ofs, len);
+    uint64_t data = bf_load(env, d.addr, d.blen, ra);
+    uint64_t mask = -1ull << (64 - d.len) >> d.bofs;
+
+    bf_store(env, d.addr, d.blen, data ^ mask, ra);
+
+    return ((data & mask) << d.bofs) >> 32;
+}
+
+uint32_t HELPER(bfclr_mem)(CPUM68KState *env, uint32_t addr,
+                           int32_t ofs, uint32_t len)
+{
+    uintptr_t ra = GETPC();
+    struct bf_data d = bf_prep(addr, ofs, len);
+    uint64_t data = bf_load(env, d.addr, d.blen, ra);
+    uint64_t mask = -1ull << (64 - d.len) >> d.bofs;
+
+    bf_store(env, d.addr, d.blen, data & ~mask, ra);
+
+    return ((data & mask) << d.bofs) >> 32;
+}
+
+uint32_t HELPER(bfset_mem)(CPUM68KState *env, uint32_t addr,
+                           int32_t ofs, uint32_t len)
+{
+    uintptr_t ra = GETPC();
+    struct bf_data d = bf_prep(addr, ofs, len);
+    uint64_t data = bf_load(env, d.addr, d.blen, ra);
+    uint64_t mask = -1ull << (64 - d.len) >> d.bofs;
+
+    bf_store(env, d.addr, d.blen, data | mask, ra);
+
+    return ((data & mask) << d.bofs) >> 32;
+}
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 1487914..fe44fda 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -711,10 +711,17 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
     case 0: /* Data register direct.  */
     case 1: /* Address register direct.  */
         return NULL_QREG;
-    case 2: /* Indirect register */
     case 3: /* Indirect postincrement.  */
+        if (opsize == OS_UNSIZED) {
+            return NULL_QREG;
+        }
+        /* fallthru */
+    case 2: /* Indirect register */
         return get_areg(s, reg0);
     case 4: /* Indirect predecrememnt.  */
+        if (opsize == OS_UNSIZED) {
+            return NULL_QREG;
+        }
         reg = get_areg(s, reg0);
         tmp = tcg_temp_new();
         tcg_gen_subi_i32(tmp, reg, opsize_bytes(opsize));
@@ -3569,6 +3576,49 @@ DISAS_INSN(bfext_reg)
     set_cc_op(s, CC_OP_LOGIC);
 }
 
+DISAS_INSN(bfext_mem)
+{
+    int ext = read_im16(env, s);
+    int is_sign = insn & 0x200;
+    TCGv dest = DREG(ext, 12);
+    TCGv addr, len, ofs;
+
+    addr = gen_lea(env, s, insn, OS_UNSIZED);
+    if (IS_NULL_QREG(addr)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    if (ext & 0x20) {
+        len = DREG(ext, 0);
+    } else {
+        len = tcg_const_i32(extract32(ext, 0, 5));
+    }
+    if (ext & 0x800) {
+        ofs = DREG(ext, 6);
+    } else {
+        ofs = tcg_const_i32(extract32(ext, 6, 5));
+    }
+
+    if (is_sign) {
+        gen_helper_bfexts_mem(dest, cpu_env, addr, ofs, len);
+        tcg_gen_mov_i32(QREG_CC_N, dest);
+    } else {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        gen_helper_bfextu_mem(tmp, cpu_env, addr, ofs, len);
+        tcg_gen_extr_i64_i32(dest, QREG_CC_N, tmp);
+        tcg_temp_free_i64(tmp);
+    }
+    set_cc_op(s, CC_OP_LOGIC);
+
+    if (!(ext & 0x20)) {
+        tcg_temp_free(len);
+    }
+    if (!(ext & 0x800)) {
+        tcg_temp_free(ofs);
+    }
+}
+
 DISAS_INSN(bfop_reg)
 {
     int ext = read_im16(env, s);
@@ -3634,6 +3684,54 @@ DISAS_INSN(bfop_reg)
     tcg_temp_free(mask);
 }
 
+DISAS_INSN(bfop_mem)
+{
+    int ext = read_im16(env, s);
+    TCGv addr, len, ofs;
+
+    addr = gen_lea(env, s, insn, OS_UNSIZED);
+    if (IS_NULL_QREG(addr)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    if (ext & 0x20) {
+        len = DREG(ext, 0);
+    } else {
+        len = tcg_const_i32(extract32(ext, 0, 5));
+    }
+    if (ext & 0x800) {
+        ofs = DREG(ext, 6);
+    } else {
+        ofs = tcg_const_i32(extract32(ext, 6, 5));
+    }
+
+    switch (insn & 0x0f00) {
+    case 0x0a00: /* bfchg */
+        gen_helper_bfchg_mem(QREG_CC_N, cpu_env, addr, ofs, len);
+        break;
+    case 0x0c00: /* bfclr */
+        gen_helper_bfclr_mem(QREG_CC_N, cpu_env, addr, ofs, len);
+        break;
+    case 0x0e00: /* bfset */
+        gen_helper_bfset_mem(QREG_CC_N, cpu_env, addr, ofs, len);
+        break;
+    case 0x0800: /* bftst */
+        gen_helper_bfexts_mem(QREG_CC_N, cpu_env, addr, ofs, len);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    set_cc_op(s, CC_OP_LOGIC);
+
+    if (!(ext & 0x20)) {
+        tcg_temp_free(len);
+    }
+    if (!(ext & 0x800)) {
+        tcg_temp_free(ofs);
+    }
+}
+
 DISAS_INSN(bfins_reg)
 {
     int ext = read_im16(env, s);
@@ -3708,6 +3806,40 @@ DISAS_INSN(bfins_reg)
     tcg_temp_free(tmp);
 }
 
+DISAS_INSN(bfins_mem)
+{
+    int ext = read_im16(env, s);
+    TCGv src = DREG(ext, 12);
+    TCGv addr, len, ofs;
+
+    addr = gen_lea(env, s, insn, OS_UNSIZED);
+    if (IS_NULL_QREG(addr)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    if (ext & 0x20) {
+        len = DREG(ext, 0);
+    } else {
+        len = tcg_const_i32(extract32(ext, 0, 5));
+    }
+    if (ext & 0x800) {
+        ofs = DREG(ext, 6);
+    } else {
+        ofs = tcg_const_i32(extract32(ext, 6, 5));
+    }
+
+    gen_helper_bfins_mem(QREG_CC_N, cpu_env, addr, src, ofs, len);
+    set_cc_op(s, CC_OP_LOGIC);
+
+    if (!(ext & 0x20)) {
+        tcg_temp_free(len);
+    }
+    if (!(ext & 0x800)) {
+        tcg_temp_free(ofs);
+    }
+}
+
 DISAS_INSN(ff1)
 {
     TCGv reg;
@@ -4799,11 +4931,17 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(rotate8_reg, e030, f0f0, M68000);
     INSN(rotate16_reg, e070, f0f0, M68000);
     INSN(rotate_mem, e4c0, fcc0, M68000);
-    INSN(bfext_reg, e9c0, fdf8, BITFIELD);  /* bfextu & bfexts */
+    INSN(bfext_mem, e9c0, fdc0, BITFIELD);  /* bfextu & bfexts */
+    INSN(bfext_reg, e9c0, fdf8, BITFIELD);
+    INSN(bfins_mem, efc0, ffc0, BITFIELD);
     INSN(bfins_reg, efc0, fff8, BITFIELD);
+    INSN(bfop_mem, eac0, ffc0, BITFIELD);   /* bfchg */
     INSN(bfop_reg, eac0, fff8, BITFIELD);   /* bfchg */
+    INSN(bfop_mem, ecc0, ffc0, BITFIELD);   /* bfclr */
     INSN(bfop_reg, ecc0, fff8, BITFIELD);   /* bfclr */
+    INSN(bfop_mem, eec0, ffc0, BITFIELD);   /* bfset */
     INSN(bfop_reg, eec0, fff8, BITFIELD);   /* bfset */
+    INSN(bfop_mem, e8c0, ffc0, BITFIELD);   /* bftst */
     INSN(bfop_reg, e8c0, fff8, BITFIELD);   /* bftst */
     INSN(undef_fpu, f000, f000, CF_ISA_A);
     INSN(fpu,       f200, ffc0, CF_FPU);
-- 
2.7.4
