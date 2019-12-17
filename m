Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCD3C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAE62082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAE62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dornerworks.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihLH6-0004BA-6X
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 17:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jeff.Kubascik@dornerworks.com>) id 1ihJzQ-0007JD-6L
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 16:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jeff.Kubascik@dornerworks.com>) id 1ihJzO-0006vs-RB
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 16:02:44 -0500
Received: from mail.dornerworks.com ([12.207.209.150]:48067
 helo=webmail.dornerworks.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Jeff.Kubascik@dornerworks.com>)
 id 1ihJzL-0006no-QA; Tue, 17 Dec 2019 16:02:40 -0500
From: Jeff Kubascik <jeff.kubascik@dornerworks.com>
To: Peter Maydell <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH] target/arm: fix IL bit for data abort exceptions
Date: Tue, 17 Dec 2019 16:02:30 -0500
Message-ID: <20191217210230.99559-1-jeff.kubascik@dornerworks.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.27.13.171]
X-ClientProxiedBy: Mcbain.dw.local (172.27.1.45) To Mcbain.dw.local
 (172.27.1.45)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 12.207.209.150
X-Mailman-Approved-At: Tue, 17 Dec 2019 17:23:30 -0500
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Instruction Length bit of the Exception Syndrome Register was fixed to 1
for data aborts. This bit is used by the Xen hypervisor to determine how to
increment the program counter after a mmio handler is successful and returns
control back to the guest virtual machine. With this value fixed to 1, the
hypervisor would always increment the program counter by 0x4. This is a
problem when the guest virtual machine is using Thumb instructions, as the
instruction that caused the exception may be 16 bits.

This adds a is_16bit flag to the disassembler context to keep track of the
current instruction length. For load/store instructions, the instruction
length bit is stored with the instruction syndrome data, to be later used if
the data abort occurs.

Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
---
Hello,

I am using the ARMv8 version of QEMU to run the Xen hypervisor with a guest
virtual machine compiled for AArch32/Thumb code. I have noticed that when
the guest VM tries to write to an emulated PL011 register, the mmio handler
always increments the program counter by 4, even if the store instruction
that caused the exception was a 16-bit Thumb instruction.

I have traced this back to the IL bit in the ESR_EL2 register. Xen uses the
IL bit to determine how to increment the program counter. However, QEMU does
not correctly emulate this bit, always setting it to 1 (32-bit instruction).

The above patch works for my setup. However, I am not very familiar with the
QEMU code base, so it may not be the best way to do it, or even be correct.
Any feedback would be greatly appreciated.

Sincerely,
Jeff Kubascik
---
 target/arm/tlb_helper.c    | 2 +-
 target/arm/translate-a64.c | 1 +
 target/arm/translate.c     | 4 +++-
 target/arm/translate.h     | 2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 5feb312941..e63f8bda29 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -44,7 +44,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
         syn = syn_data_abort_with_iss(same_el,
                                       0, 0, 0, 0, 0,
                                       ea, 0, s1ptw, is_write, fsc,
-                                      false);
+                                      true);
         /* Merge the runtime syndrome with the template syndrome.  */
         syn |= template_syn;
     }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d4bebbe629..a3c618fdd9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14045,6 +14045,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     s->pc_curr = s->base.pc_next;
     insn = arm_ldl_code(env, s->base.pc_next, s->sctlr_b);
     s->insn = insn;
+    s->is_16bit = false;
     s->base.pc_next += 4;
 
     s->fp_access_checked = false;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2b6c1f91bf..300480f1b7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8555,7 +8555,7 @@ static ISSInfo make_issinfo(DisasContext *s, int rd, bool p, bool w)
 
     /* ISS not valid if writeback */
     if (p && !w) {
-        ret = rd;
+        ret = rd | (s->is_16bit ? ISSIs16Bit : 0);
     } else {
         ret = ISSInvalid;
     }
@@ -11057,6 +11057,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->pc_curr = dc->base.pc_next;
     insn = arm_ldl_code(env, dc->base.pc_next, dc->sctlr_b);
     dc->insn = insn;
+    dc->is_16bit = false;
     dc->base.pc_next += 4;
     disas_arm_insn(dc, insn);
 
@@ -11126,6 +11127,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->pc_curr = dc->base.pc_next;
     insn = arm_lduw_code(env, dc->base.pc_next, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, dc->base.pc_next, insn);
+    dc->is_16bit = is_16bit;
     dc->base.pc_next += 2;
     if (!is_16bit) {
         uint32_t insn2 = arm_lduw_code(env, dc->base.pc_next, dc->sctlr_b);
diff --git a/target/arm/translate.h b/target/arm/translate.h
index b837b7fcbf..c16f434477 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -14,6 +14,8 @@ typedef struct DisasContext {
     target_ulong pc_curr;
     target_ulong page_start;
     uint32_t insn;
+    /* 16-bit instruction flag */
+    bool is_16bit;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
     /* The label that will be jumped to when the instruction is skipped.  */
-- 
2.17.1


