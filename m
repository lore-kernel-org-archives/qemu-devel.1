Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1260AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC972206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLBAGrpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC972206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTbL-0003s3-1g
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT98-00086r-7B
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8z-00018M-Ec
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R33mP9vMfsFFS6scj4tu07aOYyJWL6/9GYRUw28mqtE=;
 b=BLBAGrptxMFJP24Hp4JZWoKIIqedRl2/qnzy/fIOqUgNLoZu7gApl0gHXTHvGygUaDCWGL
 WzB2pqk6wjc0ts2Bp0U5+6Ihn6lsSReZl47f0NT0f4XDBSQgzdV2zGh38dyAFlzxkilkIY
 paf8ovnpWxKENSya2XU1qpr4GLXRnAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-qoMAg_mFOWO0sd4z8b9jgw-1; Thu, 11 Jun 2020 15:45:42 -0400
X-MC-Unique: qoMAg_mFOWO0sd4z8b9jgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4F0B846363;
 Thu, 11 Jun 2020 19:45:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5802F500D3;
 Thu, 11 Jun 2020 19:45:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 064/115] target/i386: fix fisttpl,
 fisttpll handling of out-of-range values
Date: Thu, 11 Jun 2020 15:43:58 -0400
Message-Id: <20200611194449.31468-65-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

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
Message-Id: <alpine.DEB.2.21.2005152119160.3469@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c          |  28 ++++++++-
 tests/tcg/i386/test-i386-fisttp.c | 100 ++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fisttp.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 41f6f391ca..9c93f385b1 100644
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
2.26.2



