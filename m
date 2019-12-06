Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAA2C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD15721835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ1Y5WD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD15721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGj0-0006jI-9h
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idF8B-0002je-QN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idF88-0008Kx-Aw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:02:55 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1idF86-0008Ka-Tu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:02:52 -0500
Received: by mail-oi1-x241.google.com with SMTP id v140so45991oie.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=s9S4E9xGqUanoBYjJlE4Xec1+SPzSH5WNrcrxFOyDE4=;
 b=VJ1Y5WD0acb+HAa7CSt693gn+xAMgxq9vPcaA+LuG+bbgddEqHGLo1AI82rKJmuHUU
 /nIVMHWx1QvIhQDRqwGsJ2Vbzn6NIENLREEJYRV6w6qajT8SzY4Kkj7/nnJ6zkrhV9rs
 MB8xP8gRrXZiS5upvQnM5DifayQetdvLsM7zjbV8NW9iGibEyPb+aLMm9+APz3/7BHVg
 1NBXjnFzDv/ZEIufRBVokWHJC6uTSy01dUwteGTu/T5tYzlFZmg8RYp4U2ICbES2lscV
 ejYwhu24upDaEDZxlRZBf6n32xdJ3NSLqj+lAWQ5MugyBEaSpts4HnF4WxhYbcqzT4ki
 XEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=s9S4E9xGqUanoBYjJlE4Xec1+SPzSH5WNrcrxFOyDE4=;
 b=BgJowUEExe8VR1Gr74Bh22rnCxjvPYMo5Nc7RVWLwOrvcBOW5lL+/IMH3NZyB6EV5E
 fuTGZlNHHklRRvPMqV7xKVwHVcMJEpQh2xX+oT40DVMyPINdwjAjhEpaCeFSBu2U+1e6
 k6/h0/EMnRmjhqQZ+HQPvlohb2GjY0SJAYRLRtXQs0Uv4zxFBJeX03Oyn/D2l4mZEP9B
 jS9HZ7KZgCIcwZtGxEqSj3KIfpYyD7RXR0x8U4pTQT7CL8mycrIcSG5ep1sO8XnS6qvt
 lr++0Yd1lOf+M9g/tNUXfYn93+3y1JNS7Tpg06yQxNZ5qZQFHvjadkEdOmIr+CXFQUvV
 ccPQ==
X-Gm-Message-State: APjAAAWsCEm5dXrR89IfWFIzqvTWMN8SIKVcy2eGwuhbs58Cn6AezHdb
 ezhRMYEOC0MMOZ6CLFXsIEzMU3CdLNiagn/AAAsWog==
X-Google-Smtp-Source: APXvYqxRWD43taNlbmHvOp6TAVrloeYsQo3ea+Dzds59RSTtCzaLC9MFk2YwZ3KDEcCrqknVoOaArQctp+gHHgndPs0=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr467155oib.106.1575619676786;
 Fri, 06 Dec 2019 00:07:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 6 Dec 2019 00:07:56 -0800 (PST)
In-Reply-To: <1574687098-26689-2-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-2-git-send-email-Filip.Bozuta@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 6 Dec 2019 09:07:56 +0100
Message-ID: <CAL1e-=j9oxHvxJen6hJna9=muLQG3pF-pYjJfcXVXHM4CagY4Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] mips: jazz: Renovate coding style
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: multipart/alternative; boundary="00000000000022d61f0599048b97"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000022d61f0599048b97
Content-Type: text/plain; charset="UTF-8"

On Monday, November 25, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote:

> The script checkpatch.pl located in scripts folder was
> used to detect all errors and warrnings in files:
>     hw/mips/mips_jazz.c
>     hw/display/jazz_led.c
>     hw/dma/rc4030.c
>
> All these mips jazz machine files were edited and
> all the errors and warrings generated by the checkpatch.pl
> script were corrected and then the script was
> ran again to make sure there are no more errors and warnings.
>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  hw/display/jazz_led.c | 123 +++++++++++++++++++++++++-----
> --------------------
>  hw/dma/rc4030.c       |  12 +++--
>  hw/mips/mips_jazz.c   |  32 +++++++------
>  3 files changed, 88 insertions(+), 79 deletions(-)
>
> diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
> index 3e0112b..1d84559 100644
> --- a/hw/display/jazz_led.c
> +++ b/hw/display/jazz_led.c
> @@ -90,25 +90,25 @@ static void draw_horizontal_line(DisplaySurface *ds,
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>      bpp = (surface_bits_per_pixel(ds) + 7) >> 3;
>      d = surface_data(ds) + surface_stride(ds) * posy + bpp * posx1;
> -    switch(bpp) {
> -        case 1:
> -            for (x = posx1; x <= posx2; x++) {
> -                *((uint8_t *)d) = color;
> -                d++;
> -            }
> -            break;
> -        case 2:
> -            for (x = posx1; x <= posx2; x++) {
> -                *((uint16_t *)d) = color;
> -                d += 2;
> -            }
> -            break;
> -        case 4:
> -            for (x = posx1; x <= posx2; x++) {
> -                *((uint32_t *)d) = color;
> -                d += 4;
> -            }
> -            break;
> +    switch (bpp) {
> +    case 1:
> +        for (x = posx1; x <= posx2; x++) {
> +            *((uint8_t *)d) = color;
> +            d++;
> +        }
> +        break;
> +    case 2:
> +        for (x = posx1; x <= posx2; x++) {
> +            *((uint16_t *)d) = color;
> +            d += 2;
> +        }
> +        break;
> +    case 4:
> +        for (x = posx1; x <= posx2; x++) {
> +            *((uint32_t *)d) = color;
> +            d += 4;
> +        }
> +        break;
>      }
>  }
>
> @@ -121,25 +121,25 @@ static void draw_vertical_line(DisplaySurface *ds,
>
>      bpp = (surface_bits_per_pixel(ds) + 7) >> 3;
>      d = surface_data(ds) + surface_stride(ds) * posy1 + bpp * posx;
> -    switch(bpp) {
> -        case 1:
> -            for (y = posy1; y <= posy2; y++) {
> -                *((uint8_t *)d) = color;
> -                d += surface_stride(ds);
> -            }
> -            break;
> -        case 2:
> -            for (y = posy1; y <= posy2; y++) {
> -                *((uint16_t *)d) = color;
> -                d += surface_stride(ds);
> -            }
> -            break;
> -        case 4:
> -            for (y = posy1; y <= posy2; y++) {
> -                *((uint32_t *)d) = color;
> -                d += surface_stride(ds);
> -            }
> -            break;
> +    switch (bpp) {
> +    case 1:
> +        for (y = posy1; y <= posy2; y++) {
> +            *((uint8_t *)d) = color;
> +            d += surface_stride(ds);
> +        }
> +        break;
> +    case 2:
> +        for (y = posy1; y <= posy2; y++) {
> +            *((uint16_t *)d) = color;
> +            d += surface_stride(ds);
> +        }
> +        break;
> +    case 4:
> +        for (y = posy1; y <= posy2; y++) {
> +            *((uint32_t *)d) = color;
> +            d += surface_stride(ds);
> +        }
> +        break;
>      }
>  }
>
> @@ -164,28 +164,28 @@ static void jazz_led_update_display(void *opaque)
>      if (s->state & REDRAW_SEGMENTS) {
>          /* set colors according to bpp */
>          switch (surface_bits_per_pixel(surface)) {
> -            case 8:
> -                color_segment = rgb_to_pixel8(0xaa, 0xaa, 0xaa);
> -                color_led = rgb_to_pixel8(0x00, 0xff, 0x00);
> -                break;
> -            case 15:
> -                color_segment = rgb_to_pixel15(0xaa, 0xaa, 0xaa);
> -                color_led = rgb_to_pixel15(0x00, 0xff, 0x00);
> -                break;
> -            case 16:
> -                color_segment = rgb_to_pixel16(0xaa, 0xaa, 0xaa);
> -                color_led = rgb_to_pixel16(0x00, 0xff, 0x00);
> -                break;
> -            case 24:
> -                color_segment = rgb_to_pixel24(0xaa, 0xaa, 0xaa);
> -                color_led = rgb_to_pixel24(0x00, 0xff, 0x00);
> -                break;
> -            case 32:
> -                color_segment = rgb_to_pixel32(0xaa, 0xaa, 0xaa);
> -                color_led = rgb_to_pixel32(0x00, 0xff, 0x00);
> -                break;
> -            default:
> -                return;
> +        case 8:
> +            color_segment = rgb_to_pixel8(0xaa, 0xaa, 0xaa);
> +            color_led = rgb_to_pixel8(0x00, 0xff, 0x00);
> +            break;
> +        case 15:
> +            color_segment = rgb_to_pixel15(0xaa, 0xaa, 0xaa);
> +            color_led = rgb_to_pixel15(0x00, 0xff, 0x00);
> +            break;
> +        case 16:
> +            color_segment = rgb_to_pixel16(0xaa, 0xaa, 0xaa);
> +            color_led = rgb_to_pixel16(0x00, 0xff, 0x00);
> +            break;
> +        case 24:
> +            color_segment = rgb_to_pixel24(0xaa, 0xaa, 0xaa);
> +            color_led = rgb_to_pixel24(0x00, 0xff, 0x00);
> +            break;
> +        case 32:
> +            color_segment = rgb_to_pixel32(0xaa, 0xaa, 0xaa);
> +            color_led = rgb_to_pixel32(0x00, 0xff, 0x00);
> +            break;
> +        default:
> +            return;
>          }
>
>          /* display segments */
> @@ -205,8 +205,9 @@ static void jazz_led_update_display(void *opaque)
>                               (s->segments & 0x80) ? color_segment : 0);
>
>          /* display led */
> -        if (!(s->segments & 0x01))
> +        if (!(s->segments & 0x01)) {
>              color_led = 0; /* black */
> +        }
>          draw_horizontal_line(surface, 68, 50, 50, color_led);
>          draw_horizontal_line(surface, 69, 49, 51, color_led);
>          draw_horizontal_line(surface, 70, 48, 52, color_led);
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index d54e296..f7542f3 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -397,10 +397,11 @@ static void update_jazz_irq(rc4030State *s)
>
>      pending = s->isr_jazz & s->imr_jazz;
>
> -    if (pending != 0)
> +    if (pending != 0) {
>          qemu_irq_raise(s->jazz_bus_irq);
> -    else
> +    } else {
>          qemu_irq_lower(s->jazz_bus_irq);
> +    }
>  }
>
>  static void rc4030_irq_jazz_request(void *opaque, int irq, int level)
> @@ -588,7 +589,8 @@ static const VMStateDescription vmstate_rc4030 = {
>      }
>  };
>
> -static void rc4030_do_dma(void *opaque, int n, uint8_t *buf, int len, int
> is_write)
> +static void rc4030_do_dma(void *opaque, int n, uint8_t *buf,
> +                          int len, int is_write)
>  {
>      rc4030State *s = opaque;
>      hwaddr dma_addr;
> @@ -643,8 +645,8 @@ static rc4030_dma *rc4030_allocate_dmas(void *opaque,
> int n)
>      struct rc4030DMAState *p;
>      int i;
>
> -    s = (rc4030_dma *)g_malloc0(sizeof(rc4030_dma) * n);
> -    p = (struct rc4030DMAState *)g_malloc0(sizeof(struct rc4030DMAState)
> * n);
> +    s = (rc4030_dma *)g_new0(sizeof(rc4030_dma) * n);
> +    p = (struct rc4030DMAState *)g_new0(sizeof(struct rc4030DMAState) *
> n);
>      for (i = 0; i < n; i++) {
>          p->opaque = opaque;
>          p->n = i;
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index d978bb6..ac4d7ac 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -52,8 +52,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/help_option.h"
>
> -enum jazz_model_e
> -{
> +enum jazz_model_e {
>      JAZZ_MAGNUM,
>      JAZZ_PICA61,
>  };
> @@ -90,16 +89,20 @@ static const MemoryRegionOps rtc_ops = {
>  static uint64_t dma_dummy_read(void *opaque, hwaddr addr,
>                                 unsigned size)
>  {
> -    /* Nothing to do. That is only to ensure that
> -     * the current DMA acknowledge cycle is completed. */
> +    /*
> +     * Nothing to do. That is only to ensure that
> +     * the current DMA acknowledge cycle is completed.
> +     */
>      return 0xff;
>  }
>
>  static void dma_dummy_write(void *opaque, hwaddr addr,
>                              uint64_t val, unsigned size)
>  {
> -    /* Nothing to do. That is only to ensure that
> -     * the current DMA acknowledge cycle is completed. */
> +    /*
> +     * Nothing to do. That is only to ensure that
> +     * the current DMA acknowledge cycle is completed.
> +     */
>  }
>
>  static const MemoryRegionOps dma_dummy_ops = {
> @@ -109,8 +112,8 @@ static const MemoryRegionOps dma_dummy_ops = {
>  };
>
>  #define MAGNUM_BIOS_SIZE_MAX 0x7e000
> -#define MAGNUM_BIOS_SIZE (BIOS_SIZE < MAGNUM_BIOS_SIZE_MAX ? BIOS_SIZE :
> MAGNUM_BIOS_SIZE_MAX)
> -
> +#define MAGNUM_BIOS_SIZE
>      \
> +        (BIOS_SIZE < MAGNUM_BIOS_SIZE_MAX ? BIOS_SIZE :
> MAGNUM_BIOS_SIZE_MAX)
>  static void (*real_do_transaction_failed)(CPUState *cpu, hwaddr physaddr,
>                                            vaddr addr, unsigned size,
>                                            MMUAccessType access_type,
> @@ -201,8 +204,9 @@ static void mips_jazz_init(MachineState *machine,
>      memory_region_add_subregion(address_space, 0xfff00000LL, bios2);
>
>      /* load the BIOS image. */
> -    if (bios_name == NULL)
> +    if (bios_name == NULL) {
>          bios_name = BIOS_FILENAME;
> +    }
>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          bios_size = load_image_targphys(filename, 0xfff00000LL,
> @@ -229,7 +233,8 @@ static void mips_jazz_init(MachineState *machine,
>                                  sysbus_mmio_get_region(sysbus, 0));
>      memory_region_add_subregion(address_space, 0xf0000000,
>                                  sysbus_mmio_get_region(sysbus, 1));
> -    memory_region_init_io(dma_dummy, NULL, &dma_dummy_ops, NULL,
> "dummy_dma", 0x1000);
> +    memory_region_init_io(dma_dummy, NULL, &dma_dummy_ops,
> +                          NULL, "dummy_dma", 0x1000);
>      memory_region_add_subregion(address_space, 0x8000d000, dma_dummy);
>
>      /* ISA bus: IO space at 0x90000000, mem space at 0x91000000 */
> @@ -276,8 +281,9 @@ static void mips_jazz_init(MachineState *machine,
>      /* Network controller */
>      for (n = 0; n < nb_nics; n++) {
>          nd = &nd_table[n];
> -        if (!nd->model)
> +        if (!nd->model) {
>              nd->model = g_strdup("dp83932");
> +        }
>          if (strcmp(nd->model, "dp83932") == 0) {
>              qemu_check_nic_model(nd, "dp83932");
>
> @@ -338,12 +344,12 @@ static void mips_jazz_init(MachineState *machine,
>      /* Serial ports */
>      if (serial_hd(0)) {
>          serial_mm_init(address_space, 0x80006000, 0,
> -                       qdev_get_gpio_in(rc4030, 8), 8000000/16,
> +                       qdev_get_gpio_in(rc4030, 8), 8000000 / 16,
>                         serial_hd(0), DEVICE_NATIVE_ENDIAN);
>      }
>      if (serial_hd(1)) {
>          serial_mm_init(address_space, 0x80007000, 0,
> -                       qdev_get_gpio_in(rc4030, 9), 8000000/16,
> +                       qdev_get_gpio_in(rc4030, 9), 8000000 / 16,
>                         serial_hd(1), DEVICE_NATIVE_ENDIAN);
>      }
>
> --
> 2.7.4
>
>
>

--00000000000022d61f0599048b97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 25, 2019, Filip Bozuta &lt;<a href=3D"mailto:Fi=
lip.Bozuta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">The script <a href=3D"http://checkpatch.pl" target=3D"_b=
lank">checkpatch.pl</a> located in scripts folder was<br>
used to detect all errors and warrnings in files:<br>
=C2=A0 =C2=A0 hw/mips/mips_jazz.c<br>
=C2=A0 =C2=A0 hw/display/jazz_led.c<br>
=C2=A0 =C2=A0 hw/dma/rc4030.c<br>
<br>
All these mips jazz machine files were edited and<br>
all the errors and warrings generated by the <a href=3D"http://checkpatch.p=
l" target=3D"_blank">checkpatch.pl</a><br>
script were corrected and then the script was<br>
ran again to make sure there are no more errors and warnings.<br>
<br>
Signed-off-by: Filip Bozuta &lt;<a href=3D"mailto:Filip.Bozuta@rt-rk.com">F=
ilip.Bozuta@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0hw/display/jazz_led.c | 123 +++++++++++++++++++++++++-----<wbr>------=
--------------<br>
=C2=A0hw/dma/rc4030.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +++--<br>
=C2=A0hw/mips/mips_jazz.c=C2=A0 =C2=A0|=C2=A0 32 +++++++------<br>
=C2=A03 files changed, 88 insertions(+), 79 deletions(-)<br>
<br>
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c<br>
index 3e0112b..1d84559 100644<br>
--- a/hw/display/jazz_led.c<br>
+++ b/hw/display/jazz_led.c<br>
@@ -90,25 +90,25 @@ static void draw_horizontal_line(<wbr>DisplaySurface *d=
s,<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
=C2=A0 =C2=A0 =C2=A0bpp =3D (surface_bits_per_pixel(ds) + 7) &gt;&gt; 3;<br=
>
=C2=A0 =C2=A0 =C2=A0d =3D surface_data(ds) + surface_stride(ds) * posy + bp=
p * posx1;<br>
-=C2=A0 =C2=A0 switch(bpp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (x =3D posx1; x &lt;=3D posx=
2; x++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint8_t *)d) =
=3D color;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (x =3D posx1; x &lt;=3D posx=
2; x++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint16_t *)d) =
=3D color;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (x =3D posx1; x &lt;=3D posx=
2; x++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint32_t *)d) =
=3D color;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 switch (bpp) {<br>
+=C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (x =3D posx1; x &lt;=3D posx2; x++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint8_t *)d) =3D color;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (x =3D posx1; x &lt;=3D posx2; x++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint16_t *)d) =3D color;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (x =3D posx1; x &lt;=3D posx2; x++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint32_t *)d) =3D color;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -121,25 +121,25 @@ static void draw_vertical_line(<wbr>DisplaySurface *d=
s,<br>
<br>
=C2=A0 =C2=A0 =C2=A0bpp =3D (surface_bits_per_pixel(ds) + 7) &gt;&gt; 3;<br=
>
=C2=A0 =C2=A0 =C2=A0d =3D surface_data(ds) + surface_stride(ds) * posy1 + b=
pp * posx;<br>
-=C2=A0 =C2=A0 switch(bpp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (y =3D posy1; y &lt;=3D posy=
2; y++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint8_t *)d) =
=3D color;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D surface_str=
ide(ds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (y =3D posy1; y &lt;=3D posy=
2; y++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint16_t *)d) =
=3D color;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D surface_str=
ide(ds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (y =3D posy1; y &lt;=3D posy=
2; y++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint32_t *)d) =
=3D color;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D surface_str=
ide(ds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 switch (bpp) {<br>
+=C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (y =3D posy1; y &lt;=3D posy2; y++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint8_t *)d) =3D color;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D surface_stride(ds);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (y =3D posy1; y &lt;=3D posy2; y++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint16_t *)d) =3D color;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D surface_stride(ds);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (y =3D posy1; y &lt;=3D posy2; y++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((uint32_t *)d) =3D color;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d +=3D surface_stride(ds);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -164,28 +164,28 @@ static void jazz_led_update_display(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;state &amp; REDRAW_SEGMENTS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set colors according to bpp */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (surface_bits_per_pixel(<wbr>surfa=
ce)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D =
rgb_to_pixel8(0xaa, 0xaa, 0xaa);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_=
to_pixel8(0x00, 0xff, 0x00);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 15:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D =
rgb_to_pixel15(0xaa, 0xaa, 0xaa);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_=
to_pixel15(0x00, 0xff, 0x00);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 16:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D =
rgb_to_pixel16(0xaa, 0xaa, 0xaa);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_=
to_pixel16(0x00, 0xff, 0x00);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 24:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D =
rgb_to_pixel24(0xaa, 0xaa, 0xaa);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_=
to_pixel24(0x00, 0xff, 0x00);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 32:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D =
rgb_to_pixel32(0xaa, 0xaa, 0xaa);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_=
to_pixel32(0x00, 0xff, 0x00);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 8:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D rgb_to_pixel8(=
0xaa, 0xaa, 0xaa);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_to_pixel8(0x00=
, 0xff, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 15:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D rgb_to_pixel15=
(0xaa, 0xaa, 0xaa);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_to_pixel15(0x0=
0, 0xff, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 16:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D rgb_to_pixel16=
(0xaa, 0xaa, 0xaa);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_to_pixel16(0x0=
0, 0xff, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 24:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D rgb_to_pixel24=
(0xaa, 0xaa, 0xaa);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_to_pixel24(0x0=
0, 0xff, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_segment =3D rgb_to_pixel32=
(0xaa, 0xaa, 0xaa);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_led =3D rgb_to_pixel32(0x0=
0, 0xff, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* display segments */<br>
@@ -205,8 +205,9 @@ static void jazz_led_update_display(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;segments &amp; 0x80) ? color_segment=
 : 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* display led */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(s-&gt;segments &amp; 0x01))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(s-&gt;segments &amp; 0x01)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0color_led =3D 0; /* black *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0draw_horizontal_line(surface, 68, 50, 50,=
 color_led);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0draw_horizontal_line(surface, 69, 49, 51,=
 color_led);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0draw_horizontal_line(surface, 70, 48, 52,=
 color_led);<br>
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c<br>
index d54e296..f7542f3 100644<br>
--- a/hw/dma/rc4030.c<br>
+++ b/hw/dma/rc4030.c<br>
@@ -397,10 +397,11 @@ static void update_jazz_irq(rc4030State *s)<br>
<br>
=C2=A0 =C2=A0 =C2=A0pending =3D s-&gt;isr_jazz &amp; s-&gt;imr_jazz;<br>
<br>
-=C2=A0 =C2=A0 if (pending !=3D 0)<br>
+=C2=A0 =C2=A0 if (pending !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_raise(s-&gt;jazz_bus_<wbr>irq);<=
br>
-=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_lower(s-&gt;jazz_bus_<wbr>irq);<=
br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void rc4030_irq_jazz_request(void *opaque, int irq, int level)=
<br>
@@ -588,7 +589,8 @@ static const VMStateDescription vmstate_rc4030 =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
-static void rc4030_do_dma(void *opaque, int n, uint8_t *buf, int len, int =
is_write)<br>
+static void rc4030_do_dma(void *opaque, int n, uint8_t *buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int len, int is_write)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0rc4030State *s =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0hwaddr dma_addr;<br>
@@ -643,8 +645,8 @@ static rc4030_dma *rc4030_allocate_dmas(void *opaque, i=
nt n)<br>
=C2=A0 =C2=A0 =C2=A0struct rc4030DMAState *p;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
-=C2=A0 =C2=A0 s =3D (rc4030_dma *)g_malloc0(sizeof(rc4030_dma) * n);<br>
-=C2=A0 =C2=A0 p =3D (struct rc4030DMAState *)g_malloc0(sizeof(struct rc403=
0DMAState) * n);<br>
+=C2=A0 =C2=A0 s =3D (rc4030_dma *)g_new0(sizeof(rc4030_dma) * n);<br>
+=C2=A0 =C2=A0 p =3D (struct rc4030DMAState *)g_new0(sizeof(struct rc4030DM=
AState) * n);<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; n; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;opaque =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;n =3D i;<br>
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c<br>
index d978bb6..ac4d7ac 100644<br>
--- a/hw/mips/mips_jazz.c<br>
+++ b/hw/mips/mips_jazz.c<br>
@@ -52,8 +52,7 @@<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/help_option.h&quot;<br>
<br>
-enum jazz_model_e<br>
-{<br>
+enum jazz_model_e {<br>
=C2=A0 =C2=A0 =C2=A0JAZZ_MAGNUM,<br>
=C2=A0 =C2=A0 =C2=A0JAZZ_PICA61,<br>
=C2=A0};<br>
@@ -90,16 +89,20 @@ static const MemoryRegionOps rtc_ops =3D {<br>
=C2=A0static uint64_t dma_dummy_read(void *opaque, hwaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 /* Nothing to do. That is only to ensure that<br>
-=C2=A0 =C2=A0 =C2=A0* the current DMA acknowledge cycle is completed. */<b=
r>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Nothing to do. That is only to ensure that<br>
+=C2=A0 =C2=A0 =C2=A0* the current DMA acknowledge cycle is completed.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0return 0xff;<br>
=C2=A0}<br>
<br>
=C2=A0static void dma_dummy_write(void *opaque, hwaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, unsigned size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 /* Nothing to do. That is only to ensure that<br>
-=C2=A0 =C2=A0 =C2=A0* the current DMA acknowledge cycle is completed. */<b=
r>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Nothing to do. That is only to ensure that<br>
+=C2=A0 =C2=A0 =C2=A0* the current DMA acknowledge cycle is completed.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0}<br>
<br>
=C2=A0static const MemoryRegionOps dma_dummy_ops =3D {<br>
@@ -109,8 +112,8 @@ static const MemoryRegionOps dma_dummy_ops =3D {<br>
=C2=A0};<br>
<br>
=C2=A0#define MAGNUM_BIOS_SIZE_MAX 0x7e000<br>
-#define MAGNUM_BIOS_SIZE (BIOS_SIZE &lt; MAGNUM_BIOS_SIZE_MAX ? BIOS_SIZE =
: MAGNUM_BIOS_SIZE_MAX)<br>
-<br>
+#define MAGNUM_BIOS_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BIOS_SIZE &lt; MAGNUM_BIOS_SIZE_MAX ? BIOS_SI=
ZE : MAGNUM_BIOS_SIZE_MAX)<br>
=C2=A0static void (*real_do_transaction_failed)(<wbr>CPUState *cpu, hwaddr =
physaddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0vaddr addr, unsigned size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0MMUAccessType access_type,<br>
@@ -201,8 +204,9 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space, 0xfff00=
000LL, bios2);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* load the BIOS image. */<br>
-=C2=A0 =C2=A0 if (bios_name =3D=3D NULL)<br>
+=C2=A0 =C2=A0 if (bios_name =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_name =3D BIOS_FILENAME;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0filename =3D qemu_find_file(QEMU_FILE_TYPE_<wbr>BIOS, b=
ios_name);<br>
=C2=A0 =C2=A0 =C2=A0if (filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_size =3D load_image_targphys(filenam=
e, 0xfff00000LL,<br>
@@ -229,7 +233,8 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_get_region(sysbus,=
 0));<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space, 0xf0000=
000,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_get_region(sysbus,=
 1));<br>
-=C2=A0 =C2=A0 memory_region_init_io(dma_<wbr>dummy, NULL, &amp;dma_dummy_o=
ps, NULL, &quot;dummy_dma&quot;, 0x1000);<br>
+=C2=A0 =C2=A0 memory_region_init_io(dma_<wbr>dummy, NULL, &amp;dma_dummy_o=
ps,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NULL, &quot;dummy_dma&quot;, 0x1000);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space, 0x8000d=
000, dma_dummy);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* ISA bus: IO space at 0x90000000, mem space at 0x9100=
0000 */<br>
@@ -276,8 +281,9 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0/* Network controller */<br>
=C2=A0 =C2=A0 =C2=A0for (n =3D 0; n &lt; nb_nics; n++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nd =3D &amp;nd_table[n];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nd-&gt;model)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nd-&gt;model) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nd-&gt;model =3D g_strdup(&=
quot;dp83932&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(nd-&gt;model, &quot;dp83932&qu=
ot;) =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_check_nic_model(nd, &q=
uot;dp83932&quot;);<br>
<br>
@@ -338,12 +344,12 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0/* Serial ports */<br>
=C2=A0 =C2=A0 =C2=A0if (serial_hd(0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_mm_init(address_space, 0x80006000,=
 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(rc4030, 8), 8000000/16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(rc4030, 8), 8000000 / 16,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 serial_hd(0), DEVICE_NATIVE_ENDIAN);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (serial_hd(1)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_mm_init(address_space, 0x80007000,=
 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(rc4030, 9), 8000000/16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(rc4030, 9), 8000000 / 16,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 serial_hd(1), DEVICE_NATIVE_ENDIAN);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--00000000000022d61f0599048b97--

