Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184B0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD81D2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD81D2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL4A-0002HI-2L
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL0C-0005EF-LV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:52:00 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:48440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL0A-0000Ns-SJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:51:59 -0400
IronPort-SDR: +gpzItvLEde7rjocXbNPH09Hyu6O8tJ8Axe1VwqSFbzh2KRGJhvDjujCwF3RcwWAhN61xC7At2
 xWHeA6U/rp5ovVkdKpsqHI8naJIwwJP4lHmV3e4P1Az92DIVdHgDfGPMKHWOUJlSfZoytfgKCM
 e4PF53VwaT/8+K8bUQeoboHH4R2tGDb8oPA2VpGvygd/BdLxqQ2k73PkKZDY5RivudS51hXvLt
 WDbjd0yVBII9l/VqgGL4D3hRuFe9UVpprdCTkz/wyJfrTmqcGIYt7+mSBGsRyxA09CpZ9b10Mp
 Ko8=
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="51690148"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 08 Jun 2020 08:51:54 -0800
IronPort-SDR: etHJae5d5YtLJdGzKh6TMmtx3nT3gcr5wyeivUa7cYWPl+tF4qDYgCyd7NQCkOARzmOJ+6ssq0
 6SGIzA0i52iF3gNbQryiGhcxAOT4PXxxg/evT58kDQgvJFVxvLDU1bdR0WK5pko7W7vZbc/3oI
 2F9jrM24K69NjoRBglZZK+vcODnkT/fgjWFsbraBeAkfDW80u2fsoHxcanXia2wsoHBSY8dfVa
 zROxLOfbgiHjY1s2ws1YbFQxyrwkqETfmhgma2gPPrL1iCsXDmzXwCMkTTYkTTlvy7wYrZOBjj
 4Ck=
Date: Mon, 8 Jun 2020 16:51:47 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 6/7] target/i386: reimplement fprem1 using floatx80
 operations
In-Reply-To: <87a71d5wub.fsf@linaro.org>
Message-ID: <alpine.DEB.2.21.2006081648430.23637@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051901480.13777@digraph.polyomino.org.uk>
 <87a71d5wub.fsf@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1152306461-2071938687-1591635107=:23637"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:51:54
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, qemu-devel@nongnu.org,
 laurent@vivier.eu, pbonzini@redhat.com, aurelien@aurel32.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1152306461-2071938687-1591635107=:23637
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

On Mon, 8 Jun 2020, Alex Bennée wrote:

> > +    uint8_t old_flags = save_exception_flags(env);
> 
> Hmm where did this come from:

This series assumes all my other recent x87 fixes (11 such patches in 
three series that aren't yet on master, there's also a single patch for 
pcmpxstrx which is independent of those) are already present.

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-2071938687-1591635107=:23637--

