Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 10:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2EB238E2
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 10:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2EB238E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM7eV-0001xX-5g
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 06:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1kM7dL-0001Vj-4B
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 06:40:51 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:53086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1kM7dI-00015Y-7m
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 06:40:50 -0400
Received: from localhost (unknown [192.168.167.32])
 by lucky1.263xmail.com (Postfix) with ESMTP id 9A603CC3C4;
 Sat, 26 Sep 2020 18:40:31 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.33.251.241])
 by smtp.263.net (postfix) whith ESMTP id
 P19669T139950693541632S1601116809524710_; 
 Sat, 26 Sep 2020 18:40:31 +0800 (CST)
X-UNIQUE-TAG: <6a31ffff3078716fef9ee4c314a94998>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: ehabkost@redhat.com
X-SENDER-IP: 111.33.251.241
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: ehabkost@redhat.com,
	marcel.apfelbaum@gmail.com,
	laurent@vivier.eu
Subject: [PATCH] linux-user: i386: Use trapnr which returns from cpu_exec()
 instead of exception_index
Date: Sat, 26 Sep 2020 18:39:56 +0800
Message-Id: <20200926103956.28199-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.157.147.130;
 envelope-from=chengang@emindsoft.com.cn; helo=lucky1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 06:40:37
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Chen Gang <chengang@emindsoft.com.cn>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

After return from cpu_exec(), the exception_index is already set 0 in
cpu_handle_exception(), so we need the trapnr which returns from
cpu_exec() for trapno of target sigcontext.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 include/hw/core/cpu.h      |  2 ++
 linux-user/i386/cpu_loop.c | 15 +++++++--------
 linux-user/i386/signal.c   |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8f145733ce..390e27d9e1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -458,6 +458,8 @@ struct CPUState {
 
     /* track IOMMUs whose translations we've cached in the TCG TLB */
     GArray *iommu_notifiers;
+
+    int trapnr;
 };
 
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 70cde417e6..f0db088221 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -198,17 +198,16 @@ static void emulate_vsyscall(CPUX86State *env)
 void cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    int trapnr;
     abi_ulong pc;
     abi_ulong ret;
 
     for(;;) {
         cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
+        cs->trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
         process_queued_cpu_work(cs);
 
-        switch(trapnr) {
+        switch (cs->trapnr) {
         case 0x80:
             /* linux syscall from int $0x80 */
             ret = do_syscall(env,
@@ -273,7 +272,7 @@ void cpu_loop(CPUX86State *env)
         case EXCP00_DIVZ:
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
-                handle_vm86_trap(env, trapnr);
+                handle_vm86_trap(env, cs->trapnr);
                 break;
             }
 #endif
@@ -283,11 +282,11 @@ void cpu_loop(CPUX86State *env)
         case EXCP03_INT3:
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
-                handle_vm86_trap(env, trapnr);
+                handle_vm86_trap(env, cs->trapnr);
                 break;
             }
 #endif
-            if (trapnr == EXCP01_DB) {
+            if (cs->trapnr == EXCP01_DB) {
                 gen_signal(env, TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->eip);
             } else {
                 gen_signal(env, TARGET_SIGTRAP, TARGET_SI_KERNEL, 0);
@@ -297,7 +296,7 @@ void cpu_loop(CPUX86State *env)
         case EXCP05_BOUND:
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
-                handle_vm86_trap(env, trapnr);
+                handle_vm86_trap(env, cs->trapnr);
                 break;
             }
 #endif
@@ -318,7 +317,7 @@ void cpu_loop(CPUX86State *env)
         default:
             pc = env->segs[R_CS].base + env->eip;
             EXCP_DUMP(env, "qemu: 0x%08lx: unhandled CPU exception 0x%x - aborting\n",
-                      (long)pc, trapnr);
+                      (long)pc, cs->trapnr);
             abort();
         }
         process_pending_signals(env);
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 97a39204cc..c184d28d22 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -215,7 +215,7 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     __put_user(env->regs[R_EDX], &sc->edx);
     __put_user(env->regs[R_ECX], &sc->ecx);
     __put_user(env->regs[R_EAX], &sc->eax);
-    __put_user(cs->exception_index, &sc->trapno);
+    __put_user(cs->trapnr, &sc->trapno);
     __put_user(env->error_code, &sc->err);
     __put_user(env->eip, &sc->eip);
     __put_user(env->segs[R_CS].selector, (unsigned int *)&sc->cs);
@@ -251,7 +251,7 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     __put_user(env->regs[14], &sc->r14);
     __put_user(env->regs[15], &sc->r15);
 
-    __put_user(cs->exception_index, &sc->trapno);
+    __put_user(cs->trapnr, &sc->trapno);
     __put_user(env->error_code, &sc->err);
     __put_user(env->eip, &sc->rip);
 
-- 
2.24.0.308.g228f53135a




