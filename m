Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748FFC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1CA2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="gci2Rvxx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kVMQ/VrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1CA2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihLmL-0004lt-3k
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 17:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ihLkl-0003YR-Vz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ihLkk-0006Qh-T5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:55:43 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38723)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ihLke-0006Cv-1W; Tue, 17 Dec 2019 17:55:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id CE2E842D;
 Tue, 17 Dec 2019 17:55:32 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Tue, 17 Dec 2019 17:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm1; bh=KcoJQ6orCIk0G2Qck/G/g+pS1XQXN0t
 v4qqhSbQjCv0=; b=gci2Rvxx/RZjmGiyjFXURoSjFHmOIrXbz0bhVqo1t2qj4Fg
 M25NAfO1M8M+ibyL7Ckdv5dhRJHe+cHAsbOLMkxjfhDD1pyqXWc/Nqfp75YI/A+k
 E6naJZjJdUTsrnWj+W1Wkac9WqIV6fP1WW3/+Rs3V4wBDFnnOiwVm+brQB1/eQg0
 OXMod5lEjGJvVDELsyZuGHsceezHN6p9RvKkzsibzP3A/7fOB467dmzJX9RBWBUC
 cXPmkoecfZID1Pss+cyYgdQGJv6Z9poD3kzWhKgp8I3tAd9v/9XGk4ZduNlK6aXw
 poEByApbtM7kGZ0HunPWm/AopsyFdcoc9CF9Iag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KcoJQ6
 orCIk0G2Qck/G/g+pS1XQXN0tv4qqhSbQjCv0=; b=kVMQ/VrKkhKtEf7DFxsMMR
 XoEnQRAt8hgLKvzw3Cx3HjjiTMU5FZDqQjwO5zw9YR76l9n46SPEh0NxhDrBkFXL
 4ALmtvUCTvFZPfri/IjBj9Idd5CNNlMU3OafMPZEVVLvGomcgtUV4LFUFUfRqtFe
 y5/Bc/+s2fuOX78dQ32VEArxqSwDsNkycUfiMlUrz30e/O47t0g/4STFF7sKqafa
 HCoehsYtx/3P/jos6/taABQxeWVvDXDTAcXrY4yOCAAc7iwgZPvuVBHlCy5D+peS
 CIvSh2UiScYWPen9ABS4wonk7Xje836haXgFIFh8i0CKnpFP4x+yZ93miCorAnzA
 ==
X-ME-Sender: <xms:41z5Xc7nij6_XFYfMuQq6cJWJun3W39I4KAOYb_qW7w3Z-DYRis1Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtkedgtdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuffhomh
 grihhnpehoiihlrggsshdrohhrghenucfrrghrrghmpehmrghilhhfrhhomheprghnughr
 vgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:41z5XREXLcECgW_m-eFYXqnCATHRSFh9AkD8tLUzvkapkU55sAYjcA>
 <xmx:41z5XXk08j8rhazqjjJiUqwlkWCIlkrfMuj-Wv0zloU9n3paDsxORw>
 <xmx:41z5XbkRmaXHPSGkhVVBTnXIdo_2Pa_Fll2dJYKWxHDmKFmAEVwScQ>
 <xmx:5Fz5XcibI17uxgWDDiqptZQiQ795FcBFpK0iVVDQ_LM55EWHERV02A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D91FBE00A2; Tue, 17 Dec 2019 17:55:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-689-g5a57b82-fmstable-20191216v1
Mime-Version: 1.0
Message-Id: <a947382d-e630-40b3-b94f-dadf4c76a2c7@www.fastmail.com>
In-Reply-To: <CAFEAcA8BquhddybX8X4gsoTs=r+cwGJ6_ebno1_xPJLVVHhm9g@mail.gmail.com>
References: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
 <CAFEAcA8BquhddybX8X4gsoTs=r+cwGJ6_ebno1_xPJLVVHhm9g@mail.gmail.com>
Date: Wed, 18 Dec 2019 09:27:14 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Peter Maydell" <peter.maydell@linaro.org>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_0/4]_Expose_GT_CNTFRQ_as_a_CPU_property_to_suppo?=
 =?UTF-8?Q?rt_AST2600?=
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.20
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wed, 18 Dec 2019, at 01:55, Peter Maydell wrote:
> On Fri, 13 Dec 2019 at 05:48, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Hello,
> >
> > This is a v3 of the belated follow-up from a few of my earlier attempts to fix
> > up the ARM generic timer for correct behaviour on the ASPEED AST2600 SoC. The
> > AST2600 clocks the generic timer at the rate of HPLL, which is configured to
> > 1125MHz.  This is significantly quicker than the currently hard-coded generic
> > timer rate of 62.5MHz and so we see "sticky" behaviour in the guest.
> >
> > v2 can be found here:
> >
> > https://patchwork.ozlabs.org/cover/1203474/
> >
> > Changes since v2:
> >
> > * Address some minor review comments from Philippe and add tags
> >
> > Changes since v1:
> >
> > * Fix a user mode build failure from partial renaming of gt_cntfrq_period_ns()
> > * Add tags from Cedric and Richard
> >
> > Please review.
> >
> > Andrew
> >
> > Andrew Jeffery (4):
> >   target/arm: Remove redundant scaling of nexttick
> >   target/arm: Abstract the generic timer frequency
> >   target/arm: Prepare generic timer for per-platform CNTFRQ
> >   ast2600: Configure CNTFRQ at 1125MHz
> 
> 
> 
> 
> Applied to target-arm.next, thanks.

Thanks for your feedback throughout.

Andrew

