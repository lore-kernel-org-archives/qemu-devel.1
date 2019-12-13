Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C88FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238DA2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="UXrRXxlY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/MXrZne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238DA2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iffWs-00018K-CO
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 02:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iffW6-0000XV-M2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iffW5-0001FE-O0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:37:38 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iffW3-00018Z-1i; Fri, 13 Dec 2019 02:37:35 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 6A25622706;
 Fri, 13 Dec 2019 02:37:34 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Fri, 13 Dec 2019 02:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=R7vvN
 QShjZstXykvSSp28e4ebWdGwPKaCuhGtz3SP9U=; b=UXrRXxlY/RqY3GbUFkhrk
 SnylI3BL2xlgfwKqdVfSu4QPuBVZ5r8HhtKMLteQ/pR9PK52hgCI0jjcrfpQiyer
 QRt1O+lnQtVI8Wp6rj539BVkDp1/5t4MtWKNHD70JuiW+lcbEzk0IQyxmDq7HGH7
 D6/AVh27FRhy6dl9HDOMGPifZuBoTisrOPTu/yq1Ag73u7d9EcfFi9Gl2EX1ETMt
 CE9JEmvZ2csQYC25yk3Lit4DWf8mI6ZN+Q5Wnm/dy4kahrT9wsTm3/kZhM4X48Rq
 WTbLFjKVYPfxOAkjOX/HhKgsarUuZRKOWzzYAd9zmTT5NxG76uYhVVfPdeDZLdB9
 w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=R7vvNQShjZstXykvSSp28e4ebWdGwPKaCuhGtz3SP
 9U=; b=b/MXrZnenWgGj1row49Q8nWuHVIkklMIH/V09xnfKqYqvdzdPEyxuxQt8
 Tw7ggmBhoKuQu4W1vkxI52iaZwEgv5rfKkh138WrtF941mDFvrtdzAOz42aooegn
 oEHqDlc3aVjX01jaO1UUM7GY2c3gzpjIpqbAIsHG0Di4gSV5d5w1mBhuy+eDwPty
 AMazPPXxw4gT7AWPm/n4xv4TClbmXwsxYKFKX+zmwqN+9cF5GlXrdTh3HeM+cWKG
 ot85eF3OQcHmboLBvVcHgOm6AhNfX102FBn/BuLw8/120g1UMjp28zHQT2Y6A+sW
 3zG93CGgQpDyjBPq3b2OrZV3VLQWw==
X-ME-Sender: <xms:vT_zXcbzn5IWRBJmvNoh_KpYLuq9O43MMyG-Qva3FNxLqyzWH6RcNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurf
 grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhs
 thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:vT_zXYkCys5yL4M5eVP3bu9WGnNkJPk1UTCOANvYikT-JnqKd24bYA>
 <xmx:vT_zXXYUUZMFZoMmlKEE-IRTedz2SkEGa6kJwaIy8g_VzYteayX6uA>
 <xmx:vT_zXQA--z7XnBhP3TB4hqGAmUGuL0_LlqZsu-BzNfw1UKuHYNyagQ>
 <xmx:vj_zXSIqOv2Ax0xggKCMWf-RW-JP5Vu5nXaVGw6TdYbbMPpcPm_H8Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9557DE00A2; Fri, 13 Dec 2019 02:37:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-680-g58d4e90-fmstable-20191213v1
Mime-Version: 1.0
Message-Id: <1d96ac9b-5eb2-43ec-bf21-334ee3fa4420@www.fastmail.com>
In-Reply-To: <16c90bb0-a3a9-06ec-e79a-bd98471d9e11@kaod.org>
References: <cover.fc3e5e495d85ebd919c1f06a1a2c7c7730518f9c.1576211124.git-series.andrew@aj.id.au>
 <16c90bb0-a3a9-06ec-e79a-bd98471d9e11@kaod.org>
Date: Fri, 13 Dec 2019 18:07:11 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 0/2] hw/arm: ast2600: Wire up eMMC controller
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.27
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



On Fri, 13 Dec 2019, at 18:03, C=C3=A9dric Le Goater wrote:
> On 13/12/2019 05:28, Andrew Jeffery wrote:
> > Hello,
> >=20
> > The AST2600 has an additional SDHCI intended for use as an eMMC boot=
 source.
> > These two patches rework the existing ASPEED SDHCI model to accommod=
ate the
> > single-slot nature of the eMMC controller and wire it into the AST26=
00 SoC.
> >=20
> > v2 contains some minor refactorings in response to issues pointed ou=
t by
> > Cedric.
> =20
>=20
> I think these patches are based on mainline. I fixed them locally on=20=

> my aspeed 5.0 branch and I plan to send them along with other aspeed=20=

> changes in the 5.0 timeframe. =20

Yeah, they're based on Peter's tree. I'll base future patches on yours.

Andrew

