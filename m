Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACD0C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB84206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB84206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPoy-0002wo-BY
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skrll@netbsd.org>) id 1jYOiP-0004Oa-Gb
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:48:33 -0400
Received: from mail.netbsd.org ([2001:470:a085:999::25]:62787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skrll@netbsd.org>) id 1jYOiO-00033h-Dv
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:48:33 -0400
Received: by mail.netbsd.org (Postfix, from userid 1220)
 id 07F1384D81; Tue, 12 May 2020 06:48:27 +0000 (UTC)
From: Nick Hudson <skrll@netbsd.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] NetBSD/arm build fix
Date: Tue, 12 May 2020 07:48:23 +0100
Message-Id: <20200512064823.13025-1-skrll@netbsd.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2001:470:a085:999::25;
 envelope-from=skrll@netbsd.org; helo=mail.netbsd.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2020 03:56:14 -0400
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
Cc: Nick Hudson <skrll@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix building on NetBSD/arm by extracting the FSR value from the
correct siginfo_t field.

Signed-off-by: Nick Hudson <skrll@netbsd.org>
---
 accel/tcg/user-exec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 52359949df..3637626456 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -517,6 +517,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
 #if defined(__NetBSD__)
 #include <ucontext.h>
+#include <sys/siginfo.h>
 #endif
 
 int cpu_signal_handler(int host_signum, void *pinfo,
@@ -525,6 +526,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     siginfo_t *info = pinfo;
 #if defined(__NetBSD__)
     ucontext_t *uc = puc;
+    siginfo_t *si = pinfo;
 #else
     ucontext_t *uc = puc;
 #endif
@@ -539,10 +541,18 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     pc = uc->uc_mcontext.arm_pc;
 #endif
 
+#if defined(__NetBSD__)
+    /* siginfo_t::si_trap is the FSR value, in which bit 11 is WnR
+     * (assuming a v6 or later processor; on v5 we will always report
+     * this as a read).
+     */
+    is_write = extract32(si->si_trap, 11, 1);
+#else
     /* error_code is the FSR value, in which bit 11 is WnR (assuming a v6 or
      * later processor; on v5 we will always report this as a read).
      */
     is_write = extract32(uc->uc_mcontext.error_code, 11, 1);
+#endif
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
-- 
2.17.1


