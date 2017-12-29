Received: from eggs.gnu.org ([2001:4830:134:3::10]:50588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoCy-0002nH-K1
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoCw-0004Wl-Um
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:56 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:47010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoCw-0004WS-NL
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:54 -0500
Received: by mail-pf0-x243.google.com with SMTP id c204so21819539pfc.13
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:31:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:11 -0800
Message-Id: <20171229063145.29167-5-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/38] target/hppa: Define hardware exception
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        | 39 +++++++++++++++++++++++++++----
 linux-user/main.c        | 26 ++++++++++++++++++---
 target/hppa/helper.c     | 61 ++++++++++++++++++++++++++++++++++--------------
 target/hppa/mem_helper.c |  4 +++-
 target/hppa/op_helper.c  |  6 ++---
 target/hppa/translate.c  |  8 +++----
 6 files changed, 111 insertions(+), 33 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index ea7e495408..d84af91860 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -40,11 +40,40 @@
 #define MMU_USER_IDX     0
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-#define EXCP_SYSCALL     1
-#define EXCP_SYSCALL_LWS 2
-#define EXCP_SIGSEGV     3
-#define EXCP_SIGILL      4
-#define EXCP_SIGFPE      5
+/* Hardware exceptions, interupts, faults, and traps.  */
+#define EXCP_HPMC                1  /* high priority machine check */
+#define EXCP_POWER_FAIL          2
+#define EXCP_RC                  3  /* recovery counter */
+#define EXCP_EXT_INTERRUPT       4  /* external interrupt */
+#define EXCP_LPMC                5  /* low priority machine check */
+#define EXCP_ITLB_MISS           6  /* itlb miss / instruction page fault */
+#define EXCP_IMP                 7  /* instruction memory protection trap */
+#define EXCP_ILL                 8  /* illegal instruction trap */
+#define EXCP_BREAK               9  /* break instruction */
+#define EXCP_PRIV_OPR            10 /* privileged operation trap */
+#define EXCP_PRIV_REG            11 /* privileged register trap */
+#define EXCP_OVERFLOW            12 /* signed overflow trap */
+#define EXCP_COND                13 /* trap-on-condition */
+#define EXCP_ASSIST              14 /* assist exception trap */
+#define EXCP_DTLB_MISS           15 /* dtlb miss / data page fault */
+#define EXCP_NA_ITLB_MISS        16 /* non-access itlb miss */
+#define EXCP_NA_DTLB_MISS        17 /* non-access dtlb miss */
+#define EXCP_DMP                 18 /* data memory protection trap */
+#define EXCP_DMB                 19 /* data memory break trap */
+#define EXCP_TLB_DIRTY           20 /* tlb dirty bit trap */
+#define EXCP_PAGE_REF            21 /* page reference trap */
+#define EXCP_ASSIST_EMU          22 /* assist emulation trap */
+#define EXCP_HPT                 23 /* high-privilege transfer trap */
+#define EXCP_LPT                 24 /* low-privilege transfer trap */
+#define EXCP_TB                  25 /* taken branch trap */
+#define EXCP_DMAR                26 /* data memory access rights trap */
+#define EXCP_DMPI                27 /* data memory protection id trap */
+#define EXCP_UNALIGN             28 /* unaligned data reference trap */
+#define EXCP_PER_INTERRUPT       29 /* performance monitor interrupt */
+
+/* Exceptions for linux-user emulation.  */
+#define EXCP_SYSCALL             30
+#define EXCP_SYSCALL_LWS         31
 
 /* Taken from Linux kernel: arch/parisc/include/asm/psw.h */
 #define PSW_I            0x00000001
diff --git a/linux-user/main.c b/linux-user/main.c
index 71696ed33d..93073e1997 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3761,21 +3761,41 @@ void cpu_loop(CPUHPPAState *env)
             env->iaoq_f = env->gr[31];
             env->iaoq_b = env->gr[31] + 4;
             break;
-        case EXCP_SIGSEGV:
+        case EXCP_ITLB_MISS:
+        case EXCP_DTLB_MISS:
+        case EXCP_NA_ITLB_MISS:
+        case EXCP_NA_DTLB_MISS:
+        case EXCP_IMP:
+        case EXCP_DMP:
+        case EXCP_DMB:
+        case EXCP_PAGE_REF:
+        case EXCP_DMAR:
+        case EXCP_DMPI:
             info.si_signo = TARGET_SIGSEGV;
             info.si_errno = 0;
             info.si_code = TARGET_SEGV_ACCERR;
             info._sifields._sigfault._addr = env->ior;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
-        case EXCP_SIGILL:
+        case EXCP_UNALIGN:
+            info.si_signo = TARGET_SIGBUS;
+            info.si_errno = 0;
+            info.si_code = 0;
+            info._sifields._sigfault._addr = env->ior;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_ILL:
+        case EXCP_PRIV_OPR:
+        case EXCP_PRIV_REG:
             info.si_signo = TARGET_SIGILL;
             info.si_errno = 0;
             info.si_code = TARGET_ILL_ILLOPN;
             info._sifields._sigfault._addr = env->iaoq_f;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
-        case EXCP_SIGFPE:
+        case EXCP_OVERFLOW:
+        case EXCP_COND:
+        case EXCP_ASSIST:
             info.si_signo = TARGET_SIGFPE;
             info.si_errno = 0;
             info.si_code = 0;
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 4231ef3bff..6439179a0e 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -74,25 +74,52 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     int i = cs->exception_index;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        static const char * const names[] = {
+            [EXCP_HPMC]          = "high priority machine check",
+            [EXCP_POWER_FAIL]    = "power fail interrupt",
+            [EXCP_RC]            = "recovery counter trap",
+            [EXCP_EXT_INTERRUPT] = "external interrupt",
+            [EXCP_LPMC]          = "low priority machine check",
+            [EXCP_ITLB_MISS]     = "instruction tlb miss fault",
+            [EXCP_IMP]           = "instruction memory protection trap",
+            [EXCP_ILL]           = "illegal instruction trap",
+            [EXCP_BREAK]         = "break instruction trap",
+            [EXCP_PRIV_OPR]      = "privileged operation trap",
+            [EXCP_PRIV_REG]      = "privileged register trap",
+            [EXCP_OVERFLOW]      = "overflow trap",
+            [EXCP_COND]          = "conditional trap",
+            [EXCP_ASSIST]        = "assist exception trap",
+            [EXCP_DTLB_MISS]     = "data tlb miss fault",
+            [EXCP_NA_ITLB_MISS]  = "non-access instruction tlb miss",
+            [EXCP_NA_DTLB_MISS]  = "non-access data tlb miss",
+            [EXCP_DMP]           = "data memory protection trap",
+            [EXCP_DMB]           = "data memory break trap",
+            [EXCP_TLB_DIRTY]     = "tlb dirty bit trap",
+            [EXCP_PAGE_REF]      = "page reference trap",
+            [EXCP_ASSIST_EMU]    = "assist emulation trap",
+            [EXCP_HPT]           = "high-privilege transfer trap",
+            [EXCP_LPT]           = "low-privilege transfer trap",
+            [EXCP_TB]            = "taken branch trap",
+            [EXCP_DMAR]          = "data memory access rights trap",
+            [EXCP_DMPI]          = "data memory protection id trap",
+            [EXCP_UNALIGN]       = "unaligned data reference trap",
+            [EXCP_PER_INTERRUPT] = "performance monitor interrupt",
+            [EXCP_SYSCALL]       = "syscall",
+            [EXCP_SYSCALL_LWS]   = "syscall-lws",
+        };
         static int count;
-        const char *name = "<unknown>";
-
-        switch (i) {
-        case EXCP_SYSCALL:
-            name = "syscall";
-            break;
-        case EXCP_SIGSEGV:
-            name = "sigsegv";
-            break;
-        case EXCP_SIGILL:
-            name = "sigill";
-            break;
-        case EXCP_SIGFPE:
-            name = "sigfpe";
-            break;
+        const char *name = NULL;
+
+        if (i >= 0 && i < ARRAY_SIZE(names)) {
+            name = names[i];
+        }
+        if (name) {
+            qemu_log("INT %6d: %s ia_f=" TARGET_FMT_lx "\n",
+                     ++count, name, env->iaoq_f);
+        } else {
+            qemu_log("INT %6d: unknown %d ia_f=" TARGET_FMT_lx "\n",
+                     ++count, i, env->iaoq_f);
         }
-        qemu_log("INT %6d: %s ia_f=" TARGET_FMT_lx "\n",
-                 ++count, name, env->iaoq_f);
     }
     cs->exception_index = -1;
 }
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index e0802bc935..2901f3e29c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -29,7 +29,9 @@ int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
-    cs->exception_index = EXCP_SIGSEGV;
+    /* ??? Test between data page fault and data memory protection trap,
+       which would affect si_code.  */
+    cs->exception_index = EXCP_DMP;
     cpu->env.ior = address;
     return 1;
 }
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 9c7603588f..d6b86834c1 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -44,14 +44,14 @@ static void QEMU_NORETURN dynexcp(CPUHPPAState *env, int excp, uintptr_t ra)
 void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
 {
     if (unlikely((target_long)cond < 0)) {
-        dynexcp(env, EXCP_SIGFPE, GETPC());
+        dynexcp(env, EXCP_OVERFLOW, GETPC());
     }
 }
 
 void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
 {
     if (unlikely(cond)) {
-        dynexcp(env, EXCP_SIGFPE, GETPC());
+        dynexcp(env, EXCP_COND, GETPC());
     }
 }
 
@@ -235,7 +235,7 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
     env->fr[0] = (uint64_t)shadow << 32;
 
     if (hard_exp & shadow) {
-        dynexcp(env, EXCP_SIGFPE, ra);
+        dynexcp(env, EXCP_ASSIST, ra);
     }
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8e357cc60c..8d85ed9df3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -462,7 +462,7 @@ static DisasJumpType gen_excp(DisasContext *ctx, int exception)
 static DisasJumpType gen_illegal(DisasContext *ctx)
 {
     nullify_over(ctx);
-    return nullify_end(ctx, gen_excp(ctx, EXCP_SIGILL));
+    return nullify_end(ctx, gen_excp(ctx, EXCP_ILL));
 }
 
 static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
@@ -1578,7 +1578,7 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
 
     switch (ctx->iaoq_f) {
     case 0x00: /* Null pointer call */
-        gen_excp_1(EXCP_SIGSEGV);
+        gen_excp_1(EXCP_IMP);
         return DISAS_NORETURN;
 
     case 0xb0: /* LWS */
@@ -1597,7 +1597,7 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
 
     default:
     do_sigill:
-        gen_excp_1(EXCP_SIGILL);
+        gen_excp_1(EXCP_ILL);
         return DISAS_NORETURN;
     }
 }
@@ -1614,7 +1614,7 @@ static DisasJumpType trans_break(DisasContext *ctx, uint32_t insn,
                                  const DisasInsn *di)
 {
     nullify_over(ctx);
-    return nullify_end(ctx, gen_excp(ctx, EXCP_DEBUG));
+    return nullify_end(ctx, gen_excp(ctx, EXCP_BREAK));
 }
 
 static DisasJumpType trans_sync(DisasContext *ctx, uint32_t insn,
-- 
2.14.3
