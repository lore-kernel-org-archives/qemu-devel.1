Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF1C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DC721BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNk8NQ93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DC721BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXSi-0004wY-4m
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJl-0005hS-Eq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJj-00088E-Gt
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:29 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJi-00087E-Ue
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:27 -0400
Received: by mail-pg1-x544.google.com with SMTP id v27so2796262pgk.10
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C7NIKJXdUrtrKzRhohggBciUBf2QS9tq3iex/j818EA=;
 b=oNk8NQ93dRplDNU8a9jkYUOIIxsXsPUMhFGjWWuc407ONzGPNoNTodmO2DzLhQicbN
 v5CJHj5fPDGfvkmJz9U4UfjQfJ32OfJQwTZ8IKErbXE2ktI6xAKdy+eEvEk86jOfUFBH
 pDTPqHiCdErH2f3cJc7GtLZCYtpB4VzzTHgMXK4xpJeluNOOR7Av14DgS/WsSQKHa66/
 rESxYrhs+T9dFoz29/0buSMwgVM5MlZbv8HWCj62/xMx392zlD7y9P/mr7iyeCYqeaqz
 yGjvWAnsF36htFkXov4pujX78aU650ps4l1I30zylj9rUxGinRs2qf+0dq5Lxi3Hqb5D
 Nr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C7NIKJXdUrtrKzRhohggBciUBf2QS9tq3iex/j818EA=;
 b=YfQugzycTsdkc9TrNC1xIjZKAzV/GtfPhWFNuyMrR3z3xkIxn/DRljo5eP/sfu531Q
 mkg1ZiXKcl2aQzdc+hnJgdODbGBUhqBPWIL/qrmtTRKkf2F5NCx6dIOke/K1oTjwkCJE
 HuQXcAzM/M2AKtbUlMNOIKxCanfFw6gyoqgS9dNKp/iQzxgrjydByX4I+gwIjYvJXkN9
 ueyktJ1kqrQ3fLybgoLmco/Qc58U1gEHwVTWEnnqyYyY21A/jcg/NgwmDXAeQhMPhTTP
 DCGmytyYcn7acim5hwRULgdFtYF7F/P30a512yaygmVzLad5Zlhp1ZQJlPtTZbaYqrl5
 w25Q==
X-Gm-Message-State: APjAAAXsqtFvJfACtmzVZuZBl94MpxeHPSLJeQkpKI8FbTXBi6nzgZEw
 Lirg93KoLOe1MS4mU6/25Em1kqZQowc=
X-Google-Smtp-Source: APXvYqxiGgJc6LzrEinTOwxdVuO2DJKcpveZaD+zfX3ihxVc0ARTjQSQj+thYPIq2wnxRS4D1xt06g==
X-Received: by 2002:a62:3147:: with SMTP id x68mr2125356pfx.129.1569279625122; 
 Mon, 23 Sep 2019 16:00:25 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/16] cputlb: Handle TLB_NOTDIRTY in probe_access
Date: Mon, 23 Sep 2019 16:00:00 -0700
Message-Id: <20190923230004.9231-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

We can use notdirty_write for the write and
return a valid host pointer for this case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 09b0df87c6..d0bdef1eb3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1167,16 +1167,24 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
         return NULL;
     }
 
-    /* Handle watchpoints.  */
-    if (tlb_addr & TLB_WATCHPOINT) {
-        cpu_check_watchpoint(env_cpu(env), addr, size,
-                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
-                             wp_access, retaddr);
-    }
+    if (unlikely(tlb_addr & TLB_FLAGS_MASK)) {
+        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
 
-    /* Reject I/O access, or other required slow-path.  */
-    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP | TLB_ROM)) {
-        return NULL;
+        /* Reject I/O access, or other required slow-path.  */
+        if (tlb_addr & (TLB_MMIO | TLB_BSWAP | TLB_ROM)) {
+            return NULL;
+        }
+
+        /* Handle watchpoints.  */
+        if (tlb_addr & TLB_WATCHPOINT) {
+            cpu_check_watchpoint(env_cpu(env), addr, size,
+                                 iotlbentry->attrs, wp_access, retaddr);
+        }
+
+        /* Handle clean RAM pages.  */
+        if (tlb_addr & TLB_NOTDIRTY) {
+            notdirty_write(env_cpu(env), addr, size, iotlbentry, retaddr);
+        }
     }
 
     return (void *)((uintptr_t)addr + entry->addend);
-- 
2.17.1


