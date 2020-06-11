Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B91C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE2820720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1TtIVR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE2820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTi2-0008OF-Vk
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT91-00083C-28
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8x-000174-MJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1RleRQIoquv/E3/k8PdDFQo2pginmbhyLe5m5S/H8I=;
 b=H1TtIVR+EmG2HVLYOBC6isVE2mPUCI0dF4k2e10xxSvJtXMnVeHPKYTxr8BH+XjiKX/Azz
 mcEaGKedt/9f4S759RFJQEFzXypAb5onLOicP4tpxcz5ItPl2V9/wObeO7vDYU1vvrYBx2
 vTg0898X077NR83XDo88KbhUvbXzRtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-FdaCB6zNO1iajbf3xzfpPQ-1; Thu, 11 Jun 2020 15:45:40 -0400
X-MC-Unique: FdaCB6zNO1iajbf3xzfpPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D326F80B71E;
 Thu, 11 Jun 2020 19:45:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 664132AF4D;
 Thu, 11 Jun 2020 19:45:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 061/115] target/i386: fix fxam handling of invalid encodings
Date: Thu, 11 Jun 2020 15:43:55 -0400
Message-Id: <20200611194449.31468-62-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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

The fxam implementation does not check for invalid encodings, instead
treating them like NaN or normal numbers depending on the exponent.
Fix it to check that the high bit of the significand is set before
treating an encoding as NaN or normal, thus resulting in correct
handling (all of C0, C2 and C3 cleared) for invalid encodings.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005132349311.11687@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c        |   4 +-
 tests/tcg/i386/test-i386-fxam.c | 143 ++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fxam.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index f0b9cb5de8..185493db8e 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1099,7 +1099,7 @@ void helper_fxam_ST0(CPUX86State *env)
     if (expdif == MAXEXPD) {
         if (MANTD(temp) == 0x8000000000000000ULL) {
             env->fpus |= 0x500; /* Infinity */
-        } else {
+        } else if (MANTD(temp) & 0x8000000000000000ULL) {
             env->fpus |= 0x100; /* NaN */
         }
     } else if (expdif == 0) {
@@ -1108,7 +1108,7 @@ void helper_fxam_ST0(CPUX86State *env)
         } else {
             env->fpus |= 0x4400; /* Denormal */
         }
-    } else {
+    } else if (MANTD(temp) & 0x8000000000000000ULL) {
         env->fpus |= 0x400;
     }
 }
diff --git a/tests/tcg/i386/test-i386-fxam.c b/tests/tcg/i386/test-i386-fxam.c
new file mode 100644
index 0000000000..ddd76ca42d
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fxam.c
@@ -0,0 +1,143 @@
+/* Test fxam instruction.  */
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
+volatile union u ld_pseudo_nm16382 = { .s = { UINT64_C(1) << 63, 0x8000 } };
+volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
+volatile union u ld_invalid_2 = { .s = { 0, 1234 } };
+volatile union u ld_invalid_3 = { .s = { 0, 0x7fff } };
+volatile union u ld_invalid_4 = { .s = { (UINT64_C(1) << 63) - 1, 0x7fff } };
+volatile union u ld_invalid_n1 = { .s = { 1, 0x8123 } };
+volatile union u ld_invalid_n2 = { .s = { 0, 0x8123 } };
+volatile union u ld_invalid_n3 = { .s = { 0, 0xffff } };
+volatile union u ld_invalid_n4 = { .s = { (UINT64_C(1) << 63) - 1, 0xffff } };
+
+#define C0 (1 << 8)
+#define C1 (1 << 9)
+#define C2 (1 << 10)
+#define C3 (1 << 14)
+#define FLAGS (C0 | C1 | C2 | C3)
+
+int main(void)
+{
+    short sw;
+    int ret = 0;
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (0.0L));
+    if ((sw & FLAGS) != C3) {
+        printf("FAIL: +0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (-0.0L));
+    if ((sw & FLAGS) != (C3 | C1)) {
+        printf("FAIL: -0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (1.0L));
+    if ((sw & FLAGS) != C2) {
+        printf("FAIL: +normal\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (-1.0L));
+    if ((sw & FLAGS) != (C2 | C1)) {
+        printf("FAIL: -normal\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (__builtin_infl()));
+    if ((sw & FLAGS) != (C2 | C0)) {
+        printf("FAIL: +inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (-__builtin_infl()));
+    if ((sw & FLAGS) != (C2 | C1 | C0)) {
+        printf("FAIL: -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (__builtin_nanl("")));
+    if ((sw & FLAGS) != C0) {
+        printf("FAIL: +nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (-__builtin_nanl("")));
+    if ((sw & FLAGS) != (C1 | C0)) {
+        printf("FAIL: -nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (__builtin_nansl("")));
+    if ((sw & FLAGS) != C0) {
+        printf("FAIL: +snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (-__builtin_nansl("")));
+    if ((sw & FLAGS) != (C1 | C0)) {
+        printf("FAIL: -snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (0x1p-16445L));
+    if ((sw & FLAGS) != (C3 | C2)) {
+        printf("FAIL: +denormal\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (-0x1p-16445L));
+    if ((sw & FLAGS) != (C3 | C2 | C1)) {
+        printf("FAIL: -denormal\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_pseudo_m16382.ld));
+    if ((sw & FLAGS) != (C3 | C2)) {
+        printf("FAIL: +pseudo-denormal\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_pseudo_nm16382.ld));
+    if ((sw & FLAGS) != (C3 | C2 | C1)) {
+        printf("FAIL: -pseudo-denormal\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_invalid_1.ld));
+    if ((sw & FLAGS) != 0) {
+        printf("FAIL: +invalid 1\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_invalid_n1.ld));
+    if ((sw & FLAGS) != C1) {
+        printf("FAIL: -invalid 1\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_invalid_2.ld));
+    if ((sw & FLAGS) != 0) {
+        printf("FAIL: +invalid 2\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_invalid_n2.ld));
+    if ((sw & FLAGS) != C1) {
+        printf("FAIL: -invalid 2\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_invalid_3.ld));
+    if ((sw & FLAGS) != 0) {
+        printf("FAIL: +invalid 3\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_invalid_n3.ld));
+    if ((sw & FLAGS) != C1) {
+        printf("FAIL: -invalid 3\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_invalid_4.ld));
+    if ((sw & FLAGS) != 0) {
+        printf("FAIL: +invalid 4\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxam\nfnstsw" : "=a" (sw) : "t" (ld_invalid_n4.ld));
+    if ((sw & FLAGS) != C1) {
+        printf("FAIL: -invalid 4\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.26.2



