Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C767C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CFE206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhGuXJye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CFE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4AG-0000q3-4Q
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41M-0001bv-4U
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41K-0001r2-9l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:47 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41J-0001oB-Qm
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:45 -0400
Received: by mail-pl1-x642.google.com with SMTP id z6so234432plk.10
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UBTvpXnQhX/NB3BncFrtFDo86VAuYzf/XHrJqnCZIJI=;
 b=FhGuXJye0m/BZIY4rGguPzeFQd9KrcWszqS5AkTA5QHbiddacWhI472vPqiFhMYTRt
 jgsjXSZODUDEheEs1TnJcEQbMM/bs+ZPaJPjYMxO3ry32p5XzgoslFX3MPU/aVuDx/if
 IQSab1PEV/PKocitl+GFh1JxWaeJC9KHQ44bBooDKGPvK6mG+qZH3UM6zGTek1mcV74x
 r/dt2RvNAB1m2fce913ZIG7Uzz7IWa6vV+C+3PTSB7cz7nkK8MDZYUPBZXflZtWNwnmo
 McpJREqx2XlK3CBuOvVpYvqKuJi+R/YK+apmSBaGkLj5ITCY92HgJzHE5QlO3ct6HT/I
 vgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UBTvpXnQhX/NB3BncFrtFDo86VAuYzf/XHrJqnCZIJI=;
 b=Legbtxq0itrceqWaO64uu+PVgQMaAVDzZfB2wBU94YbBtYHiDE4OyeaQJpEDMETUAZ
 fTb1+x2lz7U2T4u4tAsaP0nrmjQ9G4j5vpDmkex1PC5NYsLjJicKF8DuxiYDAmA6IHvD
 Aucjy1LjlWOXYb6XR8NlV//F0xzWLCAGSlzuLP8Re4z2qPrVfOVCBmaAt8VJwYqmcioF
 3S+CedT5r6S2gL/giAFmPFl0M4gMzzZspb98BwcmnxwM0YLmYRQRB2IQRmnyA0xMGGEN
 pyfFgrGuXbQ6vHUCUuurtw7FSP6h9zALO3nQaO4lnpFEiyGqoK/g9rhOA6DBbWzmCBi3
 wajw==
X-Gm-Message-State: AGi0PuZ3sMnEMs7VKuPtOyYXYrjbE+QFPTjF0MZa43Yjg95lg0tqt4M5
 dtFVRY4ROMPoM+xJjG6L85FnX58dGmc=
X-Google-Smtp-Source: APiQypKxfVvj/Yi80V9QoskVJ1E9ywXqMi3FL1h2MijZRjK2oU+BMIUswsJJm7JfJtDAJ2p36ECn5Q==
X-Received: by 2002:a17:902:ed13:: with SMTP id
 b19mr24802958pld.254.1587518263528; 
 Tue, 21 Apr 2020 18:17:43 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/36] tcg: Use tcg_constant_{i32,i64} with tcg plugins
Date: Tue, 21 Apr 2020 18:17:01 -0700
Message-Id: <20200422011722.13287-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 49 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 51580d51a0..e5dc9d0ca9 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -284,8 +284,8 @@ static TCGOp *copy_extu_i32_i64(TCGOp **begin_op, TCGOp *op)
     if (TCG_TARGET_REG_BITS == 32) {
         /* mov_i32 */
         op = copy_op(begin_op, op, INDEX_op_mov_i32);
-        /* movi_i32 */
-        op = copy_op(begin_op, op, INDEX_op_movi_i32);
+        /* mov_i32 w/ $0 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
     } else {
         /* extu_i32_i64 */
         op = copy_op(begin_op, op, INDEX_op_extu_i32_i64);
@@ -306,39 +306,34 @@ static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op)
     return op;
 }
 
-static TCGOp *copy_movi_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* 2x movi_i32 */
-        op = copy_op(begin_op, op, INDEX_op_movi_i32);
-        op->args[1] = v;
-
-        op = copy_op(begin_op, op, INDEX_op_movi_i32);
-        op->args[1] = v >> 32;
-    } else {
-        /* movi_i64 */
-        op = copy_op(begin_op, op, INDEX_op_movi_i64);
-        op->args[1] = v;
-    }
-    return op;
-}
-
 static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
 {
     if (UINTPTR_MAX == UINT32_MAX) {
-        /* movi_i32 */
-        op = copy_op(begin_op, op, INDEX_op_movi_i32);
-        op->args[1] = (uintptr_t)ptr;
+        /* mov_i32 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(tcg_constant_i32((uintptr_t)ptr));
     } else {
-        /* movi_i64 */
-        op = copy_movi_i64(begin_op, op, (uint64_t)(uintptr_t)ptr);
+        /* mov_i64 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i64);
+        op->args[1] = tcgv_i64_arg(tcg_constant_i64((uintptr_t)ptr));
     }
     return op;
 }
 
 static TCGOp *copy_const_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
 {
-    return copy_movi_i64(begin_op, op, v);
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* 2x mov_i32 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(tcg_constant_i32(v));
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(tcg_constant_i32(v >> 32));
+    } else {
+        /* mov_i64 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i64);
+        op->args[1] = tcgv_i64_arg(tcg_constant_i64(v));
+    }
+    return op;
 }
 
 static TCGOp *copy_extu_tl_i64(TCGOp **begin_op, TCGOp *op)
@@ -486,8 +481,8 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
 
     tcg_debug_assert(type == PLUGIN_GEN_CB_MEM);
 
-    /* const_i32 == movi_i32 ("info", so it remains as is) */
-    op = copy_op(&begin_op, op, INDEX_op_movi_i32);
+    /* const_i32 == mov_i32 ("info", so it remains as is) */
+    op = copy_op(&begin_op, op, INDEX_op_mov_i32);
 
     /* const_ptr */
     op = copy_const_ptr(&begin_op, op, cb->userp);
-- 
2.20.1


