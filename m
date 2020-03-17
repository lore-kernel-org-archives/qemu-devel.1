Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29020C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62BC20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkEIutR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62BC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8rM-0004pP-58
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE8qO-0004JS-9K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE8qM-00068m-Dm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:49:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE8qL-00064k-Rx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlgwK29XXoJ79V2xw4GiTbSH4TCd0TAC3A21hE+Ta8I=;
 b=IkEIutR5m6jD+U5iwtkOE+2I9awLjfnizwb503eNGB4GVAMTUFXDZkjFC86HHtFzh713n1
 9Ebk3HP/O5Zf7Fyn0564GzM9H4g2lOwAPmq490YNZufiPdpFjAQ5ZmrB+RnKThNnTMMy4R
 H5JYSi+CoykR47zIsGhrwcWjm4qz/2E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-1LuWZ6QJMrGNxX2FYirt_g-1; Tue, 17 Mar 2020 05:48:59 -0400
X-MC-Unique: 1LuWZ6QJMrGNxX2FYirt_g-1
Received: by mail-wm1-f71.google.com with SMTP id y7so6917993wmd.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5oEq67vHO1jUy45Gr+tbnqd9Mz1dLzUQLrRT/T1z1d8=;
 b=WyDte1rdSMOz9LfxtLkZb3UKUmlNKX3idruQ15r1nLZf79rKdofdGbbpOXJ7xBVay5
 7aEa5Whp8IEYtcos9eecOiLXUkblxDnS9IRZA4rDeGn4SYjf5WAxuNPAixreJeoocFCG
 ofcrXavjaDsRVTy5g79gelyTad458+r9jFuDmaJECzj/KWCAaHF3rye3IPgzSGImMvXA
 pmI0MdVU8IZBeZKigHvhsMSZbd/zbf0cbYLwFt/p035UO4t9f19gmZfd6GfptbiakcTF
 Bw2sPTVIwyXVRQO5SxK2dGumYn975f5YImnfejMURmL5V9+xCbuHhIkF5f9rRAPmxzjX
 76wA==
X-Gm-Message-State: ANhLgQ1lJfRuUGdBkMXjdnkDEGGbGaAafNt8SonSCkZYmZRCBf/t3wab
 N6IhINYGA9s2SAzmn2jEa0kwX0s8MtWQ4Sk2c7TWGTuXac5jzcmCvhGn6MURYWUZ+oAaZEuNL1H
 vPm0cmopZCx99sp8=
X-Received: by 2002:a7b:c115:: with SMTP id w21mr4398705wmi.158.1584438538441; 
 Tue, 17 Mar 2020 02:48:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuvNtjk+RsFCGbMYRgvCrHISrlw7SJ6xpQDR5r/2rbhEmW3lGbQFxshDAQszuaSwP/W9B8WFQ==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr4398684wmi.158.1584438538249; 
 Tue, 17 Mar 2020 02:48:58 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id f187sm3372663wme.31.2020.03.17.02.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 02:48:57 -0700 (PDT)
Subject: Re: [PATCH v1 12/28] target/m68k: use gdb_get_reg helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3003316c-d52c-b720-8176-3e74e9836ff2@redhat.com>
Date: Tue, 17 Mar 2020 10:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316172155.971-13-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
> This is cleaner than poking memory directly and will make later
> clean-ups easier.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>=20
> ---
> v3
>    - fix mem_buf references
>    - fix mem_buf + len cases
> ---
>   target/m68k/helper.c | 29 +++++++++++------------------
>   1 file changed, 11 insertions(+), 18 deletions(-)
>=20
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index baf7729af00..c23b70f854d 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -72,19 +72,15 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint=
8_t *mem_buf, int n)
>   {
>       if (n < 8) {
>           float_status s;
> -        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
> -        return 8;
> +        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].=
d, &s));
>       }
>       switch (n) {
>       case 8: /* fpcontrol */
> -        stl_be_p(mem_buf, env->fpcr);
> -        return 4;
> +        return gdb_get_reg32(mem_buf, env->fpcr);
>       case 9: /* fpstatus */
> -        stl_be_p(mem_buf, env->fpsr);
> -        return 4;
> +        return gdb_get_reg32(mem_buf, env->fpsr);
>       case 10: /* fpiar, not implemented */
> -        memset(mem_buf, 0, 4);
> -        return 4;
> +        return gdb_get_reg32(mem_buf, 0);
>       }
>       return 0;
>   }
> @@ -112,21 +108,18 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, ui=
nt8_t *mem_buf, int n)
>   static int m68k_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, in=
t n)
>   {
>       if (n < 8) {
> -        stw_be_p(mem_buf, env->fregs[n].l.upper);
> -        memset(mem_buf + 2, 0, 2);
> -        stq_be_p(mem_buf + 4, env->fregs[n].l.lower);
> -        return 12;
> +        int len =3D gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
> +        len +=3D gdb_get_reg16(mem_buf + len, 0);
> +        len +=3D gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        return len;
>       }
>       switch (n) {
>       case 8: /* fpcontrol */
> -        stl_be_p(mem_buf, env->fpcr);
> -        return 4;
> +        return gdb_get_reg32(mem_buf, env->fpcr);
>       case 9: /* fpstatus */
> -        stl_be_p(mem_buf, env->fpsr);
> -        return 4;
> +        return gdb_get_reg32(mem_buf, env->fpsr);
>       case 10: /* fpiar, not implemented */
> -        memset(mem_buf, 0, 4);
> -        return 4;
> +        return gdb_get_reg32(mem_buf, 0);
>       }
>       return 0;
>   }
>=20


