Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F99C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 04:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19CA20675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 04:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="NjX4Q5Ji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aUzYjg76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19CA20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMmGE-00071r-Q2
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 00:26:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hMmFO-0006Sv-CT
	for qemu-devel@nongnu.org; Sat, 04 May 2019 00:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hMmFN-000157-BJ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 00:26:02 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40285)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hMmFM-00014G-VD
	for qemu-devel@nongnu.org; Sat, 04 May 2019 00:26:01 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 0090333357
	for <qemu-devel@nongnu.org>; Sat,  4 May 2019 00:25:57 -0400 (EDT)
Received: from imap26 ([10.202.2.76])
	by compute7.internal (MEProxy); Sat, 04 May 2019 00:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	h=mime-version:message-id:in-reply-to:references:date:from:to
	:subject:content-type; s=fm1; bh=u9Xa5ED4Qns+yBPDzZRXKqgxORvMcpa
	nG2VJljpFxTQ=; b=NjX4Q5JiSY0zjJRDU1Vxb/oKlVt2i4JBX7l7uydhhTNnOeY
	9HQPH5i8cSUFeKYUdqcBeGB7SYoESFWOp56syjg6LCAi8JvkgoyK6wL0BfSd1NMm
	uIo4z8Ho1EORfB46Y8K1snFVr50+zV8TUhrKtl0ccQeCen6Soxay8LFZMtz2VFSk
	SKbVBJx692hDsk057Qrr2q+IqX+Q720VjNdpmW4jQXlkSbCC/mBX3gAfR64QjSJD
	5g6SfnF7jw7fQSapqoRVdY5HgQuAYWfU+Tf118faRCpQ1r4TWSyye2nxvI3xe4/9
	jLXvtWN/o9pDtd72rZ/zctEYahv4GW7bzGevRpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=u9Xa5E
	D4Qns+yBPDzZRXKqgxORvMcpanG2VJljpFxTQ=; b=aUzYjg76+rfa5NWBK4RV2W
	H7c40G1EZoYI0TadHeD7CnFWok9C6QkEJZFpXGn68p+25Io5KcFK2buE4wAbh1c/
	P4IUqHYrPmN8KkWL24gpsgzH5BvPK7YKCuxMyX8jtp/VYcv2j2NQ2osNsyIYxbOh
	qklNIeyrQ6KYD5HlEZICvdcqskGbRYs1xw6yD3m6JF4AK2TjJGYsd1YIpg3cpLiQ
	Iq6kQ5wmHXfLO7XMpcQgYHoMqw2T1AtyFdB1b/xTx48PsU5cy0OilkJIEy7ZO/11
	eIoUlSODVmb5NTpeCySw/H1Jhd8sEwrGCkkSI90FfodCgHkv461k9EJNTCDHvm+w
	==
X-ME-Sender: <xms:VRTNXNK_ONiEmCyNU9IU__NNaf9DYsJ6eejJ4oMCoNGQcBQCJQwzxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjedvgdekhecutefuodetggdotefrodftvf
	curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
	uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
	dtreertdenucfhrhhomheptehlihhsthgrihhruceorghlihhsthgrihhrsegrlhhishht
	rghirhdvfedrmhgvqeenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrse
	grlhhishhtrghirhdvfedrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:VRTNXGs0XOkmm2X6XiI0Ahys42pWixAucNgj-vhBPInmRtyxlOmIqw>
	<xmx:VRTNXMLhrd5fQX6hp1LYkYzlbL1gmiyj2omAd7kT3B7983USEwemxA>
	<xmx:VRTNXP8_aquldJv8DvgAsNla4afAfbKSal7iGr1mx3p_WqY7OhSDAw>
	<xmx:VRTNXM8p_FogM9zlht_Ua8uAb5vrT_oqYv8arbvSXMQtPdLoIxG2QpVL-ng>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1881BB4470; Sat,  4 May 2019 00:25:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-449-gfb3fc5a-fmstable-20190430v1
Mime-Version: 1.0
Message-Id: <97245929-a8b5-4b67-bfee-656db4438cd0@www.fastmail.com>
In-Reply-To: <CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
	<CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
	<CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
Date: Sat, 04 May 2019 00:25:56 -0400
From: Alistair <alistair@alistair23.me>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.230
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504042556.fK0flm_VJWGipoycTtAVZAwoqqcUPGCfEqpeZ6BxgsI@z>

On Thu, May 2, 2019, at 3:06 AM, Peter Maydell wrote:
> On Tue, 30 Apr 2019 at 21:29, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, Apr 30, 2019 at 9:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > Can you explain the purpose of the reset code? None of the other
> > > v7m boards seem to need to do a manual qemu_register_reset().
> >
> > The reset code allows the machine to work with the -kernel option.
> > Without the reset override using -kernel results in the guest starting
> > at the wrong address. We can use the -device loader option without the
> > reset code though.
> 
> That sounds in line with how -kernel works on the other armv7m
> boards -- the expectation is that your image file includes a
> full vector table and the CPU will read the PC and SP from it
> when it resets. If you want "honour the entry point" you can
> use -device loader, as you say.
> 
> Ignoring the entry point for -kernel ELF files is certainly
> a bit confusing, but I think if we want to change this we should
> do it globally, rather than having one board which behaves
> differently to the rest. Changing it does have some awkwardness:

Hmm... That is a good point. It is confusing having something just for one board. I'll drop this part and we can re-evaluate later.

> * possibility of breaking previously working images

I have no way to test the other boards, so this might be difficult to change.

> * we can get the initial PC from the ELF entrypoint, but if
>  we do this what do we do about the initial SP value ?

Not sure about this one either. I'm guessing it changes between the different M cores.

Alistair

> 
> thanks
> -- PMM
> 
> 

