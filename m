Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6614BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7100720659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7100720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ1AC-0002Vw-Ak
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ18w-0000XK-Ev
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:50:31 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:33527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ18u-0002Dd-8N
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:50:30 -0400
IronPort-SDR: sr+sogIJb3AScauu8Jvdc5p66eZYbHCT4jQdVYvrmrX0PCZ5XqxkZ+bVabrci/4WoW/3ddtQd8
 +e/eyyOR8kdp2oUfAYkUkGBmOjFeHDjPcCjQcYbXZiWUXGQz+D6LFqjw1obBZatE3P1mG7hKKO
 SO4pT1neqwvTj8IY9HZA5ft0z8zi8d8ptEIZYrHxr0bYA+YeAJe7UHWxsQkfAAhjcjnAuZx5PO
 D67X3+jqpPwuf5japWlVHiGeNfNKp1AdXTYSAz6YKb09PGy80fUOpnw/nxRxAHf6XTZR65iUZC
 Zr8=
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; d="scan'208";a="48881470"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 13 May 2020 15:50:25 -0800
IronPort-SDR: LQAqwsLc4016YQ+jGIoBGs9Ak+1jGZdZcT591EXgne5645yH1WtslJexXN+/EYOvgmF8uOQ4DS
 X8dhfMOtErWLN7jlhcJBkWubO1apbwoydC4IpMNfd/GRfIUz6utAUtU4gdp6Le7TkfTSkmveb7
 TG9VvNPD/Zh4VFCurgtuFqusxRFoEExDQeNh1BiNY9sS5SUzfX39OLiXCwRfEdUaZIKNp00HGc
 B1jQc1smojsgvds7z++WQcIQIFXSktHEKaYkJEYVB0SL9zLTCpD6S2ytx1qTnsm+gDskuyg94Y
 2zg=
Date: Wed, 13 May 2020 23:50:19 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 2/4] target/i386: fix fxam handling of invalid encodings
In-Reply-To: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005132349311.11687@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 19:48:30
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

The fxam implementation does not check for invalid encodings, instead
treating them like NaN or normal numbers depending on the exponent.
Fix it to check that the high bit of the significand is set before
treating an encoding as NaN or normal, thus resulting in correct
handling (all of C0, C2 and C3 cleared) for invalid encodings.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c        |   4 +-
 tests/tcg/i386/test-i386-fxam.c | 143 ++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fxam.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 38968b2ec7..51372c371b 100644
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
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

