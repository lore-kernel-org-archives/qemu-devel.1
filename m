Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FCC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 22:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74D12053B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 22:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="U7jBl7/R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="botsc4e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74D12053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ienpG-0008UU-VF
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 17:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iennl-0007NU-KQ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 17:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iennk-00053m-BO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 17:16:17 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iennh-0004yv-Hi; Tue, 10 Dec 2019 17:16:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id B5E4AED3;
 Tue, 10 Dec 2019 17:16:11 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Tue, 10 Dec 2019 17:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=o3/w2
 8DcUaCOTUMXgSPrVlQr0SfHyxTg5qkRp+tl6uc=; b=U7jBl7/RB/bZWlk+DKnMi
 Nk5UWkXR00ZoTNs5uJlKVH07CTT5lySk2m7PwScT7eFGyOtr8mBPE/zAMt3NvupV
 iMFL8sghteoEHp5rZjQiHcasP8JfZxKWSKvibS1Ixot0Zaqte4xqVq09SXZahKaI
 11Em55qluxEw1z3NppUqtrbLgN6ITguKS2gpcIp3/OQUQ0+d7/dSNRbk/wgnylbe
 8v5rk2+d6UUnJnvpBrOXXeqmWMS66f1gkHliJWYR/D+EHFS4FmPcyHkPid0Ilbxm
 bbHOUCgamQMqVVndAUy+nypSCY/VyYnaPC4Lgpcr/B1a6NXPJMqJcaSGrJg2ejri
 Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=o3/w28DcUaCOTUMXgSPrVlQr0SfHyxTg5qkRp+tl6
 uc=; b=botsc4e4CfHucumguvrs5rYd/5kgA4EVTA2XlM4U9Mq2Ec+5hV/o0zc8W
 Vhm3lQ4EmWlUJy158Wvmy8GJuwz0CnGLxbqNiUz92yxtdQ0phmVRWOzFwvypn5a/
 MqpuBhKf/gilCPQWL3Q8jjbEVpmTaPIHm3n0hzsq/1Y7U1D4ESczEddqKSCTFSMX
 KYMZOdbiD4ebuifYJ8R5LTHLztJbUf55r4539erekhG9KZQFTKk7sOonqg505iQP
 vzbB3cq/MEfExfhxtQlWpTL57Sb0zEHdm8ylG9gHhoxgQnyFcd0xc1adlUvI4hpC
 42HVatkme13u42/3SNIHwxjE2khaA==
X-ME-Sender: <xms:KhnwXTeM-hg7RAfk84F8dr0YprhPY38KPR40YYB3YKluy3WWQehWoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelfedgudehkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurf
 grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhs
 thgvrhfuihiivgepud
X-ME-Proxy: <xmx:KhnwXSKbIZvXtE88xIKhkUzg6GlQUJGhu76_1RNaJ7kINRvCy7a27A>
 <xmx:KhnwXeeEn1vY0t1ugO4djX0O8_2Az86ZCQSgzZ-0ti1sQJlvwwjwpA>
 <xmx:KhnwXR3T2wbQTZw4iJgcD2yHoTknsZDG1vD0-BK5_F8wI7Ko9MywPw>
 <xmx:KxnwXV-VuAwDr_04-d3nJEMON6G1eOg_wyH_r8WAWRNWPoaO3YT5yA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id A3F98E00A2; Tue, 10 Dec 2019 17:16:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <27aa4292-cc3b-4a9b-a13d-ab1eced3f952@www.fastmail.com>
In-Reply-To: <c49584df-016d-9a84-b96e-6a3b2e98c6a1@kaod.org>
References: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
 <11e1d38d2374a48996a3496c906db215de246583.1575938234.git-series.andrew@aj.id.au>
 <c49584df-016d-9a84-b96e-6a3b2e98c6a1@kaod.org>
Date: Wed, 11 Dec 2019 08:47:50 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Subject: =?UTF-8?Q?Re:_[PATCH_1/2]_hw/sd:_Configure_number_of_slots_exposed_by_th?=
 =?UTF-8?Q?e_ASPEED_SDHCI_model?=
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



On Tue, 10 Dec 2019, at 19:26, C=C3=A9dric Le Goater wrote:
> On 10/12/2019 01:52, Andrew Jeffery wrote:
> > The AST2600 includes a second cut-down version of the SD/MMC control=
ler
> > found in the AST2500, named the eMMC controller. It's cut down in th=
e
> > sense that it only supports one slot rather than two, but it brings =
the
> > total number of slots supported by the AST2600 to three.
> >=20
> > The existing code assumed that the SD controller always provided two=

> > slots. Rework the SDHCI object to expose the number of slots as a
> > property to be set by the SoC configuration.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> One minor question below.
>=20
>=20
> > ---
> >  hw/arm/aspeed.c              |  2 +-
> >  hw/arm/aspeed_ast2600.c      |  2 ++
> >  hw/arm/aspeed_soc.c          |  3 +++
> >  hw/sd/aspeed_sdhci.c         | 11 +++++++++--
> >  include/hw/sd/aspeed_sdhci.h |  1 +
> >  5 files changed, 16 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index 028191ff36fc..862549b1f3a9 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -259,7 +259,7 @@ static void aspeed_board_init(MachineState *mach=
ine,
> >          cfg->i2c_init(bmc);
> >      }
> > =20
> > -    for (i =3D 0; i < ARRAY_SIZE(bmc->soc.sdhci.slots); i++) {
> > +    for (i =3D 0; i < bmc->soc.sdhci.num_slots; i++) {
> >          SDHCIState *sdhci =3D &bmc->soc.sdhci.slots[i];
> >          DriveInfo *dinfo =3D drive_get_next(IF_SD);
> >          BlockBackend *blk;
> > diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> > index 931887ac681f..931ee5aae183 100644
> > --- a/hw/arm/aspeed_ast2600.c
> > +++ b/hw/arm/aspeed_ast2600.c
> > @@ -208,6 +208,8 @@ static void aspeed_soc_ast2600_init(Object *obj)=

> >      sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->=
sdhci),
> >                            TYPE_ASPEED_SDHCI);
> > =20
> > +    object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &err=
or_abort);
>=20
> OK. This defines 2 SDHCI slots for the ast2600 SoC, but
>=20
> > +
> >      /* Init sd card slot class here so that they're under the corre=
ct parent */
> >      for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
> >          sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slo=
ts[i]),
> > diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> > index f4fe243458fd..3498f55603f2 100644
> > --- a/hw/arm/aspeed_soc.c
> > +++ b/hw/arm/aspeed_soc.c
> > @@ -215,6 +215,9 @@ static void aspeed_soc_init(Object *obj)
> >      sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->=
sdhci),
> >                            TYPE_ASPEED_SDHCI);
> > =20
> > +    object_property_set_int(OBJECT(&s->sdhci), ASPEED_SDHCI_NUM_SLO=
TS,
> > +                            "num-slots", &error_abort);
>=20
>=20
> why use ASPEED_SDHCI_NUM_SLOTS here ?

No good reason. I'll just switch it to '2' like in the 2600.

Andrew

