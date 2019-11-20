Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC373C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC0C20895
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOsBMS/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0C20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXT4f-0000ui-H7
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXT2L-0007QA-7J
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXT2I-00006C-LF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:41:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXT2I-00005q-Hl
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574268057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+B4pw7lElhWTz7e16CVN/dRmz6cM51ARg/YYW13kDM=;
 b=EOsBMS/0Onh0CtApbIS1rgsdAilmwHK9ICBd9mJjeCCIeR1R71S2M7G5oxlpUlK4FPYdEB
 dyGeYujuD8aIQts5t430rysBssd2pGkUBj0aldg4CUxsTbEK7MRmctQ0DamAzms8XXXCbd
 jYsP4ZN2KehmYqUgJ3IuLR0szDWph70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-Uqw1IHgXMySfWLPUpgJc_g-1; Wed, 20 Nov 2019 11:40:56 -0500
Received: by mail-wm1-f70.google.com with SMTP id i23so4942320wmb.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UjUPmyQwcMwWke5krDyi91vJ7MJ96ZljOUHUVnGFPOQ=;
 b=qyGUXfPB8xdfw8lCCzz2H63C4sALz6jJUgT6Ts60voBFw5imPzObD27DHvCmzW+mGA
 nHax2UEJnRH0HWM0Ni4rXnbE5zGn/9uD8xGvfz9MH5OMdWVzMwto+OhpdmefzQYTJjg5
 sOU8LLVSiQqY9lPS8LJc04eA0EFAdKkpKz2aaXwN2YXiiFs/nokpDvzMlZ2buFpWsrFw
 o5vqrGJp/R2RNtHFBK3vgW7L2kug3SVduxWWemTLzoiDs4xEDbwRHHINo02Hc74yHToN
 VSAmItnQqmYxzD2x7lomzd3QYGPRGpQ7RbDjFs/jMRHdsyexaKfedL+0hJcRV6ymrYT8
 YwkA==
X-Gm-Message-State: APjAAAVvWjqh7lI4YcgEM5zl7c+dwDEzc10ssYk2SsDO0wPCS2eEiYnS
 lHB+dcMB53GSQCC3AJIXljDsyu3ieTymMYqdqI7+p5kYtN86e58joS6RJTJmfVQPDlKV6QZkoC8
 eADhlR1Tg9bVuweI=
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr4564876wru.211.1574268055288; 
 Wed, 20 Nov 2019 08:40:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxv4ZIJeJwuUF88kdtwnVIa7oCKHL2tJprRA7YI1MkUPmfySVYQg4OIBkA1kP52J32xWgwIBg==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr4564845wru.211.1574268055025; 
 Wed, 20 Nov 2019 08:40:55 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id w11sm36173486wra.83.2019.11.20.08.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:40:53 -0800 (PST)
Subject: Re: [PATCH v4 06/37] serial: initial qom-ification
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-7-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c43719b2-9ed9-d77e-3cd5-95ee8bd29568@redhat.com>
Date: Wed, 20 Nov 2019 17:40:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-7-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: Uqw1IHgXMySfWLPUpgJc_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Make SerialState a device (the following patches will introduce IO/MM
> sysbus serial devices)
>=20
> None of the serial_{,mm}_init() callers actually free the returned
> value (even if they did, it would be quite harmless), so we can change
> the object allocation at will.
>=20
> However, the devices that embed SerialState must now have their field
> QOM-initialized manually (isa, pci, pci-multi).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial-isa.c       |  9 +++++++++
>   hw/char/serial-pci-multi.c | 15 +++++++++++++++
>   hw/char/serial-pci.c       | 13 ++++++++++++-
>   hw/char/serial.c           | 33 +++++++++++++++++++++++++++------
>   include/hw/char/serial.h   |  7 ++++++-
>   5 files changed, 69 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index 9e31c51bb6..9a5928b3ee 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -111,10 +111,19 @@ static void serial_isa_class_initfn(ObjectClass *kl=
ass, void *data)
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>   }
>  =20
> +static void serial_isa_initfn(Object *o)
> +{
> +    ISASerialState *self =3D ISA_SERIAL(o);
> +
> +    object_initialize_child(o, "serial", &self->state, sizeof(self->stat=
e),
> +                            TYPE_SERIAL, &error_abort, NULL);
> +}
> +
>   static const TypeInfo serial_isa_info =3D {
>       .name          =3D TYPE_ISA_SERIAL,
>       .parent        =3D TYPE_ISA_DEVICE,
>       .instance_size =3D sizeof(ISASerialState),
> +    .instance_init =3D serial_isa_initfn,
>       .class_init    =3D serial_isa_class_initfn,
>   };
>  =20
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 5c553c30d0..edfbfdca9e 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -181,10 +181,24 @@ static void multi_4x_serial_pci_class_initfn(Object=
Class *klass, void *data)
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>   }
>  =20
> +static void multi_serial_init(Object *o)
> +{
> +    PCIDevice *dev =3D PCI_DEVICE(o);
> +    PCIMultiSerialState *pms =3D DO_UPCAST(PCIMultiSerialState, dev, dev=
);
> +    size_t i, nports =3D multi_serial_get_port_count(PCI_DEVICE_GET_CLAS=
S(dev));
> +
> +    for (i =3D 0; i < nports; i++) {
> +        object_initialize_child(o, "serial[*]", &pms->state[i],
> +                                sizeof(pms->state[i]),
> +                                TYPE_SERIAL, &error_abort, NULL);
> +    }
> +}
> +
>   static const TypeInfo multi_2x_serial_pci_info =3D {
>       .name          =3D "pci-serial-2x",
>       .parent        =3D TYPE_PCI_DEVICE,
>       .instance_size =3D sizeof(PCIMultiSerialState),
> +    .instance_init =3D multi_serial_init,
>       .class_init    =3D multi_2x_serial_pci_class_initfn,
>       .interfaces =3D (InterfaceInfo[]) {
>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> @@ -196,6 +210,7 @@ static const TypeInfo multi_4x_serial_pci_info =3D {
>       .name          =3D "pci-serial-4x",
>       .parent        =3D TYPE_PCI_DEVICE,
>       .instance_size =3D sizeof(PCIMultiSerialState),
> +    .instance_init =3D multi_serial_init,
>       .class_init    =3D multi_4x_serial_pci_class_initfn,
>       .interfaces =3D (InterfaceInfo[]) {
>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> index cb9b76e22b..f99b6c19e0 100644
> --- a/hw/char/serial-pci.c
> +++ b/hw/char/serial-pci.c
> @@ -40,6 +40,8 @@ typedef struct PCISerialState {
>       uint8_t prog_if;
>   } PCISerialState;
>  =20
> +#define TYPE_PCI_SERIAL "pci-serial"
> +#define PCI_SERIAL(s) OBJECT_CHECK(PCISerialState, (s), TYPE_PCI_SERIAL)
>  =20
>   static void serial_pci_realize(PCIDevice *dev, Error **errp)
>   {
> @@ -103,10 +105,19 @@ static void serial_pci_class_initfn(ObjectClass *kl=
ass, void *data)
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>   }
>  =20
> +static void serial_pci_init(Object *o)
> +{
> +    PCISerialState *ps =3D PCI_SERIAL(o);
> +
> +    object_initialize_child(o, "serial", &ps->state, sizeof(ps->state),
> +                            TYPE_SERIAL, &error_abort, NULL);
> +}
> +
>   static const TypeInfo serial_pci_info =3D {
> -    .name          =3D "pci-serial",
> +    .name          =3D TYPE_PCI_SERIAL,
>       .parent        =3D TYPE_PCI_DEVICE,
>       .instance_size =3D sizeof(PCISerialState),
> +    .instance_init =3D serial_pci_init,
>       .class_init    =3D serial_pci_class_initfn,
>       .interfaces =3D (InterfaceInfo[]) {
>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index b4aa250950..e0a5bec290 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -983,9 +983,8 @@ const MemoryRegionOps serial_io_ops =3D {
>   SerialState *serial_init(int base, qemu_irq irq, int baudbase,
>                            Chardev *chr, MemoryRegion *system_io)
>   {
> -    SerialState *s;
> -
> -    s =3D g_malloc0(sizeof(SerialState));
> +    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> +    SerialState *s =3D SERIAL(dev);
>  =20
>       s->irq =3D irq;
>       s->baudbase =3D baudbase;
> @@ -993,6 +992,7 @@ SerialState *serial_init(int base, qemu_irq irq, int =
baudbase,
>       serial_realize_core(s, &error_fatal);
>  =20
>       vmstate_register(NULL, base, &vmstate_serial, s);
> +    qdev_init_nofail(dev);
>  =20
>       memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8)=
;
>       memory_region_add_subregion(system_io, base, &s->io);
> @@ -1000,6 +1000,20 @@ SerialState *serial_init(int base, qemu_irq irq, i=
nt baudbase,
>       return s;
>   }
>  =20
> +static void serial_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->user_creatable =3D false;

Why? Due to the "chardev" property?

> +}
> +
> +static const TypeInfo serial_info =3D {
> +    .name =3D TYPE_SERIAL,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(SerialState),
> +    .class_init =3D serial_class_init,
> +};
> +
>   /* Memory mapped interface */
>   static uint64_t serial_mm_read(void *opaque, hwaddr addr,
>                                  unsigned size)
> @@ -1045,9 +1059,8 @@ SerialState *serial_mm_init(MemoryRegion *address_s=
pace,
>                               qemu_irq irq, int baudbase,
>                               Chardev *chr, enum device_endian end)
>   {
> -    SerialState *s;
> -
> -    s =3D g_malloc0(sizeof(SerialState));
> +    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> +    SerialState *s =3D SERIAL(dev);
>  =20
>       s->it_shift =3D it_shift;
>       s->irq =3D irq;
> @@ -1056,9 +1069,17 @@ SerialState *serial_mm_init(MemoryRegion *address_=
space,
>  =20
>       serial_realize_core(s, &error_fatal);
>       vmstate_register(NULL, base, &vmstate_serial, s);
> +    qdev_init_nofail(dev);
>  =20
>       memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
>                             "serial", 8 << it_shift);
>       memory_region_add_subregion(address_space, base, &s->io);
>       return s;
>   }
> +
> +static void serial_register_types(void)
> +{
> +    type_register_static(&serial_info);
> +}
> +
> +type_init(serial_register_types)
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 8be3d8a4f9..180cc7c24e 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -30,10 +30,13 @@
>   #include "exec/memory.h"
>   #include "qemu/fifo8.h"
>   #include "chardev/char.h"
> +#include "hw/sysbus.h"
>  =20
>   #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
>  =20
>   typedef struct SerialState {
> +    DeviceState parent;
> +
>       uint16_t divider;
>       uint8_t rbr; /* receive register */
>       uint8_t thr; /* transmit holding register */
> @@ -84,7 +87,9 @@ void serial_realize_core(SerialState *s, Error **errp);
>   void serial_exit_core(SerialState *s);
>   void serial_set_frequency(SerialState *s, uint32_t frequency);
>  =20
> -/* legacy pre qom */
> +#define TYPE_SERIAL "serial"
> +#define SERIAL(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL)
> +
>   SerialState *serial_init(int base, qemu_irq irq, int baudbase,
>                            Chardev *chr, MemoryRegion *system_io);
>   SerialState *serial_mm_init(MemoryRegion *address_space,
>=20


