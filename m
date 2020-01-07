Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A067C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A4E208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arSVWYB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A4E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iophH-0004rR-Mz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iooLU-0006Qj-Ha
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iooLS-0007ye-RE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:52:28 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iooLS-0007y4-KW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:52:26 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so53806293wrw.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IF2p0g9z3hjHu1vHCAsockZnOSXDZZid6UAbkQGw4BY=;
 b=arSVWYB232D4avwssZqVHliOV65pTGQ6xlgetJdf/XdqpPK4Sc3var9/mz4Bsp2H7Q
 D76pgXmuB8bWjvF671AGDfZJKYrVqcKR+bRPolTAv8iSaMZTEL16itL59xLghkDvppSA
 1G2V0t37E5fgOTytvmADVLZJa2InHs5Yc9zDqCltFyzUKvcIKvulH4eDuNNSKt4cAnWn
 5JUnPxaLu1bhhD/hrZLriZQlZtJAo1w2C1r/OjQo94lLIkv4T7qoSlkJTV9IpGb4xQmo
 aormXReDoexaZuRGs/qTx/e3pXdfWFG6OuPWACE/U3+im2Ph/32jLFEHLi+f2RyY7Gmu
 UJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IF2p0g9z3hjHu1vHCAsockZnOSXDZZid6UAbkQGw4BY=;
 b=lSCHNfdMiWdbH4bCRbtW82zCoyweVH8v6267uKEqedS5wnB+sSqb0+3Si1FL3eKL19
 //DuTW9gpRQXpNvNAV0ATXjPKad8MRlNxXLBuye84vIS4jxP/6Hea23JFQBq0USZ1p2C
 4bYLitsH+fPxN5I2/e19mZHwIcnl9jmnJe76TvsmkpEiYoYnj7jBq+pqX7UtoD6d9gsD
 RDdP+qcY7N2x5eP0empiIbUX9cflopyMJJPT5dW+4cYFsbFzddWyPq8iegWwgDD4ipP/
 RElkxzojoSCGyChl6tZzXVLzZRgkeTEPvzvHmrwhlfUH56KjM9BCaMZK2VHkNugS0Ueh
 jDpA==
X-Gm-Message-State: APjAAAWLcDDAG2ppzJkzbfHjDZsrzQTRrj5Fr8pYBXOhUAnOyexYuftk
 ifUUt9A2sIEIaZ2aAnKEZ+3lli4GE62p+GfEarrIt812
X-Google-Smtp-Source: APXvYqw3DJMucONxmeFATiA6hxnnScyiMtGpvr3x04dgQQE/eubuYIchbJoQ2JO8p7o2WydWgVOeK07yptxwkCh5IJc=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr102240309wrw.370.1578401543841; 
 Tue, 07 Jan 2020 04:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
 <20191220134601.571905-13-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-13-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Jan 2020 16:52:10 +0400
Message-ID: <CAJ+F1CKSA8kvPQ973b3AfHG=nm83hDSyn7_oe7sbaOV6JZ4_sQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/37] serial: start making SerialMM a sysbus device
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 5:57 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Memory mapped serial device is in fact a sysbus device. The following
> patches will make use of sysbus facilities for resource and
> registration. In particular, "serial-mm: use sysbus facilities" will
> move internal serial realization to serial_mm_realize callback to
> follow qdev best practices.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/omap_uart.c      |  2 +-
>  hw/char/serial.c         | 66 +++++++++++++++++++++++++++++++---------
>  hw/mips/boston.c         |  2 +-
>  hw/mips/mips_malta.c     |  2 +-
>  include/hw/char/serial.h | 20 +++++++++---
>  5 files changed, 70 insertions(+), 22 deletions(-)
>
> diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
> index 13e4f43c4c..e8da933378 100644
> --- a/hw/char/omap_uart.c
> +++ b/hw/char/omap_uart.c
> @@ -27,7 +27,7 @@
>  struct omap_uart_s {
>      MemoryRegion iomem;
>      hwaddr base;
> -    SerialState *serial; /* TODO */
> +    SerialMM *serial; /* TODO */
>      struct omap_target_agent_s *ta;
>      omap_clk fclk;
>      qemu_irq irq;
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index ec388f3876..905b84c25f 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1032,16 +1032,28 @@ static const TypeInfo serial_info =3D {
>  static uint64_t serial_mm_read(void *opaque, hwaddr addr,
>                                 unsigned size)
>  {
> -    SerialState *s =3D opaque;
> -    return serial_ioport_read(s, addr >> s->it_shift, 1);
> +    SerialMM *s =3D SERIAL_MM(opaque);
> +    return serial_ioport_read(&s->serial, addr >> s->it_shift, 1);
>  }
>
>  static void serial_mm_write(void *opaque, hwaddr addr,
>                              uint64_t value, unsigned size)
>  {
> -    SerialState *s =3D opaque;
> +    SerialMM *s =3D SERIAL_MM(opaque);
>      value &=3D 255;
> -    serial_ioport_write(s, addr >> s->it_shift, value, 1);
> +    serial_ioport_write(&s->serial, addr >> s->it_shift, value, 1);
> +}
> +
> +static void serial_mm_realize(DeviceState *dev, Error **errp)
> +{
> +    SerialMM *s =3D SERIAL_MM(dev);
> +    Error *local_err =3D NULL;
> +
> +    object_property_set_bool(OBJECT(&s->serial), true, "realized", &loca=
l_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>  }
>
>  static const MemoryRegionOps serial_mm_ops[3] =3D {
> @@ -1068,30 +1080,56 @@ static const MemoryRegionOps serial_mm_ops[3] =3D=
 {
>      },
>  };
>
> -SerialState *serial_mm_init(MemoryRegion *address_space,
> +SerialMM *serial_mm_init(MemoryRegion *address_space,
>                              hwaddr base, int it_shift,
>                              qemu_irq irq, int baudbase,
>                              Chardev *chr, enum device_endian end)
>  {
> -    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> -    SerialState *s =3D SERIAL(dev);
> +    SerialMM *smm =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
> +    SerialState *s =3D &smm->serial;
>
> -    s->it_shift =3D it_shift;
> +    smm->it_shift =3D it_shift;
>      s->irq =3D irq;
> -    qdev_prop_set_uint32(dev, "baudbase", baudbase);
> -    qdev_prop_set_chr(dev, "chardev", chr);
> -    qdev_set_legacy_instance_id(dev, base, 2);
> -    qdev_init_nofail(dev);
> +    qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
> +    qdev_prop_set_chr(DEVICE(s), "chardev", chr);
> +    qdev_set_legacy_instance_id(DEVICE(s), base, 2);
>
> -    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
> +    qdev_init_nofail(DEVICE(smm));
> +
> +    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], smm,
>                            "serial", 8 << it_shift);
>      memory_region_add_subregion(address_space, base, &s->io);
> -    return s;
> +
> +    return smm;
> +}
> +
> +static void serial_mm_instance_init(Object *o)
> +{
> +    SerialMM *smm =3D SERIAL_MM(o);
> +
> +    object_initialize_child(o, "serial", &smm->serial, sizeof(smm->seria=
l),
> +                            TYPE_SERIAL, &error_abort, NULL);
>  }
>
> +static void serial_mm_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D serial_mm_realize;
> +}
> +
> +static const TypeInfo serial_mm_info =3D {
> +    .name =3D TYPE_SERIAL_MM,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .class_init =3D serial_mm_class_init,
> +    .instance_init =3D serial_mm_instance_init,
> +    .instance_size =3D sizeof(SerialMM),
> +};
> +
>  static void serial_register_types(void)
>  {
>      type_register_static(&serial_info);
> +    type_register_static(&serial_mm_info);
>  }
>
>  type_init(serial_register_types)
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index ca7d813a52..23fdd5ec6a 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -50,7 +50,7 @@ typedef struct {
>
>      MachineState *mach;
>      MIPSCPSState cps;
> -    SerialState *uart;
> +    SerialMM *uart;
>
>      CharBackend lcd_display;
>      char lcd_content[8];
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 783cd99848..ea92e5e27d 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -83,7 +83,7 @@ typedef struct {
>      uint32_t i2csel;
>      CharBackend display;
>      char display_text[9];
> -    SerialState *uart;
> +    SerialMM *uart;
>      bool display_inited;
>  } MaltaFPGAState;
>
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 548944b06a..730165347c 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -57,7 +57,6 @@ typedef struct SerialState {
>      qemu_irq irq;
>      CharBackend chr;
>      int last_break_enable;
> -    int it_shift;
>      uint32_t baudbase;
>      uint32_t tsr_retry;
>      guint watch_tag;
> @@ -80,6 +79,14 @@ typedef struct SerialState {
>      MemoryRegion io;
>  } SerialState;
>
> +typedef struct SerialMM {
> +    SysBusDevice parent;
> +
> +    SerialState serial;
> +
> +    int it_shift;
> +} SerialMM;
> +
>  extern const VMStateDescription vmstate_serial;
>  extern const MemoryRegionOps serial_io_ops;
>
> @@ -88,12 +95,15 @@ void serial_set_frequency(SerialState *s, uint32_t fr=
equency);
>  #define TYPE_SERIAL "serial"
>  #define SERIAL(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL)
>
> +#define TYPE_SERIAL_MM "serial-mm"
> +#define SERIAL_MM(s) OBJECT_CHECK(SerialMM, (s), TYPE_SERIAL_MM)
> +
>  SerialState *serial_init(int base, qemu_irq irq, int baudbase,
>                           Chardev *chr, MemoryRegion *system_io);
> -SerialState *serial_mm_init(MemoryRegion *address_space,
> -                            hwaddr base, int it_shift,
> -                            qemu_irq irq, int baudbase,
> -                            Chardev *chr, enum device_endian end);
> +SerialMM *serial_mm_init(MemoryRegion *address_space,
> +                         hwaddr base, int it_shift,
> +                         qemu_irq irq, int baudbase,
> +                         Chardev *chr, enum device_endian end);
>
>  /* serial-isa.c */
>
> --
> 2.24.0.308.g228f53135a
>
>

ping, thanks

--=20
Marc-Andr=C3=A9 Lureau

