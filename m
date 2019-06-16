Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC3FC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A392133D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av2dYBt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A392133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcW7y-00039M-5b
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 10:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34777)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3e-00019b-3z
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3b-0006QU-6d
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:22:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hcW3a-0006Pf-Pf
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:22:54 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so4204615pff.8
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=fHJN2yKAczUktopgQI38G7FiIwzDuQlflWooa8t7H1U=;
 b=av2dYBt4GQSPvBq4apgjVmQDZ/YgXhkc9awpjdp1WDwGpwdZG59joO9UfVMEYhO6at
 HyPwvt+V50TSpu1u0zdqfz8xfHYLqBF4JaENwSand5LZB/kGy54dp38TWfeVJUMbVzdw
 iyag8wlsuuMkgjqt0YI5M2bWO/oQBwc3Cb8PP99k1lQ+MH8FLRJawDMrcJ1faS0/n/Cp
 Q0L2ccWgZE954jDqsk5Rk7X1KYo4Eqc8OhTcW/J43dCbvSWfD/MxMrGQwu6nTYhBkhgO
 3Dj6HjShH9kxDOPitfhvbbeKZSUKKEu9y+8bem7CFJ3NIK8vMziVJLHyOnI9xXXuInc2
 N4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=fHJN2yKAczUktopgQI38G7FiIwzDuQlflWooa8t7H1U=;
 b=mNRNLBThFgZC5ZtWsJQiPHSeLAxjDPME1haiqCTywOwy7sEz9kJo/lbzULeZsDMpVN
 ZWUjuLjln0Mw5+sCITV+1C9jurSvUxbGX0qzTAppzxLd0bV32/US2LpoY07VZGSmppib
 uMwyuGjsikwvX0wZzsqYUsKvVR2P4seti8LenDL8nouG2SoOgu679P4S2AnlEXM/yWFt
 KXogzDuNwgFQwX5PQTegar/zEMuE9ZMOwovu8SoWPFR90wM9zxAOmh9Y9IAVZTfO6eBx
 iSY2/7P3KGNV8HJ7HxEu/xNL/MthzT4VAW5cNuGGr5WPMQmsFayODzqPm8AZFsrQfyzg
 nAQw==
X-Gm-Message-State: APjAAAUaZs1P/uARVcNEgylr8ak/KcUAgdvOIdeUHD+mzaRgAAz6HFvP
 eMl+uAblYAUtQwbuC0Y8XTqAT6jq
X-Google-Smtp-Source: APXvYqzrJHcfWAOKdSBQBoYDgahdXmPWIYuILbzt8FzgbGwIWU35SAxXMK+hIw4z/Xquu2f+RQyPcQ==
X-Received: by 2002:a17:90a:32ed:: with SMTP id
 l100mr21106372pjb.11.1560694973486; 
 Sun, 16 Jun 2019 07:22:53 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id v9sm8608791pfm.34.2019.06.16.07.22.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 07:22:53 -0700 (PDT)
Date: Sun, 16 Jun 2019 23:22:50 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <20190616142250.GA71201@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 1/6] m68k cpu instantiation comments
 improvements
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

Improvement in comments for the instantiation functions.
This is to highlight what each cpu class, in the 68000 series, contains
in terms of instructions/features.

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
---
 target/m68k/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/cpu.h | 40 +++++++++++++++++++++++++---------------
 2 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c144278661..cc770a8042 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -104,6 +104,10 @@ static void m5206_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
 }
 
+
+/*
+ * Base feature set, including isns. for m68k family
+ */
 static void m68000_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
@@ -115,6 +119,12 @@ static void m68000_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
 
+/*
+ * Adds BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST, CAS, CAS2,
+ *      CHK2, CMP2, DIVSL, DIVUL, EXTB, PACK, TRAPcc, UNPK.
+ *
+ * 68020/30 Only:CALLM, cpBcc, cpDBcc, cpGEN, cpRESTORE, cpSAVE, cpScc, cpTRAPcc
+ */
 static void m68020_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
@@ -137,8 +147,34 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CHK2);
     m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
+
+/*
+ * Adds: PFLUSH (*5)
+ * 68030 Only: PFLUSHA (*5), PLOAD (*5), PMOVE
+ * 68030/40 Only: PTEST
+ *
+ * NOTES:
+ *  5. Not valid on MC68EC030
+ */
 #define m68030_cpu_initfn m68020_cpu_initfn
 
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
 static void m68040_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
@@ -148,6 +184,17 @@ static void m68040_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
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
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 3c4d7de017..b5b3db01c9 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -468,36 +468,46 @@ void m68k_switch_sp(CPUM68KState *env);
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
+    M68K_FEATURE_M68040,   /* Additional insn. specific to MC68040 */
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
-- 
2.21.0



