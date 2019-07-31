Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB562171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWm4D6tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB562171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvVg-00013L-LT
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMp-0004iy-8b
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMo-0003VK-7R
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:35 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMo-0003Uv-2E
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:34 -0400
Received: by mail-pf1-x443.google.com with SMTP id p184so32509288pfp.7
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RHV3vStI8hqe3CeMRucY7WZ1UFpWZPYBbhdsWvPNW30=;
 b=QWm4D6tIVVlCHNDWidhXBv3U+A7GuWyovfDIlJWkpWxjEGZJBP5am0SjFaoXk2ATrD
 e95MlhjOojiBHxxlx6AO7etV/0yRuB1DQesRzt0eDwuKlueXLG0n45AogMfs6im7YH9G
 pyZBdxPoArEG5YT0c0hH5q8swpTWofLTUdk01WHc+2SCW5/iAawesl/QOOhY7nOz/6b1
 do4D1rkW5Y+EGNQBLANbDPWVBfibMol1BwM3ku5MZLiAagRTIR9Y1PxYL++Lsm4jkA//
 0xkGFAPdTq8gnajI61cWS5WOdmIOu7PDBwfkPx2srm1Fvn5alrvnV4dPmVlJ4c1Kndrc
 exjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RHV3vStI8hqe3CeMRucY7WZ1UFpWZPYBbhdsWvPNW30=;
 b=RM7ZK9rnpuzID7qv/3Y6XfWg1u1JCWme3YPItJpdoFAfZSUILcwue5OXeJS7DKJ21p
 fuFsJIN3yYYyQLoVT5UEoFrZ25Ml3iazpRUBcIi8pin+o+TL6jnOqTvJv6UaHWRa+tZy
 BGTORaUrJVpauhNc3OUr+gnPj8DcrLnRcnFszuK9AJcZtfCrnAoDU5KmNLkbZ7J3Wg2C
 YqGvjnGd1t3hERZUw/Nrhp6xpCYl1IfwaCVmabtqUW95m5He/Q7vLkJjsHfKNMsutN4b
 b1I+HlPzjnKToRiyxq/Mnw6YmGt922bqtkzWz46ojF+TkewDspnhbXUvKSsQ2momtf6w
 DZNA==
X-Gm-Message-State: APjAAAU/mccsIIoOl8uv0DOVbEP1WpjWjUYbCE6BlLy3tl3SsCqpPuzZ
 taJPakZLvAuOt8xJGlDF+emoH9VFd1g=
X-Google-Smtp-Source: APXvYqw1Pnr6Xw4hruHzabYkUdZFOSUsMarpt/euRbJpfwC1kyTDI5CmNtdCTxXN/pw7fQm3/2cNPw==
X-Received: by 2002:a63:9c5:: with SMTP id 188mr80039525pgj.2.1564605512775;
 Wed, 31 Jul 2019 13:38:32 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:55 -0700
Message-Id: <20190731203813.30765-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 14/32] target/arm: Simplify
 tlb_force_broadcast alternatives
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
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
index 7ecaacb276..185f5e4aea 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -626,56 +626,54 @@ static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -3923,11 +3921,10 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -4049,11 +4046,10 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
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


