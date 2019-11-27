Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9684C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A62215F1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIgkBB01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A62215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia5U0-000703-O6
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 17:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ia5SF-0005dV-Uw
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ia5SD-0002MQ-Tb
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:35 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ia5SB-0002KJ-UN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:06:33 -0500
Received: by mail-lj1-x241.google.com with SMTP id k8so15618931ljh.5
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xnSkwpgBsxk4jxzjerZiTGLcBtPdpU9VVVnBMPqJBW8=;
 b=sIgkBB01vtWNOOD10+zcIbaRjScBNIdBDjObLz7Fi19jARCO+J2hrf1+Z/CbaWDH93
 InhhoWOOrgTLC0OA4Ec1q1KEaOOYMce5Ih5b+jJopWuXBGglBAQJdfDxRSjzYhIHr78r
 CwrEMF0tlLHAhO91FE6oa+7MHcvyNODwosHwJqCu6xK/LkiHjqhQwhqsZiuqaQUoGrsE
 Xwi5Fdfq91XhODGJJgN/Fukqd0c+JCRpF9Q2bB6Y1reKcrpU7AZRENI0t9YgcTHVGZZx
 VZ6RbPS25GfyvrfgUMcJ0Bi1gipNjZwVW8m/+B94veTguJCVwJRfZXP8r8ReybdMld8D
 /Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xnSkwpgBsxk4jxzjerZiTGLcBtPdpU9VVVnBMPqJBW8=;
 b=O1IJWDL/yYIgyx0YxJfuoc9rfhRsEus1MVv1VXnMsG2/FrzCHKBGZdD4sKYHxq7f0k
 d/YAI6t90AH0xgOJyHfwYXBsvR3KnCzTcGSOiBNK+Dc/1/ZcCz8zsUylaz7E2UAneMqc
 6ejR5wy2drbfO8dBhJV4ZvYmNLvCRRiKARJeRrPcGDoxc0m2JRX7iNVRyU31Api06pbN
 sc/IwM9dgF/8kNu3tXpcJ8Ei4ShfeyXO181pw1wLNOpuzphV2D9imh+5B+m2A2avF9EQ
 ydVnNLfNkR3O9R1xMwtSbomqhEvsZGqf3q4Q0xH9kN7qYwvsMw6j1XvKm8JFfCHztNav
 5TwQ==
X-Gm-Message-State: APjAAAXANRZiNOEil9Vb8Zidc8G4UfuyAav2v2uWtMAVeDfsr0ti/LED
 l4zcZQg7MbkmY6c4DAZgyNmatdbaRck=
X-Google-Smtp-Source: APXvYqxoCzVX7jH5dENPn+kPXdm6Pp+bD0haV1CZEsvxpW+0Ub+R2NZyss+0P/hMvDEEeZpw8BLoQA==
X-Received: by 2002:a2e:9607:: with SMTP id v7mr4317897ljh.72.1574892389690;
 Wed, 27 Nov 2019 14:06:29 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id r7sm7655611ljc.74.2019.11.27.14.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 14:06:29 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] exec: drop tb_invalidate_phys_addr
Date: Wed, 27 Nov 2019 14:06:02 -0800
Message-Id: <20191127220602.10827-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127220602.10827-1-jcmvbkbc@gmail.com>
References: <20191127220602.10827-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only remaining user of tb_invalidate_phys_addr is target/xtensa
instruction breakpoint code and it is better to use tb_flush there.

Drop tb_invalidate_phys_addr implementations and declarations.
Use tb_flush in xtensa IBREAK helpers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 exec.c                     | 29 ++---------------------------
 include/exec/exec-all.h    |  3 ---
 target/xtensa/dbg_helper.c | 19 +++----------------
 3 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/exec.c b/exec.c
index 1709b760edc1..4d20fc005520 100644
--- a/exec.c
+++ b/exec.c
@@ -983,38 +983,13 @@ const char *parse_cpu_option(const char *cpu_option)
 }
 
 #if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(target_ulong addr)
+static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
     mmap_lock();
-    tb_invalidate_phys_page_range(addr, addr + 1);
+    tb_invalidate_phys_page_range(pc, pc + 1);
     mmap_unlock();
 }
-
-static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
-{
-    tb_invalidate_phys_addr(pc);
-}
 #else
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
-{
-    ram_addr_t ram_addr;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-
-    if (!tcg_enabled()) {
-        return;
-    }
-
-    RCU_READ_LOCK_GUARD();
-    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
-    if (!(memory_region_is_ram(mr)
-          || memory_region_is_romd(mr))) {
-        return;
-    }
-    ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
-}
-
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
     /*
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d85e610e85b9..585fe7ff430c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -449,10 +449,7 @@ static inline uint32_t curr_cflags(void)
 
 /* TranslationBlock invalidate API */
 #if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(target_ulong addr);
 void tb_invalidate_phys_range(target_ulong start, target_ulong end);
-#else
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
 #endif
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index be1f81107b43..2481dc326fba 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -33,19 +33,6 @@
 #include "exec/exec-all.h"
 #include "exec/address-spaces.h"
 
-static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
-{
-    uint32_t paddr;
-    uint32_t page_size;
-    unsigned access;
-    int ret = xtensa_get_physical_addr(env, false, vaddr, 2, 0,
-                                       &paddr, &page_size, &access);
-    if (ret == 0) {
-        tb_invalidate_phys_addr(&address_space_memory, paddr,
-                                MEMTXATTRS_UNSPECIFIED);
-    }
-}
-
 void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
 {
     uint32_t change = v ^ env->sregs[IBREAKENABLE];
@@ -53,7 +40,8 @@ void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
 
     for (i = 0; i < env->config->nibreak; ++i) {
         if (change & (1 << i)) {
-            tb_invalidate_virtual_addr(env, env->sregs[IBREAKA + i]);
+            tb_flush(env_cpu(env));
+            break;
         }
     }
     env->sregs[IBREAKENABLE] = v & ((1 << env->config->nibreak) - 1);
@@ -62,8 +50,7 @@ void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
 void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 {
     if (env->sregs[IBREAKENABLE] & (1 << i) && env->sregs[IBREAKA + i] != v) {
-        tb_invalidate_virtual_addr(env, env->sregs[IBREAKA + i]);
-        tb_invalidate_virtual_addr(env, v);
+        tb_flush(env_cpu(env));
     }
     env->sregs[IBREAKA + i] = v;
 }
-- 
2.20.1


