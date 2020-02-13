Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C137C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 07:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BD42168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 07:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BD42168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j29Ju-0003QR-CP
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 02:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1j29J9-0002X2-DR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1j29J8-0001wA-8K
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:53:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:53034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1j29J8-0001uK-0B
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:53:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 23:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; d="scan'208";a="381032029"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga004.jf.intel.com with ESMTP; 12 Feb 2020 23:53:05 -0800
From: Robert Hoo <robert.hu@linux.intel.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, laurent@vivier.eu,
 philmd@redhat.com, berrange@redhat.com
Subject: [PATCH 2/2] util: add util function buffer_zero_avx512()
Date: Thu, 13 Feb 2020 15:52:59 +0800
Message-Id: <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
References: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
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
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And initialize buffer_is_zero() with it, when Intel AVX512F is
available on host.

This function utilizes Intel AVX512 fundamental instructions which
perform over previous AVX2 instructions.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 include/qemu/cpuid.h |  3 +++
 util/bufferiszero.c  | 56 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 3 deletions(-)

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
index bfb2605..cbb854a 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -187,12 +187,54 @@ buffer_zero_avx2(const void *buf, size_t len)
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
+    __m512i t;
+    __m512i *p, *e;
+
+    if (unlikely(len < 64)) { /*buff less than 512 bits, unlikely*/
+        return buffer_zero_int(buf, len);
+    }
+    /* Begin with an unaligned head of 64 bytes.  */
+    t = _mm512_loadu_si512(buf);
+    p = (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
+    e = (__m512i *)(((uintptr_t)buf + len) & -64);
+
+    /* Loop over 64-byte aligned blocks of 256.  */
+    while (p < e) {
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
+#define CACHE_SSE2    6
 
 /* Make sure that these variables are appropriately initialized when
  * SSE2 is enabled on the compiler command-line, but the compiler is
@@ -226,6 +268,11 @@ static void init_accel(unsigned cache)
         fn = buffer_zero_avx2;
     }
 #endif
+#ifdef CONFIG_AVX512F_OPT
+    if (cache & CACHE_AVX512F) {
+        fn = buffer_zero_avx512;
+    }
+#endif
     buffer_accel = fn;
 }
 
@@ -255,6 +302,9 @@ static void __attribute__((constructor)) init_cpuid_cache(void)
             if ((bv & 6) == 6 && (b & bit_AVX2)) {
                 cache |= CACHE_AVX2;
             }
+            if ((bv & 6) == 6 && (b & bit_AVX512F)) {
+                cache |= CACHE_AVX512F;
+            }
         }
     }
     cpuid_cache = cache;
-- 
1.8.3.1


