Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC35C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 10:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C212075F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 10:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C212075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaGLL-0008B0-Il
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 06:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skrll@netbsd.org>) id 1jaGJ4-00073T-9V
 for qemu-devel@nongnu.org; Sun, 17 May 2020 06:14:06 -0400
Received: from mail.netbsd.org ([199.233.217.200]:61061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skrll@netbsd.org>) id 1jaGJ3-0006PP-6q
 for qemu-devel@nongnu.org; Sun, 17 May 2020 06:14:05 -0400
Received: by mail.netbsd.org (Postfix, from userid 1220)
 id 9395E84C8B; Sun, 17 May 2020 10:14:02 +0000 (UTC)
From: Nick Hudson <skrll@netbsd.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Provide a NetBSD specific aarch64 cpu_signal_handler
Date: Sun, 17 May 2020 11:13:39 +0100
Message-Id: <20200517101339.5278-1-skrll@netbsd.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=199.233.217.200; envelope-from=skrll@netbsd.org;
 helo=mail.netbsd.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 06:14:03
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Nick Hudson <skrll@netbsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix qemu build on NetBSD/evbarm-aarch64 by providing a NetBSD specific
cpu_signal_handler.

Signed-off-by: Nick Hudson <skrll@netbsd.org>
---
 accel/tcg/user-exec.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 4be78eb9b3..dd128adc00 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -523,6 +523,31 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
 #elif defined(__aarch64__)
 
+#if defined(__NetBSD__)
+
+#include <ucontext.h>
+#include <sys/siginfo.h>
+
+int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
+{
+    ucontext_t *uc = puc;
+    siginfo_t *si = pinfo;
+    unsigned long pc;
+    int is_write;
+    uint32_t esr;
+
+    pc = uc->uc_mcontext.__gregs[_REG_PC];
+    esr = si->si_trap;
+
+    /* siginfo_t::si_trap is the ESR value, for data aborts ESR.EC
+     * is 0b10010x: then bit 6 is the WnR bit
+     */
+    is_write = extract32(esr, 27, 5) == 0x12 && extract32(esr, 6, 1) == 1;
+    return handle_cpu_signal(pc, si, is_write, &uc->uc_sigmask);
+}
+
+#else
+
 #ifndef ESR_MAGIC
 /* Pre-3.16 kernel headers don't have these, so provide fallback definitions */
 #define ESR_MAGIC 0x45535201
@@ -585,6 +610,7 @@ int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
     }
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
+#endif
 
 #elif defined(__s390__)
 
-- 
2.17.1


