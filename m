Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D5C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C82205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSa8OYsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C82205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXen-0007v7-77
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJp-0005kw-OF
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJn-0008BI-NQ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:33 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJn-0008Ah-EH
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id s1so7780240pgv.8
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jECBewfqaW7UcxXyZuLJYCCjFkwJDy6OJzmhsg374E4=;
 b=uSa8OYsaAPdBlDySx3jpe8K4Lkk2zDZHOBVdRRmmuqtJmm6HwFTPJ6tUw9BHce3iiO
 eU/0TGg2XhC2D1rt8vO0foHpZdr2BIhydY6/LXJTQEWnPBiHLE+bcZPrXHMUY1uxVfnT
 r7dKPv+ejn/MdbzmOpsZbQcEG3jaHbzLqYtT/SkW+72xOGr6SI46JQJLho7ay9s1CNyU
 e+1DgbodXNZMWFyLtQpXW5FBjVjTFL0mCNz477RbWtVKConOWPk0mQFlTJlO9zTuFrEb
 qIpDnSnMOAblgWeXUfFbUFO2VulBfWnxr46GczkGcnJbLrZZr8b0BAzCms5VmsIqqidd
 X65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jECBewfqaW7UcxXyZuLJYCCjFkwJDy6OJzmhsg374E4=;
 b=WgnfUPM0kIGu84vOL3BH6a+stS9cPyROlYO2vngujglV815B/kCqDAfG+qhpWuQSwb
 kywU4B+GWpjczrHNhj/f1LyAGZ9yLYqXqbyuk1pG01gseoOVOMpem/C1rpJWgoSws6gh
 xuOQiXeMmxFDBxrYJdDIHJ/dFpv0eOGYtz++gXh3ZuQ4Ui/tzWoc+vLYnOyQN+aOtViL
 vAIJ+yqClWkN23ucDGfGlEqjhL/enr1/aH04ntevfGbSByghb2ymzLPL72qngPlsmKwX
 cC4ZWQ0ePU2BxUbza0fyVqPdWAjcOhE8AwJQfsO2yUXiqIrjs7eU/vrp9CciMXV0yA3N
 rDhQ==
X-Gm-Message-State: APjAAAU+a70G9tD4Dhfw/QBZqwP2ykKn5gH1B8R4Sd25+dGueZc7OJZ6
 72Kfrk5gK8ZaSRWe38o3K/yHH3+qgQs=
X-Google-Smtp-Source: APXvYqyQH8ZTwjhd1Si9y1gViIUakNVFXN6tY81qSDQu/iE21Wj3/YD2nQ3XcgwrvnXkXxVB03dvjg==
X-Received: by 2002:a65:420d:: with SMTP id c13mr2247741pgq.293.1569279630041; 
 Mon, 23 Sep 2019 16:00:30 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/16] cputlb: Pass retaddr to tb_check_watchpoint
Date: Mon, 23 Sep 2019 16:00:04 -0700
Message-Id: <20190923230004.9231-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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
index b3df826039..8a0a6613b1 100644
--- a/exec.c
+++ b/exec.c
@@ -2758,7 +2758,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 cpu->watchpoint_hit = wp;
 
                 mmap_lock();
-                tb_check_watchpoint(cpu);
+                tb_check_watchpoint(cpu, ra);
                 if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                     cpu->exception_index = EXCP_DEBUG;
                     mmap_unlock();
-- 
2.17.1


