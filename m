Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4ADC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273AF20C09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3tbeitr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273AF20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYSq-0002QB-1v
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFYSJ-0001xq-63
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:54:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFYSH-0006Ug-Dn
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599551656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPgfs/vw/hl5ABwcayG2BGaNk7AT4iznmA5rCj/73Ng=;
 b=M3tbeitr5ba+TA/E8T+SgmR+t+T/mcOhpNRAP8vY/3uU+OEQ1iXGcGjMIPetOev0CaiQwH
 P9ShCWJy1RnOyb8FM4hWi9mSMG/qaH4p6/tmtyKuW8pL3kA2ce4IvHgFPMax4ZJWY5VTRW
 d/MZuyfHBdHDOiKc/kmHpXFnz8rhDhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-YhSODPN6PTKxPswxiV-0Zg-1; Tue, 08 Sep 2020 03:54:14 -0400
X-MC-Unique: YhSODPN6PTKxPswxiV-0Zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD2521074642;
 Tue,  8 Sep 2020 07:54:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A500F82460;
 Tue,  8 Sep 2020 07:54:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BC1A1132B59; Tue,  8 Sep 2020 09:54:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH v4 8/8] hw/arm/tosa: Make TYPE_TOSA_MISC_GPIO a
 plain QDev
References: <20200907163257.46527-1-f4bug@amsat.org>
 <20200907163257.46527-9-f4bug@amsat.org>
Date: Tue, 08 Sep 2020 09:54:09 +0200
In-Reply-To: <20200907163257.46527-9-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 7 Sep 2020 18:32:57
 +0200")
Message-ID: <87h7s8g0v2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> TYPE_TOSA_MISC_GPIO doesn't need to be a SysBus device,
> make it a plain QDev.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC because having to pass MachineState and call
> object_property_add_child() simply makes things more
> complex... but it seems to cleaner QOM design.

Well, what devices really *need* to be sysbus devices?

The question is trivial for "real" buses, such as PCI, USB, and so
forth: a device is a FOO device when it plugs into a FOO bus.

Sysbus is quite unlike these "real" buses.  It exists because qdev
initially *required* qdevs to plug into a qbus, so we made up a qbus for
the devices that don't plug into any of our "real" buses[1].

I figure all sysbus devices could be coded as bus-less devices today.
So the answer to "what devices really *need* to be sysbus devices?" is
"none".

I think a more useful question is what devices *should* be coded as
sysbus devices vs. bus-less devices.

Sysbus is more than just a dummy qbus.  It's a software interface that
provides useful stuff.  To use it, the device needs to be a
SysBusDevice.  This leads to a partial answer: if the device profits
from stuff we provide only to SysBusDevices, it should be one.

Perhaps the useful stuff could be separated from SysBusDevice.  Then
this partial answer evaporates.

There is just one instance of TYPE_SYSTEM_BUS[2].  This leads to another
partial answer: if the device can be part of another device, it should
not be a SysBusDevice.

Sysbus also enables "dynamic" sysbus devices.  Shoehorning them into
SysBusDevice may have been a mistake.

> Cc: Markus Armbruster <armbru@redhat.com>

Cc: QOM maintainers for actual QOM expertise :)


[1] sysbus.h describes itself as "Devices attached directly to the main
system bus".  I think that's an (unconscious?) attempt to rationalize
away its peculiar role.

[2] Exception: TYPE_MACIO_BUS (used by g3beige and mac99) is a subtype
of TYPE_SYSTEM_BUS.


> ---
>  hw/arm/tosa.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index f23651fd775..524d5fcd10b 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -79,7 +79,7 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
>      OBJECT_CHECK(TosaMiscGPIOState, (obj), TYPE_TOSA_MISC_GPIO)
> =20
>  typedef struct TosaMiscGPIOState {
> -    SysBusDevice parent_obj;
> +    DeviceState parent_obj;
>  } TosaMiscGPIOState;
> =20
>  static void tosa_reset(void *opaque, int line, int level)
> @@ -96,7 +96,7 @@ static void tosa_misc_gpio_init(Object *obj)
>      qdev_init_gpio_in_named(dev, tosa_reset, "reset", 1);
>  }
> =20
> -static void tosa_gpio_setup(PXA2xxState *cpu,
> +static void tosa_gpio_setup(MachineState *machine, PXA2xxState *cpu,
>                  DeviceState *scp0,
>                  DeviceState *scp1,
>                  TC6393xbState *tmio)
> @@ -104,7 +104,10 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
>      DeviceState *misc_gpio;
>      LEDState *led[4];
> =20
> -    misc_gpio =3D sysbus_create_simple(TYPE_TOSA_MISC_GPIO, -1, NULL);
> +    misc_gpio =3D qdev_new(TYPE_TOSA_MISC_GPIO);
> +    object_property_add_child(OBJECT(machine), "pcb-container",
> +                              OBJECT(misc_gpio));
> +    qdev_realize_and_unref(misc_gpio, NULL, &error_fatal);
> =20
>      /* MMC/SD host */
>      pxa2xx_mmci_handlers(cpu->mmc,
> @@ -253,7 +256,7 @@ static void tosa_init(MachineState *machine)
>      scp0 =3D sysbus_create_simple("scoop", 0x08800000, NULL);
>      scp1 =3D sysbus_create_simple("scoop", 0x14800040, NULL);
> =20
> -    tosa_gpio_setup(mpu, scp0, scp1, tmio);
> +    tosa_gpio_setup(machine, mpu, scp0, scp1, tmio);
> =20
>      tosa_microdrive_attach(mpu);
> =20
> @@ -307,7 +310,7 @@ static const TypeInfo tosa_ssp_info =3D {
> =20
>  static const TypeInfo tosa_misc_gpio_info =3D {
>      .name          =3D TYPE_TOSA_MISC_GPIO,
> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .parent        =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(TosaMiscGPIOState),
>      .instance_init =3D tosa_misc_gpio_init,
>      /*


