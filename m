Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E4C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C3C20674
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcH7ITAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C3C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yrh-0005ex-8N
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k7yp1-0002NY-MX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k7yoz-00013A-V4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597746381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbDW1HLNCOs0Z4yh+HyA36FoNymUmPg3R6M1amuR2RI=;
 b=HcH7ITAV9LBG24rb8iRW978O+UwAr6pL7tKJiV6MjSKdLhKqwyKoxzI/HQXe0UWBm5eafo
 JdxkhBoEJTNY3ZuWByhKnRJ9FbbmT/KAkHu/T8baURiiWUD7d8serir5bwS3I26fmXbPmn
 a2+NgvGnF7aAGd+2yi+AwVR0wHhPkU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-SXSQ7uisMnW78JbgKWNhiQ-1; Tue, 18 Aug 2020 06:26:17 -0400
X-MC-Unique: SXSQ7uisMnW78JbgKWNhiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA427801ADD;
 Tue, 18 Aug 2020 10:26:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BCAE7849A;
 Tue, 18 Aug 2020 10:26:05 +0000 (UTC)
Date: Tue, 18 Aug 2020 12:26:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v4 4/8] ppc/e500: Use start-powered-off CPUState property
Message-ID: <20200818122603.0dac1a38@redhat.com>
In-Reply-To: <83c5045d-ee26-9433-46a3-4919bcea7cd3@redhat.com>
References: <20200818033323.336912-1-bauerman@linux.ibm.com>
 <20200818033323.336912-5-bauerman@linux.ibm.com>
 <83c5045d-ee26-9433-46a3-4919bcea7cd3@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 09:22:05 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 8/18/20 5:33 AM, Thiago Jung Bauermann wrote:
> > Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), us=
e
> > the start-powered-off property which makes cpu_common_reset() initializ=
e it
> > to 1 in common code.
> >=20
> > Also change creation of CPU object from cpu_create() to object_new() an=
d
> > qdev_realize() because cpu_create() realizes the CPU and it's not possi=
ble
> > to set a property after the object is realized.
> >=20
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > ---
> >  hw/ppc/e500.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> > index ab9884e315..0077aca74d 100644
> > --- a/hw/ppc/e500.c
> > +++ b/hw/ppc/e500.c
> > @@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
> > =20
> >      cpu_reset(cs);
> > =20
> > -    /* Secondary CPU starts in halted state for now. Needs to change w=
hen
> > -       implementing non-kernel boot. */
> > -    cs->halted =3D 1;
> >      cs->exception_index =3D EXCP_HLT;
> >  }
> > =20
> > @@ -864,8 +861,9 @@ void ppce500_init(MachineState *machine)
> >          PowerPCCPU *cpu;
> >          CPUState *cs;
> >          qemu_irq *input;
> > +        Error *err =3D NULL;
> > =20
> > -        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
> > +        cpu =3D POWERPC_CPU(object_new(machine->cpu_type));
> >          env =3D &cpu->env;
> >          cs =3D CPU(cpu);
> > =20
> > @@ -897,6 +895,19 @@ void ppce500_init(MachineState *machine)
> >          } else {
> >              /* Secondary CPUs */
> >              qemu_register_reset(ppce500_cpu_reset_sec, cpu);
> > +
> > +            /*
> > +             * Secondary CPU starts in halted state for now. Needs to =
change
> > +             * when implementing non-kernel boot.
> > +             */
> > +            object_property_set_bool(OBJECT(cs), "start-powered-off", =
true,
> > +                                     &error_abort); =20
>=20
> [*]
>=20
> > +        }
> > +
> > +        if (!qdev_realize(DEVICE(cs), NULL, &err)) {
> > +            error_report_err(err);
> > +            object_unref(OBJECT(cs));
> > +            exit(EXIT_FAILURE);
> >          } =20
>=20
> The last 4 lines are equivalent to:
>=20
>            qdev_realize(DEVICE(cs), NULL, &error_fatal)) {
>=20
> This is also the preferred form, as we can not propagate errors
> from the machine_init() handler.
not exactly, it will leak refference, but we are dying anyways so who cares=
.

>=20
> Since you use &error_abort in [*], maybe you want to use it here too.
>=20
> >      }
> > =20
> >  =20
>=20
>=20


