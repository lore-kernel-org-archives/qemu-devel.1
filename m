Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2FAC34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B596524656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="EYFwl+yL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ns52S2fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B596524656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4d6E-0002S0-OA
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1j4d5a-0001mL-Mj
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1j4d5Z-00055h-Hr
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:05:26 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50841)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1j4d5X-00054W-Cb; Wed, 19 Feb 2020 23:05:23 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id CADD121AFB;
 Wed, 19 Feb 2020 23:05:22 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Wed, 19 Feb 2020 23:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm2; bh=PD+gM
 0ElJbI4B37LGwqyR+rpEQp/gBM3Hg6vW0ULoiM=; b=EYFwl+yLWU/CU2N2Wx8Gk
 YLxdxF+aK2c/NYld8GtnJfgo8QzPfpcYS2dfphSp8JdWNtRKJtPH6ztV7oSmMDbh
 fEFVWrDuY5gQlENF372sgo/IEpiZzay36vYfbgPno/154ls7jG0SV1I2FxZdheic
 2D5m7eKJ8+f14ihnaB324CK87MJ2w9FLO8/bhcTygB9Om04P8cmgsBvvWGOKX22/
 U3uuOgZurq2SrxLLtNsV6JXoGkwcBb+ms2PqNmIAGShlyfMgBvrxR1k4qym4z6by
 EttnCDUuXH4IyPpgBzt0MWyNZ1RceppJ6/PVd/2DFTimHRGPDhaANZeI4X5BsNAX
 w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=PD+gM0ElJbI4B37LGwqyR+rpEQp/gBM3Hg6vW0ULo
 iM=; b=ns52S2frYD/ZDkBm/UqFNQ0+cSng7IDlSL8BDH6CTdBtwIaUOnDlHA+I4
 UH34TEh54IwSgGLEt6CaX4HxietYa2pQem/ziK0aNwDwUwAo5ymqDRZJeIIXbltN
 CiXxVB58Ws16Zgwp1jSWRYq1th5xJRvWb42o2SKxKvDXuI+NES6OU1diGIk4Aa9V
 cNA6aRSfV/X7YgJoLeRRyH/xaCFQGpOqaOxE4EORwob0zmCpHRKxpbioXCGYXmJQ
 10OOkju9CauKPV1uXBK57qLHatnS59VkIr8LzPhvJCsZsMXULlqGTNBKmj3OeU4q
 eIwyY/yfN7yz+aaTq8rX5lmlynxKg==
X-ME-Sender: <xms:ggVOXlgeNjGlzLzuttJDZmD6DlJvnLNDzIky77uVTWVz2pCqTUx-ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedugdeikecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
 jhdrihgurdgruh
X-ME-Proxy: <xmx:ggVOXlgCRjPdU_uIOTmfODin-v7-TGzhEVDkA4GrwHJQby9X9U2ZiQ>
 <xmx:ggVOXrHGuhsknf9RDP7Xprpajwd1APALREzXF9-HjpHjV-hj8PH07Q>
 <xmx:ggVOXoB0vXx4ld8SCIM-1NdK1V3GhC54iAgab3HkuIzAHuVHCBzWGA>
 <xmx:ggVOXkVJHTM18gyauwVu4WPe6k8k8jAMp-GL5nWUrel8vRfzCgThMQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 16015E00B2; Wed, 19 Feb 2020 23:05:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-802-g7a41c81-fmstable-20200203v1
Mime-Version: 1.0
Message-Id: <c3173616-45ed-4307-92c7-53e6c8db696a@www.fastmail.com>
In-Reply-To: <20200206112645.21275-3-clg@kaod.org>
References: <20200206112645.21275-1-clg@kaod.org>
 <20200206112645.21275-3-clg@kaod.org>
Date: Thu, 20 Feb 2020 14:35:15 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] aspeed/smc: Fix User mode select/unselect scheme
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.25
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
Cc: Andrew Geissler <geissonator@gmail.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, 6 Feb 2020, at 21:56, C=C3=A9dric Le Goater wrote:
> The Aspeed SMC Controller can operate in different modes : Read, Fast
> Read, Write and User modes. When the User mode is configured, it
> selects automatically the SPI slave device until the CE_STOP_ACTIVE
> bit is set to 1. When any other modes are configured the device is
> unselected. The HW logic handles the chip select automatically when
> the flash is accessed through its AHB window.
>=20
> When configuring the CEx Control Register, the User mode logic to
> select and unselect the slave is incorrect and data corruption can be
> seen on machines using two chips, witherspoon and romulus.
>=20
> Rework the handler setting the CEx Control Register to fix this issue.=

>=20
> Fixes: 7c1c69bca43c ("ast2400: add SMC controllers (FMC and SPI)")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Champion!

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

