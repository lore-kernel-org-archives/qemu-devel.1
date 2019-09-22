Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE032C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7222E20640
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLHucrYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7222E20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBtHx-0005fq-Ed
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy8-000205-VL
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy7-0008N2-P7
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsy7-0008MY-J3
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id q7so6974798pfh.8
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kZbTTJGGFu81f0ejGjFeWXy3vD4smmCaoq9ERb/1yZk=;
 b=YLHucrYFMviJNmlYZ/QnUNsCjp/v/VFyvhNa/tNx7v2jtAE5mwCOaZZUOiD8dUDZDm
 jcQiz1KLWWUOB2RommGkSQljhz3xRjEwzNsSFwIV8y5NUhJFpYVIJGYBXWm5axLQGL6s
 +if1gOlVBMH7G1HLLY4PHkM6X2kwHqz8L8YXpb+syGAWusb+XfH+vB0LUmjwtCZu4kAW
 9xbOKINboU4+NG7IXjiGVIc9RRB5TbaLwTRUcgREDYSMiybrBlj2+XReruREnqQCA2Se
 Phd3SvY25j9iw7oYrTcIR6HYhdDBQ13A5McD6n47VLQMUWZFXewkCwiB7v/YDpSLan6Q
 LTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kZbTTJGGFu81f0ejGjFeWXy3vD4smmCaoq9ERb/1yZk=;
 b=iLzpNQjJrfpw9nXhEYbLDW8l/rxOmljMKPhFBoQHmTHkF5+OcVmLg4Wqk83TW9PKWZ
 OxYMh5wD5PODFS9O3aw694nIouo9JeaE7wrTwdv3BQGSDlOZDWBE8ixGQYhYwqprXkCp
 dEYIU/6Nd0JRJDHRD3erDrH2Id9gbYC2tLKsUDmzUZV+NxIkLfEJzQQQQwryyuNfg5r6
 yD83Pv+9mTVYVIuu7kTTnetOhSeLEfY7RibKsEOXQ+1nAPtY2C8wawK6WdfFhnlInvcR
 LICK4fb7dV2WS6pU8ZdqiihwFT0wmy9N8SIAtwbLJcjtsguY0oxxma6J9JE3fAIsvuP6
 EQcg==
X-Gm-Message-State: APjAAAXv0AT0sI5vE6/CLDA62x8eBJYLlvQEM+Ib06B23GE9tchejwtL
 A4GnOFRbYr6wTTc0Q1Y6qcsDPoIAXsg=
X-Google-Smtp-Source: APXvYqyWNdq0wnjge3LKZ+3BBax+d+Y58SqQ3JwPDN/gp6w2pZEUrw4qx09j2wYU3EozkCQMAUwEZg==
X-Received: by 2002:a63:31d8:: with SMTP id
 x207mr23008887pgx.428.1569124526008; 
 Sat, 21 Sep 2019 20:55:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/20] cputlb: Pass retaddr to tb_check_watchpoint
Date: Sat, 21 Sep 2019 20:54:58 -0700
Message-Id: <20190922035458.14879-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes the previous TLB_WATCHPOINT patches because we are currently
failing to set cpu->mem_io_pc with the call to cpu_check_watchpoint.
Pass down the retaddr directly because it's readily available.

Fixes: 50b107c5d61
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.h | 2 +-
 accel/tcg/translate-all.c | 6 +++---
 exec.c                    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 135c1ea96a..a557b4e2bb 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -30,7 +30,7 @@ void tb_invalidate_phys_page_fast(struct page_collection *pages,
                                   tb_page_addr_t start, int len,
                                   uintptr_t retaddr);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end);
-void tb_check_watchpoint(CPUState *cpu);
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
 #ifdef CONFIG_USER_ONLY
 int page_unprotect(target_ulong address, uintptr_t pc);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index db77fb221b..66d4bc4341 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2142,16 +2142,16 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
 #endif
 
 /* user-mode: call with mmap_lock held */
-void tb_check_watchpoint(CPUState *cpu)
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
 {
     TranslationBlock *tb;
 
     assert_memory_lock();
 
-    tb = tcg_tb_lookup(cpu->mem_io_pc);
+    tb = tcg_tb_lookup(retaddr);
     if (tb) {
         /* We can use retranslation to find the PC.  */
-        cpu_restore_state_from_tb(cpu, tb, cpu->mem_io_pc, true);
+        cpu_restore_state_from_tb(cpu, tb, retaddr, true);
         tb_phys_invalidate(tb, -1);
     } else {
         /* The exception probably happened in a helper.  The CPU state should
diff --git a/exec.c b/exec.c
index fed25d029b..ceeef4cd4b 100644
--- a/exec.c
+++ b/exec.c
@@ -2724,7 +2724,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 cpu->watchpoint_hit = wp;
 
                 mmap_lock();
-                tb_check_watchpoint(cpu);
+                tb_check_watchpoint(cpu, ra);
                 if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                     cpu->exception_index = EXCP_DEBUG;
                     mmap_unlock();
-- 
2.17.1


