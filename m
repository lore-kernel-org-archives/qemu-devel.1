Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA28C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380B62074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="DNc99yFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380B62074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0nY-000791-CB
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jw0lF-0006ae-Id
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:05:05 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:41484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jw0lD-0001U5-Cn
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:05:05 -0400
Received: from michell-laptop.bar.greensocs.com (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPS id CBFE32000A;
 Thu, 16 Jul 2020 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1594893898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gqETki5+C+eGFJSerGN3UnQDjssD8Cp5qBVCIW3JLrE=;
 b=DNc99yFCNjNvic/9tAUXl3unCPFJtLgnX1QsRijAm9TyDYRH/QvjDPvUV1RvXjJ1nWwW9B
 HIoai+0GRnT/oY9FMd0C1BRxqDjMoA5gW+0hFPTG/S9HPd4FrKLDTN14CAt6cIMMJd2mUo
 +Z2n8MW7d6+HKCMWiZ1zgLdTA6z3xQE=
From: Luc Michel <luc.michel@greensocs.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Subject: [RFC PATCH] tcg/cpu-exec: precise single-stepping after an exception
Date: Thu, 16 Jul 2020 12:04:45 +0200
Message-Id: <20200716100445.3748740-1-luc.michel@greensocs.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 06:04:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When single-stepping with a debugger attached to QEMU, and when an
exception is raised, the debugger misses the first instruction after the
exception:

$ qemu-system-aarch64 -M virt -display none -cpu cortex-a53 -s -S

$ aarch64-linux-gnu-gdb
GNU gdb (GDB) 9.2
[...]
(gdb) tar rem :1234
Remote debugging using :1234
warning: No executable has been specified and target does not support
determining executable automatically.  Try using the "file" command.
0x0000000000000000 in ?? ()
(gdb) # writing nop insns to 0x200 and 0x204
(gdb) set *0x200 = 0xd503201f
(gdb) set *0x204 = 0xd503201f
(gdb) # 0x0 address contains 0 which is an invalid opcode.
(gdb) # The CPU should raise an exception and jump to 0x200
(gdb) si
0x0000000000000204 in ?? ()

With this commit, the same run steps correctly on the first instruction
of the exception vector:

(gdb) si
0x0000000000000200 in ?? ()

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---

RFC because I'm really not sure this is the good place to do that since
EXCP_DEBUG are usually raised in each target translate.c. It could also
have implications with record/replay I'm not aware of.

---
 accel/tcg/cpu-exec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d95c4848a4..e85fab5d40 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -502,10 +502,21 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
             CPUClass *cc = CPU_GET_CLASS(cpu);
             qemu_mutex_lock_iothread();
             cc->do_interrupt(cpu);
             qemu_mutex_unlock_iothread();
             cpu->exception_index = -1;
+
+            if (unlikely(cpu->singlestep_enabled)) {
+                /*
+                 * After processing the exception, ensure an EXCP_DEBUG is
+                 * raised when single-stepping so that GDB doesn't miss the
+                 * next instruction.
+                 */
+                cpu->exception_index = EXCP_DEBUG;
+                return cpu_handle_exception(cpu, ret);
+            }
+
         } else if (!replay_has_interrupt()) {
             /* give a chance to iothread in replay mode */
             *ret = EXCP_INTERRUPT;
             return true;
         }
-- 
2.27.0


