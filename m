Received: from eggs.gnu.org ([2001:4830:134:3::10]:45375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgx-0007L6-Ns
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgu-0007yD-Hs
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:47 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkgu-0007xe-0i
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:28 +0100
Message-Id: <1482579633-3393-8-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 07/12] target-m68k: add cas/cas2 ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Implement CAS using cmpxchg.
Implement CAS2 using helper and either cmpxchg when
the 32bit addresses are consecutive, or with
parallel_cpus+cpu_loop_exit_atomic() otherwise.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/m68k/helper.h    |   2 +
 target/m68k/op_helper.c | 109 ++++++++++++++++++++++++++++++++++
 target/m68k/translate.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)

diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 6180dc5..a6f88fc 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -12,6 +12,8 @@ DEF_HELPER_3(shr_cc, i32, env, i32, i32)
 DEF_HELPER_3(sar_cc, i32, env, i32, i32)
 DEF_HELPER_2(set_sr, void, env, i32)
 DEF_HELPER_3(movec, void, env, i32, i32)
+DEF_HELPER_4(cas2w, void, env, i32, i32, i32)
+DEF_HELPER_4(cas2l, void, env, i32, i32, i32)
 
 DEF_HELPER_2(f64_to_i32, f32, env, f64)
 DEF_HELPER_2(f64_to_f32, f32, env, f64)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 04246a9..58d5675 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -360,3 +360,112 @@ void HELPER(divsll)(CPUM68KState *env, int numr, int regr, int32_t den)
     env->dregs[regr] = rem;
     env->dregs[numr] = quot;
 }
+
+void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
+{
+    uint32_t Dc1 = extract32(regs, 9, 3);
+    uint32_t Dc2 = extract32(regs, 6, 3);
+    uint32_t Du1 = extract32(regs, 3, 3);
+    uint32_t Du2 = extract32(regs, 0, 3);
+    int16_t c1 = env->dregs[Dc1];
+    int16_t c2 = env->dregs[Dc2];
+    int16_t u1 = env->dregs[Du1];
+    int16_t u2 = env->dregs[Du2];
+    int16_t l1, l2;
+    uintptr_t ra = GETPC();
+
+    if (parallel_cpus) {
+        /* Tell the main loop we need to serialize this insn.  */
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+    } else {
+        /* We're executing in a serial context -- no need to be atomic.  */
+        l1 = cpu_lduw_data_ra(env, a1, ra);
+        l2 = cpu_lduw_data_ra(env, a2, ra);
+        if (l1 == c1 && l2 == c2) {
+            cpu_stw_data_ra(env, a1, u1, ra);
+            cpu_stw_data_ra(env, a2, u2, ra);
+        }
+    }
+
+    if (c1 != l1) {
+        env->cc_n = l1;
+        env->cc_v = c1;
+    } else {
+        env->cc_n = l2;
+        env->cc_v = c2;
+    }
+    env->cc_op = CC_OP_CMPW;
+    env->dregs[Dc1] = deposit32(env->dregs[Dc1], 0, 16, l1);
+    env->dregs[Dc2] = deposit32(env->dregs[Dc2], 0, 16, l2);
+}
+
+void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
+{
+    uint32_t Dc1 = extract32(regs, 9, 3);
+    uint32_t Dc2 = extract32(regs, 6, 3);
+    uint32_t Du1 = extract32(regs, 3, 3);
+    uint32_t Du2 = extract32(regs, 0, 3);
+    uint32_t c1 = env->dregs[Dc1];
+    uint32_t c2 = env->dregs[Dc2];
+    uint32_t u1 = env->dregs[Du1];
+    uint32_t u2 = env->dregs[Du2];
+    uint32_t l1, l2;
+    uint64_t c, u, l;
+    uintptr_t ra = GETPC();
+#if defined(CONFIG_ATOMIC64) && !defined(CONFIG_USER_ONLY)
+    int mmu_idx = cpu_mmu_index(env, 0);
+    TCGMemOpIdx oi;
+#endif
+
+    if (parallel_cpus) {
+        /* We're executing in a parallel context -- must be atomic.  */
+#ifdef CONFIG_ATOMIC64
+        if ((a1 & 7) == 0 && a2 == a1 + 4) {
+            c = deposit64(c2, 32, 32, c1);
+            u = deposit64(u2, 32, 32, u1);
+#ifdef CONFIG_USER_ONLY
+            l = helper_atomic_cmpxchgq_be(env, a1, c, u);
+#else
+            oi = make_memop_idx(MO_BEQ, mmu_idx);
+            l = helper_atomic_cmpxchgq_be_mmu(env, a1, c, u, oi, ra);
+#endif
+            l1 = l >> 32;
+            l2 = l;
+        } else if ((a2 & 7) == 0 && a1 == a2 + 4) {
+            c = deposit64(c1, 32, 32, c2);
+            u = deposit64(u1, 32, 32, u2);
+#ifdef CONFIG_USER_ONLY
+            l = helper_atomic_cmpxchgq_be(env, a2, c, u);
+#else
+            oi = make_memop_idx(MO_BEQ, mmu_idx);
+            l = helper_atomic_cmpxchgq_be_mmu(env, a2, c, u, oi, ra);
+#endif
+            l2 = l >> 32;
+            l1 = l;
+        } else
+#endif
+        {
+            /* Tell the main loop we need to serialize this insn.  */
+            cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+        }
+    } else {
+        /* We're executing in a serial context -- no need to be atomic.  */
+        l1 = cpu_ldl_data_ra(env, a1, ra);
+        l2 = cpu_ldl_data_ra(env, a2, ra);
+        if (l1 == c1 && l2 == c2) {
+            cpu_stl_data_ra(env, a1, u1, ra);
+            cpu_stl_data_ra(env, a2, u2, ra);
+        }
+    }
+
+    if (c1 != l1) {
+        env->cc_n = l1;
+        env->cc_v = c1;
+    } else {
+        env->cc_n = l2;
+        env->cc_v = c2;
+    }
+    env->cc_op = CC_OP_CMPL;
+    env->dregs[Dc1] = l1;
+    env->dregs[Dc2] = l2;
+}
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 1567647..0124820 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1798,6 +1798,155 @@ DISAS_INSN(arith_im)
     tcg_temp_free(dest);
 }
 
+DISAS_INSN(cas)
+{
+    int opsize;
+    TCGv addr;
+    uint16_t ext;
+    TCGv load;
+    TCGv cmp;
+    TCGMemOp opc;
+
+    switch ((insn >> 9) & 3) {
+    case 1:
+        opsize = OS_BYTE;
+        opc = MO_SB;
+        break;
+    case 2:
+        opsize = OS_WORD;
+        opc = MO_TESW;
+        break;
+    case 3:
+        opsize = OS_LONG;
+        opc = MO_TESL;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    opc |= MO_ALIGN;
+
+    ext = read_im16(env, s);
+
+    /* cas Dc,Du,<EA> */
+
+    addr = gen_lea(env, s, insn, opsize);
+    if (IS_NULL_QREG(addr)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    cmp = gen_extend(DREG(ext, 0), opsize, 1);
+
+    /* if  <EA> == Dc then
+     *     <EA> = Du
+     *     Dc = <EA> (because <EA> == Dc)
+     * else
+     *     Dc = <EA>
+     */
+
+    load = tcg_temp_new();
+    tcg_gen_atomic_cmpxchg_i32(load, addr, cmp, DREG(ext, 6),
+                               IS_USER(s), opc);
+    /* update flags before setting cmp to load */
+    gen_update_cc_cmp(s, load, cmp, opsize);
+    gen_partset_reg(opsize, DREG(ext, 0), load);
+
+    tcg_temp_free(load);
+}
+
+DISAS_INSN(cas2w)
+{
+    uint16_t ext1, ext2;
+    TCGv addr1, addr2;
+    TCGv regs;
+
+    /* cas2 Dc1:Dc2,Du1:Du2,(Rn1):(Rn2) */
+
+    ext1 = read_im16(env, s);
+
+    if (ext1 & 0x8000) {
+        /* Address Register */
+        addr1 = AREG(ext1, 12);
+    } else {
+        /* Data Register */
+        addr1 = DREG(ext1, 12);
+    }
+
+    ext2 = read_im16(env, s);
+    if (ext2 & 0x8000) {
+        /* Address Register */
+        addr2 = AREG(ext2, 12);
+    } else {
+        /* Data Register */
+        addr2 = DREG(ext2, 12);
+    }
+
+    /* if (R1) == Dc1 && (R2) == Dc2 then
+     *     (R1) = Du1
+     *     (R2) = Du2
+     * else
+     *     Dc1 = (R1)
+     *     Dc2 = (R2)
+     */
+
+    regs = tcg_const_i32(REG(ext2, 6) |
+                         (REG(ext1, 6) << 3) |
+                         (REG(ext2, 0) << 6) |
+                         (REG(ext1, 0) << 9));
+    gen_helper_cas2w(cpu_env, regs, addr1, addr2);
+    tcg_temp_free(regs);
+
+    /* Note that cas2w also assigned to env->cc_op.  */
+    s->cc_op = CC_OP_CMPW;
+    s->cc_op_synced = 1;
+}
+
+DISAS_INSN(cas2l)
+{
+    uint16_t ext1, ext2;
+    TCGv addr1, addr2, regs;
+
+    /* cas2 Dc1:Dc2,Du1:Du2,(Rn1):(Rn2) */
+
+    ext1 = read_im16(env, s);
+
+    if (ext1 & 0x8000) {
+        /* Address Register */
+        addr1 = AREG(ext1, 12);
+    } else {
+        /* Data Register */
+        addr1 = DREG(ext1, 12);
+    }
+
+    ext2 = read_im16(env, s);
+    if (ext2 & 0x8000) {
+        /* Address Register */
+        addr2 = AREG(ext2, 12);
+    } else {
+        /* Data Register */
+        addr2 = DREG(ext2, 12);
+    }
+
+    /* if (R1) == Dc1 && (R2) == Dc2 then
+     *     (R1) = Du1
+     *     (R2) = Du2
+     * else
+     *     Dc1 = (R1)
+     *     Dc2 = (R2)
+     */
+
+    regs = tcg_const_i32(REG(ext2, 6) |
+                         (REG(ext1, 6) << 3) |
+                         (REG(ext2, 0) << 6) |
+                         (REG(ext1, 0) << 9));
+    gen_helper_cas2l(cpu_env, regs, addr1, addr2);
+    tcg_temp_free(regs);
+
+    /* Note that cas2l also assigned to env->cc_op.  */
+    s->cc_op = CC_OP_CMPL;
+    s->cc_op_synced = 1;
+}
+
 DISAS_INSN(byterev)
 {
     TCGv reg;
@@ -3641,6 +3790,11 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(bitop_im,  08c0, ffc0);
     INSN(arith_im,  0a80, fff8, CF_ISA_A);
     INSN(arith_im,  0a00, ff00, M68000);
+    INSN(cas,       0ac0, ffc0, CAS);
+    INSN(cas,       0cc0, ffc0, CAS);
+    INSN(cas,       0ec0, ffc0, CAS);
+    INSN(cas2w,     0cfc, ffff, CAS);
+    INSN(cas2l,     0efc, ffff, CAS);
     BASE(move,      1000, f000);
     BASE(move,      2000, f000);
     BASE(move,      3000, f000);
-- 
2.7.4
