Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC44C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9980E20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9980E20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhrS-0000KX-Ow
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZhkx-0000I8-FG
 for qemu-devel@nongnu.org; Fri, 15 May 2020 17:20:35 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:44186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZhkw-0007JC-02
 for qemu-devel@nongnu.org; Fri, 15 May 2020 17:20:35 -0400
IronPort-SDR: Rl6+KdgYmQ8I9/wBEY1zg4JqliBORW/2PECe4uuquxyTCrWFuHU/zmU993dLFUByLkJFKgl9OP
 EGj1gQPrQG1rZtiUldAToZTkrkqXYRfQYzHkYlcAdmZXfZxftgGdfjf0zMcLp+DopB8yaY24KA
 UuNCEx0KT0dUp6JY+v20sFRELlRCvWbcKqpetSn1FU0H075ehvIFKrJt6pDzVHOzoqu7wtu8Cp
 HQlF2i8UYWYvgbn2lBOh58f3FwDPRh/IVTRBvIrqiqDxt7M8ToRXMruem5/dE1V1rvoCHPiYsT
 Yik=
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; d="scan'208";a="48901696"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 15 May 2020 13:20:31 -0800
IronPort-SDR: I90DriDduXTSbGy1oykAjrBVFEsZOe3NCymQyB/EDsULtTs89ueK4Ic5cMGVF1dGKWK+sQjUJr
 2Ucwjm/qV6uVWQgzfSvtXAmEEYllu7ywYZ6IggMcy0/0s1cPmprtVeYYW9yujalM+bgK0XDwW1
 vx5MXyMTlf5c31QYBHSlDDfDr8XycimK/SNIJtfN+hQU5izaCHmq5oHRMrB6Vg5gHAabxE99d0
 EPhp46EHvd8HyFLveWYu7Sa7EVreLp1TRliZ6msvtJMyXjW6BO3ZeTS69BoenvXgeW+TtMlATh
 HQU=
Date: Fri, 15 May 2020 21:20:25 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 1/2] target/i386: fix fisttpl,
 fisttpll handling of out-of-range values
In-Reply-To: <alpine.DEB.2.21.2005152117400.3469@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005152119160.3469@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005152117400.3469@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:20:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The fist / fistt family of instructions should all store the most
negative integer in the destination format when the rounded /
truncated integer result is out of range or the input is an invalid
encoding, infinity or NaN.  The fisttpl and fisttpll implementations
(32-bit and 64-bit results, truncate towards zero) failed to do this,
producing the most positive integer in some cases instead.  Fix this
by copying the code used to handle this issue for fistpl and fistpll,
adjusted to use the _round_to_zero functions for the actual
conversion (but without any other changes to that code).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c          |  28 ++++++++-
 tests/tcg/i386/test-i386-fisttp.c | 100 ++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fisttp.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 96c512fedf..8dcc9ddf68 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -338,12 +338,36 @@ int32_t helper_fistt_ST0(CPUX86State *env)
 
 int32_t helper_fisttl_ST0(CPUX86State *env)
 {
-    return floatx80_to_int32_round_to_zero(ST0, &env->fp_status);
+    int32_t val;
+    signed char old_exp_flags;
+
+    old_exp_flags = get_float_exception_flags(&env->fp_status);
+    set_float_exception_flags(0, &env->fp_status);
+
+    val = floatx80_to_int32_round_to_zero(ST0, &env->fp_status);
+    if (get_float_exception_flags(&env->fp_status) & float_flag_invalid) {
+        val = 0x80000000;
+    }
+    set_float_exception_flags(get_float_exception_flags(&env->fp_status)
+                                | old_exp_flags, &env->fp_status);
+    return val;
 }
 
 int64_t helper_fisttll_ST0(CPUX86State *env)
 {
-    return floatx80_to_int64_round_to_zero(ST0, &env->fp_status);
+    int64_t val;
+    signed char old_exp_flags;
+
+    old_exp_flags = get_float_exception_flags(&env->fp_status);
+    set_float_exception_flags(0, &env->fp_status);
+
+    val = floatx80_to_int64_round_to_zero(ST0, &env->fp_status);
+    if (get_float_exception_flags(&env->fp_status) & float_flag_invalid) {
+        val = 0x8000000000000000ULL;
+    }
+    set_float_exception_flags(get_float_exception_flags(&env->fp_status)
+                                | old_exp_flags, &env->fp_status);
+    return val;
 }
 
 void helper_fldt_ST0(CPUX86State *env, target_ulong ptr)
diff --git a/tests/tcg/i386/test-i386-fisttp.c b/tests/tcg/i386/test-i386-fisttp.c
new file mode 100644
index 0000000000..16af59a774
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fisttp.c
@@ -0,0 +1,100 @@
+/* Test fisttpl and fisttpll instructions.  */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+union u {
+    struct { uint64_t sig; uint16_t sign_exp; } s;
+    long double ld;
+};
+
+volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
+
+int main(void)
+{
+    int ret = 0;
+    int32_t res_32;
+    int64_t res_64;
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (0x1p100L) : "st");
+    if (res_32 != INT32_MIN) {
+        printf("FAIL: fisttpl 0x1p100\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (-0x1p100L) : "st");
+    if (res_32 != INT32_MIN) {
+        printf("FAIL: fisttpl -0x1p100\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (__builtin_infl()) :
+                      "st");
+    if (res_32 != INT32_MIN) {
+        printf("FAIL: fisttpl inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (-__builtin_infl()) :
+                      "st");
+    if (res_32 != INT32_MIN) {
+        printf("FAIL: fisttpl -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (__builtin_nanl("")) :
+                      "st");
+    if (res_32 != INT32_MIN) {
+        printf("FAIL: fisttpl nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) :
+                      "t" (-__builtin_nanl("")) : "st");
+    if (res_32 != INT32_MIN) {
+        printf("FAIL: fisttpl -nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (ld_invalid_1.ld) :
+                      "st");
+    if (res_32 != INT32_MIN) {
+        printf("FAIL: fisttpl invalid\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (0x1p100L) : "st");
+    if (res_64 != INT64_MIN) {
+        printf("FAIL: fisttpll 0x1p100\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (-0x1p100L) : "st");
+    if (res_64 != INT64_MIN) {
+        printf("FAIL: fisttpll -0x1p100\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (__builtin_infl()) :
+                      "st");
+    if (res_64 != INT64_MIN) {
+        printf("FAIL: fisttpll inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (-__builtin_infl()) :
+                      "st");
+    if (res_64 != INT64_MIN) {
+        printf("FAIL: fisttpll -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) :
+                      "t" (__builtin_nanl("")) : "st");
+    if (res_64 != INT64_MIN) {
+        printf("FAIL: fisttpll nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) :
+                      "t" (-__builtin_nanl("")) : "st");
+    if (res_64 != INT64_MIN) {
+        printf("FAIL: fisttpll -nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (ld_invalid_1.ld) :
+                      "st");
+    if (res_64 != INT64_MIN) {
+        printf("FAIL: fisttpll invalid\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

