Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E930C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2485B20692
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7VeJP1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2485B20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7Wc-0005jc-BK
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7VD-0003V0-2Q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7VB-0006V4-VH
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:24:26 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:33052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7VB-0006Uo-RZ; Mon, 13 Apr 2020 18:24:25 -0400
Received: by mail-vs1-xe44.google.com with SMTP id a2so2408597vsd.0;
 Mon, 13 Apr 2020 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NfS+if34QaICcgQhFzQlQDHmzlQVRe47Rr7qXTiSLIk=;
 b=E7VeJP1anCexgCP9YAQnkh4bF9Hdp5i3OvXEPCKFXRqTj+8CCHpACQxAG4yEI9Du4N
 cO37BGaUunXddYyCo2w8xputvkC1/U4sB2Qy5fZKnIlUdEH7inGXS/wRS+j6PQ379Tax
 UPKI0+/SspkTcVJPrQvAKVj9SHWq2b28+zlGVd3KpL10YoFKH+Op/Fhup0ckGTodz6yN
 orOM1m+Y3+9Fi+TL9qrTxJ7UwPUpYYEPRhtNh9Bv9x8R2IXNViY6TzSJejRQlHIx6F+p
 EgyVkTcoLvfKlmF2F8LngUR93ntT3Q27aHaCiecvaQoXFV0e8yeJ4SdifXiFyWbNnLso
 LLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NfS+if34QaICcgQhFzQlQDHmzlQVRe47Rr7qXTiSLIk=;
 b=YZhvWLPeXYjGUaGrVFtaqt1XtxXk+iMeN6lARkGXsZU9QeHioCDLuPiK0EPN7xk3Qv
 wsBwiazh97yQYQlZNr+iV/1IC0SkYTZsjbsR/Qt5QUUo/g7tUmR11Fj2UsW7RthFffcC
 8WNYbfWrQF6z0l3H4+/m2qVUyFi0bIHE518N9ndzi0jCjGl5mYFKj8GGdilrRRjDKlmj
 yuVzPrkGHtSFDw+JlV5JQhBnW4DZBGywXit3jaECY3IlABxlOHkWjjUNhEmTn4mn5NpM
 NGlGT2Mv1cn6vEUcNzn+BKgDzLQqBj2uXf9h5s9bVyO+X62fE+5cKdpgQxd3a+nYzvco
 MrTA==
X-Gm-Message-State: AGi0PuY/lXHPqj67k1OxG2h0QumA0Wo8mHatVF2eFHBPxUiW4YJwHBBs
 1/6+596peU5bdgxnU8YbkY8ogO4jicx2bxxwJDM=
X-Google-Smtp-Source: APiQypKgKxWyFo4yqSrAmkWLvZ0SKn9Jma1qzI6ftgYUq3rO9gqUDuWaEESvxj5wpADBS3Nul9g7JFliDihW6734ZwI=
X-Received: by 2002:a67:26c2:: with SMTP id
 m185mr14419055vsm.180.1586816665267; 
 Mon, 13 Apr 2020 15:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-22-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-22-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:16:09 -0700
Message-ID: <CAKmqyKM6PxaKUi7CL-WarfkF+t7OxNpYPEfjjCQ3yTSKRtzWUg@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 21/24] hw/riscv/sifive_u: Move some code from
 realize() to init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e44
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

On Sun, Apr 12, 2020 at 3:49 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Coccinelle reported:
>
>   $ spatch ... --timeout 60 --sp-file \
>     scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   HANDLING: ./hw/riscv/sifive_u.c
>   >>> possible moves from riscv_sifive_u_soc_init() to riscv_sifive_u_soc=
_realize() in ./hw/riscv/sifive_u.c:473
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
>  hw/riscv/sifive_u.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 9c90c94c33..754af19eef 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -441,6 +441,8 @@ static void riscv_sifive_u_soc_init(Object *obj)
>      qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
>      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
>                            TYPE_CADENCE_GEM);
> +    object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
> +                            &error_abort);
>  }
>
>  static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)
> @@ -569,8 +571,6 @@ static void riscv_sifive_u_soc_realize(DeviceState *d=
ev, Error **errp)
>          qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>          qdev_set_nic_properties(DEVICE(&s->gem), nd);
>      }
> -    object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
> -                            &error_abort);
>      object_property_set_bool(OBJECT(&s->gem), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> --
> 2.21.1
>
>

