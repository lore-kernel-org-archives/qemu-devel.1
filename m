Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68C5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9039E20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fopC4DtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9039E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYu2-0003tw-NB
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iNYnK-000673-EM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iNYnI-0005cG-Sb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:48:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iNYnI-0005bu-Ii; Thu, 24 Oct 2019 04:48:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id r141so1703180wme.4;
 Thu, 24 Oct 2019 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EjHSgh2TbyrYHlVMIgQ6SppN8Xp/3S6Ywx5We+kui3w=;
 b=fopC4DtQs5Zp4wG3qMNsySNSkEssjB9CVzEmNzAFM2NF8GUiK/4eGRIC8/K4pLbsNe
 KAy7P3WjywE0sm+EsHPLTfgvyadqQPYHyeN8AFp5vIOUxF37bVU4jQhbKoj6wZc8Vrex
 Cr6H46k9i0XBF+jOuwozexhba3NGAF96OTJrRMMO7qdTc8QsfD0T2FGA2IntnzRs+4wr
 G89aLjA2NqOfs9187FMsKhfEVIsZOyAd8IPwLPECA37AbHA915+0AsN8MEqnGlxG2C86
 4lgC18Xqv/9nNVTHDiw7rpEpFIi16RHO4iIIZrGE8Nx8fWCkOAGukaH4nsY0HWTL7gsc
 XnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EjHSgh2TbyrYHlVMIgQ6SppN8Xp/3S6Ywx5We+kui3w=;
 b=kCDtbz5AOWX9I9KtypAZL5eVeHVLPGicmT7w/HqdyR23vMDGr9YD/MjfSuBVE7H+Xm
 xCnkFoRYevWvNJiD2WF+++9fDj/F9x/CR/eiYWHr2ccNDZzBaVspAj7NDznnjoiYEwao
 Y3M+7bDN6YxXVZUZuEV2TWuYnVxn2B52PzzNUoBsW4XTv+ycvSqlzCTF70vU/RjQWpRG
 +vp2dIIC8UGsn30pabLy4rkgk2O+qF0RlGVt/CBytjIFSHAMSLPByRTFgS/76ccVxT6Z
 nwv/+N+msM2+AmpOqdVN8uJEuTbHFOTOu8Gel+nkZFpkFSbTFP1+tpya0xR6+vn//u7U
 cs+w==
X-Gm-Message-State: APjAAAV9Xegygfaiv3/3mWA68XKvpEYrAj1x7ASDjcT1LUMCkDIwKVD2
 oCalEEjtbbiI3UJ1mq02XLOSXepdxRid6YKAVyBy6GBx
X-Google-Smtp-Source: APXvYqze/gsuy3UqnrkVxquSPeY1AcyUn6l4dYgHWbinr8FZcjuLaBbmW4SFbHX+2zjTsxToBluIr91HtVCIfGdaanU=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr3756595wmj.91.1571906909646;
 Thu, 24 Oct 2019 01:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-7-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Oct 2019 10:48:17 +0200
Message-ID: <CAJ+F1C+N-fJXTPHREK_-gFAwUnaVECvWgsEzzJsAbG5LedZOjQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/33] serial: initial qom-ification
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "open list:ARM" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 9:06 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Make SerialState a device (the following patches will introduce IO/MM
> sysbus serial devices)
>
> None of the serial_{,mm}_init() callers actually free the returned
> value (even if they did, it would be quite harmless), so we can change
> the object allocation at will.
>
> However, the devices that embed SerialState must now have their field
> QOM-initialized manually (isa, pci, pci-multi).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial-isa.c       |  9 +++++++++
>  hw/char/serial-pci-multi.c | 15 +++++++++++++++
>  hw/char/serial-pci.c       | 13 ++++++++++++-
>  hw/char/serial.c           | 25 +++++++++++++++++++------
>  include/hw/char/serial.h   |  7 ++++++-
>  5 files changed, 61 insertions(+), 8 deletions(-)
>
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index 9e31c51bb6..9a5928b3ee 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -111,10 +111,19 @@ static void serial_isa_class_initfn(ObjectClass *kl=
ass, void *data)
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>
> +static void serial_isa_initfn(Object *o)
> +{
> +    ISASerialState *self =3D ISA_SERIAL(o);
> +
> +    object_initialize_child(o, "serial", &self->state, sizeof(self->stat=
e),
> +                            TYPE_SERIAL, &error_abort, NULL);
> +}
> +
>  static const TypeInfo serial_isa_info =3D {
>      .name          =3D TYPE_ISA_SERIAL,
>      .parent        =3D TYPE_ISA_DEVICE,
>      .instance_size =3D sizeof(ISASerialState),
> +    .instance_init =3D serial_isa_initfn,
>      .class_init    =3D serial_isa_class_initfn,
>  };
>
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 6fa1cc6225..3485bdad87 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -182,10 +182,24 @@ static void multi_4x_serial_pci_class_initfn(Object=
Class *klass, void *data)
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>
> +static void multi_serial_init(Object *o)
> +{
> +    PCIDevice *dev =3D PCI_DEVICE(o);
> +    PCIMultiSerialState *self =3D DO_UPCAST(PCIMultiSerialState, dev, de=
v);
> +    int i, nr_ports =3D multi_serial_get_nr_ports(PCI_DEVICE_GET_CLASS(d=
ev));
> +
> +    for (i =3D 0; i < nr_ports; i++) {
> +        object_initialize_child(o, "serial[*]", &self->state[i],
> +                                sizeof(self->state[i]),
> +                                TYPE_SERIAL, &error_abort, NULL);
> +    }
> +}
> +
>  static const TypeInfo multi_2x_serial_pci_info =3D {
>      .name          =3D "pci-serial-2x",
>      .parent        =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(PCIMultiSerialState),
> +    .instance_init =3D multi_serial_init,
>      .class_init    =3D multi_2x_serial_pci_class_initfn,
>      .interfaces =3D (InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> @@ -197,6 +211,7 @@ static const TypeInfo multi_4x_serial_pci_info =3D {
>      .name          =3D "pci-serial-4x",
>      .parent        =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(PCIMultiSerialState),
> +    .instance_init =3D multi_serial_init,
>      .class_init    =3D multi_4x_serial_pci_class_initfn,
>      .interfaces =3D (InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> index cb9b76e22b..a33264a1fb 100644
> --- a/hw/char/serial-pci.c
> +++ b/hw/char/serial-pci.c
> @@ -40,6 +40,8 @@ typedef struct PCISerialState {
>      uint8_t prog_if;
>  } PCISerialState;
>
> +#define TYPE_PCI_SERIAL "pci-serial"
> +#define PCI_SERIAL(s) OBJECT_CHECK(PCISerialState, (s), TYPE_PCI_SERIAL)
>
>  static void serial_pci_realize(PCIDevice *dev, Error **errp)
>  {
> @@ -103,10 +105,19 @@ static void serial_pci_class_initfn(ObjectClass *kl=
ass, void *data)
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>
> +static void serial_pci_init(Object *o)
> +{
> +    PCISerialState *self =3D PCI_SERIAL(o);
> +
> +    object_initialize_child(o, "serial", &self->state, sizeof(self->stat=
e),
> +                            TYPE_SERIAL, &error_abort, NULL);
> +}
> +
>  static const TypeInfo serial_pci_info =3D {
> -    .name          =3D "pci-serial",
> +    .name          =3D TYPE_PCI_SERIAL,
>      .parent        =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(PCISerialState),
> +    .instance_init =3D serial_pci_init,
>      .class_init    =3D serial_pci_class_initfn,
>      .interfaces =3D (InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index b4aa250950..c839035fdd 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -983,9 +983,8 @@ const MemoryRegionOps serial_io_ops =3D {
>  SerialState *serial_init(int base, qemu_irq irq, int baudbase,
>                           Chardev *chr, MemoryRegion *system_io)
>  {
> -    SerialState *s;
> -
> -    s =3D g_malloc0(sizeof(SerialState));
> +    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> +    SerialState *s =3D SERIAL(dev);
>
>      s->irq =3D irq;
>      s->baudbase =3D baudbase;
> @@ -993,6 +992,7 @@ SerialState *serial_init(int base, qemu_irq irq, int =
baudbase,
>      serial_realize_core(s, &error_fatal);
>
>      vmstate_register(NULL, base, &vmstate_serial, s);
> +    qdev_init_nofail(dev);
>
>      memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
>      memory_region_add_subregion(system_io, base, &s->io);
> @@ -1000,6 +1000,12 @@ SerialState *serial_init(int base, qemu_irq irq, i=
nt baudbase,
>      return s;
>  }
>
> +static const TypeInfo serial_info =3D {
> +    .name =3D TYPE_SERIAL,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(SerialState),
> +};
> +

I added a class_init to set user_creatable=3Dfalse: the base device is
useless when created from command line.

>  /* Memory mapped interface */
>  static uint64_t serial_mm_read(void *opaque, hwaddr addr,
>                                 unsigned size)
> @@ -1045,9 +1051,8 @@ SerialState *serial_mm_init(MemoryRegion *address_s=
pace,
>                              qemu_irq irq, int baudbase,
>                              Chardev *chr, enum device_endian end)
>  {
> -    SerialState *s;
> -
> -    s =3D g_malloc0(sizeof(SerialState));
> +    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> +    SerialState *s =3D SERIAL(dev);
>
>      s->it_shift =3D it_shift;
>      s->irq =3D irq;
> @@ -1056,9 +1061,17 @@ SerialState *serial_mm_init(MemoryRegion *address_=
space,
>
>      serial_realize_core(s, &error_fatal);
>      vmstate_register(NULL, base, &vmstate_serial, s);
> +    qdev_init_nofail(dev);
>
>      memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
>                            "serial", 8 << it_shift);
>      memory_region_add_subregion(address_space, base, &s->io);
>      return s;
>  }
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
>  #include "exec/memory.h"
>  #include "qemu/fifo8.h"
>  #include "chardev/char.h"
> +#include "hw/sysbus.h"
>
>  #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
>
>  typedef struct SerialState {
> +    DeviceState parent;
> +
>      uint16_t divider;
>      uint8_t rbr; /* receive register */
>      uint8_t thr; /* transmit holding register */
> @@ -84,7 +87,9 @@ void serial_realize_core(SerialState *s, Error **errp);
>  void serial_exit_core(SerialState *s);
>  void serial_set_frequency(SerialState *s, uint32_t frequency);
>
> -/* legacy pre qom */
> +#define TYPE_SERIAL "serial"
> +#define SERIAL(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL)
> +
>  SerialState *serial_init(int base, qemu_irq irq, int baudbase,
>                           Chardev *chr, MemoryRegion *system_io);
>  SerialState *serial_mm_init(MemoryRegion *address_space,
> --
> 2.23.0.606.g08da6496b6
>
>


--=20
Marc-Andr=C3=A9 Lureau

