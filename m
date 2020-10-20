Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C376C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B3122242
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKlA4pTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B3122242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUug3-0001GF-I5
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue6-0007uu-Hv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue2-0000zr-Kv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id b127so2688343wmb.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ynL+ImLU8/MZiwy8JbT5zQ/0QgGC9xGdCjTroVHDtRY=;
 b=OKlA4pTpDYGoYJp1GCr28VzKFsKuZTGzmoSHGMK1pUZn0wYy9IxiZ7ZgjgtL2E9nj0
 +xPrXoXf4RFwL67aOG77Phv5n7nTwvOE1Be0Mj9qJF3LL+Wg8bIuQ7Myzz9Uy/PhmOKM
 OeZaqEY4x2EeNX5L12hEzBBNpxyPO25Ne1BtLdtrOO4J4LH6/+Zgn6N0ak03/F+zE8IO
 HCKaTPSixcRcEJBf08Nr087hJS3+ligp7wmViTiEHE5nL+URSKqBqIbjZHydmBs3kEO7
 d4pdjI+uC7FUFqeLbIUPQWN1eTf7GtrLuRv4KE+bDYOJSmF4nS8p19Z737Yt68luOLrF
 QBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ynL+ImLU8/MZiwy8JbT5zQ/0QgGC9xGdCjTroVHDtRY=;
 b=j7b4494pV47EH06JLwWTQlCSzFAzjPJ4yM5uj3/cipG5lbE2zIQZvLmZUFSWMmza/j
 YTKseCO1XuSX8yE/GAjnTCGGF0GvR5Q0bbAmFyqoJzDYH3gzjt8vnLD+XIVdLGEZ8GVr
 JZy7g5VvdWR68hQ48jrS3WW1kVllj9AdsVpC5ds7CZ0Xg+E+FV/RxJa6YOVTsZzkP9FR
 +wvRS6u3LUGiMkZdsu7AmmNhojNF3Jw68mwMxunUW/N6LJcM9hskGIsne1qPz/5urthO
 byjWgoB002OVsYpylvy49hwrPvlVDSGIesT/TUU8+vlC5C3jo4mBkgx+cJqGxOolKzPN
 WfZQ==
X-Gm-Message-State: AOAM531+RwINazmX6K0F/N/RvegpCp84seNIWyA0T4IjUhRqaQLBRsT4
 5369JBbQFsfzar0YaCe675/mYA==
X-Google-Smtp-Source: ABdhPJyCKkQyGxAve0SGv9njdbT2dNTMKc5Y8MlsICzltaLGesAnxoXKrnadPChsTwzJpPzt6y/QNg==
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr3832355wme.39.1603211871942; 
 Tue, 20 Oct 2020 09:37:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i14sm3305204wml.24.2020.10.20.09.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 09:37:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEE021FF92;
 Tue, 20 Oct 2020 17:37:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 6/8] int128.h: add bunch of uint128 utility functions
 (INCOMPLETE)
Date: Tue, 20 Oct 2020 17:37:36 +0100
Message-Id: <20201020163738.27700-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020163738.27700-1-alex.bennee@linaro.org>
References: <20201020163738.27700-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These will be useful for softfloat. I've included the extract/desposit
functions with the main Int128 header and not with cutils as we need
alternate versions for systems that don't have compiler support for
Uint128. Even with compiler support some stuff we need to
hand-hack (like clz128).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/int128.h | 122 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 76ea405922..38c8b1ab29 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -3,8 +3,10 @@
 
 #ifdef CONFIG_INT128
 #include "qemu/bswap.h"
+#include "qemu/host-utils.h"
 
 typedef __int128_t Int128;
+typedef __uint128_t Uint128;
 
 static inline Int128 int128_make64(uint64_t a)
 {
@@ -16,6 +18,11 @@ static inline Int128 int128_make128(uint64_t lo, uint64_t hi)
     return (__uint128_t)hi << 64 | lo;
 }
 
+static inline Uint128 uint128_make128(uint64_t lo, uint64_t hi)
+{
+    return (__uint128_t)hi << 64 | lo;
+}
+
 static inline uint64_t int128_get64(Int128 a)
 {
     uint64_t r = a;
@@ -28,16 +35,31 @@ static inline uint64_t int128_getlo(Int128 a)
     return a;
 }
 
+static inline uint64_t uint128_getlo(Uint128 a)
+{
+    return a;
+}
+
 static inline int64_t int128_gethi(Int128 a)
 {
     return a >> 64;
 }
 
+static inline uint64_t uint128_gethi(Uint128 a)
+{
+    return a >> 64;
+}
+
 static inline Int128 int128_zero(void)
 {
     return 0;
 }
 
+static inline Uint128 uint128_zero(void)
+{
+    return 0;
+}
+
 static inline Int128 int128_one(void)
 {
     return 1;
@@ -58,21 +80,51 @@ static inline Int128 int128_and(Int128 a, Int128 b)
     return a & b;
 }
 
+static inline Uint128 uint128_and(Uint128 a, Uint128 b)
+{
+    return a & b;
+}
+
+static inline Int128 int128_or(Int128 a, Int128 b)
+{
+    return a | b;
+}
+
+static inline Uint128 uint128_or(Uint128 a, Uint128 b)
+{
+    return a | b;
+}
+
 static inline Int128 int128_rshift(Int128 a, int n)
 {
     return a >> n;
 }
 
+static inline Uint128 uint128_rshift(Uint128 a, int n)
+{
+    return a >> n;
+}
+
 static inline Int128 int128_lshift(Int128 a, int n)
 {
     return a << n;
 }
 
+static inline Uint128 uint128_lshift(Uint128 a, int n)
+{
+    return a << n;
+}
+
 static inline Int128 int128_add(Int128 a, Int128 b)
 {
     return a + b;
 }
 
+static inline Uint128 uint128_add(Uint128 a, Uint128 b)
+{
+    return a + b;
+}
+
 static inline Int128 int128_neg(Int128 a)
 {
     return -a;
@@ -83,6 +135,11 @@ static inline Int128 int128_sub(Int128 a, Int128 b)
     return a - b;
 }
 
+static inline Uint128 uint128_sub(Uint128 a, Uint128 b)
+{
+    return a - b;
+}
+
 static inline bool int128_nonneg(Int128 a)
 {
     return a >= 0;
@@ -93,6 +150,11 @@ static inline bool int128_eq(Int128 a, Int128 b)
     return a == b;
 }
 
+static inline bool uint128_eq(Uint128 a, Uint128 b)
+{
+    return a == b;
+}
+
 static inline bool int128_ne(Int128 a, Int128 b)
 {
     return a != b;
@@ -148,6 +210,66 @@ static inline Int128 bswap128(Int128 a)
     return int128_make128(bswap64(int128_gethi(a)), bswap64(int128_getlo(a)));
 }
 
+/**
+ * extract128:
+ * @value: the value to extract the bit field from
+ * @start: the lowest bit in the bit field (numbered from 0)
+ * @length: the length of the bit field
+ *
+ * Extract from the 128 bit input @value the bit field specified by the
+ * @start and @length parameters, and return it. The bit field must
+ * lie entirely within the 128 bit word. It is valid to request that
+ * all 128 bits are returned (ie @length 128 and @start 0).
+ *
+ * Returns: the value of the bit field extracted from the input value.
+ */
+static inline Uint128 extract128(Uint128 value, int start, int length)
+{
+    assert(start >= 0 && length > 0 && length <= 128 - start);
+    Uint128 mask = ~(Uint128)0 >> (128 - length);
+    Uint128 shifted = value >> start;
+    return shifted & mask;
+}
+
+/**
+ * deposit128:
+ * @value: initial value to insert bit field into
+ * @start: the lowest bit in the bit field (numbered from 0)
+ * @length: the length of the bit field
+ * @fieldval: the value to insert into the bit field
+ *
+ * Deposit @fieldval into the 128 bit @value at the bit field specified
+ * by the @start and @length parameters, and return the modified
+ * @value. Bits of @value outside the bit field are not modified.
+ * Bits of @fieldval above the least significant @length bits are
+ * ignored. The bit field must lie entirely within the 128 bit word.
+ * It is valid to request that all 128 bits are modified (ie @length
+ * 128 and @start 0).
+ *
+ * Returns: the modified @value.
+ */
+static inline Uint128 deposit128(Uint128 value, int start, int length,
+                                 Uint128 fieldval)
+{
+    assert(start >= 0 && length > 0 && length <= 128 - start);
+    Uint128 mask = (~(Uint128)0 >> (128 - length)) << start;
+    return (value & ~mask) | ((fieldval << start) & mask);
+}
+
+static inline int clz128(Uint128 val)
+{
+    if (val) {
+        uint64_t hi = uint128_gethi(val);
+        if (hi) {
+            return clz64(hi);
+        } else {
+            return 64 + clz64(uint128_getlo(val));
+        }
+    } else {
+        return 128;
+    }
+}
+
 #else /* !CONFIG_INT128 */
 
 typedef struct Int128 Int128;
-- 
2.20.1


