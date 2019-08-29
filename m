Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91562C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B88C20856
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="iUZQ7Y+S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZ+weQuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B88C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i39Re-0002eW-Hv
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1i39Qo-00027f-M6
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1i39Qn-0000jX-LQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:40:58 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1i39Ql-0000ix-BG; Wed, 28 Aug 2019 21:40:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 1B9966A3;
 Wed, 28 Aug 2019 21:40:54 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Wed, 28 Aug 2019 21:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm3; bh=ShfIbLfI8AI5s/PHeWY2YywrjtllFmT
 6P69tTyvhcwc=; b=iUZQ7Y+S29XOkpKCHSKFlyXpNbdJJUWSznlkhpGZFIUoJsp
 dDlVhbl1YN/WXu0oIyKcLfSqd5gIwDhSnV/1BFp6kAuSkMW+B2FzvQQ8Im6CSExm
 uYNPcBIpoqwze0RwqCauaP8Wg4/liht27Nu+Fukr2qcWy6ExDicQJb+9GKlR+sdI
 u1JU2U9zLVJkKowaQK9BHy7aWqBkwpEqJpcWCImAfC407vqeblIheWESj+5yPVz5
 fDc827LhcAIWuxFUPg8YBlc6QyluOkQ8xxY6MaFKZjVLoiD8InLQWpoolwteOE0f
 ul7+1i9Gz0jwLWOb9VZA0lpTlCy2XxtVdKiDSwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ShfIbL
 fI8AI5s/PHeWY2YywrjtllFmT6P69tTyvhcwc=; b=XZ+weQuUC1EUiRIOcOabfB
 Wm8WG4JH/pmiFW8N9uekc7yo6e+YZ/StJ4MApCRHSOZxJNzOrv5qE0aNRJE+Z3/o
 RPY68uleTzMnSIX4gJY5rUd6kmVn+niAcgrXMumovNCpcgEsafZeyjr9WmSmAqYO
 ewfaCxJ7MlTzL5pw0Pn93yQNwLbX7llENmiaEZ3PpOxRsaF4pkxNURY+c3Z8rCPu
 Ih90loOPGW1LkcsBc8XOOVITp99pYPnj125EBtSY9r3v0XQxoItKOb2VH4EvsPGa
 snN2lmf1/Ej07SK0w9YmBetfuA4sfsJW0zih2isl8DdCm/jtOhP1zn8wvfEh75Ww
 ==
X-ME-Sender: <xms:JC1nXc9ZizH9tu6Y-B2GjDm7hFL78X2VWQ-3L1fR63VZoMokOyw1cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiuddghedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
 rhfuihiivgeptd
X-ME-Proxy: <xmx:JC1nXdU1qzpzfM5ofYwBrou97DfVlZi-eTunuhf_PRbdlClY__SAdg>
 <xmx:JC1nXWcf4T1xfzo17Ype2pI-NecELLXzSIF1lCWcSFVu032qAgs3Zg>
 <xmx:JC1nXf8T1HS-W19igIP50y5RtL3oikcrseZlpO0v5OFLEIAPqgERdQ>
 <xmx:JS1nXdorRIIP8NE4JXeZ2zYh_QaNdsF3qg6CnrolOVC63EGBZlTpXQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9286CE00A3; Wed, 28 Aug 2019 21:40:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-139-g73fcb67-fmstable-20190826v1
Mime-Version: 1.0
Message-Id: <453779dd-e66a-41e5-95e2-5268d799903e@www.fastmail.com>
In-Reply-To: <4fd7e761-65e1-47f7-b7b4-ed90eafaae41@www.fastmail.com>
References: <20190809054341.24728-1-andrew@aj.id.au>
 <CAFEAcA9dEKLneH5GJJsX84LTW_p9qBrGmr6yMxAYcNo-2EzHZg@mail.gmail.com>
 <4fd7e761-65e1-47f7-b7b4-ed90eafaae41@www.fastmail.com>
Date: Thu, 29 Aug 2019 11:11:14 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Peter Maydell" <peter.maydell@linaro.org>
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 64.147.123.24
Subject: Re: [Qemu-devel] [PATCH v2] target-arm: Make the counter tick
 relative to cntfrq
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, 29 Aug 2019, at 11:08, Andrew Jeffery wrote:
> 
> 
> On Wed, 28 Aug 2019, at 01:39, Peter Maydell wrote:
> > On Fri, 9 Aug 2019 at 06:43, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The use of GTIMER_SCALE assumes the clock feeding the generic timer is
> > > 62.5MHz for all platforms. This is untrue in general, for example the
> > > ASPEED AST2600 feeds the counter with either an 800 or 1200MHz clock,
> > > and CNTFRQ is configured appropriately by u-boot.
> > >
> > > To cope with these values we need to take care of the quantization
> > > caused by the clock scaling in terms of nanoseconds per clock by
> > > calculating an effective frequency such that NANOSECONDS_PER_SECOND is
> > > an integer multiple of the effective frequency. Failing to account for
> > > the quantisation leads to sticky behaviour in the VM as the guest timer
> > > subsystems account for the difference between delay time and the counter
> > > value.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > > v2:
> > > 1. Removed the user-mode change that broke v1
> > > 2. Rearranged the implementation as a consequence of 1.
> > >
> > >  target/arm/helper.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 48 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > > index b74c23a9bc08..166a54daf278 100644
> > > --- a/target/arm/helper.c
> > > +++ b/target/arm/helper.c
> > > @@ -2277,6 +2277,34 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
> > >
> > >  #ifndef CONFIG_USER_ONLY
> > >
> > > +static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
> > > +static void gt_cntfrq_write(CPUARMState *env, const ARMCPRegInfo *ri,
> > > +                            uint64_t value)
> > > +{
> > > +    uint64_t scale;
> > > +    ARMCPU *cpu;
> > > +    int i;
> > > +
> > > +    raw_write(env, ri, value);
> > > +
> > > +    /* Fix up the timer scaling */
> > > +    cpu = env_archcpu(env);
> > > +    scale = MAX(1, NANOSECONDS_PER_SECOND / value);
> > > +    for (i = 0; i < NUM_GTIMERS; i++) {
> > > +        if (!cpu->gt_timer[i]) {
> > > +            continue;
> > > +        }
> > > +
> > > +        cpu->gt_timer[i]->scale = scale;
> > 
> > Reaching into the internals of a QEMUTimer and changing
> > the 'scale' value seems like a bad idea. If QEMUTimer doesn't
> > have a facility for changing the frequency and we need one
> > then we should add one at that API layer.
> 
> Yeah, fair point. It is an RFC patch

Ugh, I just looked at the subject and realised I hadn't added "RFC".

Too many things going on :/

Andrew

