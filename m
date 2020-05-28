Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1206FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05292078C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="jrvL3kDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05292078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOS5-00024j-V3
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLz-0000Ci-2Q
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:11 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35540 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLx-000759-Et
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:10 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 4922C4C868;
 Thu, 28 May 2020 19:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694684; x=1592509085; bh=q7gmXwRPkwUACIGqBdwmffakuU+O2k8QcR4
 lqEuQsKQ=; b=jrvL3kDBSepvP/sjEZq61D15tiJvZuiZ2DoQRX6UlnYfAdQLcFu
 kfrv15xIRL5EMMRlHLgXdG6vkwRUKG6AspGjzKZpoM/DjgbtEzTswK8WVYJuqShs
 v7xzYzOdvpNepuLPh2rCYoYdQavzJc6twMb2Me6pBTWPh3oQCjZFK0Z0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id toL1aX-8Kc1p; Thu, 28 May 2020 22:38:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A5D014C865;
 Thu, 28 May 2020 22:38:03 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:05 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 08/13] i386: hvf: Drop rflags from HVFX86EmulatorState
Date: Thu, 28 May 2020 22:37:53 +0300
Message-ID: <20200528193758.51454-9-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200528193758.51454-1-r.bolshakov@yadro.com>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:38:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

HVFX86EmulatorState carries it's own copy of x86 flags. It can be
dropped in favor of eflags in generic CPUX86State.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/hvf.c       |  5 ++---
 target/i386/hvf/x86.c       |  2 +-
 target/i386/hvf/x86.h       | 42 -------------------------------------
 target/i386/hvf/x86_emu.c   |  6 +++---
 target/i386/hvf/x86_flags.c | 24 ++++++++++-----------
 target/i386/hvf/x86_task.c  |  6 +++---
 target/i386/hvf/x86hvf.c    |  6 +++---
 7 files changed, 24 insertions(+), 67 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 416a6fae7c..4cee496d71 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -723,8 +723,7 @@ int hvf_vcpu_exec(CPUState *cpu)
 
         hvf_store_events(cpu, ins_len, idtvec_info);
         rip = rreg(cpu->hvf_fd, HV_X86_RIP);
-        RFLAGS(env) = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
-        env->eflags = RFLAGS(env);
+        env->eflags = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
 
         qemu_mutex_lock_iothread();
 
@@ -736,7 +735,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         case EXIT_REASON_HLT: {
             macvm_set_rip(cpu, rip + ins_len);
             if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
-                (EFLAGS(env) & IF_MASK))
+                (env->eflags & IF_MASK))
                 && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu->halted = 1;
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 3afcedc7fc..7ebb5b45bd 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -131,7 +131,7 @@ bool x86_is_v8086(struct CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
-    return x86_is_protected(cpu) && (RFLAGS(env) & RFLAGS_VM);
+    return x86_is_protected(cpu) && (env->eflags & RFLAGS_VM);
 }
 
 bool x86_is_long_mode(struct CPUState *cpu)
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 411e4b6599..e309b8f203 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -62,44 +62,6 @@ typedef enum x86_rflags {
     RFLAGS_ID       = (1L << 21),
 } x86_rflags;
 
-/* rflags register */
-typedef struct x86_reg_flags {
-    union {
-        struct {
-            uint64_t rflags;
-        };
-        struct {
-            uint32_t eflags;
-            uint32_t hi32_unused1;
-        };
-        struct {
-            uint32_t cf:1;
-            uint32_t unused1:1;
-            uint32_t pf:1;
-            uint32_t unused2:1;
-            uint32_t af:1;
-            uint32_t unused3:1;
-            uint32_t zf:1;
-            uint32_t sf:1;
-            uint32_t tf:1;
-            uint32_t ief:1;
-            uint32_t df:1;
-            uint32_t of:1;
-            uint32_t iopl:2;
-            uint32_t nt:1;
-            uint32_t unused4:1;
-            uint32_t rf:1;
-            uint32_t vm:1;
-            uint32_t ac:1;
-            uint32_t vif:1;
-            uint32_t vip:1;
-            uint32_t id:1;
-            uint32_t unused5:10;
-            uint32_t hi32_unused2;
-        };
-    };
-} __attribute__ ((__packed__)) x86_reg_flags;
-
 typedef enum x86_reg_cr0 {
     CR0_PE =            (1L << 0),
     CR0_MP =            (1L << 1),
@@ -294,15 +256,11 @@ typedef struct lazy_flags {
 /* Definition of hvf_x86_state is here */
 struct HVFX86EmulatorState {
     struct x86_register regs[16];
-    struct x86_reg_flags   rflags;
     struct lazy_flags   lflags;
     uint8_t mmio_buf[4096];
 };
 
 /* useful register access  macros */
-#define RFLAGS(cpu) (cpu->hvf_emul->rflags.rflags)
-#define EFLAGS(cpu) (cpu->hvf_emul->rflags.eflags)
-
 #define RRX(cpu, reg) (cpu->hvf_emul->regs[reg].rrx)
 #define RAX(cpu)        RRX(cpu, R_EAX)
 #define RCX(cpu)        RRX(cpu, R_ECX)
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 0efd9f9928..04fac64e72 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -459,7 +459,7 @@ static inline void string_increment_reg(struct CPUX86State *env, int reg,
                                         struct x86_decode *decode)
 {
     target_ulong val = read_reg(env, reg, decode->addressing_size);
-    if (env->hvf_emul->rflags.df) {
+    if (env->eflags & DF_MASK) {
         val -= decode->operand_size;
     } else {
         val += decode->operand_size;
@@ -1432,7 +1432,7 @@ void load_regs(struct CPUState *cpu)
         RRX(env, i) = rreg(cpu->hvf_fd, HV_X86_RAX + i);
     }
 
-    RFLAGS(env) = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
+    env->eflags = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
     rflags_to_lflags(env);
     env->eip = rreg(cpu->hvf_fd, HV_X86_RIP);
 }
@@ -1456,7 +1456,7 @@ void store_regs(struct CPUState *cpu)
     }
 
     lflags_to_rflags(env);
-    wreg(cpu->hvf_fd, HV_X86_RFLAGS, RFLAGS(env));
+    wreg(cpu->hvf_fd, HV_X86_RFLAGS, env->eflags);
     macvm_set_rip(cpu, env->eip);
 }
 
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index ee6d33f861..1152cd7234 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -295,21 +295,21 @@ void set_SF(CPUX86State *env, bool val)
 
 void lflags_to_rflags(CPUX86State *env)
 {
-    env->hvf_emul->rflags.cf = get_CF(env);
-    env->hvf_emul->rflags.pf = get_PF(env);
-    env->hvf_emul->rflags.af = get_AF(env);
-    env->hvf_emul->rflags.zf = get_ZF(env);
-    env->hvf_emul->rflags.sf = get_SF(env);
-    env->hvf_emul->rflags.of = get_OF(env);
+    env->eflags |= get_CF(env) ? CC_C : 0;
+    env->eflags |= get_PF(env) ? CC_P : 0;
+    env->eflags |= get_AF(env) ? CC_A : 0;
+    env->eflags |= get_ZF(env) ? CC_Z : 0;
+    env->eflags |= get_SF(env) ? CC_S : 0;
+    env->eflags |= get_OF(env) ? CC_O : 0;
 }
 
 void rflags_to_lflags(CPUX86State *env)
 {
     env->hvf_emul->lflags.auxbits = env->hvf_emul->lflags.result = 0;
-    set_OF(env, env->hvf_emul->rflags.of);
-    set_SF(env, env->hvf_emul->rflags.sf);
-    set_ZF(env, env->hvf_emul->rflags.zf);
-    set_AF(env, env->hvf_emul->rflags.af);
-    set_PF(env, env->hvf_emul->rflags.pf);
-    set_CF(env, env->hvf_emul->rflags.cf);
+    set_OF(env, env->eflags & CC_O);
+    set_SF(env, env->eflags & CC_S);
+    set_ZF(env, env->eflags & CC_Z);
+    set_AF(env, env->eflags & CC_A);
+    set_PF(env, env->eflags & CC_P);
+    set_CF(env, env->eflags & CC_C);
 }
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 834baec3ea..6ea8508946 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -39,7 +39,7 @@ static void save_state_to_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
 
     /* CR3 and ldt selector are not saved intentionally */
     tss->eip = (uint32_t)env->eip;
-    tss->eflags = EFLAGS(env);
+    tss->eflags = (uint32_t)env->eflags;
     tss->eax = EAX(env);
     tss->ecx = ECX(env);
     tss->edx = EDX(env);
@@ -65,7 +65,7 @@ static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
     wvmcs(cpu->hvf_fd, VMCS_GUEST_CR3, tss->cr3);
 
     env->eip = tss->eip;
-    EFLAGS(env) = tss->eflags | 2;
+    env->eflags = tss->eflags | 2;
 
     /* General purpose registers */
     RAX(env) = tss->eax;
@@ -158,7 +158,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
     }
 
     if (reason == TSR_IRET)
-        EFLAGS(env) &= ~RFLAGS_NT;
+        env->eflags &= ~RFLAGS_NT;
 
     if (reason != TSR_CALL && reason != TSR_IDT_GATE)
         old_tss_sel.sel = 0xffff;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index edefe5319a..5cbcb32ab6 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -412,7 +412,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
 
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
         (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
-        (EFLAGS(env) & IF_MASK) && !(info & VMCS_INTR_VALID)) {
+        (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(&x86cpu->env);
         cpu_state->interrupt_request &= ~CPU_INTERRUPT_HARD;
         if (line >= 0) {
@@ -432,7 +432,7 @@ int hvf_process_events(CPUState *cpu_state)
     X86CPU *cpu = X86_CPU(cpu_state);
     CPUX86State *env = &cpu->env;
 
-    EFLAGS(env) = rreg(cpu_state->hvf_fd, HV_X86_RFLAGS);
+    env->eflags = rreg(cpu_state->hvf_fd, HV_X86_RFLAGS);
 
     if (cpu_state->interrupt_request & CPU_INTERRUPT_INIT) {
         hvf_cpu_synchronize_state(cpu_state);
@@ -444,7 +444,7 @@ int hvf_process_events(CPUState *cpu_state)
         apic_poll_irq(cpu->apic_state);
     }
     if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
-        (EFLAGS(env) & IF_MASK)) ||
+        (env->eflags & IF_MASK)) ||
         (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_state->halted = 0;
     }
-- 
2.26.1


