Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A2C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DAE02067C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWoa7WOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAE02067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haAAA-0006FZ-M3
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eD-0006qK-1I
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e9-0001qq-Rk
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:56 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9e9-0001qB-Iz
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:53 -0400
Received: by mail-pl1-x644.google.com with SMTP id s24so2979982plr.8
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lg8ZYqzoVS5LU/Hk8CNPJL+47kESr7iXuKNlKmQ7dbA=;
 b=OWoa7WOB2Ey//TXrGrSK2pLq3I5s5D32Np8l8HBKQA9n63WlLfF8VRLbcdoBS8oPNy
 dGoNQ9D29Uuf9Kf7QafrEcKyXBBG9qDpWKb2Tc7CbQrpVvvbZ1qzqYWzO2pNxA/rVr/o
 ZzTCQL7EvPuE6qzrG6jBxm/pESdNJWbvNKB5Td0c7g7x4v76pM3Gz/eEuSZ+x8dKuXWA
 DBbUJfjlJ/U0ZMF4xLTkV2sYN4MfNg45unIlAWQBV3iyka742NNEPjHK3LTg9ocM/cP/
 jtTMo9mc1OV8EWNLGa4obxQq+0dAYbTm8B3HVz/KS1KkysR2h2xfkKd/P07KgN6ZXQtU
 0Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lg8ZYqzoVS5LU/Hk8CNPJL+47kESr7iXuKNlKmQ7dbA=;
 b=I8I5C99z5PRMoU5+jRBq/LMVIxF3XlqHCx4/k53f2EIP3yKDbvupgXA4hUH/lTecoI
 CD8gdDmElWN1hBBJKwWcVZhYQ6n1qxDN+UkCcWD8RBKiCmqOb4Q+ZPJ/gqHHv+AzsYXD
 KZSjos/3cLhO65LQaQzyz3gR3ToH7ZiT9fFsOQ4uOBbDnjnbcjmX6BizmDhYN8EahCsA
 V48SL/LGctfjJFwPiXYFFXw3e9+JIQwX1OOiCs7GRWFXn9elMdtihjPXocB4oZSoxqcz
 7d0HtFduRDJ5S4IMQ5c53L/sW4r5+/er8b6TGYL9MkqDjXUAvHvkM++bi/fDPy3mWhNN
 lv+Q==
X-Gm-Message-State: APjAAAW9miV/Ee2qXZzdc8D2Sav421RMTD0LvRdJJbXLkMmMNjJTgBU2
 i6i2+4vrfrCD/iMpKrnNCtZG3SKtBh4=
X-Google-Smtp-Source: APXvYqxeksFBQ+l3PgtbgNDW+jyj52i3Chf8agrSG8iI6lXVCZ9TBceV0Fwgi3tmddNESg6QaOTk6g==
X-Received: by 2002:a17:902:b691:: with SMTP id
 c17mr45580186pls.107.1560132172014; 
 Sun, 09 Jun 2019 19:02:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:05 -0700
Message-Id: <20190610020218.9228-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PULL 26/39] target/sparc: Use env_cpu, env_archcpu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace sparc_env_get_cpu with env_archcpu.  The combination
CPU(sparc_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h          |  5 -----
 bsd-user/main.c             |  2 +-
 hw/sparc/leon3.c            |  4 ++--
 hw/sparc/sun4m.c            |  4 ++--
 hw/sparc64/sparc64.c        |  2 +-
 linux-user/sparc/cpu_loop.c |  2 +-
 target/sparc/fop_helper.c   |  2 +-
 target/sparc/helper.c       |  8 ++++----
 target/sparc/ldst_helper.c  | 33 +++++++++++++++------------------
 target/sparc/mmu_helper.c   | 10 +++++-----
 10 files changed, 32 insertions(+), 40 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index e29421349b..adcd9e3000 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -532,11 +532,6 @@ struct SPARCCPU {
     CPUSPARCState env;
 };
 
-static inline SPARCCPU *sparc_env_get_cpu(CPUSPARCState *env)
-{
-    return container_of(env, SPARCCPU, env);
-}
-
 #define ENV_OFFSET offsetof(SPARCCPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/bsd-user/main.c b/bsd-user/main.c
index bfdcae4269..f6f76f1a64 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -486,7 +486,7 @@ static void flush_windows(CPUSPARCState *env)
 
 void cpu_loop(CPUSPARCState *env)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr, ret, syscall_nr;
     //target_siginfo_t info;
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index bdead85a93..19cedebd16 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -159,7 +159,7 @@ static void leon3_set_pil_in(void *opaque, uint32_t pil_in)
 
                 env->interrupt_index = TT_EXTINT | i;
                 if (old_interrupt != env->interrupt_index) {
-                    cs = CPU(sparc_env_get_cpu(env));
+                    cs = env_cpu(env);
                     trace_leon3_set_irq(i);
                     cpu_interrupt(cs, CPU_INTERRUPT_HARD);
                 }
@@ -167,7 +167,7 @@ static void leon3_set_pil_in(void *opaque, uint32_t pil_in)
             }
         }
     } else if (!env->pil_in && (env->interrupt_index & ~15) == TT_EXTINT) {
-        cs = CPU(sparc_env_get_cpu(env));
+        cs = env_cpu(env);
         trace_leon3_reset_irq(env->interrupt_index & 15);
         env->interrupt_index = 0;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 5151a7202b..7e4f61fc3e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -166,7 +166,7 @@ void cpu_check_irqs(CPUSPARCState *env)
 
                 env->interrupt_index = TT_EXTINT | i;
                 if (old_interrupt != env->interrupt_index) {
-                    cs = CPU(sparc_env_get_cpu(env));
+                    cs = env_cpu(env);
                     trace_sun4m_cpu_interrupt(i);
                     cpu_interrupt(cs, CPU_INTERRUPT_HARD);
                 }
@@ -174,7 +174,7 @@ void cpu_check_irqs(CPUSPARCState *env)
             }
         }
     } else if (!env->pil_in && (env->interrupt_index & ~15) == TT_EXTINT) {
-        cs = CPU(sparc_env_get_cpu(env));
+        cs = env_cpu(env);
         trace_sun4m_cpu_reset_interrupt(env->interrupt_index & 15);
         env->interrupt_index = 0;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 408388945e..689801f37d 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -46,7 +46,7 @@ void cpu_check_irqs(CPUSPARCState *env)
     if (env->ivec_status & 0x20) {
         return;
     }
-    cs = CPU(sparc_env_get_cpu(env));
+    cs = env_cpu(env);
     /* check if TM or SM in SOFTINT are set
        setting these also causes interrupt 14 */
     if (env->softint & (SOFTINT_TIMER | SOFTINT_STIMER)) {
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 9e357229c0..d85359037c 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -145,7 +145,7 @@ static void flush_windows(CPUSPARCState *env)
 
 void cpu_loop (CPUSPARCState *env)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
     abi_long ret;
     target_siginfo_t info;
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index b6642fd1d7..9eb9b75718 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -53,7 +53,7 @@ static target_ulong do_check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
         }
 
         if ((fsr & FSR_CEXC_MASK) & ((fsr & FSR_TEM_MASK) >> 23)) {
-            CPUState *cs = CPU(sparc_env_get_cpu(env));
+            CPUState *cs = env_cpu(env);
 
             /* Unmasked exception, generate a trap.  Note that while
                the helper is marked as NO_WG, we can get away with
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 46232788c8..1a52061fbf 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -26,7 +26,7 @@
 
 void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = tt;
     cpu_loop_exit_restore(cs, ra);
@@ -34,7 +34,7 @@ void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
 
 void helper_raise_exception(CPUSPARCState *env, int tt)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = tt;
     cpu_loop_exit(cs);
@@ -42,7 +42,7 @@ void helper_raise_exception(CPUSPARCState *env, int tt)
 
 void helper_debug(CPUSPARCState *env)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_DEBUG;
     cpu_loop_exit(cs);
@@ -243,7 +243,7 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
 #ifndef TARGET_SPARC64
 void helper_power_down(CPUSPARCState *env)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index b4bf6faf41..7f56c100c6 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -122,13 +122,13 @@ static uint64_t ultrasparc_tag_target(uint64_t tag_access_register)
 
 static void replace_tlb_entry(SparcTLBEntry *tlb,
                               uint64_t tlb_tag, uint64_t tlb_tte,
-                              CPUSPARCState *env1)
+                              CPUSPARCState *env)
 {
     target_ulong mask, size, va, offset;
 
     /* flush page range if translation is valid */
     if (TTE_IS_VALID(tlb->tte)) {
-        CPUState *cs = CPU(sparc_env_get_cpu(env1));
+        CPUState *cs = env_cpu(env);
 
         size = 8192ULL << 3 * TTE_PGSIZE(tlb->tte);
         mask = 1ULL + ~size;
@@ -499,7 +499,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 {
     int size = 1 << (memop & MO_SIZE);
     int sign = memop & MO_SIGN;
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint64_t ret = 0;
 #if defined(DEBUG_MXCC) || defined(DEBUG_ASI)
     uint32_t last_addr = addr;
@@ -725,8 +725,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                    int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
-    SPARCCPU *cpu = sparc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     do_check_align(env, addr, size - 1, GETPC());
     switch (asi) {
@@ -874,13 +873,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
             DPRINTF_MMU("mmu flush level %d\n", mmulev);
             switch (mmulev) {
             case 0: /* flush page */
-                tlb_flush_page(CPU(cpu), addr & 0xfffff000);
+                tlb_flush_page(cs, addr & 0xfffff000);
                 break;
             case 1: /* flush segment (256k) */
             case 2: /* flush region (16M) */
             case 3: /* flush context (4G) */
             case 4: /* flush entire */
-                tlb_flush(CPU(cpu));
+                tlb_flush(cs);
                 break;
             default:
                 break;
@@ -905,7 +904,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                    are invalid in normal mode.  */
                 if ((oldreg ^ env->mmuregs[reg])
                     & (MMU_NF | env->def.mmu_bm)) {
-                    tlb_flush(CPU(cpu));
+                    tlb_flush(cs);
                 }
                 break;
             case 1: /* Context Table Pointer Register */
@@ -916,7 +915,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                 if (oldreg != env->mmuregs[reg]) {
                     /* we flush when the MMU context changes because
                        QEMU has no MMU context support */
-                    tlb_flush(CPU(cpu));
+                    tlb_flush(cs);
                 }
                 break;
             case 3: /* Synchronous Fault Status Register with Clear */
@@ -1027,8 +1026,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
     case ASI_USERTXT: /* User code access, XXX */
     case ASI_KERNELTXT: /* Supervisor code access, XXX */
     default:
-        cpu_unassigned_access(CPU(sparc_env_get_cpu(env)),
-                              addr, true, false, asi, size);
+        cpu_unassigned_access(cs, addr, true, false, asi, size);
         break;
 
     case ASI_USERDATA: /* User data access */
@@ -1175,7 +1173,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 {
     int size = 1 << (memop & MO_SIZE);
     int sign = memop & MO_SIGN;
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint64_t ret = 0;
 #if defined(DEBUG_ASI)
     target_ulong last_addr = addr;
@@ -1481,8 +1479,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                    int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
-    SPARCCPU *cpu = sparc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
 #ifdef DEBUG_ASI
     dump_asi("write", addr, asi, size, val);
@@ -1686,13 +1683,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                 env->dmmu.mmu_primary_context = val;
                 /* can be optimized to only flush MMU_USER_IDX
                    and MMU_KERNEL_IDX entries */
-                tlb_flush(CPU(cpu));
+                tlb_flush(cs);
                 break;
             case 2: /* Secondary context */
                 env->dmmu.mmu_secondary_context = val;
                 /* can be optimized to only flush MMU_USER_SECONDARY_IDX
                    and MMU_KERNEL_SECONDARY_IDX entries */
-                tlb_flush(CPU(cpu));
+                tlb_flush(cs);
                 break;
             case 5: /* TSB access */
                 DPRINTF_MMU("dmmu TSB write: 0x%016" PRIx64 " -> 0x%016"
@@ -1768,13 +1765,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
           case 1:
               env->dmmu.mmu_primary_context = val;
               env->immu.mmu_primary_context = val;
-              tlb_flush_by_mmuidx(CPU(cpu),
+              tlb_flush_by_mmuidx(cs,
                                   (1 << MMU_USER_IDX) | (1 << MMU_KERNEL_IDX));
               break;
           case 2:
               env->dmmu.mmu_secondary_context = val;
               env->immu.mmu_secondary_context = val;
-              tlb_flush_by_mmuidx(CPU(cpu),
+              tlb_flush_by_mmuidx(cs,
                                   (1 << MMU_USER_SECONDARY_IDX) |
                                   (1 << MMU_KERNEL_SECONDARY_IDX));
               break;
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index facc0c60e9..cbd1e91179 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -97,7 +97,7 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
     uint32_t pde;
     int error_code = 0, is_dirty, is_user;
     unsigned long page_offset;
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     is_user = mmu_idx == MMU_USER_IDX;
 
@@ -268,7 +268,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     hwaddr pde_ptr;
     uint32_t pde;
 
@@ -335,7 +335,7 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
 
 void dump_mmu(CPUSPARCState *env)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_ulong va, va1, va2;
     unsigned int n, m, o;
     hwaddr pde_ptr, pa;
@@ -494,7 +494,7 @@ static int get_physical_address_data(CPUSPARCState *env,
                                      hwaddr *physical, int *prot,
                                      target_ulong address, int rw, int mmu_idx)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     unsigned int i;
     uint64_t context;
     uint64_t sfsr = 0;
@@ -612,7 +612,7 @@ static int get_physical_address_code(CPUSPARCState *env,
                                      hwaddr *physical, int *prot,
                                      target_ulong address, int mmu_idx)
 {
-    CPUState *cs = CPU(sparc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     unsigned int i;
     uint64_t context;
     bool is_user = false;
-- 
2.17.1


