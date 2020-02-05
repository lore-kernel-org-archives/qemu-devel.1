Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A00AC352A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B10217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMNfApFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B10217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKUG-0005v1-AH
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izKRl-0004E4-77
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izKRk-0002QW-2j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45556
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izKRj-0002NQ-UB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580908222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdVsCmfWYLq3X9BXHiwnkxB/k4srKjQEvuOIb3gBTJE=;
 b=QMNfApFBaO6JxHvGoGIIvWTNO4WAaCsWnq0aZFqt6iMGN/uGWzmcWGPZVBqnp6H9OQ95/d
 lnp5MECcxNWn2zzNJGjHcsw7qzGLrBxmB+d+y/zAfep2yFe7GAh40w6kaUMSrZcLF9KFNz
 3we400MF/2PfJMbjxv7RJc11kf5R8Vo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-uH2CJWIiN0Cc9cqyp3OTaw-1; Wed, 05 Feb 2020 08:10:20 -0500
Received: by mail-wr1-f70.google.com with SMTP id j4so1157874wrs.13
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 05:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=svyYRmjP0AjXWveCuPG76++AZlWwHFiM6YQLm1BvpMg=;
 b=tqDo4xRRFV45/NseuajDcN/7UBq9ELSlciOAGfS/HpJziewj3N+bYTJRaL6pfIqpp8
 BUsarSx/u936tUVC9ioRmTJ5GfAyI8DE+yGO9Db02WrrmuM61MrV8DrrwyqhCCFcahW9
 f2GFeoG8GcYM05HTaoqGZf4TRTzEHyOuiN7QDvN0zIOiTMh+ZbZUinrPXv5RjT+beM5/
 AgfATQ7hgyoJ6D+VD8+dtDOsVerh0MicFah+bt33iL/rG/z2dfwoZjGFZzROqF4bsl33
 yDSaW7AXFeeQyNDlMxNoU3D1LvQBgc+IKMWXAc5rV6lzraaDjLH7f7fQrJCWmL7R2rbh
 BapA==
X-Gm-Message-State: APjAAAUIpQHk0LUwZpYE9VgZht409aAxZ5W9L9628kFLWhkGFSpYHMzy
 ES5yywIXUNrh4k5LlNU4tiyyVV4dNr/eMG3HN5MtuOkouaG3s92/MAHpajP3oZUIkSPmOpnx8n/
 eE4L0w41b8IHdDe0=
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr5903026wmh.174.1580908219540; 
 Wed, 05 Feb 2020 05:10:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwu/sIdXCm/OtyGRcfvk1ZbpWz4EU2hAyh/YTnLVCRl3D4QhrAH+/n5rlA/mA8XlzquXkC/Kw==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr5903002wmh.174.1580908219312; 
 Wed, 05 Feb 2020 05:10:19 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id e17sm7909165wma.12.2020.02.05.05.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 05:10:18 -0800 (PST)
Subject: Re: [PATCH 3/3] stellaris: delay timer_new to avoid memleaks
To: pannengyuan@huawei.com, peter.maydell@linaro.org
References: <20200205070659.22488-1-pannengyuan@huawei.com>
 <20200205070659.22488-4-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71c5dc35-d2f2-6a7e-dde3-408fc24bb425@redhat.com>
Date: Wed, 5 Feb 2020 14:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205070659.22488-4-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: uH2CJWIiN0Cc9cqyp3OTaw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhang.zhanghailiang@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 8:06 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> There is a memory leak when we call 'device_list_properties' with typenam=
e =3D stellaris-gptm. It's easy to reproduce as follow:
>=20
>    virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-prop=
erties", "arguments": {"typename": "stellaris-gptm"}}'
>=20
> This patch delay timer_new in realize to fix it.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Cc: qemu-arm@nongnu.org
> ---
>   hw/arm/stellaris.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index bb025e0bd0..221a78674e 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -347,11 +347,15 @@ static void stellaris_gptm_init(Object *obj)
>       sysbus_init_mmio(sbd, &s->iomem);
>  =20
>       s->opaque[0] =3D s->opaque[1] =3D s;
> +}
> +
> +static void stellaris_gptm_realize(DeviceState *dev, Error **errp)
> +{
> +    gptm_state *s =3D STELLARIS_GPTM(dev);
>       s->timer[0] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, gptm_tick, &s->opa=
que[0]);
>       s->timer[1] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, gptm_tick, &s->opa=
que[1]);
>   }
>  =20
> -
>   /* System controller.  */
>  =20
>   typedef struct {
> @@ -1536,6 +1540,7 @@ static void stellaris_gptm_class_init(ObjectClass *=
klass, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->vmsd =3D &vmstate_stellaris_gptm;
> +    dc->realize =3D stellaris_gptm_realize;
>   }
>  =20
>   static const TypeInfo stellaris_gptm_info =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


