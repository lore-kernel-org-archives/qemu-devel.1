Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B30C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E8220735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="tv1NnbK+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJypB7Ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E8220735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8GA-00083x-4N
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1jY8FV-0007GZ-92; Mon, 11 May 2020 09:13:37 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1jY8FT-0001aQ-5t; Mon, 11 May 2020 09:13:36 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 01D0B37B;
 Mon, 11 May 2020 09:13:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 11 May 2020 09:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=poDHtBVhyfcUrliKJhFqBeoGfMb
 lY4xnjm7jr/tYFVc=; b=tv1NnbK+ZJ1pM07x9gjYnhhkxZ3mnswgSYe4WnHrBRD
 7YTVjYDULieWCBqs4697Nedv/e0cTOUpYXtqfJjr1lxyufNRpDEPvnaiPNUyCJAX
 6b7i7iVX1jHXEBNljUPm8SX0Av2oRftWVwleOWnFcjcfIr4vPueIdHE+VWwR9jvX
 MYqcZRnQbr/N6PQFgVTBOus/XGBVumgBgSTbk7oBCWdHH5/1q8qHbmOblKYfkdBN
 ReIhUJqkQQCFDEEkd4FNiIAI4x6I8SslJDRpmjNwXN+BeEhCSXDS9Zui+bJNP7MW
 7IcsLUBFUci8cYRlsGcIdVZtucwNYCyEpsKNWUlu+NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=poDHtB
 VhyfcUrliKJhFqBeoGfMblY4xnjm7jr/tYFVc=; b=TJypB7Ay1HKZpdJpkwkizz
 TkIZv8ETkbKJyC+xM/F/9z/+gkcDFsZFVtEmDNp8zt4FUIHpgcmEQoq55IL18vRA
 SZurzpIV1xtce3DYEZxxrEhL8GTebInTZ6y39nXarLcYRhzgfu5rk9ZGXPaEHewC
 9Jb5sqyQ1MuDk0ux19BvttH0zw/I5SSK6yEXdZTLloW0nnocGHnnq7Ge+YRba7jX
 fBsU7+EsvSTeEZDmbc1GvS1GnDIgDk71s5LJSWYci12XGCPu3V6jaYadk9SCfvPX
 Ql19j3QqfaWAMJ/CYqf8GmR79BxzJiHKazD/hF7YR5RM+LZFcf2mzdfh8oNy13jw
 ==
X-ME-Sender: <xms:ek-5XiW7sIFbD_ngZJtKf2G-KsKKuSKWbU_esLNG2sBk6WntjIHPjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrledtgdehiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
 hrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehgtderredttddv
 necuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsth
 iftgigrdighiiiqeenucggtffrrghtthgvrhhnpeettdduveffleejjefhvdeiveeltddv
 udeiuddvgfeufedujeetieehueevueefjeenucffohhmrghinhepqhgvmhhurdhorhhgne
 cukfhppeejiedrvdehtddrkeegrddvfeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:ek-5Xq7ZKV7zTd2CZVzzW_cjFoN7wcO0fWQvzCpzw7EpCI2JeSTx7g>
 <xmx:ek-5XpIMy1C0tHJGo4KaxcJ1BP-fWa2jgfytJN4hEqHeOwLjwIBNHg>
 <xmx:ek-5XrIl697aBUaeCRGy1cGSfaTYhAXvWLCHIjFgaluqj6JsxFJbmw>
 <xmx:ek-5XhM35XtKnz5cw3Heurmu_6JSSscaO40lTd2hSLkEsULfABga3Q>
Received: from localhost (76-250-84-236.lightspeed.austtx.sbcglobal.net
 [76.250.84.236])
 by mail.messagingengine.com (Postfix) with ESMTPA id B8F91306627C;
 Mon, 11 May 2020 09:13:29 -0400 (EDT)
Date: Mon, 11 May 2020 08:13:28 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3] aspeed: Add support for the sonorapass-bmc board
Message-ID: <20200511131328.GF10214@heinlein>
References: <20200506173035.2154053-1-patrick@stwcx.xyz>
 <20200506183219.2166987-1-patrick@stwcx.xyz>
 <CAFEAcA8RMhq3aZcqzqFkaWCkwkzfptxAyAogEEg+BcqNU1BquA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8RMhq3aZcqzqFkaWCkwkzfptxAyAogEEg+BcqNU1BquA@mail.gmail.com>
Received-SPF: pass client-ip=64.147.123.21; envelope-from=patrick@stwcx.xyz;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 09:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Amithash Prasad <amithash@fb.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 11:54:42AM +0100, Peter Maydell wrote:
> On Wed, 6 May 2020 at 19:32, Patrick Williams <patrick@stwcx.xyz> wrote:

> Looking up through the thread I can't find the email where
> Amithash gave his reviewed-by tag -- did I miss it?

I probably shouldn't have done this.  I asked Amithash off-list for his
approval to add his Reviewed-by.  I'll ask him to reply to this with
confirmation.

> PS: for the future, v2/v3 etc patches should be sent as
> fresh emails, not as followups/replies to the v1.

Thanks.  I missed this detail when I read [1] before but I see it now.
It seems like LKML tends to do the opposite?

1. https://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Patrick Williams

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAl65T3gACgkQqwNHzC0A
wRln/hAAo5o+d9iLTggHpL16/1V/xBluCym0xQkMiDY0KtmbBfVoLmiBm3dGOLr5
BEwBsMOWBjSZTpMytFlyqmEzz6lK12HzZgTEd/9jSb/ig4KBC/Cv7VsZK8kqnwjK
5ceM57UgAA8OTZ1DdK2XZTciP4TqOCMP6R50rVqxsTMjTJv/9C1p2PS5M2+LAhEq
qZfB47yexUcij8vuK15tFD4gLgOLhAWNuKQvQxpKfJLBaG0VvhVpg4BCLv1ztH9p
99VgTC7uKy6MLd/3BsYmC1HHe6NSZgqkNQCd3XjMlozfjqTNP/q42fRqRMNXwnhg
Xj1wC8mjyyfpT/q9Xu6+nBLO9uLrrG4dXiukT85w+05+AhG5pFxt+qfPu+nt3LrW
trMxxKGJ8dY4/IwVgyuGhG9PnRem/MLXkul53e+HMdav2MtGlKDmMpuuodbqxDQN
05MvgwTFXVT5Z5HdfiEIgc0q+DzK6n1aIfCVnweTY6PCTCF8JtkznwR4Ai6AFxcp
53HeJjo2ijVwqyXdBCRkXy593LaNQvR4S7bSnAOWs0Ak0No8OTqnK/NXr2Wkmim9
60KF9cgVRoU4Dm6q5e8evXcxiTVDnFMAznpUYgnDocMpIJr5gpIG1Ed86jM9ecNx
imnXzqgDre/76mg6/7FX5G4RUdKg2UM/IwUdFl32IDTmON5P3xg=
=FFs6
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--

