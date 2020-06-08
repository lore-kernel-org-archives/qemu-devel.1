Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A110C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B86E2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B86E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL8i-0000Wf-5r
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL4z-00043B-1S
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:56:57 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:45679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL4x-0001Os-1o
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:56:56 -0400
IronPort-SDR: r2mWtAkwymmgt6cyHei4YDntnWQx26ProPtKOCoULTAjkhxKvZ1q60A7Cv062uvwUGdEcPDYrB
 jbXGkAzfm8XG+whRUMzzmybNmPxdV8ZUHvkUvyT3PFxtvP53hsuIMhbdZNOjySk9MipSV03fwS
 sUWmoG2gFms/LFJ+tH444l0NuvLCYoUyo4D3zYVG1cpuEOsPZNp5tywHwzr7NOxEvv82pQvz6X
 ngmEoKm8bAqkBGbgkQqRfW07Ky4eA9AUcXAKob155gHELwquSO4JpNqluvZFGpxuVxgFN1CrHV
 Ers=
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="49617203"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 08 Jun 2020 08:56:53 -0800
IronPort-SDR: VpGolUg+nL79sI7ZVR/jja5Ucoapp4Xzfme8IAxy1jrdJUwWa7a1OHw8TUdpDDy4ouwyr+RBVn
 f4ycK2EvPwTUNnuQTWBB+uNVxjqf6FU/va2ErU1o9Kwk/XxkTL1awuevt80n1paxhbA+bCAZkE
 pvf64vkPaWMhj5QIb6My2OTJszxo1lyb+PEZCOCllnP1cQagXH+6lhInjkYM6YnFXdmpHlP/bn
 2RTrJ9YOZzim4psq7Qo0pIPhcU6BtHqgYQspuI4dK8qDHd8ryjazb4heHuC1enD3vt5ImkXRWj
 los=
Date: Mon, 8 Jun 2020 16:56:47 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 4/6] softfloat: do not set denominator high bit for floatx80
 remainder
In-Reply-To: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006081656220.23637@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:54:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The floatx80 remainder implementation unnecessarily sets the high bit
of bSig explicitly.  By that point in the function, arguments that are
invalid, zero, infinity or NaN have already been handled and
subnormals have been through normalizeFloatx80Subnormal, so the high
bit will already be set.  Remove the unnecessary code.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9d43868e4c..1552241b5e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5736,7 +5736,6 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         if ( aSig0 == 0 ) return a;
         normalizeFloatx80Subnormal( aSig0, &aExp, &aSig0 );
     }
-    bSig |= UINT64_C(0x8000000000000000);
     zSign = aSign;
     expDiff = aExp - bExp;
     aSig1 = 0;
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

