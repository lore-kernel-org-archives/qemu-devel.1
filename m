Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F0FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23ED2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chGI5dVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23ED2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyUj-0001m2-VG
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jIyPi-0003pn-FC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jIyPg-0004oV-Pt
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:41:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53199)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jIyPg-0004nv-Lo
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585590087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IpxZKY7hw37LIBDLiGqmFLlCGZacOzt9psBdBXuz4DU=;
 b=chGI5dVB4/V3Qj7UGaO8XinHuBDi/gdTabf2pjB2Ab2EJzUv5Ic1SYluB8LGaZ2d5Hyn4j
 MDco9ubCGc/bvHqPLDNs4cBmeuDFXh4ag2cB0ATpHcRah8ZSyTIns1pPfy69QV4jMzl3fT
 BnqQMf93t97nNUXkCW5bQvnEbch6aUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-YtahEkWDMVCQbdkiiTEzBw-1; Mon, 30 Mar 2020 13:41:24 -0400
X-MC-Unique: YtahEkWDMVCQbdkiiTEzBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFF1C10CE787;
 Mon, 30 Mar 2020 17:41:22 +0000 (UTC)
Received: from work-vm (ovpn-114-162.ams2.redhat.com [10.36.114.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48CA896B60;
 Mon, 30 Mar 2020 17:41:19 +0000 (UTC)
Date: Mon, 30 Mar 2020 18:41:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] serial: Fix double migration data
Message-ID: <20200330174116.GC2843@work-vm>
References: <20200330164712.198282-1-dgilbert@redhat.com>
 <CAJ+F1CKd9x3BQKCGFPF8ouW4Fzvw0R5z3ZRT_0XPNSepP5hMZQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKd9x3BQKCGFPF8ouW4Fzvw0R5z3ZRT_0XPNSepP5hMZQ@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Mon, Mar 30, 2020 at 6:47 PM Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > After c9808d60281 we have both an object representing the serial-isa
> > device and a separate object representing the underlying common serial
> > uart.  Both of these have vmsd's associated with them and thus the
> > migration stream ends up with two copies of the migration data - the
> > serial-isa includes the vmstate of the core serial.   Besides
> > being wrong, it breaks backwards migration compatibility.
> >
> > Fix this by removing the dc->vmsd from the core device, so it only
> > gets migrated by any parent devices including it.
> > Add a vmstate_serial_mm so that any device that uses serial_mm_init
> > rather than creating a device still gets migrated.
> > (That doesn't fix backwards migration for serial_mm_init users,
> > but does seem to work forwards for ppce500).
> >
> > Fixes: c9808d60281 ('serial: realize the serial device')
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1869426
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/char/serial.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 2ab8b69e03..c822a9ae6c 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -1043,7 +1043,6 @@ static void serial_class_init(ObjectClass *klass,=
 void* data)
> >      dc->user_creatable =3D false;
> >      dc->realize =3D serial_realize;
> >      dc->unrealize =3D serial_unrealize;
> > -    dc->vmsd =3D &vmstate_serial;
> >      device_class_set_props(dc, serial_properties);
> >  }
> >
> > @@ -1113,6 +1112,16 @@ static void serial_mm_realize(DeviceState *dev, =
Error **errp)
> >      sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
> >  }
> >
> > +static const VMStateDescription vmstate_serial_mm =3D {
> > +    .name =3D "serial",
> > +    .version_id =3D 3,
> > +    .minimum_version_id =3D 2,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_STRUCT(serial, SerialMM, 0, vmstate_serial, SerialStat=
e),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
>=20
> Why do you make it a sub-state?

Because it's consistent with serial-isa and it's simple.

> # qemu-system-ppc -M ppce500 -monitor stdio -serial pty
> in 4.2 and 5.0:
>     "serial (8)": {
>         "divider": "0x00d9",
>         "rbr": "0x00",
>         "ier": "0x00",
>         "iir": "0xc1",
>         "lcr": "0x03",
>         "mcr": "0x03",
>         "lsr": "0x60",
>         "msr": "0xb0",
>         "scr": "0x00",
>         "fcr_vmstate": "0x01"
>     },
>=20
> With this patch:
>     "serial (8)": {
>         "serial": {
>             "divider": "0x00d9",
>             "rbr": "0x00",
>             "ier": "0x00",
>             "iir": "0xc1",
>             "lcr": "0x03",
>             "mcr": "0x03",
>             "lsr": "0x60",
>             "msr": "0xb0",
>             "scr": "0x00",
>             "fcr_vmstate": "0x01"
>         }
>     },
>=20
> >  SerialMM *serial_mm_init(MemoryRegion *address_space,
> >                           hwaddr base, int regshift,
> >                           qemu_irq irq, int baudbase,
> > @@ -1162,6 +1171,7 @@ static void serial_mm_class_init(ObjectClass *oc,=
 void *data)
> >
> >      device_class_set_props(dc, serial_mm_properties);
> >      dc->realize =3D serial_mm_realize;
> > +    dc->vmsd =3D &vmstate_serial_mm;
> >  }
> >
> >  static const TypeInfo serial_mm_info =3D {
> > --
> > 2.25.1
> >
> >
>=20
> I understand removing the serial state from SerialClass solves the
> double state issue for ISA. But at the same time, I think we should
> aim to migrate ISASerial state to SerialClass state. I can take a look
> if you want.

I don't think there's anything wrong with having a separate layer here;
the physical reality of what we have is a UART (Serial) that is on the
ISA bus where the ISA bus interfacing doesn't require any extra state
to be migrated.

Dave

>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


