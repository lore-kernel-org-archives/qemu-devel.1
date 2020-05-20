Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B38C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0A12072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YctlSDQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0A12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQ9H-0003ya-CC
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbQ7S-0001eT-Jr
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:54:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49291
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbQ7R-00044p-F7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589986492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9Lgteko6sLUlaPUdyp0fIg5auB2l940g7Q95k7FOxw=;
 b=YctlSDQBpq4mbG+uNsFUQI9wQWMM/Qk70E4xrsUEoXWTlVdVJKtAC7djVP8BshON66lR8J
 p70Nx8fDeWzoSxmGOPEfUazmkQfNUEdIYpgmf3Rw01bBBdltTsQHaO9393z3DnYgs/W6SV
 hXm4Vpc7d6zafgCr3Krjs1zCpp9J0aU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-bfduPXboPYGlLowaOQ0VuA-1; Wed, 20 May 2020 10:54:49 -0400
X-MC-Unique: bfduPXboPYGlLowaOQ0VuA-1
Received: by mail-wr1-f69.google.com with SMTP id d16so1494022wrv.18
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l9Lgteko6sLUlaPUdyp0fIg5auB2l940g7Q95k7FOxw=;
 b=CX3tyUWX3FDYiqOrHNjJOhXr2519ZjAngeUzeQ/hVYy5V+Hq1MtsI7OGxa54pfk7ey
 K3nah3VVQrqnhnikWupDbLxy5F7F98WVJIBj7SYZQL3PrK7WHcraKD+h0aWNoBLsW+Lk
 qkW+cuIUTQQxD9iQabkJu1+IbuQXY/YxLHM31NIFaRr7mgi/sD5lzbF4WNs/C/LzuHO/
 PhfdGpQ/AXezwPmZl0YX5NPJuIPzVhDxKCLkFBj43on2Uo7WEdHPdh1kh5PwdSEyPvTO
 pMpa9+cdeF8z9LOOe1uV9y/wN9iKwK7P+hxVVQLhN4nMJkG5OtjGTM+xlblkgQsuW0++
 yNxw==
X-Gm-Message-State: AOAM531fZDyz2AkO/C0strmq0Yj3ECKBa57CYaETJVpyW56tBAZzVFaW
 KL7HLhYPPDqnVODeKAMLAU/+8Q2e+a67tQ4HLSEfJajwLBrelebGlXqHMpSuc8LxriCfUVoYfYL
 6TeDsfL6CCMF1y+eaSsbhS2yJPHsfb/o=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr4272726wrp.427.1589986488698; 
 Wed, 20 May 2020 07:54:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVLPqMz7ZzYgI6VtznNy5HHRU2ChCdzv7OSgqoNdUMmZBa132+ppUR0ptUOQQ7HFYmMU9dJ2LMdA+JU47kxlo=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr4272715wrp.427.1589986488441; 
 Wed, 20 May 2020 07:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-39-armbru@redhat.com>
 <3bb39878-b422-954b-5c78-49e61b4fee7a@redhat.com>
 <87tv0apsor.fsf@dusky.pond.sub.org>
In-Reply-To: <87tv0apsor.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 May 2020 16:54:37 +0200
Message-ID: <CAP+75-Xh8BWMKHO+p5ARQ7H+V9NN_ubCnCfCMA4ZfWKZJ-tuWQ@mail.gmail.com>
Subject: Re: [PATCH 38/55] microbit: Tidy up sysbus_init_child_obj() @child
 argument
To: Markus Armbruster <armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 4:49 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > On 5/19/20 4:55 PM, Markus Armbruster wrote:
> >> The callers of sysbus_init_child_obj() commonly pass either &child,
> >> sizeof(child), or pchild, sizeof(*pchild).  Tidy up two that don't,
> >> mostly to keep future commits simpler.
> >>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>   hw/arm/microbit.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> >> index ef213695bd..72fab429c4 100644
> >> --- a/hw/arm/microbit.c
> >> +++ b/hw/arm/microbit.c
> >> @@ -39,7 +39,7 @@ static void microbit_init(MachineState *machine)
> >>       Object *soc =3D OBJECT(&s->nrf51);
> >>       Object *i2c =3D OBJECT(&s->i2c);
> >>   -    sysbus_init_child_obj(OBJECT(machine), "nrf51", soc,
> >> sizeof(s->nrf51),
> >> +    sysbus_init_child_obj(OBJECT(machine), "nrf51", &s->nrf51, sizeof=
(s->nrf51),
> >>                             TYPE_NRF51_SOC);
> >>       qdev_prop_set_chr(DEVICE(&s->nrf51), "serial0", serial_hd(0));
> >>       object_property_set_link(soc, OBJECT(system_memory), "memory",
> >> @@ -51,7 +51,7 @@ static void microbit_init(MachineState *machine)
> >>        * hack until we implement the nRF51 TWI controller properly and=
 the
> >>        * magnetometer/accelerometer devices.
> >>        */
> >> -    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", i2c,
> >> +    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", &s->i2c,
> >>                             sizeof(s->i2c), TYPE_MICROBIT_I2C);
> >>       object_property_set_bool(i2c, true, "realized", &error_fatal);
> >
> > i2c is only used once now, maybe you can remove it and directly use
> > in-place.
>
> Twice.  After PATCH 47, both uses will be SYS_BUS_DEVICE(i2c).  I think
> I should either eliminate the variable, or change it to SysBusDevice *.

Pointless double-cast, we can directly use SYS_BUS_DEVICE(&s->nrf51).

>
> >           Regardless:
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Thanks!
>
> >>       mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
> >>
>


