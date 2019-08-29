Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6431EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242A520856
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LmnOFb52";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awK6v7D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242A520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i39PJ-00015H-A5
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1i39OW-0000Zt-HD
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1i39OV-00009I-9K
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:38:36 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:54253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1i39OS-00006q-Gp; Wed, 28 Aug 2019 21:38:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 0127C692;
 Wed, 28 Aug 2019 21:38:29 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Wed, 28 Aug 2019 21:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm3; bh=LVPie1C5fos3rwKR0Fk/z2o0YAIqln0
 QtTZkZZi43mM=; b=LmnOFb52ycz31AUcCCdYrE/TIf4SkA4jhlDec3vfLOPGfm0
 mhfe0TeKUJHC57bITfFiffuYofz5oaeVr98o4ZAyA8ZfBLPN8JkcxLNaw2n9aJtI
 nG7S5/ZLle8xWYO0/lFU/vV660vKIq/dJxuNOhNbIw77511lrd0AjHFoci5jCWfG
 3af7/Fl7wyT2tovUmHxrfYJVIh8Z/ZB7FnGUOKvjXL/UcVEnsFhdELUalmmZheon
 BXLdG+JK1SVYOFETgZnpz2rgV79OvoG5cTtguyjifz+aEY0IOCCqPDRBE1c9i9oT
 AXs+EMrqT9Ain5rT22X7J9Tj3remDCgpO/YTyIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LVPie1
 C5fos3rwKR0Fk/z2o0YAIqln0QtTZkZZi43mM=; b=awK6v7D79UUM8kn1R+N8ul
 KofYZtYTIes7cAOxk2sg7IEQqOpXer1SCCsUPcxFQFi1nGqkQ3AMMoOFTlnI5ZSS
 xRQRv8l7JrANIhW4PPg4aC71C2eiH/Er+aPwO1EnNQF3TJTcNAWjq+Qlm3kFl5xr
 X3J5LlqzH6xFZVVgwHnnyGDPdIENELKkLmAhftZDlMGUjJ0oqnFarzJXjpOKbqwZ
 n5xXy0oUygmUbRJTu8Kt5OPP0HpWUdk0nLERAmZLB5iCsbg/TnV4UKdSHksQ1v/0
 AVFOj+l0UbB9hgOK3/hgCs00WXRTVxf9NM0BW3mudkPWr4U09Rzq/qB/CW57/3KQ
 ==
X-ME-Sender: <xms:lCxnXfUqYjMwP2lDhDScrPwwNN1c4UKi-tdrQ29Wy-p1t-ZRijp_XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiuddggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
 rhfuihiivgeptd
X-ME-Proxy: <xmx:lCxnXaYTAa-hpb0rbOqmktPiI4xtVeeLEzlyAvlbj02I7a9AQsG82g>
 <xmx:lCxnXeKKl83VlEvbmLpn4OGx0gkQOZ3ANc2hId-nsAry3IhsiBQ7bQ>
 <xmx:lCxnXd1dauJK2wa-7gjtoD-DOsIac59YSPnkbmOxcqhlwMAf1W2xiQ>
 <xmx:lSxnXcxmb4Z9A_PGFdlC8yoJn6YDy00U5ahx35egyoPxop82cUBfRQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 549DAE00A3; Wed, 28 Aug 2019 21:38:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-139-g73fcb67-fmstable-20190826v1
Mime-Version: 1.0
Message-Id: <4fd7e761-65e1-47f7-b7b4-ed90eafaae41@www.fastmail.com>
In-Reply-To: <CAFEAcA9dEKLneH5GJJsX84LTW_p9qBrGmr6yMxAYcNo-2EzHZg@mail.gmail.com>
References: <20190809054341.24728-1-andrew@aj.id.au>
 <CAFEAcA9dEKLneH5GJJsX84LTW_p9qBrGmr6yMxAYcNo-2EzHZg@mail.gmail.com>
Date: Thu, 29 Aug 2019 11:08:49 +0930
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



On Wed, 28 Aug 2019, at 01:39, Peter Maydell wrote:
> On Fri, 9 Aug 2019 at 06:43, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The use of GTIMER_SCALE assumes the clock feeding the generic timer is
> > 62.5MHz for all platforms. This is untrue in general, for example the
> > ASPEED AST2600 feeds the counter with either an 800 or 1200MHz clock,
> > and CNTFRQ is configured appropriately by u-boot.
> >
> > To cope with these values we need to take care of the quantization
> > caused by the clock scaling in terms of nanoseconds per clock by
> > calculating an effective frequency such that NANOSECONDS_PER_SECOND is
> > an integer multiple of the effective frequency. Failing to account for
> > the quantisation leads to sticky behaviour in the VM as the guest timer
> > subsystems account for the difference between delay time and the counter
> > value.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > v2:
> > 1. Removed the user-mode change that broke v1
> > 2. Rearranged the implementation as a consequence of 1.
> >
> >  target/arm/helper.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 48 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index b74c23a9bc08..166a54daf278 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -2277,6 +2277,34 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
> >
> >  #ifndef CONFIG_USER_ONLY
> >
> > +static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
> > +static void gt_cntfrq_write(CPUARMState *env, const ARMCPRegInfo *ri,
> > +                            uint64_t value)
> > +{
> > +    uint64_t scale;
> > +    ARMCPU *cpu;
> > +    int i;
> > +
> > +    raw_write(env, ri, value);
> > +
> > +    /* Fix up the timer scaling */
> > +    cpu = env_archcpu(env);
> > +    scale = MAX(1, NANOSECONDS_PER_SECOND / value);
> > +    for (i = 0; i < NUM_GTIMERS; i++) {
> > +        if (!cpu->gt_timer[i]) {
> > +            continue;
> > +        }
> > +
> > +        cpu->gt_timer[i]->scale = scale;
> 
> Reaching into the internals of a QEMUTimer and changing
> the 'scale' value seems like a bad idea. If QEMUTimer doesn't
> have a facility for changing the frequency and we need one
> then we should add one at that API layer.

Yeah, fair point. It is an RFC patch for these kinds of reasons -
I solved the problem but wasn't at all convinced about the
shape of the solution.

> 
> Also, this isn't how the hardware works, I'm pretty sure.
> In hardware the timers tick at whatever frequency they're
> set up to tick, and CNTFRQ is just a reads-as-written register
> that firmware can fill in with an appropriate value that it's
> determined from somewhere for the benefit of other software.

Yes, I think you're right. Again, as above this got rid of the
problem, but needed some massaging. The write just was a
handy hook point to inject the change of frequency.

> 
> If on ASPEED SoCs the timer frequency is different, then we
> should model that by having CPU properties for timer frequency
> and having the SoC set those properties, I think.

Sounds good, I'll work on that approach.

Thanks for the feedback.

Andrew

