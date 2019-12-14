Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E15C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2708D20706
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJPJXJ6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2708D20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igF3R-0001K8-20
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igF2N-0000hB-Co
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igF2L-0000ab-RE
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:33:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igF2L-0000Xh-KT
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576359196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j391IjHgHROzkHgnJCfJ5wR1IbqoOXKF1PaqlJJLd1Q=;
 b=RJPJXJ6GaLh1TQSII0bLv9/le5JG+GPFg+AhqXlhvovjr/fk2qosrFc6vqlLwMSXRP5K6Q
 xvGHBJKXxBgCDgqFb40/DLpJ3JTcKiR5Ia9Tyhfk6sSs3N1Tkpg5fwKafZ1hjYNt5iiPqW
 qsJwbI5KKo8jzddREk+9YMU0Bmko9gg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-6rsyQethO-6Tmsa177MbBg-1; Sat, 14 Dec 2019 08:31:20 -0500
Received: by mail-wr1-f69.google.com with SMTP id k18so992598wrw.9
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dbnDEi0BpLH0r2hJNyawre/pcgsgwRWyYuY/TK+FmcI=;
 b=Xrb2bBiKBE5LCVnYHpwGlnBAYFBKfqdCgvJWAk2SnCy4ILuRl12DGFrCZavjPJbgBU
 2Oh0JkMCgaXkRAj6JZARRryCwJdzEM11EFDAGY2jWVztWkoHaX6nxcqlBUxF37nmeppR
 YsfhKJZxa8RVg6Og/R8EBnl4AOBSPmu/wZCYCQkflZamkY2muN/We+nFXhddwWaQEieH
 sQ3CnKgzEpXaCG4zU4zaMY3WGJwHt0qTkm4iGB1jPPl/r5dg3GkRfiDK+DCj251KC/Wp
 RjxQq0ru/L55UJu/gmXO/9yhWdgUpkAnhYov5R+N/H+JuhDBT5nFhXgjAAzbCHx55kHF
 kHEg==
X-Gm-Message-State: APjAAAUMQvEKz+8RC2XhUj+A9pJKz3Dcm9E6dWhWj9L5wer3I41wZa5b
 z6DtZTaUWRA1KrlL7b4OcfkyRvoInfzdjDJWjPHCLkvR65lw56K37XTC6Rn550/gn25jZAs3np6
 K6ycT5GBz6n5HuoU=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr17852414wrr.32.1576330279088; 
 Sat, 14 Dec 2019 05:31:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqygzCiTLYn6SquoqAJ/zHMrrkSbn7s4Zsk3VV9XVjZcrpZl4J8pDDFTDySqkq8ZoYamj2CIiA==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr17852396wrr.32.1576330278853; 
 Sat, 14 Dec 2019 05:31:18 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id z6sm14585135wrw.36.2019.12.14.05.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:31:18 -0800 (PST)
Subject: Re: [PATCH 06/10] dp8393x: Clear RRRA command register bit only when
 appropriate
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <d3fdb6ca3fa26e495dd89136ee7f06cd94d1f0f7.1576286757.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <90fa4646-d7ed-2187-8d04-171be99ee7ab@redhat.com>
Date: Sat, 14 Dec 2019 14:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d3fdb6ca3fa26e495dd89136ee7f06cd94d1f0f7.1576286757.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: 6rsyQethO-6Tmsa177MbBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Herve Poussineau <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/14/19 2:25 AM, Finn Thain wrote:
> It doesn't make sense to clear the command register bit unless the
> command was actually issued.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/net/dp8393x.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 494deb42bf..3fdc6cc6f9 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -337,9 +337,6 @@ static void dp8393x_do_read_rra(dp8393xState *s)
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_RBE;
>           dp8393x_update_irq(s);
>       }
> -
> -    /* Done */
> -    s->regs[SONIC_CR] &=3D ~SONIC_CR_RRRA;
>   }
>  =20
>   static void dp8393x_do_software_reset(dp8393xState *s)
> @@ -548,8 +545,10 @@ static void dp8393x_do_command(dp8393xState *s, uint=
16_t command)
>           dp8393x_do_start_timer(s);
>       if (command & SONIC_CR_RST)
>           dp8393x_do_software_reset(s);
> -    if (command & SONIC_CR_RRRA)
> +    if (command & SONIC_CR_RRRA) {
>           dp8393x_do_read_rra(s);
> +        s->regs[SONIC_CR] &=3D ~SONIC_CR_RRRA;
> +    }
>       if (command & SONIC_CR_LCAM)
>           dp8393x_do_load_cam(s);
>   }
>=20


