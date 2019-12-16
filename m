Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B392FC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73011206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UN7Bwu6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73011206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyvd-0005kv-Lm
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybb-0005ir-Pl
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyba-0007ma-Mo
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:43 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyba-0007mQ-HL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:42 -0500
Received: by mail-pg1-x541.google.com with SMTP id s64so4488991pgb.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DPDM5gwX8Fn+IwrqOpQTWcLHE7dPxmxG57n6nMl0zxo=;
 b=UN7Bwu6+vOzTHBL6i9nPiI8ZiDgfElJLwM8FCB7zZWSEOagzuNJmZfuexqMfRBdd4I
 EwG1TXovlLiTAhK+gAU7fRxPJXmxvdbR1cEGzm0FV9yl7n2vplZL6wHWeOU/h1Mch96d
 ZfsQlJJdx/Q7mO9lWo5KseNk5WgRllfRI6XH7GVzGf+F53ohbdCXYUuzmB3bh6P1+aTS
 o5aKHLKbHXeAIxKXxDJXxiVeKAO9JBk1YeGJJmFbrPP+89EcGwFfo8vhuPkQnV+b8GgO
 kOdkCaZJ1ZVqhGw9WS9udTsoZsXw6sGqo+PkmndXRiwEsTRmrbX6ScOt/7EjRL4XHYWR
 cCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DPDM5gwX8Fn+IwrqOpQTWcLHE7dPxmxG57n6nMl0zxo=;
 b=khcr6lyFvf+MKbJibmmnV0iLLooVvafQjHMFbh1CAobUAZR+j3UWXn5E89O+1t0IJB
 V0Nzk7TwCiM6jWzVhYUMSXkM8RLxVgbKwO4BwjolSZr/NDo9ClIlxZ6zMMAnsV/ssD8m
 IQrQVLhuAI6N4oAj8+tesOf8C1sTMMz39RIcS9C/hBbTqJH7ZjAPVCreW2Hy0Z8+TwbD
 I5uzIbszWPyjAQAGGf+NNKtKoV7V3mE9DOlgA6g4UqJrpDbdm9kqeWqPH0PD44RTYe3+
 ctJ1qaDyYJ2OYJngwk4GPxqQAFqi+Chu4Jxz1x6NcS4xs6f81EwLYVLKVGj4Iz20MotT
 +6+w==
X-Gm-Message-State: APjAAAVkioW3vemS3g5kCENvRyBDPNwQQIooIXYM+CAYjPiophpP2Wcp
 P0eNAlbeDNbFvG0GBxpr+4wxL0IjL7A=
X-Google-Smtp-Source: APXvYqxdsTLRo2YI0jZNV7EEq/hRTbKBBHIb5YmKmUpI1le6cnqKFF4TXbBLyb8k0oyqqUg1z62lGA==
X-Received: by 2002:aa7:850c:: with SMTP id v12mr18697255pfn.188.1576534361333; 
 Mon, 16 Dec 2019 14:12:41 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/28] target/ppc: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Mon, 16 Dec 2019 12:11:56 -1000
Message-Id: <20191216221158.29572-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are only two uses.  Within dcbz_common, the local variable
mmu_idx already contains the epid computation, and we can avoid
repeating it for the store.  Within helper_icbiep, the usage is
trivially expanded using PPC_TLB_EPID_LOAD.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h        |  2 --
 target/ppc/mem_helper.c | 11 ++---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e3e82327b7..3bd983adaa 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -951,8 +951,6 @@ struct ppc_radix_page_info {
  * + real/paged mode combinations. The other two modes are for
  * external PID load/store.
  */
-#define MMU_MODE8_SUFFIX _epl
-#define MMU_MODE9_SUFFIX _eps
 #define PPC_TLB_EPID_LOAD 8
 #define PPC_TLB_EPID_STORE 9
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 1351b53f28..56855f2381 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -177,14 +177,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     } else {
         /* Slow path */
         for (i = 0; i < dcbz_size; i += 8) {
-            if (epid) {
-#if !defined(CONFIG_USER_ONLY)
-                /* Does not make sense on USER_ONLY config */
-                cpu_stq_eps_ra(env, addr + i, 0, retaddr);
-#endif
-            } else {
-                cpu_stq_data_ra(env, addr + i, 0, retaddr);
-            }
+            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
         }
     }
 }
@@ -216,7 +209,7 @@ void helper_icbiep(CPUPPCState *env, target_ulong addr)
 #if !defined(CONFIG_USER_ONLY)
     /* See comments above */
     addr &= ~(env->dcache_line_size - 1);
-    cpu_ldl_epl_ra(env, addr, GETPC());
+    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
 #endif
 }
 
-- 
2.20.1


