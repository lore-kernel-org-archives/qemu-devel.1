Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C9C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9CE20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViHYVa2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9CE20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTm4-0005Rs-7d
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj8-0005Lh-4T
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj6-0001zS-Vj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:42 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTj6-0001xu-Pm
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:40 -0400
Received: by mail-pj1-x1042.google.com with SMTP id np16so2964216pjb.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wN0TfHqfZivaapeBhs6fRX0f635NiC55vaX3XaH653M=;
 b=ViHYVa2IeF2adL4f3D4ETRqrlHVsziMQ7lV68vafRzNA2+lyX+m/bhOYsTKGAeVAHA
 bsxm7M/poAJu1lqEqXuChqSrsqeLqpX7PMcgcMNjg0RdiK9uJIqWT7ZyE13bb2B900v6
 TAurQKqQicROPyOkVxxQAn9wP6mnR1qV8zXhwhWBti1kdDfBLb3r3rRJj7xZLcVXHfed
 9KLyAWFXcbwMsOKYXWMPfh8XdbK9t+WOFZwcIK8mkBsEydJoXn3eQHg9uHVbwzxAkelr
 a+DeCQF4BDR4G0SgFjTfW19BdUeNJwzdlM80R2JDmaIfK1UbETWpuaNVcjJEtv2RdGYa
 i04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wN0TfHqfZivaapeBhs6fRX0f635NiC55vaX3XaH653M=;
 b=IYIs9Ytrq8cJMIxVFGsgnqaMJG9XifsosIFDYNXxkRvfsJqhTAAw3Q4n1VGmeSWoYB
 p/ZVgS5du+dnnwWhZdb7ysxRCStBL9QA9yPWU0iTvRG97XpRmxibiOnoIZOCXc1JDBnD
 MD2IcMs0CPgpgr/iJ5Bq5BVv03sTA0jNKQnc4y4F7lGarBh385W3shAfX2ZQ0cYNJlVM
 OmN6J5eWhzKPK8JcUmp29/Dvvcqhi0GSTd5EeLB6nXWiuYGtmeTAnJMNGZtgKfR0e/VF
 n+U+AjjCiD3gA7npkollk1gFheSjnoopcZ9GZOKsHXQnElF57rjec9WuqUoN7j4dq1rK
 VKZA==
X-Gm-Message-State: ANhLgQ3vSsHuDz3LNLg33xkjglKyH+153sv3ikQQ8kXgw5jPoq3vGVLJ
 bufZCaLKaQdJdpBcvkyHcFzynKErTXU=
X-Google-Smtp-Source: ADFU+vvBl8xXhve2nk+KtSWPbdc4kzq+cZcbkDzr/ZJudrGaWu/pRVyl7s3X1RskCe7fJ2xQHu+xXw==
X-Received: by 2002:a17:90a:9306:: with SMTP id p6mr5806526pjo.0.1584042159488; 
 Thu, 12 Mar 2020 12:42:39 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/42] target/arm: Add helper_probe_access
Date: Thu, 12 Mar 2020 12:41:51 -0700
Message-Id: <20200312194219.24406-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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

Raise an exception if the given virtual memory is not accessible.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  2 ++
 target/arm/op_helper.c     | 16 ++++++++++++++++
 target/arm/translate-a64.c | 13 +++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 72eb9e6a1a..8a616ed6d8 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -95,6 +95,8 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index eb0de080f1..b1065216b2 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -935,3 +935,19 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
+
+void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+                          uint32_t access_type, uint32_t mmu_idx,
+                          uint32_t size)
+{
+    uint32_t in_page = -((uint32_t)ptr | TARGET_PAGE_SIZE);
+    uintptr_t ra = GETPC();
+
+    if (likely(size <= in_page)) {
+        probe_access(env, ptr, size, access_type, mmu_idx, ra);
+    } else {
+        probe_access(env, ptr, in_page, access_type, mmu_idx, ra);
+        probe_access(env, ptr + in_page, size - in_page,
+                     access_type, mmu_idx, ra);
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 49c94bc565..45a95d8ea0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -249,6 +249,19 @@ static void gen_address_with_allocation_tag0(TCGv_i64 dst, TCGv_i64 src)
     tcg_gen_andi_i64(dst, src, ~MAKE_64BIT_MASK(56, 4));
 }
 
+static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
+                             MMUAccessType acc, int log2_size)
+{
+    TCGv_i32 t_acc = tcg_const_i32(acc);
+    TCGv_i32 t_idx = tcg_const_i32(get_mem_index(s));
+    TCGv_i32 t_size = tcg_const_i32(1 << log2_size);
+
+    gen_helper_probe_access(cpu_env, ptr, t_acc, t_idx, t_size);
+    tcg_temp_free_i32(t_acc);
+    tcg_temp_free_i32(t_idx);
+    tcg_temp_free_i32(t_size);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
-- 
2.20.1


