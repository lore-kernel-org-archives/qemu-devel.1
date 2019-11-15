Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1728CC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7B4206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="XDFFDNZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7B4206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVTTH-0001Dx-RP
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 23:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iVTQJ-00060I-J7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iVTQI-00085S-5j
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:31 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iVTQH-000859-Vv
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:30 -0500
Received: by mail-pg1-x541.google.com with SMTP id k1so3882661pgg.12
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 20:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=BDRz7F8WZuWovA+zwb21EWtUEg2HMx8lqlNygTR580E=;
 b=XDFFDNZ20uGcvoeCSAFqRCYg+iMD7suGQ9t4gEXwrQdJ8RxgoTlDz/0mJJ8Z3/QjX9
 xNpfZ0P+SOsd0fEOdcLJAZ5jGysTD970lW2beMHtvTBQcJbWRn225YsEvHL/zzfWqeKo
 6iULEEDUBqEgAT/qhEEA/XdvUnynNZxyAazGlBflkZSA/VMF8dv6SQievEFelCCGwkAq
 o8nBSB0NLpCGjvvbHlJpfS87bzloypBgxmRItNFZG+FQk7Mo71EaiosmtyJhzU5XuzSe
 TJvkKrUXwafhTS9hHfYTne52QKkuPZ+VqzlNUDzjoYSIOh0LHwgU3K2ri9gUjM3chHr0
 RfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=BDRz7F8WZuWovA+zwb21EWtUEg2HMx8lqlNygTR580E=;
 b=raxZhOOOKw6+lxfqN0YKi0Nfdruxhg4gseCC/je8feqR8Lt9b/p10fqsrCQOmnzkMh
 AbRkt+4pAQ7uI9eYAUXVjgLNfYv3Tv6hpCKDH/Kcvu3xhUFGYD/BeIZqm5Tgyc3jKAsw
 Z8/vSwDAGJHDvdy1XOBxYwyynASiwWc6asCHdeXbvYEcksxXI/0fzFIhmg8xS0oDe2+B
 R/LSmNZsCNBPLN11LXVoT1ZGx5l7IipeVPsVZPKVWBDvaXiYlKO/lmNDnAqgWVu3jyZ0
 n9EfayL/8kST7vr+rozKiBIWbvN37TfDkar0MbWIH10ccedE24YM0plHm0Dsbw7k2n2k
 N/8w==
X-Gm-Message-State: APjAAAXYIBk84SlfeYdIDFq/ODzGXdpG86AX+6ZYq+IVRPbOPyDHE52w
 J2DPmee+GkcTFJxK6AzT9cyv+Q==
X-Google-Smtp-Source: APXvYqwS6BlPymmpZsOvMaGNc5Nh6d6tU1tqyb9rIdi4gqOgLrr0sZEK36fxzsQm3X6s/H1i5VVy2w==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr13922642pgj.147.1573792888617; 
 Thu, 14 Nov 2019 20:41:28 -0800 (PST)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id a145sm9138943pfa.7.2019.11.14.20.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 20:41:28 -0800 (PST)
Subject: [PULL 2/4] target/riscv: Remove atomic accesses to MIP CSR
Date: Thu, 14 Nov 2019 20:41:02 -0800
Message-Id: <20191115044104.4197-3-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115044104.4197-1-palmer@dabbelt.com>
References: <20191115044104.4197-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Instead of relying on atomics to access the MIP register let's update
our helper function to instead just lock the IO mutex thread before
writing. This follows the same concept as used in PPC for handling
interrupts

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 target/riscv/cpu.c        |  5 ++--
 target/riscv/cpu.h        |  9 --------
 target/riscv/cpu_helper.c | 48 +++++++++++++++------------------------
 target/riscv/csr.c        |  2 +-
 4 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3939963b71ab..d37861a4305b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -224,8 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
-                 (target_ulong)atomic_read(&env->mip));
+    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
@@ -275,7 +274,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
      */
-    return (atomic_read(&env->mip) & env->mie) != 0;
+    return (env->mip & env->mie) != 0;
 #else
     return true;
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c64c68538d8..e59343e13c02 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -121,15 +121,6 @@ struct CPURISCVState {
     target_ulong mhartid;
     target_ulong mstatus;
 
-    /*
-     * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
-     * by I/O threads. It should be read with atomic_read. It should be updated
-     * using riscv_cpu_update_mip with the iothread mutex held. The iothread
-     * mutex must be held because mip must be consistent with the CPU inturrept
-     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interrupt
-     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
-     * mip is 32-bits to allow atomic_read on 32-bit hosts.
-     */
     uint32_t mip;
     uint32_t miclaim;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f13131a51bde..767c8762ac42 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
@@ -38,7 +39,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
-    target_ulong pending = atomic_read(&env->mip) & env->mie;
+    target_ulong pending = env->mip & env->mie;
     target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
     target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
     target_ulong irqs = (pending & ~env->mideleg & -mie) |
@@ -92,42 +93,29 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
     }
 }
 
-struct CpuAsyncInfo {
-    uint32_t new_mip;
-};
-
-static void riscv_cpu_update_mip_irqs_async(CPUState *target_cpu_state,
-                                            run_on_cpu_data data)
-{
-    struct CpuAsyncInfo *info = (struct CpuAsyncInfo *) data.host_ptr;
-
-    if (info->new_mip) {
-        cpu_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
-    }
-
-    g_free(info);
-}
-
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
 {
     CPURISCVState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
-    struct CpuAsyncInfo *info;
-    uint32_t old, new, cmp = atomic_read(&env->mip);
+    uint32_t old = env->mip;
+    bool locked = false;
+
+    if (!qemu_mutex_iothread_locked()) {
+        locked = true;
+        qemu_mutex_lock_iothread();
+    }
 
-    do {
-        old = cmp;
-        new = (old & ~mask) | (value & mask);
-        cmp = atomic_cmpxchg(&env->mip, old, new);
-    } while (old != cmp);
+    env->mip = (env->mip & ~mask) | (value & mask);
 
-    info = g_new(struct CpuAsyncInfo, 1);
-    info->new_mip = new;
+    if (env->mip) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
 
-    async_run_on_cpu(cs, riscv_cpu_update_mip_irqs_async,
-                     RUN_ON_CPU_HOST_PTR(info));
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
 
     return old;
 }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 974c9c20b5f4..da02f9f0b177 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -579,7 +579,7 @@ static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
     if (mask) {
         old_mip = riscv_cpu_update_mip(cpu, mask, (new_value & mask));
     } else {
-        old_mip = atomic_read(&env->mip);
+        old_mip = env->mip;
     }
 
     if (ret_value) {
-- 
2.21.0


