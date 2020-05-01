Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C01C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49010208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49010208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUcoV-00011j-DA
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 17:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUcn6-0000B3-LN
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUcn5-00083c-5K
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:01:47 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:30978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUcn4-00080j-CZ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:01:46 -0400
IronPort-SDR: 04s/GsWxUiZvJ3CrA6iy18EQPiZmuDQx2Nb8o/FnstpmaHzL+hPpnRNgbok20P7fz2zS6YtRtp
 LXpGmVzhVu8lfhS293FSHZw4hssKJRxCrDdfHWubbCJGBp199GlSSkTSbHiGWJadAbIXh2XlSM
 K50YMnBZOxTkSWHz/zL7CGHZO0DBE+SaPDUwT7wDKvIj9kLr3ZhTRQIu6Q9BhAO3T/C7mryWtr
 ZMrglX5u0F+nXPNAIhvK1F9jv5/jpkMAWifqFpytrJYIp9u+5Y/NkCfy9xpCsMVbHG7rUrC5Kr
 yO4=
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; d="scan'208";a="50452113"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 01 May 2020 13:01:43 -0800
IronPort-SDR: 97nCcGhWd+6LdvBBN+e5F5t7tbE4XzmEzbGtN6J/uWCUJuGyAeaF47v1OeIt3hN2GGHkA96HS9
 KE0Cv4NFaqBPcTI/R7y5Jo0lJ/l5uQi4ux6CB1dnKCoc4IcWMZb0W69fGVUBD3TF0T2io3MFNt
 6yxsUhF5pZNh0MSpC0Fn7xU+6V2imPLXxJ8IRHydIq5i/39R6uQR9LATlfZgyKF72NDeaIGDdm
 x1CrE8tCtBu4tWPX4rRxhQp4ZnWqNGnNeqz8N1CsWtUCPHquIJtc9D4OKaoohKcEHm5mehU8Il
 s+E=
Date: Fri, 1 May 2020 21:01:37 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/4] softfloat: fix floatx80 pseudo-denormal
 comparisons
In-Reply-To: <87a72rih9x.fsf@linaro.org>
Message-ID: <alpine.DEB.2.21.2005012046280.26026@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005010038260.30535@digraph.polyomino.org.uk>
 <87d07niidw.fsf@linaro.org>
 <alpine.DEB.2.21.2005011911420.26026@digraph.polyomino.org.uk>
 <87a72rih9x.fsf@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1152306461-208732417-1588366897=:26026"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 15:12:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 68.232.129.153
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1152306461-208732417-1588366897=:26026
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

On Fri, 1 May 2020, Alex Bennée wrote:

> OK - so these only turn up in i386?

Patch 1, silencing sNaN, is about generic semantics of IEEE floating-point 
conversions (which are implemented correctly in various other cases in 
QEMU), and would be equally applicable to m68k (I believe, without having 
m68k hardware to test).

Patches 2 and 3 are i386-specific (just like everything in the existing 
softfloat code relating to floatx80 subnormals), because m68k interprets 
biased exponent zero differently.

Patch 4 would apply equally to m68k, because all that matters there is 
that a certain representation is a small nonzero value, not exactly what 
value it is.

None of these apply to any other architectures supported by QEMU.

> We have two tests currently (float_convs and float_madds) which
> currently exercise the various combinations of limits and NaN types
> using some common float_helpers.c support. Maybe extend it for have a
> table of the various ext80 types and write a i386 only test case to
> exercise the functions you fixed?

It seems to me that appropriate tests would be entirely i386-specific (in 
tests/tcg/i386?).  How are such tests supposed to signal success or 
failure, since all the tests currently there seem to exit with status 0 
unconditionally?

I do have a test I'm using to check these fixes (in C code for convenience 
of implementation, with only a little inline asm), but it's not suitable 
for inclusion as-is, since it includes many tests that currently fail 
(e.g. for exceptions generated, since the i386 floating-point support in 
QEMU currently discards exceptions from the softfloat code; one of the 
things I intend to fix but haven't yet).  It also doesn't yet cover all 
the problems I think I've found so far in the floating-point support in 
the i386 port (at least ten such bugs beyond the ones fixed in the present 
patch series).  And it might well depend on details of compiler code 
generation to test some of the bugs effectively.

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-208732417-1588366897=:26026--

