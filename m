Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E29C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4129E206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuJRZlwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4129E206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcTb-00063K-7E
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcFP-0006GL-HT
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:39:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcFO-0003Lp-GU
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588603145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BH9wuXRD9/YVdHDb50afXa3I6EKLocibnO9GX03AXns=;
 b=IuJRZlwqX+aGyy8kwlLDhr7DA3oSNTgG+JjqHkSCv/gtCoQuXHvdF8AW8ioaDxIrOZClW8
 QojTRgQ5leBZVpoTuaRF1hZwtKsj35eLnBFvRkDKKBFbZywtFxe1Itm5Bp6oOcHTnlYe9+
 cbOdic5g2FRizcejHvGpEDJ5g/mFEa8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-N5kUOg2INtO1VqMD6YvPhw-1; Mon, 04 May 2020 10:39:03 -0400
X-MC-Unique: N5kUOg2INtO1VqMD6YvPhw-1
Received: by mail-wm1-f72.google.com with SMTP id h6so5000242wmi.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+7azJu6Ikq7YS8ItSyZZASskOx2GXwB1jsgmxaCHmok=;
 b=aOWppshKt4stve8LYDyltEvLNZKmO8agTYb8uuYlcn4rZXW/2CPuzPWimvqPsyAZvH
 LE4tyXdjtB7CX3+Hdn8o88xRFdsHfYWXMxgM5ypr2ZLT5uAVEDnsSbDeX1AyepoogCei
 tu2LyRiJW2muSyEHW0oa2EA2u/d1a7XHARNQ9K+wnt11RrlB0qPTdyk+aP24/OTMnN75
 ADTZGpn9gnIfn7LfiqZybmhAWr6fxJaA09eyYegoMBF55cWxkv4+6JgS+sDfv9SE9HAN
 FDCssBZxNiXz/eyk40qTb7rkKVSpvHRwRuOmnu7pXKHPDopQ10JdYViLVYAB5tczggkI
 wpCw==
X-Gm-Message-State: AGi0PubJn8XoggyfsBzGYgmlN/ePeiRTArX0UhmpWq56hv3iGulwrags
 QEA84z9yLDkyLDhgCWVT2dgS3vQTvnRga2aZXkW/vlkN5a12KvoT3d4fWF+6XSLYor0Lbat2hPL
 WFAXBxOOxiapYLwQ=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr7978141wrp.427.1588603142596; 
 Mon, 04 May 2020 07:39:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypLj+2dR7XeK2DIR0C5kr2krU+h5MRhoxpPyMq2cZ6xLk138g+WofC/splQw0k/V55c/Ykt8aw==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr7978118wrp.427.1588603142377; 
 Mon, 04 May 2020 07:39:02 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id v131sm14885230wmb.19.2020.05.04.07.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 07:39:01 -0700 (PDT)
Subject: Re: [PATCH] tests/qht-bench: Fix Clang 'int-conversion' warning
To: qemu-devel@nongnu.org
References: <20200504142630.12842-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <202238cc-034f-d232-12b0-5017a24f96c8@redhat.com>
Date: Mon, 4 May 2020 16:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504142630.12842-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 4:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> When building with Clang 10 on Fedora 32, we get:
>=20
>    tests/qht-bench.c:287:29: error: implicit conversion from 'unsigned lo=
ng' to 'double' changes value from 18446744073709551615 to 1844674407370955=
1616 [-Werror,-Wimplicit-int-float-conversion]
>            *threshold =3D rate * UINT64_MAX;
>                              ~ ^~~~~~~~~~
>    /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
>    # define UINT64_MAX             (__UINT64_C(18446744073709551615))
>                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    /usr/include/stdint.h:107:25: note: expanded from macro '__UINT64_C'
>    #  define __UINT64_C(c) c ## UL
>                            ^~~~~~~
>    <scratch space>:14:1: note: expanded from here
>    18446744073709551615UL
>    ^~~~~~~~~~~~~~~~~~~~~~
>=20
> Fix by using nextafter() from <math.h>:
>=20
>    float nextafterf( float from, float to );
>=20
>        Returns the next representable value of 'from'
>        in the direction of 'to'.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Emilio G. Cota <cota@braap.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Alexander Bulekov <alxndr@bu.edu>
> ---
>   tests/qht-bench.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index e3b512f26f..f93f8e0fe2 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -10,6 +10,7 @@
>   #include "qemu/qht.h"
>   #include "qemu/rcu.h"
>   #include "qemu/xxhash.h"
> +#include <math.h>
>  =20
>   struct thread_stats {
>       size_t rd;
> @@ -284,7 +285,7 @@ static void do_threshold(double rate, uint64_t *thres=
hold)
>       if (rate =3D=3D 1.0) {
>           *threshold =3D UINT64_MAX;
>       } else {
> -        *threshold =3D rate * UINT64_MAX;
> +        *threshold =3D rate * nextafterf(0x1p64, 0.0);

NAck since of double type. Will send v2.

>       }
>   }
>  =20
>=20


