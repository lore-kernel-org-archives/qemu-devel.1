Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B294C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD08208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AORFDPiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD08208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15nb-0000k5-DT
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j15ml-00008c-82
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j15mk-0002uv-1v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:55:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j15mj-0002tb-Tz
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581328521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LalPpMW9ng7YCbFD/fK+hthpRjp2vK90qzJFL7t/VU=;
 b=AORFDPiU4oV4pgEy32qG4mRICSm2Q/2v6Quue3Mcky8uLSuzcU3LzaJBXIzjO8g4cIFZGG
 lS7b6C2jfAib0wykT20COqwsmfJa/PlAUSL3G5A+IfAHH5O30cyTxlbyY/lXVhk4EcyLeY
 g3Lhj1mU7XhW0dATz0f9MYsOU1KfNj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-GRqamLgDNuyHCzzhSqI7pw-1; Mon, 10 Feb 2020 04:55:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A0AC800D41;
 Mon, 10 Feb 2020 09:55:18 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96DBE5C1D4;
 Mon, 10 Feb 2020 09:55:13 +0000 (UTC)
Date: Mon, 10 Feb 2020 10:55:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 09/13] hw/arm/raspi: Let class_init() directly call
 raspi_machine_init()
Message-ID: <20200210105511.2b1c9b37@redhat.com>
In-Reply-To: <20200208165645.15657-10-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-10-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GRqamLgDNuyHCzzhSqI7pw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat,  8 Feb 2020 17:56:41 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> raspi_machine_init() access to board_rev via RaspiMachineClass.
> raspi2_init() and raspi3_init() do nothing. Call raspi_machine_init
> directly.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Squash with previous?
> ---
>  hw/arm/raspi.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index fbfcd29732..1628b0dda7 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -228,7 +228,7 @@ static void setup_boot(MachineState *machine, int ver=
sion, size_t ram_size)
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
>  }
> =20
> -static void raspi_init(MachineState *machine)
> +static void raspi_machine_init(MachineState *machine)
>  {
>      RaspiMachineClass *mc =3D RASPI_MACHINE_GET_CLASS(machine);
>      RaspiMachineState *s =3D RASPI_MACHINE(machine);
> @@ -280,11 +280,6 @@ static void raspi_init(MachineState *machine)
>      setup_boot(machine, version, machine->ram_size - vcram_size);
>  }
> =20
> -static void raspi2_init(MachineState *machine)
> -{
> -    raspi_init(machine);
> -}
> -
>  static void raspi2_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -293,7 +288,7 @@ static void raspi2_machine_class_init(ObjectClass *oc=
, void *data)
> =20
>      rmc->board_rev =3D board_rev;
>      mc->desc =3D "Raspberry Pi 2B";
> -    mc->init =3D raspi2_init;
> +    mc->init =3D raspi_machine_init;

[...]
> @@ -319,7 +309,7 @@ static void raspi3_machine_class_init(ObjectClass *oc=
, void *data)
> =20
>      rmc->board_rev =3D board_rev;
>      mc->desc =3D "Raspberry Pi 3B";
> -    mc->init =3D raspi3_init;
> +    mc->init =3D raspi_machine_init;
[...]

you could set it once in base class_init,
since there is not reason lest to do it per leaf class.

Either with this change or without

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


