Received: from eggs.gnu.org ([2001:4830:134:3::10]:53860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dROyG-0001ez-3b
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dROyD-0006lu-5h
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:24 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dROyD-0006li-03
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:21 -0400
Received: by mail-qt0-x242.google.com with SMTP id w12so19176531qta.2
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 13:26:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat,  1 Jul 2017 13:25:53 -0700
Message-Id: <20170701202600.14057-2-rth@twiddle.net>
In-Reply-To: <20170701202600.14057-1-rth@twiddle.net>
References: <20170701202600.14057-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 1/8] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |   1 +
 target/s390x/cpu_models.c  |   2 +
 target/s390x/mem_helper.c  | 189 +++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  13 +++-
 target/s390x/insn-data.def |   2 +
 5 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 964097b..23e8d1d 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -33,6 +33,7 @@ DEF_HELPER_3(celgb, i64, env, i64, i32)
 DEF_HELPER_3(cdlgb, i64, env, i64, i32)
 DEF_HELPER_3(cxlgb, i64, env, i64, i32)
 DEF_HELPER_4(cdsg, void, env, i64, i32, i32)
+DEF_HELPER_4(csst, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_3(aeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(adb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_5(axb, TCG_CALL_NO_WG, i64, env, i64, i64, i64, i64)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 63903c2..08290ce 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -684,6 +684,8 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_ETF2_ENH,
         S390_FEAT_STORE_CLOCK_FAST,
         S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
+        S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
+        S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index ede8471..513b402 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1353,6 +1353,195 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
     env->regs[r1 + 1] = int128_getlo(oldv);
 }
 
+uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
+{
+#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_ATOMIC128)
+    uint32_t mem_idx = cpu_mmu_index(env, false);
+#endif
+    uintptr_t ra = GETPC();
+    uint32_t fc = extract32(env->regs[0], 0, 8);
+    uint32_t sc = extract32(env->regs[0], 8, 8);
+    uint64_t pl = get_address(env, 1) & -16;
+    uint64_t svh, svl;
+    uint32_t cc;
+
+    /* Sanity check the function code and storage characteristic.  */
+    if (fc > 1 || sc > 3) {
+        if (!s390_has_feat(S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2)) {
+            goto spec_exception;
+        }
+        if (fc > 2 || sc > 4 || (fc == 2 && (r3 & 1))) {
+            goto spec_exception;
+        }
+    }
+
+    /* Sanity check the alignments.  */
+    if (extract32(a1, 0, 4 << fc) || extract32(a2, 0, 1 << sc)) {
+        goto spec_exception;
+    }
+
+    /* Sanity check writability of the store address.  */
+#ifndef CONFIG_USER_ONLY
+    probe_write(env, a2, mem_idx, ra);
+#endif
+
+    /* Note that the compare-and-swap is atomic, and the store is atomic, but
+       the complete operation is not.  Therefore we do not need to assert serial
+       context in order to implement this.  That said, restart early if we can't
+       support either operation that is supposed to be atomic.  */
+    if (parallel_cpus) {
+        int mask = 0;
+#if !defined(CONFIG_ATOMIC64)
+        mask = -8;
+#elif !defined(CONFIG_ATOMIC128)
+        mask = -16;
+#endif
+        if (((4 << fc) | (1 << sc)) & mask) {
+            cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+        }
+    }
+
+    /* All loads happen before all stores.  For simplicity, load the entire
+       store value area from the parameter list.  */
+    svh = cpu_ldq_data_ra(env, pl + 16, ra);
+    svl = cpu_ldq_data_ra(env, pl + 24, ra);
+
+    switch (fc) {
+    case 0:
+        {
+            uint32_t nv = cpu_ldl_data_ra(env, pl, ra);
+            uint32_t cv = env->regs[r3];
+            uint32_t ov;
+
+            if (parallel_cpus) {
+#ifdef CONFIG_USER_ONLY
+                uint32_t *haddr = g2h(a1);
+                ov = atomic_cmpxchg__nocheck(haddr, cv, nv);
+#else
+                TCGMemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mem_idx);
+                ov = helper_atomic_cmpxchgl_be_mmu(env, a1, cv, nv, oi, ra);
+#endif
+            } else {
+                ov = cpu_ldl_data_ra(env, a1, ra);
+                cpu_stl_data_ra(env, a1, (ov == cv ? nv : ov), ra);
+            }
+            cc = (ov != cv);
+            env->regs[r3] = deposit64(env->regs[r3], 32, 32, ov);
+        }
+        break;
+
+    case 1:
+        {
+            uint64_t nv = cpu_ldq_data_ra(env, pl, ra);
+            uint64_t cv = env->regs[r3];
+            uint64_t ov;
+
+            if (parallel_cpus) {
+#ifdef CONFIG_USER_ONLY
+# ifdef CONFIG_ATOMIC64
+                uint64_t *haddr = g2h(a1);
+                ov = atomic_cmpxchg__nocheck(haddr, cv, nv);
+# else
+                /* Note that we asserted !parallel_cpus above.  */
+                g_assert_not_reached();
+# endif
+#else
+                TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN, mem_idx);
+                ov = helper_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi, ra);
+#endif
+            } else {
+                ov = cpu_ldq_data_ra(env, a1, ra);
+                cpu_stq_data_ra(env, a1, (ov == cv ? nv : ov), ra);
+            }
+            cc = (ov != cv);
+            env->regs[r3] = ov;
+        }
+        break;
+
+    case 2:
+        {
+            uint64_t nvh = cpu_ldq_data_ra(env, pl, ra);
+            uint64_t nvl = cpu_ldq_data_ra(env, pl + 8, ra);
+            Int128 nv = int128_make128(nvl, nvh);
+            Int128 cv = int128_make128(env->regs[r3 + 1], env->regs[r3]);
+            Int128 ov;
+
+            if (parallel_cpus) {
+#ifdef CONFIG_ATOMIC128
+                TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+                ov = helper_atomic_cmpxchgo_be_mmu(env, a1, cv, nv, oi, ra);
+                cc = !int128_eq(ov, cv);
+#else
+                /* Note that we asserted !parallel_cpus above.  */
+                g_assert_not_reached();
+#endif
+            } else {
+                uint64_t oh = cpu_ldq_data_ra(env, a1 + 0, ra);
+                uint64_t ol = cpu_ldq_data_ra(env, a1 + 8, ra);
+
+                ov = int128_make128(ol, oh);
+                cc = !int128_eq(ov, cv);
+                if (cc) {
+                    nv = ov;
+                }
+
+                cpu_stq_data_ra(env, a1 + 0, int128_gethi(nv), ra);
+                cpu_stq_data_ra(env, a1 + 8, int128_getlo(nv), ra);
+            }
+
+            env->regs[r3 + 0] = int128_gethi(ov);
+            env->regs[r3 + 1] = int128_getlo(ov);
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    /* Store only if the comparison succeeded.  Note that above we use a pair
+       of 64-bit big-endian loads, so for sc < 3 we must extract the value
+       from the most-significant bits of svh.  */
+    if (cc == 0) {
+        switch (sc) {
+        case 0:
+            cpu_stb_data_ra(env, a2, svh >> 56, ra);
+            break;
+        case 1:
+            cpu_stw_data_ra(env, a2, svh >> 48, ra);
+            break;
+        case 2:
+            cpu_stl_data_ra(env, a2, svh >> 32, ra);
+            break;
+        case 3:
+            cpu_stq_data_ra(env, a2, svh, ra);
+            break;
+        case 4:
+            if (parallel_cpus) {
+#ifdef CONFIG_ATOMIC128
+                TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+                Int128 sv = int128_make128(svl, svh);
+                helper_atomic_sto_be_mmu(env, a2, sv, oi, ra);
+#else
+                /* Note that we asserted !parallel_cpus above.  */
+                g_assert_not_reached();
+#endif
+            } else {
+                cpu_stq_data_ra(env, a2 + 0, svh, ra);
+                cpu_stq_data_ra(env, a2 + 8, svl, ra);
+            }
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    return cc;
+
+ spec_exception:
+    cpu_restore_state(ENV_GET_CPU(env), ra);
+    program_interrupt(env, PGM_SPECIFICATION, 6);
+    g_assert_not_reached();
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 592d6b0..e739525 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2033,6 +2033,18 @@ static ExitStatus op_cdsg(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_csst(DisasContext *s, DisasOps *o)
+{
+    int r3 = get_field(s->fields, r3);
+    TCGv_i32 t_r3 = tcg_const_i32(r3);
+
+    gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
+    tcg_temp_free_i32(t_r3);
+
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_csp(DisasContext *s, DisasOps *o)
 {
@@ -5437,7 +5449,6 @@ enum DisasInsnEnum {
 /* Give smaller names to the various facilities.  */
 #define FAC_Z           S390_FEAT_ZARCH
 #define FAC_CASS        S390_FEAT_COMPARE_AND_SWAP_AND_STORE
-#define FAC_CASS2       S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2
 #define FAC_DFP         S390_FEAT_DFP
 #define FAC_DFPR        S390_FEAT_FLOATING_POINT_SUPPPORT_ENH /* DFP-rounding */
 #define FAC_DO          S390_FEAT_STFLE_45 /* distinct-operands */
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d3bb851..6ac12b8 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -265,6 +265,8 @@
     D(0xbb00, CDS,     RS_a,  Z,   r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEQ)
     D(0xeb31, CDSY,    RSY_a, LD,  r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEQ)
     C(0xeb3e, CDSG,    RSY_a, Z,   0, 0, 0, 0, cdsg, 0)
+/* COMPARE AND SWAP AND STORE */
+    C(0xc802, CSST,    SSF,   CASS, la1, a2, 0, 0, csst, 0)
 
 /* COMPARE AND TRAP */
     D(0xb972, CRT,     RRF_c, GIE, r1_32s, r2_32s, 0, 0, ct, 0, 0)
-- 
2.9.4
