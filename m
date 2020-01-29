Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A16FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23853206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnSPkNOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23853206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwx82-0007Qt-AV
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6e-0005zf-35
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6c-0001t7-VD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:48 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwx6c-0001s3-PZ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:46 -0500
Received: by mail-pg1-x542.google.com with SMTP id s64so627574pgb.9
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=42DTzkxwIkIPw/1LzUPJIt4v8UUQuVZ50M1s+EwARmU=;
 b=PnSPkNOso8gryQy6Y4ADutI8RnPNerJgzp3bLA6jxVTlI1k5tXZOOMLmG4LurRMT6v
 dZjS1O2pYiMfo9Rsm/QVeF9+Z+Opo7Y+mvMnfuPZCzvlJaNi5PinwvJc68lX6gOuaF0h
 TgWuf2TdHK9aOrObogca7YMI97dELWFiRCBJX9y6VgxhLI4qUwS5/I1z7GML5VZ5xWY+
 C5OfgHkusqzeAwcAv9EQfRx4V7mpIaRHrd4SFXWYAn+ozb5ii/6OOtZBBjEa4HGb/cfs
 LAIqgVEKAAtQjuHFVpB4Nq+EHRYhgBaViujKtvk7GSQoWqurmf+qeAWDuUIgi3yZK69H
 NSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=42DTzkxwIkIPw/1LzUPJIt4v8UUQuVZ50M1s+EwARmU=;
 b=avX2SiHAejiTkEv4u9Naitgrhl+OnAppLILIw6I+y7XJCFKcb9ILCHt636P344157i
 vwm3nPdkv5qh5DJWwe42nmaFLAxRONW1/t9a293h4nHTzXBKCES1QCLR3s6G1ybwyjZg
 zFdRymaiNl1XWL1+pqQ3g82SGPyI+Zna1zFtvEKM1LprqkHgtypuCJjDUytIg5zQ2CYo
 ArDXsPVJLEGpA2/rMTVdcHFY4xFyOxNoPaR8hUTPFuQgmj/ELX3WkJKVf5XeBVss2Vqa
 8FGCeGJx563u5xDO0ReaEilvrfyQA15/1s9PvX/hvWpWOmhkTqZ7qS8Wj1g9cinFGsCe
 n9Vw==
X-Gm-Message-State: APjAAAVBXkWpAkT8MBAdqJIFgXRwbm2onQSpEWlGjvpSGxIkY2M8cujl
 jT/moU2nKTzzjgWgdncmNCL36zvKYMA=
X-Google-Smtp-Source: APXvYqyse4L2CD8eq+DLjlpGRNQvOPf5WQZlst9bMrT5X44hr9LiFBjwTXNciyy4zHdDI5z4QAJICw==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr1660915pga.293.1580341845530; 
 Wed, 29 Jan 2020 15:50:45 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id 13sm3740195pfi.78.2020.01.29.15.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:50:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/ppc: Use probe_access for LMW, STMW
Date: Wed, 29 Jan 2020 15:50:38 -0800
Message-Id: <20200129235040.24022-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235040.24022-1-richard.henderson@linaro.org>
References: <20200129235040.24022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: hsp.cat7@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a minimum number of mmu lookups for the contiguous bytes
that are accessed.  If the lookup succeeds, we can finish the
operation with host addresses only.

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 45 +++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 508d472a2f..e7d3a79d96 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -84,26 +84,45 @@ static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint32_t nb,
 
 void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
-    for (; reg < 32; reg++) {
-        if (needs_byteswap(env)) {
-            env->gpr[reg] = bswap32(cpu_ldl_data_ra(env, addr, GETPC()));
-        } else {
-            env->gpr[reg] = cpu_ldl_data_ra(env, addr, GETPC());
+    uintptr_t raddr = GETPC();
+    int mmu_idx = cpu_mmu_index(env, false);
+    void *host = probe_contiguous(env, addr, (32 - reg) * 4,
+                                  MMU_DATA_LOAD, mmu_idx, raddr);
+
+    if (likely(host)) {
+        /* Fast path -- the entire operation is in RAM at host.  */
+        for (; reg < 32; reg++) {
+            env->gpr[reg] = (uint32_t)ldl_be_p(host);
+            host += 4;
+        }
+    } else {
+        /* Slow path -- at least some of the operation requires i/o.  */
+        for (; reg < 32; reg++) {
+            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
+            addr = addr_add(env, addr, 4);
         }
-        addr = addr_add(env, addr, 4);
     }
 }
 
 void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
-    for (; reg < 32; reg++) {
-        if (needs_byteswap(env)) {
-            cpu_stl_data_ra(env, addr, bswap32((uint32_t)env->gpr[reg]),
-                                                   GETPC());
-        } else {
-            cpu_stl_data_ra(env, addr, (uint32_t)env->gpr[reg], GETPC());
+    uintptr_t raddr = GETPC();
+    int mmu_idx = cpu_mmu_index(env, false);
+    void *host = probe_contiguous(env, addr, (32 - reg) * 4,
+                                  MMU_DATA_STORE, mmu_idx, raddr);
+
+    if (likely(host)) {
+        /* Fast path -- the entire operation is in RAM at host.  */
+        for (; reg < 32; reg++) {
+            stl_be_p(host, env->gpr[reg]);
+            host += 4;
+        }
+    } else {
+        /* Slow path -- at least some of the operation requires i/o.  */
+        for (; reg < 32; reg++) {
+            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            addr = addr_add(env, addr, 4);
         }
-        addr = addr_add(env, addr, 4);
     }
 }
 
-- 
2.20.1


