Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F86BC48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A07E20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRMQboMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A07E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffi0-0001dj-Ah
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32942)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <atar4qemu@gmail.com>) id 1hfffN-0000a5-91
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1hfffL-0008HA-Qw
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:14:57 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hfffK-0008F7-VT
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:14:55 -0400
Received: by mail-io1-xd42.google.com with SMTP id s7so903655iob.11
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t3Cn+pUIhIpjURzIYY1KGobuO49nmtNfCIkUNb9tzP8=;
 b=eRMQboMP11yYXSTydtFfxLe8rWz6VHZhKGyj0ZZN8d6kGmZj/P3E5gIcKIltqK7NGt
 YfyPYG+rYWbiP68s205v1GcZaJKB2xF4nGZ2XR7UOLHnvoQ/Ysg+//tW7xZ2S+/2ODTj
 lG1r47MDRg9bIwq8FaIrgiSfnGD6P4Qlndkobvr2DRRXY7a3zaeUNYxYYNRn8xesdxDR
 Fl4FHRRUCdbl52P6HDMepVwUC2o6QHbdXH8EZXiffs4AvhH5qUYfjDANFK2bDK0Ma+AT
 5Xa8LUz0x0Hpt2HACUgNXUljdUVC78kr+sLZXz47OuwugcI3Jx6ex/i9PN6q41a+Ys7b
 gisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t3Cn+pUIhIpjURzIYY1KGobuO49nmtNfCIkUNb9tzP8=;
 b=fnqY6uMX/YdYmKD0ZBGKMo+QQn8XO/PQ7878cs1W1knFu3u4PRSkZUuuW4bcZ0hVHn
 KFKxEk03/FASOUcL4UijiEYD5S+oLj6ibR9xZ8hNukJa7Z41KtnPSow1ZzCaLwHa1VYv
 CbI/tjk08OklxU7L/Z2VeJnIZfNi7O5FaG/VoD+O6Zw3OxZPUmMRogqsUNo6eEog+p/v
 QyyUCELhAtoNz5QXcVj9qx9lmhH9Mx5JloszTH4vLf+xZenCTHzUB8v+uVDc4RpibVm9
 CILDhOidcbPbsohovGRiWgTTx8B5FkzCO+kAfAYYp7r3fZVfYyl12kPppS6wGrSq87Ht
 p1Mw==
X-Gm-Message-State: APjAAAW43G8e9rgkMzjPvI3TUUCKpUtzaDPdk8Ve8T7ZRXqNUrpt4Akt
 RQw3hWSDV0qNLvX2L+8JKVD8QiTM+vREzeUSbSI=
X-Google-Smtp-Source: APXvYqwMA1rSt0Wp5Q8GbqBp8LDsEEVRXBt3a5lFUU/tIConIzQIuZkjceU3dCdzYCAJzViXk2Io/vAN9FQircKEyqU=
X-Received: by 2002:a6b:6012:: with SMTP id r18mr4388784iog.241.1561446894337; 
 Tue, 25 Jun 2019 00:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-9-f4bug@amsat.org>
In-Reply-To: <20190624220056.25861-9-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 25 Jun 2019 09:14:43 +0200
Message-ID: <CACXAS8C=D+Jf9SPiW9SMTj6VMTcjeAQS+VXhpgUtKPPSfFrg5w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/sparc/sun4m: Simplify the RAM
 creation
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 12:01 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Now than the empty_slot device can be overlapped, use it to cover
> the maximum memory range.

Whilie this is true for SS-5, the SS-20 does trap on missing RAM, so
empty_slot_init must be conditional.
nack.

> We can simplify now the main RAM is created.
> The TYPE_SUN4M_MEMORY is not migratable, simply remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sparc/sun4m.c | 85 ++++++++----------------------------------------
>  1 file changed, 13 insertions(+), 72 deletions(-)
>
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 0df5a8edfc..d55753d5cb 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -767,71 +767,6 @@ static const TypeInfo prom_info =3D {
>      .class_init    =3D prom_class_init,
>  };
>
> -#define TYPE_SUN4M_MEMORY "memory"
> -#define SUN4M_RAM(obj) OBJECT_CHECK(RamDevice, (obj), TYPE_SUN4M_MEMORY)
> -
> -typedef struct RamDevice {
> -    SysBusDevice parent_obj;
> -
> -    MemoryRegion ram;
> -    uint64_t size;
> -} RamDevice;
> -
> -/* System RAM */
> -static void ram_realize(DeviceState *dev, Error **errp)
> -{
> -    RamDevice *d =3D SUN4M_RAM(dev);
> -    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> -
> -    memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ram"=
,
> -                                         d->size);
> -    sysbus_init_mmio(sbd, &d->ram);
> -}
> -
> -static void ram_init(hwaddr addr, ram_addr_t RAM_size,
> -                     uint64_t max_mem)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -    RamDevice *d;
> -
> -    /* allocate RAM */
> -    if ((uint64_t)RAM_size > max_mem) {
> -        error_report("Too much memory for this machine: %" PRId64 ","
> -                     " maximum %" PRId64,
> -                     RAM_size / MiB, max_mem / MiB);
> -        exit(1);
> -    }
> -    dev =3D qdev_create(NULL, "memory");
> -    s =3D SYS_BUS_DEVICE(dev);
> -
> -    d =3D SUN4M_RAM(dev);
> -    d->size =3D RAM_size;
> -    qdev_init_nofail(dev);
> -
> -    sysbus_mmio_map(s, 0, addr);
> -}
> -
> -static Property ram_properties[] =3D {
> -    DEFINE_PROP_UINT64("size", RamDevice, size, 0),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void ram_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -
> -    dc->realize =3D ram_realize;
> -    dc->props =3D ram_properties;
> -}
> -
> -static const TypeInfo ram_info =3D {
> -    .name          =3D TYPE_SUN4M_MEMORY,
> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> -    .instance_size =3D sizeof(RamDevice),
> -    .class_init    =3D ram_class_init,
> -};
> -
>  static void cpu_devinit(const char *cpu_type, unsigned int id,
>                          uint64_t prom_addr, qemu_irq **cpu_irqs)
>  {
> @@ -872,6 +807,19 @@ static void sun4m_hw_init(const struct sun4m_hwdef *=
hwdef,
>      FWCfgState *fw_cfg;
>      DeviceState *dev;
>      SysBusDevice *s;
> +    MemoryRegion ram;
> +
> +    if ((uint64_t)machine->ram_size > hwdef->max_mem) {
> +        error_report("Too much memory for this machine: %" PRId64 ","
> +                     " maximum %" PRId64,
> +                     machine->ram_size / MiB, hwdef->max_mem / MiB);
> +        exit(1);
> +    }
> +    memory_region_allocate_system_memory(&ram, OBJECT(machine), "sun4m.r=
am",
> +                                         machine->ram_size);
> +    memory_region_add_subregion(get_system_memory(), 0x00000000, &ram);
> +    /* models without ECC don't trap when missing ram is accessed */
> +    empty_slot_init(0x00000000, hwdef->max_mem);
>
>      /* init CPUs */
>      for(i =3D 0; i < smp_cpus; i++) {
> @@ -881,13 +829,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *=
hwdef,
>      for (i =3D smp_cpus; i < MAX_CPUS; i++)
>          cpu_irqs[i] =3D qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_=
PILS);
>
> -
>      /* set up devices */
> -    ram_init(0, machine->ram_size, hwdef->max_mem);
> -    /* models without ECC don't trap when missing ram is accessed */
> -    if (!hwdef->ecc_base) {
> -        empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram=
_size);
> -    }
>
>      prom_init(hwdef->slavio_base, bios_name);
>
> @@ -1561,7 +1503,6 @@ static void sun4m_register_types(void)
>      type_register_static(&idreg_info);
>      type_register_static(&afx_info);
>      type_register_static(&prom_info);
> -    type_register_static(&ram_info);
>
>      type_register_static(&ss5_type);
>      type_register_static(&ss10_type);
> --
> 2.19.1
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

