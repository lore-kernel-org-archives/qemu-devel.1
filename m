Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68869C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 03:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED5D214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 03:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="G6/Q01Qf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v31LoSfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB9go-0003DN-7r
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 23:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iB9fw-0002gP-RH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 23:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iB9fv-0008N8-NZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 23:33:40 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42949)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iB9ft-0008Kx-1c; Thu, 19 Sep 2019 23:33:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 626B8494;
 Thu, 19 Sep 2019 23:33:34 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Thu, 19 Sep 2019 23:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm3; bh=ah7cQPmHf2Gk7WcmfSJ5XdfKJIREpKF
 JSm/kt3ZWmFo=; b=G6/Q01QfqhKg5dseK28VH/R7gwDemg3+6F/2TdBowN/E4HY
 ODzE/xsjZoLquflwS7z0EkzbHS6PXyjUkzLIMtDzhsdd7TfDFyq7TXjA+3sAu8ZR
 aXWhLumurK29+DusijthSrna+3zXK1CSgC6jfOEwuzlZbYb5u2nP51cFxhd9nQtf
 TgDj2K/LbwivUlqtq1zvKAprGwDl6tDSwghXMc9zqLHDQvJAJddt4w/9H6NXBpVb
 ivDLs8UjFz4kBbmLqmMQNiD/SuPbIca2drMr+Ev6ZpQ/EsgqCuVbOsVjP6A83Ogg
 OudiiJ/Nq+wMi3YIZwRhUvijJsF7iSApokCJj2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ah7cQP
 mHf2Gk7WcmfSJ5XdfKJIREpKFJSm/kt3ZWmFo=; b=v31LoSfYj19Xbu4DkDvcuW
 Jf/3E7GPBUkDMdXazvQHnBcRqkOsruG82fSjZUTBjuBntaEu2kj+AA1e7GuAaFqf
 ZHC6uocI4/OTUlTTudcKnHXNex4LLAWTB/HOCDe4y4nKgQTyfH0UBDSU8cQk2m8X
 vQ1bxKKKrN1lVygWJHN4RaFMeCS7oFVhSbMVS0TAoPmXpzdd4OdVenv4dETAwO2b
 7/cfIplJTyr0AkCpVB6h3TSFu7Ms9mLnmXWZdpLFBTlXmuTaIJzsb9OO5LxXeFoq
 k5Pp63wfT0Z1PpToZ2P3E/C9qLhY0mm4nOuPB5Cq/+efwKFPn8t+947NYT7W0emA
 ==
X-ME-Sender: <xms:jUiEXRV0InU27Zg5MMJYUHj-gIyNb1H81FyjRG5KwgQD5VFFq1G_mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddugdejvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
 vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
 hinhepphgrthgthhgvfidrohhrghenucfrrghrrghmpehmrghilhhfrhhomheprghnughr
 vgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:jUiEXV3nTNuhZjAjMjqZmSL1tPhZiKnm6Nm7LUgsr6Gmj1noU8DrAw>
 <xmx:jUiEXQ8EqWl36QYLCHaPI49FcAqM6mtRuCJb20jHNcOzx27-3xKVWQ>
 <xmx:jUiEXTdFnO6s4pR_xVoeq2chKJOZDwKJANwmps4CpdmbROJNzWVWug>
 <xmx:jkiEXbnAi8Y76nL3m_YXWcrEpkmuhgPHzylakmvqsCvDard3FsgYQw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1EAB3E00A9; Thu, 19 Sep 2019 23:33:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-238-g170a812-fmstable-20190913v1
Mime-Version: 1.0
Message-Id: <d0707b66-4446-457b-a5fa-2b4225db9ad5@www.fastmail.com>
In-Reply-To: <156892658765.2125.17871103047730488122@1c8ae44fe5c0>
References: <156892658765.2125.17871103047730488122@1c8ae44fe5c0>
Date: Fri, 20 Sep 2019 13:04:09 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: no-reply <no-reply@patchew.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: =?UTF-8?Q?Re:_[Qemu-devel]_[PATCH_00/21]_aspeed:_Add_support_for_the_AST?=
 =?UTF-8?Q?2600_SoC?=
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 64.147.123.20
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Fri, 20 Sep 2019, at 06:26, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190919055002.6729-1-clg@kaod.org/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the 
> testing commands and
> their output below. If you have Docker installed, you can probably 
> reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
> libudev           no
> default devices   yes
> 
> warning: Python 2 support is deprecated
> warning: Python 3 will be required for building future versions of QEMU
> cross containers  no
> 
> NOTE: guest cross-compilers enabled: cc
> ---
> Property '.cntfrq' not found

Ah, we should drop the patch introducing the CNTFRQ configuration for the 2600
as well given the patch adding support to configure it isn't part of the series.

Andrew

