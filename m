Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEABC55ABD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4050B207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcPqE8SL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4050B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV67l-00020z-6u
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66R-0000Iy-Gb
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:51:59 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66P-0005fX-JT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:51:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id v22so564262ply.12
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LGlRflbwn1KenFXbCDq01WldOf+RnlV0DAS6MBQx+Bc=;
 b=AcPqE8SL1cKCYr8ojEk6ues3+ugqArGTnkDR3qlt5S8lEbu4hbaJcnz8yfs9oauH0m
 yolnPKozz/fs7n0iq26xtWMV4xj0NGvGbq6C228n5UNjCAcx7F9ar7l/9dzHnpE26qXk
 aNOs/0SuWG3cFYELU+e+Gzib+S2AjJEIyonCvoTw4wGp72ZY2jy5+MU7X7kM0/roS+ay
 q7eNtGUVeyXzM3NI7quCrDtsc0KVgMmLFo9NHzC/1ogBYS2VFlXEuTWZmc9r6jpJ7OV9
 0qv8BfGbs/Xvva2TUxGTJN5L+d+kOyztf0c9AWBESBVt6tOakmMpPxDU4POUCHPc5HJH
 M/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LGlRflbwn1KenFXbCDq01WldOf+RnlV0DAS6MBQx+Bc=;
 b=a6+0NYBhusQefVnyPQjLYKQrWPaQu9JG1UnSfw0Odg3IUoFYIynbyxEvlpu6mdf6rz
 iVLGfmdhhwhYtpPMs15rmB6h9hAvE/ShNOzzBpCqWlXX1qW/RH+pKQwYMDF+T+xhxsh2
 3sZKiu9GgMtoVhoclbjKQeBwRVWTp38rIlfpV5nCZNDvbfODCXmVBsHQAuv9NJ7qBK+1
 ZT4kfN2fpZ6j6BpwzzwO5k+rIBNJczrjnHmElsxCCjQErKJQnMjP0QN+vwJCpYBuVbAS
 noBEPpVmMzEMa9ESxcl1G9ivVZo6p7Pm7lhgOQOBAlN1jxmLhdN8XTbaDxUTAknE81up
 3MBA==
X-Gm-Message-State: AOAM5332CxlwzBY3ILis9AZpOg3tbByDaZsawOWbM/N0S2HLi6Hi6WUc
 ZYh2HyMgOovdlXM2baD79q1hWlTzTp67rg==
X-Google-Smtp-Source: ABdhPJyh2yOZsThxlVqTEeNryM87KdtKDA4JaAvJ1oXYCya5IhE5dBPA419qq6ejJgk+84qgCO5sVQ==
X-Received: by 2002:a17:90a:bb0e:: with SMTP id
 u14mr1478435pjr.112.1603255915621; 
 Tue, 20 Oct 2020 21:51:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:51:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 03/15] qemu/int128: Rename int128_rshift, int128_lshift
Date: Tue, 20 Oct 2020 21:51:37 -0700
Message-Id: <20201021045149.1582203-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change these to sar/shl to emphasize the signed shift.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/int128.h   |  8 ++++----
 softmmu/physmem.c       |  4 ++--
 target/ppc/int_helper.c |  4 ++--
 tests/test-int128.c     | 44 ++++++++++++++++++++---------------------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 055f202d08..167f13ae10 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -63,12 +63,12 @@ static inline Int128 int128_or(Int128 a, Int128 b)
     return a | b;
 }
 
-static inline Int128 int128_rshift(Int128 a, int n)
+static inline Int128 int128_sar(Int128 a, int n)
 {
     return a >> n;
 }
 
-static inline Int128 int128_lshift(Int128 a, int n)
+static inline Int128 int128_shl(Int128 a, int n)
 {
     return a << n;
 }
@@ -218,7 +218,7 @@ static inline Int128 int128_or(Int128 a, Int128 b)
     return (Int128) { a.lo | b.lo, a.hi | b.hi };
 }
 
-static inline Int128 int128_rshift(Int128 a, int n)
+static inline Int128 int128_sar(Int128 a, int n)
 {
     int64_t h;
     if (!n) {
@@ -232,7 +232,7 @@ static inline Int128 int128_rshift(Int128 a, int n)
     }
 }
 
-static inline Int128 int128_lshift(Int128 a, int n)
+static inline Int128 int128_shl(Int128 a, int n)
 {
     uint64_t l = a.lo << (n & 63);
     if (n >= 64) {
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index e319fb2a1e..7f6e98e7b0 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1156,8 +1156,8 @@ static void register_multipage(FlatView *fv,
     AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     hwaddr start_addr = section->offset_within_address_space;
     uint16_t section_index = phys_section_add(&d->map, section);
-    uint64_t num_pages = int128_get64(int128_rshift(section->size,
-                                                    TARGET_PAGE_BITS));
+    uint64_t num_pages = int128_get64(int128_sar(section->size,
+                                                 TARGET_PAGE_BITS));
 
     assert(num_pages);
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index b45626f44c..fe569590b4 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1444,7 +1444,7 @@ void helper_vlogefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
         } else {                                                    \
             index = ((15 - (a & 0xf) + 1) * 8) - size;              \
         }                                                           \
-        return int128_getlo(int128_rshift(b->s128, index)) &        \
+        return int128_getlo(int128_sar(b->s128, index)) &           \
             MAKE_64BIT_MASK(0, size);                               \
     }
 #else
@@ -1457,7 +1457,7 @@ void helper_vlogefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
         } else {                                                    \
             index = (a & 0xf) * 8;                                  \
         }                                                           \
-        return int128_getlo(int128_rshift(b->s128, index)) &        \
+        return int128_getlo(int128_sar(b->s128, index)) &           \
             MAKE_64BIT_MASK(0, size);                               \
     }
 #endif
diff --git a/tests/test-int128.c b/tests/test-int128.c
index b86a3c76e6..9bd6cb59ec 100644
--- a/tests/test-int128.c
+++ b/tests/test-int128.c
@@ -176,34 +176,34 @@ static void test_gt(void)
 /* Make sure to test undefined behavior at runtime! */
 
 static void __attribute__((__noinline__)) ATTRIBUTE_NOCLONE
-test_rshift_one(uint32_t x, int n, uint64_t h, uint64_t l)
+test_sar_one(uint32_t x, int n, uint64_t h, uint64_t l)
 {
     Int128 a = expand(x);
-    Int128 r = int128_rshift(a, n);
+    Int128 r = int128_sar(a, n);
     g_assert_cmpuint(int128_getlo(r), ==, l);
     g_assert_cmpuint(int128_gethi(r), ==, h);
 }
 
-static void test_rshift(void)
+static void test_sar(void)
 {
-    test_rshift_one(0x00010000U, 64, 0x0000000000000000ULL, 0x0000000000000001ULL);
-    test_rshift_one(0x80010000U, 64, 0xFFFFFFFFFFFFFFFFULL, 0x8000000000000001ULL);
-    test_rshift_one(0x7FFE0000U, 64, 0x0000000000000000ULL, 0x7FFFFFFFFFFFFFFEULL);
-    test_rshift_one(0xFFFE0000U, 64, 0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFFEULL);
-    test_rshift_one(0x00010000U, 60, 0x0000000000000000ULL, 0x0000000000000010ULL);
-    test_rshift_one(0x80010000U, 60, 0xFFFFFFFFFFFFFFF8ULL, 0x0000000000000010ULL);
-    test_rshift_one(0x00018000U, 60, 0x0000000000000000ULL, 0x0000000000000018ULL);
-    test_rshift_one(0x80018000U, 60, 0xFFFFFFFFFFFFFFF8ULL, 0x0000000000000018ULL);
-    test_rshift_one(0x7FFE0000U, 60, 0x0000000000000007ULL, 0xFFFFFFFFFFFFFFE0ULL);
-    test_rshift_one(0xFFFE0000U, 60, 0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFE0ULL);
-    test_rshift_one(0x7FFE8000U, 60, 0x0000000000000007ULL, 0xFFFFFFFFFFFFFFE8ULL);
-    test_rshift_one(0xFFFE8000U, 60, 0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFE8ULL);
-    test_rshift_one(0x00018000U,  0, 0x0000000000000001ULL, 0x8000000000000000ULL);
-    test_rshift_one(0x80018000U,  0, 0x8000000000000001ULL, 0x8000000000000000ULL);
-    test_rshift_one(0x7FFE0000U,  0, 0x7FFFFFFFFFFFFFFEULL, 0x0000000000000000ULL);
-    test_rshift_one(0xFFFE0000U,  0, 0xFFFFFFFFFFFFFFFEULL, 0x0000000000000000ULL);
-    test_rshift_one(0x7FFE8000U,  0, 0x7FFFFFFFFFFFFFFEULL, 0x8000000000000000ULL);
-    test_rshift_one(0xFFFE8000U,  0, 0xFFFFFFFFFFFFFFFEULL, 0x8000000000000000ULL);
+    test_sar_one(0x00010000U, 64, 0x0000000000000000ULL, 0x0000000000000001ULL);
+    test_sar_one(0x80010000U, 64, 0xFFFFFFFFFFFFFFFFULL, 0x8000000000000001ULL);
+    test_sar_one(0x7FFE0000U, 64, 0x0000000000000000ULL, 0x7FFFFFFFFFFFFFFEULL);
+    test_sar_one(0xFFFE0000U, 64, 0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFFEULL);
+    test_sar_one(0x00010000U, 60, 0x0000000000000000ULL, 0x0000000000000010ULL);
+    test_sar_one(0x80010000U, 60, 0xFFFFFFFFFFFFFFF8ULL, 0x0000000000000010ULL);
+    test_sar_one(0x00018000U, 60, 0x0000000000000000ULL, 0x0000000000000018ULL);
+    test_sar_one(0x80018000U, 60, 0xFFFFFFFFFFFFFFF8ULL, 0x0000000000000018ULL);
+    test_sar_one(0x7FFE0000U, 60, 0x0000000000000007ULL, 0xFFFFFFFFFFFFFFE0ULL);
+    test_sar_one(0xFFFE0000U, 60, 0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFE0ULL);
+    test_sar_one(0x7FFE8000U, 60, 0x0000000000000007ULL, 0xFFFFFFFFFFFFFFE8ULL);
+    test_sar_one(0xFFFE8000U, 60, 0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFE8ULL);
+    test_sar_one(0x00018000U,  0, 0x0000000000000001ULL, 0x8000000000000000ULL);
+    test_sar_one(0x80018000U,  0, 0x8000000000000001ULL, 0x8000000000000000ULL);
+    test_sar_one(0x7FFE0000U,  0, 0x7FFFFFFFFFFFFFFEULL, 0x0000000000000000ULL);
+    test_sar_one(0xFFFE0000U,  0, 0xFFFFFFFFFFFFFFFEULL, 0x0000000000000000ULL);
+    test_sar_one(0x7FFE8000U,  0, 0x7FFFFFFFFFFFFFFEULL, 0x8000000000000000ULL);
+    test_sar_one(0xFFFE8000U,  0, 0xFFFFFFFFFFFFFFFEULL, 0x8000000000000000ULL);
 }
 
 int main(int argc, char **argv)
@@ -218,6 +218,6 @@ int main(int argc, char **argv)
     g_test_add_func("/int128/int128_lt", test_lt);
     g_test_add_func("/int128/int128_ge", test_ge);
     g_test_add_func("/int128/int128_gt", test_gt);
-    g_test_add_func("/int128/int128_rshift", test_rshift);
+    g_test_add_func("/int128/int128_sar", test_sar);
     return g_test_run();
 }
-- 
2.25.1


