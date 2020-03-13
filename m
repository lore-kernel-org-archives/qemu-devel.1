Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31850C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95C02072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95C02072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkxp-0005xC-R0
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>) id 1jCkrk-0005qA-Au
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <remi@remlab.net>) id 1jCkrh-0001Rn-MK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:00:44 -0400
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:49724
 helo=ns207790.ip-94-23-215.eu) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <remi@remlab.net>)
 id 1jCkrV-0000b0-MG; Fri, 13 Mar 2020 10:00:29 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 683635FD2A;
 Fri, 13 Mar 2020 15:00:24 +0100 (CET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To: qemu-arm@nongnu.org
Subject: [PATCH 2/5] target/arm: MTE user mode disassembly
Date: Fri, 13 Mar 2020 16:00:20 +0200
Message-Id: <20200313140023.83844-2-remi@remlab.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41d0:2:5a1a::
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>

This adds TCG disassembler support for the EL0-accessible instructions
from ARMv8.5-MemTag, and sets corresponding feature bit in the
"maximum" emulated CPU.

Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu64.c         |   7 ++
 target/arm/helper.c        |  30 +++++
 target/arm/translate-a64.c | 236 +++++++++++++++++++++++++++++++++++--
 3 files changed, 266 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 62d36f9e8d..a72dfd3d98 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -665,6 +665,13 @@ static void aarch64_max_initfn(Object *obj)
=20
         t =3D cpu->isar.id_aa64pfr1;
         t =3D FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+#ifdef CONFIG_USER_ONLY
+        /* All MTE instructions and processor states are supported for u=
ser
+         * mode. This corresponds to feature field value 1 (field value =
2
+         * implies MemTag memory support).
+         */
+        t =3D FIELD_DP64(t, ID_AA64PFR1, MTE, 1);
+#endif
         cpu->isar.id_aa64pfr1 =3D t;
=20
         t =3D cpu->isar.id_aa64mmfr1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 38500e4f92..ed56198623 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6839,6 +6839,33 @@ static const ARMCPRegInfo dcpodp_reg[] =3D {
 };
 #endif /*CONFIG_USER_ONLY*/
=20
+static uint64_t tco_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_TCO;
+}
+
+static void tco_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t=
 val)
+{
+    if (val & PSTATE_TCO) {
+        env->pstate |=3D PSTATE_TCO;
+    } else {
+        env->pstate &=3D ~PSTATE_TCO;
+    }
+}
+
+static const ARMCPRegInfo mte_reginfo[] =3D {
+    { .name =3D "DC_GVA", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 4, .opc2 =3D 3,
+      .access =3D PL0_W, .type =3D ARM_CP_NOP },
+    { .name =3D "DC_GZVA", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 4, .opc2 =3D 4,
+      .access =3D PL0_W, .type =3D ARM_CP_DC_ZVA },
+    { .name =3D "TCO", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 3, .crn =3D 4, .crm =3D 2, .opc2 =3D 7,
+      .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW,
+      .readfn =3D tco_read, .writefn =3D tco_write },
+    REGINFO_SENTINEL
+};
 #endif
=20
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInf=
o *ri,
@@ -7956,6 +7983,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
     }
 #endif /*CONFIG_USER_ONLY*/
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        define_arm_cp_regs(cpu, mte_reginfo);
+    }
 #endif
=20
     if (cpu_isar_feature(any_predinv, cpu)) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8fffb52203..6d86480043 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -830,6 +830,31 @@ static void gen_adc_CC(int sf, TCGv_i64 dest, TCGv_i=
64 t0, TCGv_i64 t1)
     }
 }
=20
+/* Extract an Allocation Tag from an address */
+static void gen_extract_tag(TCGv_i64 dest, TCGv_i64 source)
+{
+    TCGv_i64 sign =3D tcg_temp_new_i64();
+
+    /* See ARMv8.5-A AllocationTagFromAddress pseudocode */
+    tcg_gen_extract_i64(sign, source, 55, 1);
+    tcg_gen_extract_i64(dest, source, 56, 4);
+    tcg_gen_add_i64(dest, dest, sign);
+    tcg_gen_andi_i64(dest, dest, 0xf);
+    tcg_temp_free_i64(sign);
+}
+
+/* Deposit an Allocation Tag into an address */
+static void gen_deposit_tag(TCGv_i64 dest, TCGv_i64 source, TCGv_i64 tag=
)
+{
+    TCGv_i64 tmp =3D tcg_temp_new_i64();
+
+    /* See ARMv8.5-A AddressWithAllocationTag pseudocode */
+    tcg_gen_extract_i64(tmp, source, 55, 1);
+    tcg_gen_sub_i64(tmp, tag, tmp);
+    tcg_gen_deposit_i64(dest, source, tmp, 56, 4);
+    tcg_temp_free_i64(tmp);
+}
+
 /*
  * Load/Store generators
  */
@@ -1650,6 +1675,19 @@ static void handle_msr_i(DisasContext *s, uint32_t=
 insn,
         tcg_temp_free_i32(t1);
         break;
=20
+    case 0x1c: /* TCO */
+        if (!dc_isar_feature(aa64_mte, s)) {
+            unallocated_encoding(s);
+            return;
+        }
+        if (crm & 1) {
+            set_pstate_bits(PSTATE_TCO);
+        } else {
+            clear_pstate_bits(PSTATE_TCO);
+        }
+        s->base.is_jmp =3D DISAS_NEXT;
+        break;
+
     case 0x1e: /* DAIFSet */
         t1 =3D tcg_const_i32(crm);
         gen_helper_msr_i_daifset(cpu_env, t1);
@@ -2678,6 +2716,82 @@ static void disas_ld_lit(DisasContext *s, uint32_t=
 insn)
     tcg_temp_free_i64(clean_addr);
 }
=20
+/* LDG, LDGV(EL1), ST(Z)(2)G, STGV */
+static void disas_ldst_memtag(DisasContext *s, uint32_t insn)
+{
+    int opc =3D extract32(insn, 22, 2);
+    int op2 =3D extract32(insn, 10, 2);
+    bool tuple =3D opc & 2;
+    bool zero_data =3D opc & 1;
+    bool is_store =3D op2 !=3D 0;
+    bool postindex =3D op2 =3D=3D 1;
+    bool wback =3D op2 !=3D 2;
+    uint64_t offset =3D sextract64(insn, 12, 9) << ARM_LOG2_TAG_GRANULE;
+    int rn =3D extract32(insn, 5, 5);
+    int rt =3D extract32(insn, 0, 5);
+    TCGv_i64 tcg_addr;
+
+    if (!dc_isar_feature(aa64_mte, s) || extract32(insn, 30, 2) !=3D 3) =
{
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (op2 =3D=3D 0 && opc !=3D 1) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (rn =3D=3D 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    tcg_addr =3D read_cpu_reg_sp(s, rn, 1);
+
+    if (!postindex) {
+        tcg_gen_addi_i64(tcg_addr, tcg_addr, offset);
+    }
+
+    if (is_store) {
+        /* Store Allocation Tag (STG, ST2G, STZG, STZ2G) */
+        if (zero_data) {
+            TCGv_i64 ptr =3D tcg_temp_new_i64();
+            TCGv_i64 zero =3D tcg_const_i64(0);
+
+            do_gpr_st(s, zero, tcg_addr, 3, false, 0, false, false);
+            tcg_gen_addi_i64(ptr, tcg_addr, 8);
+            do_gpr_st(s, zero, ptr, 3, false, 0, false, false);
+
+            if (tuple) {
+                tcg_gen_addi_i64(ptr, ptr, 8);
+                do_gpr_st(s, zero, ptr, 3, false, 0, false, false);
+                tcg_gen_addi_i64(ptr, ptr, 8);
+                do_gpr_st(s, zero, ptr, 3, false, 0, false, false);
+            }
+
+            tcg_temp_free_i64(zero);
+            tcg_temp_free_i64(ptr);
+        }
+        /* Write access permission should be checked here.
+         * If zero_data is true, do_gpr_st() does it but elsewise not.
+         */
+
+        if (wback) {
+            if (postindex) {
+                tcg_gen_addi_i64(tcg_addr, tcg_addr, offset);
+            }
+            tcg_gen_mov_i64(cpu_reg_sp(s, rn), tcg_addr);
+        }
+    } else {
+        /* Load Allocation Tag (LDG) */
+        TCGv_i64 tcg_tag =3D tcg_const_i64(0);
+
+        tcg_gen_andi_i64(tcg_addr, tcg_addr, ~(ARM_TAG_GRANULE - 1));
+        /* In principles, read access permission should be checked here.=
 */
+        gen_deposit_tag(cpu_reg(s, rt), tcg_addr, tcg_tag);
+        tcg_temp_free_i64(tcg_tag);
+    }
+}
+
 /*
  * LDNP (Load Pair - non-temporal hint)
  * LDP (Load Pair - non vector)
@@ -2688,6 +2802,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t =
insn)
  * LDP (Load Pair of SIMD&FP)
  * STNP (Store Pair of SIMD&FP - non-temporal hint)
  * STP (Store Pair of SIMD&FP)
+ * STGP (Store Pair - allocate tag)
  *
  *  31 30 29   27  26  25 24   23  22 21   15 14   10 9    5 4    0
  * +-----+-------+---+---+-------+---+-----------------------------+
@@ -2736,8 +2851,12 @@ static void disas_ldst_pair(DisasContext *s, uint3=
2_t insn)
         size =3D 2 + extract32(opc, 1, 1);
         is_signed =3D extract32(opc, 0, 1);
         if (!is_load && is_signed) {
-            unallocated_encoding(s);
-            return;
+            if (size =3D=3D 3 || !dc_isar_feature(aa64_mte, s)) {
+                unallocated_encoding(s);
+                return;
+            }
+
+            size =3D 3; /* sic! */
         }
     }
=20
@@ -3728,12 +3847,15 @@ static void disas_ldst(DisasContext *s, uint32_t =
insn)
         disas_ldst_single_struct(s, insn);
         break;
     case 0x19: /* LDAPR/STLR (unscaled immediate) */
-        if (extract32(insn, 10, 2) !=3D 0 ||
-            extract32(insn, 21, 1) !=3D 0) {
+        if (extract32(insn, 10, 2) !=3D 0) {
             unallocated_encoding(s);
             break;
         }
-        disas_ldst_ldapr_stlr(s, insn);
+        if (extract32(insn, 21, 1) !=3D 0) {
+            disas_ldst_memtag(s, insn);
+        } else {
+            disas_ldst_ldapr_stlr(s, insn);
+        }
         break;
     default:
         unallocated_encoding(s);
@@ -3791,10 +3913,12 @@ static void disas_add_sub_imm(DisasContext *s, ui=
nt32_t insn)
     bool setflags =3D extract32(insn, 29, 1);
     bool sub_op =3D extract32(insn, 30, 1);
     bool is_64bit =3D extract32(insn, 31, 1);
+    bool memtag =3D false;
=20
     TCGv_i64 tcg_rn =3D cpu_reg_sp(s, rn);
     TCGv_i64 tcg_rd =3D setflags ? cpu_reg(s, rd) : cpu_reg_sp(s, rd);
     TCGv_i64 tcg_result;
+    TCGv_i64 tcg_rtag;
=20
     switch (shift) {
     case 0x0:
@@ -3802,11 +3926,23 @@ static void disas_add_sub_imm(DisasContext *s, ui=
nt32_t insn)
     case 0x1:
         imm <<=3D 12;
         break;
+    case 0x2:
+        memtag =3D true;
+
+        if (dc_isar_feature(aa64_mte, s) && is_64bit && !setflags) {
+            imm =3D extract32(imm, 6, 6) << ARM_LOG2_TAG_GRANULE;
+            break;
+        }
+        /* fall through */
     default:
         unallocated_encoding(s);
         return;
     }
=20
+    if (memtag) {
+        tcg_rtag =3D tcg_const_i64(0);
+    }
+
     tcg_result =3D tcg_temp_new_i64();
     if (!setflags) {
         if (sub_op) {
@@ -3824,6 +3960,11 @@ static void disas_add_sub_imm(DisasContext *s, uin=
t32_t insn)
         tcg_temp_free_i64(tcg_imm);
     }
=20
+    if (memtag) {
+        gen_deposit_tag(tcg_result, tcg_result, tcg_rtag);
+        tcg_temp_free_i64(tcg_rtag);
+    }
+
     if (is_64bit) {
         tcg_gen_mov_i64(tcg_rd, tcg_result);
     } else {
@@ -5281,6 +5422,72 @@ static void handle_crc32(DisasContext *s,
     tcg_temp_free_i32(tcg_bytes);
 }
=20
+/* SUBP, SUBPS (incl. CCMP) */
+static void handle_subp(DisasContext *s, bool setflags, unsigned int sf,
+                        unsigned int rm, unsigned int rn, unsigned int r=
d)
+{
+    TCGv_i64 tcg_addr1, tcg_addr2;
+    TCGv_i64 tcg_result;
+
+    if (!sf || !dc_isar_feature(aa64_mte, s)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    tcg_addr1 =3D tcg_temp_new_i64();
+    tcg_addr2 =3D tcg_temp_new_i64();
+    tcg_result =3D cpu_reg(s, rd);
+
+    tcg_gen_sextract_i64(tcg_addr1, cpu_reg_sp(s, rn), 0, 56);
+    tcg_gen_sextract_i64(tcg_addr2, cpu_reg_sp(s, rm), 0, 56);
+
+    if (setflags) {
+        gen_sub_CC(1, tcg_result, tcg_addr1, tcg_addr2);
+    } else {
+        tcg_gen_sub_i64(tcg_result, tcg_addr1, tcg_addr2);
+    }
+
+    tcg_temp_free_i64(tcg_addr2);
+    tcg_temp_free_i64(tcg_addr1);
+}
+
+static void handle_irg(DisasContext *s, unsigned int sf,
+                       unsigned int rm, unsigned int rn, unsigned int rd=
)
+{
+    TCGv_i64 rtag;
+
+    if (!sf || !dc_isar_feature(aa64_mte, s)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    rtag =3D tcg_temp_new_i64();
+    tcg_gen_movi_i64(rtag, 0);
+    gen_deposit_tag(cpu_reg_sp(s, rd), cpu_reg_sp(s, rn), rtag);
+    tcg_temp_free_i64(rtag);
+}
+
+static void handle_gmi(DisasContext *s, unsigned int sf,
+                       unsigned int rm, unsigned int rn, unsigned int rd=
)
+{
+    TCGv_i64 tcg_one, tcg_tag;
+
+    if (!sf || !dc_isar_feature(aa64_mte, s)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    tcg_one =3D tcg_const_i64(1);
+    tcg_tag =3D tcg_temp_new_i64();
+
+    gen_extract_tag(tcg_tag, cpu_reg_sp(s, rn));
+    tcg_gen_shl_i64(tcg_tag, tcg_one, tcg_tag);
+    tcg_gen_or_i64(cpu_reg(s, rd), cpu_reg(s, rm), tcg_tag);
+
+    tcg_temp_free_i64(tcg_tag);
+    tcg_temp_free_i64(tcg_one);
+}
+
 /* Data-processing (2 source)
  *   31   30  29 28             21 20  16 15    10 9    5 4    0
  * +----+---+---+-----------------+------+--------+------+------+
@@ -5297,17 +5504,32 @@ static void disas_data_proc_2src(DisasContext *s,=
 uint32_t insn)
     rd =3D extract32(insn, 0, 5);
=20
     if (extract32(insn, 29, 1)) {
-        unallocated_encoding(s);
-        return;
+        switch (opcode) {
+        case 0:
+            handle_subp(s, true, sf, rm, rn, rd);
+            break;
+        default:
+            unallocated_encoding(s);
+            return;
+        }
     }
=20
     switch (opcode) {
+    case 0:
+        handle_subp(s, false, sf, rm, rn, rd);
+        break;
     case 2: /* UDIV */
         handle_div(s, false, sf, rm, rn, rd);
         break;
     case 3: /* SDIV */
         handle_div(s, true, sf, rm, rn, rd);
         break;
+    case 4:
+        handle_irg(s, sf, rm, rn, rd);
+        break;
+    case 5:
+        handle_gmi(s, sf, rm, rn, rd);
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
--=20
2.25.1


