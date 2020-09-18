Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B66DC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC61E21D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6yp7BoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC61E21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLIb-0000k8-PT
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGj-0007MR-ND
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:01 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGi-00072k-0b
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:01 -0400
Received: by mail-pl1-x644.google.com with SMTP id k13so3442041plk.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rRP60tIXgXyDjfRHhOpTpwQ4z3K7JPkhoQFnyY4gDHg=;
 b=X6yp7BoK7Iom3GOnwch1Rsj7fljWGvc7tch+klKdqPu+sghEKLxq9lpGz5UZ/QGgYs
 GTfJM2ep0u1ug5zvIOckbot0H+KaYy3slynYwkFLSXSqwmcm4zNVRUc2fIjGtWQYPfbv
 ublJxte5uRQTPQXyKaCfrvemQaqigbjjRWGhgtR0B7nhZOKJ+IT5pBnFGMS3/h5I7Ydw
 OysE6L3FcFZEk8/HONnq6dslgGGEuC0/WEhWrzvsO07aMhQ4JWEfZ5GSGIsXpEMtr6zh
 JotPkHhbrBm66stBwchsaJg+4xk0NwVAjkF3jkrKVIgn7iBr1Ke0aSEnOdtncGz0vyfH
 spVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rRP60tIXgXyDjfRHhOpTpwQ4z3K7JPkhoQFnyY4gDHg=;
 b=N3ISMWd8b8RbFtvKy+5qJpHnk4E+e86mRf6Cge7FD0wdBDUHXoVsVWsatew/WVZBJW
 qun5nFdMofTNrR0ZzIXDFKk6iBJI7do0HpOzsLHNL2WTy28razLiW9y9GFFXerKlT0Bw
 BQnZb1z18lD9RuCrCgGVNIA1fINTJxtEf0A4LRpayCQ8FGDQxeK8o3kAyWo3rZjc1fgb
 MGikALuKpJY1R1xB2Uq5bRG8bWx1fKb6B+JIsSEHBj2QZjEg2DYX1koYvWz3ZlXCgyEy
 FvQK/QZU0IQk9CHBYH8wS4fnvLNzCGCFgG/tth6WVWEpIieEKI1ZBxrvCCtnlRvBc+Qz
 SuQQ==
X-Gm-Message-State: AOAM533KRBYD6ADZE3QEdE7zbv1HTbHdLQuRu8siyPNBUaS8Ol6X1EVr
 VXbEHK85xA4SQ4uJdxl7ZoOGYFh8Nrd9Jw==
X-Google-Smtp-Source: ABdhPJxR1oYdOEKRTmfHQkUrJTsYp4jSTQ58ckutG0XGsOoz/Nld3I3RLOoxvJIz/axJRNkMk7sGOA==
X-Received: by 2002:a17:90b:f83:: with SMTP id
 ft3mr14069235pjb.234.1600454276540; 
 Fri, 18 Sep 2020 11:37:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:37:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/81] target/arm: Fix sve_zip_p vs odd vector lengths
Date: Fri, 18 Sep 2020 11:36:32 -0700
Message-Id: <20200918183751.2787647-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, peter.maydell@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wrote too much with low-half zip (zip1) with vl % 512 != 0.

Adjust all of the x + (y << s) to x | (y << s) as a style fix.

We only ever have exact overlap between D, M, and N.  Therefore
we only need a single temporary, and we do not need to check for
partial overlap.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fcb46f150f..b8651ae173 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1870,6 +1870,7 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
     intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
     int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
     intptr_t high = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1);
+    int esize = 1 << esz;
     uint64_t *d = vd;
     intptr_t i;
 
@@ -1882,33 +1883,35 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
         mm = extract64(mm, high * half, half);
         nn = expand_bits(nn, esz);
         mm = expand_bits(mm, esz);
-        d[0] = nn + (mm << (1 << esz));
+        d[0] = nn | (mm << esize);
     } else {
-        ARMPredicateReg tmp_n, tmp_m;
+        ARMPredicateReg tmp;
 
         /* We produce output faster than we consume input.
            Therefore we must be mindful of possible overlap.  */
-        if ((vn - vd) < (uintptr_t)oprsz) {
-            vn = memcpy(&tmp_n, vn, oprsz);
-        }
-        if ((vm - vd) < (uintptr_t)oprsz) {
-            vm = memcpy(&tmp_m, vm, oprsz);
+        if (vd == vn) {
+            vn = memcpy(&tmp, vn, oprsz);
+            if (vd == vm) {
+                vm = vn;
+            }
+        } else if (vd == vm) {
+            vm = memcpy(&tmp, vm, oprsz);
         }
         if (high) {
             high = oprsz >> 1;
         }
 
-        if ((high & 3) == 0) {
+        if ((oprsz & 7) == 0) {
             uint32_t *n = vn, *m = vm;
             high >>= 2;
 
-            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
+            for (i = 0; i < oprsz / 8; i++) {
                 uint64_t nn = n[H4(high + i)];
                 uint64_t mm = m[H4(high + i)];
 
                 nn = expand_bits(nn, esz);
                 mm = expand_bits(mm, esz);
-                d[i] = nn + (mm << (1 << esz));
+                d[i] = nn | (mm << esize);
             }
         } else {
             uint8_t *n = vn, *m = vm;
@@ -1920,7 +1923,7 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
 
                 nn = expand_bits(nn, esz);
                 mm = expand_bits(mm, esz);
-                d16[H2(i)] = nn + (mm << (1 << esz));
+                d16[H2(i)] = nn | (mm << esize);
             }
         }
     }
-- 
2.25.1


