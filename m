Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE4BECE58B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBB321655
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sglKhyY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBB321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWpL-0008Ap-BZ
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc2-0002XO-H3
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWbz-0004c4-BJ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWbz-0004aX-6R
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so2103154pfn.11
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=m0A5hOzZEJmS1c+sxnHnolxCjQzyN94AtrGRUtBbpGQ=;
 b=sglKhyY6pcUvb3rcImY9EopmQ7xuhFcLjIxOGbccP9Rt1kpFKwah1P+fUQTu0L82qo
 d6fxq/o6p0DCYLenuB3i6FLaWLuHZ2jcnt2h6nG1Jn6V0R5HMUy6UJN+puw/F9hUHIAL
 gzHlBP4kavlioLAWJrFVv9uUNCuHDb6EGYUeQNW3bTx8DVwib7/l1+FXkTl+lhMnH+Cr
 BUfzZ+W5q0SV4IwKwiuVG3oZbVjiDx235b2Az+zGeiD6vTIE7Ib+gA48XhIEk/HMfZqg
 GffaC9Pvum9A/dm0Z9dOjGREZMuPf12wLff3Kiv5dUNirKXkLKDiBjoUfrVwmEWdMxY5
 PL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=m0A5hOzZEJmS1c+sxnHnolxCjQzyN94AtrGRUtBbpGQ=;
 b=P+J7OybrmgFza1WRIfSM6VaPDzFG1XoGgIGKHpSbxRoKbLper3IuyTbsSQ7/bQfZIN
 8n7tfVFRhKbrT0qIO60bGuy9KSEdhvsfme/jlQpXbZ65PjLECMybKR8LrlCFtKHkpTBw
 HMGZHNfCzpchDj2T7OkOUn4qyCDadDdXg+LEhpFAzS1+THBu0d5u8diIbtZbLHP/SPzR
 h5UZVfkzPNrZ2husJpNnKQuTh4kr3q6GwG5uUt4FeF5ppAS5/4nqA/4lJ8bdzGaVACBJ
 GKWBsqZrVEmM/MCJdGj2qo4GgLXXCbpeWvEnOT2ArrEmHPO7pKN3YfpJYnu6v/a8GVbi
 +rOQ==
X-Gm-Message-State: APjAAAWIAXnXoKpcwpa4z1Znww2qQXpBHPf5exwgwLd37f+eP2gN0x1+
 6cfh4jnzv+oMMFylvAt8/K3Tn8DXHZU=
X-Google-Smtp-Source: APXvYqxmah4eTeDLq6Cv+TFrZ6eJZ2scsNMs6k79k3NYmGLN8JkgPE1aMTGfqP5JWPTFtFdcK26HVQ==
X-Received: by 2002:a17:90a:a404:: with SMTP id
 y4mr4537383pjp.62.1569515179760; 
 Thu, 26 Sep 2019 09:26:19 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/18] target/s390x: Truncate 32-bit psw_addr before
 creating TB
Date: Thu, 26 Sep 2019 09:25:58 -0700
Message-Id: <20190926162615.31168-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If, somehow, the psw_addr is out of range, truncate early
rather than after we get into gen_intermediate_code.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h       | 26 +++++++++++++++++++-------
 target/s390x/translate.c |  6 ------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index e74a809257..ce20dafd23 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -357,18 +357,30 @@ static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
-static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+static inline void cpu_get_tb_cpu_state(CPUS390XState* env,
+                                        target_ulong *p_pc,
+                                        target_ulong *cs_base,
+                                        uint32_t *p_flags)
 {
-    *pc = env->psw.addr;
-    *cs_base = env->ex_value;
-    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+    uint32_t flags;
+    uint64_t pc;
+
+    flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
     if (env->cregs[0] & CR0_AFP) {
-        *flags |= FLAG_MASK_AFP;
+        flags |= FLAG_MASK_AFP;
     }
     if (env->cregs[0] & CR0_VECTOR) {
-        *flags |= FLAG_MASK_VECTOR;
+        flags |= FLAG_MASK_VECTOR;
     }
+
+    pc = env->psw.addr;
+    if (!(flags & FLAG_MASK_64)) {
+        pc &= 0x7fffffff;
+    }
+
+    *p_pc = pc;
+    *cs_base = env->ex_value;
+    *p_flags = flags;
 }
 
 /* PER bits from control register 9 */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a3e43ff9ec..e1c54ab03b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6446,12 +6446,6 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    /* 31-bit mode */
-    if (!(dc->base.tb->flags & FLAG_MASK_64)) {
-        dc->base.pc_first &= 0x7fffffff;
-        dc->base.pc_next = dc->base.pc_first;
-    }
-
     dc->cc_op = CC_OP_DYNAMIC;
     dc->ex_value = dc->base.tb->cs_base;
     dc->do_debug = dc->base.singlestep_enabled;
-- 
2.17.1


