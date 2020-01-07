Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69AC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AD4208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJj1VX4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AD4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopjO-0003fu-2K
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iooMD-0008Bd-Dx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iooMB-0008Lp-VB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:53:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iooMB-0008LE-OT
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:53:11 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so19267343wma.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DkFkhBsEEWMJIdr5iOzrBzGzPQw3TGwOEoiv4wHtGDQ=;
 b=HJj1VX4vgmUnVkEgSs/s/j7c48HyuIGXRVSQh5j7IhP3BQSSRFRH/tT7bhOI4NQNc8
 c6zY+hJXVVwU4+K3twtrlDbcM8vt7e7HnC4TmUOixirCwkc24XsWejDVNdG8xYGmVhwI
 uJPM2NeZUd5eXqdi2S/IfSG/dV4OSdvI6IBLXYg3EFO8s+rbKTj+vax11KPSU2/SBEa+
 kBluxCp+rymKVLV4Oybtm8GKKGP1dnILzOT940sjf0IwuudaHkWpFjHbKljRiYcGxhJD
 MIukKyO12EMl9/tW6rSq64t6LhtZ5ifxpOmsm2rsLOaBRADWbVehOVyaiMDlWc0wwKdK
 ivhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DkFkhBsEEWMJIdr5iOzrBzGzPQw3TGwOEoiv4wHtGDQ=;
 b=Nfx4RSS1UK/nJmjM6dXApeRFjvaZTeWTkgF0AZbP9GrerbkJ9BWUPHcamkHwL6+5CT
 szc8+UwMlgmvBAYGgz+/MJoxRpBCaaZOJ9HKTCt8CE/J4ZTXJUBFTUG0obcI9k4ZTo2H
 91taHnL+B+JZvTLg9dGW7qE6MoX8lYaRA5rhirdpPDSEKJ/kKvCKY9TaTNGKbLxrpfl6
 c53BcQQRWuYHj5MDASB58l2n1ggL/rGgpxi3cJ/soUWaRXESSMACVY16kMqVcpIvBNpA
 Q7eYalCRCudqjz1/pT4SQ+YZViwiKocnvP8mSrCLiVpH0YtT4GLNW0ZMG3V4HuUMnpHc
 Z46w==
X-Gm-Message-State: APjAAAXnD6Bb4Io68jTFFGTJ2ya5xgkDfZTu5hOryUGf09xMpN7dakgY
 mxM/Zt3gc/0RWrPvsQ7sUTuicwm31Sj4noKPfH5CFJ/w
X-Google-Smtp-Source: APXvYqy3TpXIBG5xHpD7pp56fWu0555eQIIDvtLBtHwkRUMPGC3UHXP8/9LHN3h6x4E14gqPf3iZpSkNsl/5BeN1ie8=
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr41260407wmf.56.1578401589339; 
 Tue, 07 Jan 2020 04:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
 <20191220134601.571905-22-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-22-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Jan 2020 16:52:56 +0400
Message-ID: <CAJ+F1CK84g_NOZUy_-jLx=jSYukTu9OJo_fg8kK-Q-gi5Ys52Q@mail.gmail.com>
Subject: Re: [PATCH v5 21/37] sm501: make SerialMM a child,
 export chardev property
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

On Fri, Dec 20, 2019 at 5:55 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Embed the SerialMM sybus device, and re-export its "chardev" property.
> That way, we can get rid of PROP_PTR "chr-state" and better track
> devices relationship.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/sm501.c | 29 +++++++++++++++++++++--------
>  hw/sh4/r2d.c       |  2 +-
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 79bd7bc2d1..66a1bfbe60 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1930,7 +1930,7 @@ typedef struct {
>      SM501State state;
>      uint32_t vram_size;
>      uint32_t base;
> -    void *chr_state;
> +    SerialMM serial;
>  } SM501SysBusState;
>
>  static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
> @@ -1938,6 +1938,7 @@ static void sm501_realize_sysbus(DeviceState *dev, =
Error **errp)
>      SM501SysBusState *s =3D SYSBUS_SM501(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      DeviceState *usb_dev;
> +    MemoryRegion *mr;
>
>      sm501_init(&s->state, dev, s->vram_size);
>      if (get_local_mem_size(&s->state) !=3D s->vram_size) {
> @@ -1958,15 +1959,15 @@ static void sm501_realize_sysbus(DeviceState *dev=
, Error **errp)
>      sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
>
>      /* bridge to serial emulation module */
> -    serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
> -                   NULL, /* TODO : chain irq to IRL */
> -                   115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
> +    qdev_init_nofail(DEVICE(&s->serial));
> +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->serial), 0);
> +    memory_region_add_subregion(&s->state.mmio_region, SM501_UART0, mr);
> +    /* TODO : chain irq to IRL */
>  }
>
>  static Property sm501_sysbus_properties[] =3D {
>      DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
>      DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
> -    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -1997,9 +1998,20 @@ static void sm501_sysbus_class_init(ObjectClass *k=
lass, void *data)
>      dc->props =3D sm501_sysbus_properties;
>      dc->reset =3D sm501_reset_sysbus;
>      dc->vmsd =3D &vmstate_sm501_sysbus;
> -    /* Note: pointer property "chr-state" may remain null, thus
> -     * no need for dc->user_creatable =3D false;
> -     */
> +}
> +
> +static void sm501_sysbus_init(Object *o)
> +{
> +    SM501SysBusState *sm501 =3D SYSBUS_SM501(o);
> +    SerialMM *smm =3D &sm501->serial;
> +
> +    sysbus_init_child_obj(o, "serial", smm, sizeof(SerialMM), TYPE_SERIA=
L_MM);
> +    qdev_set_legacy_instance_id(DEVICE(smm), SM501_UART0, 2);
> +    qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
> +    qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN)=
;
> +
> +    object_property_add_alias(o, "chardev",
> +                              OBJECT(smm), "chardev", &error_abort);
>  }
>
>  static const TypeInfo sm501_sysbus_info =3D {
> @@ -2007,6 +2019,7 @@ static const TypeInfo sm501_sysbus_info =3D {
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(SM501SysBusState),
>      .class_init    =3D sm501_sysbus_class_init,
> +    .instance_init =3D sm501_sysbus_init,
>  };
>
>  #define TYPE_PCI_SM501 "sm501"
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index ee0840f380..72bb5285cc 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -272,7 +272,7 @@ static void r2d_init(MachineState *machine)
>      busdev =3D SYS_BUS_DEVICE(dev);
>      qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
>      qdev_prop_set_uint32(dev, "base", 0x10000000);
> -    qdev_prop_set_ptr(dev, "chr-state", serial_hd(2));
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(2));
>      qdev_init_nofail(dev);
>      sysbus_mmio_map(busdev, 0, 0x10000000);
>      sysbus_mmio_map(busdev, 1, 0x13e00000);
> --
> 2.24.0.308.g228f53135a
>
>

ping, thanks

--=20
Marc-Andr=C3=A9 Lureau

