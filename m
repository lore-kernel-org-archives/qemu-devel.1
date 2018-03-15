Received: from eggs.gnu.org ([2001:4830:134:3::10]:54500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewYQN-0000aZ-Jx
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewYQL-00060z-QR
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ewYQL-0005yk-0F
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 15 Mar 2018 20:19:57 +0100
Message-Id: <20180315191958.28937-3-laurent@vivier.eu>
In-Reply-To: <20180315191958.28937-1-laurent@vivier.eu>
References: <20180315191958.28937-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 2/3] target/m68k: use tcg_temp_try_free()
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

SRC_EA() and gen_extend() can return either a temporary
TCGv or memory allocated one. Try to free the temporary
one with tcg_temp_try_free().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index cef6f663ad..03aa701dde 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1550,6 +1550,7 @@ DISAS_INSN(mulw)
         tcg_gen_ext16u_i32(tmp, reg);
     SRC_EA(env, src, OS_WORD, sign, NULL);
     tcg_gen_mul_i32(tmp, tmp, src);
+    tcg_temp_try_free(src);
     tcg_gen_mov_i32(reg, tmp);
     gen_logic_cc(s, tmp, OS_LONG);
     tcg_temp_free(tmp);
@@ -1574,6 +1575,7 @@ DISAS_INSN(divw)
     } else {
         gen_helper_divuw(cpu_env, destr, src);
     }
+    tcg_temp_try_free(src);
     tcg_temp_free(destr);
 
     set_cc_op(s, CC_OP_FLAGS);
@@ -1605,6 +1607,7 @@ DISAS_INSN(divl)
         } else {
             gen_helper_divull(cpu_env, num, reg, den);
         }
+        tcg_temp_try_free(den);
         tcg_temp_free(reg);
         tcg_temp_free(num);
         set_cc_op(s, CC_OP_FLAGS);
@@ -1622,6 +1625,7 @@ DISAS_INSN(divl)
     } else {
         gen_helper_divul(cpu_env, num, reg, den);
     }
+    tcg_temp_try_free(den);
     tcg_temp_free(reg);
     tcg_temp_free(num);
 
@@ -1762,9 +1766,11 @@ DISAS_INSN(abcd_reg)
     src = gen_extend(DREG(insn, 0), OS_BYTE, 0);
     dest = gen_extend(DREG(insn, 9), OS_BYTE, 0);
     bcd_add(dest, src);
+    tcg_temp_try_free(src);
     gen_partset_reg(OS_BYTE, DREG(insn, 9), dest);
 
     bcd_flags(dest);
+    tcg_temp_try_free(dest);
 }
 
 DISAS_INSN(abcd_mem)
@@ -1781,11 +1787,13 @@ DISAS_INSN(abcd_mem)
                        NULL_QREG, &addr, EA_LOADU, IS_USER(s));
 
     bcd_add(dest, src);
+    tcg_temp_try_free(src);
 
     gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
                 EA_STORE, IS_USER(s));
 
     bcd_flags(dest);
+    tcg_temp_try_free(dest);
 }
 
 DISAS_INSN(sbcd_reg)
@@ -1798,10 +1806,12 @@ DISAS_INSN(sbcd_reg)
     dest = gen_extend(DREG(insn, 9), OS_BYTE, 0);
 
     bcd_sub(dest, src);
+    tcg_temp_try_free(src);
 
     gen_partset_reg(OS_BYTE, DREG(insn, 9), dest);
 
     bcd_flags(dest);
+    tcg_temp_try_free(dest);
 }
 
 DISAS_INSN(sbcd_mem)
@@ -1818,11 +1828,13 @@ DISAS_INSN(sbcd_mem)
                        NULL_QREG, &addr, EA_LOADU, IS_USER(s));
 
     bcd_sub(dest, src);
+    tcg_temp_try_free(src);
 
     gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
                 EA_STORE, IS_USER(s));
 
     bcd_flags(dest);
+    tcg_temp_try_free(dest);
 }
 
 DISAS_INSN(nbcd)
@@ -1836,6 +1848,7 @@ DISAS_INSN(nbcd)
 
     dest = tcg_const_i32(0);
     bcd_sub(dest, src);
+    tcg_temp_try_free(src);
 
     DEST_EA(env, insn, OS_BYTE, dest, &addr);
 
@@ -1877,9 +1890,12 @@ DISAS_INSN(addsub)
     gen_update_cc_add(dest, src, opsize);
     if (insn & 0x100) {
         DEST_EA(env, insn, opsize, dest, &addr);
+        tcg_temp_try_free(tmp);
     } else {
         gen_partset_reg(opsize, DREG(insn, 9), dest);
+        tcg_temp_try_free(src);
     }
+    tcg_temp_try_free(reg);
     tcg_temp_free(dest);
 }
 
@@ -1935,6 +1951,7 @@ DISAS_INSN(bitop_reg)
     default: /* btst */
         break;
     }
+    tcg_temp_try_free(src1);
     tcg_temp_free(tmp);
     if (op) {
         DEST_EA(env, insn, opsize, dest, &addr);
@@ -2183,6 +2200,7 @@ DISAS_INSN(bitop_im)
         DEST_EA(env, insn, opsize, tmp, &addr);
         tcg_temp_free(tmp);
     }
+    tcg_temp_try_free(src1);
 }
 
 static TCGv gen_get_ccr(DisasContext *s)
@@ -2244,6 +2262,7 @@ static void gen_move_to_sr(CPUM68KState *env, DisasContext *s, uint16_t insn,
         TCGv src;
         SRC_EA(env, src, OS_WORD, 0, NULL);
         gen_set_sr(s, src, ccr_only);
+        tcg_temp_try_free(src);
     }
 }
 
@@ -2306,6 +2325,7 @@ DISAS_INSN(arith_im)
         } else {
             DEST_EA(env, insn, opsize, dest, &addr);
             gen_logic_cc(s, dest, opsize);
+            tcg_temp_try_free(src1);
         }
         break;
     case 1: /* andi */
@@ -2315,6 +2335,7 @@ DISAS_INSN(arith_im)
         } else {
             DEST_EA(env, insn, opsize, dest, &addr);
             gen_logic_cc(s, dest, opsize);
+            tcg_temp_try_free(src1);
         }
         break;
     case 2: /* subi */
@@ -2323,6 +2344,7 @@ DISAS_INSN(arith_im)
         gen_update_cc_add(dest, im, opsize);
         set_cc_op(s, CC_OP_SUBB + opsize);
         DEST_EA(env, insn, opsize, dest, &addr);
+        tcg_temp_try_free(src1);
         break;
     case 3: /* addi */
         tcg_gen_add_i32(dest, src1, im);
@@ -2330,6 +2352,7 @@ DISAS_INSN(arith_im)
         tcg_gen_setcond_i32(TCG_COND_LTU, QREG_CC_X, dest, im);
         set_cc_op(s, CC_OP_ADDB + opsize);
         DEST_EA(env, insn, opsize, dest, &addr);
+        tcg_temp_try_free(src1);
         break;
     case 5: /* eori */
         tcg_gen_xor_i32(dest, src1, im);
@@ -2338,10 +2361,12 @@ DISAS_INSN(arith_im)
         } else {
             DEST_EA(env, insn, opsize, dest, &addr);
             gen_logic_cc(s, dest, opsize);
+            tcg_temp_try_free(src1);
         }
         break;
     case 6: /* cmpi */
         gen_update_cc_cmp(s, src1, im, opsize);
+        tcg_temp_try_free(src1);
         break;
     default:
         abort();
@@ -2400,6 +2425,7 @@ DISAS_INSN(cas)
                                IS_USER(s), opc);
     /* update flags before setting cmp to load */
     gen_update_cc_cmp(s, load, cmp, opsize);
+    tcg_temp_try_free(cmp);
     gen_partset_reg(opsize, DREG(ext, 0), load);
 
     tcg_temp_free(load);
@@ -2558,6 +2584,7 @@ DISAS_INSN(move)
         /* This will be correct because loads sign extend.  */
         gen_logic_cc(s, src, opsize);
     }
+    tcg_temp_try_free(src);
 }
 
 DISAS_INSN(negx)
@@ -2590,6 +2617,7 @@ DISAS_INSN(negx)
      */
 
     tcg_gen_and_i32(QREG_CC_V, QREG_CC_N, src);
+    tcg_temp_try_free(src);
 
     /* Copy the rest of the results into place.  */
     tcg_gen_or_i32(QREG_CC_Z, QREG_CC_Z, QREG_CC_N); /* !Z is sticky */
@@ -2650,6 +2678,7 @@ DISAS_INSN(neg)
     tcg_gen_neg_i32(dest, src1);
     set_cc_op(s, CC_OP_SUBB + opsize);
     gen_update_cc_add(dest, src1, opsize);
+    tcg_temp_try_free(src1);
     tcg_gen_setcondi_i32(TCG_COND_NE, QREG_CC_X, dest, 0);
     DEST_EA(env, insn, opsize, dest, &addr);
     tcg_temp_free(dest);
@@ -2671,6 +2700,7 @@ DISAS_INSN(not)
     SRC_EA(env, src1, opsize, 1, &addr);
     dest = tcg_temp_new();
     tcg_gen_not_i32(dest, src1);
+    tcg_temp_try_free(src1);
     DEST_EA(env, insn, opsize, dest, &addr);
     gen_logic_cc(s, dest, opsize);
 }
@@ -2738,6 +2768,7 @@ DISAS_INSN(tst)
     opsize = insn_opsize(insn);
     SRC_EA(env, tmp, opsize, 1, NULL);
     gen_logic_cc(s, tmp, opsize);
+    tcg_temp_try_free(tmp);
 }
 
 DISAS_INSN(pulse)
@@ -2761,6 +2792,7 @@ DISAS_INSN(tas)
     SRC_EA(env, src1, OS_BYTE, 1, &addr);
     gen_logic_cc(s, src1, OS_BYTE);
     tcg_gen_ori_i32(dest, src1, 0x80);
+    tcg_temp_try_free(src1);
     DEST_EA(env, insn, OS_BYTE, dest, &addr);
     tcg_temp_free(dest);
 }
@@ -2788,6 +2820,7 @@ DISAS_INSN(mull)
         } else {
             tcg_gen_mulu2_i32(QREG_CC_Z, QREG_CC_N, src1, DREG(ext, 12));
         }
+        tcg_temp_try_free(src1);
         /* if Dl == Dh, 68040 returns low word */
         tcg_gen_mov_i32(DREG(ext, 0), QREG_CC_N);
         tcg_gen_mov_i32(DREG(ext, 12), QREG_CC_Z);
@@ -2824,6 +2857,7 @@ DISAS_INSN(mull)
         tcg_gen_mul_i32(DREG(ext, 12), src1, DREG(ext, 12));
         gen_logic_cc(s, DREG(ext, 12), OS_LONG);
     }
+    tcg_temp_try_free(src1);
 }
 
 static void gen_link(DisasContext *s, uint16_t insn, int32_t offset)
@@ -2950,6 +2984,7 @@ DISAS_INSN(addsubq)
     val = tcg_const_i32(imm);
     dest = tcg_temp_new();
     tcg_gen_mov_i32(dest, src);
+    tcg_temp_try_free(src);
     if ((insn & 0x38) == 0x08) {
         /* Don't update condition codes if the destination is an
            address register.  */
@@ -3044,6 +3079,7 @@ DISAS_INSN(mvzs)
     reg = DREG(insn, 9);
     tcg_gen_mov_i32(reg, src);
     gen_logic_cc(s, src, opsize);
+    tcg_temp_try_free(src);
 }
 
 DISAS_INSN(or)
@@ -3066,6 +3102,8 @@ DISAS_INSN(or)
         tcg_gen_or_i32(dest, src, reg);
         gen_partset_reg(opsize, DREG(insn, 9), dest);
     }
+    tcg_temp_try_free(reg);
+    tcg_temp_try_free(src);
     gen_logic_cc(s, dest, opsize);
     tcg_temp_free(dest);
 }
@@ -3078,6 +3116,7 @@ DISAS_INSN(suba)
     SRC_EA(env, src, (insn & 0x100) ? OS_LONG : OS_WORD, 1, NULL);
     reg = AREG(insn, 9);
     tcg_gen_sub_i32(reg, reg, src);
+    tcg_temp_try_free(src);
 }
 
 static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
@@ -3124,6 +3163,8 @@ DISAS_INSN(subx_reg)
     dest = gen_extend(DREG(insn, 9), opsize, 1);
 
     gen_subx(s, src, dest, opsize);
+    tcg_temp_try_free(src);
+    tcg_temp_try_free(dest);
 
     gen_partset_reg(opsize, DREG(insn, 9), QREG_CC_N);
 }
@@ -3178,6 +3219,8 @@ DISAS_INSN(cmp)
     SRC_EA(env, src, opsize, 1, NULL);
     reg = gen_extend(DREG(insn, 9), opsize, 1);
     gen_update_cc_cmp(s, reg, src, opsize);
+    tcg_temp_try_free(src);
+    tcg_temp_try_free(reg);
 }
 
 DISAS_INSN(cmpa)
@@ -3194,6 +3237,7 @@ DISAS_INSN(cmpa)
     SRC_EA(env, src, opsize, 1, NULL);
     reg = AREG(insn, 9);
     gen_update_cc_cmp(s, reg, src, OS_LONG);
+    tcg_temp_try_free(src);
 }
 
 DISAS_INSN(cmpm)
@@ -3209,6 +3253,8 @@ DISAS_INSN(cmpm)
                       NULL_QREG, NULL, EA_LOADS, IS_USER(s));
 
     gen_update_cc_cmp(s, dst, src, opsize);
+    tcg_temp_try_free(src);
+    tcg_temp_try_free(dst);
 }
 
 DISAS_INSN(eor)
@@ -3223,6 +3269,7 @@ DISAS_INSN(eor)
     SRC_EA(env, src, opsize, 0, &addr);
     dest = tcg_temp_new();
     tcg_gen_xor_i32(dest, src, DREG(insn, 9));
+    tcg_temp_try_free(src);
     gen_logic_cc(s, dest, opsize);
     DEST_EA(env, insn, opsize, dest, &addr);
     tcg_temp_free(dest);
@@ -3276,6 +3323,7 @@ DISAS_INSN(and)
         tcg_gen_and_i32(dest, src, reg);
         gen_partset_reg(opsize, reg, dest);
     }
+    tcg_temp_try_free(src);
     gen_logic_cc(s, dest, opsize);
     tcg_temp_free(dest);
 }
@@ -3288,6 +3336,7 @@ DISAS_INSN(adda)
     SRC_EA(env, src, (insn & 0x100) ? OS_LONG : OS_WORD, 1, NULL);
     reg = AREG(insn, 9);
     tcg_gen_add_i32(reg, reg, src);
+    tcg_temp_try_free(src);
 }
 
 static inline void gen_addx(DisasContext *s, TCGv src, TCGv dest, int opsize)
@@ -3333,6 +3382,8 @@ DISAS_INSN(addx_reg)
     src = gen_extend(DREG(insn, 0), opsize, 1);
 
     gen_addx(s, src, dest, opsize);
+    tcg_temp_try_free(src);
+    tcg_temp_try_free(dest);
 
     gen_partset_reg(opsize, DREG(insn, 9), QREG_CC_N);
 }
@@ -3404,6 +3455,7 @@ static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
             tcg_gen_sari_i32(QREG_CC_N, reg, count);
         }
     }
+    tcg_temp_try_free(reg);
 
     gen_ext(QREG_CC_N, QREG_CC_N, opsize, 1);
     tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
@@ -3497,6 +3549,7 @@ static inline void shift_reg(DisasContext *s, uint16_t insn, int opsize)
         tcg_gen_movcond_i32(TCG_COND_NE, QREG_CC_X, s32, QREG_CC_V,
                             QREG_CC_C, QREG_CC_X);
     }
+    tcg_temp_try_free(reg);
     gen_ext(QREG_CC_N, QREG_CC_N, opsize, 1);
     tcg_gen_mov_i32(QREG_CC_Z, QREG_CC_N);
 
@@ -3567,6 +3620,7 @@ DISAS_INSN(shift_mem)
             tcg_gen_sari_i32(QREG_CC_N, src, 1);
         }
     }
+    tcg_temp_try_free(src);
 
     gen_ext(QREG_CC_N, QREG_CC_N, OS_WORD, 1);
     tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
@@ -3806,6 +3860,7 @@ DISAS_INSN(rotate8_im)
     }
     tcg_temp_free(shift);
     gen_partset_reg(OS_BYTE, DREG(insn, 0), reg);
+    tcg_temp_try_free(reg);
     set_cc_op(s, CC_OP_FLAGS);
 }
 
@@ -3832,6 +3887,7 @@ DISAS_INSN(rotate16_im)
     }
     tcg_temp_free(shift);
     gen_partset_reg(OS_WORD, DREG(insn, 0), reg);
+    tcg_temp_try_free(reg);
     set_cc_op(s, CC_OP_FLAGS);
 }
 
@@ -3901,6 +3957,7 @@ DISAS_INSN(rotate8_reg)
     tcg_temp_free(t1);
     tcg_temp_free(t0);
     gen_partset_reg(OS_BYTE, DREG(insn, 0), reg);
+    tcg_temp_try_free(reg);
     set_cc_op(s, CC_OP_FLAGS);
 }
 
@@ -3936,6 +3993,7 @@ DISAS_INSN(rotate16_reg)
     tcg_temp_free(t1);
     tcg_temp_free(t0);
     gen_partset_reg(OS_WORD, DREG(insn, 0), reg);
+    tcg_temp_try_free(reg);
     set_cc_op(s, CC_OP_FLAGS);
 }
 
@@ -3958,6 +4016,7 @@ DISAS_INSN(rotate_mem)
     }
     tcg_temp_free(shift);
     DEST_EA(env, insn, OS_WORD, src, &addr);
+    tcg_temp_try_free(src);
     set_cc_op(s, CC_OP_FLAGS);
 }
 
@@ -4357,6 +4416,8 @@ DISAS_INSN(chk)
 
     gen_flush_flags(s);
     gen_helper_chk(cpu_env, reg, src);
+    tcg_temp_try_free(reg);
+    tcg_temp_try_free(src);
 }
 
 DISAS_INSN(chk2)
@@ -5409,6 +5470,7 @@ DISAS_INSN(frestore)
     if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
         SRC_EA(env, addr, OS_LONG, 0, NULL);
         /* FIXME: check the state frame */
+        tcg_temp_try_free(addr);
     } else {
         disas_undef(env, s, insn);
     }
@@ -5713,6 +5775,7 @@ DISAS_INSN(to_mac)
     } else {
         tcg_gen_extu_i32_i64(acc, val);
     }
+    tcg_temp_try_free(val);
     tcg_gen_andi_i32(QREG_MACSR, QREG_MACSR, ~(MACSR_PAV0 << accnum));
     gen_mac_clear_flags();
     gen_helper_mac_set_flags(cpu_env, tcg_const_i32(accnum));
@@ -5731,6 +5794,7 @@ DISAS_INSN(to_mask)
     TCGv val;
     SRC_EA(env, val, OS_LONG, 0, NULL);
     tcg_gen_ori_i32(QREG_MAC_MASK, val, 0xffff0000);
+    tcg_temp_try_free(val);
 }
 
 DISAS_INSN(to_mext)
@@ -5745,6 +5809,7 @@ DISAS_INSN(to_mext)
         gen_helper_set_mac_exts(cpu_env, val, acc);
     else
         gen_helper_set_mac_extu(cpu_env, val, acc);
+    tcg_temp_try_free(val);
 }
 
 static disas_proc opcode_table[65536];
-- 
2.14.3
