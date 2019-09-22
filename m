Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C1A2080F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahPTAEdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C1A2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBtEu-0002Cc-9s
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy3-0001qo-Vo
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy2-0008KB-Na
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:23 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsy2-0008JT-Gl
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:22 -0400
Received: by mail-pl1-x642.google.com with SMTP id u12so4953598pls.12
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zEd6YE2E51WcAYpdL1J80c/c4YK3movqIfz5U+RR1Wo=;
 b=ahPTAEdLS/CFjPoKB2eUVHeIexGBLL6i3O33ZfdtOPD7FfG303LYID/k7GkUc//OIz
 jBycjRCZ7WSPvxjAhPYiv6rtS/95UqurvzUQdZjDhEyHH/Y2HaJfvF/iPDGOPIHCvufA
 Wah6xUW4IEBvExcBWZzJNEVbG8B89A+XaNgT7UHb7apmJ44c8VxyjHGIYTIQt91ofm9x
 Fk+pwxp75JT1qOrCQ6MoXgW1Rmpiv3sPw0wTRaPgwUCGD9xGdGBORN1Yt1mb2nRHUldj
 Djy611wWfxKDD56x7hxKhz7GGzjM3IiCEgcusSgaNQ+60QI4STU+NY8yH7JPBI09nyNc
 /cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zEd6YE2E51WcAYpdL1J80c/c4YK3movqIfz5U+RR1Wo=;
 b=dKimr+AN18NfmZZb3DBB9m+91lrluLX7dhTJUW8az0IFo07vVKr+HjcJqHGGUNGJWJ
 Uqa0e3ufRHUYGh3J+K936gR0jxdm31Q8CJVSArNVSi9h4/U2h/Lcjzq5byr7FAQU8lDU
 je8kUPGhV3p6BRJJCbS9xaKx/Ie8DrXRHDyiI5smI5c8y6ui6d2EkgO2pnC8LftsbaLz
 ZOxH2xTdkv9M2gaPzvqoLexS5MHQ+I+YgHOUX8p846tI6JiJXx9gGpuF+Xus1qAVa0ls
 X0EqQS7dTLS4j21G3F2Rvfje8M3Cz1yMtNjzPniUMcAGTaMvvH+duQRiwV4Vb/oks25f
 pT8w==
X-Gm-Message-State: APjAAAVhfv09eEf9z5jHTzMFlZFjJXj7Y8xjFV3pe0fLDNV0wJiM+PSC
 CPsdyH5XJ3CgBWO83iswXyZ5IWcGJKk=
X-Google-Smtp-Source: APXvYqzSE8M5fWbBBDrlvprdOb8HjuYi2T2ERdExmvR2v8ilXKNtn2/fQhoLtw6A/ErJnApfThJJ9g==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr3321plq.17.1569124521049; 
 Sat, 21 Sep 2019 20:55:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/20] cputlb: Handle TLB_NOTDIRTY in probe_access
Date: Sat, 21 Sep 2019 20:54:54 -0700
Message-Id: <20190922035458.14879-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
index 6f685cb93a..6f4096bd0d 100644
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


