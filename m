Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2354DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E251120716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtQSt9LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E251120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqMQ-0006Mv-5o
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwqLd-0005qk-4v
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwqLb-00029n-Qb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:37:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwqLb-00029T-Mu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580315867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4UFEH86N/uafquosBTDEDwxHkWjiO59N9KWu1pZEDI=;
 b=ZtQSt9LXZ68s7ilP9KOamM8EAtt4G2kuVJtIUDvMsmRkQLuHqrFR6v7zeHRMrtlct3Sz7y
 izRC50nCbRvx4j9t2b6W87gqHBjiIrX1aXuE31ICpAhn7Jfl3gj49Yxf0ExaQspZYT9Jia
 1UCWXnvI429Ms988UpAE+9O7lH5YLBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-vAATwlLrP0K2okrD7gSflQ-1; Wed, 29 Jan 2020 11:37:44 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so65162wrm.23
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 08:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hHWQ6xd3BLKU6QJmQaalAerIn7acm+a2DiZl/A8Oy1w=;
 b=C+J8btiBfG3jK2eiaJtGkZtnic5VCGUC6Nv1XAuG5j27Pc9eJfYRZnctHi5iMiNbNk
 2xNGXDW5GPFIflZDoHZJmCz9C5QLffc6J9YZj4MIm4g76a9xT9mM9X6KdNYtG7IMqEwX
 5ODkI3jJuGUFCDoD97MKCapVtpLSCtnM9gKmwKBt2TvldR1+oryLhDSfkRgtFWJUXecn
 SmSscvc6OHpWsojf3IN4Hglx7/o+cWDj0q+VCWrCgMwKd9Z6RrEbLJ/xdfELARRccSFR
 8i2xl/bw7uhMY0Yv8o8mqSEnREyyiCso38op4dP6XlVDXZAM1lqnOhSyJvB2LCiNXSW7
 WjAA==
X-Gm-Message-State: APjAAAXS7T1KEoDLbAOc6/eDZLFXmuGeSYy5LqNLwz9+P390l7LedTS5
 8zOowtABny6Ugf+gH8hUFBR6tQnE/oXZI7tMr1xu2oI8QlWZYCog7yiV5O3s7gWZqeVmI7IAqS6
 wu331IRB9JXZxFBs=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr132335wmg.38.1580315863689; 
 Wed, 29 Jan 2020 08:37:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPU2g0paKkbMQ3k2K2qkiIVmOkgbHbxT2zDpnDk/MXmkz4XAfScc11mp0LkkjzKctZKSmSRA==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr132306wmg.38.1580315863373; 
 Wed, 29 Jan 2020 08:37:43 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id p15sm2770948wma.40.2020.01.29.08.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 08:37:42 -0800 (PST)
Subject: Re: [PATCH v4 13/14] dp8393x: Don't reset Silicon Revision register
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <61d9753b631e9071809cdd1bb8e12385aa06c83e.1580290069.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a25e9fd2-4d3b-318c-1da5-b1de1d349ac1@redhat.com>
Date: Wed, 29 Jan 2020 17:37:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <61d9753b631e9071809cdd1bb8e12385aa06c83e.1580290069.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: vAATwlLrP0K2okrD7gSflQ-1
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 10:27 AM, Finn Thain wrote:
> The jazzsonic driver in Linux uses the Silicon Revision register value
> to probe the chip. The driver fails unless the SR register contains 4.
> Unfortunately, reading this register in QEMU usually returns 0 because
> the s->regs[] array gets wiped after a software reset.
>=20
> Fixes: bd8f1ebce4 ("net/dp8393x: fix hardware reset")
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
> Changed since v3:
> - Simplified as per suggestion from Philippe Mathieu-Daud=C3=A9.
> ---
>   hw/net/dp8393x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 1b73a8703b..93eb07e6c8 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -919,6 +919,7 @@ static void dp8393x_reset(DeviceState *dev)
>       timer_del(s->watchdog);
>  =20
>       memset(s->regs, 0, sizeof(s->regs));
> +    s->regs[SONIC_SR] =3D 0x0004; /* only revision recognized by Linux/m=
ips */
>       s->regs[SONIC_CR] =3D SONIC_CR_RST | SONIC_CR_STP | SONIC_CR_RXDIS;
>       s->regs[SONIC_DCR] &=3D ~(SONIC_DCR_EXBUS | SONIC_DCR_LBR);
>       s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_LB0 | SONIC_RCR_LB1 | SONIC_RCR=
_BRD | SONIC_RCR_RNT);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> @@ -971,7 +972,6 @@ static void dp8393x_realize(DeviceState *dev, Error *=
*errp)
>       qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a)=
;
>  =20
>       s->watchdog =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, =
s);
> -    s->regs[SONIC_SR] =3D 0x0004; /* only revision recognized by Linux *=
/
>  =20
>       memory_region_init_ram(&s->prom, OBJECT(dev),
>                              "dp8393x-prom", SONIC_PROM_SIZE, &local_err)=
;
>=20


