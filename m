Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C3C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 20:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E322082E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 20:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Is4yI/Oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E322082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibVR5-0001dc-3N
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 15:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ibVQR-00013P-5g
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ibVQO-0002id-EF
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:02:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ibVQN-0002iZ-Qo
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575230550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7+8YUdPGIDlQ/JixXwhlEFAwy4aR+GMyio0LsFgo2w=;
 b=Is4yI/OyAlWAx5IAn/x5GLYzzdK1YsJqRFsYuEJfQQJ0vH8g3hUFXeIYXp161QAA4AiVXr
 2ICPgPe4Hq7c2pLC/F3Ei8zptLxAM8Vw5MFzIgw8txk75GTnQmoRwFiMrtb+QTGR6ntu00
 FnidmiLGAfX+wfek9EYtTjTdUtBNTPc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-EJRiA1bkN7-av97aWLW9RA-1; Sun, 01 Dec 2019 15:02:27 -0500
Received: by mail-wr1-f70.google.com with SMTP id z14so1833664wrs.4
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 12:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R9vWN/ktr+mXjVfcYhElNo4UN8+FmnRrkrdjaVnVqBw=;
 b=lMasNmvCgHAmx6Pk7b4U9hrGA7y7awL/ZK1FGRADXjf+HgxqZgdKREj4OXMHGLrMb1
 vJWBAOBFpmPSBYcrv2/Am1g0yugvqXYxSlarUfd9uKJQccTRrvtZL3wl51rffSwWu4lQ
 32w/AGs4yBiOV6+tIhSqLZqBZ0Fd8SfmIOlRNUeWDA3IT1dItnmOKONMeCGcBH5cR3j4
 X/7G2flz7jFrNw+RZVbaBJ96S8EfVTgYpxwVl3V7jY2Nvcv0uYC937Z2aYMLdzbRSmSv
 6Ovp9hx/M947nJiYgsJjXDphBXMktkLLeTgb5XI7rt30hcNNTRjWFXlz1p3B2FMTISVd
 w7MQ==
X-Gm-Message-State: APjAAAXx94uEfX5Ir1jY3lo2hbpNlMmVQaNQTzJX0dlPhU/pDQTTK/6X
 lySvWYo9huHSWAB0HRLcg/6oVFLpU5q/evwuJL7P7LrezCB8bEqm1kaB+YGbaZ4OQRSWx+HoJZF
 USfACaaUH0tJDXM4=
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr24831867wme.89.1575230546504; 
 Sun, 01 Dec 2019 12:02:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/ykHBtgvaWGHBQrX7tupPFlR1kJfXjy0gX/P1r2T4NJP5dY8XZSimxhao3yvh2uIWwDPTPg==
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr24831854wme.89.1575230546332; 
 Sun, 01 Dec 2019 12:02:26 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id i10sm23255313wru.16.2019.12.01.12.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 12:02:25 -0800 (PST)
Subject: Re: [PATCH v2 05/14] gdbstub: add helper for 128 bit registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ceecdac9-db1b-41f0-54ba-4aaa2953f85a@redhat.com>
Date: Sun, 1 Dec 2019 21:02:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-6-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: EJRiA1bkN7-av97aWLW9RA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: damien.hedde@greensocs.com, richard.henderson@linaro.org,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 9:45 AM, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>    - take care of endianess of the whole 128 bit word
> ---
>   include/exec/gdbstub.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>=20
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 08363969c14..59e366ba3af 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -102,6 +102,19 @@ static inline int gdb_get_reg64(uint8_t *mem_buf, ui=
nt64_t val)
>       return 8;
>   }
>  =20
> +static inline int gdb_get_reg128(uint8_t *mem_buf, uint64_t val_hi,
> +                                 uint64_t val_lo)
> +{
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stq_p(mem_buf, val_hi);
> +    stq_p(mem_buf + 8, val_lo);
> +#else
> +    stq_p(mem_buf, val_lo);
> +    stq_p(mem_buf + 8, val_hi);
> +#endif
> +    return 16;
> +}
> +
>   #if TARGET_LONG_BITS =3D=3D 64
>   #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
>   #define ldtul_p(addr) ldq_p(addr)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


