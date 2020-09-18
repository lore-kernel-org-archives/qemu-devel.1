Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4C0C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C8F21D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebBXjqUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C8F21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLLb-0004Qt-2m
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGi-0007JB-5d
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:00 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:33125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGf-00072b-Gt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:37:59 -0400
Received: by mail-pj1-x1043.google.com with SMTP id md22so4603364pjb.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fBhW7XDEMls1H/wfvRiEP/0AEEm3Vshw5FyVOPuU9nc=;
 b=ebBXjqUh9BnzS7oUs2hKkTxk0uigH5tQvciOH4Tqrn+KUKkHqRR19oPw3RJALIbE6I
 dvyd+DMBRqK39QoCo2Td0T3bysIt3qRBXOQlK48IXyiUo2jvWIsC7ulC+LXL+pBTIfON
 drY5ccboJaMTmK5/LzALak7ogqFCIGhnUNkt94tX39VDZecYdNWiEJxr8cblSU/yR1te
 nva6Bf2lYFskurgUTGNvTqJa5u9OhjtVubVwptks0cfQo+Dm0FHIipGCVz1MTsvnCtfg
 oqVT0g5keUO0S6SoC4EkCJbn9TpTScTHh3O7ZQ4erGXjrRtRj97HlpAn5qDWkxp3CGso
 d4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fBhW7XDEMls1H/wfvRiEP/0AEEm3Vshw5FyVOPuU9nc=;
 b=hcj0VIn6UhD0c5mwuSn+ZVPiQReFZ+kT4pXved0I7FFFw+BbEzjZV+oiBUATBeELE6
 VIsKxPHjJSxzLueg2kvGYHhzuDqW41gIIr1rCJTmjwvlXdTAalMecxmNdHDz0RuKWmxq
 hDZvHEbPG6FccyMxzynQNiPptbEy3fHDkeP8JYQB0J6LF9vNroktsPRSKpynkroO/m82
 biTPNuIsrSu3Pl0fQ8yt/E1ixVlvYqddlAWTc58Jb+wdJ5+mNZIs0JChsAeJ9xC3JvVu
 1DT57bBl8d0ZCpTXOsu2mpB8v4RBla0uf2Z9x9XaFO5kAiue01cHXONUP4Mwo1csbDUv
 RUWA==
X-Gm-Message-State: AOAM533T2S5tG6ZydR2wnKhq49oAIDfUjUwB04B/C9ZfG0Mma3UKCB11
 1UCKOp7O2WF8AJYWHWn61Pd2rTSWYlGnXQ==
X-Google-Smtp-Source: ABdhPJwivMRS6LU1K56Wq9cBT4YMxwYgQSsMgf0tD/nlukG7cNBXezI2W7c9h37Mh+8AMzwCVnRKpg==
X-Received: by 2002:a17:902:d711:b029:d1:c6b5:ae5f with SMTP id
 w17-20020a170902d711b02900d1c6b5ae5fmr25678639ply.38.1600454275153; 
 Fri, 18 Sep 2020 11:37:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:37:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/81] target/arm: Fix sve_uzp_p vs odd vector lengths
Date: Fri, 18 Sep 2020 11:36:31 -0700
Message-Id: <20200918183751.2787647-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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

Missed out on compressing the second half of a predicate
with length vl % 512 > 256.

Adjust all of the x + (y << s) to x | (y << s) as a
general style fix.  Drop the extract64 because the input
uint64_t are known to be already zero-extended from the
current size of the predicate.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4758d46f34..fcb46f150f 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1938,7 +1938,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
     if (oprsz <= 8) {
         l = compress_bits(n[0] >> odd, esz);
         h = compress_bits(m[0] >> odd, esz);
-        d[0] = extract64(l + (h << (4 * oprsz)), 0, 8 * oprsz);
+        d[0] = l | (h << (4 * oprsz));
     } else {
         ARMPredicateReg tmp_m;
         intptr_t oprsz_16 = oprsz / 16;
@@ -1952,23 +1952,35 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
             h = n[2 * i + 1];
             l = compress_bits(l >> odd, esz);
             h = compress_bits(h >> odd, esz);
-            d[i] = l + (h << 32);
+            d[i] = l | (h << 32);
         }
 
-        /* For VL which is not a power of 2, the results from M do not
-           align nicely with the uint64_t for D.  Put the aligned results
-           from M into TMP_M and then copy it into place afterward.  */
+        /*
+         * For VL which is not a multiple of 512, the results from M do not
+         * align nicely with the uint64_t for D.  Put the aligned results
+         * from M into TMP_M and then copy it into place afterward.
+         */
         if (oprsz & 15) {
-            d[i] = compress_bits(n[2 * i] >> odd, esz);
+            int final_shift = (oprsz & 15) * 2;
+
+            l = n[2 * i + 0];
+            h = n[2 * i + 1];
+            l = compress_bits(l >> odd, esz);
+            h = compress_bits(h >> odd, esz);
+            d[i] = l | (h << final_shift);
 
             for (i = 0; i < oprsz_16; i++) {
                 l = m[2 * i + 0];
                 h = m[2 * i + 1];
                 l = compress_bits(l >> odd, esz);
                 h = compress_bits(h >> odd, esz);
-                tmp_m.p[i] = l + (h << 32);
+                tmp_m.p[i] = l | (h << 32);
             }
-            tmp_m.p[i] = compress_bits(m[2 * i] >> odd, esz);
+            l = m[2 * i + 0];
+            h = m[2 * i + 1];
+            l = compress_bits(l >> odd, esz);
+            h = compress_bits(h >> odd, esz);
+            tmp_m.p[i] = l | (h << final_shift);
 
             swap_memmove(vd + oprsz / 2, &tmp_m, oprsz / 2);
         } else {
@@ -1977,7 +1989,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
                 h = m[2 * i + 1];
                 l = compress_bits(l >> odd, esz);
                 h = compress_bits(h >> odd, esz);
-                d[oprsz_16 + i] = l + (h << 32);
+                d[oprsz_16 + i] = l | (h << 32);
             }
         }
     }
-- 
2.25.1


