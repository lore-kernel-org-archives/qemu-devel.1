Received: from eggs.gnu.org ([2001:4830:134:3::10]:49289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1fyMF7-0008Ee-H4
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 15:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1fyMF3-0000F8-CW
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 15:16:33 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:44551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1fyMF3-000095-0K
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 15:16:29 -0400
Date: Fri, 7 Sep 2018 21:16:19 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20180907191619.GA11275@r52>
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
	<20180801133922.GC2371@localhost.localdomain>
	<c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: Initial support for MIPS
 R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@mips.com>, "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Thank you, Richard,

> >  Can QEMU be instructed to emulate
> > the FPU only for Linux user space programs as opposed to hardware emulation?
> 
> Yes, that can be done.  I would suggest something like
> 
> /*
>  * Hardware traps to the operating system for emulation.
>  * For user-only, qemu is the operating system, so we
>  * emulate the trap and emulate by simply emulating the
>  * instruction directly.
>  */
> #ifdef CONFIG_USER_ONLY
> # define CP0C1_FP_USER_ONLY  (1 << CP0C1_FP)
> #else
> # define CP0C1_FP_USER_ONLY  0
> #endif
> 
> and include that in your initialization of CP0_Config1.

I've made both CP0C1_FP and the LL/SC emulation conditional on user-only,
and adjusted the patch after the review by Maciej, as shown below.

Aleksandar, Aurelien, Maciej -- are you happy with this initial v2 patch?

Fredrik

Signed-off-by: Fredrik Noring <noring@nocrew.org>

 ---
 include/elf.h                    |    3 ++
 linux-user/mips/target_elf.h     |    3 ++
 target/mips/mips-defs.h          |    2 +
 target/mips/translate.c          |   31 ++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c |   44 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 1 deletion(-)

--- a/include/elf.h
+++ b/include/elf.h
@@ -48,6 +48,8 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ARCH_32R6       0x90000000      /* MIPS32r6 code.  */
 #define EF_MIPS_ARCH_64R6       0xa0000000      /* MIPS64r6 code.  */
 
+#define EF_MIPS_MACH_5900       0x00920000
+
 /* The ABI of a file. */
 #define EF_MIPS_ABI_O32		0x00001000	/* O32 ABI.  */
 #define EF_MIPS_ABI_O64		0x00002000	/* O32 extended for 64 bit.  */
@@ -62,6 +64,7 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_FP64      0x00000200
 #define EF_MIPS_NAN2008   0x00000400
 #define EF_MIPS_ARCH      0xf0000000
+#define EF_MIPS_MACH      0x00ff0000
 
 /* These constants define the different elf file types */
 #define ET_NONE   0
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -12,6 +12,9 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
+    if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
+        return "R5900";
+    }
     return "24Kf";
 }
 #endif
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -52,6 +52,7 @@
 #define   ASE_MSA       0x01000000
 
 /* Chip specific instructions. */
+#define		INSN_R5900	0x10000000
 #define		INSN_LOONGSON2E  0x20000000
 #define		INSN_LOONGSON2F  0x40000000
 #define		INSN_VR54XX	0x80000000
@@ -62,6 +63,7 @@
 #define		CPU_MIPS3	(CPU_MIPS2 | ISA_MIPS3)
 #define		CPU_MIPS4	(CPU_MIPS3 | ISA_MIPS4)
 #define		CPU_VR54XX	(CPU_MIPS4 | INSN_VR54XX)
+#define		CPU_R5900	(CPU_MIPS4 | INSN_R5900)
 #define		CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
 #define		CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
 
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3618,6 +3618,31 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t1);
 }
 
+static void gen_mul_r5900 (DisasContext *ctx, uint32_t opc,
+                            int rd, int rs, int rt)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    switch (opc) {
+    case OPC_MULT:
+    case OPC_MULTU:
+        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
+        break;
+    default:
+        MIPS_INVAL("mul R5900");
+        generate_exception_end(ctx, EXCP_RI);
+        goto out;
+    }
+
+ out:
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 static void gen_mul_vr54xx (DisasContext *ctx, uint32_t opc,
                             int rd, int rs, int rt)
 {
@@ -17357,7 +17382,11 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_MULT:
     case OPC_MULTU:
-        if (sa) {
+        if (ctx->insn_flags & INSN_R5900) {
+            gen_muldiv(ctx, op1, 0, rs, rt);
+            if (rd != 0)
+                gen_mul_r5900(ctx, op1, rd, rs, rt);
+        } else if (sa) {
             check_insn(ctx, INSN_VR54XX);
             op1 = MASK_MUL_VR54XX(ctx->opcode);
             gen_mul_vr54xx(ctx, op1, rd, rs, rt);
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -410,6 +410,50 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R5 | ASE_MSA,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        .name = "R5900",
+        .CP0_PRid = 0x00003800,
+        /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
+        .CP0_Config0 = (1 << 17) | (0x3 << 9) | (0x3 << 6) | (0x2 << CP0C0_K0),
+        /* Note: Config1 is only used internally, the R5900 has only Config0. */
+        .CP0_Status_rw_bitmask = 0xF4C79C1F,
+#ifdef CONFIG_USER_ONLY
+	/*
+	 * R5900 hardware traps to the Linux kernel for IEEE 754-1985 and LL/SC
+	 * emulation. For user-only, qemu is the kernel, so we emulate the traps
+	 * by simply emulating the instructions directly.
+	 */
+        .CP0_Config1 = (1 << CP0C1_FP) | (47 << CP0C1_MMU),
+        .CP0_LLAddr_rw_bitmask = 0xFFFFFFFF,
+        .CP0_LLAddr_shift = 4,
+        .CP1_fcr0 = (0x38 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0x0183FFFF,
+#else
+	/*
+	 * The R5900 COP1 FPU implements single-precision floating-point
+	 * operations but is not entirely IEEE 754-1985 compatible. In
+	 * particular,
+	 *
+	 * - NaN (not a number) and plus/minus infinities are not supported;
+	 * - exception mechanisms are not fully supported;
+	 * - denormalized numbers are not supported;
+	 * - rounding towards nearest and plus/minus infinities are not supported;
+	 * - computed results usually differs in the least significant bit;
+	 * - saturating instructions can differ more than the least significant bit.
+	 *
+	 * Since only rounding towards zero is supported, the two least
+	 * significant bits of FCR31 are hardwired to 01.
+	 *
+	 * FPU emulation is disabled here until it is implemented.
+	 */
+        .CP0_Config1 = (47 << CP0C1_MMU),
+#endif /* CONFIG_USER_ONLY */
+        .SEGBITS = 19,
+        .PABITS = 20,
+        .insn_flags = CPU_R5900,
+        .mmu_type = MMU_TYPE_R4000,
+    },
     {
         /* A generic CPU supporting MIPS32 Release 6 ISA.
            FIXME: Support IEEE 754-2008 FP.
