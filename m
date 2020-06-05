Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95549C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696212077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696212077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHb5-0000TF-KU
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHZj-0007ng-Oj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:00:19 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:33964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHZi-0006kF-Sc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:00:19 -0400
IronPort-SDR: 9GYcwDgzUE23Zz9Jpn/vvQdCGmbQtwS2G28xA4vme/GAffyb8iKOBIY/oCDOnlOYw54MOqueKd
 sX9+zpWbvN/tjd4ouhXrnOcXF2gKjiZAaXfRrNI2MwSt+fuct1e6TEsPvgVFl0Wcje7b8gJxe1
 co7Ck+V4F9dpryuI8TdKrSVyJKKwKKX6JkctrXEbn/yiq6mPe5Ig/SQylF9l/X7SxfNyVFYdjg
 OSFskJxj8uYEfQf6mKjPJktXTc5EMAubSlU/+Db5kUDwaGbvHnRb4GFe8zYnLfhbRXHiIeVfWg
 ceg=
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; d="scan'208";a="49633038"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 05 Jun 2020 11:00:17 -0800
IronPort-SDR: F/1FruGMO9R7ujubsMTUScSsM8Mx4W2Fh5rWxXLYYxsGY9wrtJq5kU0mA1aJ2JrIGkbkAFNdis
 sOixld8CnN58F1VpLQSeM9EipzExRbuwSgoaoy7IaMOVqyAtZekhdwyQtNi+Nxwk6XfbmT1qDy
 qZ0qx/q6L0cH8RYLyGtd4Eeyx/nBq/XEgl5QshxttGwCsuQ87mf7Y3+iTybqIduvkJ2xYb8GC7
 gZuZ3J0vxk0ZCc04k4jy0V2/36aN6F2iQ/fetXsaVmd5/PP01Gt7xcjYh4UrRKWTNmdbdNjqc7
 bOk=
Date: Fri, 5 Jun 2020 19:00:11 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH 2/7] softfloat: fix floatx80 remainder pseudo-denormal check
 for zero
In-Reply-To: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006051859440.13777@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:59:46
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

The floatx80 remainder implementation ignores the high bit of the
significand when checking whether an operand (numerator) with zero
exponent is zero.  This means it mishandles a pseudo-denormal
representation of 0x1p-16382L by treating it as zero.  Fix this by
checking the whole significand instead.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7b1ce7664f..091847beb9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5726,7 +5726,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         normalizeFloatx80Subnormal( bSig, &bExp, &bSig );
     }
     if ( aExp == 0 ) {
-        if ( (uint64_t) ( aSig0<<1 ) == 0 ) return a;
+        if ( aSig0 == 0 ) return a;
         normalizeFloatx80Subnormal( aSig0, &aExp, &aSig0 );
     }
     bSig |= UINT64_C(0x8000000000000000);
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

