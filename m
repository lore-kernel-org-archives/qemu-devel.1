Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C320C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4712B206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TObTXdof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTcb-0005sd-ES
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8v-0007uV-3x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8s-00011r-1L
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MiZTuB1jn4OQN9DsLVSeuNz7XUvR6qH6PEUWfjPKZw=;
 b=TObTXdofZ5MKpmiRkQO9PkP3xszFjYMhP6HDIb4f9OVYz6JT1ntj3PmOxdLK7m55+JxIJR
 OVQxXv/g9wwXmENZNVr3pJO3jlWhKaRO5gDGHScAzidT6dmi8V+sSuayKedvDh3evLoR9S
 GJv4+B16HO+JUcXDq5D+MyvUpLWTh70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-YsuNxs3hM4e08-P8UdY26g-1; Thu, 11 Jun 2020 15:45:34 -0400
X-MC-Unique: YsuNxs3hM4e08-P8UdY26g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0153A0C00;
 Thu, 11 Jun 2020 19:45:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 231B8707C6;
 Thu, 11 Jun 2020 19:45:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 052/115] target/i386: fix fscale handling of signaling NaN
Date: Thu, 11 Jun 2020 15:43:46 -0400
Message-Id: <20200611194449.31468-53-pbonzini@redhat.com>
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

The implementation of the fscale instruction returns a NaN exponent
unchanged.  Fix it to return a quiet NaN when the provided exponent is
a signaling NaN.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005070043330.18350@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c          |  4 ++++
 tests/tcg/i386/test-i386-fscale.c | 37 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tests/tcg/i386/test-i386-fscale.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 568bd3b359..0671de6952 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -970,6 +970,10 @@ void helper_fscale(CPUX86State *env)
 {
     if (floatx80_is_any_nan(ST1)) {
         ST0 = ST1;
+        if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+            float_raise(float_flag_invalid, &env->fp_status);
+            ST0 = floatx80_silence_nan(ST0, &env->fp_status);
+        }
     } else {
         int n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
diff --git a/tests/tcg/i386/test-i386-fscale.c b/tests/tcg/i386/test-i386-fscale.c
new file mode 100644
index 0000000000..aecac5125f
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fscale.c
@@ -0,0 +1,37 @@
+/* Test fscale instruction.  */
+
+#include <stdint.h>
+#include <stdio.h>
+
+union u {
+    struct { uint64_t sig; uint16_t sign_exp; } s;
+    long double ld;
+};
+
+volatile long double ld_res;
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
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (2.5L), "u" (__builtin_nansl("")));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale snan\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.26.2



