Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D17C3565B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B0D206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5ZCKuiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B0D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5D5j-0007j2-DB
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j5D4L-0006ek-UH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j5D4J-0004WC-R0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:30:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j5D4J-0004Vi-DS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582309830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmCMAvywZ70BUe2bx1A/nrOwN6GAdbYos9+k3nWZsO0=;
 b=Q5ZCKuiDG3KTbVfsQbLL9VxZttvdrSHw2reCj8XldHQayGjtUb9E42q8MhEhVYgROspgjI
 WdUFOCpnjpEtynBj+duo/QIYrQ5h2I8VVIbmdITICL1oMWFWpnua2v6Z0WSIUJKH5Fe9wi
 YONvEoxXwnasArmGgUV3vY99jdevqtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-sX8tmzVBOpKNa2aslO4D_g-1; Fri, 21 Feb 2020 13:30:28 -0500
X-MC-Unique: sX8tmzVBOpKNa2aslO4D_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 585698010F1;
 Fri, 21 Feb 2020 18:30:27 +0000 (UTC)
Received: from localhost (unknown [10.16.197.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D28BE19C70;
 Fri, 21 Feb 2020 18:30:26 +0000 (UTC)
Date: Fri, 21 Feb 2020 13:30:26 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 12/13] hw/arm/raspi: Add the Raspberry Pi B+ machine
Message-ID: <20200221183026.GD5238@habkost.net>
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-13-f4bug@amsat.org>
 <26d85b1f-b2b7-ff9f-1236-43e9cb761c30@greensocs.com>
 <c56d4f85-b4df-643c-c017-350b7f64aec2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c56d4f85-b4df-643c-c017-350b7f64aec2@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 10:35:43AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Eduardo/Igor.
>=20
> On 2/18/20 9:48 AM, Luc Michel wrote:
> > On 2/17/20 12:45 PM, Philippe Mathieu-Daud=E9 wrote:
> > >    $ qemu-system-arm -M raspi1b -serial stdio \
> > >        -kernel raspberrypi/firmware/boot/kernel.img \
> > >        -dtb raspberrypi/firmware/boot/bcm2708-rpi-b.dtb \
> > >        -append 'printk.time=3D0 earlycon=3Dpl011,0x20201000 console=
=3DttyAMA0'
> > >    [    0.000000] Booting Linux on physical CPU 0x0
> > >    [    0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc version =
4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep 3 20:21=
:01 BST 2019
> > >    [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision=
 7 (ARMv7), cr=3D00c5387d
> > >    [    0.000000] CPU: VIPT aliasing data cache, unknown instruction =
cache
> > >    [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
> > >    [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
> > >    [    0.000000] bootconsole [pl11] enabled
> > >    [    0.000000] Memory policy: Data cache writeback
> > >    [    0.000000] cma: Reserved 8 MiB at 0x1b800000
> > >    [    0.000000] random: get_random_bytes called from start_kernel+0=
x8c/0x49c with crng_init=3D0
> > >    [    0.000000] Built 1 zonelists, mobility grouping on.  Total pag=
es: 113680
> > >    [    0.000000] Kernel command line: printk.time=3D0 earlycon=3Dpl0=
11,0x20201000 console=3DttyAMA0
> > >    Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> > >    Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> > >    Memory: 434380K/458752K available (6971K kernel code, 635K rwdata,=
 2080K rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
> > >    ...
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > ---
> > >   hw/arm/raspi.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > >=20
> > > diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> > > index 3537a329ac..2d9f4e3085 100644
> > > --- a/hw/arm/raspi.c
> > > +++ b/hw/arm/raspi.c
> > > @@ -324,6 +324,15 @@ static void raspi_machine_class_common_init(Mach=
ineClass *mc,
> > >       mc->default_ram_size =3D board_ram_size(board_rev);
> > >   };
> > > +static void raspi1b_machine_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > > +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> > > +
> > > +    rmc->board_rev =3D 0x900032;
> > > +    raspi_machine_class_common_init(mc, rmc->board_rev);
> > > +};
> > > +
> > >   static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
> > >   {
> > >       MachineClass *mc =3D MACHINE_CLASS(oc);
> > > @@ -348,6 +357,10 @@ static void raspi3b_machine_class_init(ObjectCla=
ss *oc, void *data)
> > >   static const TypeInfo raspi_machine_types[] =3D {
> > >       {
> > > +        .name           =3D MACHINE_TYPE_NAME("raspi1b"),
> > If it's the B+ model, why not call it raspi1b+ ?
>=20
> I thought about it (and prefer it), but I'm not sure this can have some
> side-effect.
>=20
> Eduardo, Igor, is that OK to use a '+' in a machine name?

It would probably work, but I would prefer to avoid that.

>=20
> So far the names used match [a-zA-Z0-9-].
>=20
> >=20
> > > +        .parent         =3D TYPE_RASPI_MACHINE,
> > > +        .class_init     =3D raspi1b_machine_class_init,
> > > +    }, {
> > >           .name           =3D MACHINE_TYPE_NAME("raspi2b"),
> > >           .parent         =3D TYPE_RASPI_MACHINE,
> > >           .class_init     =3D raspi2b_machine_class_init,
> > >=20
> >=20
>=20

--=20
Eduardo


