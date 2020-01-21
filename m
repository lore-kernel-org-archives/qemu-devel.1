Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA3824125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2plpXL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA3824125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpFq-0004Ip-BG
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itpF0-0003ok-PQ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itpEw-0007s9-Gd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:50:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itpEw-0007rt-CB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579596625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjHPxg5qB8KbvaBa0oMco9NZs9Nm0MWWrx+PgSbqDhw=;
 b=f2plpXL6T8uJYYtpEpO6Xe2+gys6ztOQRt8CwCSKhK3w9O9R6ROFqnes945FcQIVjga4lP
 mKej34nDGnNCPqXoiEEH9MAe8+QlgFvyAEk6w/G+dlg6SbdotEq+5hrNU8RHTS9emfmiQx
 oaxjyHA8RaWMeVAQVIvbOy1mkFY9/Gk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-lr5QoUiAMzevxWsuyjP3nA-1; Tue, 21 Jan 2020 03:50:24 -0500
Received: by mail-wm1-f70.google.com with SMTP id g26so215626wmk.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 00:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0ugJAjvR5ekoeAAftioBbAxnSs8SCfOCAgEIwawD2q0=;
 b=ucQbV2SigPxekYQkXnCuzGPKziW0DzTPivE4M35GI789JiZHtgKggGTiOK/0x9z6bc
 bkhU4lbTNUYc4gsOwA+j7YHMDNEotS8gjr6Ner557Vi+CP/NLj7OsnhXf9J9AMVsMXrb
 m4hmkb1MMA1iwAl6Tm7zKeBfNKw8wueQcVgXfLh78qJkflsnTF5Sw2vCe48Bl0m6w5VO
 YcUzECRryBNMzLMCU4zdjFyp2Ne8yRWero34mzLpjTxzA3LS8ny+3PYU5ArcczAI9izG
 tRfnSbTcrMDa3jYegZEp+1OejCXFshYihByotbzqvG/mSdd9AP7A5HWKV6mlBlGyWWa7
 vRvA==
X-Gm-Message-State: APjAAAV7206VT7Q/6qL6jFZ4AtPO9RDaVBkJ1pksRJEYXyQ3+1Nab6H8
 WH1KNSsRAYqZcIZx+wRZiulOLkIZki+G/7IGE2OyIqnU2yLuP6ifx8toWBkb56gEMOwCn9X4sg8
 bosadN6kbVcFJecc=
X-Received: by 2002:adf:ea42:: with SMTP id j2mr3832464wrn.270.1579596623135; 
 Tue, 21 Jan 2020 00:50:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVi+24ClPkCTLcJKkmrtd1fqJ0E8rH/guq89GE9zPjxoT/+QE+aNJDXLmqpLGY02FBoubR/g==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr3832421wrn.270.1579596622665; 
 Tue, 21 Jan 2020 00:50:22 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id p5sm49154069wrt.79.2020.01.21.00.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 00:50:22 -0800 (PST)
Subject: Re: [PATCH 1/2] aspeed/scu: Create separate write callbacks
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20200121013302.43839-1-joel@jms.id.au>
 <20200121013302.43839-2-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <acc9731a-9920-b2c4-94ff-7cc74810f0f2@redhat.com>
Date: Tue, 21 Jan 2020 09:50:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121013302.43839-2-joel@jms.id.au>
Content-Language: en-US
X-MC-Unique: lr5QoUiAMzevxWsuyjP3nA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/21/20 2:33 AM, Joel Stanley wrote:
> This splits the common write callback into separate ast2400 and ast2500
> implementations. This makes it clearer when implementing differing
> behaviour.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/misc/aspeed_scu.c | 80 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 57 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index f62fa25e3474..7108cad8c6a7 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -232,8 +232,47 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr=
 offset, unsigned size)
>       return s->regs[reg];
>   }
>  =20
> -static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
> -                             unsigned size)
> +static void aspeed_ast2400_scu_write(void *opaque, hwaddr offset,
> +                                     uint64_t data, unsigned size)
> +{
> +    AspeedSCUState *s =3D ASPEED_SCU(opaque);
> +    int reg =3D TO_REG(offset);
> +

I'd move the trace call here:

        trace_aspeed_scu_write(offset, size, data);

(we might be running with tracing enabled but not guest_errors).

Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    if (reg >=3D ASPEED_SCU_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRI=
x "\n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    if (reg > PROT_KEY && reg < CPU2_BASE_SEG1 &&
> +            !s->regs[PROT_KEY]) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__)=
;
> +    }
> +
> +    trace_aspeed_scu_write(offset, size, data);
> +
> +    switch (reg) {
> +    case PROT_KEY:
> +        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
> +        return;
> +    case SILICON_REV:
> +    case FREQ_CNTR_EVAL:
> +    case VGA_SCRATCH1 ... VGA_SCRATCH8:
> +    case RNG_DATA:
> +    case FREE_CNTR4:
> +    case FREE_CNTR4_EXT:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Write to read-only offset 0x%" HWADDR_PRIx "\=
n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    s->regs[reg] =3D data;
> +}
> +
> +static void aspeed_ast2500_scu_write(void *opaque, hwaddr offset,
> +                                     uint64_t data, unsigned size)
>   {
>       AspeedSCUState *s =3D ASPEED_SCU(opaque);
>       int reg =3D TO_REG(offset);
> @@ -257,25 +296,11 @@ static void aspeed_scu_write(void *opaque, hwaddr o=
ffset, uint64_t data,
>       case PROT_KEY:
>           s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
>           return;
> -    case CLK_SEL:
> -        s->regs[reg] =3D data;
> -        break;
>       case HW_STRAP1:
> -        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
> -            s->regs[HW_STRAP1] |=3D data;
> -            return;
> -        }
> -        /* Jump to assignment below */
> -        break;
> +        s->regs[HW_STRAP1] |=3D data;
> +        return;
>       case SILICON_REV:
> -        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
> -            s->regs[HW_STRAP1] &=3D ~data;
> -        } else {
> -            qemu_log_mask(LOG_GUEST_ERROR,
> -                          "%s: Write to read-only offset 0x%" HWADDR_PRI=
x "\n",
> -                          __func__, offset);
> -        }
> -        /* Avoid assignment below, we've handled everything */
> +        s->regs[HW_STRAP1] &=3D ~data;
>           return;
>       case FREQ_CNTR_EVAL:
>       case VGA_SCRATCH1 ... VGA_SCRATCH8:
> @@ -291,9 +316,18 @@ static void aspeed_scu_write(void *opaque, hwaddr of=
fset, uint64_t data,
>       s->regs[reg] =3D data;
>   }
>  =20
> -static const MemoryRegionOps aspeed_scu_ops =3D {
> +static const MemoryRegionOps aspeed_ast2400_scu_ops =3D {
> +    .read =3D aspeed_scu_read,
> +    .write =3D aspeed_ast2400_scu_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +    .valid.unaligned =3D false,
> +};
> +
> +static const MemoryRegionOps aspeed_ast2500_scu_ops =3D {
>       .read =3D aspeed_scu_read,
> -    .write =3D aspeed_scu_write,
> +    .write =3D aspeed_ast2500_scu_write,
>       .endianness =3D DEVICE_LITTLE_ENDIAN,
>       .valid.min_access_size =3D 4,
>       .valid.max_access_size =3D 4,
> @@ -469,7 +503,7 @@ static void aspeed_2400_scu_class_init(ObjectClass *k=
lass, void *data)
>       asc->calc_hpll =3D aspeed_2400_scu_calc_hpll;
>       asc->apb_divider =3D 2;
>       asc->nr_regs =3D ASPEED_SCU_NR_REGS;
> -    asc->ops =3D &aspeed_scu_ops;
> +    asc->ops =3D &aspeed_ast2400_scu_ops;
>   }
>  =20
>   static const TypeInfo aspeed_2400_scu_info =3D {
> @@ -489,7 +523,7 @@ static void aspeed_2500_scu_class_init(ObjectClass *k=
lass, void *data)
>       asc->calc_hpll =3D aspeed_2500_scu_calc_hpll;
>       asc->apb_divider =3D 4;
>       asc->nr_regs =3D ASPEED_SCU_NR_REGS;
> -    asc->ops =3D &aspeed_scu_ops;
> +    asc->ops =3D &aspeed_ast2500_scu_ops;
>   }
>  =20
>   static const TypeInfo aspeed_2500_scu_info =3D {
>=20


