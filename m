Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92595C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6051C206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3j/kjGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6051C206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcKn-0006rE-Bu
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcJb-00053O-E9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:43:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcJa-0006pk-Fu
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588603405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5fDtqOgBSAxxZ+m9oqLcVSlkVmX6DCIOa02As9nAHg=;
 b=X3j/kjGn4dl6cRVyP3xQybMy9J7Cw2bvPfVdvmsJffaiJkJS558pE9zhy3imxRfVjKukyL
 Egqm+xH8RVANUFz6yIwFtnUAYqhH/CCaUpORqj8IP3zzIxGlh6URZR0EdF8f1W3UWIzWdH
 wrxrXEWzJCOx0ReqrMd/U8FYmGoqU/8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-y6mi26zFMZWnq3OTzD99MA-1; Mon, 04 May 2020 10:43:22 -0400
X-MC-Unique: y6mi26zFMZWnq3OTzD99MA-1
Received: by mail-wm1-f72.google.com with SMTP id h6so5008778wmi.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vJpX+3iu6ILlEy7TX7dBMt2ttN3DsTsKcrZ+HLBxuaw=;
 b=qNUCjMeC9Yaa7DmhFsdeBvaNrMnb4osQzpw3vyWSWEmvxyqa0Fx52jd4yO5HqPgOdc
 oJgmJr01FISA3hjtIVlluINhGCTurt5Lxe0ap9rnqU3P4DLN1GwdpCkD63lJ70Z+44c0
 q5ZaDlF8OsaajqWKnVrdB2MTn+Af4ixKlNwV9XipznzZdebBBaej8HEdC3w5Kh6DdysN
 Y+7DcXE1GGEBdxbnSE7dCWjR6WnrPVejXDEPbuhSA9aeAQ9O1gtPJ95J+6zC2QkxduiE
 ZV963tpkPTxTiBUm6EUPVrOIYR+ekBypQWUtmMJWy1wOS81QpgE/px8PPnQkekkEXpGT
 2q8w==
X-Gm-Message-State: AGi0PubKAN34pCpqFbviFid9pbSIfn8YmSGgMbu/Fcadi/RpR3yRTqYS
 3+l6e8v+nm0O4k7XhIddADPZWs4kgAJTxP8V5AkItfRFX+YjyCb3YVOUutNEbtaAcUT/jzOmUDT
 XntXiTxX065yH4Is=
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr15059261wmi.103.1588603401227; 
 Mon, 04 May 2020 07:43:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypKo8nIYCWCvo1zIGp2iWSrVR+pEPfupdVnmxjjwQJtcR1uspZE6u5yoemf5ztnZqwz0HioFWQ==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr15059243wmi.103.1588603401032; 
 Mon, 04 May 2020 07:43:21 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id e2sm19052671wrv.89.2020.05.04.07.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 07:43:20 -0700 (PDT)
Subject: Re: [PATCH v2] tests/qht-bench: Fix Clang 'int-conversion' warning
To: qemu-devel@nongnu.org
References: <20200504144125.22435-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <12d041f1-6141-c828-1b72-7066a22b9639@redhat.com>
Date: Mon, 4 May 2020 16:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504144125.22435-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Wrong subject =3D) v3 coming...

On 5/4/20 4:41 PM, Philippe Mathieu-Daud=C3=A9 wrote:
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
>    double nextafter( double from, double to );
>=20
>        Returns the next representable value of 'from'
>        in the direction of 'to'.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Since v1: nextafterf() -> nextafter()
>=20
> Cc: Emilio G. Cota <cota@braap.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Alexander Bulekov <alxndr@bu.edu>
> ---
>   tests/qht-bench.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index e3b512f26f..54ce1e8188 100644
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
> +        *threshold =3D rate * nextafter(0x1p64, 0.0);
>       }
>   }
>  =20
>=20


