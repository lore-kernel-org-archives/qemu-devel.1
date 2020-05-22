Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9976C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ABC2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ABC2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbx0J-00049a-N5
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jbwzT-0002Lz-QQ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:00:51 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:54548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jbwzQ-0007T4-LW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:00:50 -0400
IronPort-SDR: QtmrcNG4BAzmwoMnWqhxuxLLEArQQAGDAPl9khtAmNy22TKDvTD9zJH8+sBOCrTdNHCn6q9mmZ
 aqsphdp2mvQr50dOPMHqIfWJX3GMBCk9RXlBuiyb3gL7qleHdaqbeoNjjAjEdTcLxhjVpLMUsu
 nHODC1gcvsr3R4ZxirtnbdulRS+hKV2ubQyRnuMNFNN/zqrDji8wL3YyFebuORJflNC8uD58+L
 PsR3jVdILRQh9LOm6c/uGZsSm18XkfsBa1KBv212C6SZfouSqPc9pxSLN3SYbXrciVbo2s3LcK
 DsQ=
X-IronPort-AV: E=Sophos;i="5.73,420,1583222400"; d="scan'208";a="49161231"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 21 May 2020 18:00:44 -0800
IronPort-SDR: NECrZWnczPBjTmuX6iMeFihDOie6MuHSVG7J/2xw9BDprJ0E6mVeg/7wKel3luALWfJqSZbYZD
 HzV27/40430UGhrnWS3UoOYnB1cFm7zKHAWbRmYwyVP2sNfZG5EA9dC9EBlhbctNtRt4OObuMo
 6hZiNTdzGYTEoewyzICik+EXh3Suof/9P9ticTE77D0AQrWAQughnPzAWmfpCQeEJbj1p+yP/o
 AQ0n/rd2SLr9fdoIAx0oPD+JWi8duHzBrdlE8ZpMvHDN0i++PnllSDS/LWQs9ljakxBfiEbvpn
 y3Q=
Date: Fri, 22 May 2020 02:00:38 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH] target/i386: correct fix for pcmpxstrx substring search
Message-ID: <alpine.DEB.2.21.2005220155280.25609@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 22:00:44
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

This corrects a bug introduced in my previous fix for SSE4.2 pcmpestri
/ pcmpestrm / pcmpistri / pcmpistrm substring search, commit
ae35eea7e4a9f21dd147406dfbcd0c4c6aaf2a60.

That commit fixed a bug that showed up in four GCC tests with one libc
implementation.  The tests in question generate random inputs to the
intrinsics and compare results to a C implementation, but they only
test 1024 possible random inputs, and when the tests use the cases of
those instructions that work with word rather than byte inputs, it's
easy to have problematic cases that show up much less frequently than
that.  Thus, testing with a different libc implementation, and so a
different random number generator, showed up a problem with the
previous patch.

When investigating the previous test failures, I found the description
of these instructions in the Intel manuals (starting from computing a
16x16 or 8x8 set of comparison results) confusing and hard to match up
with the more optimized implementation in QEMU, and referred to AMD
manuals which described the instructions in a different way.  Those
AMD descriptions are very explicit that the whole of the string being
searched for must be found in the other operand, not running off the
end of that operand; they say "If the prototype and the SUT are equal
in length, the two strings must be identical for the comparison to be
TRUE.".  However, that statement is incorrect.

In my previous commit message, I noted:

  The operation in this case is a search for a string (argument d to
  the helper) in another string (argument s to the helper); if a copy
  of d at a particular position would run off the end of s, the
  resulting output bit should be 0 whether or not the strings match in
  the region where they overlap, but the QEMU implementation was
  wrongly comparing only up to the point where s ends and counting it
  as a match if an initial segment of d matched a terminal segment of
  s.  Here, "run off the end of s" means that some byte of d would
  overlap some byte outside of s; thus, if d has zero length, it is
  considered to match everywhere, including after the end of s.

The description "some byte of d would overlap some byte outside of s"
is accurate only when understood to refer to overlapping some byte
*within the 16-byte operand* but at or after the zero terminator; it
is valid to run over the end of s if the end of s is the end of the
16-byte operand.  So the fix in the previous patch for the case of d
being empty was correct, but the other part of that patch was not
correct (as it never allowed partial matches even at the end of the
16-byte operand).  Nor was the code before the previous patch correct
for the case of d nonempty, as it would always have allowed partial
matches at the end of s.

Fix with a partial revert of my previous change, combined with
inserting a check for the special case of s having maximum length to
determine where it is necessary to check for matches.

In the added test, test 1 is for the case of empty strings, which
failed before my 2017 patch, test 2 is for the bug introduced by my
2017 patch and test 3 deals with the case where a match of an initial
segment at the end of the string is not valid when the string ends
before the end of the 16-byte operand (that is, the case that would be
broken by a simple revert of the non-empty-string part of my 2017
patch).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/ops_sse.h                |  4 ++--
 tests/tcg/i386/Makefile.target       |  3 +++
 tests/tcg/i386/test-i386-pcmpistri.c | 33 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-pcmpistri.c

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index ec1ec745d0..f5ede2ca27 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2076,10 +2076,10 @@ static inline unsigned pcmpxstrx(CPUX86State *env, Reg *d, Reg *s,
             res = (2 << upper) - 1;
             break;
         }
-        for (j = valids - validd; j >= 0; j--) {
+        for (j = valids == upper ? valids : valids - validd; j >= 0; j--) {
             res <<= 1;
             v = 1;
-            for (i = validd; i >= 0; i--) {
+            for (i = MIN(valids - j, validd); i >= 0; i--) {
                 v &= (pcmp_val(s, ctrl, i + j) == pcmp_val(d, ctrl, i));
             }
             res |= v;
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 43ee2e181e..de5a3a275f 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -10,6 +10,9 @@ ALL_X86_TESTS=$(I386_SRCS:.c=)
 SKIP_I386_TESTS=test-i386-ssse3
 X86_64_TESTS:=$(filter test-i386-ssse3, $(ALL_X86_TESTS))
 
+test-i386-pcmpistri: CFLAGS += -msse4.2
+test-i386-pcmpistri: QEMU_OPTS += -cpu max
+
 #
 # hello-i386 is a barebones app
 #
diff --git a/tests/tcg/i386/test-i386-pcmpistri.c b/tests/tcg/i386/test-i386-pcmpistri.c
new file mode 100644
index 0000000000..37cb56d669
--- /dev/null
+++ b/tests/tcg/i386/test-i386-pcmpistri.c
@@ -0,0 +1,33 @@
+/* Test pcmpistri instruction.  */
+
+#include <nmmintrin.h>
+#include <stdio.h>
+
+union u {
+    __m128i x;
+    unsigned char uc[16];
+};
+
+union u s0 = { .uc = { 0 } };
+union u s1 = { .uc = "abcdefghijklmnop" };
+union u s2 = { .uc = "bcdefghijklmnopa" };
+union u s3 = { .uc = "bcdefghijklmnab" };
+
+int
+main(void)
+{
+    int ret = 0;
+    if (_mm_cmpistri(s0.x, s0.x, 0x4c) != 15) {
+        printf("FAIL: pcmpistri test 1\n");
+        ret = 1;
+    }
+    if (_mm_cmpistri(s1.x, s2.x, 0x4c) != 15) {
+        printf("FAIL: pcmpistri test 2\n");
+        ret = 1;
+    }
+    if ("%d\n", _mm_cmpistri(s1.x, s3.x, 0x4c) != 16) {
+        printf("FAIL: pcmpistri test 3\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

