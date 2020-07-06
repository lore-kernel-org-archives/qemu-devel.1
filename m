Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4CFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 01:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059A22070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 01:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="bfrOQxTf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GhCUFqHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059A22070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsG7u-0007wm-9Q
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 21:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jsG7A-00074o-Io; Sun, 05 Jul 2020 21:40:12 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1jsG78-0001Pb-Lr; Sun, 05 Jul 2020 21:40:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 0EA8E5804BA;
 Sun,  5 Jul 2020 21:40:08 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Sun, 05 Jul 2020 21:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=u/8AV
 K8DC7AMWjmPg9ogvUOkyYedusJsI0qnRfcaQIw=; b=bfrOQxTfhZby5Gv712QnY
 Xnu6I51Hn4ZHxPjJ2D+emDNTfcrARp/wfWUzfXg1lRcmp0yhwtaknq8K5+matxhN
 RTC01VPJCysHDHBjWWw6XH/F1QDlvBCLv3SUDOxj7I/9laQvyG3bFlpYE5z/qV+F
 9akxL8u7Eqdsdphj/lLEgdyObManB7JgMqehJGfT82kyDetA43wJHs073f+NQPrZ
 8LJC4z/RNhfC/Es15Vq12tJ9ta5/YqKNvrJKFDjt6pyqEtGN0LskFgRzAwmERxJe
 irgOo5LKpx9BPF/Zi/qGV1WVDhxKPbx7qOGgt0gLUTZVYrmQvY4heYbCwH/vwiPz
 g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=u/8AVK8DC7AMWjmPg9ogvUOkyYedusJsI0qnRfcaQ
 Iw=; b=GhCUFqHHZLwRwNueqAeKfWYQG6EusFbEl0MqTuAGdothU6ySyFHlrstiT
 qZPVyhpF/7LGDeuqz6rR9Behznqlcvz6dMmwas0fohA/p8lebzWFAAniILDbNTok
 FIl7qPfA9r/AjfS4V6F2Oc0XbhlMcKpUvTeXC1mN+dNuZyH0EqJWbI7LPglytrV9
 SF3oiUVnqMIQuUqBvDF7rb45Kw6nJczz8UuI8vPY0VKpJQA4YIVoseARznkwvrIi
 Iz0ljFR8p8PHmvTf8r6/e5qYezbkOJhQvnUsR9+JZriowS9CiiHUJ//29d1PflzZ
 bO7qDYme9HooxJxEABC1ZR97YN92g==
X-ME-Sender: <xms:84ACX0-JEqLe6ZhfBQULT8p-tcHY8lVylpEF0bu43HWHxAdLECh8tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdegjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
 grthhtvghrnhepvdegkeehgeefvdfhteehhfduteetgeeugefgieeigeeuheekudegtdek
 gfelgfehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:9IACX8uMCwj291F7pkVWTTkMAS9nhmfyVuWDFvQK6X9XBb4-J0XxOg>
 <xmx:9IACX6Cs7ZkOq_aJ4_6v0xVE6NHqkz_gcGTwuFp4c0WEkchU-CXCeA>
 <xmx:9IACX0esrTt2pWY0zxvL0rEJ6UO_Um4AF4q44SrCgrFIcDtvUTFxlQ>
 <xmx:-IACX8pssk9Vbel3bbisSPnt1nbibKGTw5LQ1xv8QN0zc0p5WaWxmQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E2DA9E00AA; Sun,  5 Jul 2020 21:40:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-576-gfe2cd66-fm-20200629.001-gfe2cd668
Mime-Version: 1.0
Message-Id: <b4a2748d-efbd-4fb9-b6f4-93d172b2cc9f@www.fastmail.com>
In-Reply-To: <20200705224154.16917-2-f4bug@amsat.org>
References: <20200705224154.16917-1-f4bug@amsat.org>
 <20200705224154.16917-2-f4bug@amsat.org>
Date: Mon, 06 Jul 2020 11:09:42 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/5] hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.229; envelope-from=andrew@aj.id.au;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 21:40:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Mon, 6 Jul 2020, at 08:11, Philippe Mathieu-Daud=C3=A9 wrote:
> All the callers of aspeed_i2c_get_bus() have a AspeedI2CState and
> cast it to a DeviceState with DEVICE(), then aspeed_i2c_get_bus()
> cast the DeviceState to an AspeedI2CState with ASPEED_I2C()...
>=20
> Simplify aspeed_i2c_get_bus() callers by using AspeedI2CState
> argument.
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

