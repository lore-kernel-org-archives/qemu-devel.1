Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7778C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20712072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iv2a/uzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20712072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLa4-0003FU-LZ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irLYg-0001u0-EB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irLYd-00078J-K5
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:44:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irLYd-00077z-Gx
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579005870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoV8XFb70US4wtfbY1n94Er2azORQJIzo99CIq35yg8=;
 b=iv2a/uznojkhxiSyxGSH/V1jbFTiAzqfweWYl+BUAKp3NtrYEuaMMKlO2Xx8uFEwP5fnjz
 m0hmjy1kcTHAsicunMFjdMQTeHuiA3sD8AphGIX2OZ56MahGGadbGtcHKvlst6anhVBjZf
 xKV27PHr+6ZXOOr7rZPWI71gm3q72VI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-RNWWUhjzOm6vq8QEr9feUw-1; Tue, 14 Jan 2020 07:44:28 -0500
Received: by mail-wm1-f69.google.com with SMTP id t4so3503742wmf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 04:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7j8CwUwkHJam8aVjm733nleoJ5Yw969ctuPEeETw7z4=;
 b=WiLGljxLT97urIFnYLQVNCQBbLoAqPplWp2+B/GA3pPvg+b3K4UQaCjm6AdoBqW5pu
 wDN7geM4BlQqZmquihkv34o7NOugp52+yD6rdno9/NuRZaydROUDVDYSSZeFnO2euws1
 zas0dE6hmUS/xncA7IZy+1qYvPxMi/Lg2Q4/YHVzSVP+CD9LUEI69+Wj8bkYdQfiZKqm
 LkYoFGROlKAr3J8eZKCDMTB7DGOmBf9m+BCju9q4qB4wCwQXzmxplUi0gBEQSmtzEu2v
 rClTMY4aiKNVru4KOUdbQeXY/9jqKOJoyQ/FECLBPIdq7vR+b9xD97d5+bYyOkkj5Bku
 HA3A==
X-Gm-Message-State: APjAAAWOosQ4XW8jrtrmp5T5TEIxdkV6rItZpW0ZTM2unqHwwd1xBvzI
 XZ5DZ34B7CeSw1sk7HmktSaL98QtAQ5dfu00o+GX1kqq/wD7+sJl9672KFdPzISeb8Zl80wolYb
 XlWVAY3G9iLV+jDE=
X-Received: by 2002:a1c:4857:: with SMTP id v84mr27888907wma.8.1579005867323; 
 Tue, 14 Jan 2020 04:44:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzm7xmqsDRrXMqCEChulMqqQcND2uTklxttqvXkG4nn2i3NhBjwiOlFqUhjKjVXlSz6vIKRog==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr27888876wma.8.1579005867071; 
 Tue, 14 Jan 2020 04:44:27 -0800 (PST)
Received: from [10.0.1.197] (lfbn-mon-1-1103-34.w90-48.abo.wanadoo.fr.
 [90.48.206.34])
 by smtp.gmail.com with ESMTPSA id b137sm19520346wme.26.2020.01.14.04.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 04:44:26 -0800 (PST)
Subject: Re: [PATCH] target/arm: add PMU feature to cortex-r5 and cortex-r5f
To: Clement Deschamps <clement.deschamps@greensocs.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200114105918.2366370-1-clement.deschamps@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <03110090-dd50-b124-e60a-9cf136e8f7fd@redhat.com>
Date: Tue, 14 Jan 2020 13:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114105918.2366370-1-clement.deschamps@greensocs.com>
Content-Language: en-US
X-MC-Unique: RNWWUhjzOm6vq8QEr9feUw-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 11:59 AM, Clement Deschamps wrote:

Maybe describe here:

The PMU is not optional on cortex-r5 and cortex-r5f (see
the "Features" chapter of the Technical Reference Manual).

> Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
> See cortex-r5 TRM - 1.3 Features
>=20
> PMU is not optional on cortex-r5 and cortex-r5f
> ---
>   target/arm/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index d62fd5fdc6..64cd0a7d73 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2121,6 +2121,7 @@ static void cortex_r5_initfn(Object *obj)
>       set_feature(&cpu->env, ARM_FEATURE_V7);
>       set_feature(&cpu->env, ARM_FEATURE_V7MP);
>       set_feature(&cpu->env, ARM_FEATURE_PMSA);
> +    set_feature(&cpu->env, ARM_FEATURE_PMU);
>       cpu->midr =3D 0x411fc153; /* r1p3 */
>       cpu->id_pfr0 =3D 0x0131;
>       cpu->id_pfr1 =3D 0x001;
>=20


