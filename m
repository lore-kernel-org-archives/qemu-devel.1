Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4929C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EEB206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Cxi1pfTz";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYs4UKBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EEB206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNUie-0007fi-5z
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 01:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1kNUgh-0006xJ-3m; Wed, 30 Sep 2020 01:29:59 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1kNUge-0004ZH-Lp; Wed, 30 Sep 2020 01:29:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id CB905F5E;
 Wed, 30 Sep 2020 01:29:52 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Wed, 30 Sep 2020 01:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=e12hF
 XNNmwPJGZe5khvlN1AXzehk4KonO6r6ohj6wtU=; b=Cxi1pfTzlh9ohjlb5Fhgt
 nKgftiEWynJBRss3pAG22bsgNuBdOsE9kr2MuWXiMnuJz7tFLMoQdRCE4QE2eLDy
 +dkfAX9Kr7gYknWjHKBld3V3Iq0XIMctmFov85cOignhvXDvMBCci0/5sE4V3qv9
 rnYHzUmPfJAgdZDPUu71hWgLQ8FRTbYbHTkCHu6aeETpeviJng5WlrZxY/d0uxJ9
 FtgP14VRAvPAc5kWS7VyOaYUA+YTi2gGj+G/IP5FOpQF99Kishvyc7RsAcuvV5fO
 AHbbmhM/GTinUIbJgooUTH3K0YHXozML6w5AtxPJMeM5GX54EWwIIE4YPubn4SDR
 g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=e12hFXNNmwPJGZe5khvlN1AXzehk4KonO6r6ohj6w
 tU=; b=SYs4UKByEMsEFKsUjwlNxCXYhhp6vXP0MXmSHBOGSlB8EizQARTqjGNZa
 L8UfjpMCi+uEhtSBlJ7xiQ7getXuXt40C01SJRxkkcF0WpF10MNeutRuirj0kWFe
 q1fcRbuYPy3O97U5Q7uy8dyAX9yMNiieTdKy9ttUqgxIZr1qti4WSO+mGGqTWvEX
 eO3s1FrBZBedMTU6JxwyHWCZClkNnpcb5HzWPb4WMM05gapC6QLZ21q4npf6M1+d
 XPMpfxa4zcMxjE0TPxlFkZySNIqXx3AlKceqjGtXQEw4DbbRaGGRF3BjvtxPcv+X
 N9Laly5r5Z75sGcpCh+CY/rlrpQPw==
X-ME-Sender: <xms:zxd0X5fhYDmHo7Wbnvdn7xyPkLrCCCHYB6PRmDWg9Zvara63DlyKfg>
 <xme:zxd0X3PTF6oL8UJcEP_G78DKo4H-Gt3Lqd8TTkOw2SIzuXTwnRK9GMPAKYdxzOlTf
 mttm_CLePNjjsBgdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgdelgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
 grthhtvghrnhepieffteejteeitddtheehheetfeeggfehheeljedvueefhffhjeeufedu
 hfeijeefnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:zxd0XyiygnN6wipZwUL_rL5u15PgogBjL18JGb0S-59EygiDwmN_EA>
 <xmx:zxd0Xy83ecyUxfs0ty78wR16djvX9SiAVLsFPn-50_sdlwAwClY3IA>
 <xmx:zxd0X1t9yNTz-nvoYbJWqcBoAj3HxeUlQ3YUU-NrCbA0A0wppZgJNA>
 <xmx:0Bd0X9J06UkRhIgGG1gJhl6LSJvo2PYTi6d5UrMDN9IZQ0eg2gGF4A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 27DEEE011E; Wed, 30 Sep 2020 01:29:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-382-ge235179-fm-20200928.002-ge2351794
Mime-Version: 1.0
Message-Id: <fd68ae45-da39-44fe-b07f-2510481dbf7f@www.fastmail.com>
In-Reply-To: <4648c188-cacc-c532-857c-f0206f60e109@kaod.org>
References: <20200905212415.760452-1-f4bug@amsat.org>
 <e640309b-b694-e815-d64d-40dd453e52ef@amsat.org>
 <5e27c1f9-6d11-fa62-ba71-0020ce9d595b@kaod.org>
 <07b21d1d-fb5b-efb0-50f2-54a4b86df444@amsat.org>
 <4648c188-cacc-c532-857c-f0206f60e109@kaod.org>
Date: Wed, 30 Sep 2020 14:59:30 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/arm/aspeed: Map the UART5 device unconditionally
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.24; envelope-from=andrew@aj.id.au;
 helo=wout1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 01:29:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Fri, 18 Sep 2020, at 02:33, C=C3=A9dric Le Goater wrote:
> On 9/17/20 6:57 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/16/20 7:51 AM, C=C3=A9dric Le Goater wrote:
> >> On 9/15/20 7:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> ping?
> >>
> >> It's reviewed :=20
> >>
> >>   http://patchwork.ozlabs.org/project/qemu-devel/patch/202009052124=
15.760452-1-f4bug@amsat.org/
> >>
> >=20
> > Yes I know :) This is part of my routine to check if a
> > patch hasn't been confirmed to be queued 1 week after the
> > last review, to ping the maintainer (because some
> > automatically flush patches older than 1month in their
> > mailbox).
>=20
> ooh. That's brutal.
>=20
> >> I will send a PR when I have more patches.
> >=20
> > Ah OK. I didn't know you would keep merging the Aspeed
> > patches. Since this was a single patch, I thought it would
> > go via the usual qemu-arm queue from Peter.
>=20
> sure. It could also. Fine with me. I have only three for the
> moment.=20
>=20
> > No rush, I just wanted to be sure the patch was not lost.
> > Also, once a patch is queued, I understand it is the
> > maintainer responsibility to keep rebasing the patch
> > queued.
>=20
> yes. I know. I have been taking care of Andrew's ADC patches=20
> since 2017 ... cough cough :)

Agh!

