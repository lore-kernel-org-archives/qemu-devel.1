Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF15EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FFC21906
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQ4Yh1s1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FFC21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWa3-0006HR-Pz
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAWYW-0005IZ-U1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAWYV-0002yi-La
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:47:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAWYV-0002xs-DP
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:47:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id p7so1790345wmp.4
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e9onsw2cul4/bEEkSLISh0i/rF2oXFYBq99vhe7ORXA=;
 b=tQ4Yh1s1Y51MOnA6NJmntRUI6R6a5pJMi1YB6mm6fuJgwamHWIXCGua4oIDfnSeH3i
 wa18i30xbj6VpuvX99AFvVusSjQfgA3EJbqlZ5PnimUzGzt92Y3JrIoAcCJSIFRHK+tm
 WEUq417FXA6l213dBlQiDG+9PWPa0Uy2wuUzVHtlFMNS6/YR8CxetsCSOraaswyGfJlc
 s+80Oxcbw1KHtexpHSXXReZIJZebIQqx1OppXgIB2HcloNWDbDvRQAmJpoKmjkv63qy0
 hEp+/rOP646h1f+97NGIyBNimA8y3TKGoZr+EZFgkTtqfu2JJBtlQxdmxDUuis8Hz2HH
 vVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e9onsw2cul4/bEEkSLISh0i/rF2oXFYBq99vhe7ORXA=;
 b=sabv3/n243vCmP2CS0+183k5Y3XCSXToQaaj0WWjyyM7KkKcB2Oaa5B13wk0zG+jsf
 oJ4ugeBwCAYcY96e73ZNWbmL+b2ViU25cYpKV/htrIPuDT70gS6Rbm7E5o5beuDC1F5E
 T2DW7bwTX/tr0p/Msy+/Ob9uq14feASoT1diybgRrrpzUpc8dDyR9tZr6zSRgXAqq9a5
 ftipB/jW7rZz8el1vtZVyTVhJH5I/j3LCz76seLwp/FJVZ7dKCp6C71B96SbZrAaRg/N
 kkaZK9Vq4azqmPYp2jJSIOqZEda1QHQ0pOaUwBG4zq334eN0yPf6CN+VuK0c7xIDQ/di
 chug==
X-Gm-Message-State: APjAAAXgnw6QWLKwwx0jxQZNfF1v5GZQKt6N2cuV0uW/XAZrWSx7oZrw
 J0Z6ASLv5IAW1zOOTkacexI6sQ==
X-Google-Smtp-Source: APXvYqzGrAf55RgelSv6Ur4RmrS3HJea7fPylfIoDWo1ujSXC4y1BxxVASyFMQ4nUAfCO4nIrffxvw==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr2060949wmj.57.1568800041488; 
 Wed, 18 Sep 2019 02:47:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h26sm12249939wrc.13.2019.09.18.02.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 02:47:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D2A7E1FF87;
 Wed, 18 Sep 2019 10:47:19 +0100 (BST)
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-30-david@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190916135806.1269-30-david@redhat.com>
Date: Wed, 18 Sep 2019 10:47:19 +0100
Message-ID: <875zlq0wd4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 29/29] tests/tcg: target/s390x: Test MVO
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> Let's add the simple test based on the example from the PoP.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/tcg/s390x/Makefile.target |  1 +
>  tests/tcg/s390x/mvo.c           | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 tests/tcg/s390x/mvo.c
>
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.t=
arget
> index 151dc075aa..6a3bfa8b29 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -6,3 +6,4 @@ TESTS+=3Dipm
>  TESTS+=3Dexrl-trt
>  TESTS+=3Dexrl-trtr
>  TESTS+=3Dpack
> +TESTS+=3Dmvo
> diff --git a/tests/tcg/s390x/mvo.c b/tests/tcg/s390x/mvo.c
> new file mode 100644
> index 0000000000..5546fe2a97
> --- /dev/null
> +++ b/tests/tcg/s390x/mvo.c
> @@ -0,0 +1,25 @@
> +#include <stdint.h>
> +#include <stdio.h>
> +
> +int main(void)
> +{
> +    uint8_t dest[6] =3D {0xff, 0x77, 0x88, 0x99, 0x0c, 0xff};
> +    uint8_t src[5] =3D {0xee, 0x12, 0x34, 0x56, 0xee};
> +    uint8_t expected[6] =3D {0xff, 0x01, 0x23, 0x45, 0x6c, 0xff};
> +    int i;
> +
> +    asm volatile (
> +        "    mvo 0(4,%[dest]),0(3,%[src])\n"
> +        :
> +        : [dest] "d" (dest + 1),
> +          [src] "d" (src + 1)
> +        : "memory");
> +
> +    for (i =3D 0; i < sizeof(expected); i++) {
> +        if (dest[i] !=3D expected[i]) {
> +            fprintf(stderr, "bad data\n");
> +            return 1;
> +        }
> +    }
> +    return 0;
> +}

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

but...

can this test be expanded to check the page cross cases that caused you
so much trouble to track down?

--
Alex Benn=C3=A9e

