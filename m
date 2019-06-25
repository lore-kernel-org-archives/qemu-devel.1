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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F2DC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB4120665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmcj47vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB4120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffYv-0002lE-31
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <atar4qemu@gmail.com>) id 1hffUv-0001Pk-AD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1hffUs-0000FG-GP
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:04:07 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hffUs-0000Bg-AH
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:04:06 -0400
Received: by mail-io1-xd43.google.com with SMTP id r185so705266iod.6
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KrXnJ5YvWdU3UegtaiF+6vuAdH4k7Ayo6tMH4ry+F0Y=;
 b=Pmcj47vs2j5u4pmtBBp+m+BriQKAIEXN+Xk4yq/BK+jSxqJ2PiXVCkcs7+cB4E5Lc7
 8Yty6V2mX3K0p+q/sPqPfabWRAPI5jJDJSFmXT9vY+p+6wyklb/7MJYhLYtIhCDanrdZ
 39eIsXspv03lv/S3YWmmpOYtNhYxeByjhB3faNV3SwvT/xMJvKgU1x2ds4VaZ6OENh2E
 aSnUANBTP4h937DfmZcmk+tGri6E7LFIDi2+MP/kVNFAlxwsQN4yrL0uzpZK+u2StHnY
 YyCaxlfxmxHZF/Eq2rtbQ6L0Ojn8ySFTkDbLslXxfcQ1kG+4Xnwbq1UmnoDtb9SnJsML
 JY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KrXnJ5YvWdU3UegtaiF+6vuAdH4k7Ayo6tMH4ry+F0Y=;
 b=qwQ76FznkHnVCxurOpszqSl4pIEKGOXIsR3e3bmdHlN3zOgKDJ1YHobOvVZ7apYlH5
 Ujhp6aJqKZrBpCB99HcPm2MjP4giupifHfXtLJSVWWQ211Vcbb+Db3Nz39jVpDibLhRg
 NrUOFLi7+FSGDj61PEkY/tuhEa4LRU7WeALNtNX4SLG2jDvjKt6ZAwznxXovlBZcewN+
 sc8msT/cItBGGq/oavmMgZXJ5RkMAZLSpolKao5Btd/4vA+h3mzadCwrr4GVm6SEFLFF
 cZMoi1UWi5Q6vCAWM98JY1LORZQV/lM1AM0g3nC+lLmvJSWAtku9FuybQb2KCWDTZGhs
 3rFQ==
X-Gm-Message-State: APjAAAUble6C00cnDb3ay7EmGbdJzXKZe1Pf8iknFz1LwVl4dUgtb3h1
 D76zAp8qZydE9blRh9Cn/+h0g87fVGou9lI664A=
X-Google-Smtp-Source: APXvYqwKdjHgFM1mQyvCmfmNCYDhac5IvdSKki36PE8hzNE/IVMIqTAhsx90gkW4KtSmYfJ38xIVyMApsbK4i1dLYYY=
X-Received: by 2002:a5d:964d:: with SMTP id d13mr21975558ios.224.1561446244272; 
 Tue, 25 Jun 2019 00:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-10-f4bug@amsat.org>
In-Reply-To: <20190624220056.25861-10-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 25 Jun 2019 09:03:53 +0200
Message-ID: <CACXAS8B1iSM1TKOW5E3cgT7tsbRrOw8OvO+ATKLpdQsGQ98Tew@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH 9/9] hw/misc/empty_slot: Pass the slot name
 as argument
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
> Use the slot name to have more meaningful tracing logs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  include/hw/misc/empty_slot.h | 3 ++-
>  hw/mips/mips_malta.c         | 2 +-
>  hw/misc/empty_slot.c         | 6 ++++--
>  hw/sparc/sun4m.c             | 9 ++++++---
>  4 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/misc/empty_slot.h b/include/hw/misc/empty_slot.h
> index 46483f24c3..d0cd989d2d 100644
> --- a/include/hw/misc/empty_slot.h
> +++ b/include/hw/misc/empty_slot.h
> @@ -14,6 +14,7 @@
>
>  /**
>   * empty_slot_init: create and map a RAZ/WI device
> + * @name: name of the device for debug logging
>   * @base: base address of the device's MMIO region
>   * @size: size of the device's MMIO region
>   *
> @@ -27,6 +28,6 @@
>   * use it to cover a large region and then map other devices on top of i=
t
>   * if necessary.
>   */
> -void empty_slot_init(hwaddr addr, uint64_t slot_size);
> +void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size);
>
>  #endif
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 7008be2e5b..51db5212be 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1212,7 +1212,7 @@ void mips_malta_init(MachineState *machine)
>      /* The whole address space decoded by the GT-64120A doesn't generate
>         exception when accessing invalid memory. Create an empty slot to
>         emulate this feature. */
> -    empty_slot_init(0, 0x20000000);
> +    empty_slot_init("gt64120-ad", 0x00000000, 0x20000000);
>
>      qdev_init_nofail(dev);
>
> diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
> index b810655554..396f9dd06a 100644
> --- a/hw/misc/empty_slot.c
> +++ b/hw/misc/empty_slot.c
> @@ -52,12 +52,13 @@ static const MemoryRegionOps empty_slot_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>  };
>
> -void empty_slot_init(hwaddr addr, uint64_t slot_size)
> +void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size)
>  {
>      DeviceState *dev;
>
>      dev =3D qdev_create(NULL, TYPE_EMPTY_SLOT);
>
> +    qdev_prop_set_string(dev, "name", name);
>      qdev_prop_set_uint64(dev, "size", slot_size);
>      qdev_init_nofail(dev);
>
> @@ -77,7 +78,8 @@ static void empty_slot_realize(DeviceState *dev, Error =
**errp)
>          return;
>      }
>      if (s->name =3D=3D NULL) {
> -        s->name =3D g_strdup("empty-slot");
> +        error_setg(errp, "property 'name' not specified");
> +        return;
>      }
>
>      memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index d55753d5cb..b17be3ddb8 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -819,7 +819,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
>                                           machine->ram_size);
>      memory_region_add_subregion(get_system_memory(), 0x00000000, &ram);
>      /* models without ECC don't trap when missing ram is accessed */
> -    empty_slot_init(0x00000000, hwdef->max_mem);
> +    empty_slot_init("dram", 0x00000000, hwdef->max_mem);
>
>      /* init CPUs */
>      for(i =3D 0; i < smp_cpus; i++) {
> @@ -859,7 +859,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
>             Software shouldn't use aliased addresses, neither should it c=
rash
>             when does. Using empty_slot instead of aliasing can help with
>             debugging such accesses */
> -        empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
> +        empty_slot_init("iommu.alias",
> +                        hwdef->iommu_pad_base, hwdef->iommu_pad_len);
>      }
>
>      sparc32_dma_init(hwdef->dma_base,
> @@ -908,7 +909,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
>      for (i =3D 0; i < MAX_VSIMMS; i++) {
>          /* vsimm registers probed by OBP */
>          if (hwdef->vsimm[i].reg_base) {
> -            empty_slot_init(hwdef->vsimm[i].reg_base, 0x2000);
> +            char *name =3D g_strdup_printf("vsimm[%d]", i);
> +            empty_slot_init(name, hwdef->vsimm[i].reg_base, 0x2000);
> +            g_free(name);
>          }
>      }
>
> --
> 2.19.1
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

