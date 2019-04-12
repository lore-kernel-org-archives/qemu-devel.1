Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52875C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DF62083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="NPnRO1WJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="02d9UTIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DF62083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEmpD-0002jV-Ai
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 23:25:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmoM-0001sV-1G
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmoL-0004V5-6Q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:25:06 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrew@aj.id.au>)
	id 1hEmoD-0004RR-PD; Thu, 11 Apr 2019 23:24:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 68C1221FE5;
	Thu, 11 Apr 2019 23:24:56 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
	by compute4.internal (MEProxy); Thu, 11 Apr 2019 23:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
	mime-version:message-id:in-reply-to:references:date:from:to:cc
	:subject:content-type:content-transfer-encoding; s=fm2; bh=PCNys
	LiKHb8gXJxsYRLbY1zjZ1t3f8jiZOl7tebbhq0=; b=NPnRO1WJU+RUejyXKITAF
	Cr2Feye2tGe05qg70QkDBcg5MP8feKmKtFn9exEFB3DXxCxpoTv7EXwulnmEVAzm
	Y7es5BMlpheTCkY/5j/3xKLIO5f5ea0Rp6svmwKY1Spk8mxSEByi8r/UAK4MBFZc
	IH42d19shMTsVQy41REH9mu8AglIDW1scNsmCSsZpNwna3hTAsrQR6Y6saYlVAs5
	61IfPA9eAMCu0n5/a9gHmk9juf7c5YB4R8+dgQXemyJf4VGFa5fd2rt4fULkKUoW
	uUn1K5/le1OzOXzTId4HCyMwn9chOW3SAos2yGQKWP/lgbjQwFLtPnrB4ag5mo4Z
	w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; bh=PCNysLiKHb8gXJxsYRLbY1zjZ1t3f8jiZOl7tebbh
	q0=; b=02d9UTIgfzGojXk6T8v3NymqGEpHXW60p4l3bQxsy+r8QHOuv3gE8GBo8
	fw31ITSjC7V26h9V8Mi6yyi9pBhCRnZXlF0riwZV5zv4xCcnIiMZok1NcO3pioiW
	ld/PkzVxEPqGtDeYl5MYRkezKfwss1CJFrFpSx/gVJONwFuzeoNXoorU2yKNtTrT
	UrUtdV+0IqExMYjaAdCv2cQYI2i8LqLEvMQ5slUhwqNSh3pXT4Af4WJuxjri25Rb
	6XtWwaGMEwPNKM8JotIGSUPhhCfndmFgc/F4/J9J4zmOa5frW8K1RrwQe2eiv+mW
	iSRqsjUZGqOEMyV61xGNSKU/iyPlA==
X-ME-Sender: <xms:BwWwXLlZOq9GgSimlNOhcZsikVfT1z4wuzpG5GLIHSemh67WSvcDrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrvddtgdeijecutefuodetggdotefrodftvf
	curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
	uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
	fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
	rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
	grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
	rhfuihiivgeptd
X-ME-Proxy: <xmx:BwWwXMNBHon_kB65J70yWjBYPj599iyGxgx7pJ7s3-5wGMC132MfNA>
	<xmx:BwWwXI-pvSMpWOfmvUBJgkfHJXfGfzW15mpIHoQf8oZ1vUA6pKjNQA>
	<xmx:BwWwXOEUrINGJER_ZT-D8gKCmFHmp6Sa12uhmwR4rSy41MS3b1KYDQ>
	<xmx:CAWwXLEuHBaK7yCppythJyVO16s8pq15yien6AqZZ_883AbDR-PGXw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 18D397C132; Thu, 11 Apr 2019 23:24:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <c007d615-4dbf-4525-9fb0-6e4feb28c344@www.fastmail.com>
In-Reply-To: <CACPK8XezRXPFFiiK7_xXLs-ipnfw9400E1dSRHN0XnF2cc4=vA@mail.gmail.com>
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-3-clg@kaod.org>
	<CACPK8XezRXPFFiiK7_xXLs-ipnfw9400E1dSRHN0XnF2cc4=vA@mail.gmail.com>
Date: Thu, 11 Apr 2019 23:24:54 -0400
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Joel Stanley" <joel@jms.id.au>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.28
Subject: Re: [Qemu-devel] [PATCH 2/3] aspeed: add a per SoC mapping for the
 memory space
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412032454.hI77XppjKmJD-JfaeE3VlGfsfx7RBtzjnO3ZaNi64V8@z>



On Fri, 12 Apr 2019, at 11:48, Joel Stanley wrote:
> On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
> >
> > This will simplify the definition of new SoCs, like the AST2600 whic=
h
> > should use a slightly different address space and have a different s=
et
> > of controllers.
> >
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> > diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> > index 5bbd1fb87d18..9b601709e93c 100644
> > --- a/hw/arm/aspeed_soc.c
> > +++ b/hw/arm/aspeed_soc.c
>=20
> > +static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
>=20
> > +static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
>=20
> Most of these arrays is common. And some of it will stay common in the=

> 2600. Any ideas how we could avoid duplication?

I dunno, I feel that any attempt to create some "common" layout concept =
is
more distracting than having soc-specific, complete layouts described.

There's no reason why they're common beyond coincidence (i.e. it's at
ASPEED's whim). I think this is fine.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

>=20
> This is fine for now.
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>

