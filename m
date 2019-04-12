Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC50C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3313C2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="C4TpS4DF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1f8ujIsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3313C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEmhC-00084m-4c
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 23:17:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmg1-0007eg-BT
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmg0-00005I-73
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:16:29 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrew@aj.id.au>)
	id 1hEmfw-0008Vk-VW; Thu, 11 Apr 2019 23:16:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6DCE721BA9;
	Thu, 11 Apr 2019 23:16:24 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
	by compute4.internal (MEProxy); Thu, 11 Apr 2019 23:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
	mime-version:message-id:in-reply-to:references:date:from:to:cc
	:subject:content-type:content-transfer-encoding; s=fm2; bh=Tg0eT
	dkFsLa5G0tt0ttNJOWPLLGK/NBnEC95xGdLE78=; b=C4TpS4DFUz9Bh7WLYkY30
	UOO48z5r0VcpmKq7m/Nu70DKpTOZYtZQX/jJbCQMoHPRRaIlPP4Smv+MQGI4Eh8s
	pvC9zJ4fluZSOaVIPNk8oklFRztyId2oY7SpAy8KRyttWdS2TPXIXrzQ8NpVfYj8
	nCMVLD/ddNBj0ug8R0BD16slbDR3w4EXdtY06u/sIiXrc5fVRhEgL4RRCPPd7t8G
	pSTbf/whTc0QACcX/B4jZOXcRO10/jYepa8X/mJPwf9/D4bULrqMbdMKonpmbBh7
	00ImfQHBGVBxuYAxbK7S4ae/hx+hZQ4ibgfieHq5FScWED0tDLkK7C+F3cfViYuy
	w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; bh=Tg0eTdkFsLa5G0tt0ttNJOWPLLGK/NBnEC95xGdLE
	78=; b=1f8ujIsIc/VqlkWw0laQmXZMfKwgobi2B99ggVDEwpIsxDPTJ3XcA1Cor
	TkfpKCVbDWsSzlCkciQSAgvrofeysqiodPf3i5W19WeWbfaT/J5GMlShY/z7Z2LX
	xsCMrlnzjeHcdgKvixdL0Bf1qNksYVCO6yceA4auEgtyUSgs/2/pL0D8anH/IAdd
	IbuEfemLniyaZJ74yXVROY3qwX4EIGj9O4tuGPcc13yuU6ZvCUDq3y7rc2xCPxBK
	2hgm2sgb6J31jervmel42LDE22ZI6FZftaynGk8IbWAii/P2XigDBlfU26is1ieq
	uLvpgKEBUT6kpoKQ58xJGZqSTuN4A==
X-ME-Sender: <xms:BwOwXI7QfUMggNL0MMReiWAmLoL1o_TXv2rFENCPQNWZfTbeZEeO5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrvddtgdeiiecutefuodetggdotefrodftvf
	curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
	uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
	fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
	rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
	grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
	rhfuihiivgeptd
X-ME-Proxy: <xmx:BwOwXC4mUIRt2JjgaxgIIC-8VyyoYqFdO_pBPfMUxpI1f6QdPaz6UQ>
	<xmx:BwOwXBKpsiW8nrbHpNutJFCU-ULLU5521xEm0l3J6m80ZuzwIqKOsw>
	<xmx:BwOwXEF43C3PPoHYR17mkAmknj8HGZBOfmg1E4Is_vdddtEN07cDrA>
	<xmx:CAOwXFOf0mhQxO4t9w19A_AgNRh6wBZ0ffoe1iWb10xL4F-ASXIv1A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 249997C19C; Thu, 11 Apr 2019 23:16:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <17c56d46-117c-4b8b-a60f-ea7d1725dfc8@www.fastmail.com>
In-Reply-To: <20190411161013.4514-4-clg@kaod.org>
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-4-clg@kaod.org>
Date: Thu, 11 Apr 2019 23:16:22 -0400
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	"Peter Maydell" <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.28
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BPATCH_3/3=5D_aspeed=3A_use_sysbus=5Fin?=
 =?utf-8?q?it=5Fchild=5Fobj=28=29_to_initialize_children?=
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412031622.4N4jrF4gCNAAgWCp_7B73wWolpyahTQe_G893fiJTwM@z>



On Fri, 12 Apr 2019, at 01:40, C=C3=A9dric Le Goater wrote:
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  hw/arm/aspeed_soc.c | 50 ++++++++++++++++++--------------------------=
-
>  1 file changed, 20 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 9b601709e93c..110956828c44 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -212,12 +212,11 @@ static void aspeed_soc_init(Object *obj)
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>      int i;
> =20
> -    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
> -    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
> +    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cp=
u),
> +                            sc->info->cpu_type, &error_abort, NULL);
> =20
> -    object_initialize(&s->scu, sizeof(s->scu), TYPE_ASPEED_SCU);
> -    object_property_add_child(obj, "scu", OBJECT(&s->scu), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu)=
,
> +                          TYPE_ASPEED_SCU);
>      qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
>                           sc->info->silicon_rev);
>      object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
> @@ -227,36 +226,29 @@ static void aspeed_soc_init(Object *obj)
>      object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
>                                "hw-prot-key", &error_abort);
> =20
> -    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
> -    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic)=
,
> +                          TYPE_ASPEED_VIC);
> =20
> -    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEE=
D_TIMER);
> -    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl)=
, NULL);
> +    sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
> +                          sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
>      object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
>                                     OBJECT(&s->scu), &error_abort);
> -    qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());=

> =20
> -    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
> -    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c)=
,
> +                          TYPE_ASPEED_I2C);
> =20
> -    object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename=
);
> -    object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc)=
,
> +                          sc->info->fmc_typename);
>      object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs=
",
>                                &error_abort);
> =20
>      for (i =3D 0; i < sc->info->spis_num; i++) {
> -        object_initialize(&s->spi[i], sizeof(s->spi[i]),
> -                          sc->info->spi_typename[i]);
> -        object_property_add_child(obj, "spi[*]", OBJECT(&s->spi[i]), =
NULL);
> -        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default())=
;
> +        sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
> +                              sizeof(s->spi[i]), sc->info->spi_typena=
me[i]);
>      }
> =20
> -    object_initialize(&s->sdmc, sizeof(s->sdmc), TYPE_ASPEED_SDMC);
> -    object_property_add_child(obj, "sdmc", OBJECT(&s->sdmc), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->sdmc), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sd=
mc),
> +                          TYPE_ASPEED_SDMC);
>      qdev_prop_set_uint32(DEVICE(&s->sdmc), "silicon-rev",
>                           sc->info->silicon_rev);
>      object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
> @@ -265,16 +257,14 @@ static void aspeed_soc_init(Object *obj)
>                                "max-ram-size", &error_abort);
> =20
>      for (i =3D 0; i < sc->info->wdts_num; i++) {
> -        object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_=
WDT);
> -        object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), =
NULL);
> -        qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default())=
;
> +        sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
> +                              sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
>          qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
>                                      sc->info->silicon_rev);
>      }
> =20
> -    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMA=
C100);
> -    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100)=
, NULL);
> -    qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());=

> +    sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
> +                          sizeof(s->ftgmac100), TYPE_FTGMAC100);
>  }
> =20
>  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> --=20
> 2.20.1
>=20
>

