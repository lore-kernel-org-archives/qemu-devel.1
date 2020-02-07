Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E96C352A3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B609821D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B609821D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iztAP-0008Ke-SS
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvr-0006Xs-3d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvi-0001KP-OA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:47 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53099 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvi-00018v-4T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 59F201A210C;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B2EF51A20DA;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 13/32] target/avr: Add instruction translation - Data
 Transfer Instructions
Date: Fri,  7 Feb 2020 02:57:41 +0100
Message-Id: <1581040680-308-14-git-send-email-aleksandar.markovic@rt-rk.com>
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
    - MOV, MOVW
    - LDI, LDS LDX LDY LDZ
    - LDDY, LDDZ
    - STS, STX STY STZ
    - STDY, STDZ
    - LPM, LPMX
    - ELPM, ELPMX
    - SPM, SPMX
    - IN, OUT
    - PUSH, POP
    - XCH
    - LAS, LAC LAT

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 target/avr/insn.decode |  56 +++
 target/avr/translate.c | 992 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 1048 insertions(+)

diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 8b00d88..341b552 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -107,3 +107,59 @@ SBIC            1001 1001 reg:5 bit:3
 SBIS            1001 1011 reg:5 bit:3
 BRBS            1111 00 ....... ...         @op_bit_imm
 BRBC            1111 01 ....... ...         @op_bit_imm
+
+#
+# Data Transfer Instructions
+#
+
+%rd_d           4:4                         !function=3Dto_regs_00_30_by=
_two
+%rr_d           0:4                         !function=3Dto_regs_00_30_by=
_two
+
+@io_rd_imm      .... . .. ..... ....        &rd_imm     rd=3D%rd imm=3D%=
io_imm
+@ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=3D%ldst_d_im=
m
+
+# The 16-bit immediate is completely in the next word.
+# Fields cannot be defined with no bits, so we cannot play
+# the same trick and append to a zero-bit value.
+# Defer reading the immediate until trans_{LDS,STS}.
+@ldst_s         .... ... rd:5 ....          imm=3D0
+
+MOV             0010 11 . ..... ....        @op_rd_rr
+MOVW            0000 0001 .... ....         &rd_rr      rd=3D%rd_d rr=3D=
%rr_d
+LDI             1110 .... .... ....         @op_rd_imm8
+LDS             1001 000 ..... 0000         @ldst_s
+LDX1            1001 000 rd:5 1100
+LDX2            1001 000 rd:5 1101
+LDX3            1001 000 rd:5 1110
+LDY2            1001 000 rd:5 1001
+LDY3            1001 000 rd:5 1010
+LDZ2            1001 000 rd:5 0001
+LDZ3            1001 000 rd:5 0010
+LDDY            10 . 0 .. 0 ..... 1 ...     @ldst_d
+LDDZ            10 . 0 .. 0 ..... 0 ...     @ldst_d
+STS             1001 001 ..... 0000         @ldst_s
+STX1            1001 001 rr:5 1100
+STX2            1001 001 rr:5 1101
+STX3            1001 001 rr:5 1110
+STY2            1001 001 rd:5 1001
+STY3            1001 001 rd:5 1010
+STZ2            1001 001 rd:5 0001
+STZ3            1001 001 rd:5 0010
+STDY            10 . 0 .. 1 ..... 1 ...     @ldst_d
+STDZ            10 . 0 .. 1 ..... 0 ...     @ldst_d
+LPM1            1001 0101 1100 1000
+LPM2            1001 000 rd:5 0100
+LPMX            1001 000 rd:5 0101
+ELPM1           1001 0101 1101 1000
+ELPM2           1001 000 rd:5 0110
+ELPMX           1001 000 rd:5 0111
+SPM             1001 0101 1110 1000
+SPMX            1001 0101 1111 1000
+IN              1011 0 .. ..... ....        @io_rd_imm
+OUT             1011 1 .. ..... ....        @io_rd_imm
+PUSH            1001 001 rd:5 1111
+POP             1001 000 rd:5 1111
+XCH             1001 001 rd:5 0100
+LAC             1001 001 rd:5 0110
+LAS             1001 001 rd:5 0101
+LAT             1001 001 rd:5 0111
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 6db9f74..63b4e16 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -144,6 +144,11 @@ static int to_regs_24_30_by_two(DisasContext *ctx, i=
nt indx)
     return 24 + (indx % 4) * 2;
 }
=20
+static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
+{
+    return (indx % 16) * 2;
+}
+
=20
 static uint16_t next_word(DisasContext *ctx)
 {
@@ -1508,3 +1513,990 @@ static bool trans_BRBS(DisasContext *ctx, arg_BRB=
S *a)
     ctx->bstate =3D DISAS_CHAIN;
     return true;
 }
+
+/*
+ * Data Transfer Instructions
+ */
+
+/*
+ *  in the gen_set_addr & gen_get_addr functions
+ *  H assumed to be in 0x00ff0000 format
+ *  M assumed to be in 0x000000ff format
+ *  L assumed to be in 0x000000ff format
+ */
+static void gen_set_addr(TCGv addr, TCGv H, TCGv M, TCGv L)
+{
+
+    tcg_gen_andi_tl(L, addr, 0x000000ff);
+
+    tcg_gen_andi_tl(M, addr, 0x0000ff00);
+    tcg_gen_shri_tl(M, M, 8);
+
+    tcg_gen_andi_tl(H, addr, 0x00ff0000);
+}
+
+static void gen_set_xaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampX, cpu_r[27], cpu_r[26]);
+}
+
+static void gen_set_yaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampY, cpu_r[29], cpu_r[28]);
+}
+
+static void gen_set_zaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampZ, cpu_r[31], cpu_r[30]);
+}
+
+static TCGv gen_get_addr(TCGv H, TCGv M, TCGv L)
+{
+    TCGv addr =3D tcg_temp_new_i32();
+
+    tcg_gen_deposit_tl(addr, M, H, 8, 8);
+    tcg_gen_deposit_tl(addr, L, addr, 8, 16);
+
+    return addr;
+}
+
+static TCGv gen_get_xaddr(void)
+{
+    return gen_get_addr(cpu_rampX, cpu_r[27], cpu_r[26]);
+}
+
+static TCGv gen_get_yaddr(void)
+{
+    return gen_get_addr(cpu_rampY, cpu_r[29], cpu_r[28]);
+}
+
+static TCGv gen_get_zaddr(void)
+{
+    return gen_get_addr(cpu_rampZ, cpu_r[31], cpu_r[30]);
+}
+
+/*
+ *  Load one byte indirect from data space to register and stores an cle=
ar
+ *  the bits in data space specified by the register. The instruction ca=
n only
+ *  be used towards internal SRAM.  The data location is pointed to by t=
he Z (16
+ *  bits) Pointer Register in the Register File. Memory access is limite=
d to the
+ *  current data segment of 64KB. To access another data segment in devi=
ces with
+ *  more than 64KB data space, the RAMPZ in register in the I/O area has=
 to be
+ *  changed.  The Z-pointer Register is left unchanged by the operation.=
 This
+ *  instruction is especially suited for clearing status bits stored in =
SRAM.
+ */
+static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)
+{
+    if (ctx->tb->flags & TB_FLAGS_FULL_ACCESS) {
+        gen_helper_fullwr(cpu_env, data, addr);
+    } else {
+        tcg_gen_qemu_st8(data, addr, MMU_DATA_IDX); /* mem[addr] =3D dat=
a */
+    }
+}
+
+static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
+{
+    if (ctx->tb->flags & TB_FLAGS_FULL_ACCESS) {
+        gen_helper_fullrd(data, cpu_env, addr);
+    } else {
+        tcg_gen_qemu_ld8u(data, addr, MMU_DATA_IDX); /* data =3D mem[add=
r] */
+    }
+}
+
+/*
+ *  This instruction makes a copy of one register into another. The sour=
ce
+ *  register Rr is left unchanged, while the destination register Rd is =
loaded
+ *  with a copy of Rr.
+ */
+static bool trans_MOV(DisasContext *ctx, arg_MOV *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv Rr =3D cpu_r[a->rr];
+
+    tcg_gen_mov_tl(Rd, Rr);
+
+    return true;
+}
+
+/*
+ *  This instruction makes a copy of one register pair into another regi=
ster
+ *  pair. The source register pair Rr+1:Rr is left unchanged, while the
+ *  destination register pair Rd+1:Rd is loaded with a copy of Rr + 1:Rr=
.  This
+ *  instruction is not available in all devices. Refer to the device spe=
cific
+ *  instruction set summary.
+ */
+static bool trans_MOVW(DisasContext *ctx, arg_MOVW *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MOVW)) {
+        return true;
+    }
+
+    TCGv RdL =3D cpu_r[a->rd];
+    TCGv RdH =3D cpu_r[a->rd + 1];
+    TCGv RrL =3D cpu_r[a->rr];
+    TCGv RrH =3D cpu_r[a->rr + 1];
+
+    tcg_gen_mov_tl(RdH, RrH);
+    tcg_gen_mov_tl(RdL, RrL);
+
+    return true;
+}
+
+/*
+ * Loads an 8 bit constant directly to register 16 to 31.
+ */
+static bool trans_LDI(DisasContext *ctx, arg_LDI *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    int imm =3D a->imm;
+
+    tcg_gen_movi_tl(Rd, imm);
+
+    return true;
+}
+
+/*
+ *  Loads one byte from the data space to a register. For parts with SRA=
M,
+ *  the data space consists of the Register File, I/O memory and interna=
l SRAM
+ *  (and external SRAM if applicable). For parts without SRAM, the data =
space
+ *  consists of the register file only. The EEPROM has a separate addres=
s space.
+ *  A 16-bit address must be supplied. Memory access is limited to the c=
urrent
+ *  data segment of 64KB. The LDS instruction uses the RAMPD Register to=
 access
+ *  memory above 64KB. To access another data segment in devices with mo=
re than
+ *  64KB data space, the RAMPD in register in the I/O area has to be cha=
nged.
+ *  This instruction is not available in all devices. Refer to the devic=
e
+ *  specific instruction set summary.
+ */
+static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D tcg_temp_new_i32();
+    TCGv H =3D cpu_rampD;
+    a->imm =3D next_word(ctx);
+
+    tcg_gen_mov_tl(addr, H); /* addr =3D H:M:L */
+    tcg_gen_shli_tl(addr, addr, 16);
+    tcg_gen_ori_tl(addr, addr, a->imm);
+
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Loads one byte indirect from the data space to a register. For parts
+ *  with SRAM, the data space consists of the Register File, I/O memory =
and
+ *  internal SRAM (and external SRAM if applicable). For parts without S=
RAM, the
+ *  data space consists of the Register File only. In some parts the Fla=
sh
+ *  Memory has been mapped to the data space and can be read using this =
command.
+ *  The EEPROM has a separate address space.  The data location is point=
ed to by
+ *  the X (16 bits) Pointer Register in the Register File. Memory access=
 is
+ *  limited to the current data segment of 64KB. To access another data =
segment
+ *  in devices with more than 64KB data space, the RAMPX in register in =
the I/O
+ *  area has to be changed.  The X-pointer Register can either be left u=
nchanged
+ *  by the operation, or it can be post-incremented or predecremented.  =
These
+ *  features are especially suited for accessing arrays, tables, and Sta=
ck
+ *  Pointer usage of the X-pointer Register. Note that only the low byte=
 of the
+ *  X-pointer is updated in devices with no more than 256 bytes data spa=
ce. For
+ *  such devices, the high byte of the pointer is not used by this instr=
uction
+ *  and can be used for other purposes. The RAMPX Register in the I/O ar=
ea is
+ *  updated in parts with more than 64KB data space or more than 64KB Pr=
ogram
+ *  memory, and the increment/decrement is added to the entire 24-bit ad=
dress on
+ *  such devices.  Not all variants of this instruction is available in =
all
+ *  devices. Refer to the device specific instruction set summary.  In t=
he
+ *  Reduced Core tinyAVR the LD instruction can be used to achieve the s=
ame
+ *  operation as LPM since the program memory is mapped to the data memo=
ry
+ *  space.
+ */
+static bool trans_LDX1(DisasContext *ctx, arg_LDX1 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_xaddr();
+
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDX2(DisasContext *ctx, arg_LDX2 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_xaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */
+
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDX3(DisasContext *ctx, arg_LDX3 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_xaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Loads one byte indirect with or without displacement from the data s=
pace
+ *  to a register. For parts with SRAM, the data space consists of the R=
egister
+ *  File, I/O memory and internal SRAM (and external SRAM if applicable)=
. For
+ *  parts without SRAM, the data space consists of the Register File onl=
y. In
+ *  some parts the Flash Memory has been mapped to the data space and ca=
n be
+ *  read using this command. The EEPROM has a separate address space.  T=
he data
+ *  location is pointed to by the Y (16 bits) Pointer Register in the Re=
gister
+ *  File. Memory access is limited to the current data segment of 64KB. =
To
+ *  access another data segment in devices with more than 64KB data spac=
e, the
+ *  RAMPY in register in the I/O area has to be changed.  The Y-pointer =
Register
+ *  can either be left unchanged by the operation, or it can be post-inc=
remented
+ *  or predecremented.  These features are especially suited for accessi=
ng
+ *  arrays, tables, and Stack Pointer usage of the Y-pointer Register. N=
ote that
+ *  only the low byte of the Y-pointer is updated in devices with no mor=
e than
+ *  256 bytes data space. For such devices, the high byte of the pointer=
 is not
+ *  used by this instruction and can be used for other purposes. The RAM=
PY
+ *  Register in the I/O area is updated in parts with more than 64KB dat=
a space
+ *  or more than 64KB Program memory, and the increment/decrement/displa=
cement
+ *  is added to the entire 24-bit address on such devices.  Not all vari=
ants of
+ *  this instruction is available in all devices. Refer to the device sp=
ecific
+ *  instruction set summary.  In the Reduced Core tinyAVR the LD instruc=
tion can
+ *  be used to achieve the same operation as LPM since the program memor=
y is
+ *  mapped to the data memory space.
+ */
+static bool trans_LDY2(DisasContext *ctx, arg_LDY2 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_yaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */
+
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDY3(DisasContext *ctx, arg_LDY3 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_yaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDDY(DisasContext *ctx, arg_LDDY *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_yaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr =3D addr + q */
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Loads one byte indirect with or without displacement from the data s=
pace
+ *  to a register. For parts with SRAM, the data space consists of the R=
egister
+ *  File, I/O memory and internal SRAM (and external SRAM if applicable)=
. For
+ *  parts without SRAM, the data space consists of the Register File onl=
y. In
+ *  some parts the Flash Memory has been mapped to the data space and ca=
n be
+ *  read using this command. The EEPROM has a separate address space.  T=
he data
+ *  location is pointed to by the Z (16 bits) Pointer Register in the Re=
gister
+ *  File. Memory access is limited to the current data segment of 64KB. =
To
+ *  access another data segment in devices with more than 64KB data spac=
e, the
+ *  RAMPZ in register in the I/O area has to be changed.  The Z-pointer =
Register
+ *  can either be left unchanged by the operation, or it can be post-inc=
remented
+ *  or predecremented.  These features are especially suited for Stack P=
ointer
+ *  usage of the Z-pointer Register, however because the Z-pointer Regis=
ter can
+ *  be used for indirect subroutine calls, indirect jumps and table look=
up, it
+ *  is often more convenient to use the X or Y-pointer as a dedicated St=
ack
+ *  Pointer. Note that only the low byte of the Z-pointer is updated in =
devices
+ *  with no more than 256 bytes data space. For such devices, the high b=
yte of
+ *  the pointer is not used by this instruction and can be used for othe=
r
+ *  purposes. The RAMPZ Register in the I/O area is updated in parts wit=
h more
+ *  than 64KB data space or more than 64KB Program memory, and the
+ *  increment/decrement/displacement is added to the entire 24-bit addre=
ss on
+ *  such devices.  Not all variants of this instruction is available in =
all
+ *  devices. Refer to the device specific instruction set summary.  In t=
he
+ *  Reduced Core tinyAVR the LD instruction can be used to achieve the s=
ame
+ *  operation as LPM since the program memory is mapped to the data memo=
ry
+ *  space.  For using the Z-pointer for table lookup in Program memory s=
ee the
+ *  LPM and ELPM instructions.
+ */
+static bool trans_LDZ2(DisasContext *ctx, arg_LDZ2 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDZ3(DisasContext *ctx, arg_LDZ3 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDDZ(DisasContext *ctx, arg_LDDZ *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr =3D addr + q */
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Stores one byte from a Register to the data space. For parts with SR=
AM,
+ *  the data space consists of the Register File, I/O memory and interna=
l SRAM
+ *  (and external SRAM if applicable). For parts without SRAM, the data =
space
+ *  consists of the Register File only. The EEPROM has a separate addres=
s space.
+ *  A 16-bit address must be supplied. Memory access is limited to the c=
urrent
+ *  data segment of 64KB. The STS instruction uses the RAMPD Register to=
 access
+ *  memory above 64KB. To access another data segment in devices with mo=
re than
+ *  64KB data space, the RAMPD in register in the I/O area has to be cha=
nged.
+ *  This instruction is not available in all devices. Refer to the devic=
e
+ *  specific instruction set summary.
+ */
+static bool trans_STS(DisasContext *ctx, arg_STS *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D tcg_temp_new_i32();
+    TCGv H =3D cpu_rampD;
+    a->imm =3D next_word(ctx);
+
+    tcg_gen_mov_tl(addr, H); /* addr =3D H:M:L */
+    tcg_gen_shli_tl(addr, addr, 16);
+    tcg_gen_ori_tl(addr, addr, a->imm);
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ * Stores one byte indirect from a register to data space. For parts wit=
h SRAM,
+ * the data space consists of the Register File, I/O memory, and interna=
l SRAM
+ * (and external SRAM if applicable). For parts without SRAM, the data s=
pace
+ * consists of the Register File only. The EEPROM has a separate address=
 space.
+ *
+ * The data location is pointed to by the X (16 bits) Pointer Register i=
n the
+ * Register File. Memory access is limited to the current data segment o=
f 64KB.
+ * To access another data segment in devices with more than 64KB data sp=
ace, the
+ * RAMPX in register in the I/O area has to be changed.
+ *
+ * The X-pointer Register can either be left unchanged by the operation,=
 or it
+ * can be post-incremented or pre-decremented. These features are especi=
ally
+ * suited for accessing arrays, tables, and Stack Pointer usage of the
+ * X-pointer Register. Note that only the low byte of the X-pointer is u=
pdated
+ * in devices with no more than 256 bytes data space. For such devices, =
the high
+ * byte of the pointer is not used by this instruction and can be used f=
or other
+ * purposes. The RAMPX Register in the I/O area is updated in parts with=
 more
+ * than 64KB data space or more than 64KB Program memory, and the increm=
ent /
+ * decrement is added to the entire 24-bit address on such devices.
+ */
+static bool trans_STX1(DisasContext *ctx, arg_STX1 *a)
+{
+    TCGv Rd =3D cpu_r[a->rr];
+    TCGv addr =3D gen_get_xaddr();
+
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STX2(DisasContext *ctx, arg_STX2 *a)
+{
+    TCGv Rd =3D cpu_r[a->rr];
+    TCGv addr =3D gen_get_xaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STX3(DisasContext *ctx, arg_STX3 *a)
+{
+    TCGv Rd =3D cpu_r[a->rr];
+    TCGv addr =3D gen_get_xaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ * Stores one byte indirect with or without displacement from a register=
 to data
+ * space. For parts with SRAM, the data space consists of the Register F=
ile, I/O
+ * memory, and internal SRAM (and external SRAM if applicable). For part=
s
+ * without SRAM, the data space consists of the Register File only. The =
EEPROM
+ * has a separate address space.
+ *
+ * The data location is pointed to by the Y (16 bits) Pointer Register i=
n the
+ * Register File. Memory access is limited to the current data segment o=
f 64KB.
+ * To access another data segment in devices with more than 64KB data sp=
ace, the
+ * RAMPY in register in the I/O area has to be changed.
+ *
+ * The Y-pointer Register can either be left unchanged by the operation,=
 or it
+ * can be post-incremented or pre-decremented. These features are especi=
ally
+ * suited for accessing arrays, tables, and Stack Pointer usage of the Y=
-pointer
+ * Register. Note that only the low byte of the Y-pointer is updated in =
devices
+ * with no more than 256 bytes data space. For such devices, the high by=
te of
+ * the pointer is not used by this instruction and can be used for other
+ * purposes. The RAMPY Register in the I/O area is updated in parts with=
 more
+ * than 64KB data space or more than 64KB Program memory, and the increm=
ent /
+ * decrement / displacement is added to the entire 24-bit address on suc=
h
+ * devices.
+ */
+static bool trans_STY2(DisasContext *ctx, arg_STY2 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_yaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STY3(DisasContext *ctx, arg_STY3 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_yaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STDY(DisasContext *ctx, arg_STDY *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_yaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr =3D addr + q */
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ * Stores one byte indirect with or without displacement from a register=
 to data
+ * space. For parts with SRAM, the data space consists of the Register F=
ile, I/O
+ * memory, and internal SRAM (and external SRAM if applicable). For part=
s
+ * without SRAM, the data space consists of the Register File only. The =
EEPROM
+ * has a separate address space.
+ *
+ * The data location is pointed to by the Y (16 bits) Pointer Register i=
n the
+ * Register File. Memory access is limited to the current data segment o=
f 64KB.
+ * To access another data segment in devices with more than 64KB data sp=
ace, the
+ * RAMPY in register in the I/O area has to be changed.
+ *
+ * The Y-pointer Register can either be left unchanged by the operation,=
 or it
+ * can be post-incremented or pre-decremented. These features are especi=
ally
+ * suited for accessing arrays, tables, and Stack Pointer usage of the Y=
-pointer
+ * Register. Note that only the low byte of the Y-pointer is updated in =
devices
+ * with no more than 256 bytes data space. For such devices, the high by=
te of
+ * the pointer is not used by this instruction and can be used for other
+ * purposes. The RAMPY Register in the I/O area is updated in parts with=
 more
+ * than 64KB data space or more than 64KB Program memory, and the increm=
ent /
+ * decrement / displacement is added to the entire 24-bit address on suc=
h
+ * devices.
+ */
+static bool trans_STZ2(DisasContext *ctx, arg_STZ2 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STZ3(DisasContext *ctx, arg_STZ3 *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STDZ(DisasContext *ctx, arg_STDZ *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr =3D addr + q */
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Loads one byte pointed to by the Z-register into the destination
+ *  register Rd. This instruction features a 100% space effective consta=
nt
+ *  initialization or constant data fetch. The Program memory is organiz=
ed in
+ *  16-bit words while the Z-pointer is a byte address. Thus, the least
+ *  significant bit of the Z-pointer selects either low byte (ZLSB =3D 0=
) or high
+ *  byte (ZLSB =3D 1). This instruction can address the first 64KB (32K =
words) of
+ *  Program memory. The Zpointer Register can either be left unchanged b=
y the
+ *  operation, or it can be incremented. The incrementation does not app=
ly to
+ *  the RAMPZ Register.
+ *
+ *  Devices with Self-Programming capability can use the LPM instruction=
 to read
+ *  the Fuse and Lock bit values.
+ */
+static bool trans_LPM1(DisasContext *ctx, arg_LPM1 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
+        return true;
+    }
+
+    TCGv Rd =3D cpu_r[0];
+    TCGv addr =3D tcg_temp_new_i32();
+    TCGv H =3D cpu_r[31];
+    TCGv L =3D cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */
+    tcg_gen_or_tl(addr, addr, L);
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LPM2(DisasContext *ctx, arg_LPM2 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
+        return true;
+    }
+
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D tcg_temp_new_i32();
+    TCGv H =3D cpu_r[31];
+    TCGv L =3D cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */
+    tcg_gen_or_tl(addr, addr, L);
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPMX)) {
+        return true;
+    }
+
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D tcg_temp_new_i32();
+    TCGv H =3D cpu_r[31];
+    TCGv L =3D cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */
+    tcg_gen_or_tl(addr, addr, L);
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[addr] */
+    tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */
+    tcg_gen_andi_tl(L, addr, 0xff);
+    tcg_gen_shri_tl(addr, addr, 8);
+    tcg_gen_andi_tl(H, addr, 0xff);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Loads one byte pointed to by the Z-register and the RAMPZ Register i=
n
+ *  the I/O space, and places this byte in the destination register Rd. =
This
+ *  instruction features a 100% space effective constant initialization =
or
+ *  constant data fetch. The Program memory is organized in 16-bit words=
 while
+ *  the Z-pointer is a byte address. Thus, the least significant bit of =
the
+ *  Z-pointer selects either low byte (ZLSB =3D 0) or high byte (ZLSB =3D=
 1). This
+ *  instruction can address the entire Program memory space. The Z-point=
er
+ *  Register can either be left unchanged by the operation, or it can be
+ *  incremented. The incrementation applies to the entire 24-bit concate=
nation
+ *  of the RAMPZ and Z-pointer Registers.
+ *
+ *  Devices with Self-Programming capability can use the ELPM instructio=
n to
+ *  read the Fuse and Lock bit value.
+ */
+static bool trans_ELPM1(DisasContext *ctx, arg_ELPM1 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
+        return true;
+    }
+
+    TCGv Rd =3D cpu_r[0];
+    TCGv addr =3D gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_ELPM2(DisasContext *ctx, arg_ELPM2 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
+        return true;
+    }
+
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_ELPMX(DisasContext *ctx, arg_ELPMX *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPMX)) {
+        return true;
+    }
+
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[addr] */
+    tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  SPM can be used to erase a page in the Program memory, to write a pa=
ge
+ *  in the Program memory (that is already erased), and to set Boot Load=
er Lock
+ *  bits. In some devices, the Program memory can be written one word at=
 a time,
+ *  in other devices an entire page can be programmed simultaneously aft=
er first
+ *  filling a temporary page buffer. In all cases, the Program memory mu=
st be
+ *  erased one page at a time. When erasing the Program memory, the RAMP=
Z and
+ *  Z-register are used as page address. When writing the Program memory=
, the
+ *  RAMPZ and Z-register are used as page or word address, and the R1:R0
+ *  register pair is used as data(1). When setting the Boot Loader Lock =
bits,
+ *  the R1:R0 register pair is used as data. Refer to the device documen=
tation
+ *  for detailed description of SPM usage. This instruction can address =
the
+ *  entire Program memory.
+ *
+ *  The SPM instruction is not available in all devices. Refer to the de=
vice
+ *  specific instruction set summary.
+ *
+ *  Note: 1. R1 determines the instruction high byte, and R0 determines =
the
+ *  instruction low byte.
+ */
+static bool trans_SPM(DisasContext *ctx, arg_SPM *a)
+{
+    /* TODO */
+    if (!avr_have_feature(ctx, AVR_FEATURE_SPM)) {
+        return true;
+    }
+
+    return true;
+}
+
+static bool trans_SPMX(DisasContext *ctx, arg_SPMX *a)
+{
+    /* TODO */
+    if (!avr_have_feature(ctx, AVR_FEATURE_SPMX)) {
+        return true;
+    }
+
+    return true;
+}
+
+/*
+ *  Loads data from the I/O Space (Ports, Timers, Configuration Register=
s,
+ *  etc.) into register Rd in the Register File.
+ */
+static bool trans_IN(DisasContext *ctx, arg_IN *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv port =3D tcg_const_i32(a->imm);
+
+    gen_helper_inb(Rd, cpu_env, port);
+
+    tcg_temp_free_i32(port);
+
+    return true;
+}
+
+/*
+ *  Stores data from register Rr in the Register File to I/O Space (Port=
s,
+ *  Timers, Configuration Registers, etc.).
+ */
+static bool trans_OUT(DisasContext *ctx, arg_OUT *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv port =3D tcg_const_i32(a->imm);
+
+    gen_helper_outb(cpu_env, port, Rd);
+
+    tcg_temp_free_i32(port);
+
+    return true;
+}
+
+/*
+ *  This instruction stores the contents of register Rr on the STACK. Th=
e
+ *  Stack Pointer is post-decremented by 1 after the PUSH.  This instruc=
tion is
+ *  not available in all devices. Refer to the device specific instructi=
on set
+ *  summary.
+ */
+static bool trans_PUSH(DisasContext *ctx, arg_PUSH *a)
+{
+    TCGv Rd =3D cpu_r[a->rd];
+
+    gen_data_store(ctx, Rd, cpu_sp);
+    tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+    return true;
+}
+
+/*
+ *  This instruction loads register Rd with a byte from the STACK. The S=
tack
+ *  Pointer is pre-incremented by 1 before the POP.  This instruction is=
 not
+ *  available in all devices. Refer to the device specific instruction s=
et
+ *  summary.
+ */
+static bool trans_POP(DisasContext *ctx, arg_POP *a)
+{
+    /*
+     * Using a temp to work around some strange behaviour:
+     * tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+     * gen_data_load(ctx, Rd, cpu_sp);
+     * seems to cause the add to happen twice.
+     * This doesn't happen if either the add or the load is removed.
+     */
+    TCGv t1 =3D tcg_temp_new_i32();
+    TCGv Rd =3D cpu_r[a->rd];
+
+    tcg_gen_addi_tl(t1, cpu_sp, 1);
+    gen_data_load(ctx, Rd, t1);
+    tcg_gen_mov_tl(cpu_sp, t1);
+
+    return true;
+}
+
+/*
+ *  Exchanges one byte indirect between register and data space.  The da=
ta
+ *  location is pointed to by the Z (16 bits) Pointer Register in the Re=
gister
+ *  File. Memory access is limited to the current data segment of 64KB. =
To
+ *  access another data segment in devices with more than 64KB data spac=
e, the
+ *  RAMPZ in register in the I/O area has to be changed.
+ *
+ *  The Z-pointer Register is left unchanged by the operation. This inst=
ruction
+ *  is especially suited for writing/reading status bits stored in SRAM.
+ */
+static bool trans_XCH(DisasContext *ctx, arg_XCH *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv t0 =3D tcg_temp_new_i32();
+    TCGv addr =3D gen_get_zaddr();
+
+    gen_data_load(ctx, t0, addr);
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_mov_tl(Rd, t0);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Load one byte indirect from data space to register and set bits in d=
ata
+ *  space specified by the register. The instruction can only be used to=
wards
+ *  internal SRAM.  The data location is pointed to by the Z (16 bits) P=
ointer
+ *  Register in the Register File. Memory access is limited to the curre=
nt data
+ *  segment of 64KB. To access another data segment in devices with more=
 than
+ *  64KB data space, the RAMPZ in register in the I/O area has to be cha=
nged.
+ *
+ *  The Z-pointer Register is left unchanged by the operation. This inst=
ruction
+ *  is especially suited for setting status bits stored in SRAM.
+ */
+static bool trans_LAS(DisasContext *ctx, arg_LAS *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rr =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+    TCGv t0 =3D tcg_temp_new_i32();
+    TCGv t1 =3D tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */
+    tcg_gen_or_tl(t1, t0, Rr);
+    tcg_gen_mov_tl(Rr, t0); /* Rr =3D t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Load one byte indirect from data space to register and stores and cl=
ear
+ *  the bits in data space specified by the register. The instruction ca=
n
+ *  only be used towards internal SRAM.  The data location is pointed to=
 by
+ *  the Z (16 bits) Pointer Register in the Register File. Memory access=
 is
+ *  limited to the current data segment of 64KB. To access another data
+ *  segment in devices with more than 64KB data space, the RAMPZ in regi=
ster
+ *  in the I/O area has to be changed.
+ *
+ *  The Z-pointer Register is left unchanged by the operation. This inst=
ruction
+ *  is especially suited for clearing status bits stored in SRAM.
+ */
+static bool trans_LAC(DisasContext *ctx, arg_LAC *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rr =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+    TCGv t0 =3D tcg_temp_new_i32();
+    TCGv t1 =3D tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */
+    tcg_gen_andc_tl(t1, t0, Rr); /* t1 =3D t0 & (0xff - Rr) =3D t0 & ~Rr=
 */
+    tcg_gen_mov_tl(Rr, t0); /* Rr =3D t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Load one byte indirect from data space to register and toggles bits =
in
+ *  the data space specified by the register.  The instruction can only =
be used
+ *  towards SRAM.  The data location is pointed to by the Z (16 bits) Po=
inter
+ *  Register in the Register File. Memory access is limited to the curre=
nt data
+ *  segment of 64KB. To access another data segment in devices with more=
 than
+ *  64KB data space, the RAMPZ in register in the I/O area has to be cha=
nged.
+ *
+ *  The Z-pointer Register is left unchanged by the operation. This inst=
ruction
+ *  is especially suited for changing status bits stored in SRAM.
+ */
+static bool trans_LAT(DisasContext *ctx, arg_LAT *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rd =3D cpu_r[a->rd];
+    TCGv addr =3D gen_get_zaddr();
+    TCGv t0 =3D tcg_temp_new_i32();
+    TCGv t1 =3D tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */
+    tcg_gen_xor_tl(t1, t0, Rd);
+    tcg_gen_mov_tl(Rd, t0); /* Rd =3D t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
--=20
2.7.4



