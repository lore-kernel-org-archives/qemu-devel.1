Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D465720720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="godjkGwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D465720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTip-0001L6-2E
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT90-00082M-Bu
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8x-00016y-Fc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DTxtOc5LdYdP17d4UDiZN2OUZYIKMNt5E0uvZNLm+g=;
 b=godjkGweT2sWc3ak0rBpVyK0QBtdgJK22UByJXTn34oo6XmuImJ4oNAF8tzcq+AkWAJI56
 LVXRqOhTnDQz/k+9MNTN31tjohZCRIw9oSaBaib4vL74nGoKmneZXEFIneDlQ9nv/l/nct
 tKTp91ve1+YKNckcd9duBCWc/NyOMoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-IYNd9nSgOUatmNfMtw6ZlA-1; Thu, 11 Jun 2020 15:45:36 -0400
X-MC-Unique: IYNd9nSgOUatmNfMtw6ZlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0221419057BF;
 Thu, 11 Jun 2020 19:45:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 920938FF7E;
 Thu, 11 Jun 2020 19:45:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 054/115] target/i386: fix fscale handling of infinite exponents
Date: Thu, 11 Jun 2020 15:43:48 -0400
Message-Id: <20200611194449.31468-55-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The fscale implementation passes infinite exponents through to generic
code that rounds the exponent to a 32-bit integer before using
floatx80_scalbn.  In round-to-nearest mode, and ignoring exceptions,
this works in many cases.  But it fails to handle the special cases of
scaling 0 by a +Inf exponent or an infinity by a -Inf exponent, which
should produce a NaN, and because it produces an inexact result for
finite nonzero numbers being scaled, the result is sometimes incorrect
in other rounding modes.  Add appropriate handling of infinite
exponents to produce a NaN or an appropriately signed exact zero or
infinity as a result.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005070045010.18350@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c          | 22 ++++++++++++++++++++++
 tests/tcg/i386/test-i386-fscale.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 10ff90370e..72d1e77eb0 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -977,6 +977,28 @@ void helper_fscale(CPUX86State *env)
             float_raise(float_flag_invalid, &env->fp_status);
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
+    } else if (floatx80_is_infinity(ST1) &&
+               !floatx80_invalid_encoding(ST0) &&
+               !floatx80_is_any_nan(ST0)) {
+        if (floatx80_is_neg(ST1)) {
+            if (floatx80_is_infinity(ST0)) {
+                float_raise(float_flag_invalid, &env->fp_status);
+                ST0 = floatx80_default_nan(&env->fp_status);
+            } else {
+                ST0 = (floatx80_is_neg(ST0) ?
+                       floatx80_chs(floatx80_zero) :
+                       floatx80_zero);
+            }
+        } else {
+            if (floatx80_is_zero(ST0)) {
+                float_raise(float_flag_invalid, &env->fp_status);
+                ST0 = floatx80_default_nan(&env->fp_status);
+            } else {
+                ST0 = (floatx80_is_neg(ST0) ?
+                       floatx80_chs(floatx80_infinity) :
+                       floatx80_infinity);
+            }
+        }
     } else {
         int n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
diff --git a/tests/tcg/i386/test-i386-fscale.c b/tests/tcg/i386/test-i386-fscale.c
index b65a055d0a..b953e7c563 100644
--- a/tests/tcg/i386/test-i386-fscale.c
+++ b/tests/tcg/i386/test-i386-fscale.c
@@ -31,6 +31,7 @@ int issignaling_ld(long double x)
 
 int main(void)
 {
+    short cw;
     int ret = 0;
     __asm__ volatile ("fscale" : "=t" (ld_res) :
                       "0" (2.5L), "u" (__builtin_nansl("")));
@@ -62,5 +63,33 @@ int main(void)
         printf("FAIL: fscale invalid 4\n");
         ret = 1;
     }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (0.0L), "u" (__builtin_infl()));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale 0 up inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (__builtin_infl()), "u" (-__builtin_infl()));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale inf down inf\n");
+        ret = 1;
+    }
+    /* Set round-downward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x400;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (1.0L), "u" (__builtin_infl()));
+    if (ld_res != __builtin_infl()) {
+        printf("FAIL: fscale finite up inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (-1.0L), "u" (-__builtin_infl()));
+    if (ld_res != -0.0L || __builtin_copysignl(1.0L, ld_res) != -1.0L) {
+        printf("FAIL: fscale finite down inf\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.26.2



