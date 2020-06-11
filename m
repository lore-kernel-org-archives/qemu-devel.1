Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB0DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798D1206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwgtY0E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798D1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTZp-00011X-MV
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8w-0007vm-6I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8r-00011i-1o
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/wjUl3m9r8YPv43a4ONQjZjOlKS4ioJdW6M+fE0u9c=;
 b=YwgtY0E98ouV9J526lj9yN5rlRCi7K7rkbv53glSHCuuNt/0BShk5xpdu5ZhXLmXGssPlp
 jPjAi/M3XutFw0EwbjXccRP+WaSOvawX4gE6w2N4CLxejwLeWQXWVmEwMMcT+VyiP231Cm
 4gPHCoTLujQPonydUhUagVHTputl9Og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-RvBDhcJTOM26uZFVRVuLfw-1; Thu, 11 Jun 2020 15:45:33 -0400
X-MC-Unique: RvBDhcJTOM26uZFVRVuLfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F030F100A8E8;
 Thu, 11 Jun 2020 19:45:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76010707C6;
 Thu, 11 Jun 2020 19:45:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 051/115] target/i386: implement special cases for fxtract
Date: Thu, 11 Jun 2020 15:43:45 -0400
Message-Id: <20200611194449.31468-52-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The implementation of the fxtract instruction treats all nonzero
operands as normal numbers, so yielding incorrect results for invalid
formats, infinities, NaNs and subnormal and pseudo-denormal operands.
Implement appropriate handling of all those cases.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <alpine.DEB.2.21.2005070042360.18350@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c           |  25 +++++-
 tests/tcg/i386/test-i386-fxtract.c | 120 +++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/i386/test-i386-fxtract.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index b34fa784eb..568bd3b359 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -767,10 +767,33 @@ void helper_fxtract(CPUX86State *env)
                            &env->fp_status);
         fpush(env);
         ST0 = temp.d;
+    } else if (floatx80_invalid_encoding(ST0)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST0 = floatx80_default_nan(&env->fp_status);
+        fpush(env);
+        ST0 = ST1;
+    } else if (floatx80_is_any_nan(ST0)) {
+        if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+            float_raise(float_flag_invalid, &env->fp_status);
+            ST0 = floatx80_silence_nan(ST0, &env->fp_status);
+        }
+        fpush(env);
+        ST0 = ST1;
+    } else if (floatx80_is_infinity(ST0)) {
+        fpush(env);
+        ST0 = ST1;
+        ST1 = floatx80_infinity;
     } else {
         int expdif;
 
-        expdif = EXPD(temp) - EXPBIAS;
+        if (EXPD(temp) == 0) {
+            int shift = clz64(temp.l.lower);
+            temp.l.lower <<= shift;
+            expdif = 1 - EXPBIAS - shift;
+            float_raise(float_flag_input_denormal, &env->fp_status);
+        } else {
+            expdif = EXPD(temp) - EXPBIAS;
+        }
         /* DP exponent bias */
         ST0 = int32_to_floatx80(expdif, &env->fp_status);
         fpush(env);
diff --git a/tests/tcg/i386/test-i386-fxtract.c b/tests/tcg/i386/test-i386-fxtract.c
new file mode 100644
index 0000000000..64fd93d333
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fxtract.c
@@ -0,0 +1,120 @@
+/* Test fxtract instruction.  */
+
+#include <stdint.h>
+#include <stdio.h>
+
+union u {
+    struct { uint64_t sig; uint16_t sign_exp; } s;
+    long double ld;
+};
+
+volatile union u ld_pseudo_m16382 = { .s = { UINT64_C(1) << 63, 0 } };
+volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
+volatile union u ld_invalid_2 = { .s = { 0, 1234 } };
+volatile union u ld_invalid_3 = { .s = { 0, 0x7fff } };
+volatile union u ld_invalid_4 = { .s = { (UINT64_C(1) << 63) - 1, 0x7fff } };
+
+volatile long double ld_sig, ld_exp;
+
+int isnan_ld(long double x)
+{
+  union u tmp = { .ld = x };
+  return ((tmp.s.sign_exp & 0x7fff) == 0x7fff &&
+          (tmp.s.sig >> 63) != 0 &&
+          (tmp.s.sig << 1) != 0);
+}
+
+int issignaling_ld(long double x)
+{
+    union u tmp = { .ld = x };
+    return isnan_ld(x) && (tmp.s.sig & UINT64_C(0x4000000000000000)) == 0;
+}
+
+int main(void)
+{
+    int ret = 0;
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) : "0" (2.5L));
+    if (ld_sig != 1.25L || ld_exp != 1.0L) {
+        printf("FAIL: fxtract 2.5\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) : "0" (0.0L));
+    if (ld_sig != 0.0L || __builtin_copysignl(1.0L, ld_sig) != 1.0L ||
+        ld_exp != -__builtin_infl()) {
+        printf("FAIL: fxtract 0.0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) : "0" (-0.0L));
+    if (ld_sig != -0.0L || __builtin_copysignl(1.0L, ld_sig) != -1.0L ||
+        ld_exp != -__builtin_infl()) {
+        printf("FAIL: fxtract -0.0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (__builtin_infl()));
+    if (ld_sig != __builtin_infl() || ld_exp != __builtin_infl()) {
+        printf("FAIL: fxtract inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (-__builtin_infl()));
+    if (ld_sig != -__builtin_infl() || ld_exp != __builtin_infl()) {
+        printf("FAIL: fxtract -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (__builtin_nanl("")));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract qnan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (__builtin_nansl("")));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (0x1p-16445L));
+    if (ld_sig != 1.0L || ld_exp != -16445.0L) {
+        printf("FAIL: fxtract subnormal\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_pseudo_m16382.ld));
+    if (ld_sig != 1.0L || ld_exp != -16382.0L) {
+        printf("FAIL: fxtract pseudo\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_invalid_1.ld));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract invalid 1\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_invalid_2.ld));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract invalid 2\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_invalid_3.ld));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract invalid 3\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_invalid_4.ld));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract invalid 4\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.26.2



