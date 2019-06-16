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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B785BC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9282133D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFwXn0XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9282133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcWC3-0007CB-G5
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 10:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3y-0001Gx-Bg
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3w-0006fu-M3
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:18 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hcW3u-0006ak-Ho
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:16 -0400
Received: by mail-pf1-x441.google.com with SMTP id q10so4206264pff.9
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=Fd3b28r/kyCi9OaEEgHj5z0zH8dnmvwKtniKArD1gNk=;
 b=LFwXn0XYI8tNXh9SMRqs3ecCzEZr7hwBolQf7dAVb+PnchkPBr3IRM9dW+xFDxRkSR
 yBkZGpjWWP+vbYHmCvndT/Kxj11NAECFXbud3oEhic5JCRacyuBBLEg6Cqq8hVpmevDO
 bA+9MPAbOJXl619uRtO9xhcujww7CNGFLwmrewMDYsCtR6brhLbXGMPNzsdUkbqmsoR3
 rD5qO9ZVwgvk5cdR2m2eVzX/dB+lkiCE7n/m0pXhSXNCqGxd/VhWaCO7g321UwUMxA29
 tHjZcyzVYVlE/uUNNwr2NAgEQaVl5KyrdGJjEwhZsS+6Elz3qqW9optQmrYbzSQrnqWH
 Mbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=Fd3b28r/kyCi9OaEEgHj5z0zH8dnmvwKtniKArD1gNk=;
 b=QPwV/w4pJc1UfGO+oowmyo3yAncjC3XXd3WEspTLr4xWwjNXQg3aUeLFntJPXwz2Ga
 EAyMBpfZPXzUULkESe49ef3TyKR5GUkM7xWcu0TDNPxz5AxkoG7gQnUWL0C4PTJ8Vkfs
 /fUJmvYw6xDUmdT73S5Z+rsLL1jB3T9ciFbJHnDrkSDLJ6a90qZtMsabU9pHPDB/eaOX
 WtowrIXMWEiFXLKiJGKCC/NWQfm6b4EpuP3mXnBwIg2ErRp8W4S4B2MQ2XrV2YdBeNHb
 PyBbKI58votPwulp0Bzr2nRFaPj8bisyrq44Hv1c32MdgMjY7sqx5VnjmBYcEIcIWiPB
 K+dA==
X-Gm-Message-State: APjAAAUbByiCOmX3Hug61q9+81GPRhBnsOftc04N7hO8+5eMV8p61fET
 pp2TvbTtPFnr5BFo0GpytiJSLU1d
X-Google-Smtp-Source: APXvYqxhBzOVkwuALPg3V+smhSguLjkIev+pJG2itDcQMN+O38uLDz9itTunxdkSsPEnoz9NKbPf+w==
X-Received: by 2002:a62:1c93:: with SMTP id c141mr6717619pfc.9.1560694987337; 
 Sun, 16 Jun 2019 07:23:07 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id o20sm7996858pgj.70.2019.06.16.07.23.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 07:23:06 -0700 (PDT)
Date: Sun, 16 Jun 2019 23:23:03 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <20190616142303.GA71209@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 5/6] MOVEC insn. doesnt generate exception if
 wrong CR is accessed
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

Added "CPU class" m68k_feature to each CPU init func so MOVEC can detect wrong
CR (Control Register) access.

Added CPU class detection for each CR type in the m68k_move_to/from helpers,
so that it throws and exception if an unsupported register is requested
for that CPU class.

Reclassified MOVEC insn. as only supported in 68010.

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
---
 target/m68k/cpu.c       |   3 +
 target/m68k/cpu.h       |   4 +
 target/m68k/helper.c    | 192 ++++++++++++++++++++++++++++++----------
 target/m68k/translate.c |   2 +-
 4 files changed, 155 insertions(+), 46 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f3246d6e72..50260de97d 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -134,6 +134,7 @@ static void m68010_cpu_initfn(Object *obj)
     CPUM68KState *env = &cpu->env;
 
     m68000_cpu_initfn(obj);
+    m68k_set_feature(env, M68K_FEATURE_M68010);
     m68k_set_feature(env, M68K_FEATURE_RTD);
     m68k_set_feature(env, M68K_FEATURE_BKPT);
 }
@@ -151,6 +152,7 @@ static void m68020_cpu_initfn(Object *obj)
     CPUM68KState *env = &cpu->env;
 
     m68010_cpu_initfn(obj);
+    m68k_set_feature(env, M68K_FEATURE_M68020);
     m68k_set_feature(env, M68K_FEATURE_QUAD_MULDIV);
     m68k_set_feature(env, M68K_FEATURE_BRAL);
     m68k_set_feature(env, M68K_FEATURE_BCCL);
@@ -177,6 +179,7 @@ static void m68030_cpu_initfn(Object *obj)
     CPUM68KState *env = &cpu->env;
 
     m68020_cpu_initfn(obj);
+    m68k_set_feature(env, M68K_FEATURE_M68030);
 }
 
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2386419c42..86ba19f779 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -488,7 +488,11 @@ void do_m68k_semihosting(CPUM68KState *env, int nr);
 
 enum m68k_features {
     M68K_FEATURE_M68000,   /* Base m68k instruction set */
+    M68K_FEATURE_M68010,   /* Additional insn. specific to MC68010 */
+    M68K_FEATURE_M68020,   /* Additional insn. specific to MC68020 */
+    M68K_FEATURE_M68030,   /* Additional insn. specific to MC68030 */
     M68K_FEATURE_M68040,   /* Additional insn. specific to MC68040 */
+    M68K_FEATURE_M68060,   /* Additional insn. specific to MC68060 */
     M68K_FEATURE_CF_ISA_A, /* Base Coldfire set Rev A. */
     M68K_FEATURE_CF_ISA_B, /* (ISA B or C).  */
     M68K_FEATURE_CF_ISA_APLUSC, /* BIT/BITREV, FF1, STRLDSR (ISA A+ or C).  */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 47b352c9c9..119fc3af2b 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -192,6 +192,16 @@ void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
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
@@ -211,52 +221,96 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
         return;
     /* MC680[2346]0 */
     case M68K_CR_CACR:
-        env->cacr = val;
-        m68k_switch_sp(env);
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->cacr = val;
+            m68k_switch_sp(env);
+            return;
+        }
+        break;
     /* MC680[46]0 */
     case M68K_CR_TC:
-        env->mmu.tcr = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->mmu.tcr = val;
+            return;
+        }
+        break;
     /* MC680[4]0 */
     case M68K_CR_MMUSR:
-        env->mmu.mmusr = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.mmusr = val;
+            return;
+        }
+        break;
     /* MC680[46]0 */
     case M68K_CR_SRP:
-        env->mmu.srp = val;
-        return;
-    case M68K_CR_URP:
-        env->mmu.urp = val;
-        return;
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->mmu.srp = val;
+            return;
+        }
+        break;
     /* MC680[46]0 */
+    case M68K_CR_URP:
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
     /* MC680[234]0 */
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
     /* MC680[234]0 */
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
+    case M68K_CR_ITT0: /* MC68EC040 only: M68K_CR_IACR0 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ttr[M68K_ITTR0] = val;
+            return;
+        }
+        break;
     /* MC68040/MC68LC040 */
-    case M68K_CR_ITT1:
-         env->mmu.ttr[M68K_ITTR1] = val;
-        return;
+    case M68K_CR_ITT1: /* MC68EC040 only: M68K_CR_IACR1 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ttr[M68K_ITTR1] = val;
+            return;
+        }
+        break;
     /* MC68040/MC68LC040 */
-    case M68K_CR_DTT0:
-        env->mmu.ttr[M68K_DTTR0] = val;
-        return;
+    case M68K_CR_DTT0: /* MC68EC040 only: M68K_CR_DACR0 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ttr[M68K_DTTR0] = val;
+            return;
+        }
+        break;
     /* MC68040/MC68LC040 */
-    case M68K_CR_DTT1:
-        env->mmu.ttr[M68K_DTTR1] = val;
-        return;
+    case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ttr[M68K_DTTR1] = val;
+            return;
+        }
+        break;
     /* Unimplemented Registers */
     case M68K_CR_CAAR:
     case M68K_CR_PCR:
@@ -266,8 +320,10 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
                   reg, val);
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
@@ -286,40 +342,83 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
         return env->vbr;
     /* MC680[2346]0 */
     case M68K_CR_CACR:
-        return env->cacr;
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            return env->cacr;
+        }
+        break;
     /* MC680[46]0 */
     case M68K_CR_TC:
-        return env->mmu.tcr;
+        if (m68k_feature(env, M68K_FEATURE_M68040)
+         || m68k_feature(env, M68K_FEATURE_M68060)) {
+            return env->mmu.tcr;
+        }
+        break;
     /* MC680[4]0 */
     case M68K_CR_MMUSR:
-        return env->mmu.mmusr;
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.mmusr;
+        }
+        break;
     /* MC680[46]0 */
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
     /* MC680[46]0 */
     case M68K_CR_USP:
         return env->sp[M68K_USP];
     /* MC680[234]0 */
     case M68K_CR_MSP:
-        return env->sp[M68K_SSP];
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->sp[M68K_SSP];
+        }
+        break;
     /* MC680[234]0 */
     case M68K_CR_ISP:
-        return env->sp[M68K_ISP];
-    /* MC68040/MC68LC040 */
-    case M68K_CR_URP:
-        return env->mmu.urp;
+        if (m68k_feature(env, M68K_FEATURE_M68020)
+         || m68k_feature(env, M68K_FEATURE_M68030)
+         || m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->sp[M68K_ISP];
+        }
+        break;
     /* MC68040/MC68LC040 */
     case M68K_CR_ITT0: /* MC68EC040 only: M68K_CR_IACR0 */
-        return env->mmu.ttr[M68K_ITTR0];
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.ttr[M68K_ITTR0];
+        }
+        break;
     /* MC68040/MC68LC040 */
     case M68K_CR_ITT1: /* MC68EC040 only: M68K_CR_IACR1 */
-        return env->mmu.ttr[M68K_ITTR1];
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.ttr[M68K_ITTR1];
+        }
+        break;
     /* MC68040/MC68LC040 */
     case M68K_CR_DTT0: /* MC68EC040 only: M68K_CR_DACR0 */
-        return env->mmu.ttr[M68K_DTTR0];
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.ttr[M68K_DTTR0];
+        }
+        break;
     /* MC68040/MC68LC040 */
     case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
-        return env->mmu.ttr[M68K_DTTR1];
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            return env->mmu.ttr[M68K_DTTR1];
+        }
+        break;
     /* Unimplemented Registers */
     case M68K_CR_CAAR:
     case M68K_CR_PCR:
@@ -327,8 +426,11 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
         cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
                   reg);
     }
-    cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
-              reg);
+
+    /* Invalid control registers will generate an exception. */
+    raise_exception_ra(env, EXCP_ILLEGAL, 0);
+
+    return 0;
 }
 
 void HELPER(set_macsr)(CPUM68KState *env, uint32_t val)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 9b0ca4c14c..cbca02a7b5 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5990,7 +5990,7 @@ void register_m68k_insns (CPUM68KState *env)
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



