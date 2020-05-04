Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1852C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EC120705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EC120705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkpJ-0005gU-TO
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkgl-0004qK-ET
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:39:55 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:10580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkgd-0004B2-QH
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:39:53 -0400
IronPort-SDR: m3gDoFHOE7zhNlO4alM3Gug4FpmcatEE09XYUP2NOpEKiOfB/jvh3Z8JIMJBojnckMKH2Z53Km
 1+XXsfZ9ti1JQaHb7rfxzdWvsDuKbMSavUyi3N537r0+Zran838fl7eyu257ehIb8hRhnNt2X4
 X+HbABVpdEeXDvr1NsbjuzSBHxELG5N3it/do9pkAWdxrJIZwcWWaIrLjNcecuOo1GK7YbKIAI
 dZ4LsJArWXS4yeIphJ3u2qIem2duh5OQKJIvJ30cxGhl2YtBOJFhwnxIgBz3J9b/5rAi6ul4m4
 3qM=
X-IronPort-AV: E=Sophos;i="5.73,353,1583222400"; d="scan'208";a="48579981"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 04 May 2020 15:39:46 -0800
IronPort-SDR: o2hG4PvUtA+T6GMgu8uQs4Vqn9bhkL0je1kI4+gPFfZCsMGta42yPkBD//Elogr7lNQ4Y/nyJq
 Y8PA/369hrPhDDZAYyCsepqbxLIAurht7fFW861ZlHmTeVbFv42ncVNkAzInyy+0gtSMqtB5uH
 oH8Tzt6LIQIcuynyKEja9GJ6Bo3J0jAdzTkfiqBRI+ppXCve9DVH6X0I+EW6NMAOsrNxL0bDHq
 f6IDllGfd5SVDUKHTSvGFYSTWLQXJxpKf+fLCL1GwjC11Nnlwo9JpQB52tA8US7P5bqXyW1KEz
 lJQ=
Date: Mon, 4 May 2020 23:39:39 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <pbonzini@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 3/4] softfloat: fix floatx80 pseudo-denormal comparisons
In-Reply-To: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005042338470.22972@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:36:19
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

The softfloat floatx80 comparisons fail to allow for pseudo-denormals,
which should compare equal to corresponding values with biased
exponent 1 rather than 0.  Add an adjustment for that case when
comparing numbers with the same sign.

Note that this fix only changes floatx80_compare_internal, not the
other more specific comparison operations.  That is the only
comparison function for floatx80 used in the i386 port, which is the
only supported port with these pseudo-denormal semantics.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c                            | 5 +++++
 tests/tcg/i386/test-i386-pseudo-denormal.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6094d267b5..8e9c714e6f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7966,6 +7966,11 @@ static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
             return 1 - (2 * aSign);
         }
     } else {
+        /* Normalize pseudo-denormals before comparison.  */
+        if ((a.high & 0x7fff) == 0 && a.low & UINT64_C(0x8000000000000000))
+            ++a.high;
+        if ((b.high & 0x7fff) == 0 && b.low & UINT64_C(0x8000000000000000))
+            ++b.high;
         if (a.low == b.low && a.high == b.high) {
             return float_relation_equal;
         } else {
diff --git a/tests/tcg/i386/test-i386-pseudo-denormal.c b/tests/tcg/i386/test-i386-pseudo-denormal.c
index cfa2a500b0..acf2b9cf03 100644
--- a/tests/tcg/i386/test-i386-pseudo-denormal.c
+++ b/tests/tcg/i386/test-i386-pseudo-denormal.c
@@ -20,5 +20,9 @@ int main(void)
         printf("FAIL: pseudo-denormal add\n");
         ret = 1;
     }
+    if (ld_pseudo_m16382.ld != 0x1p-16382L) {
+        printf("FAIL: pseudo-denormal compare\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

