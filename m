Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965CC2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 03:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536D52051A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 03:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="YH8sw4z3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhGmGTS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536D52051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMkaj-0005pq-Ex
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 23:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1jMkYg-0002gt-CO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1jMkYe-0008DF-UF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:42:22 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46471)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>) id 1jMkYe-0008Ci-Fg
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:42:20 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id EDDDC5C00A4;
 Thu,  9 Apr 2020 23:42:18 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Thu, 09 Apr 2020 23:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm2; bh=fOKPc3YI3q/NXP+x0EVRaUlZVrZw9OO
 Pfm+ZgwKP6Yc=; b=YH8sw4z3CAeqT6XwegB1837zFN5uz/q32vZ0gkdg6D/XZGN
 urxHV4Sov69PcBKvrtmxJEFB5D/818InyrFsrZIw2b8ugxhlEntw1sYq9yFtl19f
 EJDLIE9A3rPfU2eAMGDGBqfsnhcusc4mpHXp5Fu9idND1j3otQHx1GOBVCOQbpfT
 4WTHBarhsqeQ7O0AEgizIoOmWnsWTdghydyIwL0Ziuqk5nVZ10TiNJ29M0e/302y
 pOjZMl5/YpUg31yMdEmMRLPouz40lP3rujqiYkxfJ5sQTj2xD7Trf8SJO9MHl26n
 vPbP/lm5rcywGFtMGsOteNDbEV67ruXoqwcjvKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fOKPc3
 YI3q/NXP+x0EVRaUlZVrZw9OOPfm+ZgwKP6Yc=; b=ZhGmGTS0qv9rPrsfH6FsOX
 NMHlpRu++hn0T1W4A7+jX0bpr42qFKIG8CFmRPyeHSPDYJaIZw3lpA+wXhlArYWh
 45/C2FgyfHKFkLPflhZ2l+3jCl68ez2hsxCKQhoZfbUkoed7pwSgTH/MIsNkSNc/
 uQkQu4rPpERbG72tJ8mKICQqVHOXIRZgIp1uWw+eDTUW6BPeLRk8NA1yCZxgQFC7
 CR7QbPGq48wJftGdEEogvHEOAJucMOvojEeYBecL6Pe4VXPJ4PU+F8GL5IPkVaEP
 LODD08udoQSWRftraTO+yH4B5OXgVTM9u0g6FpfGaC73BbVnNqMsYzyS8765etvg
 ==
X-ME-Sender: <xms:GuuPXuG6oudMXRa8j8HJxNBfq4dFFlpfI5dm_KRhph3fBqUdKrmRwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddugdejfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
 vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
 hinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:GuuPXvjT8PY0-YdG0SNTEkLQLdD46DCmpZhvoRcY944jLHBi8Vfj6g>
 <xmx:GuuPXqx1fk8sENiI6Yjtnsq_xqunGw3ViviE8YhWcbviyewPNO_zWA>
 <xmx:GuuPXjqZoG_x9ZY2-F_i9ncnMrV-e3-yECFWvdosVysA9wKQ2TKjew>
 <xmx:GuuPXin4nFVv321YJ0kmZW9gAAFL7MoTgbm1cXI6eSGQSZBKtDsHkA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id EE178E00A5; Thu,  9 Apr 2020 23:42:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1104-g203475c-fmstable-20200408v2
Mime-Version: 1.0
Message-Id: <9e8076d0-6704-4ff6-bcc7-90b71ac398db@www.fastmail.com>
In-Reply-To: <CAFEAcA9erXezwsn_UaXJz0SL5Zaj=UmjTO0LPg0LDM4P50tjHQ@mail.gmail.com>
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
 <CAFEAcA9FSVzxwudyaDoCty8B+Up33caM20qytLNO7HAXWmcwtg@mail.gmail.com>
 <CACPK8Xc3mpoakAqq2_wccCH6_2i+V4NB61CmdxtMecJ4ejzgmQ@mail.gmail.com>
 <CAFEAcA9erXezwsn_UaXJz0SL5Zaj=UmjTO0LPg0LDM4P50tjHQ@mail.gmail.com>
Date: Fri, 10 Apr 2020 13:12:06 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Peter Maydell" <peter.maydell@linaro.org>, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.28
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tue, 7 Apr 2020, at 18:20, Peter Maydell wrote:
> On Tue, 7 Apr 2020 at 09:45, Joel Stanley <joel@jms.id.au> wrote:
> > On Tue, 7 Apr 2020 at 08:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > Do you have a link to this patch, please? I had a quick search through
> > > my mailing list articles but couldn't see anything obviously relevant.
> >
> > There is a reference in this thread:
> >
> > https://lore.kernel.org/qemu-devel/dd8fc1f7-56d9-4d9f-96a4-0fdcafdc8f55@www.fastmail.com/
> >
> > The patch is here:
> >
> > https://lore.kernel.org/qemu-devel/20170630030058.28943-1-andrew@aj.id.au/
> 
> Oh, that's from 2017, no wonder I couldn't find it!

Yeah, I never quite got back to finishing it :(

It's development was driven by development of the ASPEED ADC model,
which I hacked up in the interest of getting the ASPEED SDK booting
under qemu (the SDK kernel had an infinite spin waiting for the ADC-ready
bit).

IIRC Phil wanted to enable sub-word accesses to the sample value
registers but I didn't want to spread logic dealing with different access
widths through the model. We already had a mechanism to describe the
model's  supported access sizes (as opposed to the valid access sizes
allowed by hardware) in the `impl` member of the MemoryRegionOps, so
I was trying to use that, but it didn't work as I needed.

The accesses generated at the point of the guest MMIO need to be
expanded to the access width supported by the model and then the
resulting data trimmed again upon returning the data (in the case of a
read) via the MMIO operation.

So the intent was less about unaligned accesses than enabling models
implementations that only have to handle certain-sized access widths.
It happens to help the unaligned access case as well.

> 
> Does somebody who's already reviewed the patch want to summarize
> what the effects on devices are -- i.e. what calls the device's read/write
> methods used to get if the guest did an unaligned access, including an
> unaligned access half off-the-end of the memory region, and what
> calls the read/write methods get after the patch ? The patch's commit
> message doesn't really describe what it's doing...

Honestly any of that information has well left my memory at this point, I'd
have to analyse the patch to recover it.

I was hoping that my turn-around time would be shorter than 3 years but
there hasn't been a shortage of fires to put out in the mean time.

Andrew

