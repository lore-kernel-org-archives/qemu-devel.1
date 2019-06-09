Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7117EC28EBD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 16:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79292145D
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 16:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/wa8sM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79292145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha0wQ-0006nR-HH
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 12:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1ha0vG-0006ET-Hk
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1ha0vD-0003na-IO
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:43:58 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1ha0vD-0003mc-6c
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:43:55 -0400
Received: by mail-pf1-x442.google.com with SMTP id i189so3873549pfg.10
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=DtPfPTWOQlo10DwlIQDI2mU54ew7piJpCaqIxGPpLWs=;
 b=W/wa8sM2EET8QPOcnEriu9Ehkcdc+F6QzgjUJbNfTIh+KDkfVjDFQr89N7WqJcwy12
 suYCUq57Dfs+DtJoNtF7bQn3ar5eWvxlm+Pvmg2ISk6vP2LkxQJPK35vAnbXtmYBpo2n
 LYRb+DbV+q/NuFKDpKhnhadVs16KVRnePaG0+z4tbUqM9D4rIIcuVjXXd2dO0Eb1B35L
 j8/aEKslgMTL/eGr/TBwZt/4sk0xCrbd1BH7wtbS3h5i5kZYPb2Ogy1dpWKERmgB+6yD
 EGRzMm7kFnIyCIZ3BEwqeGzJQ/L+HhC7YcpKB0hVrNnryn7KIIRWtwxljmVzuAHOeRQC
 Wx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=DtPfPTWOQlo10DwlIQDI2mU54ew7piJpCaqIxGPpLWs=;
 b=Puq0S4PUTtfYSLd5z5HsOX3pqBOwOcsx2tfY+5VeSD+xPGDmsJDXVUojR9oJMera4i
 pE8p5BIIgx/+rHOktErkVJvhUrwXDOGyJ3qsIRUn7HwB0TNzvK97rRGS+ecBpO6+6EMa
 YinNuRJQNIKvTZxcYrznO0FnPshU12R2bDqAYIl1zEB4e5wJoBMlWn5uOqmNdhI0Vpyb
 JaiKNtX73RThuJeLzB0/6yln+2kHeSI2XQFUP0JQwRN7CgWRBewuQPZp4xt8VqEmAWo7
 4YX0BYWn5Eai3fJBkZq1NJdrjrQCm7s9boELq7hOTl/DVqikWqWFBd1RuMbr9Pk67S5f
 vTOw==
X-Gm-Message-State: APjAAAUrMrUtE+l/sXhZB6+WMDStodLvwXy5xraUQat1WiWPiMcT02nE
 CvlRTjiMNCzGoKE+2MMQy1mijvx1
X-Google-Smtp-Source: APXvYqz7P/Xz7Yg5VL5rqFVuSOn6RB+CIW0MiL7Uo2X3YTcwwtzgBSEu+IgSJ2+EssFhHKndUKwbiA==
X-Received: by 2002:a62:b503:: with SMTP id y3mr68086392pfe.4.1560098633582;
 Sun, 09 Jun 2019 09:43:53 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id n35sm8553523pgl.44.2019.06.09.09.43.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 09 Jun 2019 09:43:53 -0700 (PDT)
Date: Mon, 10 Jun 2019 01:43:49 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <20190609164349.GA60211@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2] Incorrect Stack Pointer shadow register
 support on some m68k CPUs
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Brief overview;
- Added "CPU class" m68k_feature to each CPU init
  so MOVEC can detect wrong CR (Control Register) access
- Added cascaded "inheritance" of m68k_features by calling m680xx_cpu_initfn()
  of previous CPU so that 68060 inherits 68040, and so on
- Added comments above m680xx_cpu_initfn to identify additional supported
  features for that CPU class
- Added more detailed comments, including CPU classes supported,
  to enum m68k_features
- Added more detailed comments to each case of m68k_move_to/from helpers
  to list the supported CPUs for that CR
- Added CPU class detection for each CR type, exits switch if unsupported
- Added ILLEGAL INSTRUCITON exception condition when the helper fails to
  decode the CR
- Moved abort only to handle unimplemented control registers,
  all other unknown CR will cause ILLEGAL instruciton
- Fixed m68k_switch_sp so it switches only if MSP feature is implemented
- Changed the MOVEC instruction in translate to be 68010 not 68000
- Added missing BUSCR/PCR CR defines, and decodes for helpers for the 68060

Long overview;
The 68000 does not support the MOVEC instruction, it was added with the 68010.

Futher on the 68010, and CPU32 the ISP doesnt exist.
These CPUs only have SSP/USP.

On supporting CPUs the SR register also implements a single bit,  the "M"
(master-mode) bit that determines which of the ISP/MSP is active at the time.

When not supported by the CPU the MOVEC instruction when accessing these
shadow registers should issue an ILLEGAL INSTRUCTION exception.

Futher this patch adds classes for each CPU family 680[012346] so that
illegal access to specific control registers can be checked.

Additional comments added to the features set to claify
exactly what differentiates each class.  (m68k_features)

The helpers m68k_movec_to, and m68k_movec_from have been updated to support
the exception ILLEGAL INSTRUCTION for all control registers that
are illegal per CPU class, and for any unkown control register.

Added defines for BUS, and Processor Configuration Register (PCR) for MC68060,
and case statements in the helper for the missing Cache Address Register (CAAR),
and the new BUS, and PCR which results in a cpu abort (unimplemented).

All other cases will result in an ILLEGAL INSTRUCTION exception as per the
manual.

Because the MSP support results in an illegal instruction exception
if the wrong Control Register is accessed then it was necessary to
know the CPU class in the MOVEC instruction.

To do this a sizable overhaul of the CPU initialize funcitons was needed
to add a feature showing the CPU class.

So in the CPU classes the m680XX_cpu_initfn functions have been rearranged
to cascade starting from the base 68000, so that the 68010 then inherits
from this, and so on until the 68060.

Because each cpu class inherits the previous CPU class, then for example
the 68020 also has the feature 68010, and 68000 and so on upto the 68060.

Added some more detailed comments to each cpu initialization function
to make it clear the instructions added/changed for that CPU to make
future debugging easier, and the reason for the feature flags more clear.

These comments could go deeper into explaining supported/ehnaced modes,
but this wasnt done in this patch.

There are comments in the existing code referring to the EC/L/and-so-on
classes, however no code has been implemented to handle these specific
varitations of each CPU class, and so no m68k_feature was mde to
distinguish them that way.

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
---

Notes:
    v1->v2
      - Submitted previous patch to fix existing non-compliant comment style 
      - Added a comment about sp in CPUM68KState structure
      - updated movec in the same patch to issue exception
      - Reworked code in m68k_movec_from()/m68k_movec_to() because 
        as they trigger a cpu_abort() with unknown code, 
      - Above rework then required some additions for CPU class and so on.
      - Maybe this is becoming more of an RFC? / should be split for the rework?

Based-on: 20190606234125.GA4830@localhost.localdomain
([PATCH v2] m68k comments break patch submission due to being incorrectly formatted)

 target/m68k/cpu.c       | 112 ++++++++++++++----
 target/m68k/cpu.h       |  56 ++++++---
 target/m68k/helper.c    | 247 +++++++++++++++++++++++++++++++---------
 target/m68k/translate.c |   4 +-
 4 files changed, 326 insertions(+), 93 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c144278661..09f3514715 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -42,6 +42,11 @@ static void m68k_set_feature(CPUM68KState *env, int feature)
     env->features |= (1u << feature);
 }
 
+static void m68k_unset_feature(CPUM68KState *env, int feature)
+{
+    env->features &= (-1u - (1u << feature));
+}
+
 /* CPUClass::reset() */
 static void m68k_cpu_reset(CPUState *s)
 {
@@ -104,6 +109,10 @@ static void m5206_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
 }
 
+
+/*
+ * Base feature set, including isns. for m68k family
+ */
 static void m68000_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
@@ -115,14 +124,36 @@ static void m68000_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
 
+
+/*
+ * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
+ */
+static void m68010_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m68000_cpu_initfn(obj);
+    m68k_set_feature(env, M68K_FEATURE_M68010);
+    m68k_set_feature(env, M68K_FEATURE_RTD);
+    m68k_set_feature(env, M68K_FEATURE_BKPT);
+    m68k_set_feature(env, M68K_FEATURE_MSP);
+}
+
+
+/*
+ * Adds BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST, CAS, CAS2,
+ *      CHK2, CMP2, DIVSL, DIVUL, EXTB, PACK, TRAPcc, UNPK.
+ *
+ * 68020/30 Only:CALLM, cpBcc, cpDBcc, cpGEN, cpRESTORE, cpSAVE, cpScc, cpTRAPcc
+ */
 static void m68020_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
-    m68k_set_feature(env, M68K_FEATURE_M68000);
-    m68k_set_feature(env, M68K_FEATURE_USP);
-    m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
+    m68010_cpu_initfn(obj);
+    m68k_set_feature(env, M68K_FEATURE_M68020);
     m68k_set_feature(env, M68K_FEATURE_QUAD_MULDIV);
     m68k_set_feature(env, M68K_FEATURE_BRAL);
     m68k_set_feature(env, M68K_FEATURE_BCCL);
@@ -132,43 +163,79 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_LONG_MULDIV);
     m68k_set_feature(env, M68K_FEATURE_FPU);
     m68k_set_feature(env, M68K_FEATURE_CAS);
-    m68k_set_feature(env, M68K_FEATURE_BKPT);
-    m68k_set_feature(env, M68K_FEATURE_RTD);
     m68k_set_feature(env, M68K_FEATURE_CHK2);
-    m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
-#define m68030_cpu_initfn m68020_cpu_initfn
 
-static void m68040_cpu_initfn(Object *obj)
+
+/*
+ * Adds: PFLUSH (*5)
+ * 68030 Only: PFLUSHA (*5), PLOAD (*5), PMOVE
+ * 68030/40 Only: PTEST
+ *
+ * NOTES:
+ *  5. Not valid on MC68EC030
+ */
+static void m68030_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
     m68020_cpu_initfn(obj);
+    m68k_set_feature(env, M68K_FEATURE_M68030);
+}
+
+
+/*
+ * Adds: CINV, CPUSH
+ * Adds all with Note *2: FABS, FSABS, FDABS, FADD, FSADD, FDADD, FBcc, FCMP,
+ *                        FDBcc, FDIV, FSDIV, FDDIV, FMOVE, FSMOVE, FDMOVE,
+ *                        FMOVEM, FMUL, FSMUL, FDMUL, FNEG, FSNEG, FDNEG, FNOP,
+ *                        FRESTORE, FSAVE, FScc, FSQRT, FSSQRT, FDSQRT, FSUB,
+ *                        FSSUB, FDSUB, FTRAPcc, FTST
+ *
+ * Adds with Notes *2, and *3: FACOS, FASIN, FATAN, FATANH, FCOS, FCOSH, FETOX,
+ *                             FETOXM, FGETEXP, FGETMAN, FINT, FINTRZ, FLOG10,
+ *                             FLOG2, FLOGN, FLOGNP1, FMOD, FMOVECR, FREM,
+ *                             FSCALE, FSGLDIV, FSGLMUL, FSIN, FSINCOS, FSINH,
+ *                             FTAN, FTANH, FTENTOX, FTWOTOX
+ * NOTES:
+ * 2. Not applicable to the MC68EC040, MC68LC040, MC68EC060, and MC68LC060.
+ * 3. These are software-supported instructions on the MC68040 and MC68060.
+ */
+static void m68040_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m68030_cpu_initfn(obj);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
+
+/*
+ * Adds: PLPA
+ * Adds all with Note *2: CAS, CAS2, MULS, MULU, CHK2, CMP2, DIVS, DIVU
+ * All Fxxxx instructions are as per m68040 with exception to; FMOVEM NOTE3
+ *
+ * Does NOT implement MOVEP
+ *
+ * NOTES:
+ * 2. Not applicable to the MC68EC040, MC68LC040, MC68EC060, and MC68LC060.
+ * 3. These are software-supported instructions on the MC68040 and MC68060.
+ */
 static void m68060_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
-    m68k_set_feature(env, M68K_FEATURE_M68000);
-    m68k_set_feature(env, M68K_FEATURE_USP);
-    m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
-    m68k_set_feature(env, M68K_FEATURE_BRAL);
-    m68k_set_feature(env, M68K_FEATURE_BCCL);
-    m68k_set_feature(env, M68K_FEATURE_BITFIELD);
-    m68k_set_feature(env, M68K_FEATURE_EXT_FULL);
-    m68k_set_feature(env, M68K_FEATURE_SCALED_INDEX);
-    m68k_set_feature(env, M68K_FEATURE_LONG_MULDIV);
-    m68k_set_feature(env, M68K_FEATURE_FPU);
-    m68k_set_feature(env, M68K_FEATURE_CAS);
-    m68k_set_feature(env, M68K_FEATURE_BKPT);
-    m68k_set_feature(env, M68K_FEATURE_RTD);
-    m68k_set_feature(env, M68K_FEATURE_CHK2);
+    m68040_cpu_initfn(obj);
+    m68k_unset_feature(env, M68K_FEATURE_MOVEP);
+
+    /* Implemented as a software feature */
+    m68k_unset_feature(env, M68K_FEATURE_QUAD_MULDIV);
 }
 
+
 static void m5208_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
@@ -303,6 +370,7 @@ static const TypeInfo m68k_cpus_type_infos[] = {
         .class_init = m68k_cpu_class_init,
     },
     DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("m68010", m68010_cpu_initfn),
     DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
     DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
     DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 3c4d7de017..7a8e4872e2 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -93,7 +93,13 @@ typedef struct CPUM68KState {
     uint32_t pc;
     uint32_t sr;
 
-    /* SSP and USP.  The current_sp is stored in aregs[7], the other here.  */
+    /*
+     * The 68020/30/40 support two supervisor stacks, ISP and MSP.
+     * The 68000/10, Coldfire, and CPU32 only have USP/SSP.
+     *
+     * The current_sp is stored in aregs[7], the other here.
+     * The USP, SSP, and if used the additional ISP for 68020/30/40.
+     */
     int current_sp;
     uint32_t sp[3];
 
@@ -411,6 +417,10 @@ typedef enum {
 #define M68K_CR_DACR0    0x006
 #define M68K_CR_DACR1    0x007
 
+/* MC68060 */
+#define M68K_CR_BUSCR    0x008
+#define M68K_CR_PCR      0x808
+
 #define M68K_FPIAR_SHIFT  0
 #define M68K_FPIAR        (1 << M68K_FPIAR_SHIFT)
 #define M68K_FPSR_SHIFT   1
@@ -468,36 +478,50 @@ void m68k_switch_sp(CPUM68KState *env);
 void do_m68k_semihosting(CPUM68KState *env, int nr);
 
 /*
+ * The 68000 family is defined in six main CPU classes, the 680[012346]0.
+ * Generally each successive CPU adds enhanced data/stack/instructions.
+ * However, some features are only common to one, or a few classes.
+ * The features covers those subsets of instructons.
+ *
+ * CPU32/32+ are basically 680010 compatible with some 68020 class instructons,
+ * and some additional CPU32 instructions. Mostly Supervisor state differences.
+ *
+ * The ColdFire core ISA is a RISC-style reduction of the 68000 series cpu.
  * There are 4 ColdFire core ISA revisions: A, A+, B and C.
  * Each feature covers the subset of instructions common to the
  * ISA revisions mentioned.
  */
 
 enum m68k_features {
-    M68K_FEATURE_M68000,
-    M68K_FEATURE_CF_ISA_A,
+    M68K_FEATURE_M68000,   /* Base m68k instruction set */
+    M68K_FEATURE_M68010,   /* Additional insn. specific to MC68010 */
+    M68K_FEATURE_M68020,   /* Additional insn. specific to MC68020 */
+    M68K_FEATURE_M68030,   /* Additional insn. specific to MC68030 */
+    M68K_FEATURE_M68040,   /* Additional insn. specific to MC68040 */
+    M68K_FEATURE_M68060,   /* Additional insn. specific to MC68060 */
+    M68K_FEATURE_CF_ISA_A, /* Base Coldfire set Rev A. */
     M68K_FEATURE_CF_ISA_B, /* (ISA B or C).  */
     M68K_FEATURE_CF_ISA_APLUSC, /* BIT/BITREV, FF1, STRLDSR (ISA A+ or C).  */
-    M68K_FEATURE_BRAL, /* Long unconditional branch.  (ISA A+ or B).  */
+    M68K_FEATURE_BRAL, /* BRA with Long branch.  (680[2346]0, ISA A+ or B). */
     M68K_FEATURE_CF_FPU,
     M68K_FEATURE_CF_MAC,
     M68K_FEATURE_CF_EMAC,
     M68K_FEATURE_CF_EMAC_B, /* Revision B EMAC (dual accumulate).  */
-    M68K_FEATURE_USP, /* User Stack Pointer.  (ISA A+, B or C).  */
+    M68K_FEATURE_USP, /* User Stack Pointer. (680[012346]0, ISA A+, B or C).*/
+    M68K_FEATURE_MSP, /* Master Stack Pointer. (680[234]0) */
     M68K_FEATURE_EXT_FULL, /* 68020+ full extension word.  */
     M68K_FEATURE_WORD_INDEX, /* word sized address index registers.  */
     M68K_FEATURE_SCALED_INDEX, /* scaled address index registers.  */
-    M68K_FEATURE_LONG_MULDIV, /* 32 bit multiply/divide. */
-    M68K_FEATURE_QUAD_MULDIV, /* 64 bit multiply/divide. */
-    M68K_FEATURE_BCCL, /* Long conditional branches.  */
-    M68K_FEATURE_BITFIELD, /* Bit field insns.  */
-    M68K_FEATURE_FPU,
-    M68K_FEATURE_CAS,
-    M68K_FEATURE_BKPT,
-    M68K_FEATURE_RTD,
-    M68K_FEATURE_CHK2,
-    M68K_FEATURE_M68040, /* instructions specific to MC68040 */
-    M68K_FEATURE_MOVEP,
+    M68K_FEATURE_LONG_MULDIV, /* 32 bit mul/div. (680[2346]0, and CPU32) */
+    M68K_FEATURE_QUAD_MULDIV, /* 64 bit mul/div. (680[2346]0, and CPU32) */
+    M68K_FEATURE_BCCL, /* Bcc with Long branches. (680[2346]0, and CPU32) */
+    M68K_FEATURE_BITFIELD, /* BFxxx Bit field insns. (680[2346]0) */
+    M68K_FEATURE_FPU, /* fpu insn. (680[46]0) */
+    M68K_FEATURE_CAS, /* CAS/CAS2[WL] insns. (680[2346]0) */
+    M68K_FEATURE_BKPT,/* BKPT insn. (680[12346]0, and CPU32) */
+    M68K_FEATURE_RTD, /* RTD insn. (680[12346]0, and CPU32) */
+    M68K_FEATURE_CHK2,/* CHL2 insn. (680[2346]0, and CPU32) */
+    M68K_FEATURE_MOVEP,/* MOVEP insn. (680[01234]0, and CPU32) */
 };
 
 static inline int m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index b0bb579403..0661723aac 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -192,64 +192,138 @@ void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
     }
 }
 
+
+
+static void raise_exception_ra(CPUM68KState *env, int tt, uintptr_t raddr)
+{
+    CPUState *cs = CPU(m68k_env_get_cpu(env));
+
+    cs->exception_index = tt;
+    cpu_loop_exit_restore(cs, raddr);
+}
+
 void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
 {
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
     switch (reg) {
-    /* MC680[1234]0 */
+    /* MC680[12346]0 */
     case M68K_CR_SFC:
         env->sfc = val & 7;
         return;
+    /* MC680[12346]0 */
     case M68K_CR_DFC:
         env->dfc = val & 7;
         return;
+    /* MC680[12346]0 */
     case M68K_CR_VBR:
         env->vbr = val;
         return;
-    /* MC680[234]0 */
+    /* MC680[2346]0 */
     case M68K_CR_CACR:
-        env->cacr = val;
-        m68k_switch_sp(env);
-        return;
-    /* MC680[34]0 */
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->cacr = val;
+            m68k_switch_sp(env);
+            return;
+        }
+        break;
+    /* MC680[46]0 */
     case M68K_CR_TC:
-        env->mmu.tcr = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->mmu.tcr = val;
+            return;
+        }
+        break;
+    /* MC680[4]0 */
     case M68K_CR_MMUSR:
-        env->mmu.mmusr = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.mmusr = val;
+            return;
+        }
+        break;
+    /* MC680[46]0 */
     case M68K_CR_SRP:
-        env->mmu.srp = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->mmu.srp = val;
+            return;
+        }
+        break;
+    /* MC680[46]0 */
     case M68K_CR_URP:
-        env->mmu.urp = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->mmu.urp = val;
+            return;
+        }
+        break;
+    /* MC680[12346]0 */
     case M68K_CR_USP:
         env->sp[M68K_USP] = val;
         return;
+    /* MC680[234]0 */
     case M68K_CR_MSP:
-        env->sp[M68K_SSP] = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->sp[M68K_SSP] = val;
+            return;
+        }
+        break;
+    /* MC680[234]0 */
     case M68K_CR_ISP:
-        env->sp[M68K_ISP] = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->sp[M68K_ISP] = val;
+            return;
+        }
+        break;
     /* MC68040/MC68LC040 */
-    case M68K_CR_ITT0:
-        env->mmu.ttr[M68K_ITTR0] = val;
-        return;
-    case M68K_CR_ITT1:
-         env->mmu.ttr[M68K_ITTR1] = val;
-        return;
-    case M68K_CR_DTT0:
-        env->mmu.ttr[M68K_DTTR0] = val;
-        return;
-    case M68K_CR_DTT1:
-        env->mmu.ttr[M68K_DTTR1] = val;
+    case M68K_CR_ITT0: /* MC68EC040 only: M68K_CR_IACR0 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ttr[M68K_ITTR0] = val;
+            return;
+        }
+        break;
+    /* MC68040/MC68LC040 */
+    case M68K_CR_ITT1: /* MC68EC040 only: M68K_CR_IACR1 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ttr[M68K_ITTR1] = val;
+            return;
+        }
+        break;
+    /* MC68040/MC68LC040 */
+    case M68K_CR_DTT0: /* MC68EC040 only: M68K_CR_DACR0 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ttr[M68K_DTTR0] = val;
+            return;
+        }
+        break;
+    /* MC68040/MC68LC040 */
+    case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ttr[M68K_DTTR1] = val;
+            return;
+        }
+        break;
+    /* Unimplemented Registers */
+    case M68K_CR_CAAR:
+    case M68K_CR_PCR:
+    case M68K_CR_BUSCR:
+        cpu_abort(CPU(cpu),
+                  "Unimplemented control register write 0x%x = 0x%x\n",
+                  reg, val);
         return;
     }
-    cpu_abort(CPU(cpu), "Unimplemented control register write 0x%x = 0x%x\n",
-              reg, val);
+
+    /* Invalid control registers will generate an exception. */
+    raise_exception_ra(env, EXCP_ILLEGAL, 0);
+    return;
 }
 
 uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
@@ -257,43 +331,107 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
     switch (reg) {
-    /* MC680[1234]0 */
+    /* MC680[12346]0 */
     case M68K_CR_SFC:
         return env->sfc;
+    /* MC680[12346]0 */
     case M68K_CR_DFC:
         return env->dfc;
+    /* MC680[12346]0 */
     case M68K_CR_VBR:
         return env->vbr;
-    /* MC680[234]0 */
+    /* MC680[2346]0 */
     case M68K_CR_CACR:
-        return env->cacr;
-    /* MC680[34]0 */
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            return env->cacr;
+        }
+        break;
+    /* MC680[46]0 */
     case M68K_CR_TC:
-        return env->mmu.tcr;
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            return env->mmu.tcr;
+        }
+        break;
+    /* MC680[4]0 */
     case M68K_CR_MMUSR:
-        return env->mmu.mmusr;
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.mmusr;
+        }
+        break;
+    /* MC680[46]0 */
     case M68K_CR_SRP:
-        return env->mmu.srp;
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            return env->mmu.srp;
+        }
+        break;
+    /* MC68040/MC68LC040 */
+    case M68K_CR_URP:
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            return env->mmu.urp;
+        }
+        break;
+    /* MC680[46]0 */
     case M68K_CR_USP:
         return env->sp[M68K_USP];
+    /* MC680[234]0 */
     case M68K_CR_MSP:
-        return env->sp[M68K_SSP];
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->sp[M68K_SSP];
+        }
+        break;
+    /* MC680[234]0 */
     case M68K_CR_ISP:
-        return env->sp[M68K_ISP];
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->sp[M68K_ISP];
+        }
+        break;
     /* MC68040/MC68LC040 */
-    case M68K_CR_URP:
-        return env->mmu.urp;
-    case M68K_CR_ITT0:
-        return env->mmu.ttr[M68K_ITTR0];
-    case M68K_CR_ITT1:
-        return env->mmu.ttr[M68K_ITTR1];
-    case M68K_CR_DTT0:
-        return env->mmu.ttr[M68K_DTTR0];
-    case M68K_CR_DTT1:
-        return env->mmu.ttr[M68K_DTTR1];
-    }
-    cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
-              reg);
+    case M68K_CR_ITT0: /* MC68EC040 only: M68K_CR_IACR0 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.ttr[M68K_ITTR0];
+        }
+        break;
+    /* MC68040/MC68LC040 */
+    case M68K_CR_ITT1: /* MC68EC040 only: M68K_CR_IACR1 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.ttr[M68K_ITTR1];
+        }
+        break;
+    /* MC68040/MC68LC040 */
+    case M68K_CR_DTT0: /* MC68EC040 only: M68K_CR_DACR0 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.ttr[M68K_DTTR0];
+        }
+        break;
+    /* MC68040/MC68LC040 */
+    case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.ttr[M68K_DTTR1];
+        }
+        break;
+    /* Unimplemented Registers */
+    case M68K_CR_CAAR:
+    case M68K_CR_PCR:
+    case M68K_CR_BUSCR:
+        cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
+                  reg);
+        return 0;
+    }
+
+    /* Invalid control registers will generate an exception. */
+    raise_exception_ra(env, EXCP_ILLEGAL, 0);
+
+    return 0;
 }
 
 void HELPER(set_macsr)(CPUM68KState *env, uint32_t val)
@@ -337,7 +475,8 @@ void m68k_switch_sp(CPUM68KState *env)
     env->sp[env->current_sp] = env->aregs[7];
     if (m68k_feature(env, M68K_FEATURE_M68000)) {
         if (env->sr & SR_S) {
-            if (env->sr & SR_M) {
+            /* SR:Master-Mode bit unimplemented then ISP is not available */
+            if (!m68k_feature(env, M68K_FEATURE_MSP) || env->sr & SR_M) {
                 new_sp = M68K_SSP;
             } else {
                 new_sp = M68K_ISP;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 9b0ca4c14c..7a5da254dd 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4753,6 +4753,8 @@ DISAS_INSN(m68k_movec)
     } else {
         reg = DREG(ext, 12);
     }
+
+    /* Decode ctrl reg field, issues exception if the cpu doesnt support it */
     if (insn & 1) {
         gen_helper_m68k_movec_to(cpu_env, tcg_const_i32(ext & 0xfff), reg);
     } else {
@@ -5990,7 +5992,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(stop,      4e72, ffff);
     BASE(rte,       4e73, ffff);
     INSN(cf_movec,  4e7b, ffff, CF_ISA_A);
-    INSN(m68k_movec, 4e7a, fffe, M68000);
+    INSN(m68k_movec, 4e7a, fffe, M68010);
 #endif
     BASE(nop,       4e71, ffff);
     INSN(rtd,       4e74, ffff, RTD);
-- 
2.21.0



