Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB8C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9FE20708
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gn5CWhCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9FE20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j18pU-0001dr-9U
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j18op-00011Z-JR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j18oo-0003DI-6k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:09:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j18oo-0003CY-3c
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581340180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFmokft1kTFAFJrbqzvipAx5diDrfYbxHxW698ao9q4=;
 b=Gn5CWhCyb3KOkllLEO+8UONfPUkD4rDMKF2Dptj2tXt6jYPEm0etWbZvfSosesMrmzOg9K
 eQ0CNK43J8Jo8N/IStw7ejNMtb7ejAgeUW6Ha4Swno7TspbNacijI14I9QxkF40+hkT91L
 a+u76wNKu+pfve8aOa8X7x4/NgU3I50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-3O34Gw-hONmztIX9CZuEgA-1; Mon, 10 Feb 2020 08:09:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F612800D41;
 Mon, 10 Feb 2020 13:09:25 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A47B5DA82;
 Mon, 10 Feb 2020 13:09:19 +0000 (UTC)
Date: Mon, 10 Feb 2020 14:09:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v3 08/13] hw/arm/raspi: Make board_rev a field of
 RaspiMachineClass
Message-ID: <20200210140918.270c8a5d@redhat.com>
In-Reply-To: <2adc51a2-b526-7f6a-4c01-775f3ac06444@redhat.com>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-9-f4bug@amsat.org>
 <20200210105042.7e76e4e6@redhat.com>
 <2adc51a2-b526-7f6a-4c01-775f3ac06444@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3O34Gw-hONmztIX9CZuEgA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Alistair Francis <alistair@alistair23.me>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020 11:03:40 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/10/20 10:50 AM, Igor Mammedov wrote:
> > On Sat,  8 Feb 2020 17:56:40 +0100
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> We want to have a common class_init(). The only value that
> >> matters (and changes) is the board revision.
> >> Pass the board_rev as class_data to class_init().
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>   hw/arm/raspi.c | 17 ++++++++++++++---
> >>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> >> index 62b8df3c2e..fbfcd29732 100644
> >> --- a/hw/arm/raspi.c
> >> +++ b/hw/arm/raspi.c
> >> @@ -46,6 +46,7 @@ typedef struct RaspiMachineClass {
> >>       /*< private >*/
> >>       MachineClass parent_obj;
> >>       /*< public >*/
> >> +    uint32_t board_rev;
> >>   } RaspiMachineClass;
> >>  =20
> >>   #define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
> >> @@ -227,9 +228,11 @@ static void setup_boot(MachineState *machine, int=
 version, size_t ram_size)
> >>       arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
> >>   }
> >>  =20
> >> -static void raspi_init(MachineState *machine, uint32_t board_rev)
> >> +static void raspi_init(MachineState *machine)
> >>   {
> >> +    RaspiMachineClass *mc =3D RASPI_MACHINE_GET_CLASS(machine);
> >>       RaspiMachineState *s =3D RASPI_MACHINE(machine);
> >> +    uint32_t board_rev =3D mc->board_rev;
> >>       int version =3D board_version(board_rev);
> >>       uint64_t ram_size =3D board_ram_size(board_rev);
> >>       uint32_t vcram_size;
> >> @@ -279,13 +282,16 @@ static void raspi_init(MachineState *machine, ui=
nt32_t board_rev)
> >>  =20
> >>   static void raspi2_init(MachineState *machine)
> >>   {
> >> -    raspi_init(machine, 0xa21041);
> >> +    raspi_init(machine);
> >>   }
> >>  =20
> >>   static void raspi2_machine_class_init(ObjectClass *oc, void *data)
> >>   {
> >>       MachineClass *mc =3D MACHINE_CLASS(oc);
> >> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> >> +    uint32_t board_rev =3D (uint32_t)(uintptr_t)data;
> >>  =20
> >> +    rmc->board_rev =3D board_rev; =20
> >=20
> > instead of doing a bit obscure ".class_data     =3D (void *)0xa21041," =
and
> > using it here, I'd just do
> >=20
> >         rmc->board_rev =3D 0xa21041;
> >=20
> > using value specific for each leaf class =20
>=20
> Leaf classes are removed in patch #12 "Use a unique=20
> raspi_machine_class_init() method", see more uses of .class_data from v2:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg677164.html
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg677166.html
>=20
> Are you disagreeing with them? Then we should document .class_data as=20
> deprecated and show example of good code.

we sometimes use .class_data when creating many derived types
(typical example CPU types (x86) ) where it's impractical to code
leaf class_init functions. I'd use .class_data in cases where I
can't get away with explicit .class_init

However in case of machines (even various versioned ones) practice
was to use parent class_init to set common data and leaf class_inits
to set board (version) specific features.


> > with this change
> >   Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >  =20
> >>       mc->desc =3D "Raspberry Pi 2B";
> >>       mc->init =3D raspi2_init;
> >>       mc->block_default_type =3D IF_SD;
> >> @@ -302,13 +308,16 @@ static void raspi2_machine_class_init(ObjectClas=
s *oc, void *data)
> >>   #ifdef TARGET_AARCH64
> >>   static void raspi3_init(MachineState *machine)
> >>   {
> >> -    raspi_init(machine, 0xa02082);
> >> +    raspi_init(machine);
> >>   }
> >>  =20
> >>   static void raspi3_machine_class_init(ObjectClass *oc, void *data)
> >>   {
> >>       MachineClass *mc =3D MACHINE_CLASS(oc);
> >> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> >> +    uint32_t board_rev =3D (uint32_t)(uintptr_t)data;
> >>  =20
> >> +    rmc->board_rev =3D board_rev;
> >>       mc->desc =3D "Raspberry Pi 3B";
> >>       mc->init =3D raspi3_init;
> >>       mc->block_default_type =3D IF_SD;
> >> @@ -327,11 +336,13 @@ static const TypeInfo raspi_machine_types[] =3D =
{
> >>           .name           =3D MACHINE_TYPE_NAME("raspi2"),
> >>           .parent         =3D TYPE_RASPI_MACHINE,
> >>           .class_init     =3D raspi2_machine_class_init,
> >> +        .class_data     =3D (void *)0xa21041,
> >>   #ifdef TARGET_AARCH64
> >>       }, {
> >>           .name           =3D MACHINE_TYPE_NAME("raspi3"),
> >>           .parent         =3D TYPE_RASPI_MACHINE,
> >>           .class_init     =3D raspi3_machine_class_init,
> >> +        .class_data     =3D (void *)0xa02082,
> >>   #endif
> >>       }, {
> >>           .name           =3D TYPE_RASPI_MACHINE, =20
> >  =20
>=20


