Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C1D2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C1D2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ1Bd-0005De-8q
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ1AF-00031s-N9
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:51:51 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:18313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ1AE-0002aq-E1
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:51:51 -0400
IronPort-SDR: CNbcyX4cbEDzFv5IPZTvzmktUl8MLdhjGyPZ+1wHeMemq7IxKLvQFCZW5+TK/2IK6tWbGB8ako
 3E7RAeUqTzP8xcnxHH8Rb8PgX1uXtGi1EUjOe6uIddT9MZevszkWAMAU+0w2+vVVMcfH+MeQfo
 jnNdspZZdxFQgI/ulZ27RQVc+vm6LgI/8cTGRDARgB/00+No5prL6WH62Og5ewkN5YTn5Iyc5m
 KRMDUWZPCK5dW1wTUqnLes2p4MB/yLCJgb+ERUF66WkkJZYuhVJS4qN/73SzJ7vQ6EQK5yMUs6
 xOw=
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; d="scan'208";a="50854627"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa1.mentor.iphmx.com with ESMTP; 13 May 2020 15:51:48 -0800
IronPort-SDR: D6XNl6saNuL/Xenub0mNfIVTa5boTUOTiIoLVHr+63M5YCHPVcHRLuC9AF6R5EvmWTRXI5omFM
 NB+idXVPgpR6dGuntX3SL7fuR0bt7TcHvU5LgEytp97PoUkb1W3MG5UFAi+WvmB07JzNq8AUmd
 wmpaZNBxhrUlReLIfqOBycsqkWwq8Sl94dz8QoHwaQaY4UoOr8PtaVBtrmiRTnaqg6fnhUoLyS
 9Ve1c+2c3JWcT5CBlg96THHXlSX9VMd74xgtk9Etpig86E57XpgKNxDFruTI1wyG+iA51r5mhT
 gy0=
Date: Wed, 13 May 2020 23:51:42 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 4/4] target/i386: fix fbstp handling of out-of-range values
In-Reply-To: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005132351110.11687@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 19:51:48
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

The fbstp implementation fails to check for out-of-range and invalid
values, instead just taking the result of conversion to int64_t and
storing its sign and low 18 decimal digits.  Fix this by checking for
an out-of-range result (invalid conversions always result in INT64_MAX
or INT64_MIN from the softfloat code, which are large enough to be
considered as out-of-range by this code) and storing the packed BCD
indefinite encoding in that case.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c         |  10 +++
 tests/tcg/i386/test-i386-fbstp.c | 115 +++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index e1872b3fc0..96c512fedf 100644
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
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

