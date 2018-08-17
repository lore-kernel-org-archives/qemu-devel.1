Received: from eggs.gnu.org ([2001:4830:134:3::10]:52353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMQ-0004dl-RN
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMN-0007MX-27
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41587 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMM-0007Ln-IM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:14 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:02:50 +0200
Message-Id: <1534514633-13725-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 02/65] target/mips: Add nanoMIPS base
 instruction set opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add nanoMIPS opcodes. nanoMIPS instruction are organized by so-called
instruction pools. Each pool contains a set of opcodes, that in turn
can be instruction opcodes or instruction pool opcodes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 670 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 670 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index bdd880b..0075dbc 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -15701,6 +15701,676 @@ static int decode_micromips_opc (CPUMIPSState *env, DisasContext *ctx)
     return 2;
 }
 
+/*
+ *
+ * nanoMIPS opcodes
+ *
+ */
+
+/* MAJOR, P16, and P32 pools opcodes */
+enum {
+    NM_P_ADDIU      = 0x00,
+    NM_ADDIUPC      = 0x01,
+    NM_MOVE_BALC    = 0x02,
+    NM_P16_MV       = 0x04,
+    NM_LW16         = 0x05,
+    NM_BC16         = 0x06,
+    NM_P16_SR       = 0x07,
+
+    NM_POOL32A      = 0x08,
+    NM_P_BAL        = 0x0a,
+    NM_P16_SHIFT    = 0x0c,
+    NM_LWSP16       = 0x0d,
+    NM_BALC16       = 0x0e,
+    NM_P16_4X4      = 0x0f,
+
+    NM_P_GP_W       = 0x10,
+    NM_P_GP_BH      = 0x11,
+    NM_P_J          = 0x12,
+    NM_P16C         = 0x14,
+    NM_LWGP16       = 0x15,
+    NM_P16_LB       = 0x17,
+
+    NM_P48I         = 0x18,
+    NM_P16_A1       = 0x1c,
+    NM_LW4X4        = 0x1d,
+    NM_P16_LH       = 0x1f,
+
+    NM_P_U12        = 0x20,
+    NM_P_LS_U12     = 0x21,
+    NM_P_BR1        = 0x22,
+    NM_P16_A2       = 0x24,
+    NM_SW16         = 0x25,
+    NM_BEQZC16      = 0x26,
+
+    NM_POOL32F      = 0x28,
+    NM_P_LS_S9      = 0x29,
+    NM_P_BR2        = 0x2a,
+
+    NM_P16_ADDU     = 0x2c,
+    NM_SWSP16       = 0x2d,
+    NM_BNEZC16      = 0x2e,
+    NM_MOVEP        = 0x2f,
+
+    NM_POOL32S      = 0x30,
+    NM_P_BRI        = 0x32,
+    NM_LI16         = 0x34,
+    NM_SWGP16       = 0x35,
+    NM_P16_BR       = 0x36,
+
+    NM_P_LUI        = 0x38,
+    NM_ANDI16       = 0x3c,
+    NM_SW4X4        = 0x3d,
+    NM_MOVEPREV     = 0x3f,
+};
+
+/* POOL32A instruction pool */
+enum {
+    NM_POOL32A0    = 0x00,
+    NM_SPECIAL2    = 0x01,
+    NM_COP2_1      = 0x02,
+    NM_UDI         = 0x03,
+    NM_POOL32A5    = 0x05,
+    NM_POOL32A7    = 0x07,
+};
+
+/* P.GP.W instruction pool */
+enum {
+    NM_ADDIUGP_W = 0x00,
+    NM_LWGP      = 0x02,
+    NM_SWGP      = 0x03,
+};
+
+/* P48I instruction pool */
+enum {
+    NM_LI48        = 0x00,
+    NM_ADDIU48     = 0x01,
+    NM_ADDIUGP48   = 0x02,
+    NM_ADDIUPC48   = 0x03,
+    NM_LWPC48      = 0x0b,
+    NM_SWPC48      = 0x0f,
+};
+
+/* P.U12 instruction pool */
+enum {
+    NM_ORI      = 0x00,
+    NM_XORI     = 0x01,
+    NM_ANDI     = 0x02,
+    NM_P_SR     = 0x03,
+    NM_SLTI     = 0x04,
+    NM_SLTIU    = 0x05,
+    NM_SEQI     = 0x06,
+    NM_ADDIUNEG = 0x08,
+    NM_P_SHIFT  = 0x0c,
+    NM_P_ROTX   = 0x0d,
+    NM_P_INS    = 0x0e,
+    NM_P_EXT    = 0x0f,
+};
+
+/* POOL32F instruction pool */
+enum {
+    NM_POOL32F_0   = 0x00,
+    NM_POOL32F_3   = 0x03,
+    NM_POOL32F_5   = 0x05,
+};
+
+/* POOL32S instruction pool */
+enum {
+    NM_POOL32S_0   = 0x00,
+    NM_POOL32S_4   = 0x04,
+};
+
+/* P.LUI instruction pool */
+enum {
+    NM_LUI      = 0x00,
+    NM_ALUIPC   = 0x01,
+};
+
+/* P.GP.BH instruction pool */
+enum {
+    NM_LBGP      = 0x00,
+    NM_SBGP      = 0x01,
+    NM_LBUGP     = 0x02,
+    NM_ADDIUGP_B = 0x03,
+    NM_P_GP_LH   = 0x04,
+    NM_P_GP_SH   = 0x05,
+    NM_P_GP_CP1  = 0x06,
+};
+
+/* P.LS.U12 instruction pool */
+enum {
+    NM_LB        = 0x00,
+    NM_SB        = 0x01,
+    NM_LBU       = 0x02,
+    NM_P_PREFU12 = 0x03,
+    NM_LH        = 0x04,
+    NM_SH        = 0x05,
+    NM_LHU       = 0x06,
+    NM_LWU       = 0x07,
+    NM_LW        = 0x08,
+    NM_SW        = 0x09,
+    NM_LWC1      = 0x0a,
+    NM_SWC1      = 0x0b,
+    NM_LDC1      = 0x0e,
+    NM_SDC1      = 0x0f,
+};
+
+/* P.LS.S9 instruction pool */
+enum {
+    NM_P_LS_S0         = 0x00,
+    NM_P_LS_S1         = 0x01,
+    NM_P_LS_E0         = 0x02,
+    NM_P_LS_WM         = 0x04,
+    NM_P_LS_UAWM       = 0x05,
+};
+
+/* P.BAL instruction pool */
+enum {
+    NM_BC       = 0x00,
+    NM_BALC     = 0x01,
+};
+
+/* P.J instruction pool */
+enum {
+    NM_JALRC    = 0x00,
+    NM_JALRC_HB = 0x01,
+    NM_P_BALRSC = 0x08,
+};
+
+/* P.BR1 instruction pool */
+enum {
+    NM_BEQC     = 0x00,
+    NM_P_BR3A   = 0x01,
+    NM_BGEC     = 0x02,
+    NM_BGEUC    = 0x03,
+};
+
+/* P.BR2 instruction pool */
+enum {
+    NM_BNEC     = 0x00,
+    NM_BLTC     = 0x02,
+    NM_BLTUC    = 0x03,
+};
+
+/* P.BRI instruction pool */
+enum {
+    NM_BEQIC    = 0x00,
+    NM_BBEQZC   = 0x01,
+    NM_BGEIC    = 0x02,
+    NM_BGEIUC   = 0x03,
+    NM_BNEIC    = 0x04,
+    NM_BBNEZC   = 0x05,
+    NM_BLTIC    = 0x06,
+    NM_BLTIUC   = 0x07,
+};
+
+/* P16.SHIFT instruction pool */
+enum {
+    NM_SLL16    = 0x00,
+    NM_SRL16    = 0x01,
+};
+
+/* POOL16C instruction pool */
+enum {
+    NM_POOL16C_0  = 0x00,
+    NM_LWXS16     = 0x01,
+};
+
+/* P16.A1 instruction pool */
+enum {
+    NM_ADDIUR1SP = 0x01,
+};
+
+/* P16.A2 instruction pool */
+enum {
+    NM_ADDIUR2  = 0x00,
+    NM_P_ADDIURS5  = 0x01,
+};
+
+/* P16.ADDU instruction pool */
+enum {
+    NM_ADDU16     = 0x00,
+    NM_SUBU16     = 0x01,
+};
+
+/* P16.SR instruction pool */
+enum {
+    NM_SAVE16        = 0x00,
+    NM_RESTORE_JRC16 = 0x01,
+};
+
+/* P16.4X4 instruction pool */
+enum {
+    NM_ADDU4X4      = 0x00,
+    NM_MUL4X4       = 0x01,
+};
+
+/* P16.LB instruction pool */
+enum {
+    NM_LB16       = 0x00,
+    NM_SB16       = 0x01,
+    NM_LBU16      = 0x02,
+};
+
+/* P16.LH  instruction pool */
+enum {
+    NM_LH16     = 0x00,
+    NM_SH16     = 0x01,
+    NM_LHU16    = 0x02,
+};
+
+/* P.RI instruction pool */
+enum {
+    NM_SIGRIE       = 0x00,
+    NM_P_SYSCALL    = 0x01,
+    NM_BREAK        = 0x02,
+    NM_SDBBP        = 0x03,
+};
+
+/* POOL32A0 instruction pool */
+enum {
+    NM_P_TRAP   = 0x00,
+    NM_SEB      = 0x01,
+    NM_SLLV     = 0x02,
+    NM_MUL      = 0x03,
+    NM_MFC0     = 0x06,
+    NM_MFHC0    = 0x07,
+    NM_SEH      = 0x09,
+    NM_SRLV     = 0x0a,
+    NM_MUH      = 0x0b,
+    NM_MTC0     = 0x0e,
+    NM_MTHC0    = 0x0f,
+    NM_SRAV     = 0x12,
+    NM_MULU     = 0x13,
+    NM_ROTRV    = 0x1a,
+    NM_MUHU     = 0x1b,
+    NM_ADD      = 0x22,
+    NM_DIV      = 0x23,
+    NM_ADDU     = 0x2a,
+    NM_MOD      = 0x2b,
+    NM_SUB      = 0x32,
+    NM_DIVU     = 0x33,
+    NM_RDHWR    = 0x38,
+    NM_SUBU     = 0x3a,
+    NM_MODU     = 0x3b,
+    NM_P_CMOVE  = 0x42,
+    NM_FORK     = 0x45,
+    NM_MFTR     = 0x46,
+    NM_MFHTR    = 0x47,
+    NM_AND      = 0x4a,
+    NM_YIELD    = 0x4d,
+    NM_MTTR     = 0x4e,
+    NM_MTHTR    = 0x4f,
+    NM_OR       = 0x52,
+    NM_D_E_MT_VPE = 0x56,
+    NM_NOR      = 0x5a,
+    NM_XOR      = 0x62,
+    NM_SLT      = 0x6a,
+    NM_P_SLTU   = 0x72,
+    NM_SOV      = 0x7a,
+};
+
+/* POOL32A7 instruction pool */
+enum {
+    NM_P_LSX        = 0x00,
+    NM_LSA          = 0x01,
+    NM_EXTW         = 0x03,
+    NM_POOL32AXF    = 0x07,
+};
+
+/* P.SR instruction pool */
+enum {
+    NM_PP_SR           = 0x00,
+    NM_P_SR_F          = 0x01,
+};
+
+/* P.SHIFT instruction pool */
+enum {
+    NM_P_SLL        = 0x00,
+    NM_SRL          = 0x02,
+    NM_SRA          = 0x04,
+    NM_ROTR         = 0x06,
+};
+
+/* P.ROTX instruction pool */
+enum {
+    NM_ROTX         = 0x00,
+};
+
+/* P.INS instruction pool */
+enum {
+    NM_INS          = 0x00,
+};
+
+/* P.EXT instruction pool */
+enum {
+    NM_EXT          = 0x00,
+};
+
+/* POOL32F_0 (fmt) instruction pool */
+enum {
+    NM_RINT_S              = 0x04,
+    NM_RINT_D              = 0x44,
+    NM_ADD_S               = 0x06,
+    NM_SELEQZ_S            = 0x07,
+    NM_SELEQZ_D            = 0x47,
+    NM_CLASS_S             = 0x0c,
+    NM_CLASS_D             = 0x4c,
+    NM_SUB_S               = 0x0e,
+    NM_SELNEZ_S            = 0x0f,
+    NM_SELNEZ_D            = 0x4f,
+    NM_MUL_S               = 0x16,
+    NM_SEL_S               = 0x17,
+    NM_SEL_D               = 0x57,
+    NM_DIV_S               = 0x1e,
+    NM_ADD_D               = 0x26,
+    NM_SUB_D               = 0x2e,
+    NM_MUL_D               = 0x36,
+    NM_MADDF_S             = 0x37,
+    NM_MADDF_D             = 0x77,
+    NM_DIV_D               = 0x3e,
+    NM_MSUBF_S             = 0x3f,
+    NM_MSUBF_D             = 0x7f,
+};
+
+/* POOL32F_3  instruction pool */
+enum {
+    NM_MIN_FMT         = 0x00,
+    NM_MAX_FMT         = 0x01,
+    NM_MINA_FMT        = 0x04,
+    NM_MAXA_FMT        = 0x05,
+    NM_POOL32FXF       = 0x07,
+};
+
+/* POOL32F_5  instruction pool */
+enum {
+    NM_CMP_CONDN_S     = 0x00,
+    NM_CMP_CONDN_D     = 0x02,
+};
+
+/* P.GP.LH instruction pool */
+enum {
+    NM_LHGP    = 0x00,
+    NM_LHUGP   = 0x01,
+};
+
+/* P.GP.SH instruction pool */
+enum {
+    NM_SHGP    = 0x00,
+};
+
+/* P.GP.CP1 instruction pool */
+enum {
+    NM_LWC1GP       = 0x00,
+    NM_SWC1GP       = 0x01,
+    NM_LDC1GP       = 0x02,
+    NM_SDC1GP       = 0x03,
+};
+
+/* P.LS.S0 instruction pool */
+enum {
+    NM_LBS9     = 0x00,
+    NM_LHS9     = 0x04,
+    NM_LWS9     = 0x08,
+    NM_LDS9     = 0x0c,
+
+    NM_SBS9     = 0x01,
+    NM_SHS9     = 0x05,
+    NM_SWS9     = 0x09,
+    NM_SDS9     = 0x0d,
+
+    NM_LBUS9    = 0x02,
+    NM_LHUS9    = 0x06,
+    NM_LWC1S9   = 0x0a,
+    NM_LDC1S9   = 0x0e,
+
+    NM_P_PREFS9 = 0x03,
+    NM_LWUS9    = 0x07,
+    NM_SWC1S9   = 0x0b,
+    NM_SDC1S9   = 0x0f,
+};
+
+/* P.LS.S1 instruction pool */
+enum {
+    NM_ASET_ACLR = 0x02,
+    NM_UALH      = 0x04,
+    NM_UASH      = 0x05,
+    NM_CACHE     = 0x07,
+    NM_P_LL      = 0x0a,
+    NM_P_SC      = 0x0b,
+};
+
+/* P.LS.WM instruction pool */
+enum {
+    NM_LWM       = 0x00,
+    NM_SWM       = 0x01,
+};
+
+/* P.LS.UAWM instruction pool */
+enum {
+    NM_UALWM       = 0x00,
+    NM_UASWM       = 0x01,
+};
+
+/* P.BR3A instruction pool */
+enum {
+    NM_BC1EQZC          = 0x00,
+    NM_BC1NEZC          = 0x01,
+    NM_BC2EQZC          = 0x02,
+    NM_BC2NEZC          = 0x03,
+    NM_BPOSGE32C        = 0x04,
+};
+
+/* P16.RI instruction pool */
+enum {
+    NM_P16_SYSCALL  = 0x01,
+    NM_BREAK16      = 0x02,
+    NM_SDBBP16      = 0x03,
+};
+
+/* POOL16C_0 instruction pool */
+enum {
+    NM_POOL16C_00      = 0x00,
+};
+
+/* P16.JRC instruction pool */
+enum {
+    NM_JRC          = 0x00,
+    NM_JALRC16      = 0x01,
+};
+
+/* P.SYSCALL instruction pool */
+enum {
+    NM_SYSCALL      = 0x00,
+    NM_HYPCALL      = 0x01,
+};
+
+/* P.TRAP instruction pool */
+enum {
+    NM_TEQ          = 0x00,
+    NM_TNE          = 0x01,
+};
+
+/* P.CMOVE instruction pool */
+enum {
+    NM_MOVZ            = 0x00,
+    NM_MOVN            = 0x01,
+};
+
+/* POOL32Axf instruction pool */
+enum {
+    NM_POOL32AXF_4 = 0x04,
+    NM_POOL32AXF_5 = 0x05,
+};
+
+/* POOL32Axf_{4, 5} instruction pool */
+enum {
+    NM_CLO      = 0x25,
+    NM_CLZ      = 0x2d,
+
+    NM_TLBP     = 0x01,
+    NM_TLBR     = 0x09,
+    NM_TLBWI    = 0x11,
+    NM_TLBWR    = 0x19,
+    NM_TLBINV   = 0x03,
+    NM_TLBINVF  = 0x0b,
+    NM_DI       = 0x23,
+    NM_EI       = 0x2b,
+    NM_RDPGPR   = 0x70,
+    NM_WRPGPR   = 0x78,
+    NM_WAIT     = 0x61,
+    NM_DERET    = 0x71,
+    NM_ERETX    = 0x79,
+};
+
+/* PP.SR instruction pool */
+enum {
+    NM_SAVE         = 0x00,
+    NM_RESTORE      = 0x02,
+    NM_RESTORE_JRC  = 0x03,
+};
+
+/* P.SR.F instruction pool */
+enum {
+    NM_SAVEF        = 0x00,
+    NM_RESTOREF     = 0x01,
+};
+
+/* P16.SYSCALL  instruction pool */
+enum {
+    NM_SYSCALL16     = 0x00,
+    NM_HYPCALL16     = 0x01,
+};
+
+/* POOL16C_00 instruction pool */
+enum {
+    NM_NOT16           = 0x00,
+    NM_XOR16           = 0x01,
+    NM_AND16           = 0x02,
+    NM_OR16            = 0x03,
+};
+
+/* PP.LSX and PP.LSXS instruction pool */
+enum {
+    NM_LBX      = 0x00,
+    NM_LHX      = 0x04,
+    NM_LWX      = 0x08,
+    NM_LDX      = 0x0c,
+
+    NM_SBX      = 0x01,
+    NM_SHX      = 0x05,
+    NM_SWX      = 0x09,
+    NM_SDX      = 0x0d,
+
+    NM_LBUX     = 0x02,
+    NM_LHUX     = 0x06,
+    NM_LWC1X    = 0x0a,
+    NM_LDC1X    = 0x0e,
+
+    NM_LWUX     = 0x07,
+    NM_SWC1X    = 0x0b,
+    NM_SDC1X    = 0x0f,
+
+    NM_LHXS     = 0x04,
+    NM_LWXS     = 0x08,
+    NM_LDXS     = 0x0c,
+
+    NM_SHXS     = 0x05,
+    NM_SWXS     = 0x09,
+    NM_SDXS     = 0x0d,
+
+    NM_LHUXS    = 0x06,
+    NM_LWC1XS   = 0x0a,
+    NM_LDC1XS   = 0x0e,
+
+    NM_LWUXS    = 0x07,
+    NM_SWC1XS   = 0x0b,
+    NM_SDC1XS   = 0x0f,
+};
+
+/* ERETx instruction pool */
+enum {
+    NM_ERET     = 0x00,
+    NM_ERETNC   = 0x01,
+};
+
+/* POOL32FxF_{0, 1} insturction pool */
+enum {
+    NM_CFC1     = 0x40,
+    NM_CTC1     = 0x60,
+    NM_MFC1     = 0x80,
+    NM_MTC1     = 0xa0,
+    NM_MFHC1    = 0xc0,
+    NM_MTHC1    = 0xe0,
+
+    NM_CVT_S_PL = 0x84,
+    NM_CVT_S_PU = 0xa4,
+
+    NM_CVT_L_S     = 0x004,
+    NM_CVT_L_D     = 0x104,
+    NM_CVT_W_S     = 0x024,
+    NM_CVT_W_D     = 0x124,
+
+    NM_RSQRT_S     = 0x008,
+    NM_RSQRT_D     = 0x108,
+
+    NM_SQRT_S      = 0x028,
+    NM_SQRT_D      = 0x128,
+
+    NM_RECIP_S     = 0x048,
+    NM_RECIP_D     = 0x148,
+
+    NM_FLOOR_L_S   = 0x00c,
+    NM_FLOOR_L_D   = 0x10c,
+
+    NM_FLOOR_W_S   = 0x02c,
+    NM_FLOOR_W_D   = 0x12c,
+
+    NM_CEIL_L_S    = 0x04c,
+    NM_CEIL_L_D    = 0x14c,
+    NM_CEIL_W_S    = 0x06c,
+    NM_CEIL_W_D    = 0x16c,
+    NM_TRUNC_L_S   = 0x08c,
+    NM_TRUNC_L_D   = 0x18c,
+    NM_TRUNC_W_S   = 0x0ac,
+    NM_TRUNC_W_D   = 0x1ac,
+    NM_ROUND_L_S   = 0x0cc,
+    NM_ROUND_L_D   = 0x1cc,
+    NM_ROUND_W_S   = 0x0ec,
+    NM_ROUND_W_D   = 0x1ec,
+
+    NM_MOV_S       = 0x01,
+    NM_MOV_D       = 0x81,
+    NM_ABS_S       = 0x0d,
+    NM_ABS_D       = 0x8d,
+    NM_NEG_S       = 0x2d,
+    NM_NEG_D       = 0xad,
+    NM_CVT_D_S     = 0x04d,
+    NM_CVT_D_W     = 0x0cd,
+    NM_CVT_D_L     = 0x14d,
+    NM_CVT_S_D     = 0x06d,
+    NM_CVT_S_W     = 0x0ed,
+    NM_CVT_S_L     = 0x16d,
+};
+
+/* P.LL instruction pool */
+enum {
+    NM_LL       = 0x00,
+    NM_LLWP     = 0x01,
+};
+
+/* P.SC instruction pool */
+enum {
+    NM_SC       = 0x00,
+    NM_SCWP     = 0x01,
+};
+
+/* P.DVP instruction pool */
+enum {
+    NM_DVP      = 0x00,
+    NM_EVP      = 0x01,
+};
+
 /* SmartMIPS extension to MIPS32 */
 
 #if defined(TARGET_MIPS64)
-- 
2.7.4
