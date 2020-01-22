Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246FBC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E505A2087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGgKYogy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E505A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6A2-0002uT-EF
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65o-0005iV-Ef
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65n-0002mc-9f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:08 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65n-0002mH-41
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:50:07 -0500
Received: by mail-pl1-x644.google.com with SMTP id t14so2256989plr.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LhXy4iUjavswiSO2/mQ5JX54ZZQdZ3jpXP3LWsXowkI=;
 b=oGgKYogyffPAeHHV0zp7Ai46aZ39EbHTIvqEI9n9f93jO9qr/UdzL+KpSKpHi3DSaH
 0FrZwZL/3nhEdO4rmbTeBVeQfFk95y4SGEjuM1Ib9xoToXW9KcsO/DUHroA5G2gouHuC
 FJSjx/rfC9k0srTpn9HBsyh4QhDo0WkGeG4uDIoA57Q4wEd+iotOyU0wnMqF9/ym/3q6
 rsqDwFAUlEH/4z4nY7TxiYLXd0lx1VhF54/y/JGj0Fspw7oxn21lpvLp94l+b81UWRQF
 sG2EPlyJsu7XdzAeacNllsLVx0VK534KcHHmaNajDFYw9rE44NIzdl++anSd4AWy7xCM
 y68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LhXy4iUjavswiSO2/mQ5JX54ZZQdZ3jpXP3LWsXowkI=;
 b=F2JiMnpt+hYMYl+KRRWYOo7cA4D6OA03i+KmC+XwPL0A1Vj1syRy92O3TN0CuYHBpL
 BnDZ6WSLD7sm7Dt62PAJtFdtq9rpwKeeqBDyFEj5tafM1sjI1ETMGbvrjCVl553BNcHy
 FjZ782+uh3+F/sOy5xtVX/QQwU18g5WWI48Y6e5+tKh6LSdhy3H/A9MVWhm4NkkPkdDO
 qAwk7NcaqaqL8KzxZU41YptvvSlDFeuwTZ1BIgZkLwHtHCHAfOEKS3OUOqPXZb4bx777
 5b0C3HmLifawqfIbSVcb3IYtVwf1qMq9W2A7JDAo7uugMIzp8591Nu1iN63h6fOwryTz
 gpkQ==
X-Gm-Message-State: APjAAAXjoe7KL8hRjzFtEKietawe7cw/i1VH9nE66sv5m6yvOlnCmq3/
 VbYgug3iMbqUWkNgB4SEXbS4VXKiBAA=
X-Google-Smtp-Source: APXvYqwd401eJQFUGEd1cNiEW6dlReOTrN+Vx1o9QNYTv93tONL+q5FcTP0itvIqZxaaXpyarpLuXQ==
X-Received: by 2002:a17:902:be06:: with SMTP id
 r6mr7887537pls.99.1579661405845; 
 Tue, 21 Jan 2020 18:50:05 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:50:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] cputlb: Pass CPUTLBDescFast to tlb_n_entries and
 sizeof_tlb
Date: Tue, 21 Jan 2020 16:49:39 -1000
Message-Id: <20200122024946.28484-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not need the entire CPUArchState to compute these values.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 500c56d74d..cc6f4c994b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -80,14 +80,14 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
-static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
+static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
 {
-    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
+    return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
 }
 
-static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
+static inline size_t sizeof_tlb(CPUTLBDescFast *fast)
 {
-    return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
+    return fast->mask + (1 << CPU_TLB_ENTRY_BITS);
 }
 
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
@@ -156,7 +156,7 @@ static void tlb_dyn_init(CPUArchState *env)
 static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
 {
     CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
-    size_t old_size = tlb_n_entries(env, mmu_idx);
+    size_t old_size = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
     size_t rate;
     size_t new_size = old_size;
     int64_t now = get_clock_realtime();
@@ -236,7 +236,8 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
     env_tlb(env)->d[mmu_idx].large_page_addr = -1;
     env_tlb(env)->d[mmu_idx].large_page_mask = -1;
     env_tlb(env)->d[mmu_idx].vindex = 0;
-    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
+    memset(env_tlb(env)->f[mmu_idx].table, -1,
+           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
     memset(env_tlb(env)->d[mmu_idx].vtable, -1,
            sizeof(env_tlb(env)->d[0].vtable));
 }
@@ -719,7 +720,7 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
-        unsigned int n = tlb_n_entries(env, mmu_idx);
+        unsigned int n = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
 
         for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&env_tlb(env)->f[mmu_idx].table[i],
-- 
2.20.1


