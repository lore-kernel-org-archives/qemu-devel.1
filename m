Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38BCC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39FC20663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soz/lluK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39FC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7Fs-0003Fy-Uz
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7FI-0002ej-8l
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7FG-0003TP-VO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:08:00 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:33841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7FG-0003P4-RZ; Mon, 13 Apr 2020 18:07:58 -0400
Received: by mail-vs1-xe41.google.com with SMTP id b5so6498830vsb.1;
 Mon, 13 Apr 2020 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=43BfZE9uxQlRypiXVLawqDbuwTbqxgiL7O2TCDlfh/g=;
 b=Soz/lluK+rYgW7TNHkF/fmsFqes4CsWM+/+cQedeyb8GyB2+WFvbgbg6SugVUl+9ja
 /Kt7OEmXq05rLhrb0rKqY8+QhlqDTY7niiQK01EFqM/QtBPC1bJU9LrVRszWds7M7C+l
 qc2aGPrU+hgXn2KBEnxwTrArE64rVM3nU+fxboY3rBqgkdYCsFuxo9V1LJZnnphLThw7
 XhadXRqhphrsA5bJj865JBOURPbtrxWXJVKtyfSaVDKWVW2aPJqkXo5+JCU2181tihq/
 gsIigC0ob8Sek8ChSSCLEz5dwRjfL6994LUZr8xd/rGpw6Z3cE8ZP4nq4yTRhCPRsAAp
 JMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=43BfZE9uxQlRypiXVLawqDbuwTbqxgiL7O2TCDlfh/g=;
 b=olW31riyxdUL3wOLi0mVzGxFn8Y9a/YJvk/EVl5Xw/uMW/lkDXm5PP70Zjq2/RJsyl
 V0w7ffA9QU7wXqy8TNQi36/XoMEaWkf4EWpx06yLVBxSH3xYNAiB8I1GMBChf4sGHIyu
 baSKoXwE5hzJzXOHmD7CYsS5kM2Xn9153ShBJldHK/thGphGtBCOIotyicBH7eo7rEIq
 UzvR2K7W3O4m6jypfFS//lLKKf4eG6Q4FTF3pIRmEGoTeLDXZkULmQ/KdFxJ7Gr51myl
 Dui+fh/hZYCZLZG8nR05Ys9gQpRo/Tg9v8hKx6tKuqsP5osS2KkrWRK7/T1tXEzvCAkV
 qIwg==
X-Gm-Message-State: AGi0PuaEtoLcGpje0uKV7Jrf8dTepAv/C5FpJLoNF81X5YJZu1mG3IEa
 Y5e4lo7KbCHKve1x2IAEFNPEuU+4tt1kmNEFvOA=
X-Google-Smtp-Source: APiQypJXJu8RS2a8EA2WZ4sRmnHeppOg+jK3niFqdqiVH7okRCgERTN4WzyiM4Z9fC/AqASKYb0kN9ibRcqbxqmEtvI=
X-Received: by 2002:a67:902:: with SMTP id 2mr14829949vsj.133.1586815677800;
 Mon, 13 Apr 2020 15:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-12-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-12-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 14:59:41 -0700
Message-ID: <CAKmqyKPpjifNG575VVbfKk1h7+v1XK9YMs44nG2rY=Z3=HDkbg@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 11/24] hw/arm/msf2-soc: Store MemoryRegion in
 MSF2State
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e41
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

On Sun, Apr 12, 2020 at 3:40 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Coccinelle reported:
>
>   $ spatch ... --timeout 60 --sp-file \
>     scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   HANDLING: ./hw/arm/msf2-soc.c
>   >>> possible moves from m2sxxx_soc_initfn() to m2sxxx_soc_realize() in =
./hw/arm/msf2-soc.c:86
>
> While reviewing we notice storing the MemoryRegion in the device
> state, we'll be able to later automatically simplify the error
> propagation calls.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/arm/msf2-soc.h |  4 ++++
>  hw/arm/msf2-soc.c         | 18 +++++++-----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
> index 3cfe5c76ee..e4c5110036 100644
> --- a/include/hw/arm/msf2-soc.h
> +++ b/include/hw/arm/msf2-soc.h
> @@ -50,6 +50,10 @@ typedef struct MSF2State {
>
>      ARMv7MState armv7m;
>
> +    MemoryRegion sram;
> +    MemoryRegion nvm;
> +    MemoryRegion nvm_alias;
> +
>      char *cpu_type;
>      char *part_name;
>      uint64_t envm_size;
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 588d643b8d..e448b0ab74 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -90,13 +90,9 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, E=
rror **errp)
>      SysBusDevice *busdev;
>      Error *err =3D NULL;
>      int i;
> -
>      MemoryRegion *system_memory =3D get_system_memory();
> -    MemoryRegion *nvm =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *nvm_alias =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *sram =3D g_new(MemoryRegion, 1);
>
> -    memory_region_init_rom(nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_si=
ze,
> +    memory_region_init_rom(&s->nvm, OBJECT(dev_soc), "MSF2.eNVM", s->env=
m_size,
>                             &error_fatal);
>      /*
>       * On power-on, the eNVM region 0x60000000 is automatically
> @@ -104,15 +100,15 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc=
, Error **errp)
>       * start address (0x0). We do not support remapping other eNVM,
>       * eSRAM and DDR regions by guest(via Sysreg) currently.
>       */
> -    memory_region_init_alias(nvm_alias, OBJECT(dev_soc), "MSF2.eNVM", nv=
m, 0,
> -                             s->envm_size);
> +    memory_region_init_alias(&s->nvm_alias, OBJECT(dev_soc), "MSF2.eNVM"=
,
> +                             &s->nvm, 0, s->envm_size);
>
> -    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, nvm);
> -    memory_region_add_subregion(system_memory, 0, nvm_alias);
> +    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, &s->nv=
m);
> +    memory_region_add_subregion(system_memory, 0, &s->nvm_alias);
>
> -    memory_region_init_ram(sram, NULL, "MSF2.eSRAM", s->esram_size,
> +    memory_region_init_ram(&s->sram, NULL, "MSF2.eSRAM", s->esram_size,
>                             &error_fatal);
> -    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
> +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sr=
am);
>
>      armv7m =3D DEVICE(&s->armv7m);
>      qdev_prop_set_uint32(armv7m, "num-irq", 81);
> --
> 2.21.1
>
>

