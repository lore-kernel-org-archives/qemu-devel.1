Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1EEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D63217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLv1VY+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D63217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYDQ-000609-G0
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itY6z-0007CK-OU
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itY6w-0005Sh-7N
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:33:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itY6w-0005SO-3Y
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579530781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiuR/TBKSn7iq3zXfA4rwRILcghA5F0tmB02QQDWD0U=;
 b=MLv1VY+3ffsuS44g7LNafM/PEHT82zTH9ff3hFLDyM7LyhZoOwmRYqetyK0m7xHh/oa1T+
 YrXAL6l3SYlPLctrzzskcuPsGi6uNxNCfBmxAW0QdEGid3mO8FX6eIGupCgjuIy7TuMEHw
 J9KmMVaTH/svTM0BgpRDK83P98RP/4Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Cspg97ZSP06ikO_BwX7xVA-1; Mon, 20 Jan 2020 09:33:00 -0500
Received: by mail-wm1-f72.google.com with SMTP id f25so3767335wmb.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uCsbDigzTt6RW4fnGOjgxkWaT/i208m4Os41PawKEKY=;
 b=qLNfOipVMo9JRPf0M1cxGsXhv+hZRKKCIqR9lI/+3IjDH6g/pXKpc9cOsaRnIiOwc7
 393b7e7YZ9NiIE5kB3+vYHX0IEoIW8pNdGrFr5tTU8Mlom3RTmlMKWxtR6DcS3BXp4Xr
 R/1495lJd9PAVmW7vKD4nNp831p4LiJtLnco3Mj7YZUn6PCcx8qUop3tRWT0dFbYex9K
 r3dX1Tpq57RmTeFhgRtKamKEUmMMe/+GU2ZiWTMXijUEUGQJVFQrCsuENbTuKl+bzCpw
 8WfXtxPI/uVch/g6ZOr7EIPC+Cf6sjfm/EwJDlhTMP+jXFdkbpBokjwolfFRIfSrcnRR
 X0/g==
X-Gm-Message-State: APjAAAU28//rcNVyUHHHzTd2ocoZ1Dt/VSw4mvTl2NAMVwos+lraEFv5
 LiF/a0261WUwyNJylfbjw8B15db1eTkSq6ILJSzNctCAQlzc3ohlf1C/5RnFMSi7/PYjvRh7+oA
 mzSW3x05UC5aCNK0=
X-Received: by 2002:a7b:c151:: with SMTP id z17mr19595454wmi.137.1579530778741; 
 Mon, 20 Jan 2020 06:32:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/jWOkwEundbpdIRMcJVDS0I1yPkDwpYNZpAZmMSX6hU6Npd9PWqn4Jr4FBxtRhtQONi6Usw==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr19595434wmi.137.1579530778450; 
 Mon, 20 Jan 2020 06:32:58 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z124sm25648866wmc.20.2020.01.20.06.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 06:32:57 -0800 (PST)
Subject: Re: [PATCH] hw/core/or-irq: Fix incorrect assert forbidding num-lines
 == MAX_OR_LINES
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200120142235.10432-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b6db7d21-684d-5ccc-8df0-ce83d00c98bd@redhat.com>
Date: Mon, 20 Jan 2020 15:32:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120142235.10432-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: Cspg97ZSP06ikO_BwX7xVA-1
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
Cc: Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 3:22 PM, Peter Maydell wrote:
> The num-lines property of the TYPE_OR_GATE device sets the number
> of input lines it has. An assert() in or_irq_realize() restricts
> this to the maximum supported by the implementation. However we
> got the condition in the assert wrong: it should be using <=3D,
> because num-lines =3D=3D MAX_OR_LINES is permitted, and means that
> all entries from 0 to MAX_OR_LINES-1 in the s->levels[] array
> are used.
>=20
> We didn't notice this previously because no user has so far
> needed that many input lines.
>=20
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/or-irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
> index 18d63831cd3..2be18333811 100644
> --- a/hw/core/or-irq.c
> +++ b/hw/core/or-irq.c
> @@ -58,7 +58,7 @@ static void or_irq_realize(DeviceState *dev, Error **er=
rp)
>   {
>       qemu_or_irq *s =3D OR_IRQ(dev);
>  =20
> -    assert(s->num_lines < MAX_OR_LINES);
> +    assert(s->num_lines <=3D MAX_OR_LINES);
>  =20
>       qdev_init_gpio_in(dev, or_irq_handler, s->num_lines);
>   }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


