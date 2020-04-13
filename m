Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A15C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3DC20735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI0Calf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3DC20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7Mp-0002A1-9i
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7Lo-00010N-8b
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7Ln-0004in-00
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:14:44 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:35817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7Lk-0004ia-2F; Mon, 13 Apr 2020 18:14:42 -0400
Received: by mail-vs1-xe42.google.com with SMTP id r7so3550196vso.2;
 Mon, 13 Apr 2020 15:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5eB1z8c5kK9kvW0a6iujT6vXRX9S8fGFoN6RJDHnU2g=;
 b=TI0Calf2IxOfsyHK2xiLLnkprfuUQZ3rec4E0Pkows5wNSZzE+kFamJx03TcD8yytM
 +PmQUcTuSLU/Ujb1i8o6P54jgreamUbYltgTg6N8mLPZWQ/+phGZ3MJ/5beryeROv6Wq
 MeVe3ia9ChISGinAPI3RoLam/Ohz1Z2KxvaWL0A+Lv0rWruY1J3gsD24+ETUVUCjZw79
 kOtB3XMkAeKNnOgRFbwVgzZBdYbMxasyFTEUt51C1fESqQPUoGLFEDn2ZJVo9DMFJoVp
 9CLusdX3k8qPVNGNG2biM+CHwoDwc9toaZz3qTyOQv4oP6jwl7FgdO+it01nV0kzIYfl
 q/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5eB1z8c5kK9kvW0a6iujT6vXRX9S8fGFoN6RJDHnU2g=;
 b=f5zRKLB7jWSUZZaSvbCEaP+1b462nZA2CegQR/bcZ9c8iwqKyJWZtXFLrh2S9YTm0E
 lL2XFujgVM1G3DCRCrojIUrzgozpK/ccayRq3LF3z5M+FoaelzBvvrgmUBVxmpnCAkff
 Q2rm0WRBQjgyA3OASCUQS/ev9oi6m6YJRhNmVT5tgrLuPh1TgCVXMtPJjSDd55ql3tRI
 8eh0uuvduLvWB0kxbTXDXGyfF866WQTptybe6LdkelmzFVKnTCkX7D5lXID6D2l5r4XC
 U4YsUtwm0tn+uDJzJLOWOHifocUCYeQM0atd9qsGWL+gQvQqBh6A8vDcgjnK6jfoAVYX
 Tzog==
X-Gm-Message-State: AGi0PuYhU9dTS4e5IRbr8mMKS6cM4sbNOVcvbIYwAW4hkzMoqNdmmPBw
 H6JLeIpQh+lE/PZ5DuHzQ8J+fFGZ/NB5RMSF+e4=
X-Google-Smtp-Source: APiQypLObMJB5KGfvx8eqmUvlJyWtzXJPVcel83Hl2IydFW0aD/us9mAT8+du+g1gFIylr5J/S0ETsQkcTdu9h5BKx4=
X-Received: by 2002:a67:902:: with SMTP id 2mr14851445vsj.133.1586816079263;
 Mon, 13 Apr 2020 15:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-17-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-17-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:06:22 -0700
Message-ID: <CAKmqyKN=2tkTyPY6d5a_T1Lnd0-m6tFPw2fdes2a0C+_erYXeQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 16/24] hw/arm/xlnx-zynqmp: Move some code from
 realize() to init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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
> Coccinelle failed at processing this file:
>
>   $ spatch ... --timeout 60 --sp-file \
>     scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   HANDLING: ./hw/arm/xlnx-zynqmp.c
>   EXN: Coccinelle_modules.Common.Timeout
>
> Move the calls using &error_abort which don't depend on input
> updated before realize() to init().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v3: Typo 'depend of' -> 'depend on' (eblake)
> ---
>  hw/arm/xlnx-zynqmp.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 457057198a..5ec9c24ee7 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -242,6 +242,11 @@ static void xlnx_zynqmp_init(Object *obj)
>                                  &s->apu_cpu[i], sizeof(s->apu_cpu[i]),
>                                  ARM_CPU_TYPE_NAME("cortex-a53"),
>                                  &error_abort, NULL);
> +
> +        object_property_set_int(OBJECT(&s->apu_cpu[i]), QEMU_PSCI_CONDUI=
T_SMC,
> +                                "psci-conduit", &error_abort);
> +        object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
> +                                "reset-cbar", &error_abort);
>      }
>
>      sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
> @@ -250,6 +255,10 @@ static void xlnx_zynqmp_init(Object *obj)
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
>          sysbus_init_child_obj(obj, "gem[*]", &s->gem[i], sizeof(s->gem[i=
]),
>                                TYPE_CADENCE_GEM);
> +        object_property_set_int(OBJECT(&s->gem[i]), GEM_REVISION, "revis=
ion",
> +                                &error_abort);
> +        object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-que=
ues",
> +                                &error_abort);
>      }
>
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
> @@ -259,6 +268,8 @@ static void xlnx_zynqmp_init(Object *obj)
>
>      sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
>                            TYPE_SYSBUS_AHCI);
> +    object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports=
",
> +                            &error_abort);
>
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
>          sysbus_init_child_obj(obj, "sdhci[*]", &s->sdhci[i],
> @@ -370,9 +381,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>      for (i =3D 0; i < num_apus; i++) {
>          char *name;
>
> -        object_property_set_int(OBJECT(&s->apu_cpu[i]), QEMU_PSCI_CONDUI=
T_SMC,
> -                                "psci-conduit", &error_abort);
> -
>          name =3D object_get_canonical_path_component(OBJECT(&s->apu_cpu[=
i]));
>          if (strcmp(name, boot_cpu)) {
>              /* Secondary CPUs start in PSCI powered-down state */
> @@ -387,8 +395,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>                                   s->secure, "has_el3", NULL);
>          object_property_set_bool(OBJECT(&s->apu_cpu[i]),
>                                   s->virt, "has_el2", NULL);
> -        object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
> -                                "reset-cbar", &error_abort);
>          object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
>                                  "core-count", &error_abort);
>          object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized=
",
> @@ -490,10 +496,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Er=
ror **errp)
>              qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>              qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
>          }
> -        object_property_set_int(OBJECT(&s->gem[i]), GEM_REVISION, "revis=
ion",
> -                                &error_abort);
> -        object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-que=
ues",
> -                                &error_abort);
>          object_property_set_bool(OBJECT(&s->gem[i]), true, "realized", &=
err);
>          if (err) {
>              goto out_propagate_error;
> @@ -514,8 +516,6 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>                             gic_spi[uart_intr[i]]);
>      }
>
> -    object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports=
",
> -                            &error_abort);
>      object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
>      if (err) {
>          goto out_propagate_error;
> --
> 2.21.1
>
>

