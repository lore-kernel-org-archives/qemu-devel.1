Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D23C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799232068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="J0XOrd6B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aPSc1Uxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799232068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7t0-0007w6-Ey
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ic7lS-0005bX-12
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ic7lO-0004hB-G4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:58:47 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33831)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ic7lC-0003mP-Sp; Tue, 03 Dec 2019 07:58:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 2675C22434;
 Tue,  3 Dec 2019 07:58:32 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=gmcRl
 dLVl4I/fOLntbCUdmtMLEf8OQ0bpPWIabSstiY=; b=J0XOrd6BnoTOajNzODzlY
 0VbixE3gQsvO8DIaJYbS3YS0WTVOBu/csGCOE/uEeNXop7J4L7VAW9g5LLPqGybz
 kxMq16dH4oGnySU/x6GQyU3kb6xK+s4zNpDCCgnVgSa6KEgMY4DAZDLmlX0RsltL
 SjXHqWGs7FvUpSo5/H8Ij61luMez9vd2D4Lfdwd/cGHtjc8EicrAiS5Xu/lZHSfN
 Rq0Kdn6yZDAdEY0UmeWQtk0QydebKRmwi8P9HXQZuFwkDjQwEJHyBv4SLrsry+o1
 xbuhlVY+zL3QP0uRJorGBMUekBO0z3DS1n7Rd7c8ztSjldT9mvnYUGnNin7mRdld
 g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=gmcRldLVl4I/fOLntbCUdmtMLEf8OQ0bpPWIabSst
 iY=; b=aPSc1UxfLKBksK7HlqQmFXmkdTbA5GJcRUq9GhvBeiM9CUM0zOmdeTR3W
 COGoraFXemiTRIG08FVxqKHKEUpFsITcDKBo3Yb9ERF6SLIE5ckaJR/vz7cy4Z29
 jbaCH3GanIxqsKt4vJ6JzDOExkcbJQkDu+lse8v4yXH8xkZF4lWJuHPMTE5VVQ5o
 gS+RUnicy5N+bXUhb6rm1Wfm2cBCkMuaPZudSk+bh/srbHru+pudvKlxRC13ifCm
 9yivNJBAGe/S+9Pg/x8wmiNY9h/rA6yTTPDnn+o7KuOZrqF9+CtSYRTUxKHSQBIs
 OxPiy4mbCWMl8kFiVa8X1DvUy5avg==
X-ME-Sender: <xms:91vmXWhbEJl5eh7IiIuIGXQ4JdmXJnZz1stpNFkoWJMk0MUglmUcTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedggeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
 hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
 vghrufhiiigvpedt
X-ME-Proxy: <xmx:91vmXX1_EkXNTWY00wsJXWE8HJZ2AgAExGkLz9SyIUf470wirzotAQ>
 <xmx:91vmXcrW7polw0D2vY0pQok5HD0bhfCaMEphnNVsxvpV1Sc1qcmHUw>
 <xmx:91vmXVEcbCymmygIFyKqm4b5YsRdTLlOgz8rZFFNCRFoj-QyLvnkXw>
 <xmx:-FvmXXlHMrBsS7nW9asCsXfucAPxEgBHgxGHaqmMRzRZmxs77h-lPQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 52010E00A3; Tue,  3 Dec 2019 07:58:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-612-g13027cc-fmstable-20191203v1
Mime-Version: 1.0
Message-Id: <915ab8c8-5cd9-43fa-8abf-e1ea8c91c807@www.fastmail.com>
In-Reply-To: <fc320f0d-b2e2-c603-e5db-170f24df1149@redhat.com>
References: <20191203041440.6275-1-andrew@aj.id.au>
 <20191203041440.6275-4-andrew@aj.id.au>
 <fc320f0d-b2e2-c603-e5db-170f24df1149@redhat.com>
Date: Tue, 03 Dec 2019 23:29:54 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_3/4]_target/arm:_Prepare_generic_timer_for_per-p?=
 =?UTF-8?Q?latform_CNTFRQ?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.27
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



On Tue, 3 Dec 2019, at 16:49, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/3/19 5:14 AM, Andrew Jeffery wrote:
> > The ASPEED AST2600 clocks the generic timer at the rate of HPLL. On
> > recent firmwares this is at 1125MHz, which is considerably quicker t=
han
> > the assumed 62.5MHz of the current generic timer implementation. The=

> > delta between the value as read from CNTFRQ and the true rate of the=

> > underlying QEMUTimer leads to sticky behaviour in AST2600 guests.
> >=20
> > Add a feature-gated property exposing CNTFRQ for ARM CPUs providing =
the
> > generic timer. This allows platforms to configure CNTFRQ (and the
> > associated QEMUTimer) to the appropriate frequency prior to starting=
 the
> > guest.
> >=20
> > As the platform can now determine the rate of CNTFRQ we're exposed t=
o
> > limitations of QEMUTimer that didn't previously materialise: In the
> > course of emulation we need to arbitrarily and accurately convert
> > between guest ticks and time, but we're constrained by QEMUTimer's u=
se
> > of an integer scaling factor. The effect is QEMUTimer cannot exactly=

> > capture the period of frequencies that do not cleanly divide
> > NANOSECONDS_PER_SECOND for scaling ticks to time. As such, provide a=
n
> > equally inaccurate scaling factor for scaling time to ticks so at le=
ast
> > a self-consistent inverse relationship holds.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   target/arm/cpu.c    | 43 +++++++++++++++++++++++++++++++++--------=
--
> >   target/arm/cpu.h    | 18 ++++++++++++++++++
> >   target/arm/helper.c |  9 ++++++++-
> >   3 files changed, 59 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 5698a74061bb..f186019a77fd 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -974,10 +974,12 @@ static void arm_cpu_initfn(Object *obj)
> >       if (tcg_enabled()) {
> >           cpu->psci_version =3D 2; /* TCG implements PSCI 0.2 */
> >       }
> > -
> > -    cpu->gt_cntfrq =3D NANOSECONDS_PER_SECOND / GTIMER_SCALE;
> >   }
> >  =20
> > +static Property arm_cpu_gt_cntfrq_property =3D
> > +            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq,
> > +                               NANOSECONDS_PER_SECOND / GTIMER_SCAL=
E);
> > +
> >   static Property arm_cpu_reset_cbar_property =3D
> >               DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0=
);
> >  =20
> > @@ -1174,6 +1176,11 @@ void arm_cpu_post_init(Object *obj)
> >  =20
> >       qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property=
,
> >                                &error_abort);
> > +
> > +    if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
> > +        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_pr=
operty,
> > +                                 &error_abort);
> > +    }
> >   }
> >  =20
> >   static void arm_cpu_finalizefn(Object *obj)
> > @@ -1253,14 +1260,30 @@ static void arm_cpu_realizefn(DeviceState *d=
ev, Error **errp)
> >           }
> >       }
> >  =20
> > -    cpu->gt_timer[GTIMER_PHYS] =3D timer_new(QEMU_CLOCK_VIRTUAL, GT=
IMER_SCALE,
> > -                                           arm_gt_ptimer_cb, cpu);
> > -    cpu->gt_timer[GTIMER_VIRT] =3D timer_new(QEMU_CLOCK_VIRTUAL, GT=
IMER_SCALE,
> > -                                           arm_gt_vtimer_cb, cpu);
> > -    cpu->gt_timer[GTIMER_HYP] =3D timer_new(QEMU_CLOCK_VIRTUAL, GTI=
MER_SCALE,
> > -                                          arm_gt_htimer_cb, cpu);
> > -    cpu->gt_timer[GTIMER_SEC] =3D timer_new(QEMU_CLOCK_VIRTUAL, GTI=
MER_SCALE,
> > -                                          arm_gt_stimer_cb, cpu);
> > +
> > +    {
> > +        uint64_t scale;
>=20
> Apparently you have to use this odd indent due to the '#ifndef=20
> CONFIG_USER_ONLY'. Well, acceptable.

It's the indent associated with the block scope for the scale variable t=
o limit its lifetime
to where I needed it.

>=20
> > +
> > +        if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
> > +            if (!cpu->gt_cntfrq) {
> > +                error_setg(errp, "Invalid CNTFRQ: %"PRId64"Hz",
> > +                           cpu->gt_cntfrq);
> > +                return;
> > +            }
> > +            scale =3D gt_cntfrq_period_ns(cpu);
> > +        } else {
> > +            scale =3D GTIMER_SCALE;
> > +        }
> > +
> > +        cpu->gt_timer[GTIMER_PHYS] =3D timer_new(QEMU_CLOCK_VIRTUAL=
, scale,
> > +                                               arm_gt_ptimer_cb, cp=
u);
> > +        cpu->gt_timer[GTIMER_VIRT] =3D timer_new(QEMU_CLOCK_VIRTUAL=
, scale,
> > +                                               arm_gt_vtimer_cb, cp=
u);
> > +        cpu->gt_timer[GTIMER_HYP] =3D timer_new(QEMU_CLOCK_VIRTUAL,=
 scale,
> > +                                              arm_gt_htimer_cb, cpu=
);
> > +        cpu->gt_timer[GTIMER_SEC] =3D timer_new(QEMU_CLOCK_VIRTUAL,=
 scale,
> > +                                              arm_gt_stimer_cb, cpu=
);
> > +    }
> >   #endif
> >  =20
> >       cpu_exec_realizefn(cs, &local_err);
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 666c03871fdf..0bcd13dcac81 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -939,6 +939,24 @@ struct ARMCPU {
> >  =20
> >   static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> >   {
> > +    /*
> > +     * The exact approach to calculating guest ticks is:
> > +     *
> > +     *     muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), cpu->gt_=
cntfrq,
> > +     *              NANOSECONDS_PER_SECOND);
> > +     *
> > +     * We don't do that. Rather we intentionally use integer divisi=
on
> > +     * truncation below and in the caller for the conversion of hos=
t monotonic
> > +     * time to guest ticks to provide the exact inverse for the sem=
antics of
> > +     * the QEMUTimer scale factor. QEMUTimer's scale facter is an i=
nteger, so
> > +     * it loses precision when representing frequencies where
> > +     * `(NANOSECONDS_PER_SECOND % cpu->gt_cntfrq) > 0` holds. Faili=
ng to
> > +     * provide an exact inverse leads to scheduling timers with neg=
ative
> > +     * periods, which in turn leads to sticky behaviour in the gues=
t.
> > +     *
> > +     * Finally, CNTFRQ is effectively capped at 1GHz to ensure our =
scale factor
> > +     * cannot become zero.
> > +     */
>=20
> This comment belong to the previous patch.

Sort of, but also sort of not. We don't expose the limitation until this=
 patch as
NANOSECONDS_PER_SECOND is an integer multiple of GTIMER_SCALE, which
is what gt_cntfrq is set to until we add the property to configure it to=
 arbitrary
values in this patch. So I added the comment in this patch rather than t=
he
previous one which adds the code.

Andrew

