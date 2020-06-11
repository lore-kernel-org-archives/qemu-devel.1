Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB52CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807352073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GP4EoOX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807352073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTwh-0008SR-Qf
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAQ-0001vi-D7
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51103
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAM-0001Py-MS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mt/mzo7Xjry8W/ngrfH4ZHzjNcs1f2BBM2/k/sxZwoM=;
 b=GP4EoOX9TZhDU3voysGzgeZIc4hxjYTvigBkb98KTp45QKYlCgJ/gniuON/9UwZa63xUrB
 u8PjPcqYjZMXvjrrp8J8N0QJsvl3vB68IkOUHIG9N2cT2xyNb8its7B14fGC3bOIi0uXYO
 oCBfoZREB08Ocy0I6FvLSfpXwio+znE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-DzieUaGuOYeOynBIcw234g-1; Thu, 11 Jun 2020 15:47:02 -0400
X-MC-Unique: DzieUaGuOYeOynBIcw234g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C75845F2A;
 Thu, 11 Jun 2020 19:47:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1861010013D7;
 Thu, 11 Jun 2020 19:47:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 093/115] i386: hvf: Drop rflags from HVFX86EmulatorState
Date: Thu, 11 Jun 2020 15:44:27 -0400
Message-Id: <20200611194449.31468-94-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

HVFX86EmulatorState carries it's own copy of x86 flags. It can be
dropped in favor of eflags in generic CPUX86State.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-9-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.26.2



