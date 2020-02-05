Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498D2C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F620217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8J2DBUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F620217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKZq-0001Cn-8F
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izKYj-0000Fc-Jj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izKYh-0006Qg-Nh
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:17:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izKYh-0006KC-1P
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580908654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvLLe8yBaYZcl+G2yAPUEN1Kqr9GEEPddP+xnkcoFyY=;
 b=Q8J2DBUeiLs8MrEECo0Dg7ITLoCkv9qDEZvg9i2wC/l50yfKo1jw7s082P5K+jjhxxQOep
 rIo8bsACM7s0RyM9asBxRQFNafA3kQgNlySXo0ONIhvHerItKtDMI5YKZuYK3DZa9GkrmE
 dOyvYCaWpxXy2TK4Zct5T2Fqe7DXpgU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-rup4OPNiNQK2_iZ4QO1jTA-1; Wed, 05 Feb 2020 08:17:32 -0500
Received: by mail-wr1-f72.google.com with SMTP id f10so1168869wro.14
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 05:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8n5FCvmEl/OYgLTN+qMrZJr3PeEu3pFsGPavXoTEYKw=;
 b=M6XuHsU3atniRq4CK7YiIAQa9pvUZhdUCzu9Q2YMDhRjiKYGmUXxv+kbF9DM3lWMB4
 oUEFN/9+bSbOhrXR5TuBeE2n7sMdFOQnJ7k5v/aOKivqQfeacGv9PIi33Wm7KVZXZZ2+
 66VQvpsYx1m6zqqXTxKEgSS262mESFwTxtC5jkZjt6md3OkN4ar/OPiRLlX+oCN3Sxcg
 07kkvbD6YjFfm5n+YgttOPgim7D4U90pf+ZNrXo1qE99+fhLIk1G0khN5D4afxFOv/fd
 vb/qQzP7cOdXhXI8j0ZEuIWRoVQNrLKKXobZDbmjjLzaun4Uqwi3Pns8LFQjVPQPMu2k
 l5HQ==
X-Gm-Message-State: APjAAAXyRCDftxlzHaJRppbmyibM+zlTTB82xMm16h9JnBeBuqxwli6O
 XGTlaBugJgsjrC1oWLGr0cACGFLLS0g+eupIlDm6r6xPuV1/uzwasCymp/uVwpI1t6Mb0zeETXQ
 XoU68/6Mkwgb3TRs=
X-Received: by 2002:adf:f986:: with SMTP id f6mr25432660wrr.182.1580908651061; 
 Wed, 05 Feb 2020 05:17:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBN+etAzAf0SFmelx1W1T5ZMFdbrh8XEfNurMRfdgaAEcobvcx/Z7pm/SUIubod3HrK11Pzw==
X-Received: by 2002:adf:f986:: with SMTP id f6mr25432642wrr.182.1580908650884; 
 Wed, 05 Feb 2020 05:17:30 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id f1sm34872022wro.85.2020.02.05.05.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 05:17:30 -0800 (PST)
Subject: Re: [PATCH 2/3] stm32f2xx_timer: delay timer_new to avoid memleaks
To: pannengyuan@huawei.com, peter.maydell@linaro.org
References: <20200205070659.22488-1-pannengyuan@huawei.com>
 <20200205070659.22488-3-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <80b6d1cb-f711-1fac-c6b4-7a60b7c9e0a0@redhat.com>
Date: Wed, 5 Feb 2020 14:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205070659.22488-3-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: rup4OPNiNQK2_iZ4QO1jTA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 8:06 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> There is a memory leak when we call 'device_list_properties' with typenam=
e =3D stm32f2xx_timer. It's easy to reproduce as follow:
>=20
>      virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-pr=
operties", "arguments": {"typename": "stm32f2xx_timer"}}'
>=20
> This patch delay timer_new to fix this memleaks.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> ---
>   hw/timer/stm32f2xx_timer.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index fb370ce0f0..06ec8a02c2 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -314,7 +314,11 @@ static void stm32f2xx_timer_init(Object *obj)
>       memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
>                             "stm32f2xx_timer", 0x400);
>       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
>  =20
> +static void stm32f2xx_timer_realize(DeviceState *dev, Error **errp)
> +{
> +    STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);
>       s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_inter=
rupt, s);
>   }
>  =20
> @@ -325,6 +329,7 @@ static void stm32f2xx_timer_class_init(ObjectClass *k=
lass, void *data)
>       dc->reset =3D stm32f2xx_timer_reset;
>       device_class_set_props(dc, stm32f2xx_timer_properties);
>       dc->vmsd =3D &vmstate_stm32f2xx_timer;
> +    dc->realize =3D stm32f2xx_timer_realize;
>   }
>  =20
>   static const TypeInfo stm32f2xx_timer_info =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


