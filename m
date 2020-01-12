Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917C1C33CA9
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 23:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505D82080D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 23:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="KcW/XsGE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LAm65t9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505D82080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqmWU-0006vW-Gv
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 18:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iqmVU-0006An-VD
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 18:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iqmVU-0000Z0-1g
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 18:18:56 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iqmVR-0000HR-IB; Sun, 12 Jan 2020 18:18:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 6817A2015D;
 Sun, 12 Jan 2020 18:18:51 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Sun, 12 Jan 2020 18:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=zx26K
 D5Pz02YJ+yg8O2oz5kKMQr/WceSgZS/j9AYF68=; b=KcW/XsGEt0FCMmLJiEYN4
 91vO/qsCjwaqId83f4EtJ1ttPfWFoL7WvI2Imv6Le8kWOj6eNqfro6iRBP48yGQz
 dql4fQSkhEea4PAIXPPqtpbb9tkfNQf766CFUtYsIT4dtBHmOhDpbW46xNkEaWG0
 57JksM/x3maOjtqM2AYrrVHgn7TkGI04u2wJLCpo9g0PbZsaT1BfYrGLgkvEIhPQ
 C7x9ZMrw/0N9LnUW89ZVMwCNgeJ5RKKshGgsqjhA4StgWKjI9OBX34Y+kwtLq/JA
 jYHNGpV5xDKPjKp8CeBp5pTGZt8MjcPVznuIxr8dovy0RRnqnqTdGFvrzHj3hQwc
 A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=zx26KD5Pz02YJ+yg8O2oz5kKMQr/WceSgZS/j9AYF
 68=; b=LAm65t9FtOdokN5o5SO3VP4eBJ8f3+gtDgGq0yq8ax3USZ+R860GvTtxt
 JKas0KABzEeZueublkI+j/7ilu6MNuDX/CQB6LOEbkFFJsmXGFR4z92FWiOtQC4D
 dBjHKIxGhIM1EAMJJRumkQMLoIDsuwKcKH6DYLyE/wm06C1N3tFhtIOfOMcAjgh/
 RZ8LDEmUWPbA4c9YJ4JBMLLgNeGmBqCEwlnhVHnE9ie3I7mZ6ppJOQQITiRQa3MN
 WQXTlaD4/WsiV8fVKMQhhdu570y3Td0sAOCJmyIE0J3eE0XOI+70Vc5X9dvIc29Z
 pzL2rZWcgG9P6H1g9aWLV4VyLkdLQ==
X-ME-Sender: <xms:WqkbXqH3MtBqPHeKol5Y8SmMuYOMnm_1TbDJroXgtN-EQ4QTo-NbHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgudduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
 hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
 vghrufhiiigvpedt
X-ME-Proxy: <xmx:WqkbXnoCRRhH4AizuF5xBoSICJ4nJlJy8mw5z2_U5sB7dc5Mmb-gxg>
 <xmx:WqkbXm6zEnmBrhyyXuCipCY9JRqEuHlhB2L5tGXQNzISlleR1BSmbw>
 <xmx:WqkbXl7ZJgAfHoL-ADMPRFYtfAXZebkPm2MGA06SJDfjIrHqrwFfyw>
 <xmx:W6kbXt9pZlGI1kky6NvHOHb89Ki_bmDeQB9a_FLKo86Djbz2Fv1NUw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 97B0AE00A2; Sun, 12 Jan 2020 18:18:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <114b0ca0-3e98-43f5-818d-f69df5a0c5c9@www.fastmail.com>
In-Reply-To: <901d2dc7-f8ed-bbca-b587-19fce5fed631@kaod.org>
References: <20200107073423.30043-1-clg@kaod.org>
 <20200107073423.30043-3-clg@kaod.org>
 <a7c45303-e624-d7aa-df6f-e03f26b3cba7@redhat.com>
 <901d2dc7-f8ed-bbca-b587-19fce5fed631@kaod.org>
Date: Mon, 13 Jan 2020 09:50:53 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/5] hw/arm: ast2600: Wire up the eMMC controller
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
Cc: qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Fri, 10 Jan 2020, at 22:26, C=C3=A9dric Le Goater wrote:
> >> +
> >> +=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "emmc", OBJECT(&s->e=
mmc), sizeof(s->emmc),
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 TYPE_ASPEED_SDHCI);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 object_property_set_int(OBJECT(&s->emmc), 1, "n=
um-slots", &error_abort);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "emmc[*]", OBJECT(&s=
->emmc.slots[0]),
> >=20
> > Single block, so use "emmc" instead.
>=20
> Andrew, how should we call the objects in the slots ? "sdhci" ?=20

I think that's the right way to go, but maybe we need to rethink the nam=
ing at the
controller level.

Andrew

