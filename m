Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD0C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3F821534
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYyMbrpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3F821534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG3P-000168-Sv
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0K-0004lw-LG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:36704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0I-0005hC-UQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id s19so747350plp.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PUkREiDac/4ZH7kWY/xK+XNOCt1EYwSejvDGxYtWXc4=;
 b=lYyMbrpdc++53vlc3q+IWdBjzU9XkySvfkNS25W7dv13bKR38I535+EFHodl0X2XKc
 lbSxON3zFzUjwB3x/exjzHAyOKfinuh3LTZNeuVAxOly1yEVplmqcWEes7dIBIYdy+mw
 FvdOn1tIDasH6lGX9xnL1N4fHeU1wpmwu942Rc3gegE1AmxSBUVzPkTx+n7Tb+0Kp+rV
 d5DPBpAcMjVbchVwccgSOZltEBlKHrFIL6lWa9+kYamANQnWiMyDKmeK3BX/GkXdcI9D
 nwhy1lS4+ryyGDN+VBdpqbWVp6ns+sqNWA1uOo9k271fwGDNVilV4vmMZmO8DnP1vfk2
 pgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PUkREiDac/4ZH7kWY/xK+XNOCt1EYwSejvDGxYtWXc4=;
 b=s4PPcncvi4fK4Ur6ILgU6eLs70iYhS0dxTBDdL+Rg2ooH9HN4L/y3lYK2jYpiXHP8l
 raluBbYcuGs99zrHsyOT6SdPmaRZa+qBTrdton4h71irMIoV+8EcWPb/pMbdp1UB2qJ9
 EYI6/xuDwDqxLwYtyeREBhKjvKwCFxEB8hWX8KOwSP5zbfCa33AsO6gCANHkOXjwTguF
 +KzPfaLJfhkGot/xq4XhjCkqI3q7lUkzWYRm6qtOv1IAp6CfFQiVv4/Kq887d8HJ5V5P
 wnqw1HLBUsu4+vjyTqwF2o/JgV2CtAJK4XrTKSYp0VAd7AauebA6WX277fAx9GDUYxr/
 tcZA==
X-Gm-Message-State: AOAM531DJZY9GsDZpMXRUw7ybZ1MVugvIsYzITlD9ZKGoao7LXYW0mKI
 YOz82rH/rcXMD15kDfFQK/qzZYJLYQSzeA==
X-Google-Smtp-Source: ABdhPJzMOS2FmZyIbfQ/ARz6qZ2hW4CRiVsy9YvfmzBRFRZT4WZh1M9cpHzQIbdeziR+SB/WeyuOcA==
X-Received: by 2002:a17:902:9697:b029:d1:e598:4001 with SMTP id
 n23-20020a1709029697b02900d1e5984001mr2288681plp.59.1600910697202; 
 Wed, 23 Sep 2020 18:24:57 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:24:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] softfloat: Use int128.h for some operations
Date: Wed, 23 Sep 2020 18:24:47 -0700
Message-Id: <20200924012453.659757-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924012453.659757-1-richard.henderson@linaro.org>
References: <20200924012453.659757-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use our Int128, which wraps the compiler's __int128_t,
instead of open-coding left shifts and arithmetic.
We'd need to extend Int128 to have unsigned operations
to replace more than these three.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 39 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 57845f8af0..95d88d05b8 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -84,6 +84,7 @@ this code that are retained.
 
 #include "fpu/softfloat-types.h"
 #include "qemu/host-utils.h"
+#include "qemu/int128.h"
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
@@ -352,13 +353,11 @@ static inline void shortShift128Left(uint64_t a0, uint64_t a1, int count,
 static inline void shift128Left(uint64_t a0, uint64_t a1, int count,
                                 uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    if (count < 64) {
-        *z1Ptr = a1 << count;
-        *z0Ptr = count == 0 ? a0 : (a0 << count) | (a1 >> (-count & 63));
-    } else {
-        *z1Ptr = 0;
-        *z0Ptr = a1 << (count - 64);
-    }
+    Int128 a = int128_make128(a1, a0);
+    Int128 z = int128_lshift(a, count);
+
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
@@ -405,15 +404,15 @@ static inline void
 *----------------------------------------------------------------------------*/
 
 static inline void
- add128(
-     uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1, uint64_t *z0Ptr, uint64_t *z1Ptr )
+add128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1,
+       uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    uint64_t z1;
-
-    z1 = a1 + b1;
-    *z1Ptr = z1;
-    *z0Ptr = a0 + b0 + ( z1 < a1 );
+    Int128 a = int128_make128(a1, a0);
+    Int128 b = int128_make128(b1, b0);
+    Int128 z = int128_add(a, b);
 
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
@@ -463,13 +462,15 @@ static inline void
 *----------------------------------------------------------------------------*/
 
 static inline void
- sub128(
-     uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1, uint64_t *z0Ptr, uint64_t *z1Ptr )
+sub128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1,
+       uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
+    Int128 a = int128_make128(a1, a0);
+    Int128 b = int128_make128(b1, b0);
+    Int128 z = int128_sub(a, b);
 
-    *z1Ptr = a1 - b1;
-    *z0Ptr = a0 - b0 - ( a1 < b1 );
-
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.25.1


