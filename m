Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A2C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13212064A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13212064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWUhR-00041i-Qu
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 20:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUgO-00030M-W4
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:46:37 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:28734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUgN-0008Qd-Td
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:46:36 -0400
IronPort-SDR: ZxyQrGsU5nH7qRNuFKktqrairlk72hQhOKe4tUth7/B4h1cBexY9D004llfm9cJC1g2bs4Arg7
 NzVK5bj6d5d3BrQInnBohJXHONZMZ2IyJPlMMoV9JuS/YIANAqIUaCgBI5wR197BJCjNs1Bpew
 vvhH2bOmzPzU0LBU4wJ8GN61uJjmD5biF+3JHq708PHWa/UTZVzuf/7hkodneUKlVxhbPRMYaw
 AqFgf+wE37SUcbW5AlKU6HS3cMBjrDyFzEBgtjnl2900grxd17f+2qd8zieHwshiKlak1A/K7w
 uIo=
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; d="scan'208";a="50620999"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa1.mentor.iphmx.com with ESMTP; 06 May 2020 16:46:32 -0800
IronPort-SDR: 9ELJo0XDSiuZvCWlVruAvRGDMC4MyDWnEtY7Ba4zLZ0xdyHnIfm34qFJn+xp9Al5Z9R1lA3n2E
 7C6VRlxMijSJhkjXaP6Ylr11hckbxdi+zvgdO2ZvP/MQxfMREQ11hpoKf4GWC5oNBeHPsg9DyD
 By8Mx+gC968EurwQNsFuIVL86DQzuJ21Jnk0UPn17c5dm3nhNztKKe1adSxfVEaldOndsOS7gO
 MpT1bWpHTrS0CAoAkC1VfBLqdZyOBR63oLg04Ka2CnqfnLHXaJdRrAhr0ggFrrWpzDd+iSFzF8
 txE=
Date: Thu, 7 May 2020 00:46:28 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 5/5] target/i386: fix fscale handling of rounding precision
In-Reply-To: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005070045430.18350@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 20:46:34
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

The fscale implementation uses floatx80_scalbn for the final scaling
operation.  floatx80_scalbn ends up rounding the result using the
dynamic rounding precision configured for the FPU.  But only a limited
set of x87 floating-point instructions are supposed to respect the
dynamic rounding precision, and fscale is not in that set.  Fix the
implementation to save and restore the rounding precision around the
call to floatx80_scalbn.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c          |  3 +++
 tests/tcg/i386/test-i386-fscale.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index d4c15728e1..0c3fce933c 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1001,7 +1001,10 @@ void helper_fscale(CPUX86State *env)
         }
     } else {
         int n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
+        signed char save = env->fp_status.floatx80_rounding_precision;
+        env->fp_status.floatx80_rounding_precision = 80;
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
+        env->fp_status.floatx80_rounding_precision = save;
     }
 }
 
diff --git a/tests/tcg/i386/test-i386-fscale.c b/tests/tcg/i386/test-i386-fscale.c
index b953e7c563..d23b3cfeec 100644
--- a/tests/tcg/i386/test-i386-fscale.c
+++ b/tests/tcg/i386/test-i386-fscale.c
@@ -8,6 +8,8 @@ union u {
     long double ld;
 };
 
+volatile long double ld_third = 1.0L / 3.0L;
+volatile long double ld_four_thirds = 4.0L / 3.0L;
 volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
 volatile union u ld_invalid_2 = { .s = { 0, 1234 } };
 volatile union u ld_invalid_3 = { .s = { 0, 0x7fff } };
@@ -91,5 +93,16 @@ int main(void)
         printf("FAIL: fscale finite down inf\n");
         ret = 1;
     }
+    /* Set round-to-nearest with single-precision rounding.  */
+    cw = cw & ~0xf00;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (ld_third), "u" (2.0L));
+    cw = cw | 0x300;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    if (ld_res != ld_four_thirds) {
+        printf("FAIL: fscale single-precision\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

