Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662FCC3404C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30ED124656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="t5l+g7hA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HX1VIC8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ED124656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4d23-0000LU-Cu
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1j4d1A-00083E-Gj
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1j4d19-00046b-JK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:00:52 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59307)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1j4d17-00046C-Gz; Wed, 19 Feb 2020 23:00:49 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id CF1F921DC4;
 Wed, 19 Feb 2020 23:00:46 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Wed, 19 Feb 2020 23:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm2; bh=etUlX
 aKb6s1XrkRtfVBx1UhOcc0NW5xvfVRd6PG5drM=; b=t5l+g7hAWUsdKhljlr7x4
 Wf273WTNbHDHye76yDtlYmREStCapYF+x5sYZkuzmQa7W8S725tFKI7jz5oF6CxF
 gXYTkilIGHi+9e2dnxjfkjffPaPW4e4uN2EY2RdWgbDTqOS1T95Z8fB4BeDvW0ff
 33xSB1yBamCa5XKDYY/ZIfGomaKDA6KuvTEVfEFmXMK4Nu69aTGxw/XRPlGiMWf9
 PPR2xshw3+riigqmvU8taFk0gk0KGWWbbTN0/kSOP5wYbXr3no8LHvJUEDyUKVB+
 4K4PZJWKiCjOC+QcOA2Rp9yaDI4DfRhTsk2EnUS2WCivK9gsHJYqohgLpcXvvfhM
 g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=etUlXaKb6s1XrkRtfVBx1UhOcc0NW5xvfVRd6PG5d
 rM=; b=HX1VIC8r+iICGIpQooJEzoASXWt4wdXU/ly57Ju38Tjo9kZrnzulniuTo
 qGBbSH1VgzGZQWoJqY7i/52fueVMCoKIVFLMRPoexmBK6/3i8RN/311KVQnCQY9Z
 oiQgomTRNHEtbCTiEQWPPtmgzih8SQJ16l4q1sEWCdi+PhzTi599Gq/Daws9PBZG
 WdgGoQMvj1ZmAlguxSWyoJEP+eLakBeC3sdROaCXOwpJg/GyiqG8wH3bnLzUiiOZ
 uSlKfre4PwAV2/GTgXaZybtrsf5irZ6iDk39CX+CdwfRkbs1CFL2Zjy9XT/EAygD
 EfkLvQfFns3PTlXv25Ul5m1+jMDBg==
X-ME-Sender: <xms:bQROXra6FTumU8XHMrMHbVN-9B89D0D98_yXvGKcp8H5X1YbTXtvNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedugdeijecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
 jhdrihgurdgruh
X-ME-Proxy: <xmx:bQROXk0RYWvSX8XHW3_T134k2VDgujGxZj2g3cGwOPID7lZ99eaVfw>
 <xmx:bQROXlcKRvnmMwA2u3KGHkgFQ9CaDcdLSW5WKDAFx70XUlVc1oXsbw>
 <xmx:bQROXpKyQIcFdohyQeHSiP4uwCW9C5642lydQpA5CgW9xB2_ru0PKg>
 <xmx:bgROXoW4MKK6ojP-dg6hd6S1AvBHr4B6-b3aRW6ngG27nDp8vbKq1Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B3C34E00C0; Wed, 19 Feb 2020 23:00:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-802-g7a41c81-fmstable-20200203v1
Mime-Version: 1.0
Message-Id: <de73618c-b7ff-4524-8182-727e6ada1429@www.fastmail.com>
In-Reply-To: <20200206112645.21275-2-clg@kaod.org>
References: <20200206112645.21275-1-clg@kaod.org>
 <20200206112645.21275-2-clg@kaod.org>
Date: Thu, 20 Feb 2020 14:30:39 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] aspeed/smc: Add some tracing
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
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

