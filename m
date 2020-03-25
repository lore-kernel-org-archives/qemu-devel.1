Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEF1C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDFE2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io3iPucT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDFE2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4yU-0001ag-1x
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jH4xq-00012k-Js
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jH4xo-0002S4-F7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:16:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30099)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jH4xo-0002Rw-Cd
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585138612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bmV4sOT4NhvGdk2GId5YJPBewxX0veeluic1lE0Lp4=;
 b=io3iPucT8kJ1U1WMLDKf0XMOjQ3Xx3LG95vivubcvnhWFzMoFOGXFTlLBKkSs7L6CE7R79
 ILQqxoPPYOrBjIhbEbxiWxMxblLg+O3LAz8DGNbc23SxGwvntGyJZxs9zw55ZHh4XESe0S
 mBjIlAeo8FzOP/jhZZV7MHUQT66WgpM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-YqJdSULBMtO1v_X-ZSlgSg-1; Wed, 25 Mar 2020 08:16:48 -0400
X-MC-Unique: YqJdSULBMtO1v_X-ZSlgSg-1
Received: by mail-ed1-f69.google.com with SMTP id b9so1958282edj.10
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 05:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OXZj8wxpd2CuQfdgX57NxDBKGqs4ewvXpGZHiKXxXh4=;
 b=ddXENL3YUBQiEIvDUAvQJ4vY9pBmvp7Cuz9ue4U8J76FYnjCh/okCbMJY73Q/ZcUOk
 pYsXko7i51+SbWuFWAyZ8TXXMRh/urxrFgvq4PGz3OOS9MDh86padcy4ZWUDgjfvAZ0i
 BFqCooXu2fy2mRrV0odo2ozAZoo9Ub13y12UJCQE0YUfIpJzYdK7haalGG5aeOZlKspS
 rs3oy6Oc9cDFDM365bY1hsbQQq+lhPVMhxqpyadJriDlCduqvC/XJ4Djf4jlpCQ4MpRG
 s6DVWiofnyrqL7gwZHXXXbLC5JVkAjrTW+5Y66mK+mt3EVFd67lkg+Oo40kGguupW5RH
 /IMA==
X-Gm-Message-State: ANhLgQ38txf5/F8JcpxgVddG2bUAccA+/orOSf5WEtx6GmkVnqScc8Lk
 2Ix/Yt8ZaAn7hSxfx/vwMWgLln07Axp3vkJhlNipQPm+tGjmGR9tMm3ViMoaaVZZRJXXIC1hU7/
 DuwCuUHXJ4kO7pgQ=
X-Received: by 2002:a05:6402:110a:: with SMTP id
 u10mr2579251edv.159.1585138607120; 
 Wed, 25 Mar 2020 05:16:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvq2c9xFGvMYiatVInceDNNvVPZtpdNdQR5Ck12cwAexER9ALjtc8Np7K7nlJYKf+Qd0TG13g==
X-Received: by 2002:a05:6402:110a:: with SMTP id
 u10mr2579224edv.159.1585138606836; 
 Wed, 25 Mar 2020 05:16:46 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id v13sm847252edj.62.2020.03.25.05.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 05:16:46 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] timer/exynos4210_mct: Remove redundant statement
 in exynos4210_mct_write()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
 <20200325025919.21316-4-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab8c91a3-46dd-255d-9eb4-5013a7b598cc@redhat.com>
Date: Wed, 25 Mar 2020 13:16:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325025919.21316-4-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Euler Robot <euler.robot@huawei.com>,
 zhang.zhanghailiang@huawei.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 3:59 AM, Chen Qun wrote:
> Clang static code analyzer show warning:
> hw/timer/exynos4210_mct.c:1370:9: warning: Value stored to 'index' is nev=
er read
>          index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>          ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/timer/exynos4210_mct.c:1399:9: warning: Value stored to 'index' is nev=
er read
>          index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>          ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/timer/exynos4210_mct.c:1441:9: warning: Value stored to 'index' is nev=
er read
>          index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>          ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/exynos4210_mct.c | 4 ----
>   1 file changed, 4 deletions(-)
>=20
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index 944120aea5..570cf7075b 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -1367,7 +1367,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
>  =20
>       case L0_TCNTB: case L1_TCNTB:
>           lt_i =3D GET_L_TIMER_IDX(offset);
> -        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>  =20
>           /*
>            * TCNTB is updated to internal register only after CNT expired=
.
> @@ -1396,7 +1395,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
>  =20
>       case L0_ICNTB: case L1_ICNTB:
>           lt_i =3D GET_L_TIMER_IDX(offset);
> -        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>  =20
>           s->l_timer[lt_i].reg.wstat |=3D L_WSTAT_ICNTB_WRITE;
>           s->l_timer[lt_i].reg.cnt[L_REG_CNT_ICNTB] =3D value &
> @@ -1438,8 +1436,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
>  =20
>       case L0_FRCNTB: case L1_FRCNTB:
>           lt_i =3D GET_L_TIMER_IDX(offset);
> -        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
> -
>           DPRINTF("local timer[%d] FRCNTB write %llx\n", lt_i, value);
>  =20
>           s->l_timer[lt_i].reg.wstat |=3D L_WSTAT_FRCCNTB_WRITE;
>=20


