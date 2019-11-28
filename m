Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808B9C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 22:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADDE2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 22:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="gu8le+RW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPMlkMvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADDE2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaSQA-00063n-P5
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 17:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iaSGo-0003HN-R2
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 17:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iaSGi-00056c-Jk
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 17:28:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iaSGR-0003gJ-NB; Thu, 28 Nov 2019 17:28:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id CB2A522860;
 Thu, 28 Nov 2019 17:27:48 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Thu, 28 Nov 2019 17:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=ngIkV
 +IylyGSLmLHT3SURjuY4VgUj/m7vqSNbsEu9W0=; b=gu8le+RWUG+hq9YGbaRhl
 nmIcW87GDXnNjH2soGplvyx60HKZVOhjrVczwa5taSh9AXX1yaGfgjKLFHPAqQMo
 9npA/tGvH4fQeUTpzIhaPBAkJ5fTVxJ03aLt8vyISo1Rbvzc1ykX4HglU0MZzaj0
 ZnWvOo2GcXgqvp9UvA3veqaETSMv+zNOdtwemJjsZRn7KBnoTGx1OFNBhlkOmw5Y
 BMqz8TtwkJrb3KjS2yldmalHNsu0rt/UPZvRcVUDLF+4VGth5Rg6Ua6t8oHozP9G
 /ZTEb2bQW6bEpvWHroygSno8/3wfH2RBbGFTiO2CuJBxO+lhrJzOApF7D3u3Mye9
 Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=ngIkV+IylyGSLmLHT3SURjuY4VgUj/m7vqSNbsEu9
 W0=; b=VPMlkMvM/Q2MlEzb0poKQ95bHHrr8kJlbfE/zJJycc8n3i8Co/+cWo5fK
 Sxnx9LSorvoKFOygZfrsSh9eZzwd1gBLlZzxcVdYcLNzjgHbuMuCeKkffB9dkgfd
 BBqdoLuXuggo2ytvrWZemiFQTuGjE98zPxNRrOVFm40/oILweF9zI0I96r1Khfmt
 BG+HYLchWJjfhc7l6M3+VOWpSHIT9ClWRF+DEjQyEY/iQ7Iy7p5yXB9EceopkPFW
 ICEtQOHoarE7ufkmgkP7RfLMsaBPlrdrHd4VMp7LxDktNg4PBzQGJXGm9a37/TLz
 na2i5IakZNQRMJFa7pNIYHIkd3kJw==
X-ME-Sender: <xms:5EngXTNIO1iMarInyKyq-twznGXRN8UFofjDrWIpJwPVPWtiYibAYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedgudehkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurf
 grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhs
 thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:5EngXYaejjruOnt6Nx-XF2JWe9XvyrPKX7Xxv6WGhnp7XOw1ZINflA>
 <xmx:5EngXZAyiIj_0oFxj_cs1JJprC8gaw9N4rdFn_HB_eQzuRAm-c66NA>
 <xmx:5EngXSLavFztRmcFPWZqcYuaihZ8NKUPTPiYfPEG0HF97G_2f7X9GA>
 <xmx:5EngXd_xodcRSok4iCN0NCmOS_5bgMmUYV6EL4-deMRrko8Q0sQtSg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 44F86E00A2; Thu, 28 Nov 2019 17:27:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <1d967cfe-c3bf-47bb-806f-8d8290d5bf1a@www.fastmail.com>
In-Reply-To: <cd0b8fe7-ce7a-1ba4-2c5c-1bec0a2d1a57@kaod.org>
References: <20191128054527.25450-1-andrew@aj.id.au>
 <20191128054527.25450-3-andrew@aj.id.au>
 <cd0b8fe7-ce7a-1ba4-2c5c-1bec0a2d1a57@kaod.org>
Date: Fri, 29 Nov 2019 08:59:19 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH 2/4] target/arm: Abstract the generic timer frequency
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.26
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, 28 Nov 2019, at 19:16, C=C3=A9dric Le Goater wrote:
> On 28/11/2019 06:45, Andrew Jeffery wrote:
> > Prepare for SoCs such as the ASPEED AST2600 whose firmware configure=
s
> > CNTFRQ to values significantly larger than the static 62.5MHz value
> > currently derived from GTIMER_SCALE. As the OS potentially derives i=
ts
> > timer periods from the CNTFRQ value the lack of support for running
> > QEMUTimers at the appropriate rate leads to sticky behaviour in the
> > guest.
> >=20
> > Substitute the GTIMER_SCALE constant with use of a helper to derive =
the
> > period from gt_cntfrq stored in struct ARMCPU. Initially set gt_cntf=
rq
> > to the frequency associated with GTIMER_SCALE so current behaviour i=
s
> > maintained.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  target/arm/cpu.c    |  2 ++
> >  target/arm/cpu.h    | 10 ++++++++++
> >  target/arm/helper.c | 10 +++++++---
> >  3 files changed, 19 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 7a4ac9339bf9..5698a74061bb 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
> >      if (tcg_enabled()) {
> >          cpu->psci_version =3D 2; /* TCG implements PSCI 0.2 */
> >      }
> > +
> > +    cpu->gt_cntfrq =3D NANOSECONDS_PER_SECOND / GTIMER_SCALE;
> >  }
> > =20
> >  static Property arm_cpu_reset_cbar_property =3D
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 83a809d4bac4..666c03871fdf 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -932,8 +932,18 @@ struct ARMCPU {
> >       */
> >      DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
> >      DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
> > +
> > +    /* Generic timer counter frequency, in Hz */
> > +    uint64_t gt_cntfrq;
> >  };
> > =20
> > +static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> > +{
> > +    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECON=
D? */
> > +    const unsigned int ns_per_s =3D 1000 * 1000 * 1000;
> > +    return ns_per_s > cpu->gt_cntfrq ? ns_per_s / cpu->gt_cntfrq : =
1;
> > +}
>=20
> Are you inlining this helper for performance reasons ?=20

Originally I was going to do it as a macro in order to avoid redundantly=
 scattering
the calculation around. My thought was to use a macro as it's a simple c=
alculation,
but then figured it was a bit nicer as a function for type safety. I alr=
eady had it as a
macro in the header, so it was the least effort to switch it to a static=
 inline and leave
it where it was :) So that's the justification, mostly just evolution of=
 thought process.
Performance was also a consideration but I've done no measurements.

Andrew

