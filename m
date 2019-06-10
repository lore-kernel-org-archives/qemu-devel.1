Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D585C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175B92067C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbqrbA+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175B92067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haAAL-0006e9-CY
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eH-0006tV-Ge
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eF-0001zY-J6
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:01 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eD-0001v3-LE
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:57 -0400
Received: by mail-pl1-x644.google.com with SMTP id bh12so2987924plb.4
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nwSqled/nvSwrZxfnns2Ie8Xa1WPbLk6Osef1/ENK6I=;
 b=sbqrbA+X7C1HnFF0eEAzDpnLYEnAUJgqAUo0dP8fm0OHllqaAHIFpWtQippRcS0FsK
 P/VxusZDv7MvOYwb5zMQTFNihOJkdRdsitS2KFl2jhKcLa0qizSTCJ0oL+Va1Ajagxg+
 z2JNmOtLW4wuIgTszMGWjsYCGXvVjwNpXm+DQZtwGaBsqteN3AxSkDup91IbKc2ahFd+
 6Qn4T7BtF5CNe0yjbeoOkNMXeEzztmddDyyEHhb5/bnSHlHLFg0mQBfCCfjZAjAw5uHB
 io8b6IxoJTu9rY++xEcb8ZvjRrhIrGAu/NOCCmVZw5JY5KuqcFR/FpYk2uuKafOpG0Kp
 XgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nwSqled/nvSwrZxfnns2Ie8Xa1WPbLk6Osef1/ENK6I=;
 b=R02q6mDLzFrAjLS+EhYigJdv/wig8ICCcmIEvtrqGP8CcuzcP2siAr9xc8O24XIkCF
 Mb8TRYPU2DTgaNxRLDRvL2WfFOaJol8DParB1zl6hdSG6cTrBbgEHdc0wSZ/t8t/fuYB
 SaPHJRrlE/Gqlzld2/InFnyWwhQv3B70p1k6SV03H4BL8jW4bojCbSMKeYzzLbHO7hO9
 cqKuJkJZ8vD6UoIaXGCYBsIPRVi1XdO6v1AKehURj9s8LgoZNdAM03T1G3TIuUTvGBve
 4/JbwpaEFTz7tGRlEmSy4DFhdSPxzw4/ZLjcQDlMkaXA0ck6fHXwyEFkkk9fU2n3iY6q
 3GKA==
X-Gm-Message-State: APjAAAUPZKPjAXZShSOBvZNmqMPQZRqwTVZ/UNNcGBYx23UDl8hQI4LK
 T6ru6si7zaL2xyqabiUEdxqhLSLZN5k=
X-Google-Smtp-Source: APXvYqynSZGm5VwxUlS6ukOhaQChFAmEv4V3w+CEGPoaZI+tf2uqhbJlxd0pRjFq3UxfV1JNxHkroA==
X-Received: by 2002:a17:902:7c03:: with SMTP id
 x3mr43380280pll.242.1560132176444; 
 Sun, 09 Jun 2019 19:02:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:09 -0700
Message-Id: <20190610020218.9228-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PULL 30/39] target/xtensa: Use env_cpu, env_archcpu
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
Replace xtensa_env_get_cpu with env_archcpu.  The combination
CPU(xtensa_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Move cpu_get_tb_cpu_state below the include of "exec/cpu-all.h"
so that the definition of env_cpu is available.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h          | 17 ++++++-----------
 hw/xtensa/pic_cpu.c          |  2 +-
 linux-user/xtensa/cpu_loop.c |  2 +-
 target/xtensa/dbg_helper.c   |  4 ++--
 target/xtensa/exc_helper.c   |  9 ++++-----
 target/xtensa/helper.c       |  2 +-
 target/xtensa/mmu_helper.c   | 17 ++++++-----------
 target/xtensa/xtensa-semi.c  |  2 +-
 8 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 3de53cb5d0..97b7bae0fe 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -559,11 +559,6 @@ struct XtensaCPU {
     CPUXtensaState env;
 };
 
-static inline XtensaCPU *xtensa_env_get_cpu(const CPUXtensaState *env)
-{
-    return container_of(env, XtensaCPU, env);
-}
-
 #define ENV_OFFSET offsetof(XtensaCPU, env)
 
 
@@ -724,10 +719,15 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
 #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
 
+typedef CPUXtensaState CPUArchState;
+typedef XtensaCPU ArchCPU;
+
+#include "exec/cpu-all.h"
+
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
         target_ulong *cs_base, uint32_t *flags)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     *pc = env->pc;
     *cs_base = 0;
@@ -797,9 +797,4 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
     }
 }
 
-typedef CPUXtensaState CPUArchState;
-typedef XtensaCPU ArchCPU;
-
-#include "exec/cpu-all.h"
-
 #endif
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index a8939f5e58..df3acbb541 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -33,7 +33,7 @@
 
 void check_interrupts(CPUXtensaState *env)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int minlevel = xtensa_get_cintlevel(env);
     uint32_t int_set_enabled = env->sregs[INTSET] & env->sregs[INTENABLE];
     int level;
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index bee78edb8a..64831c9199 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -123,7 +123,7 @@ static void xtensa_underflow12(CPUXtensaState *env)
 
 void cpu_loop(CPUXtensaState *env)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_siginfo_t info;
     abi_ulong ret;
     int trapnr;
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index cd8fbd653a..be1f81107b 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -71,7 +71,7 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
         uint32_t dbreakc)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
     uint32_t mask = dbreakc | ~DBREAKC_MASK;
 
@@ -118,7 +118,7 @@ void HELPER(wsr_dbreakc)(CPUXtensaState *env, uint32_t i, uint32_t v)
             set_dbreak(env, i, env->sregs[DBREAKA + i], v);
         } else {
             if (env->cpu_watchpoint[i]) {
-                CPUState *cs = CPU(xtensa_env_get_cpu(env));
+                CPUState *cs = env_cpu(env);
 
                 cpu_watchpoint_remove_by_ref(cs, env->cpu_watchpoint[i]);
                 env->cpu_watchpoint[i] = NULL;
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 4a1f7aef5d..601341d13a 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -34,7 +34,7 @@
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     if (excp == EXCP_YIELD) {
@@ -100,7 +100,7 @@ void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
 
 void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
 {
-    CPUState *cpu;
+    CPUState *cpu = env_cpu(env);
 
     env->pc = pc;
     env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) |
@@ -111,11 +111,10 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
     qemu_mutex_unlock_iothread();
 
     if (env->pending_irq_level) {
-        cpu_loop_exit(CPU(xtensa_env_get_cpu(env)));
+        cpu_loop_exit(cpu);
         return;
     }
 
-    cpu = CPU(xtensa_env_get_cpu(env));
     cpu->halted = 1;
     HELPER(exception)(env, EXCP_HLT);
 }
@@ -165,7 +164,7 @@ static void handle_interrupt(CPUXtensaState *env)
         (env->config->level_mask[level] &
          env->sregs[INTSET] &
          env->sregs[INTENABLE])) {
-        CPUState *cs = CPU(xtensa_env_get_cpu(env));
+        CPUState *cs = env_cpu(env);
 
         if (level > 1) {
             env->sregs[EPC1 + level - 1] = env->pc;
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index f2d07e4a2f..376a61f339 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -324,7 +324,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 
 void xtensa_runstall(CPUXtensaState *env, bool runstall)
 {
-    CPUState *cpu = CPU(xtensa_env_get_cpu(env));
+    CPUState *cpu = env_cpu(env);
 
     env->runstall = runstall;
     cpu->halted = runstall;
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index cab39f687a..f15bff306f 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -71,12 +71,10 @@ void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
 
 void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
 {
-    XtensaCPU *cpu = xtensa_env_get_cpu(env);
-
     v = (v & 0xffffff00) | 0x1;
     if (v != env->sregs[RASID]) {
         env->sregs[RASID] = v;
-        tlb_flush(CPU(cpu));
+        tlb_flush(env_cpu(env));
     }
 }
 
@@ -276,8 +274,7 @@ static void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
                                  unsigned wi, unsigned ei,
                                  uint32_t vpn, uint32_t pte)
 {
-    XtensaCPU *cpu = xtensa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
     xtensa_tlb_entry *entry = xtensa_tlb_get_entry(env, dtlb, wi, ei);
 
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
@@ -503,7 +500,7 @@ void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
         uint32_t wi;
         xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
         if (entry->variable && entry->asid) {
-            tlb_flush_page(CPU(xtensa_env_get_cpu(env)), entry->vaddr);
+            tlb_flush_page(env_cpu(env), entry->vaddr);
             entry->asid = 0;
         }
     }
@@ -844,7 +841,7 @@ static int get_physical_addr_mmu(CPUXtensaState *env, bool update_tlb,
 
 static bool get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t paddr;
     uint32_t page_size;
     unsigned access;
@@ -924,13 +921,11 @@ static int xtensa_mpu_lookup(const xtensa_mpu_entry *entry, unsigned n,
 
 void HELPER(wsr_mpuenb)(CPUXtensaState *env, uint32_t v)
 {
-    XtensaCPU *cpu = xtensa_env_get_cpu(env);
-
     v &= (2u << (env->config->n_mpu_fg_segments - 1)) - 1;
 
     if (v != env->sregs[MPUENB]) {
         env->sregs[MPUENB] = v;
-        tlb_flush(CPU(cpu));
+        tlb_flush(env_cpu(env));
     }
 }
 
@@ -942,7 +937,7 @@ void HELPER(wptlb)(CPUXtensaState *env, uint32_t p, uint32_t v)
         env->mpu_fg[segment].vaddr = v & -env->config->mpu_align;
         env->mpu_fg[segment].attr = p & XTENSA_MPU_ATTR_MASK;
         env->sregs[MPUENB] = deposit32(env->sregs[MPUENB], segment, 1, v);
-        tlb_flush(CPU(xtensa_env_get_cpu(env)));
+        tlb_flush(env_cpu(env));
     }
 }
 
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 38efa3485a..8862985e56 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -197,7 +197,7 @@ void xtensa_sim_open_console(Chardev *chr)
 
 void HELPER(simcall)(CPUXtensaState *env)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t *regs = env->regs;
 
     switch (regs[2]) {
-- 
2.17.1


