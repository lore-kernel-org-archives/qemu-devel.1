Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8EDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACDA20684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzyXE10e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACDA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby3d-0001rS-Ik
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwq-00038Z-Du
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwm-00086v-Dp
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:54 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwl-00085o-0L
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:51 -0500
Received: by mail-pg1-x543.google.com with SMTP id x7so855320pgl.11
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IK4eA+8GzL3ARTInAUnzO/6P31CtExBfABqpoPMVkjQ=;
 b=TzyXE10eIeEtfc3xnTUutUXgUMLdl6filN8zICwyjjGmsrnEB7NcIFHRsw0D03VFda
 g0+VEd9xAjTfLyBOfdd2YW4hANY3ZRy2/JGU2BXvnRTcFtgWh/0EsuWys+ohQ7oWSGIY
 aOaotBT9FnrV7EufLpOzVA9qkTdtMJPAPNTDlahpFfS7hRtUkU2eAIgWvATh82RYlgr4
 kNuVq1cEFidepgVHMpoJSCtj8emNIqBtnBftdr01IhDoLBBFRp1HkkOBr47d2WWMP79w
 GRi+3FZ/guPzvkON9N/XAzaw7kir/FfIV6GuvZGb5GRZo3kJfZ/gPNz2aKi0D5PW/3T5
 P4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IK4eA+8GzL3ARTInAUnzO/6P31CtExBfABqpoPMVkjQ=;
 b=XRmBi7fnsl/CBEF5JxiRl73btpEzhKzWmWnIbw2LGm1tLGZVQy4z8lIyOQ+4akRXys
 FDDm4icgcr6GKn586KCxHHscbdTJ9A1l4bNeEw296q1T800oeVUoquyLNcWfs5sKEHrm
 X4GK5/BxNX1eVmKQbL98VCOv9Y/dsVDoJdXjgiCv9l85dUI+YhgHiKQSZkPMOoKgL7n1
 39EmHaxpLU/ZLDIJTnDBq5Fk3o3qWedpRpTpoF5AfP1JPr9RA/GW+KxnD4vEfyJWiJqY
 /BgF1U7ykqBZZYKtudwPGnhED7FsdZi7IpOwJlAAL323gTKCiR4JhnI6jreMd1wWCT/1
 k8ew==
X-Gm-Message-State: APjAAAVkhr2paIV1qHJTgfX9ofcZU/1NdJiXvKEoF3DkwzHm9wW5Pv6K
 0iHKHK1/7vh6T5+mlQHck5tbeFrQwKo=
X-Google-Smtp-Source: APXvYqwGk9wconeG8Ip5Bn9Zczuemo8ldM4s9lLUjVCrnU7knLZ/lbQjyKVRA6T/XSYnuUUYo8ghzQ==
X-Received: by 2002:a05:6a00:3:: with SMTP id h3mr2255810pfk.78.1575340188542; 
 Mon, 02 Dec 2019 18:29:48 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/40] target/arm: Simplify tlb_force_broadcast alternatives
Date: Mon,  2 Dec 2019 18:29:04 -0800
Message-Id: <20191203022937.1474-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than call to a separate function and re-compute any
parameters for the flush, simply use the correct flush
function directly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 52 +++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b0130d814..6c09cda4ea 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -614,56 +614,54 @@ static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
     /* Invalidate all (TLBIALL) */
-    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
     if (tlb_force_broadcast(env)) {
-        tlbiall_is_write(env, NULL, value);
-        return;
+        tlb_flush_all_cpus_synced(cs);
+    } else {
+        tlb_flush(cs);
     }
-
-    tlb_flush(CPU(cpu));
 }
 
 static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
     /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
-    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
+    value &= TARGET_PAGE_MASK;
     if (tlb_force_broadcast(env)) {
-        tlbimva_is_write(env, NULL, value);
-        return;
+        tlb_flush_page_all_cpus_synced(cs, value);
+    } else {
+        tlb_flush_page(cs, value);
     }
-
-    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
 }
 
 static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
     /* Invalidate by ASID (TLBIASID) */
-    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
     if (tlb_force_broadcast(env)) {
-        tlbiasid_is_write(env, NULL, value);
-        return;
+        tlb_flush_all_cpus_synced(cs);
+    } else {
+        tlb_flush(cs);
     }
-
-    tlb_flush(CPU(cpu));
 }
 
 static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
     /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
-    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
+    value &= TARGET_PAGE_MASK;
     if (tlb_force_broadcast(env)) {
-        tlbimvaa_is_write(env, NULL, value);
-        return;
+        tlb_flush_page_all_cpus_synced(cs, value);
+    } else {
+        tlb_flush_page(cs, value);
     }
-
-    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
 }
 
 static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3915,11 +3913,10 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int mask = vae1_tlbmask(env);
 
     if (tlb_force_broadcast(env)) {
-        tlbi_aa64_vmalle1is_write(env, NULL, value);
-        return;
+        tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
+    } else {
+        tlb_flush_by_mmuidx(cs, mask);
     }
-
-    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static int vmalle1_tlbmask(CPUARMState *env)
@@ -4041,11 +4038,10 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     if (tlb_force_broadcast(env)) {
-        tlbi_aa64_vae1is_write(env, NULL, value);
-        return;
+        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
+    } else {
+        tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
     }
-
-    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.17.1


