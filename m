Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29000C3F2CE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8B520679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Owy3iBlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8B520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxOB-00034z-Pt
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH4-0002Wu-7A
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH2-0000lE-ED
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxH2-0000iK-7u
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKYvUhjSJklIbG3VyhaS4xUOvCy4nVZady6qtVInulQ=;
 b=Owy3iBlO3Rux+GmDdAsoFbrpYDooyEodlZ3KZI74j+lzTMiXeU8Da596hafWOTza1JOqGs
 U3/X+hjmIfzcleB4IKyQS5Zm+Mg71uZRbZXNKByRN/1tCmNt2L2biycOjBe2toM4cweMlC
 Yh4runk49y1X/oD31M/kALDVofUVg+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-UvtGVBEfMRK_wlCmBZhjAA-1; Mon, 16 Mar 2020 17:27:43 -0400
X-MC-Unique: UvtGVBEfMRK_wlCmBZhjAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 979AC107ACCD;
 Mon, 16 Mar 2020 21:27:42 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A463919C4F;
 Mon, 16 Mar 2020 21:27:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/61] util: add util function buffer_zero_avx512()
Date: Mon, 16 Mar 2020 22:26:33 +0100
Message-Id: <1584394048-44994-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Hoo <robert.hu@linux.intel.com>

And intialize buffer_is_zero() with it, when Intel AVX512F is
available on host.

This function utilizes Intel AVX512 fundamental instructions which
is faster than its implementation with AVX2 (in my unit test, with
4K buffer, on CascadeLake SP, ~36% faster, buffer_zero_avx512() V.S.
buffer_zero_avx2()).

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/cpuid.h |  3 +++
 util/bufferiszero.c  | 74 +++++++++++++++++++++++++++++++++++++++++++++---=
----
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
=20
-#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT) || defined(__S=
SE2__)
 /* Do not use push_options pragmas unnecessarily, because clang
  * does not support them.
  */
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #pragma GCC push_options
 #pragma GCC target("sse2")
 #endif
@@ -104,7 +104,7 @@ buffer_zero_sse2(const void *buf, size_t len)
=20
     return _mm_movemask_epi8(_mm_cmpeq_epi8(t, zero)) =3D=3D 0xFFFF;
 }
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #pragma GCC pop_options
 #endif
=20
@@ -187,18 +187,54 @@ buffer_zero_avx2(const void *buf, size_t len)
 #pragma GCC pop_options
 #endif /* CONFIG_AVX2_OPT */
=20
+#ifdef CONFIG_AVX512F_OPT
+#pragma GCC push_options
+#pragma GCC target("avx512f")
+#include <immintrin.h>
+
+static bool
+buffer_zero_avx512(const void *buf, size_t len)
+{
+    /* Begin with an unaligned head of 64 bytes.  */
+    __m512i t =3D _mm512_loadu_si512(buf);
+    __m512i *p =3D (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
+    __m512i *e =3D (__m512i *)(((uintptr_t)buf + len) & -64);
+
+    /* Loop over 64-byte aligned blocks of 256.  */
+    while (p <=3D e) {
+        __builtin_prefetch(p);
+        if (unlikely(_mm512_test_epi64_mask(t, t))) {
+            return false;
+        }
+        t =3D p[-4] | p[-3] | p[-2] | p[-1];
+        p +=3D 4;
+    }
+
+    t |=3D _mm512_loadu_si512(buf + len - 4 * 64);
+    t |=3D _mm512_loadu_si512(buf + len - 3 * 64);
+    t |=3D _mm512_loadu_si512(buf + len - 2 * 64);
+    t |=3D _mm512_loadu_si512(buf + len - 1 * 64);
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
=20
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
=20
 static unsigned cpuid_cache =3D INIT_CACHE;
 static bool (*buffer_accel)(const void *, size_t) =3D INIT_ACCEL;
+static int length_to_accel;
=20
 static void init_accel(unsigned cache)
 {
     bool (*fn)(const void *, size_t) =3D buffer_zero_int;
     if (cache & CACHE_SSE2) {
         fn =3D buffer_zero_sse2;
+        length_to_accel =3D 64;
     }
 #ifdef CONFIG_AVX2_OPT
     if (cache & CACHE_SSE4) {
         fn =3D buffer_zero_sse4;
+        length_to_accel =3D 64;
     }
     if (cache & CACHE_AVX2) {
         fn =3D buffer_zero_avx2;
+        length_to_accel =3D 64;
+    }
+#endif
+#ifdef CONFIG_AVX512F_OPT
+    if (cache & CACHE_AVX512F) {
+        fn =3D buffer_zero_avx512;
+        length_to_accel =3D 256;
     }
 #endif
     buffer_accel =3D fn;
 }
=20
-#ifdef CONFIG_AVX2_OPT
+#if defined(CONFIG_AVX512F_OPT) || defined(CONFIG_AVX2_OPT)
 #include "qemu/cpuid.h"
=20
 static void __attribute__((constructor)) init_cpuid_cache(void)
@@ -252,9 +298,17 @@ static void __attribute__((constructor)) init_cpuid_ca=
che(void)
             int bv;
             __asm("xgetbv" : "=3Da"(bv), "=3Dd"(d) : "c"(0));
             __cpuid_count(7, 0, a, b, c, d);
-            if ((bv & 6) =3D=3D 6 && (b & bit_AVX2)) {
+            if ((bv & 0x6) =3D=3D 0x6 && (b & bit_AVX2)) {
                 cache |=3D CACHE_AVX2;
             }
+            /* 0xe6:
+            *  XCR0[7:5] =3D 111b (OPMASK state, upper 256-bit of ZMM0-ZMM=
15
+            *                    and ZMM16-ZMM31 state are enabled by OS)
+            *  XCR0[2:1] =3D 11b (XMM state and YMM state are enabled by O=
S)
+            */
+            if ((bv & 0xe6) =3D=3D 0xe6 && (b & bit_AVX512F)) {
+                cache |=3D CACHE_AVX512F;
+            }
         }
     }
     cpuid_cache =3D cache;
@@ -277,7 +331,7 @@ bool test_buffer_is_zero_next_accel(void)
=20
 static bool select_accel_fn(const void *buf, size_t len)
 {
-    if (likely(len >=3D 64)) {
+    if (likely(len >=3D length_to_accel)) {
         return buffer_accel(buf, len);
     }
     return buffer_zero_int(buf, len);
--=20
1.8.3.1



