Received: from eggs.gnu.org ([2001:4830:134:3::10]:39541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1fyeDN-00017U-KR
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 10:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1fyeDK-0007V3-BK
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 10:27:57 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:30820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1fyeDJ-0007UA-U3
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 10:27:54 -0400
Date: Sat, 8 Sep 2018 16:27:41 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20180908142741.GA11984@r52>
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
	<20180801133922.GC2371@localhost.localdomain>
	<c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>
	<20180907191619.GA11275@r52>
	<DM6PR08MB4875E5EDA598B98379D09C57C6070@DM6PR08MB4875.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR08MB4875E5EDA598B98379D09C57C6070@DM6PR08MB4875.namprd08.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v3] target/mips: Support R5900 GCC programs
 in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Aleksandar,

> Please:
> 
> - rebase your changes to the latest QEMU code

Sure. V2 applied to 3.0.0 and this v3 applies to HEAD (commit 19b599f7664b).

> - organize the changes in the form of patch series

What kind of granularity do you have in mind? The patch is quite small with
79 insertions and 1 deletion in total.

> - provide links to or attach relevant documentation

The most relevant manual is probably Toshiba TX System RISC TX79 Core
Architecture:

http://www.lukasz.dk/files/tx79architecture.pdf

> - in cover letter, outline what is needed for full QEMU support of the cpu
>   in question

The primary purpose of this patch is to support programs compiled by GCC for
the R5900 target. This enables QEMU to run R5900 Linux distributions, for
example Gentoo. In particular, this avoids issues with cross compilation.
R5900 hardware is typically limited to 32 MiB of RAM, which is insufficient 
for running GCC in many cases.

> - describe testing and verification

This patch has been tested with Gentoo compiled for R5900, including native
compilation of several packages under QEMU. During testing of 2.12.50 I
discovered two problems which I reported and I believe are unrelated to the
patch itself:

The error

	qemu: Unsupported syscall: 4352 (seccomp)

was reported during Gentoo package installations, and QEMU crashed with

	qemu-mipsel: qemu/accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion `use_icount' failed.
	qemu: uncaught target signal 11 (Segmentation fault) - core dumped

when compiling Perl under Gentoo. That crash seems to be related to the bug

https://bugs.launchpad.net/qemu/+bug/1768246

for SH4, which appears to have a fix for SH4 in

commit 5b38d0264064055255db991e29d938491f9e8a32
Author: Laurent Vivier <laurent@vivier.eu>
Date:   Sat Aug 11 10:23:28 2018 +0200

    sh4: fix use_icount with linux-user
    
    This fixes java in a linux-user chroot:
      $ java --version
      qemu-sh4: .../accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion `use_icount' failed.
      qemu: uncaught target signal 6 (Aborted) - core dumped
      Aborted (core dumped)
    
    In gen_conditional_jump() in the GUSA_EXCLUSIVE part, we must reset
    base.is_jmp to DISAS_NEXT after the gen_goto_tb() as it is done in
    gen_delayed_conditional_jump() after the gen_jump().
    
    Bug: https://bugs.launchpad.net/qemu/+bug/1768246
    Fixes: 4834871bc95b67343248100e2a75ae0d287bc08b
           ("target/sh4: Convert to DisasJumpType")
    Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    Signed-off-by: Laurent Vivier <laurent@vivier.eu>
    Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
    Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
    Message-Id: <20180811082328.11268-1-laurent@vivier.eu>

> - remove the unclear word 'initial' from the title

Sure.

> - outline your plan for providing full support - can you commit enough
>   resources to do the job in a reasonable timeframe?

For its intended purpose, to support R5900 GCC programs in user mode, I
believe this patch is sufficiently complete as it stands.
 
> Otherwise, I am generally happy with your patch.

Good!

Fredrik

Signed-off-by: Fredrik Noring <noring@nocrew.org>

 ---
 linux-user/mips/target_elf.h     |    3 ++
 target/mips/mips-defs.h          |    2 +
 target/mips/translate.c          |   31 ++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c |   44 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

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
@@ -53,6 +53,7 @@
 #define   ASE_MSA       0x01000000
 
 /* Chip specific instructions. */
+#define		INSN_R5900	0x10000000
 #define		INSN_LOONGSON2E  0x20000000
 #define		INSN_LOONGSON2F  0x40000000
 #define		INSN_VR54XX	0x80000000
@@ -63,6 +64,7 @@
 #define		CPU_MIPS3	(CPU_MIPS2 | ISA_MIPS3)
 #define		CPU_MIPS4	(CPU_MIPS3 | ISA_MIPS4)
 #define		CPU_VR54XX	(CPU_MIPS4 | INSN_VR54XX)
+#define		CPU_R5900	(CPU_MIPS4 | INSN_R5900)
 #define		CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
 #define		CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
 
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3768,6 +3768,31 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
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
@@ -22374,7 +22399,11 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
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
