Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3B9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB7E20715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyUO8t6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB7E20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSpj-0002mJ-MY
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXSnm-0001N1-JR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXSnk-000433-Ul
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:25:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXSnk-00042n-RQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574267155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwEoHJoG+l4SNOgZJD5gdpz2dPJF6TN8SpJk93ofdj4=;
 b=NyUO8t6eWblg0u5InZ2N8hLJr1fjjR+czakCMuyTFPX3HcMtrDLiaxw7AVAOa/HzRQ7x2H
 1FcAKoSBrzEa9zh03ixnuMIoq0kQLemE9krsVcAXweyYCS0uoow4q0nFGjfkfurgkvSZ8j
 ZU/nQVm8OmnTYf1fWNzAigQVLeW8PCw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361--t8AjOECO9mcPpKOjaC4Lw-1; Wed, 20 Nov 2019 11:25:52 -0500
Received: by mail-wm1-f70.google.com with SMTP id d140so3139752wmd.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i9l5BqjLUUMCBOLMcLu21WjsMNZp/sJLPl5FzacZQyI=;
 b=WiGuBvwCCXV+uo42ooigm1+Uj8+l9l7fnzhPfQV1OJfy+Sf+DxC1itaia5uVlf9LUO
 sEb03YXGco0+Mmf2No7mDMLUK0JRWKIktCpkCZUxMsDMmr8twEFbwqUuoj5ujdCEdy2k
 R04jMzAQng+rl+hwtLXLlexGwRdZzSiswTeCdU8y7uOebFe2jby5OmUK4MGw8aDMqpRU
 eTyrGm6tBqvaObF4tqYVhw4Sm2Q3qWEAbZpgNycRBEZ/PeKkxyybgp896y48Er4v0iOl
 xQ8wFx7NfyguojHco6LKVIpIDlm/pNuv/Iqf1jm6zyTo2ivBwUNGD5K2IyOaYA9EenPW
 Hvbw==
X-Gm-Message-State: APjAAAWj8HKqCzpnSYYlgyJb9KoaDGG6NZ1ngegCCerBKpV3wEDR7Ewz
 StOtLDhamAAWMCnk9T8g9+L+VY3bTjKgGnMg8TUGviOPZQchq8N3ldUzPBnFdhIOymk/AfTmKc0
 XmhuelhhicSs709Y=
X-Received: by 2002:a5d:570a:: with SMTP id a10mr4356246wrv.107.1574267149638; 
 Wed, 20 Nov 2019 08:25:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqymVsTsCtWl8BQZe82IAslvBvxKGs3d5gte32wxkuaxv55paWa1Jsym/HDBFbyZe2IY9aTXKg==
X-Received: by 2002:a5d:570a:: with SMTP id a10mr4356225wrv.107.1574267149442; 
 Wed, 20 Nov 2019 08:25:49 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id y8sm6827871wmi.9.2019.11.20.08.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:25:48 -0800 (PST)
Subject: Re: [PATCH v4 28/37] qdev: use g_strcmp0() instead of open-coding it
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-29-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6506012-cbae-bbf0-a373-398635f98692@redhat.com>
Date: Wed, 20 Nov 2019 17:25:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-29-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: -t8AjOECO9mcPpKOjaC4Lw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Minor code simplification.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/qdev.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index cf1ba28fe3..c79befc865 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -394,11 +394,8 @@ static NamedGPIOList *qdev_get_named_gpio_list(Devic=
eState *dev,
>       NamedGPIOList *ngl;
>  =20
>       QLIST_FOREACH(ngl, &dev->gpios, node) {
> -        /* NULL is a valid and matchable name, otherwise do a normal
> -         * strcmp match.
> -         */
> -        if ((!ngl->name && !name) ||
> -                (name && ngl->name && strcmp(name, ngl->name) =3D=3D 0))=
 {
> +        /* NULL is a valid and matchable name. */
> +        if (g_strcmp0(name, ngl->name) =3D=3D 0) {

Cocci pattern?

>               return ngl;
>           }
>       }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


