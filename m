Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F61C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F04206EB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F04206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkrF-0008OQ-6y
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkhK-0005W6-PA
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:40:30 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:56982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkhJ-00051P-26
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:40:30 -0400
IronPort-SDR: k+6E3kast7bqw+SHecXMvVr4wWD4b4dJI6r8/fhKPYPn2KgziKNNdUwTZHfm5E27g9ZbiRZPBR
 jUPkPdqqCKBsEvBQ6gXNym/GNmdBRvCfnFVwxoKnbWFvJTHbA4eup0Dw2fQ44E5pzI2xyc1BpC
 sL7N4I60gOj854FghIL2QFIGjeeyAdKNQLnhv1bqgGwSlKs2ctAM1uNI75XrXG8Daw1G9Fxwn3
 rhp9DTDjWFWu4GeXYJegHazWfNM7i8OdeAz/P3byY+nFoHFau/WcJ1mERUeuGDJPDkWqLuRPFx
 0VY=
X-IronPort-AV: E=Sophos;i="5.73,353,1583222400"; d="scan'208";a="48455809"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 04 May 2020 15:40:26 -0800
IronPort-SDR: oitUw0oqvz3OL0p7M1vIxWB6mSbIRwBsAJAB0o7C2Bxy0+564SwnyqImluokHjYAuieeDIcWZR
 G/CyBsU5FJ9F83v6yKTJ0suZYh/LnASLaMzhRfVDfaj0qhD+3j5X/kHMpw7IgTaWwJ6BQwifwt
 cYCtnhbU78nzWdb6QGte/gW92AlN13Z+nWcJaNUwa1eixlrEdvsgtvFX3+3cwKkpnmQsCcscV4
 gWR+7pdKUFgeUL17HtKcFup9BDB457a6tBNZODNtON/BgFY6DHeuBAqpHno8buZWHHxQV15dCB
 xQI=
Date: Mon, 4 May 2020 23:40:20 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <pbonzini@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 4/4] softfloat: fix floatx80 pseudo-denormal round to
 integer
In-Reply-To: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005042339420.22972@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:40:26
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

The softfloat function floatx80_round_to_int incorrectly handles the
case of a pseudo-denormal where only the high bit of the significand
is set, ignoring that bit (treating the number as an exact zero)
rather than treating the number as an alternative representation of
+/- 2^-16382 (which may round to +/- 1 depending on the rounding mode)
as hardware does.  Fix this check (simplifying the code in the
process).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c                            |  2 +-
 tests/tcg/i386/test-i386-pseudo-denormal.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8e9c714e6f..e29b07542a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5741,7 +5741,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
     }
     if ( aExp < 0x3FFF ) {
         if (    ( aExp == 0 )
-             && ( (uint64_t) ( extractFloatx80Frac( a )<<1 ) == 0 ) ) {
+             && ( (uint64_t) ( extractFloatx80Frac( a ) ) == 0 ) ) {
             return a;
         }
         status->float_exception_flags |= float_flag_inexact;
diff --git a/tests/tcg/i386/test-i386-pseudo-denormal.c b/tests/tcg/i386/test-i386-pseudo-denormal.c
index acf2b9cf03..00d510cf4a 100644
--- a/tests/tcg/i386/test-i386-pseudo-denormal.c
+++ b/tests/tcg/i386/test-i386-pseudo-denormal.c
@@ -14,6 +14,7 @@ volatile long double ld_res;
 
 int main(void)
 {
+    short cw;
     int ret = 0;
     ld_res = ld_pseudo_m16382.ld + ld_pseudo_m16382.ld;
     if (ld_res != 0x1p-16381L) {
@@ -24,5 +25,14 @@ int main(void)
         printf("FAIL: pseudo-denormal compare\n");
         ret = 1;
     }
+    /* Set round-upward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x800;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ ("frndint" : "=t" (ld_res) : "0" (ld_pseudo_m16382.ld));
+    if (ld_res != 1.0L) {
+        printf("FAIL: pseudo-denormal round-to-integer\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

