Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62091C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3849B20716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3849B20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjqr-0002qG-Dl
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jnjpe-0001WH-Iz
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:26 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:60851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jnjpb-0007aq-Td
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:25 -0400
IronPort-SDR: 5xmajyuyqrPbgublXoOIHyCtGZjaH6F74B7akDKzdwS7qTS0f8T/o5qk6O9vdlWjJwn8UzFHj9
 FHvAHiAloPCE+/2hTIids4BoJpafY+gWVl1fy9Z271mrEDzY1yxRhKXTx88ugID4jYlY7f3HhF
 qNSoLuZlnp/iZIWadTx5Hcil5lQj+63bycFg3gm9WOOPFCGG7GK6MWHHQAqfuEu6MzHBTkN4eu
 FeSrzeUkswGVNfAXlYyxL1+v9ozHA83JB0iaw5skkLKZJKesgt4Z5FQezK2qeOOIVDWrF2eF2d
 +YI=
X-IronPort-AV: E=Sophos;i="5.75,271,1589270400"; d="scan'208";a="50107502"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 23 Jun 2020 06:23:19 -0800
IronPort-SDR: kDr2EH9WOgEifl5qHVCAXVCt0y8W81U/nTIxi3z8/+2g+EkpYKWjSoBLRGN4hO159Gj81ESI7T
 603kQ2f6tfa7kFq34Vzfrn0TYn2Zuy4YzTwN53ea+4uEh4YJ8sqfhADH2tNxs6Qq7xO1Myswvx
 uJHArJD+iiMh7I8d2hVVQnd2GQR82aas4B0iMHfIGL11wBidqtgeJMUlhuxzklgRgCIvXgLfbc
 P+Aqs+IYLNqQH0JBCuUWiFIa34RExBYQfD7sWpMLMldRsZrx51fBvSAe2whgs5djcaBG4U71nC
 Ydk=
Date: Tue, 23 Jun 2020 14:23:13 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] target/i386: reimplement fpatan using floatx80
 operations
In-Reply-To: <27588539-95cc-f10f-b8c2-c263b56c921a@redhat.com>
Message-ID: <alpine.DEB.2.21.2006231411570.29757@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006230000340.24721@digraph.polyomino.org.uk>
 <27588539-95cc-f10f-b8c2-c263b56c921a@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:23:19
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020, Paolo Bonzini wrote:

> On 23/06/20 02:01, Joseph Myers wrote:
> > The x87 fpatan emulation is currently based around conversion to
> > double.  This is inherently unsuitable for a good emulation of any
> > floatx80 operation.  Reimplement using the soft-float operations, as
> > for other such instructions.
> > 
> > Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> 
> Queued, thanks.
> 
> Just one question: do recent processors still use the same CORDIC
> approximations as the 8087, and if so would it be better or simpler to
> do that instead of using a good implementation such as this one?

I don't know what approximations the processors use, but they're 
definitely different for at least some instructions between Intel and AMD 
processors (as shown by glibc test ulps baselines created on one processor 
sometimes needing increasing to work on other processors; avoiding test 
problems means the emulation needs to be at least as accurate as 
hardware).  (Whereas the AVX-512 approximation instructions have reference 
implementations for their exact semantics.)

-- 
Joseph S. Myers
joseph@codesourcery.com

