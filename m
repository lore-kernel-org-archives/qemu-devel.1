Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE2AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FCF20678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz0PVq/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FCF20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7Si-0007DA-FP
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7Rb-00062Y-F3
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7Ra-0005gk-97
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:20:43 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:36447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7Ra-0005gF-4n; Mon, 13 Apr 2020 18:20:42 -0400
Received: by mail-ua1-x944.google.com with SMTP id m15so3730682uao.3;
 Mon, 13 Apr 2020 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=toRP5OdDSqL37nOVTtbDzZz9Y6NSxog2RE0ose10fSM=;
 b=Lz0PVq/AAPYY7OhzNipMMEv90XYIzcdSGE4EwnXvk7uCDP3HNaWnZICooiC793ZDB+
 TXs3h1kGDNHRpe2rdeFBSHU0QtQcOBY8cxU5aUUVKJL3H22x7MZyOcdd/xZl7YyFlevR
 jDRJ/nDVcN8mZtDLlrbeEQiR71lfR/b2lPfzPNH4cAgTnVKIcFGls6GEGndtQgMjXLZ7
 C/s3PW0JOxy9Qivn8o7KJUo7spGm9mY36C6Hqj8dyzj4cKQ9arhGyFAfZEe7NokIZvUU
 l7VbsGiICoQ6YSsDStinfY+FKAyw4ZRXPDa1wi7at8ykMPxlpYSkKM88QwpBNG2d0eeG
 GeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=toRP5OdDSqL37nOVTtbDzZz9Y6NSxog2RE0ose10fSM=;
 b=uZMHgShfzkmSZ48EaS+19YrGofUsYh+F/HFgKC2gL+JKZJE5Fujyv00dBMyHS2qEo6
 c2LKDvgJPtQCb0qV3QQYfUdKLSpCgvCQ9lQrVd0ny25Qgy6NH8j8nBgeTPW6TKh1TPDH
 GVuCr27EH7M6UU7+7ztTDoJi4f5mkdywrVydvQ0zR4WeF4vJPnhIepW+dRDeh+6eM+lz
 7X0aEIfehGbA2YTnvpjsNQTpeZA1MceBjuCTYH1x0wxMzQ6SnKIVqNatHRjSbMimFVC/
 yJSpZdQEv/3lp5F4SK6Beq38RTx7XqsC266o0h6pN9X4iM7MhjdOYRyZM1jGjz2OGz97
 P97g==
X-Gm-Message-State: AGi0PuYVNsZ7v9H6Ypz90bt+cGs6PX0d6gwwAxGvhCFPwEAyt5c8IM9A
 3Q6N4T3VDuRSQz69IfXM7QTsiPIqhsHt0o/6TvM=
X-Google-Smtp-Source: APiQypK1SHabMyVIMqvApnoC72tgGemKa5e9A9NqQf9hEf2dmcMpUWP4/HTYUMHPAAQSzdrNBRw+qVzieqSVmyvoIqk=
X-Received: by 2002:a9f:27ca:: with SMTP id b68mr10657548uab.8.1586816441036; 
 Mon, 13 Apr 2020 15:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200412224144.12205-1-f4bug@amsat.org>
 <20200412224144.12205-8-f4bug@amsat.org>
In-Reply-To: <20200412224144.12205-8-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:12:24 -0700
Message-ID: <CAKmqyKNKw9hye2AaGocrKozyTA0xb-qDFB=yJ06iV+4xGT8-OA@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 07/23] hw/riscv/sifive: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 4:00 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Patch created mechanically by running:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
>     --keep-comments --smpl-spacing --in-place --dir hw
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_e.c |  6 +++++-
>  hw/riscv/sifive_u.c | 24 ++++++++++++++++++++----
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 0be8b52147..6d4e141ff7 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -156,7 +156,11 @@ static void riscv_sifive_e_soc_realize(DeviceState *=
dev, Error **errp)
>      MemoryRegion *sys_mem =3D get_system_memory();
>
>      object_property_set_bool(OBJECT(&s->cpus), true, "realized",
> -                            &error_abort);
> +                            &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>
>      /* MMIO */
>      s->plic =3D sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index e13ab34de4..b07526aba1 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -508,9 +508,17 @@ static void riscv_sifive_u_soc_realize(DeviceState *=
dev, Error **errp)
>      NICInfo *nd =3D &nd_table[0];
>
>      object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
> -                             &error_abort);
> +                             &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->u_cpus), true, "realized",
> -                             &error_abort);
> +                             &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      /*
>       * The cluster must be realized after the RISC-V hart array containe=
r,
>       * as the container's CPU object is only created on realize, and the
> @@ -518,9 +526,17 @@ static void riscv_sifive_u_soc_realize(DeviceState *=
dev, Error **errp)
>       * cluster is realized.
>       */
>      object_property_set_bool(OBJECT(&s->e_cluster), true, "realized",
> -                             &error_abort);
> +                             &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
> -                             &error_abort);
> +                             &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>
>      /* create PLIC hart topology configuration string */
>      plic_hart_config_len =3D (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
> --
> 2.21.1
>
>

