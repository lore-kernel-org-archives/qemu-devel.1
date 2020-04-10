Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B3C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B5E2082D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="K4KQ2abF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1VpBk1St"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B5E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMtpT-0003b4-Hu
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 09:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1jMtoj-00030e-1E
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1jMtoh-0003YD-VM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:35:32 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45975)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>) id 1jMtog-0003WM-LX
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:35:30 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 0CB17591;
 Fri, 10 Apr 2020 09:35:28 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Fri, 10 Apr 2020 09:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm2; bh=HDw5IXRazEOaekki98SW4r0ZWV5bu15
 aBHY7fP98FCo=; b=K4KQ2abF6OTNvWL7ZPO8iZM7qGfPK4BXhFMEEwBF8i6GkG6
 53sP7iFxak5CIUq2ansbK0M1+SvzzuIUk1RVMLwZu4TwSCzzPioGB2aLaCGDWfY/
 ikvcQU0yRv1RrGF8Q+lK7wzlRz+p7VPH2YLqXqJm30wnwNfuOLG1AFPkpwtqCZ2M
 e/ZNT5HTBF3/jhADXcOuN4KD2DDzSawDrOHPjIr7aXQz1ksVXHsLEFXu/SzAwCLx
 mj56OlbhlFK3px6BzBfOUT6BW1PX3VxqRjrdQL3Vn+WR9K05+jGeXmvc8KllWDFq
 forKNvD1BgynSqhGZKcBTipauZ9s3Dq9p2hrJxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=HDw5IX
 RazEOaekki98SW4r0ZWV5bu15aBHY7fP98FCo=; b=1VpBk1StziBF7YIECsNTxz
 vZAVTVo0KSMaS5kj44CoLxXDDfHa9Ck308ZVJs0qQbMq1ppb1nLLJxDQe3hv+pcX
 AhcWNR28wBI+vwH2njpEF/tOlQQ7mmdTbCk57dSIiWoGfrYWBGnLJ6qNXBzuLeNu
 btdCZOtIwwyd03pl58OJdi3HpDi4qVfdWqrVFVHQYjFGTDlOuvFao/LBDX6uKxPs
 8S+LVfgI75KLhVCGuoTW3p6qs/qoFTrExbPtg0Rvli1353MKnuJLD0LxAxCVBYeC
 iomz1Il8QfNpT0+Bkj3CSkjVXjcN3vM0RWADezRdwx078srXJceLSDkq+D+MWzHw
 ==
X-ME-Sender: <xms:H3aQXnXT_RBdaXjXKanhHAQoW6y9AjjfPzV4skVQlEaExqDuLCki9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddvgdeikecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
 vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
 rdhiugdrrghu
X-ME-Proxy: <xmx:H3aQXhYSk7NSWwdkhmq5aTqJXE3izc_Q_kTXL0ukvSR03bil0Fjvrg>
 <xmx:H3aQXlKhi_aXlvy4lGlkM9aIRH6ZcvkD0vMLjzkZY7fwp6Tyq554cw>
 <xmx:H3aQXjgmHQhZLZYFTC_H4F9WWGxqrPNM7AssOGk4i2cQ0rHSgciZXw>
 <xmx:IHaQXq7vZ-9-zhY-cpJ37-_7dew_qK8lPpWyOup7laThVyhGt96zfA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 712AEE00A5; Fri, 10 Apr 2020 09:35:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1104-g203475c-fmstable-20200408v2
Mime-Version: 1.0
Message-Id: <3a0ef208-aa2e-400f-b5c8-d9920bee0b5a@www.fastmail.com>
In-Reply-To: <CAFEAcA-TrDeO2xKWYbxLfAuavGQkzsH-etQogv9LVQvF+j=U4w@mail.gmail.com>
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
 <CAFEAcA9FSVzxwudyaDoCty8B+Up33caM20qytLNO7HAXWmcwtg@mail.gmail.com>
 <CACPK8Xc3mpoakAqq2_wccCH6_2i+V4NB61CmdxtMecJ4ejzgmQ@mail.gmail.com>
 <CAFEAcA9erXezwsn_UaXJz0SL5Zaj=UmjTO0LPg0LDM4P50tjHQ@mail.gmail.com>
 <9e8076d0-6704-4ff6-bcc7-90b71ac398db@www.fastmail.com>
 <CAFEAcA-TrDeO2xKWYbxLfAuavGQkzsH-etQogv9LVQvF+j=U4w@mail.gmail.com>
Date: Fri, 10 Apr 2020 23:05:51 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Joel Stanley <joel@jms.id.au>, Cameron Esfahani <dirty@apple.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Fri, 10 Apr 2020, at 21:56, Peter Maydell wrote:
> On Fri, 10 Apr 2020 at 04:42, Andrew Jeffery <andrew@aj.id.au> wrote:
> > IIRC Phil wanted to enable sub-word accesses to the sample value
> > registers but I didn't want to spread logic dealing with different access
> > widths through the model. We already had a mechanism to describe the
> > model's  supported access sizes (as opposed to the valid access sizes
> > allowed by hardware) in the `impl` member of the MemoryRegionOps, so
> > I was trying to use that, but it didn't work as I needed.
> >
> > The accesses generated at the point of the guest MMIO need to be
> > expanded to the access width supported by the model and then the
> > resulting data trimmed again upon returning the data (in the case of a
> > read) via the MMIO operation.
> >
> > So the intent was less about unaligned accesses than enabling models
> > implementations that only have to handle certain-sized access widths.
> > It happens to help the unaligned access case as well.
> 
> Yeah, we definitely could do with improving things here, it is annoying
> to have to write code for handling some of the oddball cases when you
> have just one register that allows byte accesses or whatever.
> The thing I have in the back of my mind as a concern is that we have
> had several "is this a buffer overrun" questions where the answer has
> been "it can't be, because the core code doesn't allow a call to the
> read/write function for a 4 byte access where the address is not 4-aligned,
> so my_byte_array[addr] is always in-bounds".
> So if we change the core code we need to make sure we don't
> inadvertently remove a restriction that was protecting us from a guest
> escape...

Oh for sure. The patch was very RFC, as mentioned I just sent it to check
whether I was on the right track or off in the weeds, and from there it has
hung around in Cedric's tree without much progress.

Feels like the time is right to sort the problem out properly, which might
mean starting from scratch to make sure we don't miss any of the details.

Andrew

