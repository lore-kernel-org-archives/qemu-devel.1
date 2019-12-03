Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A7AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3B2206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="mtJL4cwM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xq592oAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3B2206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7qC-00066V-1w
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ic7b6-0002OR-Gz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ic7at-0006Mw-NU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:48:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45533)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ic7aW-0004x5-4l; Tue, 03 Dec 2019 07:47:32 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 77D5A223CC;
 Tue,  3 Dec 2019 07:47:26 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=ACyzv
 u8ZpyXA+VrmBvFkqbpxOAuy1IEd+giaDT4RTUU=; b=mtJL4cwMAKcQfuAhUeg0G
 I48vGdUdfrMLeBwdL0xpQLX0rpC8xdgfRF3DiePAiDJN/HerMWiIlJ8E3tA1uFeY
 D5N/2N+vu9G2fepnub8Vo/esgIoEr9vZuEQREgOdCYDr77nyhEx7wte6YeYtlcGU
 U5IW5EYGK9TcdjOwq6det43kh2e2wf+aK90B3B5vLBRgJyJ6zV4CfIFgDi8YMc/t
 kcuTf16G38dX7rp2BhlXkOT3PMZCsIa8Yhj+qMlWdYhGt6Tqriou24nYVQVdZqTW
 n8YOo7WQ+Gbp92/vy7YD8sDFMMTpLWPeB5Dzwu5Gt1eJv/46IRP/vlQFvfel9/ma
 Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=ACyzvu8ZpyXA+VrmBvFkqbpxOAuy1IEd+giaDT4RT
 UU=; b=Xq592oAbWL8is3ySXBuzMXG7fILlblARzoO3uDhxow79/26coJ/+gMZX8
 AFmJYGpMkGFhS+V6KHKYkzfvi+hVE472hddL2TOfpwC4LEackCuxJ7pnhy4QHl7o
 nNo5TAh/+NFFY2+Fo2k8P7Y8G8W6394xatiolsNPqFQiSS5rxKUNYruegs4IyeH3
 Fhr1mzby1oAqKmxSacpUBz48TbK5lqVh01Krsm3Kg1a3mhsYxfu4gNREAjJLuO4A
 nKQigtSF0mt4xogw/nRWZinmeTT5ZNgBPwfcB5ADkjD0siK26//jeOdp0L+JD5RP
 W6tcOU1hutzTw2Bpb4Q3TuibYtysw==
X-ME-Sender: <xms:XVnmXVtuODptq35HzzbnZWVOREJ_lt05ob6dtb-Buuwwrs2sZIQ-qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedggeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
 hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
 vghrufhiiigvpedt
X-ME-Proxy: <xmx:XVnmXd0VReQaErilutzjD8OIMbwyzsn4wm9nnCEiI1FBTLU7humBsw>
 <xmx:XVnmXbVJpNLqhfq3C94FRwtnanEHNCiNaqeIETB3_cL-Lh47g7Oamw>
 <xmx:XVnmXdbEZ18F5iHfXWUzjkD16Vh9zoGRhGDVmiKmkAEINqLjpXtJ8A>
 <xmx:XlnmXd7ff-kjJ_nBw8fCAnJaCzLmekYFd2YpZJget5llmBAoD1P9gw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 7DA3DE00A2; Tue,  3 Dec 2019 07:47:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-612-g13027cc-fmstable-20191203v1
Mime-Version: 1.0
Message-Id: <4e90d36d-aa13-441f-9298-56f83a5bff6a@www.fastmail.com>
In-Reply-To: <283c152b-b1c7-551e-bec0-c087b14de996@redhat.com>
References: <20191203041440.6275-1-andrew@aj.id.au>
 <20191203041440.6275-3-andrew@aj.id.au>
 <283c152b-b1c7-551e-bec0-c087b14de996@redhat.com>
Date: Tue, 03 Dec 2019 23:18:59 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 2/4] target/arm: Abstract the generic timer frequency
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
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tue, 3 Dec 2019, at 16:39, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/3/19 5:14 AM, Andrew Jeffery wrote:
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
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   target/arm/cpu.c    |  2 ++
> >   target/arm/cpu.h    | 10 ++++++++++
> >   target/arm/helper.c | 10 +++++++---
> >   3 files changed, 19 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 7a4ac9339bf9..5698a74061bb 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
> >       if (tcg_enabled()) {
> >           cpu->psci_version =3D 2; /* TCG implements PSCI 0.2 */
> >       }
> > +
> > +    cpu->gt_cntfrq =3D NANOSECONDS_PER_SECOND / GTIMER_SCALE;
> >   }
> >  =20
> >   static Property arm_cpu_reset_cbar_property =3D
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 83a809d4bac4..666c03871fdf 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -932,8 +932,18 @@ struct ARMCPU {
> >        */
> >       DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
> >       DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
> > +
> > +    /* Generic timer counter frequency, in Hz */
> > +    uint64_t gt_cntfrq;
>=20
> You can also explicit the unit by calling it 'gt_cntfrq_hz'.

Fair call, I'll fix that.

>=20
> >   };
> >  =20
> > +static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> > +{
> > +    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECON=
D? */
>=20
> Why inline this call? I doubt there is a significant performance gain.=


It wasn't so much performance. It started out as a macro for a simple ca=
lculation
because I didn't want to duplicate it across a number of places, then I =
wanted type
safety for the pointer so  I switched the macro in the header to an inli=
ne function. So
it is an evolution of the patch rather than something that came from an =
explicit goal
of e.g. performance.

Andrew

