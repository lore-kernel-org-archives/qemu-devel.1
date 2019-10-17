Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B753AFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EDB20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1cEHYG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EDB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7e7-0006bp-IG
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL6qS-0000yb-GH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL6qR-0005gr-1x
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:33:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL6qQ-0005gO-R3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571322817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DN0b5UKbUanEX/TRvsJ4e4lLM4dURX19s46UiOAC/s=;
 b=P1cEHYG5/cNqFDyFo+GYpQNtwiqx9C1Gd8HIDvop65MP5Xz3qf2/6NhtmPXQ2uskQJBrXD
 u7fDtCsY7QN+ODaVh9hjSkScnZfmLi8sKu0pCd2MGcErJ8QWKSSTBZV3xyPeHG21h+Zp+a
 BKbz8O9/WUe/uKvcw0pTe36m0AI75r8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183--58yd14sN_qooLXVsA5yAQ-1; Thu, 17 Oct 2019 10:33:36 -0400
Received: by mail-wr1-f72.google.com with SMTP id k4so1066593wru.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=brJm6Hpaai1XMyXMQedvlncKTY5kxTaja0y7tcfRAeE=;
 b=cgxPpPLN6mOgqJyykIRAmpaxeLAMjVs4YyhxHeWYF/jBZGjFfWUbHJFoQYW17rsNPO
 NhfV9JE5Cj0yTKyGP4gNHDD5MhTAlBh47dOjnxs2otLyDZSHi8XvAHB2fBEmYgjIgFLk
 ozjIcKFaykfW8RQiN7+51GD/lG+VUVUI8xwt0N15UznsqJaJMVKU6yNPrI/5fmkbYGSb
 svLWLEmEIj3LMoYP41YyLhzHpW7LR2cya0WWTub7nDJKz0M9ZUpi3vKICha/PV+ayVgF
 bWXXhXovFDuLTto7D+oKk2NBZsbP0PVTRH7un1+XQG9WmbgJ5xhJnxYe7DlE8oisMOG8
 U6KA==
X-Gm-Message-State: APjAAAUpBd2oMsdhE1NeJhtRivOythE/n3zN2coICPqu2ttghA5qD7Hp
 hjpqCoFnLvyeS7Il68eLfjq4aM2tgILvAhT5nNrYFiA5OUiUy/1vuM0GVLkj1/fYP85aqjRX9KQ
 EPqdeCb2uPf0ZWTk=
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr3485973wrq.227.1571322815109; 
 Thu, 17 Oct 2019 07:33:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4sU+jGXD0TSPzf+6vLvW7Nd6FtdJ31Ji9ZvfM0y+IsJRYySTfUIrpCeUOZXp5gSboXwIv8A==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr3485940wrq.227.1571322814596; 
 Thu, 17 Oct 2019 07:33:34 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id f18sm2386846wrv.38.2019.10.17.07.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:33:34 -0700 (PDT)
Subject: Re: [PATCH] hw/timer/arm_mptimer.c: Undo accidental rename of
 arm_mptimer_init()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191017133331.5901-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9263235-7786-2e24-943c-32626f00dd75@redhat.com>
Date: Thu, 17 Oct 2019 16:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017133331.5901-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: -58yd14sN_qooLXVsA5yAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 3:33 PM, Peter Maydell wrote:
> In commit b01422622b we did an automated rename of the ptimer_init()
> function to ptimer_init_with_bh().  Unfortunately this caught the
> unrelated arm_mptimer_init() function.  Undo that accidental
> renaming.
>=20
> Fixes: b01422622b7c7293196fdaf1dbb4f495af44ecf9
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/timer/arm_mptimer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
> index fdf97d1800f..2bf11f788c3 100644
> --- a/hw/timer/arm_mptimer.c
> +++ b/hw/timer/arm_mptimer.c
> @@ -237,7 +237,7 @@ static void arm_mptimer_reset(DeviceState *dev)
>       }
>   }
>  =20
> -static void arm_mptimer_init_with_bh(Object *obj)
> +static void arm_mptimer_init(Object *obj)
>   {
>       ARMMPTimerState *s =3D ARM_MPTIMER(obj);
>  =20
> @@ -319,7 +319,7 @@ static const TypeInfo arm_mptimer_info =3D {
>       .name          =3D TYPE_ARM_MPTIMER,
>       .parent        =3D TYPE_SYS_BUS_DEVICE,
>       .instance_size =3D sizeof(ARMMPTimerState),
> -    .instance_init =3D arm_mptimer_init_with_bh,
> +    .instance_init =3D arm_mptimer_init,
>       .class_init    =3D arm_mptimer_class_init,
>   };
>  =20
>=20


