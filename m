Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907BCC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5F32073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzbdR5sB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5F32073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lqW-0004gq-2T
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1loo-0003RQ-Ci
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1lom-00020c-TS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:48:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1lom-00020Q-Pn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581490096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huYDHhyeDQkau/0GrQyIPkvWCuh3+ZoNaVxRoDa5Hbg=;
 b=ZzbdR5sBg3W+YuTtI69NclxTtC5yeaC+nPzl9e6+yX6Or8JouZ/syUztFnXs3IigvZQ56U
 MrN9ZwL+bU94LKiYVJWGiDEyOK8P5SIsayRtqMU2bVh69rULtGv+eRXsnrql8RMyGFTOEH
 tVb2wVGm3NXQwXFrnWlJh+6knMnFLcA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-fq4NnM6DP6ma3zJGh1d9cw-1; Wed, 12 Feb 2020 01:48:14 -0500
Received: by mail-wm1-f69.google.com with SMTP id o24so340661wmh.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 22:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TPrEEVkHmInFwFG1pvqFvaaK50sAKXWUESfUO3Qg1+8=;
 b=sV0pTDbGJyuBfExKO4TD8/hi1/UbQ0txu7P/hYfANGeWkv9IgUEiujWmlc6VVEfm66
 ktOioJK3N59SJ5j333m1ytG38CmC/HY1V1Yyq0gqg5w62THxsArzFlYGwr0vPaDnretp
 tt4Q1Krhe70YLlH7e43iRPklp84YMF42QoT9KlzRbbQAo0GYofd/p4xJIC3ab8MSywBN
 KWJ9WOhBI2wU6yxcs+ZkXcHTNKK1FRmeD75BwZDzk+b5YrYc6g04W81NduWiMp/S0DoT
 qoyauo813hd2hj4rLkMJDryKs5M/8G5qWFff0wzfWLwh1nDae8JHOpXJnvRBZ5Y6G8vJ
 t0Tg==
X-Gm-Message-State: APjAAAUeWEr+h7hJdQ561Tw12qnJqV/Yi1oYuJy+/vG4OMMUTopfSTTP
 al2xij65+XMlCseuVjKaUAgnRNveKFJwUADF42z5fMgHTuzzK+aJrNFvzAM3UrB05HomGHH3pcM
 zhzT7nno3jWLsj40=
X-Received: by 2002:a1c:5441:: with SMTP id p1mr11317033wmi.161.1581490093314; 
 Tue, 11 Feb 2020 22:48:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqznglmT/lUAy2G7ou8w5m6dbP/n83nr50Gk83NO88V9qJCsc5AnUwyIt685GekVZUghclGc0g==
X-Received: by 2002:a1c:5441:: with SMTP id p1mr11317002wmi.161.1581490093011; 
 Tue, 11 Feb 2020 22:48:13 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d22sm6904813wmd.39.2020.02.11.22.48.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 22:48:12 -0800 (PST)
Subject: Re: [PATCH 06/13] target/arm: Use FIELD macros for clearing ID_DFR0
 PERFMON field
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e35821e6-f92b-ee14-6738-c2a29a006b29@redhat.com>
Date: Wed, 12 Feb 2020 07:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-7-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: fq4NnM6DP6ma3zJGh1d9cw-1
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 6:37 PM, Peter Maydell wrote:
> We already define FIELD macros for ID_DFR0, so use them in the
> one place where we're doing direct bit value manipulation.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We have lots of this non-FIELD style in the code, of course;
> I change this one purely because it otherwise looks a bit odd
> sat next to the ID_AA64DFR0 line that was changed in the previous
> patch...
> ---
>   target/arm/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index dc582da8fa4..e7858b073b5 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1603,7 +1603,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>   #endif
>       } else {
>           cpu->id_aa64dfr0 =3D FIELD_DP32(cpu->id_aa64dfr0, ID_AA64DFR0, =
PMUVER, 0);

While this one should be FIELD_DP64(),

> -        cpu->id_dfr0 &=3D ~(0xf << 24);
> +        cpu->id_dfr0 =3D FIELD_DP32(cpu->id_dfr0, ID_DFR0, PERFMON, 0);

this one is correct.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           cpu->pmceid0 =3D 0;
>           cpu->pmceid1 =3D 0;
>       }
>=20


