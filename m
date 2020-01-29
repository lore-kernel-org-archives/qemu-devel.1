Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE167C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B29206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uj7zkoaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B29206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxNM-000535-JH
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC6-0003dX-J0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC5-000738-Iv
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:26 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxC5-0006yg-D9
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:25 -0500
Received: by mail-pg1-x543.google.com with SMTP id x7so630461pgl.11
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y5CyHBiFeWiBcrsW6gnwUoEpOBc9uju5IighOjtl59Y=;
 b=uj7zkoaLPsQBIcGZnKUde0oDp6Ama4f686hZaS559YDyM/iIL73X0SDxCaoM9+/3IE
 VIh10gBK18LJiex9wfvkrSduJmP4w4RXf342nIzcJGK6mtx1VfvPRPpkkQKEIup8QAnR
 OUM8jLFkBeCmyTzzWkLbbaCbhG9vhoUPttmKgf6qjtQ5Tw5dIm1PhjxnkEgObs8tBDuS
 GFNAjxXaDbw3hZfr0D3Litr015p47usa4BLhQF5BKR+5dKZRJpcgdEZM14zfi5k/WeZR
 YpuRJHboM0J9XvSHU28QtBZMtkJmgmJdwHKVtqojbFsU7o8cvqdts8An9yezgxxqZTFu
 aamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y5CyHBiFeWiBcrsW6gnwUoEpOBc9uju5IighOjtl59Y=;
 b=cFP4vBap51apg1CL3VBqwuyv+q/YsXC4VUV9JUr17xaV27JHrWfniMJOv8WRdZ/Coe
 4b0SZB36djONxmCa89afU/bOi7Lwon1PL7OMtrDbPgnN65h66B3cYvNNcpALCg6jXGVJ
 t6fyAtOQgY9dVl6tvDDCrEeTXQGEtmT2XzWylIJfTdd+lutleeoVf6Zt7O5wyd62LC4a
 XMJN1R1D/I336AfooPfI9hZ2s5DXqkH9MJMApTEjPHqzDmX3UffmvmYgQG6O7jfQ7CVH
 ozmP62avhLQCvjd+WhvlPTmfRvH9GcJM3Ta/bhHSf93/moVsVmqzREATxHFKhwIi43R+
 sXiA==
X-Gm-Message-State: APjAAAXMKbtJ63oJg/3VV9nrc4YN5AJ/eh0tSs1twUwF047oNryxZo8K
 96ppklBN8V8REMDJKIMEcM5wXkvN3KE=
X-Google-Smtp-Source: APXvYqww7AzCODFyqALFdF1nEL2je9mYd9YMgFiEm9qsu6ZK7x5HlQpHyI2fmtehNzr40HSfC2T3IA==
X-Received: by 2002:a63:1c13:: with SMTP id c19mr1704981pgc.450.1580342183984; 
 Wed, 29 Jan 2020 15:56:23 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/41] target/arm: Split out vae1_tlbmask
Date: Wed, 29 Jan 2020 15:55:39 -0800
Message-Id: <20200129235614.29829-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change, but unify code sequences.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 830f83ae55..20eb8b53c1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3940,42 +3940,36 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
  * Page D4-1736 (DDI0487A.b)
  */
 
+static int vae1_tlbmask(CPUARMState *env)
+{
+    if (arm_is_secure_below_el3(env)) {
+        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+    } else {
+        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+    }
+}
+
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
     CPUState *cs = env_cpu(env);
-    bool sec = arm_is_secure_below_el3(env);
+    int mask = vae1_tlbmask(env);
 
-    if (sec) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S1SE1 |
-                                            ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S12NSE1 |
-                                            ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
 
     if (tlb_force_broadcast(env)) {
         tlbi_aa64_vmalle1is_write(env, NULL, value);
         return;
     }
 
-    if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S1SE1 |
-                            ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


