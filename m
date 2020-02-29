Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F05C3F2C6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 12:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740E6246A3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 12:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740E6246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j81Lo-0005e3-Hk
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 07:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1j81KZ-0004ec-IW
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 07:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1j81KY-00081T-AG
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 07:34:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:29711)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1j81KY-000815-2S
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 07:34:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Feb 2020 04:34:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,499,1574150400"; d="scan'208";a="242654297"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga006.jf.intel.com with ESMTP; 29 Feb 2020 04:34:50 -0800
From: Robert Hoo <robert.hu@linux.intel.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 laurent@vivier.eu, philmd@redhat.com, berrange@redhat.com
Subject: [PATCH v4 2/2] util: add util function buffer_zero_avx512()
Date: Sat, 29 Feb 2020 20:34:35 +0800
Message-Id: <1582979675-22550-3-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582979675-22550-1-git-send-email-robert.hu@linux.intel.com>
References: <1582979675-22550-1-git-send-email-robert.hu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: robert.hu@intel.com, chao.p.peng@intel.com,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And intialize buffer_is_zero() with it, when Intel AVX512F is
available on host.

This function utilizes Intel AVX512 fundamental instructions which
is faster than its implementation with AVX2 (in my unit test, with
4K buffer, on CascadeLake SP, ~36% faster, buffer_zero_avx512() V.S.
buffer_zero_avx2()).

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 include/qemu/cpuid.h |  3 +++
 util/bufferiszero.c  | 74 +++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index 6930170..09fc245 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -45,6 +45,9 @@
 #ifndef bit_AVX2
 #define bit_AVX2        (1 << 5)
 #endif
+#ifndef bit_AVX512F
+#define bit_AVX512F        (1 << 16)
+#endif
 #ifndef bit_BMI2
 #define bit_BMI2        (1 << 8)
 #endif
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index bfb2605..b6eab0c 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -63,11 +63,11 @@ buffer_zero_int(const void *buf, size_t len)
     }
 }
 
-#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 /* Do not use push_options pragmas unnecessarily, because clang
  * does not support them.
  */
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #pragma GCC push_options
 #pragma GCC target("sse2")
 #endif
@@ -104,7 +104,7 @@ buffer_zero_sse2(const void *buf, size_t len)
 
     return _mm_movemask_epi8(_mm_cmpeq_epi8(t, zero)) == 0xFFFF;
 }
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #pragma GCC pop_options
 #endif
 
@@ -187,18 +187,54 @@ buffer_zero_avx2(const void *buf, size_t len)
 #pragma GCC pop_options
 #endif /* CONFIG_AVX2_OPT */
 
+#ifdef CONFIG_AVX512F_OPT
+#pragma GCC push_options
+#pragma GCC target("avx512f")
+#include <immintrin.h>
+
+static bool
+buffer_zero_avx512(const void *buf, size_t len)
+{
+    /* Begin with an unaligned head of 64 bytes.  */
+    __m512i t = _mm512_loadu_si512(buf);
+    __m512i *p = (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
+    __m512i *e = (__m512i *)(((uintptr_t)buf + len) & -64);
+
+    /* Loop over 64-byte aligned blocks of 256.  */
+    while (p <= e) {
+        __builtin_prefetch(p);
+        if (unlikely(_mm512_test_epi64_mask(t, t))) {
+            return false;
+        }
+        t = p[-4] | p[-3] | p[-2] | p[-1];
+        p += 4;
+    }
+
+    t |= _mm512_loadu_si512(buf + len - 4 * 64);
+    t |= _mm512_loadu_si512(buf + len - 3 * 64);
+    t |= _mm512_loadu_si512(buf + len - 2 * 64);
+    t |= _mm512_loadu_si512(buf + len - 1 * 64);
+
+    return !_mm512_test_epi64_mask(t, t);
+
+}
+#pragma GCC pop_options
+#endif
+
+
 /* Note that for test_buffer_is_zero_next_accel, the most preferred
  * ISA must have the least significant bit.
  */
-#define CACHE_AVX2    1
-#define CACHE_SSE4    2
-#define CACHE_SSE2    4
+#define CACHE_AVX512F 1
+#define CACHE_AVX2    2
+#define CACHE_SSE4    4
+#define CACHE_SSE2    8
 
 /* Make sure that these variables are appropriately initialized when
  * SSE2 is enabled on the compiler command-line, but the compiler is
  * too old to support CONFIG_AVX2_OPT.
  */
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 # define INIT_CACHE 0
 # define INIT_ACCEL buffer_zero_int
 #else
@@ -211,25 +247,35 @@ buffer_zero_avx2(const void *buf, size_t len)
 
 static unsigned cpuid_cache = INIT_CACHE;
 static bool (*buffer_accel)(const void *, size_t) = INIT_ACCEL;
+static int length_to_accel;
 
 static void init_accel(unsigned cache)
 {
     bool (*fn)(const void *, size_t) = buffer_zero_int;
     if (cache & CACHE_SSE2) {
         fn = buffer_zero_sse2;
+        length_to_accel = 64;
     }
 #ifdef CONFIG_AVX2_OPT
     if (cache & CACHE_SSE4) {
         fn = buffer_zero_sse4;
+        length_to_accel = 64;
     }
     if (cache & CACHE_AVX2) {
         fn = buffer_zero_avx2;
+        length_to_accel = 64;
+    }
+#endif
+#ifdef CONFIG_AVX512F_OPT
+    if (cache & CACHE_AVX512F) {
+        fn = buffer_zero_avx512;
+        length_to_accel = 256;
     }
 #endif
     buffer_accel = fn;
 }
 
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #include "qemu/cpuid.h"
 
 static void __attribute__((constructor)) init_cpuid_cache(void)
@@ -252,9 +298,17 @@ static void __attribute__((constructor)) init_cpuid_cache(void)
             int bv;
             __asm("xgetbv" : "=a"(bv), "=d"(d) : "c"(0));
             __cpuid_count(7, 0, a, b, c, d);
-            if ((bv & 6) == 6 && (b & bit_AVX2)) {
+            if ((bv & 0x6) == 0x6 && (b & bit_AVX2)) {
                 cache |= CACHE_AVX2;
             }
+            /* 0xe6:
+            *  XCR0[7:5] = 111b (OPMASK state, upper 256-bit of ZMM0-ZMM15
+            *                    and ZMM16-ZMM31 state are enabled by OS)
+            *  XCR0[2:1] = 11b (XMM state and YMM state are enabled by OS)
+            */
+            if ((bv & 0xe6) == 0xe6 && (b & bit_AVX512F)) {
+                cache |= CACHE_AVX512F;
+            }
         }
     }
     cpuid_cache = cache;
@@ -277,7 +331,7 @@ bool test_buffer_is_zero_next_accel(void)
 
 static bool select_accel_fn(const void *buf, size_t len)
 {
-    if (likely(len >= 64)) {
+    if (likely(len >= length_to_accel)) {
         return buffer_accel(buf, len);
     }
     return buffer_zero_int(buf, len);
-- 
1.8.3.1


