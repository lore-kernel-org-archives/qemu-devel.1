Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE183C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 22:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B9E2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 22:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="QmxoGEyJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPXzfeL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B9E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ienmj-0006NS-Jk
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 17:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ienly-0005pU-U7
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 17:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ienlx-0003G0-T4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 17:14:26 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ienlu-0003Ag-Ql; Tue, 10 Dec 2019 17:14:23 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 14F78D72;
 Tue, 10 Dec 2019 17:14:21 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Tue, 10 Dec 2019 17:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=RidXc
 mMmXmc5rXabxPfPVHMgYhwokctJfhox3MmbJIk=; b=QmxoGEyJt3fWmxfpf9F83
 pL9+ggMWdJ6X7BTs5sxBhYCPW5XjAEawTh3Gdqlm/oSZ/hlDV8pmR2k+9KCwaWlz
 nfFtdD1BcYq4gNf1xJqOjmQVTXnascxpD/KWo7yC3djEe2eBSHUpEyL8GaP7RHd9
 lEfnXFfU0bRNV4eJu12ByKtRoxtEowUZnMNXuDLS4d8pZrHSJHLTIvL9CSKvdYfb
 kT+pSnhtga1ZHFDs/+3QSPtJAfZnpXaVODoyiFoWCTZ5/RZ43WOAt0nZe0D8i0BM
 eT3lf9NoSGldV+893czIOsOJBjTStZJiIxRKoL+KCCoBgiBbi+hyZMaakGYXOVeE
 Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=RidXcmMmXmc5rXabxPfPVHMgYhwokctJfhox3MmbJ
 Ik=; b=oPXzfeL+oXtQbZUNZyQmepiqFqajuPhVNCoY1FY7RWM7hFesE+S9qcre6
 jlc41xU+rBXGOtPKS01BcdDtr7Tlt6Wwa4cG0AB10564evtHur+nI4SFVpjN6eC9
 9BtyUui466tz/AErA5INcCRjGRtljnEAEuKb+MI3nUXSPBhpjPowzElODu9VVFNG
 Do1WkW3HuYK0rq2Jm/HqPNcHaNHQSXsrWttFQ8aFir0HKvjLc4uKFR/l2VxBAVHg
 KvFsa7QinRtW08BBF/VACP6fUi7hanfa4lLvQcbdNEiHyHoLp2EiOfeyZe+1YtZQ
 g9Y03TjqruOEtob2nlYYcIYd/VMWg==
X-ME-Sender: <xms:vBjwXTWYXigpnrprP0bMNZYbmj5T3wxULnssdk621rdEVkfYz1jRvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedgudehkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurf
 grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhs
 thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:vBjwXYJTruuIUHh9nbYyreruNcnobBoiqt20lZnb7Ecs8j-u2hhdUQ>
 <xmx:vBjwXT2TviOo3AUk4xUVcBWtL40l1fZRkNW_hySDkm3e2ntuG7y2Sw>
 <xmx:vBjwXVKAHkNtrj7G8iSjGcI8x7mLmIu3GbNqh2sx4KuJ8twd9CldVA>
 <xmx:vBjwXQxeQfQRQyZ2A9hsmcI4HVcobZsvTVmr8-dT6sTzwW0ZJWs88A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 35CDBE00A2; Tue, 10 Dec 2019 17:14:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <dab5c6d3-d3a1-4d44-98d8-1626a8b62bc7@www.fastmail.com>
In-Reply-To: <d1d53a3f-90ed-4436-59ec-fe3fcc985817@kaod.org>
References: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
 <5a93d2f9d375f92e9db6b1cf8687f86beaedcbb2.1575938234.git-series.andrew@aj.id.au>
 <d1d53a3f-90ed-4436-59ec-fe3fcc985817@kaod.org>
Date: Wed, 11 Dec 2019 08:45:59 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH 2/2] hw/arm: ast2600: Wire up the eMMC controller
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.24
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tue, 10 Dec 2019, at 23:22, C=C3=A9dric Le Goater wrote:
> On 10/12/2019 01:52, Andrew Jeffery wrote:
> > Initialise another SDHCI model instance for the AST2600's eMMC
> > controller and use the SDHCI's num_slots value introduced previously=
 to
> > determine whether we should create an SD card instance for the new s=
lot.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>=20
> LGTM. One comment.
>=20
> > ---
> >  hw/arm/aspeed.c             | 13 +++++++++++++
> >  hw/arm/aspeed_ast2600.c     | 21 +++++++++++++++++++++
> >  include/hw/arm/aspeed_soc.h |  2 ++
> >  3 files changed, 36 insertions(+)
> >=20
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index 862549b1f3a9..0e08d62e9ff3 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -272,6 +272,19 @@ static void aspeed_board_init(MachineState *mac=
hine,
> >          object_property_set_bool(OBJECT(card), true, "realized", &e=
rror_fatal);
> >      }
> > =20
> > +    if (bmc->soc.emmc.num_slots) {
> > +        SDHCIState *emmc =3D &bmc->soc.emmc.slots[0];
> > +        DriveInfo *dinfo =3D drive_get_next(IF_SD);
> > +        BlockBackend *blk;
> > +        DeviceState *card;
> > +
> > +        blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> > +        card =3D qdev_create(qdev_get_child_bus(DEVICE(emmc), "sd-b=
us"),
> > +                           TYPE_SD_CARD);
> > +        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
> > +        object_property_set_bool(OBJECT(card), true, "realized", &e=
rror_fatal);
> > +    }
>=20
> I think we could use a function for the above ^

Yep, I'll refactor that.

Andrew

