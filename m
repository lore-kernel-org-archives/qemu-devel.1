Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED19C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48DF2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyUWJHEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48DF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjYO-0004TV-3X
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjDD-0003X8-GD
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD7-00066w-O5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id t2so139516wma.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=utIVepL1HuQRNNAxKKmGmf0ciz/CjvNHj8UaXUfKars=;
 b=NyUWJHEa4W5epyfV6iOgNg8+OYGCKNyqtxTfMrEkRFcjYBWEGMNwNo6W3CLCfrjINO
 9f+R8YbQXMwszKjXisTSd4wmwolUgI6sSrze7M5aeNpJ3Hg5ETLj/fQaalZzDBbkJyEg
 iHKOxqcG3NUyXSWNFJnCJLIpMNxfc8VUKlOkr6DIm5wbIcz0HLhb/J97iNSDrMk/pdfY
 gqG0XGjYmzIfV5QzVi+ZRhSvQ900AuiWkXn3C9GimQmGsJoXfPUnYBdH8Fd1VqaDEANs
 Y7vUJMXH8SFHV9/4noYF1dGGbkOKM+uB6aRcZHnDLwKSaN45WnCg7K2uTeQAPTZcUhwd
 V1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=utIVepL1HuQRNNAxKKmGmf0ciz/CjvNHj8UaXUfKars=;
 b=K+RTN8mqsruY1QIeXBow8j9lbAlIKPDu4vQy9BRSgM/q0OzZ5l2Rg3xubB74vukV0U
 YVXV2smEZgKB9PPvnfjxJHoGOPUJZEC0sU5tIbn5vpT1ba3XFGgHkl+x6iKpTC//JNQh
 QB5/2558YNW8CyT0VVLF//TEj3t6WNoYJJC6P3SfTgrLXgLFoTrWB8fPGiSp6MIJHyHZ
 q8Kf9+nAp6WuhpSFLY2m1PJy3lh9mTy+gnfsuaHbZzMe+RGPlNgEkcpAvi16oVsD4cDJ
 4l8wBhuiR/RZUnZr7QK1wUVq2y1scxYbxm1bRbhTQB3FUA4xRkzTj8p3JIp5vdjk4/U1
 7hTA==
X-Gm-Message-State: AOAM531U325Yt74QZHNVUDwLDhBk/MtMqiUEAQB3N9bk8/VFXEAp9IB+
 VyBIvqFiGWxpZgkSjZkNfip1FA==
X-Google-Smtp-Source: ABdhPJxZ+gvxnV+cUki7bBnRv40hsu8n/A085WT6ZkczxXUuXogF+MZQTxnWnQo+Y4GI3+cXAsUE2A==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr26911wmh.31.1598639687005;
 Fri, 28 Aug 2020 11:34:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 42/45] target/arm/vec_helper: Handle oprsz less than 16
 bytes in indexed operations
Date: Fri, 28 Aug 2020 19:33:51 +0100
Message-Id: <20200828183354.27913-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the gvec helper functions for indexed operations, for AArch32
Neon the oprsz (total size of the vector) can be less than 16 bytes
if the operation is on a D reg. Since the inner loop in these
helpers always goes from 0 to segment, we must clamp it based
on oprsz to avoid processing a full 16 byte segment when asked to
handle an 8 byte wide vector.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vec_helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 20f153b47a1..b27b90e1dd8 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1040,7 +1040,8 @@ DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
 #define DO_MUL_IDX(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                                          \
-    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t i, j, oprsz = simd_oprsz(desc);                               \
+    intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
     intptr_t idx = simd_data(desc);                                        \
     TYPE *d = vd, *n = vn, *m = vm;                                        \
     for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
@@ -1061,7 +1062,8 @@ DO_MUL_IDX(gvec_mul_idx_d, uint64_t, )
 #define DO_MLA_IDX(NAME, TYPE, OP, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)   \
 {                                                                          \
-    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t i, j, oprsz = simd_oprsz(desc);                               \
+    intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
     intptr_t idx = simd_data(desc);                                        \
     TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
     for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
@@ -1086,7 +1088,8 @@ DO_MLA_IDX(gvec_mls_idx_d, uint64_t, -,   )
 #define DO_FMUL_IDX(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
-    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t i, j, oprsz = simd_oprsz(desc);                               \
+    intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
     intptr_t idx = simd_data(desc);                                        \
     TYPE *d = vd, *n = vn, *m = vm;                                        \
     for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
@@ -1108,7 +1111,8 @@ DO_FMUL_IDX(gvec_fmul_idx_d, float64, )
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                   void *stat, uint32_t desc)                               \
 {                                                                          \
-    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t i, j, oprsz = simd_oprsz(desc);                               \
+    intptr_t segment = MIN(16, oprsz) / sizeof(TYPE);                      \
     TYPE op1_neg = extract32(desc, SIMD_DATA_SHIFT, 1);                    \
     intptr_t idx = desc >> (SIMD_DATA_SHIFT + 1);                          \
     TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
-- 
2.20.1


