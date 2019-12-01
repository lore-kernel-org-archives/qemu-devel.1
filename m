Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48152C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 20:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0137120833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 20:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OH5uGN/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0137120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibVUV-0003Jv-5Q
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 15:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ibVTG-0002KX-Bg
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ibVTF-0003sX-Ar
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:05:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ibVTF-0003sL-5Y
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575230728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAwPekFTr0zSt8L8C9rqmPE84AtpGq/R59iL4ReHvec=;
 b=OH5uGN/lglx6s3uOoAslsauCwTmo2sn1s+V7iu5xWZaIqc7HQTyHEMOCwZBWwesHlUtgGR
 CcWAHyMYF+vxgdgqy4fcbUus62cYiJMXUaiPWTFvAbLjp4RMF+iZHzydCSFWVZodyPxVUy
 ew/qs2Q4gcg1p7yo83Kth/aWmOifJ2g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-Mtoz-tc4MTKxnZCdnZVDCg-1; Sun, 01 Dec 2019 15:05:25 -0500
Received: by mail-wm1-f70.google.com with SMTP id 199so5221971wmb.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 12:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=97MGpVaieoX303Tm+4vRdy/8QxsLoEaL3T7bA7CwLAI=;
 b=ujoohYPVVIsZHlLnXJT0Y8px3FB2tedhlS8JQ2bYeTS65l5Lq0379l9N+vG/Jv6jyn
 GMtt4utRmc3w5x780czDZ1QJiFXWz8FLrTix1u1W/PXhdrirIyjk0i2im5PHFNi5RiCY
 /ZkQhFdE0opaQIeLfYAfXz+OH73f39lEOkwjWEWeAjv4HNwEivUabANJ0cokSjzDKp/O
 0cDMM0B1bxL4CmNRZgGrARpueZ+ZfgawRQ09mCP0JTP0ViqUOEK3o6GUI4ERpFhvnY7+
 kggkCLoVBGCpGTo6gbnjzEh0BM91BeKHZRNvythTshRR2fzPSbXkije6qYXCHNOOSkdj
 LGNw==
X-Gm-Message-State: APjAAAV+Fm44VuLBM/1E/h4p/x3XY6V0etbAWJx4FusEjNurpMDMDpPW
 IGmmXYjwhXGYevQ5EC3GIjYs5GNufd5sHTje623qYIbMtLfGXkIULc9FroKRwOQapEDNv3x0CeG
 F4aKc+Ac9J+UHP4k=
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr17016402wrt.70.1575230724436; 
 Sun, 01 Dec 2019 12:05:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4jTyXyxeHgy0eg7V/dgHnDVwjfOAayTAZjtw4jDTRZt3In4A0/hAB8CO6XLvX/GuyUCVAHA==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr17016390wrt.70.1575230724270; 
 Sun, 01 Dec 2019 12:05:24 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id x17sm15198809wrt.74.2019.12.01.12.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 12:05:23 -0800 (PST)
Subject: Re: [PATCH v2 06/14] target/arm: use gdb_get_reg helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <987465d3-3b13-e675-9622-c13e2d5205c2@redhat.com>
Date: Sun, 1 Dec 2019 21:05:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-7-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: Mtoz-tc4MTKxnZCdnZVDCg-1
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 9:45 AM, Alex Benn=C3=A9e wrote:
> This is cleaner than poking memory directly and will make later
> clean-ups easier.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>    - make sure we pass hi/lo correctly as quads are stored in LE order
> ---
>   target/arm/helper.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0bf8f53d4b8..0ac950d6c71 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -105,21 +105,17 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *env=
, uint8_t *buf, int reg)
>   {
>       switch (reg) {
>       case 0 ... 31:
> -        /* 128 bit FP register */
> -        {
> -            uint64_t *q =3D aa64_vfp_qreg(env, reg);
> -            stq_le_p(buf, q[0]);
> -            stq_le_p(buf + 8, q[1]);
> -            return 16;
> -        }
> +    {
> +        /* 128 bit FP register - quads are in LE order */

Oh, this was always wrong on BE :(

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        uint64_t *q =3D aa64_vfp_qreg(env, reg);
> +        return gdb_get_reg128(buf, q[1], q[0]);
> +    }
>       case 32:
>           /* FPSR */
> -        stl_p(buf, vfp_get_fpsr(env));
> -        return 4;
> +        return gdb_get_reg32(buf, vfp_get_fpsr(env));
>       case 33:
>           /* FPCR */
> -        stl_p(buf, vfp_get_fpcr(env));
> -        return 4;
> +        return gdb_get_reg32(buf,vfp_get_fpcr(env));
>       default:
>           return 0;
>       }
>=20


