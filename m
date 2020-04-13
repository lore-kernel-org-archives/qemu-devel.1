Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B50C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7890420663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InWQtmKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7890420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7Gy-0004cY-MS
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7GD-0003oK-FE
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7GC-0003pY-9i
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:08:57 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:38823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7GC-0003pU-5y; Mon, 13 Apr 2020 18:08:56 -0400
Received: by mail-vs1-xe43.google.com with SMTP id y15so6009110vsm.5;
 Mon, 13 Apr 2020 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HKNaRMZJ3gFznHNDvelB7ig1QHhvKcE4j/y1jytht9A=;
 b=InWQtmKQfXr4TqinKncD7MN/QgUNsROyxXpW62erh/0xwbvfeiB6pN936PJiLl5Cym
 3DFI6tjS5ltJDR5zx/cwBEHy7iErje8rAG0eAPxf2nVuJF1MfJ9p83Bejc+YPYCIE04y
 XUF1mJi1WJcj5x+VkkfjswcfAzQ21IQy6yiqWIuP5gxja1779TpRyxrUDrHTsq2NYR3v
 ue204YHjPOYkKQvaD03UlSlyyg6lt1j9s3b1vF7u0iPkqeAZLHx1+ZYgS5k9nRTc3Jws
 gpYeHT18BTGdppwtyHP4A7k/3lsEvfsEQLycaeEFmqyDpJw1tUmcPyyx0p3uakuwhh5K
 kzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HKNaRMZJ3gFznHNDvelB7ig1QHhvKcE4j/y1jytht9A=;
 b=jiRu2y3SQruy+iRYwR8gzEuQfTa7LY0O+3SjkMHohqMgjzluQhxNOqa7iFiGiwT80P
 lq+IQAzz75WjQsDXfjhmGh8ka8HNxWgHXXDO6D7MnXiQXlu25vUarsaaloPIdPVE5H93
 XQzY5P74b2ox3bXWe7HZYtdoed2CFW2E7p4ddIUw5f2t+g/x5lPV4hITyD2WA7PsitoT
 0eNDN6/MbjvplQnihvxgTjembcrxAy4E0O/8PLFpP0l10sbon69qjoH+Gfy9ggbzRj1Q
 7jVtK8uwM0aDr8xOK9bfbInwFDFRvGt2UzzOi0zDosKmCPtPgp5aF+72tVR1A+YZpLeV
 NVFg==
X-Gm-Message-State: AGi0PuZaTFoytv6NDJZgZMWSNgC9U6yg+/jLCWcX6UagtJ0nU5zVXdc6
 gUz4K9+SM6Vfrr40KnC/ropqm2YY31dR3i8fYvQ=
X-Google-Smtp-Source: APiQypJDM+Ytl8QF98aM4sj5gWifJfbg22cv5Ib9uFnyCrhc0JH2H4jr2a+ZjmSvhldng+NJpqpyWy8kxoXLw5M2auA=
X-Received: by 2002:a67:e2d5:: with SMTP id i21mr4682013vsm.151.1586815735420; 
 Mon, 13 Apr 2020 15:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-13-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-13-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:00:39 -0700
Message-ID: <CAKmqyKPUdDT+QM3ovRsRMq6gf=B6MJt_FQgcjza236mdUWpYAA@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 12/24] hw/arm/stm32f205_soc: Store MemoryRegion
 in STM32F205State
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 3:41 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Coccinelle reported:
>
>   $ spatch ... --timeout 60 --sp-file \
>     scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   HANDLING: ./hw/arm/stm32f205_soc.c
>   >>> possible moves from stm32f205_soc_initfn() to stm32f205_soc_realize=
() in ./hw/arm/stm32f205_soc.c:83
>
> While reviewing we notice storing the MemoryRegion in the device
> state, we'll be able to later automatically simplify the error
> propagation calls.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/arm/stm32f205_soc.h |  4 ++++
>  hw/arm/stm32f205_soc.c         | 18 +++++++-----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_so=
c.h
> index 922a733f88..63e7e7c825 100644
> --- a/include/hw/arm/stm32f205_soc.h
> +++ b/include/hw/arm/stm32f205_soc.h
> @@ -56,6 +56,10 @@ typedef struct STM32F205State {
>
>      ARMv7MState armv7m;
>
> +    MemoryRegion sram;
> +    MemoryRegion flash;
> +    MemoryRegion flash_alias;
> +
>      STM32F2XXSyscfgState syscfg;
>      STM32F2XXUsartState usart[STM_NUM_USARTS];
>      STM32F2XXTimerState timer[STM_NUM_TIMERS];
> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
> index 118c342559..42f4e44134 100644
> --- a/hw/arm/stm32f205_soc.c
> +++ b/hw/arm/stm32f205_soc.c
> @@ -87,23 +87,19 @@ static void stm32f205_soc_realize(DeviceState *dev_so=
c, Error **errp)
>      SysBusDevice *busdev;
>      Error *err =3D NULL;
>      int i;
> -
>      MemoryRegion *system_memory =3D get_system_memory();
> -    MemoryRegion *sram =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *flash =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *flash_alias =3D g_new(MemoryRegion, 1);
>
> -    memory_region_init_rom(flash, OBJECT(dev_soc), "STM32F205.flash",
> +    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32F205.flash"=
,
>                             FLASH_SIZE, &error_fatal);
> -    memory_region_init_alias(flash_alias, OBJECT(dev_soc),
> -                             "STM32F205.flash.alias", flash, 0, FLASH_SI=
ZE);
> +    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
> +                             "STM32F205.flash.alias", &s->flash, 0, FLAS=
H_SIZE);
>
> -    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash=
);
> -    memory_region_add_subregion(system_memory, 0, flash_alias);
> +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->f=
lash);
> +    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
>
> -    memory_region_init_ram(sram, NULL, "STM32F205.sram", SRAM_SIZE,
> +    memory_region_init_ram(&s->sram, NULL, "STM32F205.sram", SRAM_SIZE,
>                             &error_fatal);
> -    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sr=
am);
>
>      armv7m =3D DEVICE(&s->armv7m);
>      qdev_prop_set_uint32(armv7m, "num-irq", 96);
> --
> 2.21.1
>
>

