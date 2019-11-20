Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A47C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441AC2088F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQqbTBhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441AC2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXT8R-0005aK-FT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXT6s-0003bW-AF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXT6q-0002RL-Fe
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:45:42 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iXT6k-0002Or-TV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:45:36 -0500
Received: by mail-wr1-x442.google.com with SMTP id w9so671825wrr.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WlWKwatgBhd8wI3amqobjwzO9M2adDGCwC3SO4Qaskc=;
 b=UQqbTBhsVpmoz3PGWi9myOl9K+e/JMpG7AQTGxalavxlGDqmAa50y07EPdLJPgv5Om
 PK3KQTH0u4GgiqbPvBuREXhhfa8qBGI46r4yh04oYaLNsGW8nGsPMgBXCTmNhDqiZykt
 b36P1KMDvq8I0TWD653WRqJwg/UYTqOWGUbqzsDJVVc5zsaKHRzs72yihypqHJsdL1fP
 FDAdU2SFepTPuwbwn04m7PQ0do9JwOajRAB/8F/1Y6r3HGPF/ARnc83J1p9bw81oq6r2
 q3ZY53Qptn30WHGpElPCNi26hll7ZlsZuURIwWs1CBPkHBAXtroSjnIS2afV2eqmEtSx
 Sd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WlWKwatgBhd8wI3amqobjwzO9M2adDGCwC3SO4Qaskc=;
 b=GYz2PUwaPhnmi/IonIsBn28+5+vifHV4T1VSeR67uetmdIsswFJvxKnF4d7kll79re
 Fm3EGwr3+JTVfJh2Gw/L7OEAkYdWk9GUnpJQ9T68Kxk2HZVzagk+wHKngLVwMNdu19Ld
 3zsDA8XobpHZKFOQ7DPcu5/iVpALFlo830eFzFOdBMZS/1fuf/nWgkJcxVyX+fMbIhr+
 oNifqmNTe7ntG+xxjgR9c6sCEIlBZJfTtIhvljp9of39t64ir5rTH1wO7iNdXx+mmyPc
 4DSCni5EkVtnIc8sGR6kAFhKof4j6pYMREeZpu0Lml/0W6Ct+F0AAh8VYp0621Jsta1V
 Q6Cg==
X-Gm-Message-State: APjAAAVZjlamSY9oAcoNVRTqiiRzI6eweA1qHxFmoAwP8gArCYODVKKh
 bfAjS87llkpy0Ch4aKr7XhOYkSP8Laih4pybZCc=
X-Google-Smtp-Source: APXvYqzZch22SKvtyQF9KbcMNOefZZ5Pil3l4jLXikGH7wyCuU0lmLwFSp8nFXvuRT0k3oHVEHldCvgm9vHirPnPnlg=
X-Received: by 2002:a5d:4ad2:: with SMTP id y18mr4522432wrs.396.1574268330627; 
 Wed, 20 Nov 2019 08:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-7-marcandre.lureau@redhat.com>
 <c43719b2-9ed9-d77e-3cd5-95ee8bd29568@redhat.com>
In-Reply-To: <c43719b2-9ed9-d77e-3cd5-95ee8bd29568@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Nov 2019 20:45:16 +0400
Message-ID: <CAJ+F1C+6W=g26VUdtAR6taPbOXBB8O0GxDfp8xiwWFqjWC_-BQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/37] serial: initial qom-ification
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 20, 2019 at 8:42 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Make SerialState a device (the following patches will introduce IO/MM
> > sysbus serial devices)
> >
> > None of the serial_{,mm}_init() callers actually free the returned
> > value (even if they did, it would be quite harmless), so we can change
> > the object allocation at will.
> >
> > However, the devices that embed SerialState must now have their field
> > QOM-initialized manually (isa, pci, pci-multi).
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/char/serial-isa.c       |  9 +++++++++
> >   hw/char/serial-pci-multi.c | 15 +++++++++++++++
> >   hw/char/serial-pci.c       | 13 ++++++++++++-
> >   hw/char/serial.c           | 33 +++++++++++++++++++++++++++------
> >   include/hw/char/serial.h   |  7 ++++++-
> >   5 files changed, 69 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> > index 9e31c51bb6..9a5928b3ee 100644
> > --- a/hw/char/serial-isa.c
> > +++ b/hw/char/serial-isa.c
> > @@ -111,10 +111,19 @@ static void serial_isa_class_initfn(ObjectClass *=
klass, void *data)
> >       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> >   }
> >
> > +static void serial_isa_initfn(Object *o)
> > +{
> > +    ISASerialState *self =3D ISA_SERIAL(o);
> > +
> > +    object_initialize_child(o, "serial", &self->state, sizeof(self->st=
ate),
> > +                            TYPE_SERIAL, &error_abort, NULL);
> > +}
> > +
> >   static const TypeInfo serial_isa_info =3D {
> >       .name          =3D TYPE_ISA_SERIAL,
> >       .parent        =3D TYPE_ISA_DEVICE,
> >       .instance_size =3D sizeof(ISASerialState),
> > +    .instance_init =3D serial_isa_initfn,
> >       .class_init    =3D serial_isa_class_initfn,
> >   };
> >
> > diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> > index 5c553c30d0..edfbfdca9e 100644
> > --- a/hw/char/serial-pci-multi.c
> > +++ b/hw/char/serial-pci-multi.c
> > @@ -181,10 +181,24 @@ static void multi_4x_serial_pci_class_initfn(Obje=
ctClass *klass, void *data)
> >       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> >   }
> >
> > +static void multi_serial_init(Object *o)
> > +{
> > +    PCIDevice *dev =3D PCI_DEVICE(o);
> > +    PCIMultiSerialState *pms =3D DO_UPCAST(PCIMultiSerialState, dev, d=
ev);
> > +    size_t i, nports =3D multi_serial_get_port_count(PCI_DEVICE_GET_CL=
ASS(dev));
> > +
> > +    for (i =3D 0; i < nports; i++) {
> > +        object_initialize_child(o, "serial[*]", &pms->state[i],
> > +                                sizeof(pms->state[i]),
> > +                                TYPE_SERIAL, &error_abort, NULL);
> > +    }
> > +}
> > +
> >   static const TypeInfo multi_2x_serial_pci_info =3D {
> >       .name          =3D "pci-serial-2x",
> >       .parent        =3D TYPE_PCI_DEVICE,
> >       .instance_size =3D sizeof(PCIMultiSerialState),
> > +    .instance_init =3D multi_serial_init,
> >       .class_init    =3D multi_2x_serial_pci_class_initfn,
> >       .interfaces =3D (InterfaceInfo[]) {
> >           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > @@ -196,6 +210,7 @@ static const TypeInfo multi_4x_serial_pci_info =3D =
{
> >       .name          =3D "pci-serial-4x",
> >       .parent        =3D TYPE_PCI_DEVICE,
> >       .instance_size =3D sizeof(PCIMultiSerialState),
> > +    .instance_init =3D multi_serial_init,
> >       .class_init    =3D multi_4x_serial_pci_class_initfn,
> >       .interfaces =3D (InterfaceInfo[]) {
> >           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> > index cb9b76e22b..f99b6c19e0 100644
> > --- a/hw/char/serial-pci.c
> > +++ b/hw/char/serial-pci.c
> > @@ -40,6 +40,8 @@ typedef struct PCISerialState {
> >       uint8_t prog_if;
> >   } PCISerialState;
> >
> > +#define TYPE_PCI_SERIAL "pci-serial"
> > +#define PCI_SERIAL(s) OBJECT_CHECK(PCISerialState, (s), TYPE_PCI_SERIA=
L)
> >
> >   static void serial_pci_realize(PCIDevice *dev, Error **errp)
> >   {
> > @@ -103,10 +105,19 @@ static void serial_pci_class_initfn(ObjectClass *=
klass, void *data)
> >       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> >   }
> >
> > +static void serial_pci_init(Object *o)
> > +{
> > +    PCISerialState *ps =3D PCI_SERIAL(o);
> > +
> > +    object_initialize_child(o, "serial", &ps->state, sizeof(ps->state)=
,
> > +                            TYPE_SERIAL, &error_abort, NULL);
> > +}
> > +
> >   static const TypeInfo serial_pci_info =3D {
> > -    .name          =3D "pci-serial",
> > +    .name          =3D TYPE_PCI_SERIAL,
> >       .parent        =3D TYPE_PCI_DEVICE,
> >       .instance_size =3D sizeof(PCISerialState),
> > +    .instance_init =3D serial_pci_init,
> >       .class_init    =3D serial_pci_class_initfn,
> >       .interfaces =3D (InterfaceInfo[]) {
> >           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index b4aa250950..e0a5bec290 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -983,9 +983,8 @@ const MemoryRegionOps serial_io_ops =3D {
> >   SerialState *serial_init(int base, qemu_irq irq, int baudbase,
> >                            Chardev *chr, MemoryRegion *system_io)
> >   {
> > -    SerialState *s;
> > -
> > -    s =3D g_malloc0(sizeof(SerialState));
> > +    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> > +    SerialState *s =3D SERIAL(dev);
> >
> >       s->irq =3D irq;
> >       s->baudbase =3D baudbase;
> > @@ -993,6 +992,7 @@ SerialState *serial_init(int base, qemu_irq irq, in=
t baudbase,
> >       serial_realize_core(s, &error_fatal);
> >
> >       vmstate_register(NULL, base, &vmstate_serial, s);
> > +    qdev_init_nofail(dev);
> >
> >       memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", =
8);
> >       memory_region_add_subregion(system_io, base, &s->io);
> > @@ -1000,6 +1000,20 @@ SerialState *serial_init(int base, qemu_irq irq,=
 int baudbase,
> >       return s;
> >   }
> >
> > +static void serial_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->user_creatable =3D false;
>
> Why? Due to the "chardev" property?

No, because it's not user usable as such (it's an internal device for
serialio/serialmm and others). And making abstract wouldn't work
either.

>
> > +}
> > +
> > +static const TypeInfo serial_info =3D {
> > +    .name =3D TYPE_SERIAL,
> > +    .parent =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(SerialState),
> > +    .class_init =3D serial_class_init,
> > +};
> > +
> >   /* Memory mapped interface */
> >   static uint64_t serial_mm_read(void *opaque, hwaddr addr,
> >                                  unsigned size)
> > @@ -1045,9 +1059,8 @@ SerialState *serial_mm_init(MemoryRegion *address=
_space,
> >                               qemu_irq irq, int baudbase,
> >                               Chardev *chr, enum device_endian end)
> >   {
> > -    SerialState *s;
> > -
> > -    s =3D g_malloc0(sizeof(SerialState));
> > +    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> > +    SerialState *s =3D SERIAL(dev);
> >
> >       s->it_shift =3D it_shift;
> >       s->irq =3D irq;
> > @@ -1056,9 +1069,17 @@ SerialState *serial_mm_init(MemoryRegion *addres=
s_space,
> >
> >       serial_realize_core(s, &error_fatal);
> >       vmstate_register(NULL, base, &vmstate_serial, s);
> > +    qdev_init_nofail(dev);
> >
> >       memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
> >                             "serial", 8 << it_shift);
> >       memory_region_add_subregion(address_space, base, &s->io);
> >       return s;
> >   }
> > +
> > +static void serial_register_types(void)
> > +{
> > +    type_register_static(&serial_info);
> > +}
> > +
> > +type_init(serial_register_types)
> > diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> > index 8be3d8a4f9..180cc7c24e 100644
> > --- a/include/hw/char/serial.h
> > +++ b/include/hw/char/serial.h
> > @@ -30,10 +30,13 @@
> >   #include "exec/memory.h"
> >   #include "qemu/fifo8.h"
> >   #include "chardev/char.h"
> > +#include "hw/sysbus.h"
> >
> >   #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
> >
> >   typedef struct SerialState {
> > +    DeviceState parent;
> > +
> >       uint16_t divider;
> >       uint8_t rbr; /* receive register */
> >       uint8_t thr; /* transmit holding register */
> > @@ -84,7 +87,9 @@ void serial_realize_core(SerialState *s, Error **errp=
);
> >   void serial_exit_core(SerialState *s);
> >   void serial_set_frequency(SerialState *s, uint32_t frequency);
> >
> > -/* legacy pre qom */
> > +#define TYPE_SERIAL "serial"
> > +#define SERIAL(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL)
> > +
> >   SerialState *serial_init(int base, qemu_irq irq, int baudbase,
> >                            Chardev *chr, MemoryRegion *system_io);
> >   SerialState *serial_mm_init(MemoryRegion *address_space,
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau

