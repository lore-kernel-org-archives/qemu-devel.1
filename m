Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AEBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BEF20720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/kNrv1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BEF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTom-0003MB-K4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT92-00086h-UR
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8z-00018D-7i
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fc5C2D8Qy2Ifc39GMfOK5qBTqHLI5bHmpAMB0Ujy/Lk=;
 b=B/kNrv1qN3Mh2rltT1RqWBhWl0vIFTRjjI151bqZuGUBFBSbT5tCUJh2yB4r91ZdhK056f
 myVna3pnUiXUtorH8j5pD1RReI6Ud4UuKiYNduv9ZavhEEqI8BQUbhTVOAN/Vl9AWFxVuA
 tbS/2PLfnCIGcu6cv+T1TMdjZ/amgZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-nI6nhJbQOjut-Qr7L6Todg-1; Thu, 11 Jun 2020 15:45:42 -0400
X-MC-Unique: nI6nhJbQOjut-Qr7L6Todg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2744819067F2;
 Thu, 11 Jun 2020 19:45:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD8C662502;
 Thu, 11 Jun 2020 19:45:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 063/115] target/i386: fix fbstp handling of out-of-range values
Date: Thu, 11 Jun 2020 15:43:57 -0400
Message-Id: <20200611194449.31468-64-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

The fbstp implementation fails to check for out-of-range and invalid
values, instead just taking the result of conversion to int64_t and
storing its sign and low 18 decimal digits.  Fix this by checking for
an out-of-range result (invalid conversions always result in INT64_MAX
or INT64_MIN from the softfloat code, which are large enough to be
considered as out-of-range by this code) and storing the packed BCD
indefinite encoding in that case.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005132351110.11687@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c         |  10 +++
 tests/tcg/i386/test-i386-fbstp.c | 115 +++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index f0a57099ca..41f6f391ca 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -732,6 +732,16 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
 
     val = floatx80_to_int64(ST0, &env->fp_status);
     mem_ref = ptr;
+    if (val >= 1000000000000000000LL || val <= -1000000000000000000LL) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        while (mem_ref < ptr + 7) {
+            cpu_stb_data_ra(env, mem_ref++, 0, GETPC());
+        }
+        cpu_stb_data_ra(env, mem_ref++, 0xc0, GETPC());
+        cpu_stb_data_ra(env, mem_ref++, 0xff, GETPC());
+        cpu_stb_data_ra(env, mem_ref++, 0xff, GETPC());
+        return;
+    }
     mem_end = mem_ref + 9;
     if (SIGND(temp)) {
         cpu_stb_data_ra(env, mem_end, 0x80, GETPC());
diff --git a/tests/tcg/i386/test-i386-fbstp.c b/tests/tcg/i386/test-i386-fbstp.c
index d368949188..73bf56b9dc 100644
--- a/tests/tcg/i386/test-i386-fbstp.c
+++ b/tests/tcg/i386/test-i386-fbstp.c
@@ -1,8 +1,19 @@
 /* Test fbstp instruction.  */
 
+#include <stdint.h>
 #include <stdio.h>
 #include <string.h>
 
+union u {
+    struct { uint64_t sig; uint16_t sign_exp; } s;
+    long double ld;
+};
+
+volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
+volatile union u ld_invalid_2 = { .s = { 0, 1234 } };
+volatile union u ld_invalid_3 = { .s = { 0, 0x7fff } };
+volatile union u ld_invalid_4 = { .s = { (UINT64_C(1) << 63) - 1, 0x7fff } };
+
 int main(void)
 {
     int ret = 0;
@@ -21,5 +32,109 @@ int main(void)
         printf("FAIL: fbstp -0.1\n");
         ret = 1;
     }
+    memset(out, 0x1f, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-987654321987654321.0L) :
+                      "st");
+    out[9] &= 0x80;
+    if (memcmp(out, "\x21\x43\x65\x87\x19\x32\x54\x76\x98\x80",
+               sizeof out) != 0) {
+        printf("FAIL: fbstp -987654321987654321\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (999999999999999999.5L) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp 999999999999999999.5\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (1000000000000000000.0L) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp 1000000000000000000\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (1e30L) : "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp 1e30\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-999999999999999999.5L) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp -999999999999999999.5\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-1000000000000000000.0L) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp -1000000000000000000\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-1e30L) : "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp -1e30\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (__builtin_infl()) : "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp inf\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-__builtin_infl()) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp -inf\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (__builtin_nanl("")) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp nan\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-__builtin_nanl("")) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp -nan\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (ld_invalid_1.ld) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp invalid 1\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (ld_invalid_2.ld) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp invalid 2\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (ld_invalid_3.ld) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp invalid 3\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (ld_invalid_4.ld) :
+                      "st");
+    if (memcmp(out, "\0\0\0\0\0\0\0\xc0\xff\xff", sizeof out) != 0) {
+        printf("FAIL: fbstp invalid 4\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.26.2



