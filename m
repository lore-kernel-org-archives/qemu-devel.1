Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D97C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 08:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4424205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 08:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4424205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgmhq-0003Kz-5p
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 04:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgmff-00017H-FB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgmfd-0001Z8-9T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:55:51 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48355 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hgmfb-0001Lz-Rx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:55:49 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D70811A1D9C;
 Fri, 28 Jun 2019 10:55:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B7AA91A221C;
 Fri, 28 Jun 2019 10:55:33 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Fri, 28 Jun 2019 10:54:42 +0200
Message-Id: <1561712082-31441-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561712082-31441-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561712082-31441-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v15 5/5] linux-user: Handle EXCP_FPE properly
 for MIPS
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Handle EXCP_FPE properly for MIPS in cpu loop.

Note that a vast majority of FP instructions are not affected by
the absence of the code in this patch, as they use alternative code
paths for handling floating point exceptions (see, for example,
invocations of update_fcr31()) - they rely on softfloat library for
keeping track on exceptions that needs to be raised. However, there
are few MIPS FP instructions (an example is CTC1) that use function
do_raise_exception() directly, and they need the case that is added
in this patch to propagate the FPE exception as designed.

The code is based on kernel's function force_fcr31_sig() in
arch/mips/kernel.traps.c.

Reported-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/mips/cpu_loop.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 43ba267..0ba894f 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -540,6 +540,23 @@ done_syscall:
             info.si_code = TARGET_ILL_ILLOPC;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
+        case EXCP_FPE:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = TARGET_FPE_FLTUNK;
+            if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_INVALID) {
+                info.si_code = TARGET_FPE_FLTINV;
+            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_DIV0) {
+                info.si_code = TARGET_FPE_FLTDIV;
+            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_OVERFLOW) {
+                info.si_code = TARGET_FPE_FLTOVF;
+            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_UNDERFLOW) {
+                info.si_code = TARGET_FPE_FLTUND;
+            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_INEXACT) {
+                info.si_code = TARGET_FPE_FLTRES;
+            }
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         /* The code below was inspired by the MIPS Linux kernel trap
          * handling code in arch/mips/kernel/traps.c.
          */
-- 
2.7.4


