Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A346C35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD8F21927
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD8F21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izt53-0005zL-8G
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvb-0005rR-E9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvY-0001A5-9T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:31 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53087 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvX-00018W-Pw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:28 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id EFD291A2106;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id A26741A1FEC;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 12/32] target/avr: Add instruction translation - Branch
 Instructions
Date: Fri,  7 Feb 2020 02:57:40 +0100
Message-Id: <1581040680-308-13-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes:
    - RJMP, IJMP, EIJMP, JMP
    - RCALL, ICALL, EICALL, CALL
    - RET, RETI
    - CPSE, CP, CPC, CPI
    - SBRC, SBRS, SBIC, SBIS
    - BRBC, BRBS

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 target/avr/insn.decode |  33 +++
 target/avr/translate.c | 544 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 577 insertions(+)

diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 43baf6d..8b00d88 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -74,3 +74,36 @@ FMUL            0000 0011 0 ... 1 ...       @fmul
 FMULS           0000 0011 1 ... 0 ...       @fmul
 FMULSU          0000 0011 1 ... 1 ...       @fmul
 DES             1001 0100 imm:4 1011
+
+#
+# Branch Instructions
+#
+
+# The 22-bit immediate is partially in the opcode word,
+# and partially in the next.  Use append_16 to build the
+# complete 22-bit value.
+%imm_call       4:5 0:1                     !function=3Dappend_16
+
+@op_bit         .... .... . bit:3 ....
+@op_bit_imm     .... .. imm:s7 bit:3
+
+RJMP            1100 imm:s12
+IJMP            1001 0100 0000 1001
+EIJMP           1001 0100 0001 1001
+JMP             1001 010 ..... 110 .        imm=3D%imm_call
+RCALL           1101 imm:s12
+ICALL           1001 0101 0000 1001
+EICALL          1001 0101 0001 1001
+CALL            1001 010 ..... 111 .        imm=3D%imm_call
+RET             1001 0101 0000 1000
+RETI            1001 0101 0001 1000
+CPSE            0001 00 . ..... ....        @op_rd_rr
+CP              0001 01 . ..... ....        @op_rd_rr
+CPC             0000 01 . ..... ....        @op_rd_rr
+CPI             0011 .... .... ....         @op_rd_imm8
+SBRC            1111 110 rr:5 0 bit:3
+SBRS            1111 111 rr:5 0 bit:3
+SBIC            1001 1001 reg:5 bit:3
+SBIS            1001 1011 reg:5 bit:3
+BRBS            1111 00 ....... ...         @op_bit_imm
+BRBC            1111 01 ....... ...         @op_bit_imm
diff --git a/target/avr/translate.c b/target/avr/translate.c
index d81bfaa..6db9f74 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -145,6 +145,17 @@ static int to_regs_24_30_by_two(DisasContext *ctx, i=
nt indx)
 }
=20
=20
+static uint16_t next_word(DisasContext *ctx)
+{
+    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
+}
+
+static int append_16(DisasContext *ctx, int x)
+{
+    return x << 16 | next_word(ctx);
+}
+
+
 static bool avr_have_feature(DisasContext *ctx, int feature)
 {
     if (!avr_feature(ctx->env, feature)) {
@@ -964,3 +975,536 @@ static bool trans_DES(DisasContext *ctx, arg_DES *a=
)
=20
     return true;
 }
+
+/*
+ * Branch Instructions
+ */
+static void gen_jmp_ez(DisasContext *ctx)
+{
+    tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);
+    tcg_gen_or_tl(cpu_pc, cpu_pc, cpu_eind);
+    ctx->bstate =3D DISAS_LOOKUP;
+}
+
+static void gen_jmp_z(DisasContext *ctx)
+{
+    tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);
+    ctx->bstate =3D DISAS_LOOKUP;
+}
+
+static void gen_push_ret(DisasContext *ctx, int ret)
+{
+    if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
+
+        TCGv t0 =3D tcg_const_i32((ret & 0x0000ff));
+
+        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_UB);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+        tcg_temp_free_i32(t0);
+    } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
+
+        TCGv t0 =3D tcg_const_i32((ret & 0x00ffff));
+
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+        tcg_temp_free_i32(t0);
+
+    } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
+
+        TCGv lo =3D tcg_const_i32((ret & 0x0000ff));
+        TCGv hi =3D tcg_const_i32((ret & 0xffff00) >> 8);
+
+        tcg_gen_qemu_st_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
+        tcg_gen_qemu_st_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+        tcg_temp_free_i32(lo);
+        tcg_temp_free_i32(hi);
+    }
+}
+
+static void gen_pop_ret(DisasContext *ctx, TCGv ret)
+{
+    if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_UB);
+    } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+    } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
+        TCGv lo =3D tcg_temp_new_i32();
+        TCGv hi =3D tcg_temp_new_i32();
+
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+        tcg_gen_qemu_ld_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
+
+        tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
+        tcg_gen_qemu_ld_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
+
+        tcg_gen_deposit_tl(ret, lo, hi, 8, 16);
+
+        tcg_temp_free_i32(lo);
+        tcg_temp_free_i32(hi);
+    }
+}
+
+static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
+{
+    TranslationBlock *tb =3D ctx->tb;
+
+    if (ctx->singlestep =3D=3D 0) {
+        tcg_gen_goto_tb(n);
+        tcg_gen_movi_i32(cpu_pc, dest);
+        tcg_gen_exit_tb(tb, n);
+    } else {
+        tcg_gen_movi_i32(cpu_pc, dest);
+        gen_helper_debug(cpu_env);
+        tcg_gen_exit_tb(NULL, 0);
+    }
+    ctx->bstate =3D DISAS_NORETURN;
+}
+
+/*
+ *  Relative jump to an address within PC - 2K +1 and PC + 2K (words). F=
or
+ *  AVR microcontrollers with Program memory not exceeding 4K words (8KB=
) this
+ *  instruction can address the entire memory from every address locatio=
n. See
+ *  also JMP.
+ */
+static bool trans_RJMP(DisasContext *ctx, arg_RJMP *a)
+{
+    int dst =3D ctx->npc + a->imm;
+
+    gen_goto_tb(ctx, 0, dst);
+
+    return true;
+}
+
+/*
+ *  Indirect jump to the address pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File. The Z-pointer Register is 16 bits wid=
e and
+ *  allows jump within the lowest 64K words (128KB) section of Program m=
emory.
+ *  This instruction is not available in all devices. Refer to the devic=
e
+ *  specific instruction set summary.
+ */
+static bool trans_IJMP(DisasContext *ctx, arg_IJMP *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_IJMP_ICALL)) {
+        return true;
+    }
+
+    gen_jmp_z(ctx);
+
+    return true;
+}
+
+/*
+ *  Indirect jump to the address pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File and the EIND Register in the I/O space=
. This
+ *  instruction allows for indirect jumps to the entire 4M (words) Progr=
am
+ *  memory space. See also IJMP.  This instruction is not available in a=
ll
+ *  devices. Refer to the device specific instruction set summary.
+ */
+static bool trans_EIJMP(DisasContext *ctx, arg_EIJMP *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_EIJMP_EICALL)) {
+        return true;
+    }
+
+    gen_jmp_ez(ctx);
+    return true;
+}
+
+/*
+ *  Jump to an address within the entire 4M (words) Program memory. See =
also
+ *  RJMP.  This instruction is not available in all devices. Refer to th=
e device
+ *  specific instruction set summary.0
+ */
+static bool trans_JMP(DisasContext *ctx, arg_JMP *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_JMP_CALL)) {
+        return true;
+    }
+
+    gen_goto_tb(ctx, 0, a->imm);
+
+    return true;
+}
+
+/*
+ *  Relative call to an address within PC - 2K + 1 and PC + 2K (words). =
The
+ *  return address (the instruction after the RCALL) is stored onto the =
Stack.
+ *  See also CALL. For AVR microcontrollers with Program memory not exce=
eding 4K
+ *  words (8KB) this instruction can address the entire memory from ever=
y
+ *  address location. The Stack Pointer uses a post-decrement scheme dur=
ing
+ *  RCALL.
+ */
+static bool trans_RCALL(DisasContext *ctx, arg_RCALL *a)
+{
+    int ret =3D ctx->npc;
+    int dst =3D ctx->npc + a->imm;
+
+    gen_push_ret(ctx, ret);
+    gen_goto_tb(ctx, 0, dst);
+
+    return true;
+}
+
+/*
+ *  Calls to a subroutine within the entire 4M (words) Program memory. T=
he
+ *  return address (to the instruction after the CALL) will be stored on=
to the
+ *  Stack. See also RCALL. The Stack Pointer uses a post-decrement schem=
e during
+ *  CALL.  This instruction is not available in all devices. Refer to th=
e device
+ *  specific instruction set summary.
+ */
+static bool trans_ICALL(DisasContext *ctx, arg_ICALL *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_IJMP_ICALL)) {
+        return true;
+    }
+
+    int ret =3D ctx->npc;
+
+    gen_push_ret(ctx, ret);
+    gen_jmp_z(ctx);
+
+    return true;
+}
+
+/*
+ *  Indirect call of a subroutine pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File and the EIND Register in the I/O space=
. This
+ *  instruction allows for indirect calls to the entire 4M (words) Progr=
am
+ *  memory space. See also ICALL. The Stack Pointer uses a post-decremen=
t scheme
+ *  during EICALL.  This instruction is not available in all devices. Re=
fer to
+ *  the device specific instruction set summary.
+ */
+static bool trans_EICALL(DisasContext *ctx, arg_EICALL *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_EIJMP_EICALL)) {
+        return true;
+    }
+
+    int ret =3D ctx->npc;
+
+    gen_push_ret(ctx, ret);
+    gen_jmp_ez(ctx);
+    return true;
+}
+
+/*
+ *  Calls to a subroutine within the entire Program memory. The return
+ *  address (to the instruction after the CALL) will be stored onto the =
Stack.
+ *  (See also RCALL). The Stack Pointer uses a post-decrement scheme dur=
ing
+ *  CALL.  This instruction is not available in all devices. Refer to th=
e device
+ *  specific instruction set summary.
+ */
+static bool trans_CALL(DisasContext *ctx, arg_CALL *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_JMP_CALL)) {
+        return true;
+    }
+
+    int Imm =3D a->imm;
+    int ret =3D ctx->npc;
+
+    gen_push_ret(ctx, ret);
+    gen_goto_tb(ctx, 0, Imm);
+
+    return true;
+}
+
+/*
+ *  Returns from subroutine. The return address is loaded from the STACK=
.
+ *  The Stack Pointer uses a preincrement scheme during RET.
+ */
+static bool trans_RET(DisasContext *ctx, arg_RET *a)
+{
+    gen_pop_ret(ctx, cpu_pc);
+
+    ctx->bstate =3D DISAS_LOOKUP;
+    return true;
+}
+
+/*
+ *  Returns from interrupt. The return address is loaded from the STACK =
and
+ *  the Global Interrupt Flag is set.  Note that the Status Register is =
not
+ *  automatically stored when entering an interrupt routine, and it is n=
ot
+ *  restored when returning from an interrupt routine. This must be hand=
led by
+ *  the application program. The Stack Pointer uses a pre-increment sche=
me
+ *  during RETI.
+ */
+static bool trans_RETI(DisasContext *ctx, arg_RETI *a)
+{
+    gen_pop_ret(ctx, cpu_pc);
+    tcg_gen_movi_tl(cpu_If, 1);
+
+    /* Need to return to main loop to re-evaluate interrupts.  */
+    ctx->bstate =3D DISAS_EXIT;
+    return true;
+}
+
+/*
+ *  This instruction performs a compare between two registers Rd and Rr,=
 and
+ *  skips the next instruction if Rd =3D Rr.
+ */
+static bool trans_CPSE(DisasContext *ctx, arg_CPSE *a)
+{
+    ctx->skip_cond =3D TCG_COND_EQ;
+    ctx->skip_var0 =3D cpu_r[a->rd];
+    ctx->skip_var1 =3D cpu_r[a->rr];
+    return true;
+}
+
+/*
+ *  This instruction performs a compare between two registers Rd and Rr.
+ *  None of the registers are changed. All conditional branches can be u=
sed
+ *  after this instruction.
+ */
+static bool trans_CP(DisasContext *ctx, arg_CP *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv Rr =3D cpu_r[a->rr];
+    TCGv R =3D tcg_temp_new_i32();
+
+    tcg_gen_sub_tl(R, Rd, Rr); /* R =3D Rd - Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    /* update status register */
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+/*
+ *  This instruction performs a compare between two registers Rd and Rr =
and
+ *  also takes into account the previous carry. None of the registers ar=
e
+ *  changed. All conditional branches can be used after this instruction=
.
+ */
+static bool trans_CPC(DisasContext *ctx, arg_CPC *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv Rr =3D cpu_r[a->rr];
+    TCGv R =3D tcg_temp_new_i32();
+    TCGv zero =3D tcg_const_i32(0);
+
+    tcg_gen_sub_tl(R, Rd, Rr); /* R =3D Rd - Rr - Cf */
+    tcg_gen_sub_tl(R, R, cpu_Cf);
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+    /* update status register */
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_NSf(R);
+
+    /*
+     * Previous value remains unchanged when the result is zero;
+     * cleared otherwise.
+     */
+    tcg_gen_movcond_tl(TCG_COND_EQ, cpu_Zf, R, zero, cpu_Zf, zero);
+
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(R);
+
+    return true;
+}
+
+/*
+ *  This instruction performs a compare between register Rd and a consta=
nt.
+ *  The register is not changed. All conditional branches can be used af=
ter this
+ *  instruction.
+ */
+static bool trans_CPI(DisasContext *ctx, arg_CPI *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    int Imm =3D a->imm;
+    TCGv Rr =3D tcg_const_i32(Imm);
+    TCGv R =3D tcg_temp_new_i32();
+
+    tcg_gen_sub_tl(R, Rd, Rr); /* R =3D Rd - Rr */
+    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
+
+    /* update status register */
+    gen_sub_CHf(R, Rd, Rr);
+    gen_sub_Vf(R, Rd, Rr);
+    gen_ZNSf(R);
+
+    tcg_temp_free_i32(R);
+    tcg_temp_free_i32(Rr);
+
+    return true;
+}
+
+/*
+ *  This instruction tests a single bit in a register and skips the next
+ *  instruction if the bit is cleared.
+ */
+static bool trans_SBRC(DisasContext *ctx, arg_SBRC *a)
+{
+    TCGv Rr =3D cpu_r[a->rr];
+
+    ctx->skip_cond =3D TCG_COND_EQ;
+    ctx->skip_var0 =3D tcg_temp_new();
+    ctx->free_skip_var0 =3D true;
+
+    tcg_gen_andi_tl(ctx->skip_var0, Rr, 1 << a->bit);
+    return true;
+}
+
+/*
+ *  This instruction tests a single bit in a register and skips the next
+ *  instruction if the bit is set.
+ */
+static bool trans_SBRS(DisasContext *ctx, arg_SBRS *a)
+{
+    TCGv Rr =3D cpu_r[a->rr];
+
+    ctx->skip_cond =3D TCG_COND_NE;
+    ctx->skip_var0 =3D tcg_temp_new();
+    ctx->free_skip_var0 =3D true;
+
+    tcg_gen_andi_tl(ctx->skip_var0, Rr, 1 << a->bit);
+    return true;
+}
+
+/*
+ *  This instruction tests a single bit in an I/O Register and skips the
+ *  next instruction if the bit is cleared. This instruction operates on=
 the
+ *  lower 32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_SBIC(DisasContext *ctx, arg_SBIC *a)
+{
+    TCGv temp =3D tcg_const_i32(a->reg);
+
+    gen_helper_inb(temp, cpu_env, temp);
+    tcg_gen_andi_tl(temp, temp, 1 << a->bit);
+    ctx->skip_cond =3D TCG_COND_EQ;
+    ctx->skip_var0 =3D temp;
+    ctx->free_skip_var0 =3D true;
+
+    return true;
+}
+
+/*
+ *  This instruction tests a single bit in an I/O Register and skips the
+ *  next instruction if the bit is set. This instruction operates on the=
 lower
+ *  32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_SBIS(DisasContext *ctx, arg_SBIS *a)
+{
+    TCGv temp =3D tcg_const_i32(a->reg);
+
+    gen_helper_inb(temp, cpu_env, temp);
+    tcg_gen_andi_tl(temp, temp, 1 << a->bit);
+    ctx->skip_cond =3D TCG_COND_NE;
+    ctx->skip_var0 =3D temp;
+    ctx->free_skip_var0 =3D true;
+
+    return true;
+}
+
+/*
+ *  Conditional relative branch. Tests a single bit in SREG and branches
+ *  relatively to PC if the bit is cleared. This instruction branches re=
latively
+ *  to PC in either direction (PC - 63 < =3D destination <=3D PC + 64). =
The
+ *  parameter k is the offset from PC and is represented in two's comple=
ment
+ *  form.
+ */
+static bool trans_BRBC(DisasContext *ctx, arg_BRBC *a)
+{
+    TCGLabel *not_taken =3D gen_new_label();
+
+    TCGv var;
+
+    switch (a->bit) {
+    case 0x00:
+        var =3D cpu_Cf;
+        break;
+    case 0x01:
+        var =3D cpu_Zf;
+        break;
+    case 0x02:
+        var =3D cpu_Nf;
+        break;
+    case 0x03:
+        var =3D cpu_Vf;
+        break;
+    case 0x04:
+        var =3D cpu_Sf;
+        break;
+    case 0x05:
+        var =3D cpu_Hf;
+        break;
+    case 0x06:
+        var =3D cpu_Tf;
+        break;
+    case 0x07:
+        var =3D cpu_If;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_gen_brcondi_i32(TCG_COND_NE, var, 0, not_taken);
+    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
+    gen_set_label(not_taken);
+
+    ctx->bstate =3D DISAS_CHAIN;
+    return true;
+}
+
+/*
+ *  Conditional relative branch. Tests a single bit in SREG and branches
+ *  relatively to PC if the bit is set. This instruction branches relati=
vely to
+ *  PC in either direction (PC - 63 < =3D destination <=3D PC + 64). The=
 parameter k
+ *  is the offset from PC and is represented in two's complement form.
+ */
+static bool trans_BRBS(DisasContext *ctx, arg_BRBS *a)
+{
+    TCGLabel *not_taken =3D gen_new_label();
+
+    TCGv var;
+
+    switch (a->bit) {
+    case 0x00:
+        var =3D cpu_Cf;
+        break;
+    case 0x01:
+        var =3D cpu_Zf;
+        break;
+    case 0x02:
+        var =3D cpu_Nf;
+        break;
+    case 0x03:
+        var =3D cpu_Vf;
+        break;
+    case 0x04:
+        var =3D cpu_Sf;
+        break;
+    case 0x05:
+        var =3D cpu_Hf;
+        break;
+    case 0x06:
+        var =3D cpu_Tf;
+        break;
+    case 0x07:
+        var =3D cpu_If;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_gen_brcondi_i32(TCG_COND_EQ, var, 0, not_taken);
+    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
+    gen_set_label(not_taken);
+
+    ctx->bstate =3D DISAS_CHAIN;
+    return true;
+}
--=20
2.7.4


