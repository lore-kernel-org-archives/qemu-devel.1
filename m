Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83195C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 00:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F99C2083E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 00:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LKxvgFSX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfEnzr5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F99C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaq1G-0000dV-HT
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 20:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jaq0G-0008J1-1J; Mon, 18 May 2020 20:21:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jaq0C-0008Oc-NX; Mon, 18 May 2020 20:21:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 0DF965C00EE;
 Mon, 18 May 2020 20:20:58 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Mon, 18 May 2020 20:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm2; bh=5ejPM
 4auQg3IJ4AMz7sVnACxB15QpCyHfC7+4XrK7Jg=; b=LKxvgFSXh+aYfairVi8uw
 YseOUv15oW5kflI9avqGgXc1mTAbnygqTNpH20v4WgNuU01107oBItAPgG4mz8o0
 ZNF0658YOwa7Q+tLNxX6DzdDSt7JpRWeT4iaLRYkfWMuM0Uu2zVnuQ4AmTKhblkv
 HgCgWprANuyoofRXgA52PK4VrXQf/5XuPamt2n+CjcirUmGA90YZPlgyOl3UHyij
 FhSeoJpSj53OoXPunWP4fVIriPckdNeIUSj1wmD78Dgg+wFtINYJkP3Oywyzmsy0
 Z3ua2nw6sWobq+VZV4Uu96b0gEb+Z1cYAw4PG1c/0kCFKy1Ql/bu6T0V4elYsxgH
 A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=5ejPM4auQg3IJ4AMz7sVnACxB15QpCyHfC7+4XrK7
 Jg=; b=dfEnzr5JL7GyZJNPb/eSuUnZj8ZjWTcHIGK64uKJClgyb6fUWeWfsQ80q
 m4agxbM/P9o2npHdpPPHNYUmqO9C2TWV0bgymOL1LFmVjk+tfFe19Vqx+Xo8ET5X
 TAK59AlMZ5OiXmehLTCi3S3i4wCtx5CMxvueQWCASRvLZSnrKnJfGY7rubf1CBtM
 sFEopCV/mYxluRqGvsxnfhwWOsSsnO5g0yuYBOhxAfJxwOe9VLXPy81/tqMU61VA
 B2k//fgJxEdXawhi6BupYQ43yo9s31fN5cdrBjC5tyj0XMlTCD71wkgY9zsSQvkL
 8owCY4EyCYpAhgnrkVmF+PrhSd0xw==
X-ME-Sender: <xms:aSbDXlquVdMV4_GIcosaQVD0kljhcUBbQLRkfWxn2kDTF-lsJFedtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtiedgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
 frrghtthgvrhhnpedvgeekheegfedvhfethefhudetteegueeggfeiieegueehkedugedt
 kefglefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:aSbDXno0DgUJomhdlMe0W7Lmo9hDBYxXJYY01R4ZliZ_peoLmrMhsg>
 <xmx:aSbDXiNMCg7CqiYhclcGIHl7L-6mc6vWTJAfNtfZOZGtpNBFNa4CbA>
 <xmx:aSbDXg5J8QkI-xyyavASClJWBY3ocX8Ka7hOp_E0Z781PG5nJehMug>
 <xmx:aibDXuTMMffbQht9uVfFPO-Sj4kM3AB3IvGKw3PJFbeYeV_ZcPVs4w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 042D4E00F8; Mon, 18 May 2020 20:20:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-464-g810d66a-fmstable-20200518v1
Mime-Version: 1.0
Message-Id: <eb1b203d-44ba-4b89-b96b-4e7bf993ac67@www.fastmail.com>
In-Reply-To: <9fc4a6e2-fa90-ba62-91cf-e22eb3ef4cdc@kaod.org>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-5-armbru@redhat.com>
 <9fc4a6e2-fa90-ba62-91cf-e22eb3ef4cdc@kaod.org>
Date: Tue, 19 May 2020 09:50:34 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Markus Armbruster" <armbru@redhat.com>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Subject: =?UTF-8?Q?Re:_[PATCH_04/24]_aspeed:_Don't_create_unwanted_"ftgmac100", _"?=
 =?UTF-8?Q?aspeed-mmi"_devices?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.27; envelope-from=andrew@aj.id.au;
 helo=out3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 19:21:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Mon, 18 May 2020, at 21:49, C=C3=A9dric Le Goater wrote:
> On 5/18/20 7:03 AM, Markus Armbruster wrote:
> > These devices are optional, and controlled by @nb_nics.
> > aspeed_soc_ast2600_init() and aspeed_soc_init() create the maximum
> > supported number.  aspeed_soc_ast2600_realize() and
> > aspeed_soc_realize() realize only the wanted number.  Works, althoug=
h
> > it can leave unrealized devices hanging around in the QOM compositio=
n
> > tree.  Affects machines ast2500-evb, ast2600-evb, palmetto-bmc,
> > romulus-bmc, swift-bmc, tacoma-bmc, and witherspoon-bmc.
> >=20
> > Make the init functions create only the wanted ones.  Visible in "in=
fo
> > qom-tree"; here's the change for ast2600-evb:
> >=20
> >      /machine (ast2600-evb-machine)
> >        [...]
> >        /soc (ast2600-a1)
> >          [...]
> >          /ftgmac100[0] (ftgmac100)
> >            /ftgmac100[0] (qemu:memory-region)
> >     -    /ftgmac100[1] (ftgmac100)
> >     -    /ftgmac100[2] (ftgmac100)
> >     -    /ftgmac100[3] (ftgmac100)
> >          /gpio (aspeed.gpio-ast2600)
> >          [...]
> >          /mii[0] (aspeed-mmi)
> >            /aspeed-mmi[0] (qemu:memory-region)
> >     -    /mii[1] (aspeed-mmi)
> >     -    /mii[2] (aspeed-mmi)
> >     -    /mii[3] (aspeed-mmi)
> >          /rtc (aspeed.rtc)
> >=20
> > I'm not sure creating @nb_nics devices makes sense.  How many does t=
he
> > physical chip provide?
>=20
> The AST2400, AST2500 SoC have 2 macs and the AST2600 has 4. Each machi=
ne
> define the one it uses, generally MAC0 but the tacoma board uses MAC3.=

>=20
> Shouldn't the model reflect the real address space independently from
> the NIC backends defined on the command line ? =20

That's my feeling too, though I'm not sure what to make of the unrealise=
d devices
in the QOM tree. Does it matter? It hasn't bothered me.

Andrew

