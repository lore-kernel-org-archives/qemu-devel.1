Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF79C4363D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 00:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEA32085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 00:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="J62Ju40Y";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a9z1A2GZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEA32085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNmcx-0005NT-Up
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 20:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1kNmbb-0004nZ-0t; Wed, 30 Sep 2020 20:37:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1kNmbX-00029t-RY; Wed, 30 Sep 2020 20:37:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id CA67E5C029D;
 Wed, 30 Sep 2020 20:37:50 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Wed, 30 Sep 2020 20:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=ad9oT
 Yf42CSXnIkb9wrddznbrkkOlVdD1dWDk0wFhpE=; b=J62Ju40YhQo2Q7W2lWuDG
 9qkO43DEV7XyLxX0NpREMsvzgeBAWI62DZAUtRLFOQ5GJimCCTpK9GEWYs12wFuy
 Fk9gc8I1h3Qyo7jAibV0BKXdgZoxUIe/SVb8MXClSRnmyQ8k3gvPc0SblKCnKAMH
 WRXDckcxAha70qqwOXwzME2MpVXA5tv90z3Ujp07DKcxCJF/b5t2Q9f6i5VYNdeG
 E4U1AWH11Nkmj6as7NgrD1Wqn6roDvvRpId7ZGVgCQH9fHOoDH2M1hR6sSZBm6tq
 A+9U9E4ZJeEl10fd3iuyI5uULBWw080UXG5bxwR6vWos80H6TWjtUIj9NqAq8ln9
 A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=ad9oTYf42CSXnIkb9wrddznbrkkOlVdD1dWDk0wFh
 pE=; b=a9z1A2GZ+YREHnZv3x5IBoGMOWGNvl7dnGnXTYpLNCjMbOVnwho6Y5n08
 rqMBb0QeRlx6YoCckZXAisaZvkUlgh59NWe85GQ01uuDZVldFaEOqL44g8raPM63
 l3/9mEeREX8JinScB4EV8Ha4EhhQimebP5j37DXgHgfAD3ZtjK41ZKbU8VkT7htf
 ss8YrsrhXQXz2tSB3B0Vpt5WJYrVW1+0yvudlR0ZSxmrxDeAghdVVW4YVL7zkqwF
 mw/6T2xUCgObil+ZJ62Iip+8VQvHBtHd5JyHlKq7PWM9vD/ThBredq1gq6CtG7fI
 N8RfbISir447FUSrje/lNk3zY2uZQ==
X-ME-Sender: <xms:3SR1XylP6r_khHCZtsgDx0Fx9SxstFVqGATGjUFt4P9k3I3oBSPmrQ>
 <xme:3SR1X52mpAnMc3B77w-SiJSzYi5ob_h36uThFYeLvIm0GgURxZB32ZBLr-QXK4SdS
 89igLCeSxppkIgBvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdefkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
 grthhtvghrnhepieffteejteeitddtheehheetfeeggfehheeljedvueefhffhjeeufedu
 hfeijeefnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:3SR1XwpX6L4ufYt_HQBztH2XJtyBiVEENNL-AKaZ7Oy8UJ5EgtLpWQ>
 <xmx:3SR1X2l3OzUxT2v4QWl9zjIUw3YMc5o00aY1AHLfS5NQENln4tC_ow>
 <xmx:3SR1Xw3yqXbfBoN7vYqMaiQN9PiTW3OGVPdEVQPQ0uuIS7lRQZr7MQ>
 <xmx:3iR1X9z_n2BftiBlNJnrUJ6v15T8TNlU5e5xAOoqTCFv91KSroEo0Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B2045E0181; Wed, 30 Sep 2020 20:37:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-382-ge235179-fm-20200928.002-ge2351794
Mime-Version: 1.0
Message-Id: <9a77a08e-e931-4ffc-abc8-498e7cfaf802@www.fastmail.com>
In-Reply-To: <c18df4e1-99ad-8f73-378f-db00a8afa262@kaod.org>
References: <20200905212415.760452-1-f4bug@amsat.org>
 <e640309b-b694-e815-d64d-40dd453e52ef@amsat.org>
 <5e27c1f9-6d11-fa62-ba71-0020ce9d595b@kaod.org>
 <07b21d1d-fb5b-efb0-50f2-54a4b86df444@amsat.org>
 <4648c188-cacc-c532-857c-f0206f60e109@kaod.org>
 <fd68ae45-da39-44fe-b07f-2510481dbf7f@www.fastmail.com>
 <c18df4e1-99ad-8f73-378f-db00a8afa262@kaod.org>
Date: Thu, 01 Oct 2020 10:07:29 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/arm/aspeed: Map the UART5 device unconditionally
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.27; envelope-from=andrew@aj.id.au;
 helo=out3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 20:37:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On Wed, 30 Sep 2020, at 19:37, C=C3=A9dric Le Goater wrote:
> On 9/30/20 7:29 AM, Andrew Jeffery wrote:
> >=20
> >=20
> > On Fri, 18 Sep 2020, at 02:33, C=C3=A9dric Le Goater wrote:
> >> On 9/17/20 6:57 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On 9/16/20 7:51 AM, C=C3=A9dric Le Goater wrote:
> >>>> On 9/15/20 7:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> ping?
> >>>>
> >>>> It's reviewed :=20
> >>>>
> >>>>   http://patchwork.ozlabs.org/project/qemu-devel/patch/2020090521=
2415.760452-1-f4bug@amsat.org/
> >>>>
> >>>
> >>> Yes I know :) This is part of my routine to check if a
> >>> patch hasn't been confirmed to be queued 1 week after the
> >>> last review, to ping the maintainer (because some
> >>> automatically flush patches older than 1month in their
> >>> mailbox).
> >>
> >> ooh. That's brutal.
> >>
> >>>> I will send a PR when I have more patches.
> >>>
> >>> Ah OK. I didn't know you would keep merging the Aspeed
> >>> patches. Since this was a single patch, I thought it would
> >>> go via the usual qemu-arm queue from Peter.
> >>
> >> sure. It could also. Fine with me. I have only three for the
> >> moment.=20
> >>
> >>> No rush, I just wanted to be sure the patch was not lost.
> >>> Also, once a patch is queued, I understand it is the
> >>> maintainer responsibility to keep rebasing the patch
> >>> queued.
> >>
> >> yes. I know. I have been taking care of Andrew's ADC patches=20
> >> since 2017 ... cough cough :)
> >=20
> > Agh!
>=20
> Does that mean "I will work on it !" ? :)

I'll see what I can do, I've recently started to rearrange my task queue=
.

Andrew

