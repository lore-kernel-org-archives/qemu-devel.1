Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9021EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 23:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5675F20640
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 23:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Zs5Nk6iX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HE6E0A+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5675F20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibvRQ-0004kL-DY
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 18:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ibvPL-0003S4-63
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ibvPK-0004LH-1Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:47:11 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42123)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ibvPC-00049z-72; Mon, 02 Dec 2019 18:47:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 81CD8F8A;
 Mon,  2 Dec 2019 18:46:58 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Mon, 02 Dec 2019 18:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm1; bh=T1YLlY9V/qV1QpYaEv4Ka5wkXLx/BWa
 EadcqV8jlgZo=; b=Zs5Nk6iXLrth+cygCz1YEZOxWYX5H8Zz1TyKzMOP5YAZOlV
 kIIyrQ3EHP+Q3nhoaczdqp/zyoSYH5ztyN7s4sBG+MD6noDEhHYZ+mc/m+FDP1Mt
 4PrtrH0aB55M3UoHkFn//Ns9qwlpGRjO2L0zh6nNZ97DaTgRVCfy/wY18EAkJaJh
 +RTUDFiphzDWmg/FAkNRHeGZ2h1oO8+RHXvhRtKcLVDFHXdW3FV6JUHQWHB0qA2J
 xFIHZUrhsgKBaCP8HjxiWSsAcMh3ydbXsLTB8GwMwrLSouPbn3y7yhYUpFXgonwq
 2btMbULw8ejk4Iq4Fc0+/oXS6bgeZ/7GyH0gSDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=T1YLlY
 9V/qV1QpYaEv4Ka5wkXLx/BWaEadcqV8jlgZo=; b=HE6E0A+/I7ZX5ch2uzMG/Z
 GJ41RgedyqXgFMl6gOBcvdYN+kQqJGxMbl7H90XdzQ8aCq+F70yF2nByJaU9nh8l
 VWWiv3hYceENtuv/hqHug/XY4qI/tRV9Mh6FJl7s2Njt7TbSvhDaT8CQ7F0UIlnU
 AFZCDGhKYez61r7InE3fxMcV7+VqLcmEp/YxOJi6/YRgKswng4wzddVmDaB9FYeC
 IM4GK4TpptwyJOPjpVm0ea16YsbRUs/KG6kwlnJT4R3d8xWhVVJRifkKe1me3vk7
 yxsrToiyXxuTuFxCB25geCXxCEFYV4ULzhhSKA/L0UzIz/M0ZtGTqwekdjfJ0hFg
 ==
X-ME-Sender: <xms:caLlXY2hduFBz4pPrQfpnm44Y-hhwsFa1H-KrB5NN5L4M5eSdbP4yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejiedguddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
 rhfuihiivgeptd
X-ME-Proxy: <xmx:caLlXWesRFtPMrts7kFSg1zojsYR3JY3mi8CVl-bZO8ZQnlCYMdbig>
 <xmx:caLlXXiHPQW6Orgboz1tgECrWxkh74LiNPIiA79aB8ESfZjF6GjIWA>
 <xmx:caLlXaLtTb_ydif9dyyNmhR3g8fJcZBEAqJr55bzM69sYHOFI98y2g>
 <xmx:cqLlXV7mePgUUeKwdGVNbvIAmX7jLjYHm_njQCEAduKdexdMD9RmiA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6C820E00A2; Mon,  2 Dec 2019 18:46:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <b9632739-5df1-4b88-aede-abb897424cc5@www.fastmail.com>
In-Reply-To: <CAFEAcA99yzysf0J=n1yYgtxBmBDvi8-=CrCO6kdymt8Woo9t1Q@mail.gmail.com>
References: <20191128054527.25450-1-andrew@aj.id.au>
 <20191128054527.25450-3-andrew@aj.id.au>
 <CAFEAcA99yzysf0J=n1yYgtxBmBDvi8-=CrCO6kdymt8Woo9t1Q@mail.gmail.com>
Date: Tue, 03 Dec 2019 10:18:32 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] target/arm: Abstract the generic timer frequency
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.21
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tue, 3 Dec 2019, at 04:42, Peter Maydell wrote:
> On Thu, 28 Nov 2019 at 05:44, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Prepare for SoCs such as the ASPEED AST2600 whose firmware configures
> > CNTFRQ to values significantly larger than the static 62.5MHz value
> > currently derived from GTIMER_SCALE. As the OS potentially derives its
> > timer periods from the CNTFRQ value the lack of support for running
> > QEMUTimers at the appropriate rate leads to sticky behaviour in the
> > guest.
> >
> > Substitute the GTIMER_SCALE constant with use of a helper to derive the
> > period from gt_cntfrq stored in struct ARMCPU. Initially set gt_cntfrq
> > to the frequency associated with GTIMER_SCALE so current behaviour is
> > maintained.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> > +static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> > +{
> > +    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECOND? */
> > +    const unsigned int ns_per_s = 1000 * 1000 * 1000;
> > +    return ns_per_s > cpu->gt_cntfrq ? ns_per_s / cpu->gt_cntfrq : 1;
> > +}
> 
> This function is named gt_cntfrq_period_ns()...
> 
> >  static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
> >  {
> > +    ARMCPU *cpu = env_archcpu(env);
> > +
> >      /* Currently we have no support for QEMUTimer in linux-user so we
> >       * can't call gt_get_countervalue(env), instead we directly
> >       * call the lower level functions.
> >       */
> > -    return cpu_get_clock() / GTIMER_SCALE;
> > +    return cpu_get_clock() / gt_cntfrq_period(cpu);
> >  }
> 
> ...but here we call gt_cntfrq_period(), which doesn't exist,
> and indeed at least one of the patchew build systems reported
> it as a compile failure.
> 

Ah yep, I failed to test user mode after renaming the function and missed this.

I haven't seen an alert from patchew though, I wonder where that got to?

Andrew

