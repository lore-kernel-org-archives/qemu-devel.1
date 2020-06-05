Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A35AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F2E2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F2E2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHd9-0003bC-Fz
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHah-0000bV-N0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:01:19 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:23551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHag-000729-Pu
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:01:19 -0400
IronPort-SDR: uPSgdjfJa3fpg19bSgr+RqtmTA049hT6mrsqZymQcNC1PEh1e8LjSeL9qwgHW7i9/+AQpN00Hn
 SQODUeM7dWyNNfv9dObuYivym5qQZ84fyYfyyxMiCRf8sj5BxlG135zmIUScGfkbwOuALtt6sL
 OeiNzFYTZcV3uQ6KGipVfg3fu4EwNsE6u3Baon29V428iecO9Ly1uGzhnKTQjPFSoo0TC0ui/S
 K/72k5mmUhP8FT1xtkLLBVKWSOPFRiyFQuicyzML4/ikOOXA5f5bd4YYN4sa5LRuYZgOWn7bK1
 F7w=
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; d="scan'208";a="49520911"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 05 Jun 2020 11:01:17 -0800
IronPort-SDR: 99dz4Wo0vMUORJRAmZtBPNIOs5uRQgmGzcFa0BH0PO+UsxDMgqL+t+wD0MP6y54bNZ/xawLmjy
 Po16B4domtLXgPvcTfM9wBiEc2JrEyzi9B/vwhsNCn6kucz31GNz6yIuH7DIrz8wL2yuC4/pWw
 q1aU4Zy6515AFiNioEekEJQR+cW2UN+4uoVTbkXLl3X6KSQ7XKeZNb8jVAb5ayCNZFZBbsdLp5
 gwiFu42dPVGt3VVb5myN0r9vPvjSSztAYGO4mlp1Ujjn7iNzOW2unD9iW8QAXdt4NgrNMuJFLk
 9vg=
Date: Fri, 5 Jun 2020 19:01:10 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH 4/7] softfloat: do not set denominator high bit for floatx80
 remainder
In-Reply-To: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006051900410.13777@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:58:48
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
---
 fpu/softfloat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 00f362af23..423a815196 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5734,7 +5734,6 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
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

