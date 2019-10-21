Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3E3CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144B92084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVrfi6qJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144B92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYJK-00015z-MC
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMYHe-00089G-2s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMYHa-0000ep-V0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:03:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMYHa-0000eW-RS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571666617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69UIP06orsliv4REben2TV1q94dSF8ja90adjKOyMMc=;
 b=MVrfi6qJuA2Ep/BNd8p80OMrxD51cN1y+hiOKUpDKSvYjvx+W6AwYtyscg0BTHQ7abQzf4
 K0g/eFgH1Y5IcSfJuftwy0x4ymgbRqk5jqAC4G0QOo8VreeGts8+/6QI/OgCtY9yNjHl4O
 KsJnyWOQ6sQN60RkmSDeeAyGVDWdRHw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-_eg5oIKjO2qxxOten33b_w-1; Mon, 21 Oct 2019 10:03:36 -0400
Received: by mail-wm1-f70.google.com with SMTP id 6so1487523wmj.9
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zq1BDlcyiO62mkXqo0YoukHybNecVfwAHEA2Um8n6Ds=;
 b=khZOkeRuN+fgA54UNPekG1LAU+MpeATf2Syy37IjXsNPoJbw+mPS85lcfd8rWLaNns
 tinYckBIItYWwPtqOelFlQdVtYO1xylpROruEHrBIU5RIP1Z6SZRRa9ixFIOfBvKW+VE
 39sY0ZLFYG1K2PNGv6kVp5k5Eii4omcophY1kP13rUuiSj9fyVVQqf/dpMGbgRYNix0X
 7P5+/r0oJLOYwzGwrS0Dkgei77jQG/KInI/urpfJjrkkGmhY5VzvNl0QT46+yLADCfc5
 7188PVyYS44TDYTdVqf9GdI5pUM/d9IgyrHZxOVz7aKX4jH8ioUvJrmORDTJbpdv3yOC
 RZsA==
X-Gm-Message-State: APjAAAW/HHWVJdTibHfAH4MDgEBIPw7nrQRqMPv3ghehRJ6/u0zIwPcT
 Kr+cQLN2zIMoL5iiZV8FwZ0ZZcOZVx0MtDPQe9h5EtGaHjayfo7xptICTJWCTk+ZuN7sqZEzINd
 f+Mcziu7yc8K4WY0=
X-Received: by 2002:a1c:f305:: with SMTP id q5mr19345360wmq.137.1571666615044; 
 Mon, 21 Oct 2019 07:03:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVEu9fc41RI1WeV3rdhJLjFVxMhrkI/Tq/iILAj1FvzPbHT6DQu2FE03jrkfEPzxRcmWFzAg==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr19345336wmq.137.1571666614837; 
 Mon, 21 Oct 2019 07:03:34 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id z6sm14528779wro.16.2019.10.21.07.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 07:03:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] hw/timer/slavio_timer: Remove useless check for
 NULL t->timer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191021134357.14266-1-peter.maydell@linaro.org>
 <20191021134357.14266-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <17865d60-9d78-e876-90c3-f8f7363f689c@redhat.com>
Date: Mon, 21 Oct 2019 16:03:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021134357.14266-2-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: _eg5oIKjO2qxxOten33b_w-1
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 3:43 PM, Peter Maydell wrote:
> In the slavio timer devcie, the ptimer TimerContext::timer is

typo "device"

> always created by slavio_timer_init(), so there's no need to
> check it for NULL; remove the single unneeded NULL check.
>=20
> This will be useful to avoid compiler/Coverity errors when
> a subsequent change adds a use of t->timer before the location
> we currently do the NULL check.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/timer/slavio_timer.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index 692d213897d..890dd53f8d8 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -227,13 +227,11 @@ static void slavio_timer_mem_writel(void *opaque, h=
waddr addr,
>               // set limit, reset counter
>               qemu_irq_lower(t->irq);
>               t->limit =3D val & TIMER_MAX_COUNT32;
> -            if (t->timer) {
> -                if (t->limit =3D=3D 0) { /* free-run */
> -                    ptimer_set_limit(t->timer,
> -                                     LIMIT_TO_PERIODS(TIMER_MAX_COUNT32)=
, 1);
> -                } else {
> -                    ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit=
), 1);
> -                }
> +            if (t->limit =3D=3D 0) { /* free-run */
> +                ptimer_set_limit(t->timer,
> +                                 LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1)=
;
> +            } else {
> +                ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 1=
);
>               }
>           }
>           break;
>=20


